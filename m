Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BC1C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E58D20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeGYWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:02:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbeGYWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:02:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKljjT500941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:47:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKliHa500938;
        Wed, 25 Jul 2018 13:47:44 -0700
Date:   Wed, 25 Jul 2018 13:47:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970@git.kernel.org>
Cc:     tglx@linutronix.de, mpe@ellerman.id.au, kim.phillips@arm.com,
        jolsa@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, brueckner@linux.vnet.ibm.com,
        acme@redhat.com, tmricht@linux.vnet.ibm.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com,
          ravi.bangoria@linux.vnet.ibm.com, peterz@infradead.org,
          tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
          acme@redhat.com, tglx@linutronix.de, mpe@ellerman.id.au,
          kim.phillips@arm.com, jolsa@redhat.com, mingo@kernel.org,
          namhyung@kernel.org
In-Reply-To: <20180706163434.1b64ffbcc0284fb79982f53b@arm.com>
References: <20180706163434.1b64ffbcc0284fb79982f53b@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include: Grab copies of arm64 dependent
 unistd.h files
Git-Commit-ID: 34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
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

Commit-ID:  34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
Gitweb:     https://git.kernel.org/tip/34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 6 Jul 2018 16:34:34 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:52:39 -0300

tools include: Grab copies of arm64 dependent unistd.h files

Will be used for generating the syscall id/string translation table.

The arm64 unistd.h file simply #includes the asm-generic/unistd.h, so,
since we will want to know whether either change, we grab both:

  arch/arm64/include/uapi/asm/unistd.h

and

  include/uapi/asm-generic/unistd.h

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180706163434.1b64ffbcc0284fb79982f53b@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {arch => tools/arch}/arm64/include/uapi/asm/unistd.h | 0
 {include => tools/include}/uapi/asm-generic/unistd.h | 0
 tools/perf/check-headers.sh                          | 2 ++
 3 files changed, 2 insertions(+)

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
