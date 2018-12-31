Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6336C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CA20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8DBKwCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeLaSM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:12:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37087 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:12:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so24775039wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAOnbAxkac0UC41NM/y5SZGaEvMV/qtWid+iG06fEiE=;
        b=V8DBKwClcmmVtlJtWihVDKHGuwOYfXuUtXwtEiRLJo4wr+TOqrrRwZ4gEwdrMg2Ybq
         1HkfDWnSSuS1+p76KzZkj1Knum1hpzQGneiZgKFgK6q3L1XqgNTos71fOL8KwuaOo/d7
         +3eA2kh7t67CPQNPDZ7vG+xS91oeFLv4+wyXASNeWyxmhEN5JZV21rFhurxDARm0HE5l
         LJe/hQklMch00z255TSgGVu0PqOZAHvydmk0o6y8APGPjoBRGy+u7TdZnRYL6fH++hNR
         AgcqZ0TeEyDWBZpmjnxQJv0tBnMaPkB2SVW6crILFEEPJpEFuAbZrqxqFqS5WH20JlqT
         5uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAOnbAxkac0UC41NM/y5SZGaEvMV/qtWid+iG06fEiE=;
        b=RjI5ZypSG/2Txyj6Gp7jaYf3b+VEEWvTfOLf25Yloi84ZhAQAasMWcHyoEv/wZn6X/
         Zn4OcQ7BxBTtNS1wutZ3sV5zTqM3qsqs+QtPJzWuydqGI7LLZh9TwlcTNpjXoKXxQBYT
         ynCrbfQBmzHhpIsxzw5W6jErpZ+07fXefJGIdRU1bIla8fxeDtDCApNJKX9PMEtanJFY
         Lvbyblz5z2wDCImF5Grz35KK8BGGoJ/KDTmp8bvFnfWkU/TTPlARuDAm1cX8qFIUINWc
         GuhT5HfgXgEI5t47k3k4W0SfpsD70kTp+JWCqagBJuQ48QU07gWtFl+UdQbDmzoRUIsx
         xODQ==
X-Gm-Message-State: AJcUukdoTpF/aNIgTOUnyeYtmsLAxXNIAfz7/28NT35Y+IIj4VOrdheh
        yuS00i+32rw1H8TSv6L1nMfFfSNdd8k=
X-Google-Smtp-Source: AFSGD/V96Ltg1sJB72FtjDfLwpK33HJZhp0Nwx6OIVwcf2HNJiuq2TM9KfYhSR9Jq9PYXn+oQKRZXA==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr29566776wme.94.1546279944581;
        Mon, 31 Dec 2018 10:12:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t5sm38254713wmd.15.2018.12.31.10.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:12:23 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] ARM: Remove '-p' from LDFLAGS
Date:   Mon, 31 Dec 2018 11:12:10 -0700
Message-Id: <20181231181209.28695-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is not supported by lld:

    ld.lld: error: unknown argument: -p

This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
that tree). Given that the lowest officially supported of binutils for
the kernel is 2.20, which was released in 2009, nobody needs this flag
around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
linker flag") did the same for arm64.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---

v1 -> v2:

* Collect tags

* Remove an additional occurence of '-p' in the bootp Makefile, thank
  you to Stefan for pointing it out

* Drop patch 2/2, it will be fixed properly in lld: https://reviews.llvm.org/D55505

 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/bootp/Makefile      | 2 +-
 arch/arm/boot/compressed/Makefile | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0436002d5091..1d48c8ed5f89 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 83e1a076a5d6..981a8d03f064 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -8,7 +8,7 @@
 
 GCOV_PROFILE	:= n
 
-LDFLAGS_bootp	:=-p --no-undefined -X \
+LDFLAGS_bootp	:= --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
 AFLAGS_initrd.o :=-DINITRD=\"$(INITRD)\"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 01bf2585a0fa..ecfa4ca320a7 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -132,8 +132,6 @@ endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-# ?
-LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
-- 
2.20.1

