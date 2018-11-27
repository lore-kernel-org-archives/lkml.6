Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A3214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uH0SgLiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498A3214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbeK1DzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:55:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32768 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbeK1DzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:55:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id l3so434365wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25C8CIYC9SPU9SBI9QwghyxTcLF9XSvMZTbWdHBvFm8=;
        b=uH0SgLiO2qJbc33GzR5cf2JRTRQSW8zulwrxK/hoUgGgbafXk6UjDGyoGxOOx3yngy
         5c00VcRJCyxcL2Ph7XpOtbaV2bk2uik5gfamA5GwT4W7hoj3qiGR8QgE0pXggaU4jVAx
         7G3MfcTqmzJ0xcXdCTdjiFWW4nElcJUYi20y32Xq5iru0Uk0YeMnVelD/8Jq9ijBY5UQ
         HGIO0a8dSjuTcDRktBQUpifl4dngA+P7svdpob0De+rPlPH2xheaba1MpWjV/2U1hiZJ
         XmWbZaE5COdjciH4j/7xRajIIKeGdB4dVoZNR6MtEORI/8BGGjlnmzCkU4/tckzR+vEG
         BC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25C8CIYC9SPU9SBI9QwghyxTcLF9XSvMZTbWdHBvFm8=;
        b=AHJVaJ410K0Z9QBq/rvhDdnc7QQ4Bw69wxnzsuTG2W3RHMYoQwqhasj89YDWq+dD7x
         yEjDEXCC8qio415EqHsaTCbbRo3iUqKsOLCwBsFZ/s4WcbqrSxZw5TxskKWHqjT//+TH
         dn0yMdjzfZostsla5JfQpshcwfMy0OSjPJ6NOS6HqyN7KMnCz7jVCkcx6dtTS4XCjVDk
         jmscmtPu8V6W9JMpN6YQ1cX4K1MS7k//4Wp1afHGNwPYU337B1S84vNg9M0EeHoSoTi6
         osyeEInpAzKOtt2dsQd8BrfSg1kT0HIJTlvclYDQSmfmOAyoQ/6vdDSbBLBF2U4N4PJw
         jBZw==
X-Gm-Message-State: AA+aEWad7TtuAGBoPk+NTQVf74A2ceDLVgm7wfrmxqPPHO9M9L+pkOVn
        R+UWYHazbc/novq/QArqWdT0zA==
X-Google-Smtp-Source: AJdET5dk/kPxqsbkvgpXQKeInuDe0u2bnU8ufhv8gGWZux10fKqn1JFTOMvJKKz7gPe9OYlyoPUDYA==
X-Received: by 2002:a1c:ee86:: with SMTP id j6mr30100231wmi.135.1543337791517;
        Tue, 27 Nov 2018 08:56:31 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:56:30 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v12 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
Date:   Tue, 27 Nov 2018 17:55:41 +0100
Message-Id: <996c9b3898bb3c5de977d00215ddc4bf8cf154c1.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that all the necessary infrastructure code has been introduced,
select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
KASAN mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..8b331dcfb48e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

