Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC714C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD78A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD78A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeKZSTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:19:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbeKZSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:19:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQ7Pfvp085306
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:25:59 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p0c2bguwx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:25:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 26 Nov 2018 07:25:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 07:25:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQ7Posj8716688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 07:25:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF6CC11C04C;
        Mon, 26 Nov 2018 07:25:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F12F11C04A;
        Mon, 26 Nov 2018 07:25:48 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.115])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Nov 2018 07:25:48 +0000 (GMT)
Date:   Mon, 26 Nov 2018 09:25:46 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        linux-sh@vger.kernel.org, linux-mm@kvack.org,
        Rich Felker <dalias@libc.org>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Vincent Chen <deanbo422@gmail.com>,
        Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Russell King <linux@armlinux.org.uk>,
        Mark Salter <msalter@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/5] arch: simplify several early memory allocations
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
 <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112607-4275-0000-0000-000002E6AA64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112607-4276-0000-0000-000037F3E223
Message-Id: <20181126072546.GB14863@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:03:55AM +0100, Christophe LEROY wrote:
> 
> 
> Le 25/11/2018 à 22:44, Mike Rapoport a écrit :
> >There are several early memory allocations in arch/ code that use
> >memblock_phys_alloc() to allocate memory, convert the returned physical
> >address to the virtual address and then set the allocated memory to zero.
> >
> >Exactly the same behaviour can be achieved simply by calling
> >memblock_alloc(): it allocates the memory in the same way as
> >memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
> >clears the allocated memory.
> >
> >Replace the longer sequence with a simpler call to memblock_alloc().
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/arm/mm/mmu.c                     |  4 +---
> >  arch/c6x/mm/dma-coherent.c            |  9 ++-------
> >  arch/nds32/mm/init.c                  | 12 ++++--------
> >  arch/powerpc/kernel/setup-common.c    |  4 ++--
> >  arch/powerpc/mm/pgtable_32.c          |  4 +---
> >  arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
> >  arch/powerpc/platforms/powernv/opal.c |  3 +--
> >  arch/sparc/kernel/prom_64.c           |  7 ++-----
> >  arch/sparc/mm/init_64.c               |  9 +++------
> >  arch/unicore32/mm/mmu.c               |  4 +---
> >  10 files changed, 18 insertions(+), 41 deletions(-)
> >
> [...]
> 
> >diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> >index bda3c6f..9931e68 100644
> >--- a/arch/powerpc/mm/pgtable_32.c
> >+++ b/arch/powerpc/mm/pgtable_32.c
> >@@ -50,9 +50,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> >  	if (slab_is_available()) {
> >  		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> >  	} else {
> >-		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> >-		if (pte)
> >-			clear_page(pte);
> >+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> 
> memblock_alloc() uses memset to zeroize the block.
> 
> clear_page() is more performant than memset().

As far as I can tell, the majority of the page table pages will be anyway
allocated with __get_free_page() so I think the performance loss here will
negligible.
 
> Christophe
> 
> [...]
> 

-- 
Sincerely yours,
Mike.

