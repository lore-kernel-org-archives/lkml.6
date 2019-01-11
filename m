Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5843DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D9320872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfAKQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:07:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728498AbfAKQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:07:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BG5mwT041711
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:07:42 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxx9w8fcx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:07:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 11 Jan 2019 16:07:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 16:07:13 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BG7C0x63242364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 16:07:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D453EA4059;
        Fri, 11 Jan 2019 16:07:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC09A404D;
        Fri, 11 Jan 2019 16:07:12 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.97.20])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 16:07:12 +0000 (GMT)
Date:   Fri, 11 Jan 2019 17:07:11 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1] s390/smp: Fix calling smp_call_ipl_cpu() from ipl
 CPU
In-Reply-To: <20190111141822.17262-1-david@redhat.com>
References: <20190111141822.17262-1-david@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19011116-0008-0000-0000-000002AF93D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011116-0009-0000-0000-0000221B9E94
Message-Id: <20190111170711.21059fe7@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 15:18:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> When calling smp_call_ipl_cpu() from the IPL CPU, we will try to read
> from pcpu_devices->lowcore. However, due to prefixing, that will result
> in reading from absolute address 0 on that CPU. We have to go via the
> actual lowcore instead.
> 
> This means that right now, we will read lc->nodat_stack == 0 and
> therfore work on a very wrong stack.
> 
> This BUG essentially broke rebooting under QEMU TCG (which will report
> a low address protection exception). And checking under KVM, it is
> also broken under KVM. With 1 VCPU it can be easily triggered.
> 
> :/# echo 1 > /proc/sys/kernel/sysrq
> :/# echo b > /proc/sysrq-trigger
> [   28.476745] sysrq: SysRq : Resetting
> [   28.476793] Kernel stack overflow.
> [   28.476817] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476820] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476826] Krnl PSW : 0400c00180000000 0000000000115c0c (pcpu_delegate+0x12c/0x140)
> [   28.476861]            R:0 T:1 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   28.476863] Krnl GPRS: ffffffffffffffff 0000000000000000 000000000010dff8 0000000000000000
> [   28.476864]            0000000000000000 0000000000000000 0000000000ab7090 000003e0006efbf0
> [   28.476864]            000000000010dff8 0000000000000000 0000000000000000 0000000000000000
> [   28.476865]            000000007fffc000 0000000000730408 000003e0006efc58 0000000000000000
> [   28.476887] Krnl Code: 0000000000115bfe: 4170f000            la      %r7,0(%r15)
> [   28.476887]            0000000000115c02: 41f0a000            la      %r15,0(%r10)
> [   28.476887]           #0000000000115c06: e370f0980024        stg     %r7,152(%r15)
> [   28.476887]           >0000000000115c0c: c0e5fffff86e        brasl   %r14,114ce8
> [   28.476887]            0000000000115c12: 41f07000            la      %r15,0(%r7)
> [   28.476887]            0000000000115c16: a7f4ffa8            brc     15,115b66
> [   28.476887]            0000000000115c1a: 0707                bcr     0,%r7
> [   28.476887]            0000000000115c1c: 0707                bcr     0,%r7
> [   28.476901] Call Trace:
> [   28.476902] Last Breaking-Event-Address:
> [   28.476920]  [<0000000000a01c4a>] arch_call_rest_init+0x22/0x80
> [   28.476927] Kernel panic - not syncing: Corrupt kernel stack, can't continue.
> [   28.476930] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476932] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476932] Call Trace:
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/smp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index f82b3d3c36e2..be32dd0b4191 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -381,8 +381,13 @@ void smp_call_online_cpu(void (*func)(void *), void *data)
>   */
>  void smp_call_ipl_cpu(void (*func)(void *), void *data)
>  {
> +	struct lowcore *lc = pcpu_devices->lowcore;
> +
> +	if (pcpu_devices[0].address == stap())
> +		lc = &S390_lowcore;
> +
>  	pcpu_delegate(&pcpu_devices[0], func, data,
> -		      pcpu_devices->lowcore->nodat_stack);
> +		      lc->nodat_stack);
>  }
> 
>  int smp_find_processor_id(u16 address)

Uhh, subtle. With EDAT-1 this sort of works because the lowcore of CPU #0
is allocated in an area of the kernel address space that is backed with 1M
pages. It is nevertheless broken.

I have added
Fixes: 2f859d0dad81 ("s390/smp: reduce size of struct pcpu")                    
Cc: stable@vger.kernel.org # 4.0+                                               

and will queue the patch for the next pull. Thanks!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

