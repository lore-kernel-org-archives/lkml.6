Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4943C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB3E2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB3E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeIFKEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:04:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbeIFKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:04:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w865SpQ6102466
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 01:30:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mathwfd02-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:30:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 06:30:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 06:30:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w865UEu846137566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 05:30:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AB7D4205C;
        Thu,  6 Sep 2018 08:30:08 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC8B342041;
        Thu,  6 Sep 2018 08:30:07 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 08:30:07 +0100 (BST)
Date:   Thu, 6 Sep 2018 08:30:11 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "Fancer's opinion" <fancer.lancer@gmail.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] mips: switch to NO_BOOTMEM
References: <1535356775-20396-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180830214856.cwqyjksz36ujxydm@pburton-laptop>
 <20180831211747.GA31133@rapoport-lnx>
 <20180905174709.pz2rmyt2oob6bxpz@pburton-laptop>
 <20180905183751.GA4518@rapoport-lnx>
 <CAMPMW8rJ4qC8iaRa0jTjgZmiYf51AaricrgCg1aNx-Ez6=zT0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMPMW8rJ4qC8iaRa0jTjgZmiYf51AaricrgCg1aNx-Ez6=zT0g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090605-0016-0000-0000-000002010A2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090605-0017-0000-0000-00003257B1A6
Message-Id: <20180906053011.GA27492@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Wed, Sep 05, 2018 at 11:09:13PM +0300, Fancer's opinion wrote:
> Hello, Mike
> Could you CC me next time you send that larger patchset?

The larger patchset is here:

https://lore.kernel.org/lkml/1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com/
 
> -Sergey
> 
> 
> On Wed, Sep 5, 2018 at 9:38 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
>     On Wed, Sep 05, 2018 at 10:47:10AM -0700, Paul Burton wrote:
>     > Hi Mike,
>     >
>     > On Sat, Sep 01, 2018 at 12:17:48AM +0300, Mike Rapoport wrote:
>     > > On Thu, Aug 30, 2018 at 02:48:57PM -0700, Paul Burton wrote:
>     > > > On Mon, Aug 27, 2018 at 10:59:35AM +0300, Mike Rapoport wrote:
>     > > > > MIPS already has memblock support and all the memory is already
>     registered
>     > > > > with it.
>     > > > >
>     > > > > This patch replaces bootmem memory reservations with memblock ones
>     and
>     > > > > removes the bootmem initialization.
>     > > > >
>     > > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>     > > > > ---
>     > > > >
>     > > > >  arch/mips/Kconfig                      |  1 +
>     > > > >  arch/mips/kernel/setup.c               | 89
>     +++++-----------------------------
>     > > > >  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
>     > > > >  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
>     > > > >  4 files changed, 33 insertions(+), 102 deletions(-)
>     > > >
>     > > > Thanks for working on this. Unfortunately it breaks boot for at least
>     a
>     > > > 32r6el_defconfig kernel on QEMU:
>     > > >
>     > > >   $ qemu-system-mips64el \
>     > > >     -M boston \
>     > > >     -kernel arch/mips/boot/vmlinux.gz.itb \
>     > > >     -serial stdio \
>     > > >     -append "earlycon=uart8250,mmio32,0x17ffe000,115200 console=
>     ttyS0,115200 debug memblock=debug mminit_loglevel=4"
>     > > >   [    0.000000] Linux version 4.19.0-rc1-00008-g82d0f342eecd
>     (pburton@pburton-laptop) (gcc version 8.1.0 (GCC)) #23 SMP Thu Aug 30
>     14:38:06 PDT 2018
>     > > >   [    0.000000] CPU0 revision is: 0001a900 (MIPS I6400)
>     > > >   [    0.000000] FPU revision is: 20f30300
>     > > >   [    0.000000] MSA revision is: 00000300
>     > > >   [    0.000000] MIPS: machine is img,boston
>     > > >   [    0.000000] Determined physical RAM map:
>     > > >   [    0.000000]  memory: 10000000 @ 00000000 (usable)
>     > > >   [    0.000000]  memory: 30000000 @ 90000000 (usable)
>     > > >   [    0.000000] earlycon: uart8250 at MMIO32 0x17ffe000 (options
>     '115200')
>     > > >   [    0.000000] bootconsole [uart8250] enabled
>     > > >   [    0.000000] memblock_reserve: [0x00000000-0x009a8fff]
>     setup_arch+0x224/0x718
>     > > >   [    0.000000] memblock_reserve: [0x01360000-0x01361ca7]
>     setup_arch+0x3d8/0x718
>     > > >   [    0.000000] Initrd not found or empty - disabling initrd
>     > > >   [    0.000000] memblock_virt_alloc_try_nid: 7336 bytes align=0x40
>     nid=-1 from=0x00000000 max_addr=0x00000000
>     early_init_dt_alloc_memory_arch+0x20/0x2c
>     > > >   [    0.000000] memblock_reserve: [0xbfffe340-0xbfffffe7]
>     memblock_virt_alloc_internal+0x120/0x1ec
>     > > >   <hang>
>     > > >
>     > > > It looks like we took a TLB store exception after calling memset()
>     with
>     > > > a bogus address from memblock_virt_alloc_try_nid() or something
>     inlined
>     > > > into it.
>     > >
>     > > Memblock tries to allocate from the top and the resulting address ends
>     up
>     > > in the high memory.
>     > >
>     > > With the hunk below I was able to get to "VFS: Cannot open root device"
>     > >
>     > > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>     > > index 4114d3c..4a9b0f7 100644
>     > > --- a/arch/mips/kernel/setup.c
>     > > +++ b/arch/mips/kernel/setup.c
>     > > @@ -577,6 +577,8 @@ static void __init bootmem_init(void)
>     > >          * Reserve initrd memory if needed.
>     > >          */
>     > >         finalize_initrd();
>     > > +
>     > > +       memblock_set_bottom_up(true);
>     > >  }
>     >
>     > That does seem to fix it, and some basic tests are looking good.
> 
>     The bottom up mode has the downside of allocating memory below
>     MAX_DMA_ADDRESS.
> 
>     I'd like to check if memblock_set_current_limit(max_low_pfn) will also fix
>     the issue, at least with the limited tests I can do with qemu.
> 
>     > I notice you submitted this as part of your larger series to remove
>     > bootmem - are you still happy for me to take this one through mips-next?
> 
>     Sure, I've just posted it as the part of the larger series for
>     completeness.
> 
>     I believe that in the next few days I'll be able to verify whether
>     memblock_set_current_limit() can be used instead of
>     memblock_set_bottom_up() and I'll resend the patch then.
> 
>     > Thanks,
>     >     Paul
>     >
> 
>     --
>     Sincerely yours,
>     Mike.
> 
> 

-- 
Sincerely yours,
Mike.

