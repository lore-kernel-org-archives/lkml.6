Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299A1208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkHi7Bcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299A1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbeGMLiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41157 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbeGMLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so8125999edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yc3R1//BIw9bgsJaNQ6/IPZeHJp52Iw9VtHvZRVsWWw=;
        b=QkHi7BcnNKlO/5VzRgKcZQUaacKGCeW8XqGCtXDPZIoswC0kwJ7BwpcFICSeH9T9/R
         4CJ/LTcp/GejLY34tYdzdmJ6X1NbnoAumECYWM+liq6FGUQckHRalBGjTsJio+Fzmapo
         7B6Px1CluNJ+Xh4TODL+qY3B2pt4pm8wbLTeXxdHln/wk6IDAll5EwjXEgVRF6Q5PAH8
         Hw1OXzZYUWX8SpqkUqrDKH8SY+u2tA2M1YbpElHdfW40lUGhVogQbzn+31TExNjUOA4x
         xpT0XnTsqvKLTwJzSrAq35RWEONajItBu2LwEMBuRdCX5VeDy7xgYxijeG8cHiMZiDFN
         cU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yc3R1//BIw9bgsJaNQ6/IPZeHJp52Iw9VtHvZRVsWWw=;
        b=GRLeyNa7D92slzENUSOmA8mcX4ZCxj5i4z8tlyQBsgA//S4XabtiWSJWfSfZXeyQaG
         /GhwuRC1wvXi2hQl1KutXctof05yzc89gtgj7uyNH4GNUUdVXBFB1lnX0+NPiRy7As5o
         Pkj/BKHFZFA0vsfMFO02iP5OFVyMtb/TYxIeVpon2GOSsr1erhn3M9zoA93yyKpl55ov
         HWHsPXpeVpmgCdMNMsxy9wn/A/dgnFVKidc883xIaDGQHtxlzCBW5iN9OcAWf7WAHK+n
         jQ/XgfgjvqsCYLtp/K1F5ThJoszcmmVpdx/gY/NkF/AU9TpqzmVQn1u7l2y1I/GdO4pu
         wMsg==
X-Gm-Message-State: AOUpUlHMhpPQJng0dOemhnSX3CEVc3IAAbDS89SBbcFp56k592ZZIMvX
        Ngk6wsSr8wXwU6VLt4/qr2naetj0
X-Google-Smtp-Source: AAOMgpew2oE13c+LAIvNNWFsH7qjIaT5uS4zyR67lYvJIryqoPWYxXuBCQOAwt6P0zUip/gLSluiwA==
X-Received: by 2002:a50:b7a4:: with SMTP id h33-v6mr6745828ede.96.1531481041219;
        Fri, 13 Jul 2018 04:24:01 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:24:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/13] staging:rtl8192u: Rename CmdID_RF_WriteReg > CMD_ID_RF_WRITE_REG - Style
Date:   Fri, 13 Jul 2018 12:23:10 +0100
Message-Id: <20180713112311.544-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enum label CmdID_RF_WriteReg to CMD_ID_RF_WRITE_REG. This change clears
the checkpatch issue with CamelCase. The change is style only and should not
impact code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 6c57c38dc9fe..75fcd3134b6d 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1315,7 +1315,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		}
 		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
 					      MAX_RFDEPENDCMD_CNT,
-					      CmdID_RF_WriteReg,
+					      CMD_ID_RF_WRITE_REG,
 					      rZebra1_Channel,
 					      RF_CHANNEL_TABLE_ZEBRA[channel],
 					      10);
@@ -1334,7 +1334,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		}
 		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
 					      MAX_RFDEPENDCMD_CNT,
-					      CmdID_RF_WriteReg,
+					      CMD_ID_RF_WRITE_REG,
 					      rZebra1_Channel, channel, 10);
 		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
 					      MAX_RFDEPENDCMD_CNT,
@@ -1391,7 +1391,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			write_nic_byte(dev, CurrentCmd->Para1,
 				       (u8)CurrentCmd->Para2);
 			break;
-		case CmdID_RF_WriteReg:
+		case CMD_ID_RF_WRITE_REG:
 			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
 				rtl8192_phy_SetRFReg(dev,
 						     (enum RF90_RADIO_PATH_E)eRFPath,
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 1496f74768c9..75aa56ddd22f 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -13,7 +13,7 @@ enum switch_chan_cmd_id {
 	CMD_ID_WRITE_PORT_ULONG,
 	CMD_ID_WRITE_PORT_USHORT,
 	CMD_ID_WRITE_PORT_UCHAR,
-	CmdID_RF_WriteReg,
+	CMD_ID_RF_WRITE_REG,
 };
 
 /* -----------------------Define structure---------------------- */
-- 
2.18.0

