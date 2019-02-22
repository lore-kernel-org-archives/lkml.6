Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A744C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8JGbZ4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBVTft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:35:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40085 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBVTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:35:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so1525055plb.7;
        Fri, 22 Feb 2019 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=r8JGbZ4cedQpU+TsVBmmNU6DuFUVST/uPXUUDDz34UwVAoCl1q+gn3LxWYYKcgJAMq
         S5Vijg+67p8aHBfgeZ/H1jRFqL0ZrADSF+fwf8LS38/GBpB6r5/0hZSsveK5ICXegT0N
         l9MIT3UYA1RIMcoVdS+/NQe7ZT2qwPMtwDsrRZ5GcywK1eDhg6b2xwA+srSuYEuE10ve
         w2Aagxaa5CsYTJKtF3xNF8c+zpSGcgA/VvP2AL4LXREjt7ghzF9JorvZDRkstY3AHXJm
         tU5RolPRIYUudpRJv20PxEYKN/8qntVAYBr+lOd4ZeLSdFeQ6J3DP8jG+WSWevqLvLo9
         aeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=YiDeMl1phLvKI1hsyBn2uO3mjzfzk98WDgC8ozF38+kwX+Nbl0q6hpWhzRwLj8iOCo
         CmPzQimGrWGmKkcxO3auV7XQHcmE9a14/KGmm3r1BgQBCCRXnPKYY9crOOJAv+XWdsJB
         Q3rn103y5gH+6TjRhsLcV9qSuiW1N5I9AGlnusLu8k29wWgMMw5XdpXcQUtzy3ihF+Do
         D5Cn51NgLAEyuta9AEztubWvceX9Gc1gLsxPRhbya0JRux3RnB7k7JoH/6dp3fXpkpqe
         xr2tbW69lNvgCLF7VMcgUTVhWXFM55ZgquhgvUoViNRhndDTry2GdnhnU+EBDl7oQMdo
         6tXQ==
X-Gm-Message-State: AHQUAuY+rlTPWptehGI/LYXOci2VAy7Zydr/J2bzvIyIAtjvo7bZbWuA
        5S1+/nRqKz4U/0z6CnTf74U=
X-Google-Smtp-Source: AHgI3IY+BUtHdmtO3Eb36AeX+sI7B2m8HCIDEnYZtagtrhsUxsTxrLbBcw+v0eXo8AW9LfbPmK0eJg==
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11mr5830228plb.162.1550864148976;
        Fri, 22 Feb 2019 11:35:48 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:35:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/7] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Fri, 22 Feb 2019 22:34:22 +0300
Message-Id: <20190222193426.10747-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
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

