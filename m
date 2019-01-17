Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7048EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42676205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAQN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:29:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfAQN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:29:15 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HDT4iY137670
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:29:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2t7qs8j2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:29:13 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 13:29:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 13:29:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HDT82P852320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 13:29:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DCDAE053;
        Thu, 17 Jan 2019 13:29:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA903AE045;
        Thu, 17 Jan 2019 13:29:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Jan 2019 13:29:07 +0000 (GMT)
Date:   Thu, 17 Jan 2019 14:29:06 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/5] ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190116131527.2071570-3-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-3-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19011713-4275-0000-0000-0000030077C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011713-4276-0000-0000-0000380E9C86
Message-Id: <20190117132906.GB18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:15:20PM +0100, Arnd Bergmann wrote:
> The sys_ipc() and compat_ksys_ipc() functions are meant to only
> be used from the system call table, not called by another function.
> 
> Introduce ksys_*() interfaces for this purpose, as we have done
> for many other system calls.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/kernel/compat_linux.c |  2 +-
>  arch/s390/kernel/sys_s390.c     |  2 +-
>  include/linux/syscalls.h        |  4 ++++
>  ipc/syscall.c                   | 20 ++++++++++++++++----
>  4 files changed, 22 insertions(+), 6 deletions(-)

The patch below is needed as compile fix (allnoconfig).
I will add this to your patch, no resend needed.

diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 6aa8fe00b39e..fd0cbbed4d9f 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -58,6 +58,7 @@ SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
 	return error;
 }
 
+#ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
  */
@@ -76,6 +77,7 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
 	 */
 	return ksys_ipc(call, first, second, third, ptr, third);
 }
+#endif /* CONFIG_SYSVIPC */
 
 SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
 {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ab9d0e3c6d50..ad016a7db0ea 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -366,7 +366,7 @@ COND_SYSCALL(kexec_file_load);
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
 COND_SYSCALL(s390_pci_mmio_write);
-COND_SYSCALL_COMPAT(s390_ipc);
+COND_SYSCALL(s390_ipc);
 
 /* powerpc */
 COND_SYSCALL(rtas);

