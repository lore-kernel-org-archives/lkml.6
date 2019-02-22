Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1E02075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaiH8DNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfBVMyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:54:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39574 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfBVMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so1862360wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKTXMuuFJ0ycWRkeXV5y91b1obeaiELoxpNU31S68XA=;
        b=FaiH8DNHehCmj69FkdBo6mXbqqulK/U8NyRCwUPqCoCXisYnu5gQCGM5mMgF2o+r5C
         Q895ILkegF7YVy2vFzwoQsyu3DHKrS7Js60oUmj3EHAuQ3lDC4dMnGfkMJZ62pMapL+k
         xytmFOkCQHvp0gNluVOkEqXFJhXzhLYBgN2pDRZLIp1yIz0MZnbqLpN529eBLDmuCQ7L
         aRGgYK5N5Bf8jKNgpzLn0LgSmAlL7MWKlzzgbhspTRp7qG3c5svcptnL3y0tn8I+xiVR
         fsnSCnDs4Y6Ma8rGFmML1DTnS0qu8iSEQz/qlVoGNtR0rlFccPGC+6s/xVUFiGjh1uzO
         Tj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKTXMuuFJ0ycWRkeXV5y91b1obeaiELoxpNU31S68XA=;
        b=C+csNO5pDDBPIHKHRQM1fFXzJg9FyAD1/ysi+ZF+hJqXsmRdJgY+EjLRY3U0o7SGqM
         /l6ataqleGFWB0LJqjicWy0pzwSqCl06e0b8jhQWHSS6nca+wFeadRJgIDQZhpV8nmC2
         TrJlGWA93P8STzC5nFav3NIFitLwJhexJ3h5ZNAf7OTCnkVaV6ZGnZUpGoPXbOmhwK+p
         8bCy9Qw5eRKp79v0zK5kbHoaBOapErI2jf02ZEod4nI6ya90frpIOCw+oP0D8PARiNS3
         i69e5zOXmQNniyG/f2UCm1WfafhioZiIDoMNtS+kRUeZrjnF/4DAXNG6LipoH2THuxUf
         qtFA==
X-Gm-Message-State: AHQUAuY5VdJ+Ao4MCVLgF/jY/9j0DpRXX12abvk9MnCv/lasHEPbRSdI
        I0szjuigCUAgEBCztwOSxzqE8g==
X-Google-Smtp-Source: AHgI3IaT3TA/4v9Ai1qhl8SBylCTupXNiKIcUjrbtqaeD8Hyvt8HixWPqJY4f8llGtC/USwzdYOlYQ==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr2545389wmi.104.1550840015942;
        Fri, 22 Feb 2019 04:53:35 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:34 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 03/12] lib, arm64: untag user pointers in strn*_user
Date:   Fri, 22 Feb 2019 13:53:15 +0100
Message-Id: <dd3921be1d264efda649740a94d38872206de122.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..c6adfad39016 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1c1a1b0e38a5..26a6a2a1a963 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.21.0.rc0.258.g878e2cd30e-goog

