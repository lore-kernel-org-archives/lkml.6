Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DEECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0DF20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZdzNcLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0DF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeGZUnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36822 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id k15-v6so2258889edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UDM0SBldDbLi81dQOai7hB4uBlisDtpNujfAWk+yNkY=;
        b=LZdzNcLj1rYFDZj8Sn7rLbP8p9pZJyXNKnPcijssxqJ8DQ0BQMczkNiDB65l/N+KIa
         mC0X5KqH0q0NU8K0eH1FqZ67W1BX2ffkBggXxG80UUp8smSvnrYqgxVltn6XHG6VFca0
         bVGs4fHBRW5DkFq/C+3Z5e5wykefx3E5KNB71An8mOSw9dDIzpFKP5a6oDbGcZHqHMdp
         u3sXVchPMcUJJa8dwxsK0xJLWpJq5015VhQ5fhpqXXnyxxMdIKyrJhwWhTFYJH6XXpB/
         6+XVyuBHQjYqjxGyPZmEkRntqjdMqx+HvHiwZ/Snk2C9lTQNSg+hexnJ9p3jvpQQXL4I
         6ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UDM0SBldDbLi81dQOai7hB4uBlisDtpNujfAWk+yNkY=;
        b=Jv67Je6lw1GfNQf4qbYylSRFi+/w+f4nNIwbhT81gOWH2aiOvoFX7fEV0sl3t2RD3G
         nkFSeEZxGxPHYzK98wmc8FvRiigA5PVAlO42AKM6hkyvCkSPKRP3Osefo5Zf+6/vrDUO
         qYNIJUgDN4svduGUCDrB+wYZh1r3fKuJQVoxA5Z3n6K0xTv0R049aE3blZL2js6bCdXe
         JHi1a6Vsojmb+CI4VUKuHa/KZhYWDU85ClFKBicYmcaT6HoSoDN0G8foh4Ym9WgeyXuv
         v4Gu7/HhjFBkAzzMICzALy72NI4bsPiaFQfYnGqQ+1KHgNx8oX9rrmWRXhP1kD5M5CZv
         383w==
X-Gm-Message-State: AOUpUlGzXHMGDj4hjiswA8MLol7n9DHtuzR9BME67tcj+kORnV3ZwSBJ
        2kLgSIzLID5LZiA6QEoQDV9ILqls
X-Google-Smtp-Source: AAOMgpfK9qDUZPjlQ0zP9OyDl5aloy/OMf9vUQrC9rAQQUdP2Z04Vrhqt/3p+RRTNc6B5+UAvrBgsA==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr4127576eda.66.1532633090771;
        Thu, 26 Jul 2018 12:24:50 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/16] staging:rtl8192u: Rename SwChnlCmd - Style
Date:   Thu, 26 Jul 2018 20:24:11 +0100
Message-Id: <20180726192426.31913-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the structure SwChnlCmd to sw_chnl_cmd. This change clears the
checkpatch issue with CamelCase naming. The change is purely a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 16 ++++++++--------
 drivers/staging/rtl8192u/r819xU_phy.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 75fcd3134b6d..4a49bc1f139c 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1215,8 +1215,8 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 }
 
 /******************************************************************************
- * function:  This function sets command table variable (struct SwChnlCmd).
- * input:     SwChnlCmd      *CmdTable    //table to be set
+ * function:  This function sets command table variable (struct sw_chnl_cmd).
+ * input:     sw_chnl_cmd      *CmdTable    //table to be set
  *            u32            CmdTableIdx  //variable index in table to be set
  *            u32            CmdTableSz   //table size
  *            switch_chan_cmd_id    CmdID        //command ID to set
@@ -1227,11 +1227,11 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
  * return:    true if finished, false otherwise
  * notice:
  ******************************************************************************/
-static u8 rtl8192_phy_SetSwChnlCmdArray(struct SwChnlCmd *CmdTable, u32 CmdTableIdx,
+static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTableIdx,
 					u32 CmdTableSz, enum switch_chan_cmd_id CmdID,
 					u32 Para1, u32 Para2, u32 msDelay)
 {
-	struct SwChnlCmd *pCmd;
+	struct sw_chnl_cmd *pCmd;
 
 	if (CmdTable == NULL) {
 		RT_TRACE(COMP_ERR, "%s(): CmdTable cannot be NULL\n", __func__);
@@ -1268,13 +1268,13 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				       u8 *stage, u8 *step, u32 *delay)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	struct SwChnlCmd   PreCommonCmd[MAX_PRECMD_CNT];
+	struct sw_chnl_cmd   PreCommonCmd[MAX_PRECMD_CNT];
 	u32		   PreCommonCmdCnt;
-	struct SwChnlCmd   PostCommonCmd[MAX_POSTCMD_CNT];
+	struct sw_chnl_cmd   PostCommonCmd[MAX_POSTCMD_CNT];
 	u32		   PostCommonCmdCnt;
-	struct SwChnlCmd   RfDependCmd[MAX_RFDEPENDCMD_CNT];
+	struct sw_chnl_cmd   RfDependCmd[MAX_RFDEPENDCMD_CNT];
 	u32		   RfDependCmdCnt;
-	struct SwChnlCmd  *CurrentCmd = NULL;
+	struct sw_chnl_cmd  *CurrentCmd = NULL;
 	u8		   eRFPath;
 
 	RT_TRACE(COMP_CH, "%s() stage: %d, step: %d, channel: %d\n",
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 75aa56ddd22f..509b18415127 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -18,7 +18,7 @@ enum switch_chan_cmd_id {
 
 /* -----------------------Define structure---------------------- */
 /* 1. Switch channel related */
-struct SwChnlCmd {
+struct sw_chnl_cmd {
 	enum switch_chan_cmd_id	CmdID;
 	u32		        Para1;
 	u32		        Para2;
-- 
2.18.0

