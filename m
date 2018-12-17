Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbeLQIJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:09:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbeLQIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:09:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBH83XE7136786
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 03:09:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pe7f1hkbc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 03:09:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Mon, 17 Dec 2018 08:09:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 08:08:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBH88rBq42336288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 08:08:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6D74A4054;
        Mon, 17 Dec 2018 08:08:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F40A405C;
        Mon, 17 Dec 2018 08:08:49 +0000 (GMT)
Received: from sathnaga86.in.ibm.com (unknown [9.193.110.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Dec 2018 08:08:49 +0000 (GMT)
Date:   Mon, 17 Dec 2018 13:38:46 +0530
From:   Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arch@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
        deepa.kernel@gmail.com
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18121708-0028-0000-0000-0000032B911E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121708-0029-0000-0000-000023E7E6ED
Message-Id: <20181217080846.GA28424@sathnaga86.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
> 
> The system call tables are in different format in 
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a 
> script and which'll generate uapi header file and 
> syscall table file.
> 
> syscall.tbl contains the list of available system 
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in 
> the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
> 	- Compat entry name, if required.
> 	- spu entry name, if required.
> 
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to 
> come up with a generic solution.
> 
> I have done the same support for work for alpha, 
> ia64, m68k, microblaze, mips, parisc, sh, sparc, 
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
> 
> https://github.com/frzkhn/system_call_table_generator/
> 
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to 
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in the
> syscall.tbl.
> 
> Changes since v4:
>  - DOTSYM macro removed for ppc32, which was causing
>    the compilation error.
> 
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.
> 
> Changes since v2:
>  - modified/optimized the syscall.tbl to avoid duplicate
>    for the spu entries.
>  - updated the syscalltbl.sh to meet the above point.
> 
> Changes since v1:
>  - optimized/updated the syscall table generation 
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
> 
> Firoz Khan (5):
>   powerpc: add __NR_syscalls along with NR_syscalls
>   powerpc: move macro definition from asm/systbl.h
>   powerpc: add system call table generation support
>   powerpc: split compat syscall table out from native table
>   powerpc: generate uapi header and system call table files

Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
both failed to apply series.

# git am mbox
Applying: powerpc: add __NR_syscalls along with NR_syscalls
Applying: powerpc: move macro definition from asm/systbl.h
Applying: powerpc: add system call table generation support
Applying: powerpc: split compat syscall table out from native table
Applying: powerpc: generate uapi header and system call table files
error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
Patch failed at 0005 powerpc: generate uapi header and system call table files
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.

# uname -r
4.20.0-rc2-gdd2690d2c

Looks like patch series needs a rebase against the latest kernel versions.


Thanks,
-Satheesh.

> 
>  arch/powerpc/Makefile                       |   3 +
>  arch/powerpc/include/asm/Kbuild             |   4 +
>  arch/powerpc/include/asm/syscall.h          |   3 +-
>  arch/powerpc/include/asm/systbl.h           | 396 --------------------------
>  arch/powerpc/include/asm/unistd.h           |   3 +-
>  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
>  arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
>  arch/powerpc/kernel/Makefile                |  10 -
>  arch/powerpc/kernel/entry_64.S              |   7 +-
>  arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  arch/powerpc/kernel/systbl.S                |  40 ++-
>  arch/powerpc/kernel/systbl_chk.c            |  60 ----
>  arch/powerpc/kernel/vdso.c                  |   7 +-
>  arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
>  17 files changed, 606 insertions(+), 898 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/systbl.h
>  create mode 100644 arch/powerpc/kernel/syscalls/Makefile
>  create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
>  delete mode 100644 arch/powerpc/kernel/systbl_chk.c
> 
> -- 
> 1.9.1
> 

