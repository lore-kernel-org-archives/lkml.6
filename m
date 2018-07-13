Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FBBECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2HCmhyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE6A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGMLiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34600 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGMLiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id d3-v6so24347572edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cT7mqmMbwL4yXOqBd2rlYl2bNrneJzxyxYVYMIXfc70=;
        b=F2HCmhyVBDlEgytsXyPBhJkdqvqUvoIGcZDR2JRfKv8zJZpmjvwkZcLMB/cpyxHcY2
         HtN4NXtUw4oowhloGcEJ94T8MZZCbZzvMUVsTsME7qfAGKt8TcA0IMmzcCWsMx8EwTm7
         Hrg9BLk+7VTAX2PFHnFtgCgorSBXueNbSgZXVI0jkCZ/c5OEONx8tC0lhKk3ejM2bmng
         Zh7ZjCajRBUABl4ebu2uSzVBr6ex8GKroOh5fzN6rmAo7OMsNg+oA1P4vfy+3I22ctCh
         yoCjW9C2vvi6iZUt6ycA3x79nZuqVyjSylPAhhYA+L7ySrL7Og7hjexrkHqQDt3Ouvgw
         5k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cT7mqmMbwL4yXOqBd2rlYl2bNrneJzxyxYVYMIXfc70=;
        b=LP6s3wX8Q2ou2D1Ib3zGsxbepPds5o5CrB33hWnIRiF5tEeuIzhWYGtnd/sqxe8euV
         EUBs4aycA14UAYBBtzwz6NtGcT3xw2ZaKPJevHOLmLQFIbzCp5nZahA+R4kHkbtMWQYQ
         G3CH0Kvb90K8zg/XH3Sk8gvtz/g0A1NJH16islISt5n1fBlQoN1PKsL9ot4Az7YLM01k
         LlMNE4Tozp0z1KTVrjNkZp7iHMawkHuTEyGYGm+6uDc/Ff4Etv8uke4JL/K1gVM1sOWo
         e6OS3xVLiz1jL5pL/LWiYb8WH1LZDbn71Sd2cmjuQHgbz0hjqVuWE78jRdOYdPRtIofp
         OLQg==
X-Gm-Message-State: AOUpUlEta0x72qBpQG39BvpBYYPclP0JUDFfWvR5iKmYExVQfRVt+JIZ
        bk5cNh4zPiaO/lgGWFU117vqCNZ3
X-Google-Smtp-Source: AAOMgpcTJu/84gOGLXetGKP3Ds6yOXjkLE/K3G/q316lMdr5XekzLD/y7isDZqEddnAeK4c9OlMc2w==
X-Received: by 2002:a50:81a4:: with SMTP id 33-v6mr6452709ede.200.1531481031072;
        Fri, 13 Jul 2018 04:23:51 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/13] staging:rtl8192u: Rename enum label CmdID_End > CMD_ID_END - Style
Date:   Fri, 13 Jul 2018 12:23:04 +0100
Message-Id: <20180713112311.544-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enum label to clear a CamelCase warning from checkpatch. This is a
simple style change and should not impact execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 10 +++++-----
 drivers/staging/rtl8192u/r819xU_phy.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index c373dbe06154..c67159f2d9ab 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1295,13 +1295,13 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				      MAX_PRECMD_CNT, CmdID_SetTxPowerLevel,
 				      0, 0, 0);
 	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
-				      MAX_PRECMD_CNT, CmdID_End, 0, 0, 0);
+				      MAX_PRECMD_CNT, CMD_ID_END, 0, 0, 0);
 
 	/* <2> Fill up post common command. */
 	PostCommonCmdCnt = 0;
 
 	rtl8192_phy_SetSwChnlCmdArray(PostCommonCmd, PostCommonCmdCnt++,
-				      MAX_POSTCMD_CNT, CmdID_End, 0, 0, 0);
+				      MAX_POSTCMD_CNT, CMD_ID_END, 0, 0, 0);
 
 	/* <3> Fill up RF dependent command. */
 	RfDependCmdCnt = 0;
@@ -1321,7 +1321,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 					      10);
 		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
 					      MAX_RFDEPENDCMD_CNT,
-					      CmdID_End, 0, 0, 0);
+					      CMD_ID_END, 0, 0, 0);
 		break;
 
 	case RF_8256:
@@ -1338,7 +1338,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 					      rZebra1_Channel, channel, 10);
 		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
 					      MAX_RFDEPENDCMD_CNT,
-					      CmdID_End, 0, 0, 0);
+					      CMD_ID_END, 0, 0, 0);
 		break;
 
 	case RF_8258:
@@ -1363,7 +1363,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			break;
 		}
 
-		if (CurrentCmd->CmdID == CmdID_End) {
+		if (CurrentCmd->CmdID == CMD_ID_END) {
 			if ((*stage) == 2) {
 				(*delay) = CurrentCmd->msDelay;
 				return true;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 0c63c646b625..efbca1f458f5 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -8,7 +8,7 @@
 #define MAX_POSTCMD_CNT 16
 
 enum switch_chan_cmd_id {
-	CmdID_End,
+	CMD_ID_END,
 	CmdID_SetTxPowerLevel,
 	CmdID_BBRegWrite10,
 	CmdID_WritePortUlong,
-- 
2.18.0

