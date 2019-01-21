Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7014C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfAUJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:44:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbfAUJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:44:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0L9ff2Q076197
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:44:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5bnxr361-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:44:03 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 21 Jan 2019 09:44:01 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 09:43:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0L9huLD58261680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 09:43:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0810211C050;
        Mon, 21 Jan 2019 09:43:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A58D411C058;
        Mon, 21 Jan 2019 09:43:55 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Jan 2019 09:43:55 +0000 (GMT)
Date:   Mon, 21 Jan 2019 10:43:54 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 4/5] s390: autogenerate compat syscall wrappers
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190116131527.2071570-5-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-5-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19012109-0012-0000-0000-000002EAC46C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012109-0013-0000-0000-00002121EA87
Message-Id: <20190121094354.GA3932@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:15:22PM +0100, Arnd Bergmann wrote:
> Any system call that takes a pointer argument on s390 requires
> a wrapper function to do a 31-to-64 zero-extension, these are
> currently generated in arch/s390/kernel/compat_wrapper.c.
> 
> On arm64 and x86, we already generate similar wrappers for all
> system calls in the place of their definition, just for a different
> purpose (they load the arguments from pt_regs).
> 
> We can do the same thing here, by adding an asm/syscall_wrapper.h
> file with a copy of all the relevant macros to override the generic
> version. Besides the addition of the compat entry point, these also
> rename the entry points with a __s390_ or __s390x_ prefix, similar
> to what we do on arm64 and x86. This in turn requires renaming
> a few things, and adding a proper ni_syscall() entry point.
> 
> In order to still compile system call definitions that pass an
> loff_t argument, the __SC_COMPAT_CAST() macro checks for that
> and forces an -ENOSYS error, which was the best I could come up
> with. Those functions must obviously not get called from user
> space, but instead require hand-written compat_sys_*() handlers,
> which fortunately already exist.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig                       |   1 +
>  arch/s390/include/asm/syscall_wrapper.h | 136 ++++++++++++++++++++++++
>  arch/s390/kernel/compat_wrapper.c       |  23 +---
>  arch/s390/kernel/entry.S                |   4 +-
>  arch/s390/kernel/sys_s390.c             |   5 +
>  5 files changed, 148 insertions(+), 21 deletions(-)
>  create mode 100644 arch/s390/include/asm/syscall_wrapper.h

This broke system call tracing. We also need the patch below. If there
aren't any objections this should be added to Martin's 'compat' branch.

From 71880dcdc62e2f89dc206a4e46c1c60e59ce3b0d Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 21 Jan 2019 10:30:44 +0100
Subject: [PATCH] s390: fix system call tracing

When converting to autogenerated compat syscall wrappers all system
call entry points got a different symbol name: they all got a __s390x_
prefix.

This caused breakage with system call tracing, since an appropriate
arch_syscall_match_sym_name() was not provided. Add this function, and
while at it also add code to avoid compat system call tracing. s390
has different system call tables for native 64 bit system calls and
compat system calls. This isn't really supported in the common
code. However there are hardly any compat binaries left, therefore
just ignore compat system calls, like x86 and arm64 also do for the
same reason.

Fixes: aa0d6e70d3b3 ("s390: autogenerate compat syscall wrappers")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/ftrace.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 8ea270fdc7fb..1e14341201c5 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -81,5 +81,26 @@ static inline void ftrace_generate_call_insn(struct ftrace_insn *insn,
 #endif
 }
 
+/*
+ * Even though the system call numbers are identical for s390/s390x a
+ * different system call table is used for compat tasks. This may lead
+ * to e.g. incorrect or missing trace event sysfs files.
+ * Therefore simply do not trace compat system calls at all.
+ * See kernel/trace/trace_syscalls.c.
+ */
+#define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
+static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
+{
+	return is_compat_task();
+}
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	/* skip __s390x_ prefix */
+	return !strcmp(sym + 8, name);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_FTRACE_H */
-- 
2.16.4

