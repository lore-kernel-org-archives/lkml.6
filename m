Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99077206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99077206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIFPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:24:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbeIFPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:24:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86AjTUX017025
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 06:49:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mb1ckuuu3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:49:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Thu, 6 Sep 2018 11:49:42 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 11:49:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86AnceM34865332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 10:49:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31D6842041;
        Thu,  6 Sep 2018 13:49:32 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFAA642049;
        Thu,  6 Sep 2018 13:49:31 +0100 (BST)
Received: from [9.152.212.144] (unknown [9.152.212.144])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 13:49:31 +0100 (BST)
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
References: <20180824133206.4218c2e5@canb.auug.org.au>
 <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <20180824204756.e787765461975cd1e27502dc@kernel.org>
 <20180824224211.2934d7c0@canb.auug.org.au>
 <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
 <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
Date:   Thu, 6 Sep 2018 12:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090610-0016-0000-0000-000002013062
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090610-0017-0000-0000-00003257D9F3
Message-Id: <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2018 02:43, Masami Hiramatsu wrote:
> I recently added a gcov profiling for ftrace, following Documentation/dev-tools/gcov.rst.
> 6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> 
> and it caused may orphan section warnings/errors on arm and powerpc64.
> We also found same error happens when CONFIG_GCOV_PROFILE_ALL=y.
> So I guess GCOV kernel subsystem broken in some environment.

I can confirm that these issues are unrelated to your commit which only
made the existing problems visible by enabling gcov-kernel profiling for
allyesconfig builds. Both problems already exist in v4.18 and likely
earlier versions.

Problem 1: link failure on arm
(https://lkml.org/lkml/2018/8/24/345)

The root cause appears to be that the arm linker script only partially
discards unneeded sections generated by the compiler when gcov-kernel
profiling is enabled.

Problem 2: linker warnings on powerpc
(https://lkml.org/lkml/2018/8/24/72)

CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y adds compiler flag
-fdata-sections. This option causes GCC to create separate data sections
for data objects, including those generated by GCC internally for gcov
profiling. Since the name of these internal data objects starts with a .
(.LPBX0, .LPBX1), the resulting section name starts with "data..". As
section names starting with "data.." are used for specific purposes in
the Linux kernel, the linker script does not automatically handle them,
resulting in the "orphan section" linker warnings.

I've attached a quick fix that should address both problems. I'd
appreciate if this patch could get some testing before I post proper fix
patches.

-- >8 --
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index ae5fdff18406..2ca33277a28b 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -48,6 +48,7 @@

 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
+		*(.ARM.exidx.text.exit)					\
 		*(.ARM.extab.exit.text)					\
 		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
 		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..5cf3b90c5592 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -68,7 +68,7 @@
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
@@ -613,7 +613,7 @@

 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
-	*(.fini_array)							\
+	*(.fini_array .fini_array.*)					\
 	*(.dtors)							\
 	MEM_DISCARD(exit.data*)						\
 	MEM_DISCARD(exit.rodata*)
-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

