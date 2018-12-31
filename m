Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7BC2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbeLaUIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:08:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbeLaUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 15:08:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBVK8Yh0021620
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 15:08:43 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pqkmj5c22-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 15:08:42 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 31 Dec 2018 20:08:41 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 20:08:39 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBVK8cBb22675546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 20:08:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91138B2065;
        Mon, 31 Dec 2018 20:08:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CFDEB2066;
        Mon, 31 Dec 2018 20:08:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 31 Dec 2018 20:08:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DC5AD16C5EDA; Mon, 31 Dec 2018 12:08:54 -0800 (PST)
Date:   Mon, 31 Dec 2018 12:08:54 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>, Willy Tarreau <w@1wt.eu>,
        mingo@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Reply-To: paulmck@linux.ibm.com
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
 <20181230070846.GA17139@1wt.eu>
 <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18123120-0060-0000-0000-000002F103A2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01139852; UDB=6.00593102; IPR=6.00920063;
 MB=3.00024916; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-31 20:08:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123120-0061-0000-0000-000047C083ED
Message-Id: <20181231200854.GS4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 09:40:20PM -1000, Joey Pabalinas wrote:
> On Sun, Dec 30, 2018 at 08:08:46AM +0100, Willy Tarreau wrote:
> > Definitely! Same, I won't emit a patch just for this, Paul already queued it.
> 
> Yeah, not that big a deal :)
> 
> Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

But as long as I am rebasing to add the Reviewed-by, might as well
update the others.

The English rules for capitalization and lists are baroque and completely
unsuited to word processors ("If any list item is longer than one line,
capitalize all the items."), but in this case each item has multiple
sentences, so it makes sense to capitalize.

Please see below for the updated commit, and thank you all!

And Happy New Year!!!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit c12cd600666874ef43f2c555391dce47fe60fcd9
Author: Willy Tarreau <w@1wt.eu>
Date:   Sat Dec 29 19:02:18 2018 +0100

    rcutorture/nolibc: Add a bit of documentation to explain how to use nolibc
    
    Ingo rightfully asked for a bit more documentation in the nolibc header,
    so this patch adds some explanation about its purpose, how it's made, and
    how to use it.
    
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Willy Tarreau <w@1wt.eu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
    Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
index cfbbbad4bca4..1708e9f9f8aa 100644
--- a/tools/testing/selftests/rcutorture/bin/nolibc.h
+++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
@@ -3,7 +3,85 @@
  * Copyright (C) 2017-2018 Willy Tarreau <w@1wt.eu>
  */
 
-/* some archs (at least aarch64) don't expose the regular syscalls anymore by
+/*
+ * This file is designed to be used as a libc alternative for minimal programs
+ * with very limited requirements. It consists of a small number of syscall and
+ * type definitions, and the minimal startup code needed to call main().
+ * All syscalls are declared as static functions so that they can be optimized
+ * away by the compiler when not used.
+ *
+ * Syscalls are split into 3 levels:
+ *   - The lower level is the arch-specific syscall() definition, consisting in
+ *     assembly code in compound expressions. These are called my_syscall0() to
+ *     my_syscall6() depending on the number of arguments. The MIPS
+ *     implementation is limited to 5 arguments. All input arguments are cast
+ *     to a long stored in a register. These expressions always return the
+ *     syscall's return value as a signed long value which is often either a
+ *     pointer or the negated errno value.
+ *
+ *   - The second level is mostly architecture-independent. It is made of
+ *     static functions called sys_<name>() which rely on my_syscallN()
+ *     depending on the syscall definition. These functions are responsible
+ *     for exposing the appropriate types for the syscall arguments (int,
+ *     pointers, etc) and for setting the appropriate return type (often int).
+ *     A few of them are architecture-specific because the syscalls are not all
+ *     mapped exactly the same among architectures. For example, some archs do
+ *     not implement select() and need pselect6() instead, so the sys_select()
+ *     function will have to abstract this.
+ *
+ *   - The third level is the libc call definition. It exposes the lower raw
+ *     sys_<name>() calls in a way that looks like what a libc usually does,
+ *     takes care of specific input values, and of setting errno upon error.
+ *     There can be minor variations compared to standard libc calls. For
+ *     example the open() call always takes 3 args here.
+ *
+ * The errno variable is declared static and unused. This way it can be
+ * optimized away if not used. However this means that a program made of
+ * multiple C files may observe different errno values (one per C file). For
+ * the type of programs this project targets it usually is not a problem. The
+ * resulting program may even be reduced by defining the NOLIBC_IGNORE_ERRNO
+ * macro, in which case the errno value will never be assigned.
+ *
+ * Some stdint-like integer types are defined. These are valid on all currently
+ * supported architectures, because signs are enforced, ints are assumed to be
+ * 32 bits, longs the size of a pointer and long long 64 bits. If more
+ * architectures have to be supported, this may need to be adapted.
+ *
+ * Some macro definitions like the O_* values passed to open(), and some
+ * structures like the sys_stat struct depend on the architecture.
+ *
+ * The definitions start with the architecture-specific parts, which are picked
+ * based on what the compiler knows about the target architecture, and are
+ * completed with the generic code. Since it is the compiler which sets the
+ * target architecture, cross-compiling normally works out of the box without
+ * having to specify anything.
+ *
+ * Finally some very common libc-level functions are provided. It is the case
+ * for a few functions usually found in string.h, ctype.h, or stdlib.h. Nothing
+ * is currently provided regarding stdio emulation.
+ *
+ * The macro NOLIBC is always defined, so that it is possible for a program to
+ * check this macro to know if it is being built against and decide to disable
+ * some features or simply not to include some standard libc files.
+ *
+ * Ideally this file should be split in multiple files for easier long term
+ * maintenance, but provided as a single file as it is now, it's quite
+ * convenient to use. Maybe some variations involving a set of includes at the
+ * top could work.
+ *
+ * A simple static executable may be built this way :
+ *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+ *            -static -include nolibc.h -lgcc -o hello hello.c
+ *
+ * A very useful calling convention table may be found here :
+ *      http://man7.org/linux/man-pages/man2/syscall.2.html
+ *
+ * This doc is quite convenient though not necessarily up to date :
+ *      https://w3challs.com/syscalls/
+ *
+ */
+
+/* Some archs (at least aarch64) don't expose the regular syscalls anymore by
  * default, either because they have an "_at" replacement, or because there are
  * more modern alternatives. For now we'd rather still use them.
  */
@@ -19,18 +97,6 @@
 
 #define NOLIBC
 
-/* Build a static executable this way :
- *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
- *            -static -include nolibc.h -lgcc -o hello hello.c
- *
- * Useful calling convention table found here :
- *      http://man7.org/linux/man-pages/man2/syscall.2.html
- *
- * This doc is even better :
- *      https://w3challs.com/syscalls/
- */
-
-
 /* this way it will be removed if unused */
 static int errno;
 

