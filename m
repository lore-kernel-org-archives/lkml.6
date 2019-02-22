Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ABC2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8+KBjQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBVSF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33917 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfBVSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id u21so2419333lfu.1;
        Fri, 22 Feb 2019 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=c8+KBjQgBZFPJYZJLcn6IF4jWIkQTuF71Jjw05YUUPwrP9lUWRqesQ3UDx2KsPvLyY
         IcrrtRp1+hWPNNYCpCMKOUvV7LdJqqsNiUuVJw9EByv7wul+MMshHj9fbsNIi9zeaN9k
         7+ZBsHnpSJGEJodG3SEJSFOm6qWKyzooRvc93gjUhyi22qSwO8xYMEs8oH2DymWQPCLB
         iXjppVv8GCbqSsesIBsnfdTedF3E0od9Yc7G9Q+lgUYXFdc4uniHVtU2Vm3DAqZC/c/K
         7N/mh6OXQH2Y7EaloRfAcgnZiMz3YxQ7FA+7t7/4tZRQfWtSe5wR2c/cO8zqUSsqk8L7
         sLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=Z7nm7KDCCv9+SPBvwxOwI6/5fQBQRVT0OoYhZRYQxQmxjmM0+u4C+hocZzN1PqOp9+
         ux7BNRYYMyL1zQfoIqEhD3UxUr4318nXXxw9nT87HQCvyWC3GMevl4/GZ8Ny5hqSy05X
         PPZQjO5yuFusiJJ6OlDnB+HKmQ+wzc8do/IBe3ucrSc9DTuXquElgbPPUFZTWm9eChpM
         KvjbbI7x57ioG3dg4JEwlutanCT+d+JpPqZnTjrECU51XXOwmXmAE8QSu/7+TDjZ4huG
         SlMTqnliwboFMFy6pdfonkMneEVi11rxpIli1MhowJWafUoX95HiQsFI9atb6Ckyk2cA
         OOPQ==
X-Gm-Message-State: AHQUAubmzFh+dbpprYP+jrSE4yRW/bE9KdbJjVJdvtQE3/32pjdCvA01
        Ui/vd8TBj92ec7CkA8LCuI8=
X-Google-Smtp-Source: AHgI3IYt/9wxIsMPbVzzRAw07l6thGsIrsOiWAYri4mv6meo0FXtAaTrSIpifQBqtgaWishzPuvYYg==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr3438477lfi.62.1550858672826;
        Fri, 22 Feb 2019 10:04:32 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Fri, 22 Feb 2019 20:59:21 +0300
Message-Id: <20190222175926.23366-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper that provides information about whether Trusted Foundations
firmware operations have been registered.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 5 +++++
 arch/arm/include/asm/trusted_foundations.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index c496f4cc49cb..d795ed83a3cd 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -172,3 +172,8 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
 }
+
+bool trusted_foundations_registered(void)
+{
+	return firmware_ops == &trusted_foundations_ops;
+}
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index cdd48ab7d191..3f23fa493db6 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 #define TF_PM_MODE_LP0			0
 #define TF_PM_MODE_LP1			1
@@ -47,6 +48,7 @@ struct trusted_foundations_platform_data {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
+bool trusted_foundations_registered(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 
@@ -74,6 +76,11 @@ static inline void of_register_trusted_foundations(void)
 	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
 		register_trusted_foundations(NULL);
 }
+
+static inline bool trusted_foundations_registered(void)
+{
+	return false;
+}
 #endif /* CONFIG_TRUSTED_FOUNDATIONS */
 
 #endif
-- 
2.20.1

