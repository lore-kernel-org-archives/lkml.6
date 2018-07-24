Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B843ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B101020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/yqdvKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B101020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbeGXIDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37507 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeGXIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so2190799pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=C/yqdvKWveGmKVzfCDCnCkBq5NcFX9WA1yra9YOhCwvn9CfIM1fEOdK1zcjJ0ekASY
         p6+Ufuwksx9ALn1kqyOHJMbrBNTCPm74x4jxrdTj7H+j5bNDIqHPqIEoCE1nYZexUTJ9
         EtEADpmliTcPzQlEruISMb1H0icOglJoQlEj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=t6IjARzmx5DIOiUl0vv+lnldaFchPilwGSmnH8Q+L80GLhQWbEDK+Yl8ZlQsKXk0w5
         zitoE9pdx6kIaJvvS3OqahZInasmyf6Mn/gUCIeDFpWJu0LGh0EeM2u4IPc3znmCVsEw
         uQFaeLTZDfcyWZebds0IvbEodm27Xyh09+WXxozl9ae2/+AlpBZsodPk5RTPFOzQx8U4
         +jOvE3tmt+APF+h4vLK+kWITbJFqcFp3IQFLmJUP+Cc1Ru3tk4a4hfGb2VkQtOQQQdv7
         U20WhkdN2WBQ2VQlIPFLgH1rhD1yhMRlbC38/09jIM9CKbeYYIzFnfl/EexyV5twv31b
         h+pQ==
X-Gm-Message-State: AOUpUlEF81cOFd3W+Xl/E1BCJwhV07aUDAU3NSE/bihOGDOl36L1yKf6
        rXxfGR6sn9JGvtJVyUjaQRwv4g==
X-Google-Smtp-Source: AAOMgpcifmCLOo/grYLjGB8iAL1KUz1Ig/0vFwWtz1djsomngxlwEx01Gjj8jnGz7Fd7mWCUiPhIWg==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr16513182pfh.208.1532415489663;
        Mon, 23 Jul 2018 23:58:09 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id t14-v6sm11418710pgu.0.2018.07.23.23.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:09 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 07/16] arm64: add image head flag definitions
Date:   Tue, 24 Jul 2018 15:57:50 +0900
Message-Id: <20180724065759.19186-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those image head's flags will be used later by kexec_file loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/boot.h | 15 +++++++++++++++
 arch/arm64/kernel/head.S      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index 355e552a9175..0bab7eed3012 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -5,6 +5,21 @@
 
 #include <asm/sizes.h>
 
+#define ARM64_MAGIC		"ARM\x64"
+
+#define HEAD_FLAG_BE_SHIFT		0
+#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
+#define HEAD_FLAG_BE_MASK		0x1
+#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
+
+#define HEAD_FLAG_BE			1
+#define HEAD_FLAG_PAGE_SIZE_4K		1
+#define HEAD_FLAG_PAGE_SIZE_16K		2
+#define HEAD_FLAG_PAGE_SIZE_64K		3
+
+#define head_flag_field(flags, field) \
+		(((flags) >> field##_SHIFT) & field##_MASK)
+
 /*
  * arm64 requires the DTB to be 8 byte aligned and
  * not exceed 2MB in size.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..8cbac6232ed1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -91,7 +91,7 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.ascii	"ARM\x64"			// Magic number
+	.ascii	ARM64_MAGIC			// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
 
-- 
2.18.0

