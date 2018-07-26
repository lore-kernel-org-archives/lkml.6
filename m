Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37213C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33B420883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edgnQQOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33B420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeGZUof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:44:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36830 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id k15-v6so2259055edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10hT8P4zIFQztAKLP2YiYx+0Q+pInEEuUnM/ekxV95I=;
        b=edgnQQOgXng9x7ncSPEYFejBRgiW4wP2XLI7ekaJ77QdROoSeDArD6mLNb+ZQkiF7b
         fKHtRNbdOVY04wRRaGibF/oEzHLWtM73GBT+6cexZ5xOn8wlpZnOE/R3RJmWEKS2ri8l
         sSxAiDOYDiqPZcxALZu4R/M+D53KTNWMr1FlrrXG30ZgcAm6O4AVIadI7CrMwXxv6ceV
         2++QqhC0j8hYo9ZIuYuPeymtjvhvKOcNIWWwGg7zT569Xeh5vxWgkHRjCevUyemF93Tc
         niizhnsXepLUyUp8n4oWszAkWpYoONz8nAQIC028+43F0fQRl74rAoVH09EgxSGEbvZd
         eXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10hT8P4zIFQztAKLP2YiYx+0Q+pInEEuUnM/ekxV95I=;
        b=eq5foiX0GZ5Lv40OItILCfCwnZ//G7nydOTWcVXtpazPLNKWlsELazx9In5ZG7P7Ou
         a0emxV4hni2ft9D7RHYI7LDnleGa48SuW4Y/EsBimbuIjGQ++6QIkRph2XkxQl1DddvG
         IDAph5rIUHbvAblXqpsmBLx8i+Euv7w+ItOPbTm817DZE82TmqsTBitdJ7ht/7Um778V
         isXTpDompdkIedpqMgfPp4kLdfzA9ojJYSlIvUyFgilC9bxpWMVElYjaiomyW0BTO4eh
         6baN9u4aXk0anslwJsAdwOIerHWXDHilNVd8gvtSCNn0WA+luPdwPFVSv8K+7Dygp0nD
         T0FA==
X-Gm-Message-State: AOUpUlHsofxzBFLuCmqhRNAYrjAOa1p5pO2Buc2cmjUz1xHc9mNLwaT1
        W5in3i9qU3Y8QJZG1eZ8yaUAecEK
X-Google-Smtp-Source: AAOMgpfGNA/TtbD6R3b3sTB/Fltpak+k5r8QZaIqGWc438GA51ZHtqZRvxLo4iH2K29d9uIUCIj/CA==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr4102355edo.280.1532633096154;
        Thu, 26 Jul 2018 12:24:56 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/16] staging:rtl8192u: Rename msDelay to ms_delay - Style
Date:   Thu, 26 Jul 2018 20:24:15 +0100
Message-Id: <20180726192426.31913-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable msDelay to ms_delay. This change clears the
checkpatch issue with CamelCase naming. The change is purely a coding
style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 904cc8c1a83b..496f42b8f425 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1247,7 +1247,7 @@ static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTab
 	pCmd->cmd_id = CmdID;
 	pCmd->para_1 = Para1;
 	pCmd->para_2 = Para2;
-	pCmd->msDelay = msDelay;
+	pCmd->ms_delay = msDelay;
 
 	return true;
 }
@@ -1365,7 +1365,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 
 		if (CurrentCmd->cmd_id == CMD_ID_END) {
 			if ((*stage) == 2) {
-				(*delay) = CurrentCmd->msDelay;
+				(*delay) = CurrentCmd->ms_delay;
 				return true;
 			}
 			(*stage)++;
@@ -1407,7 +1407,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		break;
 	} while (true);
 
-	(*delay) = CurrentCmd->msDelay;
+	(*delay) = CurrentCmd->ms_delay;
 	(*step)++;
 	return false;
 }
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 0d4c083ea718..d783e9c0dfd1 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -22,7 +22,7 @@ struct sw_chnl_cmd {
 	enum switch_chan_cmd_id	cmd_id;
 	u32		        para_1;
 	u32		        para_2;
-	u32		        msDelay;
+	u32		        ms_delay;
 } __packed;
 
 extern u32 rtl819XMACPHY_Array_PG[];
-- 
2.18.0

