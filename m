Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UOvqJ711GVt7DwAAmS7hNA
	; Thu, 07 Jun 2018 18:13:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E932A6089E; Thu,  7 Jun 2018 18:13:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYdOtheu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72854601C3;
	Thu,  7 Jun 2018 18:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72854601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936149AbeFGSNZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46375 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeFGSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id j13-v6so16091781lfb.13;
        Thu, 07 Jun 2018 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcjfljfyhlrqZwWH1+9gew4bvxQUwNYXgP36XZgaDEo=;
        b=QYdOtheuhBfQfvUO11xaXHz8W8uoEQEswg3rzwzKzeFeZDtBbwdJ//laH1Upib0pCW
         wrdFm/kXBAKUYGCtbwONGsOjP9mvyMNopDmVFTQjHJIIvED3m8frifZBwCVTc9rVXRkd
         txjYLZ28wQnqDqtGZpkasL+1cmROsEFohtccVDuxDcVORRDpew7RAUXJU8vc8puwjeAn
         c39IHT+jXF7BKqYGpawZJij+V8LnL2GNzC5NdOpEecDILILK1aED/7ZjPqGj5/+dpJ5q
         kfP3R0hXVMZncK5TwAewhQCTWkyt2z1Xyk6DrdGtrmmC8O6H1EOqNt14Ip0qgtSaS2cG
         VeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcjfljfyhlrqZwWH1+9gew4bvxQUwNYXgP36XZgaDEo=;
        b=a/5GR8uYO5Koh1FyC6TlmyIs2l2hUDfehg8NNqrXZmJ+mory9ImT8q+vhOdHPHJoJu
         s8ATURksZ9otbXAk2ipmN+JfBHQG+8WJQgVY7rdGockdT2J05W9UZS0r1md32WhJeqsj
         Olr24ZCQP1n3NKPW0Lqu22mv0ET9kKYUD4mAiSPuyB+K6p7QomIZKnViRWx+P2tGivwG
         VIzc7shwUfjdq346GTs2v7xRDg3xc/v9nGEM2CJfheIOYOybc2GZw2FZToTWkm+vRKv1
         Z/6K8DzhOPkJA5V3mVVmAW7VPuvaNNv8XvaZOk/doGmrz7UbgaxKDHK+fVUwcdsGcezC
         ZhIg==
X-Gm-Message-State: APt69E3Qq+h7AXSKysRLgi6GRtbJaZPAMOYwVjfhEZSEDnbATGQuYVC5
        QsAU6Ej6ZvMgIFcizHIOZg==
X-Google-Smtp-Source: ADUXVKK9AHihVMtw4nn67t7iLIS4l6hCYsdS8QyNeTf0fI/if1a8mL8uTZYcfUsj+STAFaWvqidATQ==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr2245039ljf.120.1528395198693;
        Thu, 07 Jun 2018 11:13:18 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm3329722ljh.88.2018.06.07.11.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:17 -0700 (PDT)
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
Subject: [PATCH v5 1/4] fixp-arith: add a linear interpolation function
Date: Thu,  7 Jun 2018 19:12:49 +0100
Message-Id: <20180607181306.9766-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407135934.26122-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a function to interpolate against two points,
this is carried arount as a helper function by tons of drivers.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 include/linux/fixp-arith.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index d4686fe1cac7..c21de4f358dd 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -153,4 +153,24 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
 #define fixp_cos32_rad(rad, twopi)	\
 	fixp_sin32_rad(rad + twopi / 4, twopi)
 
+
+/**
+ * fixp_linear_interpolate() - interpolates a value from two known points
+ *
+ * @x0: x value of point 0
+ * @y0: y value of point 0
+ * @x1: x value of point 1
+ * @y1: y value of point 1
+ * @x: the linear interpolant
+ */
+static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
+{
+	if (y0 == y1 || x == x0)
+		return y0;
+	if (x1 == x0 || x == x1)
+		return y1;
+
+	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
+}
+
 #endif
-- 
2.17.0
