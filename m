Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CA1C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35A2170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3qnRmtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A35A2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeH0A77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46585 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH0A6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so2739283edr.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOh3N6W9KVNGTvHzPDsyPYDkLbUWuyKRi8QPivetWHk=;
        b=V3qnRmtB5k1cvjBGcMwn4HRQuW2SNsEDnWSIU0Y1xnybXJBTOyPp7MhIQkr4VGda2i
         Wi6zLZnBXAS5+BCkEgqQL4F2CwJk3n2ScoSVN5J8kPW5vBAHoQmF+GnKtJfdsDK/55zz
         uGEMv2ZnTCpLAZ1Zg1BqnWATU/84EVJwg+x4BZoh/WbLuDGYGwOpYu/Y/khUZl27VOEh
         7Vn+njXTolgDKWmnECJz/ibwToBQ4y0cPox5cumnmuitkoAe4L8IsqGJLkVBmgAC2dts
         +/8kNU8yhHi9fm6nL3tzSuOIIn0/0dAxzcLUhI7H/156YoPR9PXROXdZWPJ6ZcJcHg1s
         qXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOh3N6W9KVNGTvHzPDsyPYDkLbUWuyKRi8QPivetWHk=;
        b=oYItCZD76Y01VQsEjS4OAY+k8x2XqTtrF0FevBCxC9I07VbMeMmaINxixD5qsRxkIN
         b4Q84bz9c70+ynHa1haG+collJteaEF+1XFOLtbO/L+/bhL7/PPzPut8g8+gMDULC222
         ePLtdGclpjlNC8FZWusCRMvsgRekJq6iEBzxeS+pkpCiBZ4rcGdGSG4MTz7JrONssV6h
         WTnza1XWZmlddyHHFangH+B8vMoRkrfWvIPeo6eyT+ojc7ubsUY9OyJ7ZFHQbWlfYxWX
         E8IqwizFLlUWZ0vUR3NR3A6gCEOIy5Xf+AEn9KdXB0eASb3EUGpEiBuL398M6I+Kw6YZ
         jEZg==
X-Gm-Message-State: APzg51Cq1Ufbb36fnERPyzSDF500w9VYdz8y4JS4irJXGb5amRyR+G7k
        /3rZyUr6cDFrXNW1OFSQGt7vJSG5
X-Google-Smtp-Source: ANB0VdbKwTp/UuAD+RaLuAL0gcAw4a3rrEIkK/onFpbv73cFt2YgRHfhpOeUdMxcs2UZPNK16m0+qQ==
X-Received: by 2002:a50:95dd:: with SMTP id x29-v6mr13966189eda.3.1535318108078;
        Sun, 26 Aug 2018 14:15:08 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/21] staging:rtl8192u: Rename EEPROM_PwDiff - Style
Date:   Sun, 26 Aug 2018 22:14:27 +0100
Message-Id: <20180826211439.14326-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_PwDiff to EEPROM_PW_DIFF. This change clears
the checkpatch issue with CamelCase naming.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 5c9581bb4916..190d8e139b14 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2445,7 +2445,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		priv->TSSI_13dBm = priv->EEPROMThermalMeter * 100;
 		/* read antenna tx power offset of B/C/D to A from EEPROM */
 		if (bLoad_From_EEPOM) {
-			ret = eprom_read(dev, (EEPROM_PwDiff >> 1));
+			ret = eprom_read(dev, (EEPROM_PW_DIFF >> 1));
 			if (ret < 0)
 				return ret;
 			priv->EEPROMPwDiff = ((u16)ret & 0x0f00) >> 8;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 8a94a159e16c..c673e1e4083c 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -39,7 +39,7 @@
 
 #define EEPROM_TX_POWER_DIFF	0x1F
 #define EEPROM_THERMAL_METER	0x20
-#define EEPROM_PwDiff		0x21	//0x21
+#define EEPROM_PW_DIFF		0x21	//0x21
 #define EEPROM_CrystalCap	0x22	//0x22
 
 #define EEPROM_TxPwIndex_CCK	0x23	//0x23
-- 
2.18.0

