Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA1820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAThPac/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA1820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeFRGZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:25:35 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35149 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeFRGZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:25:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so8460928plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FD7VfIna/UAY1wgc5Dq164MMDs8h/t7X++mIIOSftvA=;
        b=RAThPac/1JdXnXIPY7xkCHzvGQre6oxJ94blQnymu8m0RYlhMHanI+solZlfyGx0Mt
         /UWlD2VODIbfQo4HyQ/Y7EnGRQ3RRPdat4qAmRpOXX+UdCI1r1yiYiO3WQGpeEI+HOwK
         Itjh6zFLDITg4zf4Mu8OIfx2VblVWg6xzbdMOFkwuFcGTcqvN1/HkjNC4hiBWLKECpVz
         KnpugIPq3K3ciSrvZMR652oZrpUEY3CnkkcBpSUEH/QCQAZgA9bAgXSK1CaICdwWBFoF
         1f685ZFivSEJNAW20l/c8ZDrkh51QtQt2/ZzEp/XspPLGUslbZGDBtbhdWLGCGhWc31/
         uGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FD7VfIna/UAY1wgc5Dq164MMDs8h/t7X++mIIOSftvA=;
        b=Ind7GF7LFt7azlI2X9RnS03TYXQxfcTTu0nvJH+H7hB6pNVJPvUEENPa2AI1D3+nRD
         N0Wc7YahQRifFQEfk4YyxnjuUlYR97hRCFu0d3rn3ZVYyzXwHYoKMRu2z0lnHnfRz09O
         Z9BmyNyQV10f6tW/rSYS0WomsTozUIAjaTZv/pfgGhl/e9HYa5OjC/PQBMqeoOHo6gIT
         t2ztVajqX9e7wsUAYua3u/I1apCAzHidOT9uYL3DzSMWg16zjrNDW6YsjacX2hKrmx/w
         an4Od4Uto2BoCVXT4VrwQ0ji0l2eL4Kp4/18T/BPBRfOiJN9DFulmaU/m6m80lbZzUZH
         Pa9Q==
X-Gm-Message-State: APt69E3dshaBufeVUdqpgPcVYnmrHR3goU9jIh2S2dLT+AOJkEPMo8pI
        fzEepyBKc6r3ctcK5gXDOl8=
X-Google-Smtp-Source: ADUXVKJOi7iHb+Fk7ka961EDxW7RFP8Uhrl9sVnlxrCG5dZOnidr5fnSdCRH1pj/Tuzi7VBxV1gh4A==
X-Received: by 2002:a17:902:28e4:: with SMTP id f91-v6mr12808790plb.146.1529303133260;
        Sun, 17 Jun 2018 23:25:33 -0700 (PDT)
Received: from localhost.localdomain ([106.208.157.247])
        by smtp.gmail.com with ESMTPSA id j13-v6sm9428953pgq.73.2018.06.17.23.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 23:25:32 -0700 (PDT)
From:   Janani Sankara Babu <jananis37@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 1/3] Staging:rtl8192e Fix Comparison to False is error prone
Date:   Mon, 18 Jun 2018 12:05:09 -0400
Message-Id: <1529337909-8900-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes comparison to False and boolean values in the code
which can be written as !var

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c466a5e7..f194705 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -257,8 +257,8 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);

 	RT_TRACE(COMP_DBG, "====>rx ADDBAREQ from : %pM\n", dst);
-	if (ieee->current_network.qos_data.active == 0  ||
-	    (ieee->pHTInfo->bCurrentHTSupport == false) ||
+	if (!ieee->current_network.qos_data.active ||
+	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
@@ -340,9 +340,9 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaTimeoutVal = (u16 *)(tag + 7);

 	RT_TRACE(COMP_DBG, "====>rx ADDBARSP from : %pM\n", dst);
-	if (ieee->current_network.qos_data.active == 0  ||
-	    ieee->pHTInfo->bCurrentHTSupport == false ||
-	    ieee->pHTInfo->bCurrentAMPDUEnable == false) {
+	if (!ieee->current_network.qos_data.active ||
+	    !ieee->pHTInfo->bCurrentHTSupport ||
+	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
@@ -369,7 +369,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
-	} else if ((pPendingBA->bValid == false) ||
+	} else if (!pPendingBA->bValid ||
 		   (*pDialogToken != pPendingBA->DialogToken)) {
 		netdev_warn(ieee->dev,
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
@@ -431,8 +431,8 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		return -1;
 	}

-	if (ieee->current_network.qos_data.active == 0  ||
-		ieee->pHTInfo->bCurrentHTSupport == false) {
+	if (!ieee->current_network.qos_data.active ||
+		!ieee->pHTInfo->bCurrentHTSupport) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
--
1.9.1

