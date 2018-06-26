Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE25626595
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE25626595
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeFZG4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:56:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFZG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:56:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6tnNJ1591515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:55:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6tnKJ1591510;
        Mon, 25 Jun 2018 23:55:49 -0700
Date:   Mon, 25 Jun 2018 23:55:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-adtgz6u3apd76tghiu9w0k19@git.kernel.org>
Cc:     mpe@ellerman.id.au, hpa@zytor.com, wangnan0@huawei.com,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, dsahern@gmail.com,
        jolsa@redhat.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        namhyung@kernel.org, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          adrian.hunter@intel.com, mathieu.desnoyers@efficios.com,
          boqun.feng@gmail.com, mpe@ellerman.id.au, hpa@zytor.com,
          brueckner@linux.vnet.ibm.com, wangnan0@huawei.com,
          dsahern@gmail.com, mingo@kernel.org, jolsa@redhat.com,
          tmricht@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include powerpc: Update
 arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
Git-Commit-ID: 801f5e1ac783df9fafff8899ef2d5511bd4dbdcb
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

Commit-ID:  801f5e1ac783df9fafff8899ef2d5511bd4dbdcb
Gitweb:     https://git.kernel.org/tip/801f5e1ac783df9fafff8899ef2d5511bd4dbdcb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 15 Jun 2018 12:04:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

tools include powerpc: Update arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall

This updates the tools/perf/ copy of the powerpc file used to generate
the syscall table file used to make 'perf trace' become aware of the new
'rseq' syscall, no matter in which system it gets built, i.e. older
systems where the syscalls are not available in the running kernel (via
tracefs) or in the system headers will still be aware of these
syscalls/.

From this commit:

  bb862b021d75 ("powerpc: Wire up restartable sequences system call")

Silencing this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-adtgz6u3apd76tghiu9w0k19@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index 389c36fd8299..ac5ba55066dd 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
