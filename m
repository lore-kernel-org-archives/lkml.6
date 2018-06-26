Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D5FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D026AF8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h68UhxK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6D026AF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935630AbeFZNQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:16:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36146 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935586AbeFZNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:16:05 -0400
Received: by mail-wm0-f48.google.com with SMTP id u18-v6so1815010wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vvbXXK/Q5KatqSN7+izsT68Mq4ipwgCuO/Xv6CAYHQQ=;
        b=h68UhxK2lguRkfv/Xh43EUruW57gdtvFzruBe4dSf11GfvQTCGGFFN1UvvNYheJy9m
         lMVo9hNOy9uY0le6a76bouYCLMfZqC8V49XSPdsNkXoIp4hgxcXXmgXaGRO+rHy2jo/K
         Uo+24DmdFWZ3U488rS1SLF/SaSDhFHkIPPEnWvGdnM7ZYlYSBCItc6kFH+KSRzcxdOcN
         QoHgUc1Ds8coNunlx93Qat0Hyber8NomGwvPlLBvqOo4iRbIBEg3FEybgBwmxf0uEp5k
         H7eon0R5T3zndWdyx/GQPBx2tshvL/fz10Q6iizH0nD+II4aBKnr9Nu5j/QiPZ/Lcmvq
         cheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vvbXXK/Q5KatqSN7+izsT68Mq4ipwgCuO/Xv6CAYHQQ=;
        b=PBRz1bhU3HtrLVK9TaRxizJ/ZUI2dCEde8+A04jiCmqLVaYCnQni3moYez86jKZ1dZ
         KJOHUvnOfm96j0PdVP17zH4uYVRMw/2rgzDYIRz2PANmogU+Ar9cXecjXGAJpVNlO1SH
         WvdZ0+NrgYQw9go3kthX2FoQ1RNIsJs+vFJDSQoRXWNAgHuFeAa4oWgDEKG+CB6qD2Zv
         7sGbVcvdovHpa5Bqe3CoMuxlHY6ay58Z+0iEynaknoBFy4f5rJRMtaKD4hbufPWvfP7h
         WDvko3EHCqEWQZFfnr6o+UIx8E1jQTJFLjTnJVmIyO+l9PYO4UPmv7irEfkWYumSj+xg
         wIDw==
X-Gm-Message-State: APt69E3jEq/rEanOot1r6bUM5hwpih04WnkjUs0jlspnlfScD7QGZrdl
        EgYzpd2FkMndn/ZYifV0LDp67A==
X-Google-Smtp-Source: AAOMgpewwqqfaDwupFyhtBgH3fcUmEq/EzQwYv2abGNAil1oKnJg4KR9NpojCVzKOGRGMPvu1SFQxQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr1577769wmb.102.1530018964107;
        Tue, 26 Jun 2018 06:16:04 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id w15-v6sm2162639wrn.25.2018.06.26.06.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:16:03 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 17/17] kasan: add SPDX-License-Identifier mark to source files
Date:   Tue, 26 Jun 2018 15:15:27 +0200
Message-Id: <436e34964be76c417066f9b14f29d3d87868768d.1530018818.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "SPDX-License-Identifier: GPL-2.0" mark to all source
files under mm/kasan.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c         | 1 +
 mm/kasan/kasan.c          | 1 +
 mm/kasan/kasan_init.c     | 1 +
 mm/kasan/kasan_report.c   | 1 +
 mm/kasan/khwasan.c        | 1 +
 mm/kasan/khwasan_report.c | 1 +
 mm/kasan/quarantine.c     | 1 +
 mm/kasan/report.c         | 1 +
 8 files changed, 8 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6cf7dec0b765..955e0ebdc644 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common KASAN and KHWASAN code.
  *
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 44ec228de0a2..128a865c9e05 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core KASAN code.
  *
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index f436246ccc79..2dfa730a9d43 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains some kasan initialization code.
  *
diff --git a/mm/kasan/kasan_report.c b/mm/kasan/kasan_report.c
index fdf2d77e3125..48da73f4ef7c 100644
--- a/mm/kasan/kasan_report.c
+++ b/mm/kasan/kasan_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains KASAN specific error reporting code.
  *
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
index fd1725022794..f0d528a8c3f3 100644
--- a/mm/kasan/khwasan.c
+++ b/mm/kasan/khwasan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core KHWASAN code.
  *
diff --git a/mm/kasan/khwasan_report.c b/mm/kasan/khwasan_report.c
index 51238b404b08..4e193546d94e 100644
--- a/mm/kasan/khwasan_report.c
+++ b/mm/kasan/khwasan_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains KHWASAN specific error reporting code.
  *
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3a8ddf8baf7d..0e4dc1a22615 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * KASAN quarantine.
  *
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e031c78f2e52..633b4b245798 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common KASAN and KHWASAN error reporting code.
  *
-- 
2.18.0.rc2.346.g013aa6912e-goog

