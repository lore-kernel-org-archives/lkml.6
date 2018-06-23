Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9190AC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E2424ABE
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgEUYZIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E2424ABE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934791AbeFWCVV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38221 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id a1-v6so140765pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VSqo6koXGPUUf73yAUuQMa9ZqsWC87ipZnOODuvNNG0=;
        b=NgEUYZIpE0lEGzhK1c2hLg189w0b4pg+UxqSoxEeBS9XKoatMVmoOFUa1d5YQ12kwp
         +kmuXVFGiRyV2viDTh4OUo3xVimTVetzMrgk5UuDgxQjNkioex8r078s6dqHZVh/xdn8
         ti3QauLgzmOz+xtQQAyKFxeKjMX446wxjHw0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VSqo6koXGPUUf73yAUuQMa9ZqsWC87ipZnOODuvNNG0=;
        b=ISjDeqLp84X8tTAhx17ZgpbGkfXfsVKaeILw4lSFvmRbPKBv/KU9jJIPzB+pzV3M7z
         LgWzwlEOqn9+qnXHcA7eChyabkh4miXtsji09ri4i52wjhJyGLqZ0g+HO3fiqtbYSYMc
         bFjaqHG2ik+jy9hr5jyoMMToMxAFb2T5WSLqtLvUD/b+fxZ28pwbtXR2/TYEt6h4wLaI
         ezxN/qwYmlR9RR1ygtf0OeerrKnTV+f/Ogfuymj3KegN6IBAb50FS9BVz55wL7C2YOcQ
         hkrHkGJqsHzsWD63hHtyO5DDIuhoK5QR3HxBOr+BWx8iSo/2UAPK4xyHc7fYcvszCaNe
         +CsA==
X-Gm-Message-State: APt69E1bO8soD7r6JmqUDb+thtoSj6zod/uG4OHKAr/tQI7WXAQQM6Yg
        ixk9V+KjJRch4cYCqelGhmelaw==
X-Google-Smtp-Source: ADUXVKISo2kA+eO7UJa+BbdbgH714ye4pxjkqBsVcoFRGuB4eMgqYsLDRRWCgqjmVZLfOMyT1cmEzg==
X-Received: by 2002:aa7:8510:: with SMTP id v16-v6mr4084143pfn.77.1529720479144;
        Fri, 22 Jun 2018 19:21:19 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id n68-v6sm16685171pfk.145.2018.06.22.19.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:18 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 06/14] arm64: cpufeature: add MMFR0 helper functions
Date:   Sat, 23 Jun 2018 11:20:50 +0900
Message-Id: <20180623022058.10935-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those helper functions for MMFR0 register will be used later by kexec_file
loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..cd90b5252d6d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -486,11 +486,59 @@ static inline bool system_supports_32bit_el0(void)
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
 }
 
+static inline bool system_supports_4kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN4_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN4_SUPPORTED;
+}
+
+static inline bool system_supports_64kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN64_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN64_SUPPORTED;
+}
+
+static inline bool system_supports_16kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN16_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN16_SUPPORTED;
+}
+
 static inline bool system_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_mixed_endian(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_BIGENDEL_SHIFT);
+
+	return val == 0x1;
+}
+
 static inline bool system_supports_fpsimd(void)
 {
 	return !cpus_have_const_cap(ARM64_HAS_NO_FPSIMD);
-- 
2.17.0

