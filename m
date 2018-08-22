Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53051C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFCA2183D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/PJBkwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFCA2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeHVGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:30:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:30:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so268032pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qB8wQLRm567sPd0BwIEEQEjYlqnBOl4UOSs2cGebjxQ=;
        b=P/PJBkwEPMZUsM7aFZSoSuMyZ+ESKprPlOZTIvj+YyTLkNr053ypWmVga5VMc06/2c
         CR7+mhHGvNik5HsqSTOAxkq1GeZG0sVfo+S2jxkIr91Z4gB91raZ4efl4oEKTLvxc+6T
         AazzPIqEiuuzu3meJfA1z183Fmn7DymWkBSlrhml//oJ8A0LytS5b3RDIth6VZizrenq
         fzHYl+0CvECgT+OoM97SsDKLkOpItmsbEzbU2zlnpsz9ms6SqABXr3vO92lbxAYdhtbW
         9O1Gye0QNq7JVhqpgqcLppc9JRgbtbLCtC3qAky/acYd7plrEAkAM/+HSGrGyrPVEa/Q
         9nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qB8wQLRm567sPd0BwIEEQEjYlqnBOl4UOSs2cGebjxQ=;
        b=eNBqZDMTC3ZrYucisxNzGoU6S1ODG7isxMEsjp4kaAAMyS8ixqllChLgozZfIQIvW2
         Ap/u1MGqWzRyNxiYBklZWMVu53IPMpykVbGXuSgTjF99wkb9nO0mvhkNajqaWZ6xRjV2
         U1xSjsx+dRf0g/oqH1hJh03Dpd+UKWFMdIQkNczz0VvQH7ge/TcUSrjW9k0AptwD8rlT
         c+VYtTQfjiXK5FWkp2Xp3YXbJEuPzxF7KGXshB6c4lPfdX+GtGe6mbGdSJtTYSKpAwtd
         cgJ6MzJXNaZrIxyJD+p8JWGC/0+wcoJI0EP9whrGnRGX9MIPngyzdLEKU/GyM3K29Y1D
         0k9A==
X-Gm-Message-State: AOUpUlGN/lb+gUcs5LvswftlsqYAeSQtBf8cW7YkHgajOHdNNksimRPe
        kcYr66fXG9GxjhLOGXoqjkA=
X-Google-Smtp-Source: AA+uWPzJBdDsbSrchc52klfb1DQ0wJelNefkYjsYYabOmrVH5TFk/ERFhQ9F0GfOux4D49sKOkvVLA==
X-Received: by 2002:a63:4005:: with SMTP id n5-v6mr10897866pga.221.1534907269416;
        Tue, 21 Aug 2018 20:07:49 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id q7-v6sm440165pfq.43.2018.08.21.20.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 20:07:48 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v11 1/3] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
Date:   Wed, 22 Aug 2018 11:07:15 +0800
Message-Id: <1534907237-2982-2-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
memblock_next_valid_pfn to generic code file. All the latter optimizations
are based on this config.

The memblock initialization time on arm/arm64 can benefit from this.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/Kconfig   | 1 +
 arch/arm64/Kconfig | 1 +
 mm/Kconfig         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd..d3c7705 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1641,6 +1641,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	select HAVE_MEMBLOCK_PFN_VALID
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..d4119e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -777,6 +777,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	select HAVE_MEMBLOCK_PFN_VALID
 
 config HW_PERF_EVENTS
 	def_bool y
diff --git a/mm/Kconfig b/mm/Kconfig
index 94af022..28fcf54 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
+config HAVE_MEMBLOCK_PFN_VALID
+	bool
+
 config HAVE_GENERIC_GUP
 	bool
 
-- 
1.8.3.1

