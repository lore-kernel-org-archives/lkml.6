Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IhQxHpx1GVtDDgAAmS7hNA
	; Thu, 07 Jun 2018 18:14:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5522D608BF; Thu,  7 Jun 2018 18:14:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIUnMEUt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8C4F606DD;
	Thu,  7 Jun 2018 18:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8C4F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936189AbeFGSOK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:14:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39431 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeFGSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:14:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id t134-v6so16111070lff.6;
        Thu, 07 Jun 2018 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=BIUnMEUtCwOtaKwW+tHZZd8eg/uvt6vt9e2yaWyINSF1ZmyJdZqmDRbRDaXb1XFL9I
         p8XKxg5GS1ebbnDNGB2mMKcZb8Qh91mMSXcnjnwiKb2a0D4tfXIRz70+1rQP8Am+DZ+e
         XzOtciEK0n/qT6TjKzuuGLd2ZC1l41K28uJN445jSTpIMTx67VFirdFy1dq1nJ7LS8MG
         UNl/Va4EnK5xiOJWbrPapXXIcNoeTHwJ3YovuJSUQn9rEhP7i7JIalaiSfZOl8gQj/zG
         JlzV5UaLKRwK+c9zUeRTrR3niLDZqwYxFgZiH7SpjQRXJj7v4Ya37EUH+oMbg+XWMXnN
         6gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=MjJ2AqHe0qZdGbv1LC3QBohnW8QooCC/RJVP6WCG/pWUr0ymtEx3AakJgYFlYZabNn
         dhERbV97qcUOjc47V3TtlNZLtAOb1jfZKQXvViw30o/dxyNegkuPsJi9A6UT/Z/NMPqS
         hLFxBmvSWvrIjbbnKAlOhONWJXWISZErdWW4P142fXm3xVoCch/7cxMQbmiBaagPOyqf
         k2xycZ7KdGj5pUEMuKTJug43F67CtcUsmMDz/SwLdgbsRfkhXIobsqLTq7R5GXUUCHZc
         A2UtrBurFCSCzGSDATKygq48XVIb8oV/qweFWJ96Opdq0+AkiVZDexA1HKsBeYm7LniV
         JUtA==
X-Gm-Message-State: APt69E1gZHy3mmjRlFzk6bDEHUlvyW4kPPn13unBhVXyqde/z7VNWOAl
        lpQfarFN6VmVnfNVWBnExw==
X-Google-Smtp-Source: ADUXVKJTySrDp3aJ0UWagzCUMTOU6f/3SFs17fuE1F0QL8X6xTNZD09tSAXSniY1mJO39bFLdpqL2Q==
X-Received: by 2002:a19:6a0f:: with SMTP id u15-v6mr2041962lfu.81.1528395245858;
        Thu, 07 Jun 2018 11:14:05 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm3329722ljh.88.2018.06.07.11.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:14:05 -0700 (PDT)
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add entry for the Qualcomm BMS
Date: Thu,  7 Jun 2018 19:12:52 +0100
Message-Id: <20180607181306.9766-4-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607181306.9766-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..be485caf9313 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11646,6 +11646,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BATTERY MONITORING SYSTEM
+M:	Craig Tatlor <ctatlor97@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/supply/qcom_bms.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Todor Tomov <todor.tomov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.0
