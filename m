Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469BEC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4B220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfAUL7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:59:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728315AbfAUL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:59:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LBvXSw031021
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:59:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5bg760vd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:59:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 21 Jan 2019 11:59:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 11:59:08 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LBx7cO61276300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 11:59:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F0614C046;
        Mon, 21 Jan 2019 11:59:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47E574C040;
        Mon, 21 Jan 2019 11:59:06 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Jan 2019 11:59:06 +0000 (GMT)
Date:   Mon, 21 Jan 2019 12:59:05 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
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
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers
 everywhere
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-15-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-15-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19012111-0008-0000-0000-000002B3D9E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012111-0009-0000-0000-00002220010E
Message-Id: <20190121115905.GC4020@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=696 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:18:20PM +0100, Arnd Bergmann wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
> 
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/include/asm/unistd.h         | 4 ----
>  arch/alpha/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/ia64/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/parisc/include/asm/unistd.h        | 3 ---
>  arch/parisc/kernel/syscalls/syscall.tbl | 4 ++++
>  arch/s390/include/asm/unistd.h          | 3 ---
>  arch/s390/kernel/syscalls/syscall.tbl   | 3 +++
>  arch/sh/kernel/syscalls/syscall.tbl     | 4 ++++
>  arch/sparc/include/asm/unistd.h         | 5 -----
>  arch/sparc/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/xtensa/kernel/syscalls/syscall.tbl | 1 +
>  12 files changed, 28 insertions(+), 15 deletions(-)

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

