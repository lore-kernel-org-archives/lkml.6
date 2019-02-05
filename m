Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E12020844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBEDwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:52:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfBEDwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:52:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x153mQbq108789
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 22:52:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qexuy8253-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:52:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Tue, 5 Feb 2019 03:52:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 03:52:16 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x153qFc747513606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 03:52:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25C3DAE04D;
        Tue,  5 Feb 2019 03:52:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3DFAE056;
        Tue,  5 Feb 2019 03:52:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 03:52:14 +0000 (GMT)
Received: from townsend.localnet (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 650CEA01B6;
        Tue,  5 Feb 2019 14:52:13 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Balbir Singh <bsingharora@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/npu: Remove redundant change_pte() hook
Date:   Tue, 05 Feb 2019 14:52:13 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20190131171106.GD19324@redhat.com>
References: <20190131103022.10218-1-peterx@redhat.com> <20190131171106.GD19324@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19020503-0008-0000-0000-000002BC15A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020503-0009-0000-0000-0000222815E9
Message-Id: <3013350.qntrAZtlsQ@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=52 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=875 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 31 January 2019 12:11:06 PM AEDT Andrea Arcangeli wrote:
> On Thu, Jan 31, 2019 at 06:30:22PM +0800, Peter Xu wrote:
> > The change_pte() notifier was designed to use as a quick path to
> > update secondary MMU PTEs on write permission changes or PFN changes.
> > For KVM, it could reduce the vm-exits when vcpu faults on the pages
> > that was touched up by KSM.  It's not used to do cache invalidations,
> > for example, if we see the notifier will be called before the real PTE
> > update after all (please see set_pte_at_notify that set_pte_at was
> > called later).

Thanks for the fixup. I didn't realise that invalidate_range() always gets 
called but I now see that is the case so this change looks good to me as well.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

> > All the necessary cache invalidation should all be done in
> > invalidate_range() already.
> > 
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Paul Mackerras <paulus@samba.org>
> > CC: Michael Ellerman <mpe@ellerman.id.au>
> > CC: Alistair Popple <alistair@popple.id.au>
> > CC: Alexey Kardashevskiy <aik@ozlabs.ru>
> > CC: Mark Hairgrove <mhairgrove@nvidia.com>
> > CC: Balbir Singh <bsingharora@gmail.com>
> > CC: David Gibson <david@gibson.dropbear.id.au>
> > CC: Andrea Arcangeli <aarcange@redhat.com>
> > CC: Jerome Glisse <jglisse@redhat.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> >  arch/powerpc/platforms/powernv/npu-dma.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> 
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> 
> It doesn't make sense to implement change_pte as an invalidate,
> change_pte is not compulsory to implement so if one wants to have
> invalidates only, change_pte method shouldn't be implemented in the
> first place and the common code will guarantee to invoke the range
> invalidates instead.
> 
> Currently the whole change_pte optimization is effectively disabled as
> noted in past discussions with Jerome (because of the range
> invalidates that always surrounds it), so we need to revisit the whole
> change_pte logic and decide it to re-enable it or to drop it as a
> whole, but in the meantime it's good to cleanup spots like below that
> should leave change_pte alone.
> 
> There are several examples of mmu_notifiers_ops in the kernel that
> don't implement change_pte, in fact it's the majority. Of all mmu
> notifier users, only nv_nmmu_notifier_ops, intel_mmuops_change and
> kvm_mmu_notifier_ops implements change_pte and as Peter found out by
> source review nv_nmmu_notifier_ops, intel_mmuops_change are wrong
> about it and should stop implementing it as an invalidate.
> 
> In short change_pte is only implemented correctly from KVM which can
> really updates the spte and flushes the TLB but the spte update
> remains and could avoid a vmexit if we figure out how to re-enable the
> optimization safely (the TLB fill after change_pte in KVM EPT/shadow
> secondary MMU will be looked up by the CPU in hardware).
> 
> If change_pte is implemented, it should update the mapping like KVM
> does and not do an invalidate.
> 
> Thanks,
> Andrea
> 
> > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c
> > b/arch/powerpc/platforms/powernv/npu-dma.c index
> > 3f58c7dbd581..c003b29d870e 100644
> > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > @@ -917,15 +917,6 @@ static void pnv_npu2_mn_release(struct mmu_notifier
> > *mn,> 
> >  	mmio_invalidate(npu_context, 0, ~0UL);
> >  
> >  }
> > 
> > -static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
> > -				struct mm_struct *mm,
> > -				unsigned long address,
> > -				pte_t pte)
> > -{
> > -	struct npu_context *npu_context = mn_to_npu_context(mn);
> > -	mmio_invalidate(npu_context, address, PAGE_SIZE);
> > -}
> > -
> > 
> >  static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
> >  
> >  					struct mm_struct *mm,
> >  					unsigned long start, unsigned long end)
> > 
> > @@ -936,7 +927,6 @@ static void pnv_npu2_mn_invalidate_range(struct
> > mmu_notifier *mn,> 
> >  static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
> >  
> >  	.release = pnv_npu2_mn_release,
> > 
> > -	.change_pte = pnv_npu2_mn_change_pte,
> > 
> >  	.invalidate_range = pnv_npu2_mn_invalidate_range,
> >  
> >  };


