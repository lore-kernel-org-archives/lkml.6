Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D14BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB25E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWwYymag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB25E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936012AbeFMQHV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:07:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33021 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935500AbeFMQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:07:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so1669424pfi.0;
        Wed, 13 Jun 2018 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcjfljfyhlrqZwWH1+9gew4bvxQUwNYXgP36XZgaDEo=;
        b=WWwYymagRz/Q4ENRHjfHZS3hactL7l5WHHXAi7mTP/070uEW0lvXKadmu5aOMHAROq
         GIrAbDKB1EqNbhFm+vREOt/3lb8k7zgnSq+1lSpEIzD8iGiUGlBGQfDzN5jyukN6rm0W
         tLjB/oaej7Mt/c5z6SpBOSiyXK4++Opuelm6xPI5cYvK9wle7E4K+RaGQXZSy8eCgcji
         1ams8GN1hwcTyq0Zn2bXBZCDP5X3mwIOnHLP2hh53+ko4DdggxQ4p4oGSnlfwnu7sYbj
         IYdrRqHNAFudhD1qyhyMZgTrycQIlF6bc97jmFefnNZW/jbDch1wDfr9tmINvg+994lx
         ScuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcjfljfyhlrqZwWH1+9gew4bvxQUwNYXgP36XZgaDEo=;
        b=kNUDOpxT/4TnHB3XC/6ZVQhbB3+C/aw58c2pcrB2bc1a2AnbvrMzBOHJpX1GCkIUoe
         LZ6o6XrBME4kgKZC0h4mYyeI53u6ol3k0CBeWNfTN4A05Lpj+TQFyt/Pem1cie2PGq6e
         UElnhl8T+bIoNxt1q4v8VpTY69xjfyYgoyS7JPHzUijjdtshQsg+N8cdinM1zwf21dY4
         vVd+VElEtxqTSv0psE0ZWy+Atv/TUCMZZ4rQui/h9s0fyrvFcq8ZHIAeOXC5edN0ei2U
         wUc/Nve4wvDMqNn30i7sEr/sluY3xc4nmo1mCjsMPPIdY/GjE6IcemwZFyP69Tt31200
         iRnw==
X-Gm-Message-State: APt69E0diaRYvNBQbEleMCLuJBFaRqUfO4vu+XtndJCqpK5i3wuSOy+Q
        MzfAHgTyxhaBq5Rd5bka7g==
X-Google-Smtp-Source: ADUXVKJRhAu2Nwt7sl1l7JLXOuSA3jNQy09X8+owo7GM6IA1TrZtShVa+NRgm9o+10tojY7vxziOHg==
X-Received: by 2002:a63:b705:: with SMTP id t5-v6mr4575433pgf.343.1528906038831;
        Wed, 13 Jun 2018 09:07:18 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm4459577pfe.163.2018.06.13.09.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:07:18 -0700 (PDT)
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
Subject: [PATCH v6 1/4] fixp-arith: add a linear interpolation function
Date:   Wed, 13 Jun 2018 17:06:22 +0100
Message-Id: <20180613160643.12638-1-ctatlor97@gmail.com>
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

