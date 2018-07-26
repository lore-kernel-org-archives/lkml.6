Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B614C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B7B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD4i4fAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B7B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbeGZUnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36829 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZUnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id k15-v6so2259013edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y33yUBapD8c1jQSRrXdPbugIKfUBo6HpNpUCPBdrCgU=;
        b=PD4i4fAuTqKoSC69xbLmP4CQgxl5tM+VBRtZjkFZyty7SjpRCcgT1qhChw0Az+6chH
         HbC5amfv3GEdHWkRX1HmTR0eg6mlt35rAmohko9T29SYow57wl7E1el1ywwza5W0eACc
         yoHc/8+Qbuiti1wI4HZH2vWYAUj6T3FvQg1z4V801hZK3ZK8pOmzXSHvh0Q9Lhg1B/aa
         HtxS9dl1stxebMcsS6PnaHQ3yUKlL1D5UEA/7eMH3a2127yQT/OPJqMcNvdojqD1fCCN
         4h1TfI7aO8Ihwi0Cvr7mV0SpL0xlJyoMzH4tUD2kZ3AcpElq/pipnghJ+RviZjABtAbI
         xq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y33yUBapD8c1jQSRrXdPbugIKfUBo6HpNpUCPBdrCgU=;
        b=a3s/nb/RSNY+2zVEDqpuGRupAs0hvShhVmncbHld5oToT9lZW6DpWnrmmAjtO9Vu/T
         +ZaHQTlwGM6M83WzO1cZLC3kmjJuPAGtX6H39XqMmQ2uxDjZ/FOdEQY0Sv/14oDe25tP
         qjBIAv0RMb6jS/Lghm4fG+7JXFa2cty+pBT59dsywMC69GaxWHnPC1lgsZG7HRl260Wv
         UoWZkmm3/sh7nkjoq/zVkKPXGgmS/W6OzplTNdQt5PW/vYY+KwSFq4QV5kbuMTUCSJi3
         R5OeKXg5leBxl7SJ0/lw538lAqtbgb8ajyRzz8ottSOBOwWE2gNkwe/Cr2LdNMlPwzeV
         78sA==
X-Gm-Message-State: AOUpUlEwS6WVTHSKJjQtgXhiFeb8ewKGWA++IqtM/s11uYP/yzPgY3oG
        2UlSibqp5PZ1rY30DbQffMZ9AgcC
X-Google-Smtp-Source: AAOMgpfU5bOWHjDNd7WwvFqMn83PMNOw3P3xJLLZY40v/nFL4LVlxgUQFnDwlbUUjcMitPdXAH2XOw==
X-Received: by 2002:aa7:c88f:: with SMTP id p15-v6mr4082283eds.242.1532633094832;
        Thu, 26 Jul 2018 12:24:54 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/16] staging:rtl8192u: Rename Para2 to para_2 - style
Date:   Thu, 26 Jul 2018 20:24:14 +0100
Message-Id: <20180726192426.31913-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename member variable Para2 to para_2. This change clears the checkpatch
issue with CamelCase naming. The change is purely a coding style change
and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 10 +++++-----
 drivers/staging/rtl8192u/r819xU_phy.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index c2a73ec90f70..904cc8c1a83b 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1246,7 +1246,7 @@ static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTab
 	pCmd = CmdTable + CmdTableIdx;
 	pCmd->cmd_id = CmdID;
 	pCmd->para_1 = Para1;
-	pCmd->Para2 = Para2;
+	pCmd->para_2 = Para2;
 	pCmd->msDelay = msDelay;
 
 	return true;
@@ -1381,15 +1381,15 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			break;
 		case CMD_ID_WRITE_PORT_ULONG:
 			write_nic_dword(dev, CurrentCmd->para_1,
-					CurrentCmd->Para2);
+					CurrentCmd->para_2);
 			break;
 		case CMD_ID_WRITE_PORT_USHORT:
 			write_nic_word(dev, CurrentCmd->para_1,
-				       (u16)CurrentCmd->Para2);
+				       (u16)CurrentCmd->para_2);
 			break;
 		case CMD_ID_WRITE_PORT_UCHAR:
 			write_nic_byte(dev, CurrentCmd->para_1,
-				       (u8)CurrentCmd->Para2);
+				       (u8)CurrentCmd->para_2);
 			break;
 		case CMD_ID_RF_WRITE_REG:
 			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
@@ -1397,7 +1397,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 						     (enum RF90_RADIO_PATH_E)eRFPath,
 						     CurrentCmd->para_1,
 						     bZebra1_ChannelNum,
-						     CurrentCmd->Para2);
+						     CurrentCmd->para_2);
 			}
 			break;
 		default:
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 77ae606c77ce..0d4c083ea718 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -21,7 +21,7 @@ enum switch_chan_cmd_id {
 struct sw_chnl_cmd {
 	enum switch_chan_cmd_id	cmd_id;
 	u32		        para_1;
-	u32		        Para2;
+	u32		        para_2;
 	u32		        msDelay;
 } __packed;
 
-- 
2.18.0

