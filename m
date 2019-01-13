Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA08C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7E120663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NSlR07vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfAMUVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:21:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38211 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAMUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:21:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8552481pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SZMXyt3fuC9QgBICnVxppk8SU2DS4LuGTafrd6+uVBA=;
        b=NSlR07vNw7hCKkP4Dm1iEyvlHGEFbw/HNpJ9p6WA66QsItXmm6/NeaUgdaRbedBQpc
         5mSJ1ccEyL7yka8bFXv65GIWc7FDflr0G4JyUPQ01K2w7m3BymE3or5oUt+VG8IeMYQk
         oGvu8kZ5A0TW+IN7uWddkgZz+HP2Spfd0ptnDNwvOxkqp9HMp9Gq4NL/A8gtH/Nhpmua
         lQm5zJ9F6AA8I9zaIxpwdeIhGpAE3h/NAXS9BEjzMVxOc+0oEJgYtb5mNdpM3H+YMdnB
         cikkotyUiFR0RqpcGrovh9bjd4S/DqCLUAHeAe6uEPivcV9Mvm0Hf38zs9h02YZ11TQF
         uMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZMXyt3fuC9QgBICnVxppk8SU2DS4LuGTafrd6+uVBA=;
        b=cKAUp7QFbT2jFNLZ/9grHPOdZesXwrzKGr271pEZLr05pv4nwQ4MNzBX5xPXicHybN
         AX762y4mWCz2FaB9wrpwcyNq6wRRy0arPe6gjQNb/B3n7+lUaP23lfyLt/hfseHSKCUv
         8ron38X/Yu/vUkRRJJlig+Wt3K/SP9dz1yrw3409FNCWmkAczdOKZjldJzVHSCPCcUA2
         T+BMTq7Pz6FaxnWBlqhpjXPQIOXMglP0KDMthCAbn8XZWFq2h/K3g9wp5QZITeNfEhK5
         827N/k04i8Uuo/wqmU5/YSdFzjga8MiqbaZFc/Da/6mFq+5GRDx9iHBNq8ZQiIgLu5b4
         iD+g==
X-Gm-Message-State: AJcUukd3tS3LUbLJOwqlAJ4bOJR9JfHK9pSOb/8uSsxI3rLd03m0IUK2
        yzI3muX3FfvSb0dANLGIIPOyUXT114THpg==
X-Google-Smtp-Source: ALg8bN5TY6xCFwLSaRtI3UpeCSMUSNfbjwrsFhB7eP0pFZAmdKsYBvtG5sbm2iL/KHhNMeKUgg3k1g==
X-Received: by 2002:a63:e051:: with SMTP id n17mr10258933pgj.258.1547404361662;
        Sun, 13 Jan 2019 10:32:41 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id b4sm96702992pgq.65.2019.01.13.10.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 10:32:39 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     akpm@linux-foundation.org
Cc:     jinb.park7@gmail.com, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] lib: test_ubsan: VLA no longer used in kernel
Date:   Sun, 13 Jan 2019 10:32:10 -0800
Message-Id: <20190113183210.56154-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now build with -Wvla, any use of VLA throws a warning.
Including this test, so... maybe we should just remove the test?

lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]

For the out-of-bounds test, switch to non-VLA setup.

lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
lib/test_ubsan.c:64:2: warning: ISO C90 forbids variable length array 'arr' [-Wvla]

Cc: Colin Ian King <colin.king@canonical.com>
Cc: Jinbum Park <jinb.park7@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Olof Johansson <olof@lixom.net>

---
 lib/test_ubsan.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 280f4979d00ed..9ea10adf7a66f 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -42,14 +42,6 @@ static void test_ubsan_divrem_overflow(void)
 	val /= val2;
 }
 
-static void test_ubsan_vla_bound_not_positive(void)
-{
-	volatile int size = -1;
-	char buf[size];
-
-	(void)buf;
-}
-
 static void test_ubsan_shift_out_of_bounds(void)
 {
 	volatile int val = -1;
@@ -61,7 +53,7 @@ static void test_ubsan_shift_out_of_bounds(void)
 static void test_ubsan_out_of_bounds(void)
 {
 	volatile int i = 4, j = 5;
-	volatile int arr[i];
+	volatile int arr[4];
 
 	arr[j] = i;
 }
@@ -113,7 +105,6 @@ static const test_ubsan_fp test_ubsan_array[] = {
 	test_ubsan_mul_overflow,
 	test_ubsan_negate_overflow,
 	test_ubsan_divrem_overflow,
-	test_ubsan_vla_bound_not_positive,
 	test_ubsan_shift_out_of_bounds,
 	test_ubsan_out_of_bounds,
 	test_ubsan_load_invalid_value,
-- 
2.11.0

