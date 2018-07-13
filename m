Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9274DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44620873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="w6Yg8QvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B44620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbeGMPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:45:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32830 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbeGMPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:45:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so12347091plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciWjzt1NHGWjS5vKTA/ijV1ahtym+4HbGR1Y0dLCQ0o=;
        b=w6Yg8QvQFtmGoH0Z4ktJIDuW5l7aBK+zHagMbzPPi1oQ5tFhU4v2NOcb+5dnbYnzIT
         BGW+S6l1Un+NjIEWfq3bvVsJ/sFoC91oq/n42eGIwgf0G6R/bzYJkz0KwWoEi5qT0pSb
         TFltgL8EUjkdA8LV4ARDGIYqC/7eIRGM1ftIxQEarBsMR6TOZeeen89w+K8t+PuU9wUa
         epfIa9vPgaPcGgYUKo5J1xNvtomfs/RLzY4wil/R1pZiIRr46mNg5kmCagg5R++i49es
         wOL3A3ZuCBN/6ek2JbyypzC4XsN1YN/BTaLaKnu4EE/wQhRYRG85a6PZqpat4vJcQO9/
         MQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciWjzt1NHGWjS5vKTA/ijV1ahtym+4HbGR1Y0dLCQ0o=;
        b=KaYp5TkZLaKmtWPBmbB4zS6mPNbg6sZ0BpfgC5mmUrJbuMkvcH9Ec4UPDiBcDiiS0A
         SrLpwF2QcDcQB/HtHjv6Cr6eWmvBjOqJqAlz9x4F8vhiCtzzmDoiRTTYm+ERKJA+eGR+
         /pIOSTC0dlUg5n8D+e1+lcEFipawi3lP4hsqwlOQ+qgBVrqLuAf/wk/T6MjMWL37beM8
         DM7LGVW2Rg/LPF8MsltUWA5L/RW7rKzgbHedYA1rXjNcClnTvsoLkniaW9pRiQI8GKkX
         rIx3/1f1N36kgY3I5OphJPiiyimDXdnvAXdo2zcQZ5oxHhJ1ONBb80G3da6DI/iPSipe
         emHg==
X-Gm-Message-State: AOUpUlE5bo1gGr1qG1XFcj6VaiGDiYka3sWA2K38NHiMKy4vJjyxumkf
        EpuPfq8K/0lxuqAKU0s3X1PVFg==
X-Google-Smtp-Source: AAOMgpf1sK5nvpu724GMOdErS0WEK6rxS53VyMdh/wSKiKXYI7XqTynPcozJ/SnblaRSDMjouLDoNQ==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11-v6mr6714436plb.25.1531495842796;
        Fri, 13 Jul 2018 08:30:42 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c29-v6sm21192139pfe.169.2018.07.13.08.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 08:30:41 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] arm64: build with baremetal linker target instead of Linux when available
Date:   Fri, 13 Jul 2018 08:30:33 -0700
Message-Id: <20180713153033.20540-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713150701.GA3049@arm.com>
References: <20180713150701.GA3049@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
in particular. So, probe for whether it's available and use the previous
(linux) targets if it isn't.

Reported-by: Laura Abbott <labbott@redhat.com>
Cc: Paul Kocialkowski <contact@paulk.fr>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/Makefile    | 9 +++++----
 scripts/Kbuild.include | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e7101b19d590..efe61a2e4b5e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,15 +60,16 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-# We must use the linux target here, since distributions don't tend to package
-# the ELF linker scripts with binutils, and this results in a build failure.
-LDFLAGS		+= -EB -maarch64linuxb
+# Prefer the baremetal ELF build target, but not all toolchains include
+# it so fall back to the standard linux version if needed.
+LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64linux # See comment above
+# Same as above, prefer ELF but fall back to linux target if needed.
+LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d61678c..1e13f502b42f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+# Usage: LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.11.0

