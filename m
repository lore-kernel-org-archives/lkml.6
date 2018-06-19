Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14786C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B451820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEfIu4KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B451820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965934AbeFSLC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:02:59 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33797 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937664AbeFSLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:56 -0400
Received: by mail-lf0-f66.google.com with SMTP id v84-v6so6292194lfa.1;
        Tue, 19 Jun 2018 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVJytHozbSHzujAtq9KrPjw+U5xn8yv4LHlVSEw8WUs=;
        b=NEfIu4KZ6f8HbyPF1sIHbqRb9cd16iAwpBUL0thIjRNIYcHZHIpbG93vjJrfnraEae
         le2mVMUlxRgPvrVqt8RdjkrO8HEkzmdh4QyhLsdkJcAUcUhGIBwItF43sxkoUyZFXUHz
         vYjZlimYSoeSmnA/QG0AIK4OyPK3UT4/uC2oHbHozj5X7BP8kO33AG92EqB51x5lgco2
         kcsmBxJD+6rLPihHsbD5Y9zWIcSb9BwKW6vlgv/4e4wsNko6D2eXM9Qnv9MFaXWsyCXU
         upUyf1Uf7GM5wpqFO3xu/wurMQA9NC7MSM7B1tT04Jruq49ovgbzgrlHiNJZzZRVhBRs
         PpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVJytHozbSHzujAtq9KrPjw+U5xn8yv4LHlVSEw8WUs=;
        b=LijIBjNm10DnpLkzVdSLIiq2eXytdRmcEVWxISn8Qm9xe6oH2aRx1uHPbl3bucL68d
         BeLQzHHzBsUfQnfDYtW9dm0W2Shwckav9QyfbiQkhNqPBZsf7JA2ctI363bOR6cUcZR2
         PW0ripRNm1BunlL23yfGMgJGTd692vOq640931AbFVyU+43qePky+ViAxyczXKQKXBWL
         Q0otM96Of0mpkXQKhyesWND+qHYjHrltNdnCEgz7FRyZhT02iElrfQR585eoFAb7sAEx
         UERsOegcJzGpmscoNZXmTAt9wjfK43KZpP4wh5rZtkoOtC70GRPUAO/RjrZ54HTy5EMJ
         bcdg==
X-Gm-Message-State: APt69E2CFbeQKeCJvl/C1YqO4YIsbmPXGped3CxkrBJBYOWbkei46ZLV
        9j4y48GcAOrnZbGsIEcJmHA=
X-Google-Smtp-Source: ADUXVKJWUQvj1kXFOLMz1V3ErEK+2/TCxVKgeB3HVxq0p9Ze4bQveabZAlGxg43Qg98XXRJK3w7gKQ==
X-Received: by 2002:a2e:6d11:: with SMTP id i17-v6mr1744800ljc.116.1529406174585;
        Tue, 19 Jun 2018 04:02:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/5] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Tue, 19 Jun 2018 14:00:24 +0300
Message-Id: <20180619110027.16935-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
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
index 30df6547020f..f6eeb67de217 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -124,3 +124,8 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
 }
+
+bool trusted_foundations_registered(void)
+{
+	return firmware_ops == &trusted_foundations_ops;
+}
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..bfd0d780824b 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
@@ -41,6 +42,7 @@ struct trusted_foundations_platform_data {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
+bool trusted_foundations_registered(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 
@@ -68,6 +70,11 @@ static inline void of_register_trusted_foundations(void)
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
2.17.1

