Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6741C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AE4218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzEL4kWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBRATk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:19:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46669 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBRATj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:19:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so7502162pgp.13;
        Sun, 17 Feb 2019 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=WzEL4kWCx33847OA62oJO2Wr9cM2nJ70TgNnaqK8kNY8pt5dl6BwVdjYoffp2DEfLM
         XT9um9KQ782bFnUcUBez6Azds+lfhwXa11qb6R1DJ7hMIl6aAunvy4FlFCnt7p48UETQ
         dhEkEwt4EE3YJUExN0fP0J5sM/ezttnJE+8BvH3H8SMNAARvXDChNsQksp4KtcC7yR1Q
         14p2faN0pVd7wGQChe3awiNYPgyHU2N0TEz8GJEZBJJwTXIrD5WnYHOj5/EOB+MyLTuq
         at8e+Gh8yyAxV2ygRGUuhY88sXvkqbyNCRjjm8H1g7v5Lar1jkoW8WlvEYP6jS/UbJvi
         lE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AXM5gfuoADBg0BFzphcMP4lLAjmgxuvX7FX0op9rJ8=;
        b=bsQGCHmf9CCJWMn0QAOkvORmGOXPWg3FLjARJhW44VFeYu865hV2JMaDBlFEOEY7sM
         EFs4eCuYROQmVWPvvLh2iMV82uwO6HAyD3Z3CmeRrjYJrXursv2W5U7xMUfFxdzCCvDz
         z3TKONEo+pR9kTH4/Y7FrYLdDusJd038Sr4zaGgXt/XHOBKGKA05UG5xvqWHoyUHQBsW
         bl/+2kAlVY4x7h9LWc8DinNpux1qgGHuuDGtxXqHX2U1hq2Q8BYX7MhXOCet6Sm9V4b2
         XSMulr6+UiutPZYe2N8C4a9U/+hjnwfZf0AA+YhbRoIfUDtufnHwRlvgykVkdypkSIRY
         U7xQ==
X-Gm-Message-State: AHQUAuay8Soj2BsTuMmcHoeRZLwj/uu/1u6HrfRIutaTk2Q6AZ/wrQvr
        1vQAexyAzX2Lm7eASuSDXMk=
X-Google-Smtp-Source: AHgI3IbFVYQxk+UFZWL1I+XcGnUftENqMcDIkh5oC5TY5Lbla+3d4kjnIpLE+JKYOIQkawf+o4YdUQ==
X-Received: by 2002:a62:d281:: with SMTP id c123mr17106376pfg.210.1550449178969;
        Sun, 17 Feb 2019 16:19:38 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:19:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Mon, 18 Feb 2019 03:17:21 +0300
Message-Id: <20190218001726.16785-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
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

