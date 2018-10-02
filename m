Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF04C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2942089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2942089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJBQoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:44:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:44:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A0sOa1913184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:00:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A0seK1913181;
        Tue, 2 Oct 2018 03:00:54 -0700
Date:   Tue, 2 Oct 2018 03:00:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Message-ID: <tip-6265adb9726098b7f4f7ca70bc51992b25fdd9d6@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        peterz@infradead.org, hpa@zytor.com, jolsa@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        msys.mizuma@gmail.com, torvalds@linux-foundation.org,
        mingo@kernel.org, eranian@google.com, tglx@linutronix.de,
        m.mizuma@jp.fujitsu.com
Reply-To: acme@redhat.com, jolsa@redhat.com, hpa@zytor.com,
          peterz@infradead.org, vincent.weaver@maine.edu,
          alexander.shishkin@linux.intel.com, m.mizuma@jp.fujitsu.com,
          tglx@linutronix.de, eranian@google.com, mingo@kernel.org,
          msys.mizuma@gmail.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180910144750.6782-1-msys.mizuma@gmail.com>
References: <20180910144750.6782-1-msys.mizuma@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Use
 boot_cpu_data.phys_proc_id instead of hardcorded physical package ID 0
Git-Commit-ID: 6265adb9726098b7f4f7ca70bc51992b25fdd9d6
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

Commit-ID:  6265adb9726098b7f4f7ca70bc51992b25fdd9d6
Gitweb:     https://git.kernel.org/tip/6265adb9726098b7f4f7ca70bc51992b25fdd9d6
Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
AuthorDate: Mon, 10 Sep 2018 10:47:50 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:37:58 +0200

perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded physical package ID 0

Physical package id 0 doesn't always exist, we should use
boot_cpu_data.phys_proc_id here.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20180910144750.6782-1-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c117e3c7..53b981dcdb42 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(0);
+	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
 
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
