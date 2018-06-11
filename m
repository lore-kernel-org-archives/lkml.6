Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7PXaCH81HlvDGwAAmS7hNA
	; Mon, 11 Jun 2018 08:41:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 623F860792; Mon, 11 Jun 2018 08:41:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOUrcVyQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CFD7160385;
	Mon, 11 Jun 2018 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFD7160385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeFKIlH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:41:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46785 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeFKIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:41:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so11897490pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GnxVqBfePK50aoe2QSlsCg+b0ZtB2V5KTJjYo0Tr/os=;
        b=mOUrcVyQ5iO2QCThe9yFG0aikN+xm0Ch8fkPiNDNGluKb1GTfqT22cP2KZl+vf6VFy
         3ZFYJeNfLOomXUeGkzqRt3KybnMBae+p8AWNEDal7fEP7NwfXsSkAV6cPoJyyKByTHLu
         oZTABFLNsYdeEVR6DWUWgAFvU+wNddBjNw3gdhWo+pUGeyTTLzCjt5ouCnTxY6HjBF3r
         +8ZXedFaysdkCk3dyA4DNJDmFBcuFNtU4Lr/bD8Ew4a2HIcCxJg9+htK9R5z+gvvMzy/
         3rnj0W04eK31siZ4BDw2WjUpiH8Pfh4nwYFt/xU8EyRQdMX2+sEUTyO2hqL66Dz8opDE
         kAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GnxVqBfePK50aoe2QSlsCg+b0ZtB2V5KTJjYo0Tr/os=;
        b=rVy7MtpoQyRG6ZCM+pegnzmIKcpi75zXls6R3SruqTcFgoaHttVZZxVJ2iZHfHpCKk
         i2XyuGXLm6EaXDFFGg25UHF9y75FH2ivnpSFMeSBUAix8xCoLra8nlP5Wl4thVL9Nxvh
         DDjyDCYdlglJyPdD8gsDBBtWWqUFgSBrtuq+nQNI4PnZJ3srjUmhV+sUzTtwEccFsdV/
         AU+uzAC9gHS1HlcIZpRKM+KxD6t4wBPKCqfJkvxT9bbf1zHSPX/3T27TSBDx5UhoVhZI
         4nEhCysHxks0FMipkXfzeLQ2BzpxdpJ9I7oaf4KA7VenEbj1ntuopaXLtpaKgb2PQre0
         NbkA==
X-Gm-Message-State: APt69E0NO40xbfSLMAflnw21pnGmOu0WX0D3eQijcFLcCBSragWU9SuJ
        OHBDPfUrdBPJb/eqmUK6LLoGzk8b
X-Google-Smtp-Source: ADUXVKKNUltszD1MAultNV9uAHMzjqVLt6VIDqm4XoF5CSzdxmIC2wmgoMHF8SCxYC0lgDgFSxl/qA==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr17364100plq.215.1528706465009;
        Mon, 11 Jun 2018 01:41:05 -0700 (PDT)
Received: from localhost.localdomain ([27.62.78.244])
        by smtp.gmail.com with ESMTPSA id j127-v6sm31436648pgc.10.2018.06.11.01.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 01:41:04 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: keescook@chromium.org, Rene.Hickersberger@gmx.at,
        davem@davemloft.net, johannes.berg@intel.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH V2 2/4] Staging:rtl8192e Fix Comparison to False is error prone
Date: Mon, 11 Jun 2018 14:20:34 -0400
Message-Id: <1528741234-3792-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes comparison to False and boolean in the code
which can be written as !var

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
changelog
v2 : remove comparison to 0 , replacing with !var
v1 : remove comparison to false

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
