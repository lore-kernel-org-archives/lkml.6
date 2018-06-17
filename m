Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA31C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D133A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D133A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeFQTqj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:46:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42996 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeFQTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:46:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so133823lff.9;
        Sun, 17 Jun 2018 12:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4u6MO7qzDZlb+2PafOM+SxYPn3xu/oB74O/sAPk68EA=;
        b=oNUWANdFw4LPM11ZfRZmQj6GjRsXjVUg39l8QlCd86BuJnZwtdtZ4IjPFtjyNeo4eY
         IrLsPAn93loSKskGFFp7dbAartgD2LaQk+GezVvT2e+0iX62GajgCmuo8JFMyk4BP0wq
         8jb/0WSCNprtliOch/y7TvqJa6Zot+1s8InPQZpIYr8Hi6wdRK2Qnfd/p3z78vXS06ZU
         nOixEogsN6+ed7xuYmQwc7u0lUoDAxEHj/AfcEyuCQgkQSCpYmCA8bgvDWHxQxtVTXW1
         B9NLEF+cbClMe59X1JzyTWhGYFPWhCktqKS32sd1d5yF4ZAA/MBVB77hvc8ASjUdORvt
         kpWQ==
X-Gm-Message-State: APt69E1U8RjCWxDCzCRBZe9js1Y21UiK+Lel+38aseIP3wqXOmzj5FE4
        ZgA7i3soxgi6ORJgocxPhx0=
X-Google-Smtp-Source: ADUXVKI35aBJZ0gT9cEiAGoAl3JE8IUIo2I4RZ+5QczF8O9d9SsLV4wpP1IEUBgYVFIm/ureXNjD0A==
X-Received: by 2002:a2e:9890:: with SMTP id b16-v6mr6109744ljj.80.1529264794220;
        Sun, 17 Jun 2018 12:46:34 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id s18-v6sm2451545lfc.22.2018.06.17.12.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 12:46:33 -0700 (PDT)
From:   efremov@linux.com
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH] ARM: S3C24XX: fix typo in guard macro for s3c2412.h
Date:   Sun, 17 Jun 2018 22:46:17 +0300
Message-Id: <20180617194617.15145-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guard macro __ARCH_ARM_REGS_S3C24XX_S3C2412_H in header s3c2412.h
doesn't match the #ifndef macro __ARCH_ARM_MACH_S3C24XX_S3C2412_H.
This patch defines the guard correctly.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
index b6b32724ace8..4ff83f956cfb 100644
--- a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
+++ b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
@@ -6,7 +6,7 @@
  */
 
 #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_H
-#define __ARCH_ARM_REGS_S3C24XX_S3C2412_H __FILE__
+#define __ARCH_ARM_MACH_S3C24XX_S3C2412_H __FILE__
 
 #define S3C2412_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
 #define S3C2412_EBIREG(x)		(S3C2412_VA_EBI + (x))
-- 
2.17.1

