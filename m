Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZegGFG1/GVsQfQAAmS7hNA
	; Thu, 07 Jun 2018 18:55:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 03D566074D; Thu,  7 Jun 2018 18:55:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qybV+aBv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 792B4601C3;
	Thu,  7 Jun 2018 18:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 792B4601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeFGSzR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:55:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33615 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeFGSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:55:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so5186978pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vC65JADnzVAHmxdvB5u1dRuunRY8QlF03TJZLf7NlQE=;
        b=qybV+aBvutD1CwEPWjIHegrvccNv19tbaA6YW4wbvNrALXuxaziFcQrI1dgp04ybCK
         5GvkZqgTwDQen9Ohvyf2tIGnBYJyCp26MTNHk7T7HERZiA3Lky0WqBycp+LLUUp9cRx8
         diR87gQA60ikzr1S60xsN9CT0nX9Foy+d9dB+qMBFy5IHksE36ZLhG+I/dYSnxokhjAv
         c3PFTTQ/T3US1+vaEiRAx9esvJmpsCdM8GF14U71R9dxMiofqBNlAd22BLfSufhupJeP
         +dg0QSKOZ+hzIEIkBvSXP8zkyxQFlK3s1Y3K2qMdLBGccdFEPJQmT84Ar8Bkp4jeEbPw
         pDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vC65JADnzVAHmxdvB5u1dRuunRY8QlF03TJZLf7NlQE=;
        b=sAaz4mJ9TTwwM00po7DI0VSQUm0m1re8bhfX/vFc3vIMLBo4WgKH5ceu+ZYf5lX76B
         FFTLGnUAw80oDXKwEVkBapuvKob9VFKMd8k9SIHJZvKyT191IUFmnhb8no6sTfs+fbGK
         WZYltzy7FISf2PuCmYIxNOUf9ZsSgCqpbMHIDkKqWVMannjCVYJVglP4y3QMDnF9BmU7
         F+m/eFmxDWbFLqZ3IqcesaYNxIY07Cux16jxJcuUOUPIrkg2RHK5QfpjB09h+G5SP1JB
         p+eUtnR1Hjk8/9DTqemdwfquKVjY/L9FY5zjg9YEmYKDqGKxc88HEc2Z/PWqnolSEAzf
         PaZw==
X-Gm-Message-State: APt69E1l6Uxc4DA2Hfi+LclPTA08xNBSd11VUyc4+XT/JND3nq3T/hqe
        m3UOQNgRi6TxhbbBgBDXQCE=
X-Google-Smtp-Source: ADUXVKLGHZ//TR81Jj6adMsyPF5FIJq3vBN1Zaz/7dcpaAnhR7iPvvF317w9rb4uvrDkThWs4IIRWQ==
X-Received: by 2002:a65:6346:: with SMTP id p6-v6mr2507237pgv.281.1528397711220;
        Thu, 07 Jun 2018 11:55:11 -0700 (PDT)
Received: from localhost.localdomain ([27.62.191.206])
        by smtp.gmail.com with ESMTPSA id m11-v6sm32783353pfk.42.2018.06.07.11.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 11:55:10 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 4/4] Staging:rtl8192e Cleanup comparison to NULL
Date: Fri,  8 Jun 2018 00:34:38 -0400
Message-Id: <1528432478-9741-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the comparison of var to NULL with !var

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c6de34a..7ea9271 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -83,7 +83,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	netdev_dbg(ieee->dev, "%s(): frame(%d) sentd to: %pM, ieee->dev:%p\n",
 		   __func__, type, Dst, ieee->dev);

-	if (pBA == NULL) {
+	if (!pBA) {
 		netdev_warn(ieee->dev, "pBA is NULL\n");
 		return NULL;
 	}
--
1.9.1
