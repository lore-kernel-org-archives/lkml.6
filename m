Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F720845
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etDX9TOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0F720845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeIADNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41455 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeIADNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so12526633wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nTscsTF8HNKPh3DssKR2D0yTvYstseoGoG2THjZDtFM=;
        b=etDX9TOk+PubhOR4sFkn/6VWndEAH8wGxNtlWkwnd7vlk89ffXsOVmKYNQfrhnqh01
         shVEU7pfSAyBTBSpKHnkBXz7aR4n+IBf6o1X1R8v2cx59VBwwyzhwse18SjtW6njk7SR
         AOiUR72jpIecmO/Mdwe0cQon0eTok8vVbbeoHL8y0OT48rpfB0h24sCNQ7vI47VFpm4l
         k3sGg4cMCNUEFDojkxEAlMjtSGjXOO+4hJLOW1cKCKaa9cN/PgoO2VmBN1l2xljyHDcT
         WzfKOBkg1bIphvoytdA71p+vaw962sU9NSHUzzbdNUv1NeChgO4+zKaIH0lKo/NHmFc5
         qU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nTscsTF8HNKPh3DssKR2D0yTvYstseoGoG2THjZDtFM=;
        b=YvqINptE6wbFP6IR2KbbbNvhA0AoJAMBauK0Qy5KgDR6tAxzV1ibb42LUHwhNsu3oK
         +rah9Rn7atmFw5sfgHug3U8cEUDN5T9PPAi9/2Yzh1i+3Tu3bBaEqsO84DlDx6wqF+Q5
         qtzndsjv4Um7aKQNH6rL5LD7HsCaA3OxCMTUNyZL89dJcNa/mAvRmQYH+LV2jNFJLtgb
         jA1ZF4/YpD47ee1ZtYLwZgPh8IRJP3cge7hB+iqwTRsu3y3SPAdNI5Yqq+R8JLgq97bW
         RmWZQFhQQ2WNv+pM7w3j/5us9WxMsx1vVp4bgwjOHhIQDpWxYRQqvqbKury2pwJfuWIw
         Hx9g==
X-Gm-Message-State: APzg51B+8xrFx4xeE0p2gdVUGtp4W2zcq0qGFXOF35NGN2j9RU6e0Xhy
        ao2qkkLPOPyOWPVB2pjPe4b/ZSNui6M=
X-Google-Smtp-Source: ANB0VdYeZFen++vX09fEpMV38/qwrPERFUsBMXTpUrwS6mA7bgQiv1jLUSnYO66UeHT7WbnWHDWpWg==
X-Received: by 2002:a5d:4152:: with SMTP id c18-v6mr1038590wrq.61.1535756605440;
        Fri, 31 Aug 2018 16:03:25 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:24 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 19/20] staging:rtl8192u: Rename LINIP - Style
Date:   Sat,  1 Sep 2018 00:02:49 +0100
Message-Id: <20180831230250.16810-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'LINIP' to 'linip', this change is to
conform to the coding style guidelines, member variables in
lowercase.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 66efa59eabf0..68e82b32a88e 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -164,7 +164,7 @@ struct tx_desc_819x_usb {
 	u8	cmd_init:1;
 	u8	last_seg:1;
 	u8	first_seg:1;
-	u8	LINIP:1;
+	u8	linip:1;
 	u8	OWN:1;
 
 	/* DWORD 1 */
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index a4d1b55a1117..911d0214b48a 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1514,7 +1514,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	/* Fill Tx descriptor */
 	memset(tx_desc, 0, sizeof(struct tx_desc_819x_usb));
 	/* DWORD 0 */
-	tx_desc->LINIP = 0;
+	tx_desc->linip = 0;
 	tx_desc->cmd_init = 1;
 	tx_desc->offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
 	tx_desc->pkt_size = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
-- 
2.18.0

