Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB53C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365CF214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365CF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeISQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727948AbeISQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:32:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JAt1hV031668
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:55:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mkky2txb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:55:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 11:55:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 11:55:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JAtGFv54460514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 10:55:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DD8311C04A;
        Wed, 19 Sep 2018 13:55:01 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C95D11C05C;
        Wed, 19 Sep 2018 13:54:59 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.135])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Sep 2018 13:54:59 +0100 (BST)
Date:   Wed, 19 Sep 2018 13:55:12 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
 <20180919100449.00006df9@huawei.com>
 <20180919103457.GA20545@rapoport-lnx>
 <20180919114507.000059f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919114507.000059f3@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091910-0008-0000-0000-0000027376B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091910-0009-0000-0000-000021DBCFBC
Message-Id: <20180919105511.GB20545@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:45:07AM +0100, Jonathan Cameron wrote:
> On Wed, 19 Sep 2018 13:34:57 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Wed, Sep 19, 2018 at 10:04:49AM +0100, Jonathan Cameron wrote:
> > > On Wed, 5 Sep 2018 18:59:18 +0300
> > > Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > >   
> > > > All architecures use memblock for early memory management. There is no need
> > > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>  
> > > 
> > > Hi Mike,
> > > 
> > > A minor editing issue in here that is stopping boot on arm64 platforms with latest
> > > version of the mm tree.  
> > 
> > Can you please try the following patch:
> > 
> > 
> > From 079bd5d24a01df3df9500d0a33d89cb9f7da4588 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Date: Wed, 19 Sep 2018 13:29:27 +0300
> > Subject: [PATCH] of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config
> >  option
> > 
> > The removal of HAVE_MEMBLOCK configuration option, mistakenly dropped the
> > wrong #endif. This patch restores that #endif and removes the part that
> > should have been actually removed, starting from #else and up to the
> > correct #endif
> > 
> > Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Hi Mike,
> 
> That's identical to the local patch I'm carrying to fix this so looks good to me.
> 
> For what it's worth given you'll probably fold this into the larger patch.
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Well, this is up to Andrew now, as the broken patch is already in the -mm
tree.
 
> Thanks for the quick reply.
> 
> Jonathan
> 
> > ---
> >  drivers/of/fdt.c | 21 +--------------------
> >  1 file changed, 1 insertion(+), 20 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 48314e9..bb532aa 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1119,6 +1119,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  #endif
> >  #ifndef MAX_MEMBLOCK_ADDR
> >  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> > +#endif
> >  
> >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> >  {
> > @@ -1175,26 +1176,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> >  	return memblock_reserve(base, size);
> >  }
> >  
> > -#else
> > -void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> > -{
> > -	WARN_ON(1);
> > -}
> > -
> > -int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> > -					phys_addr_t size, bool nomap)
> > -{
> > -	pr_err("Reserved memory not supported, ignoring range %pa - %pa%s\n",
> > -		  &base, &size, nomap ? " (nomap)" : "");
> > -	return -ENOSYS;
> > -}
> > -#endif
> > -
> >  static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> >  {
> >  	return memblock_alloc(size, align);
> 
> 

-- 
Sincerely yours,
Mike.

