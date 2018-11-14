Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C1FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDB20869
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DDB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbeKOAaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:30:21 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:51993 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726846AbeKOAaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:30:20 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from haswell.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 14483334-1500050 
        for multiple; Wed, 14 Nov 2018 14:25:22 +0000
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de
Cc:     hpa@zytor.com, Chris Wilson <chris@chris-wilson.co.uk>,
        Petri Latvala <petri.latvala@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf/x86: Bump INTEL_PMC_MAX_FIXED for Icelake
Date:   Wed, 14 Nov 2018 14:25:18 +0000
Message-Id: <20181114142518.15380-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<3>[    1.463458] hw perf events fixed 4 > max(3), clipping!
<4>[    1.463468] WARNING: CPU: 0 PID: 1 at arch/x86/events/intel/core.c:4558 intel_pmu_init+0x11bf/0x13ca
<4>[    1.463517] Modules linked in:
<4>[    1.463535] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc2-CI-CI_DRM_5134+ #1
<4>[    1.463563] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.2402.AD3.1810170014 10/17/2018
<4>[    1.463611] RIP: 0010:intel_pmu_init+0x11bf/0x13ca
<4>[    1.463631] Code: c5 ff b8 01 00 00 00 48 d3 e0 48 ff c8 83 fe 03 48 89 05 89 13 c5 ff 7e 1d ba 03 00 00 00 48 c7 c7 40 a0 07 82 e8 a6 3d 9a fe <0f> 0b c7 05 82 12 c5 ff 03 00 00 00 8b 0d 7c 12 c5 ff b8 01 00 00
<4>[    1.463692] RSP: 0000:ffffc9000004fdd0 EFLAGS: 00010282
<4>[    1.463714] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
<4>[    1.463740] RDX: 0000000000000046 RSI: ffffffff8212883a RDI: ffffffff820d6d87
<4>[    1.463766] RBP: ffffc9000004fe20 R08: 0000000000000001 R09: 0000000000000000
<4>[    1.463793] R10: ffffffff8100b380 R11: 0000000000000000 R12: 0000000000000000
<4>[    1.463819] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
<4>[    1.463846] FS:  0000000000000000(0000) GS:ffff8884afe00000(0000) knlGS:0000000000000000
<4>[    1.463876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.463898] CR2: ffff8884c03ff000 CR3: 0000000005210001 CR4: 0000000000760ef0
<4>[    1.463924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[    1.463951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[    1.463976] PKRU: 00000000
<4>[    1.463989] Call Trace:
<4>[    1.464006]  ? printk+0x4d/0x69
<4>[    1.464026]  ? merge_attr+0xa8/0xa8
<4>[    1.464042]  ? init_hw_perf_events+0x31/0x6d8
<4>[    1.464061]  init_hw_perf_events+0x31/0x6d8
<4>[    1.464083]  ? merge_attr+0xa8/0xa8
<4>[    1.464101]  do_one_initcall+0x58/0x2e0
<4>[    1.464124]  kernel_init_freeable+0x135/0x352
<4>[    1.464145]  ? rest_init+0x250/0x250
<4>[    1.464164]  kernel_init+0x5/0x100
<4>[    1.464181]  ret_from_fork+0x3a/0x50
<4>[    1.464205] irq event stamp: 368
<4>[    1.464221] hardirqs last  enabled at (367): [<ffffffff810fbb34>] vprintk_emit+0x124/0x320
<4>[    1.464252] hardirqs last disabled at (368): [<ffffffff810019b0>] trace_hardirqs_off_thunk+0x1a/0x1c
<4>[    1.464287] softirqs last  enabled at (0): [<ffffffff81083644>] copy_process.part.6+0x504/0x2250
<4>[    1.464318] softirqs last disabled at (0): [<0000000000000000>]           (null)
<4>[    1.464347] WARNING: CPU: 0 PID: 1 at arch/x86/events/intel/core.c:4558 intel_pmu_init+0x11bf/0x13ca

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Petri Latvala <petri.latvala@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
I am not aware of what the consequences are of bumping this limit, so
please take the patch with a pinch of salt and more of a heads up!
-Chris
---
 arch/x86/include/asm/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8bdf74902293..ab4cf7c12c40 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -7,7 +7,7 @@
  */
 
 #define INTEL_PMC_MAX_GENERIC				       32
-#define INTEL_PMC_MAX_FIXED					3
+#define INTEL_PMC_MAX_FIXED					4
 #define INTEL_PMC_IDX_FIXED				       32
 
 #define X86_PMC_IDX_MAX					       64
-- 
2.19.1

