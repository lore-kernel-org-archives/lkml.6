Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312F2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312F2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeGEXMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:12:13 -0400
Received: from foss.arm.com ([217.140.101.70]:57166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753464AbeGEXMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:12:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CEFBED1;
        Thu,  5 Jul 2018 16:12:10 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A843F5BA;
        Thu,  5 Jul 2018 16:12:09 -0700 (PDT)
Date:   Thu, 5 Jul 2018 18:12:08 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tools include: Grab copies of arm64 dependent
 unistd.h files
Message-Id: <20180705181208.14cdf5756d319fd6ad8c6866@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will be used for generating the syscall id/string translation table.

Arm64's unistd.h simply #includes the asm-generic/unistd.h, so,
since we will want to know whether either change, we grab both:

  arch/arm64/include/uapi/asm/unistd.h

and

  include/uapi/asm-generic/unistd.h

Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Changes in V2:
 - used git format-patch --find-copies-harder to show identical copies
   are being made of the headers, for easier review.

 {arch => tools/arch}/arm64/include/uapi/asm/unistd.h | 0
 {include => tools/include}/uapi/asm-generic/unistd.h | 0
 tools/perf/check-headers.sh                          | 2 ++
 3 files changed, 2 insertions(+)
 copy {arch => tools/arch}/arm64/include/uapi/asm/unistd.h (100%)
 copy {include => tools/include}/uapi/asm-generic/unistd.h (100%)

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
similarity index 100%
copy from arch/arm64/include/uapi/asm/unistd.h
copy to tools/arch/arm64/include/uapi/asm/unistd.h
diff --git a/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
similarity index 100%
copy from include/uapi/asm-generic/unistd.h
copy to tools/include/uapi/asm-generic/unistd.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 10f333e2e825..814aaf269949 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -35,6 +35,7 @@ arch/s390/include/uapi/asm/ptrace.h
 arch/s390/include/uapi/asm/sie.h
 arch/arm/include/uapi/asm/kvm.h
 arch/arm64/include/uapi/asm/kvm.h
+arch/arm64/include/uapi/asm/unistd.h
 arch/alpha/include/uapi/asm/errno.h
 arch/mips/include/asm/errno.h
 arch/mips/include/uapi/asm/errno.h
@@ -53,6 +54,7 @@ include/uapi/asm-generic/errno.h
 include/uapi/asm-generic/errno-base.h
 include/uapi/asm-generic/ioctls.h
 include/uapi/asm-generic/mman-common.h
+include/uapi/asm-generic/unistd.h
 '
 
 check_2 () {
-- 
2.17.1

