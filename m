Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC28C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420AF206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420AF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeIFRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:49:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIFRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:49:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DDRhu304562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:13:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DDRlb304559;
        Thu, 6 Sep 2018 06:13:27 -0700
Date:   Thu, 6 Sep 2018 06:13:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5z7qw529sdebrn9y1xxqw9hf@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        dsahern@gmail.com
Reply-To: wangnan0@huawei.com, adrian.hunter@intel.com, hpa@zytor.com,
          dsahern@gmail.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Give precedence to bpf header dir
Git-Commit-ID: d35b168c3dcdf103c2b2d694ad8513a669781703
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

Commit-ID:  d35b168c3dcdf103c2b2d694ad8513a669781703
Gitweb:     https://git.kernel.org/tip/d35b168c3dcdf103c2b2d694ad8513a669781703
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 Aug 2018 23:53:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf bpf: Give precedence to bpf header dir

I need to check the need for $KERNEL_INC_OPTIONS when building eBPF
restricted C programs, for now just give precedence to
$PERF_BPF_INC_OPTIONS so that we can get a linux/socket.h usable
in eBPF programs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5z7qw529sdebrn9y1xxqw9hf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 19262f98cd4e..5b0b60f00275 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -19,7 +19,7 @@
 #define CLANG_BPF_CMD_DEFAULT_TEMPLATE				\
 		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
 		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
-		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS " \
+		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
 		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
