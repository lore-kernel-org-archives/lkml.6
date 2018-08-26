Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC79C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C4208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq+gBVR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C4208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH0A6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41026 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0A6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so9097987edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrkicQ6EMC6BCHwMPwxLlpXTmMUSXQqBYa2plu3rktU=;
        b=iq+gBVR9zSety5xV3VCIlA8CAGB93g+nAIpSSvcY8Xl/CGK3PWTQJ2gM6ZXR6AGYKM
         EkTJW9WpC0ZB9P+NZ5pbanpPQA9nqGXZ6DVPLKk7EH9LXEbJiNwyp4/aX3xublEVYndY
         Qp6GHF0CSkK0XzVcGYL+8xD9khs5rjCZtWgTYNjWzIBD/4SUAbTt4H99hRJv4JizXoRI
         RYVAwufSphejMe5APwcUFeSclBqO3+VEbrrmFbB2Sju4MKno/OmzpPyAFpJviybTMb/c
         qWn69VWLglOK/hK52XETDA2ZbJKPnjhmahL0vWjw/bBdG6B2yQkwAnyGJAgev3HBUMTH
         gzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jrkicQ6EMC6BCHwMPwxLlpXTmMUSXQqBYa2plu3rktU=;
        b=ibRy6K5hDniYAsqmpbVmikFG7Y5ODghn4foXJwR+YXbOIZgySgqHqpXit4IiRjvO16
         Y/vNIcKcmEw5ZQYbHl01sWz5rB54yCmgAPFstOmUDzlVva1UNLGk9tJqxXNN2LiFmek/
         Is8Y06QPjQUGRdv2QcIrEVfhCBKFg84sd+GOl4l49JODj/fWb78hoO5JY2nO7MDTqYdJ
         ZyHRBcN2t7NRHiNG4OdgznzxwqPif0roDMHWAl0I6pAmIiNDz5CV+WsFLBpccG3kZnjB
         zQG+JDKklFsROQBNE9k0Rt7+BpC8FLaXtyVZIGCz4e76RATuIUX3hIfQ5zmPDGXaCxSO
         PATw==
X-Gm-Message-State: APzg51ALBbrRFmE3BITtXrAgvgtjgHZseYGJkdUMDb0is8S1TC+tWIQp
        Ahl2rIiHf7rotoNbsrHSShji7/oT
X-Google-Smtp-Source: ANB0VdZff2iuPH+FSJ/5dIiBhU1+L+WK33MSCg8R2J9nkPwl4HkCznqgqo3Je+B4tmj3w+rqvnMGGw==
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr13425760edo.47.1535318109425;
        Sun, 26 Aug 2018 14:15:09 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/21] staging:rtl8192u: Rename EEPROM_CrystalCap - Style
Date:   Sun, 26 Aug 2018 22:14:28 +0100
Message-Id: <20180826211439.14326-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_CrystalCap to EEPROM_CRYSTAL_CAP. This
clears the checkpatch issue with CamelCase naming.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 190d8e139b14..1c9b9da5e65b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2454,7 +2454,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		RT_TRACE(COMP_EPROM, "TxPwDiff:%d\n", priv->EEPROMPwDiff);
 		/* Read CrystalCap from EEPROM */
 		if (bLoad_From_EEPOM) {
-			ret = eprom_read(dev, (EEPROM_CrystalCap >> 1));
+			ret = eprom_read(dev, (EEPROM_CRYSTAL_CAP >> 1));
 			if (ret < 0)
 				return ret;
 			priv->EEPROMCrystalCap = (u16)ret & 0x0f;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index c673e1e4083c..78e4d15e2579 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -40,7 +40,7 @@
 #define EEPROM_TX_POWER_DIFF	0x1F
 #define EEPROM_THERMAL_METER	0x20
 #define EEPROM_PW_DIFF		0x21	//0x21
-#define EEPROM_CrystalCap	0x22	//0x22
+#define EEPROM_CRYSTAL_CAP	0x22	//0x22
 
 #define EEPROM_TxPwIndex_CCK	0x23	//0x23
 #define EEPROM_TxPwIndex_OFDM_24G	0x24	//0x24~0x26
-- 
2.18.0

