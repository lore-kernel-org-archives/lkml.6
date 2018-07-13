Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D3920873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDW8sjSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D3920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeGMLiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32941 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeGMLiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so20650384edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hmBpsgumOCeaTFCnBkzWycfK9w2Jw3tptSDtneBO2m4=;
        b=mDW8sjSVeG4UHnFkirxrMDkaxqyrCx1UYY+r0Amr/ufPqpuBRBizlzFd0KAMLcJbiZ
         UKKhuAO2syxe8xZx+P+81S+BS2LS1gI8liVsYjrj0lr4A21t/BjW18BPNHzulllAzqE7
         CYXRlptI6RcSNOp5BHK2qfPjCsl4RDmhkFzN889hxKAYpyj+b9JBdRU4RyJy97wJCSU+
         PV/ikWGzwZo+wSMWqwDUn0MZvqjQkAa/XP/1UxAU1aFTHykid1DxL21Os9C4Ud40gzSi
         Xb0Fv5EKcV/Jx3Yich+QUegd+dl39CNcL1RBRvszBQzyQeCZ+C9oLR9xT/qd5H/48Ukt
         ms9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hmBpsgumOCeaTFCnBkzWycfK9w2Jw3tptSDtneBO2m4=;
        b=QNeHOFswrPPQR7y/nbXfDeL/VcKnwybE9Pei+XCK66CkVsNfD+8yshAl8wqlEXaC7n
         hh4QzUHx4E7GQzP88Nwrb7kxTz4k+JDhbUSYufZxDfJOGVgOhRNYPHeSfyTvkRd+Fxae
         P5+t5fJcle4q6vTK86L3c439ag7IeCw1i9uYZaGw+eGlAYgoZqE0dbrG9PBKz/mrOou1
         uQzhmt9B7rbRJHlBZzvTbALoWtLHTJWrGqqNvOsnHs2xRduc5UEgWLMDby7+VchXc9OH
         6hXuP5xJpCiBVAFUayBngllLoEx+dQqEilzyVOncMlLO7d3hLokhXJgtoL3c/wiZPaFZ
         5sAQ==
X-Gm-Message-State: AOUpUlHhnk+mM8OzxPQiCNY1ocz1swbt5jO3GWRciP4Eq5LWAtqhalxb
        yAs6SE/fA7rOV//LYsJOlgT6v/f8
X-Google-Smtp-Source: AAOMgpdQPqVQVFN/RbqBmEZSyk9NJHQf91/gJdcFjQmQSv6xw7wYhzrH8MCQqUnMI51znD9nfuVykA==
X-Received: by 2002:a50:c3c7:: with SMTP id i7-v6mr6750087edf.232.1531481027758;
        Fri, 13 Jul 2018 04:23:47 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/13] staging:rtl8192u: remove typedef from structure SwChnlCmd - Style
Date:   Fri, 13 Jul 2018 12:23:02 +0100
Message-Id: <20180713112311.544-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch warns against creation of new types in code. This patch simply
removes the "typedef" declaration of the structure SwChnlCmd to clear this
issue. Simple coding style issue which should not impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 20 ++++++++++----------
 drivers/staging/rtl8192u/r819xU_phy.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 3df4775e1f99..d88f6c3ed46f 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1227,11 +1227,11 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
  * return:    true if finished, false otherwise
  * notice:
  ******************************************************************************/
-static u8 rtl8192_phy_SetSwChnlCmdArray(SwChnlCmd *CmdTable, u32 CmdTableIdx,
+static u8 rtl8192_phy_SetSwChnlCmdArray(struct SwChnlCmd *CmdTable, u32 CmdTableIdx,
 					u32 CmdTableSz, enum SwChnlCmdID CmdID,
 					u32 Para1, u32 Para2, u32 msDelay)
 {
-	SwChnlCmd *pCmd;
+	struct SwChnlCmd *pCmd;
 
 	if (CmdTable == NULL) {
 		RT_TRACE(COMP_ERR, "%s(): CmdTable cannot be NULL\n", __func__);
@@ -1268,14 +1268,14 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				       u8 *stage, u8 *step, u32 *delay)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	SwChnlCmd	PreCommonCmd[MAX_PRECMD_CNT];
-	u32		PreCommonCmdCnt;
-	SwChnlCmd	PostCommonCmd[MAX_POSTCMD_CNT];
-	u32		PostCommonCmdCnt;
-	SwChnlCmd	RfDependCmd[MAX_RFDEPENDCMD_CNT];
-	u32		RfDependCmdCnt;
-	SwChnlCmd	*CurrentCmd = NULL;
-	u8		eRFPath;
+	struct SwChnlCmd   PreCommonCmd[MAX_PRECMD_CNT];
+	u32		   PreCommonCmdCnt;
+	struct SwChnlCmd   PostCommonCmd[MAX_POSTCMD_CNT];
+	u32		   PostCommonCmdCnt;
+	struct SwChnlCmd   RfDependCmd[MAX_RFDEPENDCMD_CNT];
+	u32		   RfDependCmdCnt;
+	struct SwChnlCmd  *CurrentCmd = NULL;
+	u8		   eRFPath;
 
 	RT_TRACE(COMP_CH, "%s() stage: %d, step: %d, channel: %d\n",
 		 __func__, *stage, *step, channel);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d93da2360649..a02e1e0ea643 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -19,12 +19,12 @@ enum SwChnlCmdID {
 
 /* -----------------------Define structure---------------------- */
 /* 1. Switch channel related */
-typedef struct _SwChnlCmd {
+struct SwChnlCmd {
 	enum SwChnlCmdID	CmdID;
 	u32		        Para1;
 	u32		        Para2;
 	u32		        msDelay;
-} __packed SwChnlCmd;
+} __packed;
 
 extern u32 rtl819XMACPHY_Array_PG[];
 extern u32 rtl819XPHY_REG_1T2RArray[];
-- 
2.18.0

