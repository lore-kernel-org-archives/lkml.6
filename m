Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD726214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD726214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeKVBiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:38:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKVBiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:38:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF2oOt3416745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:02:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF2oIQ3416740;
        Wed, 21 Nov 2018 07:02:50 -0800
Date:   Wed, 21 Nov 2018 07:02:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t2vor2wegv41gt5n49095kly@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        chris@chris-wilson.co.uk, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, wangnan0@huawei.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
          chris@chris-wilson.co.uk, namhyung@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Synchronize i915_drm.h
Git-Commit-ID: 53f00f4548ef700e3c6867a35fd7d4f824cd165a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  53f00f4548ef700e3c6867a35fd7d4f824cd165a
Gitweb:     https://git.kernel.org/tip/53f00f4548ef700e3c6867a35fd7d4f824cd165a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Nov 2018 12:17:42 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:17:42 -0800

tools headers uapi: Synchronize i915_drm.h

To pick up the changes in:

  900ccf30f9e1 ("drm/i915: Only force GGTT coherency w/a on required chipsets")

No changes are required in tools/ nor does anything gets automatically
generated to be used in the 'perf trace' syscall arg beautifiers.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t2vor2wegv41gt5n49095kly@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 7f5634ce8e88..a4446f452040 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -529,6 +529,28 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
 
+/*
+ * Once upon a time we supposed that writes through the GGTT would be
+ * immediately in physical memory (once flushed out of the CPU path). However,
+ * on a few different processors and chipsets, this is not necessarily the case
+ * as the writes appear to be buffered internally. Thus a read of the backing
+ * storage (physical memory) via a different path (with different physical tags
+ * to the indirect write via the GGTT) will see stale values from before
+ * the GGTT write. Inside the kernel, we can for the most part keep track of
+ * the different read/write domains in use (e.g. set-domain), but the assumption
+ * of coherency is baked into the ABI, hence reporting its true state in this
+ * parameter.
+ *
+ * Reports true when writes via mmap_gtt are immediately visible following an
+ * lfence to flush the WCB.
+ *
+ * Reports false when writes via mmap_gtt are indeterminately delayed in an in
+ * internal buffer and are _not_ immediately visible to third parties accessing
+ * directly via mmap_cpu/mmap_wc. Use of mmap_gtt as part of an IPC
+ * communications channel when reporting false is strongly disadvised.
+ */
+#define I915_PARAM_MMAP_GTT_COHERENT	52
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
