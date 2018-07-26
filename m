Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC14C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114D520671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc4E5hM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114D520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGZUnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43561 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeGZUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so2242563edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DGbhayke1tXE/dDlmD3jk7a0DwT3cx5EY0Ll0gys/IA=;
        b=kc4E5hM3X6ayg646Brg2TLaTtj46tdgmOFe2mGZeCwW6M312OhKmJ4d0p9q4ez3cRW
         fDefahPt+JkuxeFVFUQKIekMLVzeP8QO1UXwrjeyGXQpV4G9FEuoYITcVO5/xqUTRKvH
         M5ghF7QebjyiBSrF/pvHWnLtPnDpeL4F+0eNMY0ctudepQBDzKzWy7Eu30xNDcNtjaxU
         VOLUvvODZ0iGEy7PIXyhPD56F3A5fWMPr70Kx6VoHHpCTgw4vCYvPDA5nnWuEsVQXvK5
         W3tbssTxPCBFV2ZgmDjmNZicXsa+nWaDFaKAaqmAvyVUJMIPRoVKUaPW3aT6J/FrWxBZ
         euag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DGbhayke1tXE/dDlmD3jk7a0DwT3cx5EY0Ll0gys/IA=;
        b=lzD9MEXZtQPqEB4uW3K/cPLoOWE4nL0t61NNIp2CkMoTq2U5MFw5RihUGvBuQ6upaV
         tGCV3vmd2TiJzkqdkEA8hEZOQ95LNHPVpj2bn/QLPjQbvqVVnMm6WBxhXc518iNBpfnh
         uE3EUBzBQWj8G2nMgMP5bcAqLDEW1SZwIJfuIzBQiuTJCUC1yHfZXmLeUG/yYavAYYy2
         RVwjiXONPz9DG5kq7AD8tJfavMhiAH8sdHMMah50afsD2OBpAlV/CJA8VCXLOiSy1upZ
         KC8go7rSs0Sx0s6bXh8ornoCvYVsjTfKIxBSjZcRLO4ofRNjpymAJ5s3tniPDtW+aW/Z
         V5Mw==
X-Gm-Message-State: AOUpUlEu0c+hrrA14Gbf73VJt/Q/GCCmurQaYbl52/OfYyKZ+3Z/KeL9
        31GEhbVwLrdhHNm+y1coSbNwA+IF
X-Google-Smtp-Source: AAOMgpffvRARovD4tzDRcD4l+taFBFtthWetf6CpR6+QgwUxKJ8RFcLXJ8+r6P1ON4i1reBht2U4OA==
X-Received: by 2002:a50:f5ad:: with SMTP id u42-v6mr4067877edm.93.1532633092141;
        Thu, 26 Jul 2018 12:24:52 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:51 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/16] staging:rtl8192u: Rename CmdID - Style
Date:   Thu, 26 Jul 2018 20:24:12 +0100
Message-Id: <20180726192426.31913-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable CmdId to cmd_id. This change clears the
checkpatch issue with CamelCase naming. The change is purely a coding
style change which should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 4a49bc1f139c..17cc47e20145 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1244,7 +1244,7 @@ static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTab
 	}
 
 	pCmd = CmdTable + CmdTableIdx;
-	pCmd->CmdID = CmdID;
+	pCmd->cmd_id = CmdID;
 	pCmd->Para1 = Para1;
 	pCmd->Para2 = Para2;
 	pCmd->msDelay = msDelay;
@@ -1363,7 +1363,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			break;
 		}
 
-		if (CurrentCmd->CmdID == CMD_ID_END) {
+		if (CurrentCmd->cmd_id == CMD_ID_END) {
 			if ((*stage) == 2) {
 				(*delay) = CurrentCmd->msDelay;
 				return true;
@@ -1373,7 +1373,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			continue;
 		}
 
-		switch (CurrentCmd->CmdID) {
+		switch (CurrentCmd->cmd_id) {
 		case CMD_ID_SET_TX_PWR_LEVEL:
 			if (priv->card_8192_version == (u8)VERSION_819xU_A)
 				/* consider it later! */
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 509b18415127..75970febaac5 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -19,7 +19,7 @@ enum switch_chan_cmd_id {
 /* -----------------------Define structure---------------------- */
 /* 1. Switch channel related */
 struct sw_chnl_cmd {
-	enum switch_chan_cmd_id	CmdID;
+	enum switch_chan_cmd_id	cmd_id;
 	u32		        Para1;
 	u32		        Para2;
 	u32		        msDelay;
-- 
2.18.0

