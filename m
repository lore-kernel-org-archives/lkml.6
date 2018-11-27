Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26424C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5192145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXmQ7q7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5192145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbeK1DzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:55:09 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39931 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbeK1DzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:55:08 -0500
Received: by mail-wm1-f45.google.com with SMTP id n133so6221478wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqHRGLTjehAPPlhG5MrM8/SiVdROoXpoESjJ74s2A4U=;
        b=AXmQ7q7R1HXMKgMVeS27Rj4kiDof/yHUPibkT4fIvoAy/nTR7z7f1eT6vpHnsqcvJW
         MLWi1ZV9OiVSrzfsGHMAKHmYej7Z6vktknz/E5w3Ba58xGUPhJ0IwsoCNVU2TRMQHe8b
         KxQSdeIyh0MgVfcqUfns/A97+FybMDUqlhE0HUEYQgW+BId0WXHFuMwt56GYob+/ow72
         z8YftlzfcnQD/leNdS+++KZsR0USvXU9aVG903NwP9hEZrwuWSZ97/yC4jgIUGQ3fO/a
         hcOQavZjNhwSveJOH46IRpXb6aJukStVP8XYVvIon2ejxulynl4IHoDlgh/h1VpFrPtZ
         23PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqHRGLTjehAPPlhG5MrM8/SiVdROoXpoESjJ74s2A4U=;
        b=ARiI449qCTBlCWKfcuJ7hWOfaCeYCPx8HOkIn3BrpPPH5T/A1TDkJa29AvSAwfmgyX
         h2XIQY1H/6CWs5NXMcFEZgCFMFxn/zyzXK53CNUabZIGIFMiTDyZuY5VuYVgLXkVGK89
         hClJFNi8ovqZcvvDlwgWCH2cCRa1QIV9zL24Trc33iQ0R027y4XcVt4WIsYUnsLvFCej
         kRcYroJY/Asq5ruaP1RroCWAgKCtRGef2kqE5FmRh3oGgto3I9Jlrmrx/uiRP8j7JY6n
         Z4xGEF5E871nN25exGwo4quTsY/6SfM3wcV+b7AgWPmUJOHW+7jTewk7SmXeGaHpFLMf
         b9uQ==
X-Gm-Message-State: AGRZ1gJpOCqdOYx0yuAKrpCU3ppv6iFbHuB/m4wf4lpIp6cQ+q4uf5TI
        XS1FsbzEIwJrOtLqajl7dwq5RA==
X-Google-Smtp-Source: AJdET5ecLjjQdWCfN0/+r/icJ0YYKjaCZ80FZLUq4u6JkOTfiBS3pz5PsaOfYZOxHXiyBNNuZUKO+w==
X-Received: by 2002:a1c:8d46:: with SMTP id p67mr26740300wmd.28.1543337795769;
        Tue, 27 Nov 2018 08:56:35 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:56:34 -0800 (PST)
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
Subject: [PATCH v12 25/25] kasan: add SPDX-License-Identifier mark to source files
Date:   Tue, 27 Nov 2018 17:55:43 +0100
Message-Id: <8e26a568b12ea02e11c35b681f3c36aff2fc1d77.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "SPDX-License-Identifier: GPL-2.0" mark to all source
files under mm/kasan.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
index 1144e741feb6..03d5d1374ca7 100644
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
index 2b21d3717d62..34afad56497b 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains some kasan initialization code.
  *
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index b209dbaefde8..57334ef2d7ef 100644
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
index 1d1b79350e28..0777649e07c4 100644
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
2.20.0.rc0.387.gc7a69e6b6c-goog

