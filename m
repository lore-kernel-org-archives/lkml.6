Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED683C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C582098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C582098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeISQM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:12:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731025AbeISQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:12:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JAaNtD065506
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:37:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mkmh10wha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:37:44 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 11:35:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 11:35:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JAZ1bS55509114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 10:35:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CE63A4051;
        Wed, 19 Sep 2018 13:34:46 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB092A404D;
        Wed, 19 Sep 2018 13:34:44 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.135])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Sep 2018 13:34:44 +0100 (BST)
Date:   Wed, 19 Sep 2018 13:34:57 +0300
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919100449.00006df9@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091910-0028-0000-0000-000002FB7231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091910-0029-0000-0000-000023B52DB5
Message-Id: <20180919103457.GA20545@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Wed, Sep 19, 2018 at 10:04:49AM +0100, Jonathan Cameron wrote:
> On Wed, 5 Sep 2018 18:59:18 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > All architecures use memblock for early memory management. There is no need
> > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Hi Mike,
> 
> A minor editing issue in here that is stopping boot on arm64 platforms with latest
> version of the mm tree.

Can you please try the following patch:


From 079bd5d24a01df3df9500d0a33d89cb9f7da4588 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Wed, 19 Sep 2018 13:29:27 +0300
Subject: [PATCH] of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config
 option

The removal of HAVE_MEMBLOCK configuration option, mistakenly dropped the
wrong #endif. This patch restores that #endif and removes the part that
should have been actually removed, starting from #else and up to the
correct #endif

Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 48314e9..bb532aa 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1119,6 +1119,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 #endif
 #ifndef MAX_MEMBLOCK_ADDR
 #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
+#endif
 
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
@@ -1175,26 +1176,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 	return memblock_reserve(base, size);
 }
 
-#else
-void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	WARN_ON(1);
-}
-
-int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
-{
-	return -ENOSYS;
-}
-
-int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
-					phys_addr_t size, bool nomap)
-{
-	pr_err("Reserved memory not supported, ignoring range %pa - %pa%s\n",
-		  &base, &size, nomap ? " (nomap)" : "");
-	return -ENOSYS;
-}
-#endif
-
 static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 {
 	return memblock_alloc(size, align);
-- 
2.7.4

 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 76c83c1..bd841bb 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1115,13 +1115,11 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  	return 1;
> >  }
> >  
> > -#ifdef CONFIG_HAVE_MEMBLOCK
> >  #ifndef MIN_MEMBLOCK_ADDR
> >  #define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
> >  #endif
> >  #ifndef MAX_MEMBLOCK_ADDR
> >  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> > -#endif
> 
> This isn't the right #endif. It is matching with the #ifndef MAX_MEMBLOCK_ADDR
> not the intented #ifdef CONFIG_HAVE_MEMBLOCK.
> 
> Now I haven't chased through the exact reason this is causing my acpi
> arm64 system not to boot on the basis it is obviously miss-matched anyway
> and I'm inherently lazy.  It's resulting in stubs replacing the following weak
> functions.
> 
> early_init_dt_add_memory_arch
> (this is defined elsewhere for some architectures but not arm)
> 
> early_init_dt_mark_hotplug_memory_arch
> (there is only one definition of this in the kernel so it doesn't
>  need to be weak or in the header etc).
> 
> early_init_dt_reserve_memory_arch
> (defined on mips but nothing else)
> 
> Taking out the right endif also lets you drop an #else removing some stub
> functions further down in here.
> 
> Nice cleanup in general btw.
> 
> Thanks,
> 
> Jonathan
> >  
> >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> >  {
> 

-- 
Sincerely yours,
Mike.

