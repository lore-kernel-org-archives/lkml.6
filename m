Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EC34C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86CB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpY7bkkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86CB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964861AbeFNPPQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:15:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45293 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964807AbeFNPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:15:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so3709795plz.12;
        Thu, 14 Jun 2018 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEDFBPLVkzjxg0xef+ST22+znpQbaduoWPWawiwbdJY=;
        b=ZpY7bkkDUK1UyPRGoSWCIIJMIJxtWksQW5zrzgrOMgV9S4ZOEpJHmZ1vsZqBgq4wd4
         rlTti81TVcCSiTLmNr2oaDiTc4xFrbHC4SBC7N5YnA+bZvGDc3F33TrOXu4xeepctlMM
         hO4ac1vy4JgG+WMYNeh8Z0n6oASgmjXBajzmfouL5z07SIbINNhKCOJfZTtylqVI0XKh
         lw9uJbYcI0VjzCZfXTFZFD7hZGQuEfHe54d3k2gUL68d8ISA2cTgAfUS/hMLe/fZSM0y
         iB4mkGafoNnWjZvQjvHMQouEcUuCzOZnpA2zqmqpxaYNMQLDhwhQMaXa41fT+XF1aXYC
         glAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEDFBPLVkzjxg0xef+ST22+znpQbaduoWPWawiwbdJY=;
        b=YeFbrGivclb40KXe4K1Mc862/xibJdRLSV1hHm9XPWg29ghFZGmse2zX0wqmW2JI4e
         QavLVm9c6SwIydJVVthkoQkRWrSZD0Lsf07y4xbOvuYaMVEy/fGF5HMoGA40+M66gGjJ
         ikg/pWl2NxfIxvuon4TZ6BXkQUn6zPOq8SIqXevhDhkHFneTolvKdJ3WY3UouTnPya/f
         ELY/fpCn3Yq/8k4r8Z/NejhQqPv8qWt3JgHRd5jTj5PyLnCkbShtcDt87sjfumrfcsJG
         uq62rxLac841wdwRI2cFMMG4xLM2hEgX5i1tF/STiUyxcB8R+isY+cy0HqyfH0Iu2G7+
         Btew==
X-Gm-Message-State: APt69E2ttZ75DMTISdLd2tCU6mc9pOYa5KKs2TYBRehXLcINqnLGU2Kc
        3tFcmE19uyWBztlVsrcTq4kJ
X-Google-Smtp-Source: ADUXVKK/+disR/xwa8nSvKc2HmVK6jWz2zNDqFI96v1q7pCZtpUgVm6fKbbiZdAmdjEX5kLcNfjSKA==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr3553738pli.3.1528989313904;
        Thu, 14 Jun 2018 08:15:13 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm8337276pgd.65.2018.06.14.08.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 08:15:13 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] fixp-arith: add a linear interpolation function
Date:   Thu, 14 Jun 2018 16:14:14 +0100
Message-Id: <20180614151435.6471-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407135934.26122-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a function to interpolate against two points,
this is carried arount as a helper function by tons of drivers.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/fixp-arith.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index d4686fe1cac7..b9e2bb59a734 100644
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

