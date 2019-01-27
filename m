Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23777C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C781E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tFx+BqMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfA0VdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:33:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40684 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0VdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:33:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so11748101wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V03FTtrAd0+nzIizDrmSVZJ4SFo1zuGNptEHc0Beu3k=;
        b=tFx+BqMNQOAnnI8uV87FJBVt3f3nm4LZNNRgG5f+R0ukOK3GKcrvM8Dm88nxzttsFL
         L1GoV3zNV5X8tKFvDnWN2M0V6IqZ+DDWF8ZHvK+zLM+8MI8L6224AGxBqgPsuUJ4W7MR
         umptG675KeEBZqYvjq9g+XEKPp3+scnNHF4ZTi/xBlx4OR/gHzP3bZXGwJJdXq3z0uiw
         iWERpmdNQ30JK93hMVq7MxlDPRdk3Wj+X9KsIEZJmf4dY9TWd7eNT7MM41WMg/rVaUg8
         ivWUvtmdAoC/7NG8efUy4GGe27qqGClZqCt3scJ1mAko99QmpQFp9gsEX7wcB2ZYdl0d
         FGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V03FTtrAd0+nzIizDrmSVZJ4SFo1zuGNptEHc0Beu3k=;
        b=KH78+ub9BxnRS7Ce0W3FrqQMa3AjVxAHXUhG4jXWKxd3L2ov/wPyGL0WSw0GLFvunt
         kQ6wgZtPI7oyn4S5qlejkXVNbvlxtG6IYyBKBUvgfm1X3cfttVMdlHGfdSiZXUaKnWpi
         LiTp/RPFkb/zbpRw6PlnLIn1ZaQOHPpa/lmMVDlzCr5jDuU4kgulO3kTJTKArot6V2HG
         JqEXMXd8k+H3MzCi3dPF4sHT/9pP7sBInLGzjKIReeS+cgQjhC16o5iEhZa4A7MEEAFj
         a0k5eqRvhbxKL1wEIlbWvSQRDONoRQUSLCNdaHOn/en2jAfFvFjHKfxEoJBZhQikJDWL
         3U9w==
X-Gm-Message-State: AJcUukcBstFyhUS7Qv2DUzJfIozMo8BTy8nqvLHW2CIeoVhEWxzkgTzp
        fk7vVnMQmlSu0SJBfNm4RXA9jIkVWZHbOQ==
X-Google-Smtp-Source: ALg8bN4BYGuySFML76FiiK/po/imrSIPUfISWcNVs1v3s3r5JWM2YE7C3sJ5JjxsdM9WiBELodv05w==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr14357994wme.134.1548624790131;
        Sun, 27 Jan 2019 13:33:10 -0800 (PST)
Received: from winie.fritz.box (i59F4FF78.versanet.de. [89.244.255.120])
        by smtp.gmail.com with ESMTPSA id h17sm108857254wrt.59.2019.01.27.13.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 13:33:09 -0800 (PST)
From:   Florian La Roche <florian.laroche@googlemail.com>
X-Google-Original-From: Florian La Roche <Florian.LaRoche@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@gmail.com>
Subject: [PATCH v3 1/1] int_sqrt() adjustments
Date:   Sun, 27 Jan 2019 22:33:04 +0100
Message-Id: <20190127213304.22845-1-Florian.LaRoche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __attribute_const__ and adjust to use (signed) int for the right param of "<<".
Change the return value of int_sqrt() from "unsigned long" to u32 to be
the same as int_sqrt64() and adjust some calling functions.

Signed-off-by: Florian La Roche <Florian.LaRoche@gmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 8 ++++----
 drivers/media/pci/cx88/cx88-dsp.c             | 2 +-
 include/linux/kernel.h                        | 4 ++--
 lib/int_sqrt.c                                | 8 ++++----
 lib/prime_numbers.c                           | 2 +-
 mm/vmscan.c                                   | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index a9ed0ecc94e2..460ef38d9667 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -348,7 +348,7 @@ static int fill_hole(struct drm_i915_private *i915,
 	struct drm_i915_gem_object *obj;
 	const unsigned long max_pages =
 		min_t(u64, ULONG_MAX - 1, hole_size/2 >> PAGE_SHIFT);
-	const unsigned long max_step = max(int_sqrt(max_pages), 2UL);
+	const u32 max_step = max(int_sqrt(max_pages), 2UL);
 	unsigned long npages, prime, flags;
 	struct i915_vma *vma;
 	LIST_HEAD(objects);
@@ -400,7 +400,7 @@ static int fill_hole(struct drm_i915_private *i915,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+						pr_err("%s(%s) pin (forward) failed with err=%d on size=%lu pages (prime=%u), offset=%llx\n",
 						       __func__, p->name, err, npages, prime, offset);
 						goto err;
 					}
@@ -473,7 +473,7 @@ static int fill_hole(struct drm_i915_private *i915,
 
 					err = i915_vma_pin(vma, 0, 0, offset | flags);
 					if (err) {
-						pr_err("%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%lu), offset=%llx\n",
+						pr_err("%s(%s) pin (backward) failed with err=%d on size=%lu pages (prime=%u), offset=%llx\n",
 						       __func__, p->name, err, npages, prime, offset);
 						goto err;
 					}
@@ -533,7 +533,7 @@ static int fill_hole(struct drm_i915_private *i915,
 				}
 			}
 
-			if (igt_timeout(end_time, "%s timed out (npages=%lu, prime=%lu)\n",
+			if (igt_timeout(end_time, "%s timed out (npages=%lu, prime=%u)\n",
 					__func__, npages, prime)) {
 				err = -EINTR;
 				goto err;
diff --git a/drivers/media/pci/cx88/cx88-dsp.c b/drivers/media/pci/cx88/cx88-dsp.c
index 105029088120..563a298f2ac0 100644
--- a/drivers/media/pci/cx88/cx88-dsp.c
+++ b/drivers/media/pci/cx88/cx88-dsp.c
@@ -137,7 +137,7 @@ static u32 freq_magnitude(s16 x[], u32 N, u32 freq)
 {
 	u32 sum = int_goertzel(x, N, freq);
 
-	return (u32)int_sqrt(sum);
+	return int_sqrt(sum);
 }
 
 static u32 noise_magnitude(s16 x[], u32 N, u32 freq_start, u32 freq_end)
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..796027bbf1b8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -513,10 +513,10 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-unsigned long int_sqrt(unsigned long);
+__attribute_const__ u32 int_sqrt(unsigned long);
 
 #if BITS_PER_LONG < 64
-u32 int_sqrt64(u64 x);
+__attribute_const__ u32 int_sqrt64(u64 x);
 #else
 static inline u32 int_sqrt64(u64 x)
 {
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 30e0f9770f88..43b0158dd901 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -16,14 +16,14 @@
  *
  * Computes: floor(sqrt(x))
  */
-unsigned long int_sqrt(unsigned long x)
+__attribute_const__ u32 int_sqrt(unsigned long x)
 {
 	unsigned long b, m, y = 0;
 
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (__fls(x) & ~1UL);
+	m = 1UL << (__fls(x) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -45,14 +45,14 @@ EXPORT_SYMBOL(int_sqrt);
  * is expected.
  * @x: 64bit integer of which to calculate the sqrt
  */
-u32 int_sqrt64(u64 x)
+__attribute_const__ u32 int_sqrt64(u64 x)
 {
 	u64 b, m, y = 0;
 
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
diff --git a/lib/prime_numbers.c b/lib/prime_numbers.c
index 550eec457c2e..96c7ef08f379 100644
--- a/lib/prime_numbers.c
+++ b/lib/prime_numbers.c
@@ -67,7 +67,7 @@ static unsigned long selftest_max;
 
 static bool slow_is_prime_number(unsigned long x)
 {
-	unsigned long y = int_sqrt(x);
+	u32 y = int_sqrt(x);
 
 	while (y > 1) {
 		if ((x % y) == 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f800e9..0b9abe1de9e7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2216,7 +2216,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	enum lru_list inactive_lru = file * LRU_FILE;
 	unsigned long inactive, active;
-	unsigned long inactive_ratio;
+	u32 inactive_ratio;
 	unsigned long refaults;
 	unsigned long gb;
 
-- 
2.17.1

