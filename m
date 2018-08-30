Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN5QeZqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeH3WIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47067 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeH3WIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so7979278ljj.13;
        Thu, 30 Aug 2018 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jiYxzZYlLxYwiCUBX9+009bBH7xfhIzJMM0X4EjQePU=;
        b=eN5QeZqH0c30fW+dqI1cVGjL5h3cen2L7BX5R/YdiX9e6CjDPp56zIMrBr5vgIUfTE
         DXKc3smXef3p1HFW5VBOJwhVv9qvgSKNuaI92apbJEXa+wLS09JEvRwD09zTqzY4Sk35
         v8ljY+1WmR0/ABtUBzul/e6279l5uU2g/CkPlDpDn6Nt11hBku3eAc8UuZxMOc+B17cd
         izfQAbVZjl1xRzfC+hM28H/49PSoW6HBMeeB5z2iQacRqQjtaWwPICDOIYJNuND2bHKw
         BHY1DP3FPKb4i/1PYVzuhirkO+dVOflNytZwd7SUrX5AaAaeD9g3K0A7kDRpVqa8yih4
         XyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jiYxzZYlLxYwiCUBX9+009bBH7xfhIzJMM0X4EjQePU=;
        b=BMxce7cHIq8nIsrM/qyEYzdEM1Yrc/REsP8WpoKwG7jFWTJ5lv2hVhm0NgUX+IcUe0
         iroZC46mznYIke+vEzX9ELr4X/nr949dh1c2M/41btTeFwYY8xR75k/veNnzV8vL46DN
         5DCJVIwGT8qL/NzUPQGRPuUepyjL2VdICY5fOMPZgfX6qR43KfUiSTihvYfURdFbu5Fu
         bceD/REuMJQ051ur8HVYtCC0jgGmRx0Y0VfcbAa6sdgA4Fgljkexlxx9cPLsL/nPhVZE
         A295IUy0BfQ4+RA6b1ye8BYYxxIGBPTReQT2X7UOAo6Lv6K1pNcr7e9quzdmwjf7S25S
         Kugw==
X-Gm-Message-State: APzg51ACV/D3jXwaFSCgX8WWRWI1HGeYJbIqvCw4Xby3u9wyg07AIogc
        dSPGb3eYR1I8rzTBVMO0U/I=
X-Google-Smtp-Source: ANB0VdYhPafGlqOEdbXy1bmb80xp5zicWVfD2Unzt2ol5lSahKedAC18SzHXQTGtjCbtre2bq5FQUw==
X-Received: by 2002:a2e:9198:: with SMTP id f24-v6mr7728460ljg.64.1535652324441;
        Thu, 30 Aug 2018 11:05:24 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Thu, 30 Aug 2018 21:04:16 +0300
Message-Id: <20180830180421.6415-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
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
2.18.0

