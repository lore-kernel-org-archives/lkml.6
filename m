Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1197C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCE52183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCOPqR5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBTMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:45:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:45:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so12443644wrg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaoljckUWXKFfeKRZfZeobgkbuOIuC7kgR+jgoF4iJk=;
        b=dCOPqR5UrKNy/r0gjEIkUKwXsNa3lqaV8sDMBn1OFghR6pdRIBuiH3LFXpJduArWHy
         QaCnlzYPUFbkqtAFyZrxQcZdVGWx28NjSPL8HCV8eCAgi/gTX7GArzZCa7EYUTlRVgfJ
         aQPv8HLTo8Hh6IQAhrMsYkO0+Y64RGeF/xTCt8LY+lkuKeOuzVlMOXyUQw72lTrxCCoR
         hVkRHVHerQDTiqt71u2jBrrOofsTEp/vWPOkV0TAHiaijjr8GAtgukm9R6JwRTf2llpU
         T9Mmuof7mcWq/f0BCOypG2mg0kE5Mc6dqLbwKcRI6EVyNpKcGQt+HF1NLdw43wUYqvYv
         8/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaoljckUWXKFfeKRZfZeobgkbuOIuC7kgR+jgoF4iJk=;
        b=sR7vgQFjC0mXOMktzJaaN5h25RyXCuYHF0KwtCjAi+d+hZfb+If/hfcczYWeEPNtIp
         HjDRRn7xKXLeQwhJxmWRyq8KuVA9bYG6xKzrC2DsRbIPpjDaqLUwpljqLTzdcAT/lbfF
         jM7tLRkEqOh8hlv9p9aNWW3oqlpLZAOLbEiKi/XwsZz2JpxLUMy6B6snVO4tuBthqb3X
         6PVwdzNwYSZGp+X1SLgtQib+UeWQ+M5EA/4CVClYWssl7DI2Xz4/dkWOV1xTG0UBRtY1
         jCQ7FT7tpVXwObuLCS73QQzGj/sLEbFLHfW7YG2fOmLLQvE7xIvWVp+Ebdv+NxUjWOsm
         jISw==
X-Gm-Message-State: AHQUAuantht9xgc/LQqFVafNeTfpSMawKIYu8p3iojdLcc6mgNZqp5+L
        L1qd8OyO1l3rCfnRbVKQA6Szjg==
X-Google-Smtp-Source: AHgI3Iahe8QNa86C6LoUNOB1tqAbTiNm3ZOgBS6ROc45eIbTQYdz863wRnoMcCuGABBxrPdDyzXdCA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr23652406wrx.74.1550666733631;
        Wed, 20 Feb 2019 04:45:33 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id f196sm6378889wme.36.2019.02.20.04.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:45:32 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/4] kasan: prevent tracing of tags.c
Date:   Wed, 20 Feb 2019 13:45:26 +0100
Message-Id: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to 0d0c8de8 ("kasan: mark file common so ftrace doesn't trace
it") add the -pg flag to mm/kasan/tags.c to prevent conflicts with
tracing.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index e2bb06c1b45e..5d1065efbd47 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -7,6 +7,8 @@ KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o = -pg
 CFLAGS_REMOVE_generic.o = -pg
+CFLAGS_REMOVE_tags.o = -pg
+
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

