Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07CEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8972620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfAQNbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:31:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbfAQNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:31:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HDTbjt049430
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:31:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2r3fyd77-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:31:22 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 13:31:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 13:31:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HDVGfR37945534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 13:31:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA024AE057;
        Thu, 17 Jan 2019 13:31:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96646AE045;
        Thu, 17 Jan 2019 13:31:16 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 13:31:16 +0000 (GMT)
Date:   Thu, 17 Jan 2019 14:31:15 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 4/5] s390: autogenerate compat syscall wrappers
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190116131527.2071570-5-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-5-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19011713-0028-0000-0000-0000033A74A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011713-0029-0000-0000-000023F79FD3
Message-Id: <20190117133115.GC18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=862 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170099
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

The patch below is needed as compile fix (allnoconfig).
I will add this to your patch, no resend needed.

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 27ebe871692f..873e7a7794b3 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -106,11 +106,10 @@
 	asmlinkage long __s390x_sys_##sname(void)
 
 #define COND_SYSCALL(name)						\
-	cond_syscall(__s390x_sys_##name)				\
-	cond_syscall(__s390_sys_##name)
+	cond_syscall(__s390x_sys_##name)
 
 #define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers);
+	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
 
 #endif /* CONFIG_COMPAT */
 

