Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0573C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B73208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXTPUSFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B73208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeHAJox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeHAJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so10420376pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=WXTPUSFBAaJs3u7G5trMfLp5/+9YTEExILtRGBfs+IJe9vkg2fysxPnpMbwEl9flKD
         lmPW2tJJl3FVwZhHhcUrzrEVaAZzqxOAZdWJl0cn+FEKabJ78upRQuMSd/7x86eFBg16
         Dw+52Me8FRGDb+FHMU+dnXOEvH1CuwLqEZdy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=ncauYQQW7DJnUCfL35DFnpO+5F1bTRkDMrT+M24qR2d4MGOfUXaL1XmsgnTA2bk1I/
         nHXvd73uj5DKMWD8CPt5xWuV7VL9YFVKbHmIPeVfB7XnAkj8ICMW5hSfvWisi0SZh2Hj
         Lzw40wTxVc6sp+W3EsdnAU9qi7y0U/oBGz2xTf8FvuFQgUGjT98u0ifhC6bIr2nQO/H6
         5d/Zw5CCUFd8sJVWqRvKX5FEtT/bew50IUkxyADQDMbArRQD/lMvr+YPRdqAOSPzx+J+
         gIUoA3de6mhUFFi/igZJa4d2/KvIOQeErUl+l1HAG+Gc+any2ZrfQ2fFd8vcq4aD2STm
         IMRQ==
X-Gm-Message-State: AOUpUlENhhvKwz+CECnXDv03BbNCRwqjon46aspzJh6sMlmMJbCd/pN8
        NKrqaAQ9xyILoycoVnWjeqo/jg==
X-Google-Smtp-Source: AAOMgpdobygIZm1RoETsHCSnyruo4M9KJCTqNJ6PyyDQnV/jgKCBl449ugNcQM31Q7JMVyj6ulNUXA==
X-Received: by 2002:a63:ba43:: with SMTP id l3-v6mr22801896pgu.295.1533110426434;
        Wed, 01 Aug 2018 01:00:26 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q78-v6sm30613415pfi.185.2018.08.01.01.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:00:25 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v13 07/16] arm64: add image head flag definitions
Date:   Wed,  1 Aug 2018 16:58:11 +0900
Message-Id: <20180801075820.3753-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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

