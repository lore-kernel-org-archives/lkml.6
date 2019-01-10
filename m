Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfAJUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:55:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730590AbfAJUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:55:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AKroPZ029166
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:55:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxa9x09vy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:55:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 10 Jan 2019 20:55:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 20:55:26 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AKtPK95439922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 20:55:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A06FAA4054;
        Thu, 10 Jan 2019 20:55:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48E49A405C;
        Thu, 10 Jan 2019 20:55:24 +0000 (GMT)
Received: from osiris (unknown [9.145.24.85])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Jan 2019 20:55:24 +0000 (GMT)
Date:   Thu, 10 Jan 2019 21:55:22 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        akpm@linux-foundation.org, deepa.kernel@gmail.com,
        ebiederm@xmission.com, firoz.khan@linaro.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 07/11] y2038: syscalls: rename y2038 compat syscalls
References: <20190110172216.313063-1-arnd@arndb.de>
 <20190110172216.313063-8-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190110172216.313063-8-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19011020-0012-0000-0000-000002E6217E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011020-0013-0000-0000-0000211D2918
Message-Id: <20190110205522.GC3676@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:22:12PM +0100, Arnd Bergmann wrote:
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index f84ea364a302..b3199a744731 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -20,7 +20,7 @@
>  10   common	unlink			sys_unlink			compat_sys_unlink
>  11   common	execve			sys_execve			compat_sys_execve
>  12   common	chdir			sys_chdir			compat_sys_chdir
> -13   32		time			-				compat_sys_time
> +13   32		time			-				sys_time32
>  14   common	mknod			sys_mknod			compat_sys_mknod
>  15   common	chmod			sys_chmod			compat_sys_chmod
>  16   32		lchown			-				compat_sys_s390_lchown16
> @@ -30,11 +30,11 @@
>  22   common	umount			sys_oldumount			compat_sys_oldumount
>  23   32		setuid			-				compat_sys_s390_setuid16
>  24   32		getuid			-				compat_sys_s390_getuid16
> -25   32		stime			-				compat_sys_stime
> +25   32		stime			-				sys_stime32
>  26   common	ptrace			sys_ptrace			compat_sys_ptrace
>  27   common	alarm			sys_alarm			sys_alarm
>  29   common	pause			sys_pause			sys_pause
> -30   common	utime			sys_utime			compat_sys_utime
> +30   common	utime			sys_utime			sys_utime32
...(and more)...

All of them need compat wrappers to clear the uppermost 33 bits of
user space pointers. I assume there is no new *32 system call which
takes u64/s64 arguments; so the pointers should be the only problem.

