Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30E220862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30E220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeKHKni convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:43:38 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:37392 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeKHKnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:43:37 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EF39F47483A9AF4715B2;
        Thu,  8 Nov 2018 09:10:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA81AXhP001727;
        Thu, 8 Nov 2018 09:10:34 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110809110079-9299472 ;
          Thu, 8 Nov 2018 09:11:00 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: [PATCH v2] x86/cpu: fix prototype warning
Date:   Thu, 8 Nov 2018 09:12:28 +0800
Message-Id: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-08 09:11:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-08 09:10:22
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wA81AXhP001727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following build warnings which because of missing
include file:

arch/x86/kernel/cpu/cacheinfo.c:647:6: warning: no previous prototype for ‘cacheinfo_amd_init_llc_id’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/cacheinfo.c:686:6: warning: no previous prototype for ‘cacheinfo_hygon_init_llc_id’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/scattered.c:37:6: warning: no previous prototype for ‘init_scattered_cpuid_features’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/scattered.c:60:5: warning: no previous prototype for ‘get_scattered_cpuid_leaf’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/topology.c:25:5: warning: no previous prototype for ‘detect_extended_topology_early’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/topology.c:57:5: warning: no previous prototype for ‘detect_extended_topology’ [-Wmissing-prototypes]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v2: merge the series into a single patch

---
 arch/x86/kernel/cpu/cacheinfo.c | 1 +
 arch/x86/kernel/cpu/scattered.c | 2 ++
 arch/x86/kernel/cpu/topology.c  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index dc1b934..5bafd93 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
+#include <asm/cacheinfo.h>
 
 #include "cpu.h"
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 772c219..5b6866f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -9,6 +9,8 @@
 
 #include <asm/apic.h>
 
+#include "cpu.h"
+
 struct cpuid_bit {
 	u16 feature;
 	u8 reg;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 71ca064..8f6c784 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -10,6 +10,8 @@
 #include <asm/pat.h>
 #include <asm/processor.h>
 
+#include "cpu.h"
+
 /* leaf 0xb SMT level */
 #define SMT_LEVEL	0
 
-- 
1.8.3.1

