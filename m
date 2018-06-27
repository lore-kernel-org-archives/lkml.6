Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B72619B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B72619B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeF0KFW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932089AbeF0KFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:05:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R9xI7N037429
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 06:05:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jv76w3snj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 06:05:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 11:05:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 11:05:12 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RA5BFm32309378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 10:05:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9645A4053;
        Wed, 27 Jun 2018 11:05:02 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C13C4A405D;
        Wed, 27 Jun 2018 11:05:01 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jun 2018 11:05:01 +0100 (BST)
Date:   Wed, 27 Jun 2018 13:05:08 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memblock: add missing include <linux/bootmem.h>
References: <20180622210542.2025-1-malat@debian.org>
 <20180625171513.31845-1-malat@debian.org>
 <20180625180717.GS28965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625180717.GS28965@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18062710-0016-0000-0000-000001E0A02A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062710-0017-0000-0000-00003234DE3E
Message-Id: <20180627100508.GB4291@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:07:17PM +0200, Michal Hocko wrote:
> On Mon 25-06-18 19:15:12, Mathieu Malaterre wrote:
> > Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > introduced two new function definitions:
> > 
> >   memblock_virt_alloc_try_nid_nopanic()
> >   memblock_virt_alloc_try_nid()
> > 
> > Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
> > introduced the following function definition:
> > 
> >   memblock_virt_alloc_try_nid_raw()
> > 
> > This commit adds an include of header file <linux/bootmem.h> to provide
> > the missing function prototypes. Silence the following gcc warning
> > (W=1):
> > 
> >   mm/memblock.c:1334:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_raw' [-Wmissing-prototypes]
> >   mm/memblock.c:1371:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_nopanic' [-Wmissing-prototypes]
> >   mm/memblock.c:1407:15: warning: no previous prototype for `memblock_virt_alloc_try_nid' [-Wmissing-prototypes]
> > 
> > It also adds #ifdef blockers to prevent compilation failure on mips/ia64
> > where CONFIG_NO_BOOTMEM=n. Because Makefile already does:
> > 
> >   obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
> > 
> > The #ifdef has been simplified from:
> > 
> >   #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
> > 
> > to simply:
> > 
> >   #if defined(CONFIG_NO_BOOTMEM)
> 
> Well, I would apreciate an explanation why do we need NO_BOOTMEM guard
> in the first place rather than why HAVE_MEMBLOCK is not needed.
> 
> > Suggested-by: Tony Luck <tony.luck@intel.com>
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> Anyway this looks better. I wish we can actually get rid of bootmem
> allocator which would simplify this as well but that is another topic.

There only 5 arches with bootmem left :)

I've started looking into it, but it goes slow :(
 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> > ---
> > v2: Simplify #ifdef
> > 
> >  mm/memblock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 03d48d8835ba..611a970ac902 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> > +#include <linux/bootmem.h>
> >  
> >  #include <asm/sections.h>
> >  #include <linux/io.h>
> > @@ -1224,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
> >  	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
> >  }
> >  
> > +#if defined(CONFIG_NO_BOOTMEM)
> >  /**
> >   * memblock_virt_alloc_internal - allocate boot memory block
> >   * @size: size of memory block to be allocated in bytes
> > @@ -1431,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
> >  	      (u64)max_addr);
> >  	return NULL;
> >  }
> > +#endif
> >  
> >  /**
> >   * __memblock_free_early - free boot memory block
> > -- 
> > 2.11.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

