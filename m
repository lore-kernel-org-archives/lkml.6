Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F70C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0569D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4b6yJLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0569D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeK1Dy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:54:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeK1Dy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so9508834wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dHZ8S+aXQverKkY9zPXDntt+u3jEBNyQXkWLj8HFag=;
        b=h4b6yJLum0eMnzXMvBzkeSRQ8LHm7k1FjgBW2udsyFDjw+uZtUe6MkbTPWyvgw2RIq
         B4gc1vfeKlBDo/vrTNe8s7rCUXIB36UrMpV8+SebqCgnHfUgzULzwYjNnZ2+UjGbgj3p
         +8KAMsOBjeqw3GFRTxskIkWm4zjf3iPC7H6DvYaJEXdPlX1AGzWlbYqr6n6+Pg8GBdKb
         8Z7/tmDjexFinDc5Q5DseAbVzZ6G2/DX9qR0qM2XvQEBe1qUiiYK42LoCU5ztSenxHBo
         WNNToPCtNyYpUb6GVr1vViuXPcoQpSaOQrcdHdJUf66asvaUUzfXyy1Q2A/snH8qQdHp
         qsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dHZ8S+aXQverKkY9zPXDntt+u3jEBNyQXkWLj8HFag=;
        b=eQodJzdDi5W+9q0slJ4kICTECHju1sTAZmiBOYV5Idi/8Z/hJLk5xvWvoUP/blwBZ3
         gkQjFsE/lMvn8xyxY/zjE94vDRDszsvCXc6FJPqDZq1LgBKl7dZPCzPJ+GEd17QAkJwk
         tBMyZwVEYElz5B4rWxuX+asOyWM9FG5Tjj2SoFd48mC+R+3Mw6yA36km9YhPblY5Tufe
         RM8GWZPEm1U9lUN1ycFTXHO3zfzT4cElHVXsRq+qM9Y/FlpajJQ0tcpDvXi1miBg0N8+
         roJ7CEJgK//W/CT0f1piJ6QYpTdm2Hj7Ft2kqOPwe/YBtlSoVYRUhtrtXlQuChfqJkl5
         3eqA==
X-Gm-Message-State: AA+aEWa3mgbQLSjK6JRBiH0k8/8xXt/9EdpwMXxyQV4mtmEBRegKB7tF
        ZA7JRLEGCDQRoDUjyxnUe7sgJg==
X-Google-Smtp-Source: AFSGD/W+Kasr/UmYVWnUYOlOX9N6HnDivsR1UWtpolJAvkPPDE1ylEorpdF9y76ljI7/gq7RsZ2ZaQ==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr18111130wmf.144.1543337755358;
        Tue, 27 Nov 2018 08:55:55 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:55:54 -0800 (PST)
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
Subject: [PATCH v12 04/25] kasan: rename source files to reflect the new naming scheme
Date:   Tue, 27 Nov 2018 17:55:22 +0100
Message-Id: <a6cd5acdc334d532754279a7d2d770e2be96419d.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have two KASAN modes: generic KASAN and tag-based KASAN. Rename
kasan.c to generic.c to reflect that. Also rename kasan_init.c to init.c
as it contains initialization code for both KASAN modes.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile                 | 8 ++++----
 mm/kasan/{kasan.c => generic.c}   | 0
 mm/kasan/{kasan_init.c => init.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename mm/kasan/{kasan.c => generic.c} (100%)
 rename mm/kasan/{kasan_init.c => init.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index a6df14bffb6b..d643530b24aa 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
-UBSAN_SANITIZE_kasan.o := n
+UBSAN_SANITIZE_generic.o := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_kasan.o = -pg
+CFLAGS_REMOVE_generic.o = -pg
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_kasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
-obj-y := common.o kasan.o report.o kasan_init.o quarantine.o
+obj-y := common.o generic.o report.o init.o quarantine.o
diff --git a/mm/kasan/kasan.c b/mm/kasan/generic.c
similarity index 100%
rename from mm/kasan/kasan.c
rename to mm/kasan/generic.c
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/init.c
similarity index 100%
rename from mm/kasan/kasan_init.c
rename to mm/kasan/init.c
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

