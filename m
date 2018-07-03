Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED1DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580A9241E8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580A9241E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeGCPD1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932273AbeGCPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:03:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63Ewn6B055830
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 11:03:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0b52gyrn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:03:25 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 16:03:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 16:03:20 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63F3JN541156668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:03:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0880AE058;
        Tue,  3 Jul 2018 18:03:21 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0268DAE051;
        Tue,  3 Jul 2018 18:03:21 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jul 2018 18:03:20 +0100 (BST)
Date:   Tue, 3 Jul 2018 18:03:16 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k/page_no.h: force __va argument to be unsigned
 long
References: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530613795-6956-3-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703142054.GL16767@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703142054.GL16767@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070315-4275-0000-0000-00000294BF27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070315-4276-0000-0000-0000379C3EA1
Message-Id: <20180703150315.GC4809@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 04:20:54PM +0200, Michal Hocko wrote:
> On Tue 03-07-18 13:29:54, Mike Rapoport wrote:
> > Add explicit casting to unsigned long to the __va() parameter
> 
> Why is this needed?

To make it consitent with other architecures and asm-generic :)

But more importantly, __memblock_free_late() passes u64 to page_to_pfn().
On m68k-nommu this results in:

  CC      mm/nobootmem.o
In file included from
arch/m68k/include/asm/page.h:49,
                 from
arch/m68k/include/asm/thread_info.h:6,
                 from
include/linux/thread_info.h:38,
                 from
include/asm-generic/preempt.h:5,
                 from ./arch/m68k/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:81,
                 from include/linux/spinlock.h:51,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from mm/memblock.c:14:
mm/memblock.c: In function '__memblock_free_late':
arch/m68k/include/asm/page_no.h:21:23: warning:
cast to pointer from integer of different size [-Wint-to-pointer-cast]
 #define __va(paddr)  ((void *)(paddr))
                       ^
arch/m68k/include/asm/page_no.h:26:57: note: in
definition of macro 'virt_to_page'
 #define virt_to_page(addr) (mem_map + (((unsigned long)(addr)-PAGE_OFFSET)
>> PAGE_SHIFT))
                                                         ^~~~
arch/m68k/include/asm/page_no.h:24:26: note: in
expansion of macro '__va'
 #define pfn_to_virt(pfn) __va((pfn) << PAGE_SHIFT)
                          ^~~~
arch/m68k/include/asm/page_no.h:29:39: note: in
expansion of macro 'pfn_to_virt'
 #define pfn_to_page(pfn) virt_to_page(pfn_to_virt(pfn))
                                       ^~~~~~~~~~~
mm/memblock.c:1473:24: note: in expansion of macro
'pfn_to_page'
   __free_pages_bootmem(pfn_to_page(cursor), cursor, 0);
                        ^~~~~~~~~~~

 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  arch/m68k/include/asm/page_no.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> > index e644c4d..6bbe520 100644
> > --- a/arch/m68k/include/asm/page_no.h
> > +++ b/arch/m68k/include/asm/page_no.h
> > @@ -18,7 +18,7 @@ extern unsigned long memory_end;
> >  #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
> >  
> >  #define __pa(vaddr)		((unsigned long)(vaddr))
> > -#define __va(paddr)		((void *)(paddr))
> > +#define __va(paddr)		((void *)((unsigned long)(paddr)))
> >  
> >  #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
> >  #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

