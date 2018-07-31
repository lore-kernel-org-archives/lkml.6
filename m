Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362AF208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362AF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeGaHkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:40:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGaHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:40:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V61QPI2594192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:01:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V61QWw2594189;
        Mon, 30 Jul 2018 23:01:26 -0700
Date:   Mon, 30 Jul 2018 23:01:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9uvu7tz4ud3bxxfyxwryuz47@git.kernel.org>
Cc:     mpe@ellerman.id.au, ravi.bangoria@linux.vnet.ibm.com,
        mingo@kernel.org, namhyung@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        leitao@debian.org, acme@redhat.com, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          namhyung@kernel.org, mingo@kernel.org,
          brueckner@linux.vnet.ibm.com, leitao@debian.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de, tmricht@linux.vnet.ibm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers powerpc: Update asm/unistd.h copy
 to pick new
Git-Commit-ID: 7def16d1d2668a4a3663291c9ace307b81934704
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

Commit-ID:  7def16d1d2668a4a3663291c9ace307b81934704
Gitweb:     https://git.kernel.org/tip/7def16d1d2668a4a3663291c9ace307b81934704
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Jul 2018 11:48:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Jul 2018 11:51:13 -0300

tools headers powerpc: Update asm/unistd.h copy to pick new

The new 'io_pgetevents' syscall was wired up in PowerPC in the following
cset:

  b2f82565f2ca ("powerpc: Wire up io_pgetevents")

Update tools/arch/powerpc/ copy of the asm/unistd.h file so that 'perf
trace' on PowerPC gets it in its syscall table.

This elliminated the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-9uvu7tz4ud3bxxfyxwryuz47@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..985534d0b448 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
