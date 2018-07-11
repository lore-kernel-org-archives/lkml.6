Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AAE20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CajYu/jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AAE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeGKHpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:45:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40878 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeGKHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:45:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so8805020plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uP6g9dIg20P4WZ2r+N/9W+9rosj1Tr0GUJ5X7xgjy0E=;
        b=CajYu/jRuy62ocVoOcQvS6x6/xHOywT1GWvp13rh/8v+XGaXmUOU5lx02fGRI3BL6o
         aeu6X6vJBKHVAnQuZaHTLmMoc0CP4glXhbcpNZM//kb6bk+2dQOaF+n/nKanWuNV8pTC
         wm1gwYT8vTQ6JGYvSa9Qyd8zMS79hUz5l6Bq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uP6g9dIg20P4WZ2r+N/9W+9rosj1Tr0GUJ5X7xgjy0E=;
        b=mQrVTGZSFxKVKHGcVR8+CZS/ISz6tcTZ/hHVburT/2w5WBXTTscDMJgwp9EVztV6+Q
         /MlpY+gmNt8S1ZxMJ48ZGJSiSHO5WzmWt0gyPHVrpoI2ilMJcmnEkXIxzSGqwru+bQ57
         tDUdlRPHOKQuz1F4sL1mjY9bW/6AOM1yA6GEArbh4otl2JR6+Y1aVxxoOd3pEiq6OGGi
         HYk7/hM3Zu8yku8d6YMvgJ/X68Fsqbe/l5BUn/Mr94/MPoNG4etXKKu9RFI006UcZzeK
         gH3hUGi9SmiGOADeAVljBWzXEtSv93dfQ++oKaGkjSU7wq6+4dkPhwb1gPD0eJJiNFF9
         XuqA==
X-Gm-Message-State: AOUpUlEn0muQ81RgeTLRvoSxmT1ATIhbs0OfVO6P/PFdghlosgC0wuZc
        T3LcoQarsK9lcfyIM/yZ2Jy5SA==
X-Google-Smtp-Source: AAOMgpfA+PySvSEeneX9208u9b/OSTtXBe5hsbHr4IWk8fk1elmD4NbCvPJStn5bney/lBPbrCs+7g==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr485209pld.289.1531294930498;
        Wed, 11 Jul 2018 00:42:10 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g124-v6sm30862281pfb.5.2018.07.11.00.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:42:09 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 06/15] arm64: add image head flag definitions
Date:   Wed, 11 Jul 2018 16:41:54 +0900
Message-Id: <20180711074203.3019-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
2.17.0

