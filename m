Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F8C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F112183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkuGNSEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfBTMpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:45:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39823 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:45:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so24715590wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VnSgGIcvAVUjgW6Yip0Hrcu3Y+bDJDMuLdNyR0jxRw=;
        b=RkuGNSEiWiBLUh5xUgWCC7aRfo5c8cmVpDx8tczf3SsCt/JNp7bl3CEPAZ6bIuphr6
         0qKGZlUEZX3FmSKQMud3QrYDhZGWbFY6JJ9gUXazEMSCQQNUiJJf32ojxJEj+xg1L+Tn
         zC9QKnEJByoPIgtwi7RtLJtG/4uVYgPOGXtZOP5AZsYJtPUVWBch17nA+JuMjTYAo0CW
         Auv5Lb9zfCy/GLO80qQIv+HIAK7/5Q1qIqeL00en4QDK0xASfoSHpM8wL4tWvvgpkb6c
         xq93SHrk6KiU4c26SCT4nfkCwzOhkzWfCNaV+nzb0aIBvJcOK6l0ln0jviTh/RXYY9AT
         C31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VnSgGIcvAVUjgW6Yip0Hrcu3Y+bDJDMuLdNyR0jxRw=;
        b=nN9+wc4HA3LZud03l11ihNtJxpZ2O5iAWRWYPhMhI7saIQd2tueEu1BKUSlY8AVjLL
         cQpzGr0PxKe93Mn4xHvSAa4g25QVPbBHv2O9WxDcYqj61mOKiNvwWsIwUnT5sp984xqJ
         MKoan8S47b7MnF7JJtf8kXPVom4oNiywOrSRZXf2S5idfQBs7YIWSBzA7dH3wDerJQIN
         WyWlFLet0YeEUYTqOTCdLmJ8VK8ZaysyKsfQqqRfIWNEG9rFUiCRnvHU7jbLOXUUkXUl
         dEaM8ZQbi0ueB0it2Gqm5mxz2zWNxJuKMSfPH2IUuWIUfKTYzE7ep46S+2pvwTsk1JXZ
         g2wQ==
X-Gm-Message-State: AHQUAubeNxOFB8w+Wrno9itXgngRkyzdO7k0StaXg9HYX1CBcCciTTGM
        0M8rlBdquQawrZ0HX9NTy4tfyw==
X-Google-Smtp-Source: AHgI3IZCQAIZAKtPesdCePJTdMeBXMjkB4yKP6E02FjEZNJbh7DAEvbOIwdxq/2SRWXrl5Daqdq8dA==
X-Received: by 2002:adf:9d1d:: with SMTP id k29mr23582142wre.211.1550666735197;
        Wed, 20 Feb 2019 04:45:35 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id f196sm6378889wme.36.2019.02.20.04.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:45:34 -0800 (PST)
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
Subject: [PATCH 2/4] kasan, slab: fix conflicts with CONFIG_HARDENED_USERCOPY
Date:   Wed, 20 Feb 2019 13:45:27 +0100
Message-Id: <9a5c0f958db10e69df5ff9f2b997866b56b7effc.1550602886.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
References: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to 96fedce2 ("kasan: make tag based mode work with
CONFIG_HARDENED_USERCOPY"), we need to reset pointer tags in
__check_heap_object() in mm/slab.c before doing any pointer math.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 78eb8c5bf4e4..c84458281a88 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4408,6 +4408,8 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	unsigned int objnr;
 	unsigned long offset;
 
+	ptr = kasan_reset_tag(ptr);
+
 	/* Find and validate object. */
 	cachep = page->slab_cache;
 	objnr = obj_to_index(cachep, page, (void *)ptr);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

