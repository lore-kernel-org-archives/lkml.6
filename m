Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F8EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8F2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxgUzK0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A8F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbeITAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53640 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeITAew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so7381090wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D2lwL1JaZ9jajF6hdt8cBeNs/CCBgtmxQ7KM/D8RFc=;
        b=PxgUzK0vwDBTyXOPX/cG4NMJdxB4fKJyTnmf8FYPU7Tl7a3W3/HEqI9dXvbmEyWpXP
         PMy/6ufcrDslWWqrDpyxBbArZ24kZrdbF36ZQCcAF9KKqFiIoj+Xq8lguy/MhBKLdXVF
         LX5t1Or53C4aX3hsKSOGer+P1D9wvnTYidtqpN4MkA159JXYlv/M/qM+LI5RlaY6IZi+
         EQ8Hzjdc/4SK7JzcWQKYUNPiUGuClZk0bRzHrlBJZwT5bKRIqwNikQ7MBLrL/QYSu/YA
         p7/o6paGlSDwSslz5TTOCe6YiXAIOfZLKsaiynXEfr/6v0HlmT7enSaUlTczy5k87NWH
         K0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D2lwL1JaZ9jajF6hdt8cBeNs/CCBgtmxQ7KM/D8RFc=;
        b=jc+N6siXLik5SVFCQTmu8gcUfkLevsYva6fSx8p4AvZR1G2IVW0aAaACseljC1FyOG
         0mu+YSp9gN8E63kEU2ekJ1GntcjAaicFSr8yAAsFT/okU5WH+3AgMt1d/IUxVKKnIVH2
         gIBZbq9yyxfYquT/MueVnHzXsgyZuF3tddbudJ0czLI5+k9o0DiND5Ru61NuhPp/rl9J
         RhDjL4MZZ0asvJ6DnmKY28YtX4DgfVj04WDZfhAfTUFvwpF4MC7gcrHLOf5jt7TABzDE
         FIyUmoW/9IdShJ4pynHgWn4bVe/l0iKR7kvxBcvCrujVXgI+UybMMYu/c3u/cJduQz1j
         UyDA==
X-Gm-Message-State: APzg51AzBvRZTyCbJTbAqeTjyc6gIVJ0ccb6JvfhiG5cS9pYT+4K5LCy
        8GY6txeZuJGTB6cyhLfmXqvRGA==
X-Google-Smtp-Source: ANB0VdZAwJs1ECP4eUwXCvbP/BcECN97gCYmPsH+kOoBGhi7wMdxkP2oUW7mAkEM8arF+3YVGck0kQ==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr21164170wmd.52.1537383335654;
        Wed, 19 Sep 2018 11:55:35 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:34 -0700 (PDT)
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
Subject: [PATCH v8 20/20] kasan: add SPDX-License-Identifier mark to source files
Date:   Wed, 19 Sep 2018 20:54:59 +0200
Message-Id: <d1494fdf6008c0c08b29930efd057a28057b8ca6.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "SPDX-License-Identifier: GPL-2.0" mark to all source
files under mm/kasan.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c         | 1 +
 mm/kasan/generic.c        | 1 +
 mm/kasan/generic_report.c | 1 +
 mm/kasan/init.c           | 1 +
 mm/kasan/quarantine.c     | 1 +
 mm/kasan/report.c         | 1 +
 mm/kasan/tags.c           | 1 +
 mm/kasan/tags_report.c    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 25be74d3738f..de76a2bbb375 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common generic and tag-based KASAN code.
  *
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index b8de6d33c55c..ccb6207276e3 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core generic KASAN code.
  *
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index a4604cceae59..5e12035888f2 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains generic KASAN specific error reporting code.
  *
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 7a2a2f13f86f..b3c068ab2a85 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains some kasan initialization code.
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
index 214d85035f99..ca9418fe9232 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common generic and tag-based KASAN error reporting code.
  *
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index a3cca11e4fed..7b7c21d40851 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core tag-based KASAN code.
  *
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 573c51d20d09..8eaf5f722271 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains tag-based KASAN specific error reporting code.
  *
-- 
2.19.0.397.gdd90340f6a-goog

