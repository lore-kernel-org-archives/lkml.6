Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w2ssDWZ/GVuMewAAmS7hNA
	; Thu, 07 Jun 2018 18:54:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 592606074D; Thu,  7 Jun 2018 18:54:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeyYX3cs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C9820601D2;
	Thu,  7 Jun 2018 18:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9820601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeFGSyc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:54:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38715 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeFGSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:54:31 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so6699465pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HQJ7DdZXm9QylgTrhF3reBeNJo+paTI45AjbUVyu1Dk=;
        b=KeyYX3csHcvbYjgeuXO/KywgpIwwyfxHPXfkr1w/hwHlAVjpDP0Rrmpf9YQrTQ3LT4
         1R8zDzZ4TnyStoLtYAJr1zpqql3h01EL0EuK8ZcxPyjRd8IjFeoiWFYZwwqiNH2Gx+bJ
         AXACEIZDt2fKTvdEY5ijYC/WQsZXveBWmBT0xZl0V/ZyzBzyEDSk0sLbrSyWy5fNKP1k
         eIF1Sp3NPDn85vVy14A/Ow0sgcdHmPa+boeIH5iXgjuSifWoxzEjHMbQ/xMVOd1Vwg8Q
         HjrS9CIJAZoycc4ZYXoKeECWw1VatoNgIFJcwxThqMf7HA9FU6Hx1oDCXejA2CZTUqu1
         pg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HQJ7DdZXm9QylgTrhF3reBeNJo+paTI45AjbUVyu1Dk=;
        b=m3vLnUzpp9jkE2Hg/zN34FOMeh5jpY+KAyq4BejdFK+Ly8dNMEmIxHT+Ix2L7iOgTR
         LulxQaq92NxfiwFl+g055GS1UJ/xBNAuAX/HoGEf755oWWDsa+WbhvFDr3eWtoNXKXj1
         CQj10lMQb1ET9E6fn/Xm+nJ6riZtYCuSqB2QfkJXTvsWRbZjLQjiFKUbGQrD73ZJijFn
         N8+BwdYOgEeOeeSaqB8E+JjDIt9lnRrJGjtgWnJo4bnOTBWvBHBTSxy1jp0MHQUgZjdK
         Kxb9/lGO4oaRhnJtcqz6EU/+fZf0b7VT+G0JqTavGz0SJTsdGsI7oYHBrG7Nq8C0V4Pd
         ttjQ==
X-Gm-Message-State: APt69E0WaHEGksm1Zq+A7Jwr+bDsaOflR1pH36QLZWAmsbBaZUC6mI/Y
        sGZRAN6keCT68pmFG5PhyOE=
X-Google-Smtp-Source: ADUXVKK0dS+P9D3Tv1ow2C+y3J4L6HjRskfPgXi8IdwARd+ugk9JXaUk+P36YRkDK9xSRVb9vPUcKA==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr3232058plb.204.1528397670589;
        Thu, 07 Jun 2018 11:54:30 -0700 (PDT)
Received: from localhost.localdomain ([27.62.191.206])
        by smtp.gmail.com with ESMTPSA id n72-v6sm4353913pfj.68.2018.06.07.11.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 11:54:30 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 2/4] Staging:rtl8192e Fix Comparison to False is error prone
Date: Fri,  8 Jun 2018 00:33:56 -0400
Message-Id: <1528432436-9652-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes comparison to False(ie. bool) in the code

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 3c7ba33..ccd898a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -258,7 +258,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)

 	RT_TRACE(COMP_DBG, "====>rx ADDBAREQ from : %pM\n", dst);
 	if (ieee->current_network.qos_data.active == 0  ||
-	    (ieee->pHTInfo->bCurrentHTSupport == false) ||
+	    !(ieee->pHTInfo->bCurrentHTSupport) ||
 	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
@@ -341,8 +341,8 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)

 	RT_TRACE(COMP_DBG, "====>rx ADDBARSP from : %pM\n", dst);
 	if (ieee->current_network.qos_data.active == 0  ||
-	    ieee->pHTInfo->bCurrentHTSupport == false ||
-	    ieee->pHTInfo->bCurrentAMPDUEnable == false) {
+	    !(ieee->pHTInfo->bCurrentHTSupport) ||
+	    !(ieee->pHTInfo->bCurrentAMPDUEnable)) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
@@ -369,7 +369,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
-	} else if ((pPendingBA->bValid == false) ||
+	} else if (!(pPendingBA->bValid) ||
 		   (*pDialogToken != pPendingBA->DialogToken)) {
 		netdev_warn(ieee->dev,
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
@@ -432,7 +432,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	}

 	if (ieee->current_network.qos_data.active == 0  ||
-		ieee->pHTInfo->bCurrentHTSupport == false) {
+		!(ieee->pHTInfo->bCurrentHTSupport)) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
--
1.9.1
