Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L0yYNnN/GVudfAAAmS7hNA
	; Thu, 07 Jun 2018 18:54:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 231526074D; Thu,  7 Jun 2018 18:54:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW88lbQY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 699EB601C3;
	Thu,  7 Jun 2018 18:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 699EB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933174AbeFGSyz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:54:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41661 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeFGSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:54:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so5345383pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jiPl2EMttVFt16on49GND/kt1rQOx5pA0A0dTzzB/q0=;
        b=dW88lbQYsWMn5hBzdXeXx2bSn2JDhNljrjH0CMpHAyWokvs8HoDX1c5fAS83KyjqzV
         t2FvJjKUf/w0ZsWpWupu7rjSIQDGo5hDAmwPrn9yBbyV0p9NvuP83sis7RtmsCIYH4wl
         fcRjpy/kQ0twZB1U2lFEvCXhnMIa3jCV/rVP9CU9LBq54FJBmu8yCb6x6ouUz/teKX+a
         O3WlheFgA65g0wpjMtPYFmVkJvC+E2cbZYlp3MqboypCqJZzTn9FjcTtx9zhS7Nh+fhS
         nCHvPBLp0Lz1hu+9wPVf8F100t30yPUn3VM1UZooVVKutQ5tatIB19qsuVNDbMiXv0+/
         Gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jiPl2EMttVFt16on49GND/kt1rQOx5pA0A0dTzzB/q0=;
        b=P1UCOila0t1LJTE54SKDTGlYJwvLobAdaC8PJXUp6eWVrhN/po9wK/q43tlcH0XUvA
         1umYtNk1ZDjGoVY7mIPWXUnd2UfdHMN45rVM1vYQ+Q/JDd1iCoYqlc2n4QxlXfFXVM47
         FNKxdegpOBRW0Uo05nhZXlxRwyL2MFvYzy2h4ZxoDV37ex1f/dNm25RhD05xsFqO8TX9
         ldI9GUT9zYF0l3hbRjhZ0oGx9UBPTE3nFI0b1GnFeAYdSZ8o8fPTdtuc+enV1c8Zbryq
         DIGn7Rm/a/N/W2P6KuDhhU6cgoXCtvYkt5sshKaubVfXtIuYevUiOAUycbsu44e3GGpM
         3iLQ==
X-Gm-Message-State: APt69E0Dtygnr5Osx08TSdvleEazI01OyEXTEzUVD8RL4WCIMByv61q7
        OBW9Jj0NUts08JL+0F0bR/I=
X-Google-Smtp-Source: ADUXVKLoRIjn/NItJbf/zxCvRBnjhdtD0rowL1fkXPdQyRl7Xa+PYRWNVbRE/8cUJ9DNrGRs5ggEgw==
X-Received: by 2002:a63:618f:: with SMTP id v137-v6mr2568529pgb.145.1528397693284;
        Thu, 07 Jun 2018 11:54:53 -0700 (PDT)
Received: from localhost.localdomain ([27.62.191.206])
        by smtp.gmail.com with ESMTPSA id q68-v6sm97186521pfb.182.2018.06.07.11.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 11:54:52 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 3/4] Staging:rtl8192e Fix Comparison to true is error prone
Date: Fri,  8 Jun 2018 00:34:19 -0400
Message-Id: <1528432459-9696-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the comaprison to bool value in the code

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index ccd898a..c6de34a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -365,7 +365,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pAdmittedBA = &pTS->TxAdmittedBARecord;


-	if (pAdmittedBA->bValid == true) {
+	if (pAdmittedBA->bValid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
 			   __func__);
 		return -1;
@@ -485,7 +485,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 {
 	struct ba_record *pBA = &pTS->TxPendingBARecord;

-	if (pBA->bValid == true && bOverwritePending == false)
+	if (pBA->bValid && !bOverwritePending)
 		return;

 	DeActivateBAEntry(ieee, pBA);
--
1.9.1
