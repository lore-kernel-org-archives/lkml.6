Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DA72083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WIy92CX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DA72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeHaL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:56:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54625 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeHaL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:56:44 -0400
Received: by mail-it0-f67.google.com with SMTP id f14-v6so6024056ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=HRrBVCY/liedzrbx86nkK5B7G7CXmut26GQ8sobj9js=;
        b=WIy92CX7lt2vi3uFw+GOFuzvnErhx6rhWOdMdIXevOEUBUDRkR1mRZiFm5N+ACzgxI
         zyFrtcy0DvY24hDBtwOUAPPaEcb54hw/Wv3PUp0Gr1v97Bvzu1buYA1+6IhtUMaTxcw5
         a/ZOP7ZvZCqV+B9IPynolEi7VAd/TsTHe6HMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=HRrBVCY/liedzrbx86nkK5B7G7CXmut26GQ8sobj9js=;
        b=Af+g/m+Uo03acniCHASvgvlbCtkoXZCwaufAWkDHc0KraZ2i/X/Q6IMbvXAeTgE0Ue
         SGgDL1FbfJcdkN06xMas/CTBNS6E24G/4pKEdCuUowwLXXAqp5npU1AVm6h1LChyZPn5
         kpDocVyY6cUuV/TqwWAtehj20hFn0Ap00yxNgXmxk+hSUA7S1uYLFHAzcrUVcBead1j+
         meIyqlUDuDdtR45hoSKRlyqwo1zWryNANYQLAMNHmjJI3y9rEPCru2ZFwCnf6feWCoQ5
         XOf9WdELsHncHJ+9qTbO6hyYRSkc0/mR07ZEt93YT9UXz37uaKYGs2TIfWAvY915J9vi
         EVOQ==
X-Gm-Message-State: APzg51BVZHYFrL6StYrgarS4KzxwsbhWK35loVkQdGRCSO3uLHuW4H7i
        AN4GOAqOUT6T9c6oDaH8/OtwcZ0su3fs/fGb5MHERQ==
X-Google-Smtp-Source: ANB0VdbMahUvQCNsl6jOMLPsW2eYwr1e5R0sBFQYTprMuCi4riM3eqT1mzGREWC3SHH08TSLunaZL1eA+hkxVIQo40k=
X-Received: by 2002:a02:5651:: with SMTP id o78-v6mr12053713jab.8.1535701833507;
 Fri, 31 Aug 2018 00:50:33 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
In-Reply-To: <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBGBaHbqJgkvCw
Date:   Fri, 31 Aug 2018 01:50:31 -0600
Message-ID: <615d78004495aebc53807156d04d988c@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ming Lei [mailto:tom.leiming@gmail.com]
> Sent: Friday, August 31, 2018 12:54 AM
> To: sumit.saxena@broadcom.com
> Cc: Ming Lei; Thomas Gleixner; Christoph Hellwig; Linux Kernel Mailing
> List;
> Kashyap Desai; shivasharan.srikanteshwara@broadcom.com; linux-block
> Subject: Re: Affinity managed interrupts vs non-managed interrupts
>
> On Wed, Aug 29, 2018 at 6:47 PM Sumit Saxena
> <sumit.saxena@broadcom.com> wrote:
> >
> > > -----Original Message-----
> > > From: Ming Lei [mailto:ming.lei@redhat.com]
> > > Sent: Wednesday, August 29, 2018 2:16 PM
> > > To: Sumit Saxena <sumit.saxena@broadcom.com>
> > > Cc: tglx@linutronix.de; hch@lst.de; linux-kernel@vger.kernel.org
> > > Subject: Re: Affinity managed interrupts vs non-managed interrupts
> > >
> > > Hello Sumit,
> > Hi Ming,
> > Thanks for response.
> > >
> > > On Tue, Aug 28, 2018 at 12:04:52PM +0530, Sumit Saxena wrote:
> > > >  Affinity managed interrupts vs non-managed interrupts
> > > >
> > > > Hi Thomas,
> > > >
> > > > We are working on next generation MegaRAID product where
> requirement
> > > > is- to allocate additional 16 MSI-x vectors in addition to number of
> > > > MSI-x vectors megaraid_sas driver usually allocates.  MegaRAID
> > > > adapter
> > > > supports 128 MSI-x vectors.
> > > >
> > > > To explain the requirement and solution, consider that we have 2
> > > > socket system (each socket having 36 logical CPUs). Current driver
> > > > will allocate total 72 MSI-x vectors by calling API-
> > > > pci_alloc_irq_vectors(with flag- PCI_IRQ_AFFINITY).  All 72 MSI-x
> > > > vectors will have affinity across NUMA node s and interrupts are
> > affinity
> > > managed.
> > > >
> > > > If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors =
> > > > 16 and, driver can allocate 16 + 72 MSI-x vectors.
> > >
> > > Could you explain a bit what the specific use case the extra 16
> > > vectors
> > is?
> > We are trying to avoid the penalty due to one interrupt per IO
> > completion
> > and decided to coalesce interrupts on these extra 16 reply queues.
> > For regular 72 reply queues, we will not coalesce interrupts as for low
> > IO
> > workload, interrupt coalescing may take more time due to less IO
> > completions.
> > In IO submission path, driver will decide which set of reply queues
> > (either extra 16 reply queues or regular 72 reply queues) to be picked
> > based on IO workload.
>
> I am just wondering how you can make the decision about using extra
> 16 or regular 72 queues in submission path, could you share us a bit
> your idea? How are you going to recognize the IO workload inside your
> driver? Even the current block layer doesn't recognize IO workload, such
> as random IO or sequential IO.

It is not yet finalized, but it can be based on per sdev outstanding,
shost_busy etc.
We want to use special 16 reply queue for IO acceleration (these queues are
working interrupt coalescing mode. This is a h/w feature)

>
> Frankly speaking, you may reuse the 72 reply queues to do interrupt
> coalescing by configuring one extra register to enable the coalescing
> mode,
> and you may just use small part of the 72 reply queues under the
> interrupt coalescing mode.
Our h/w can set interrupt coalescing per 8 reply queues. So smallest is 8.
If we choose to take 8 reply queue from existing 72 reply queue (without
asking for extra reply queue), we still have  an issue on more numa node
systems.  Example - in 8 numa node system each node will have only *one*
reply queue for effective interrupt coalescing. (since irq subsystem will
spread msix per numa).

To keep things scalable we cherry picked few reply queues and wanted them to
be out of cpu-msix mapping.

>
> Or you can learn from SPDK to use one or small number of dedicated cores
> or kernel threads to poll the interrupts from all reply queues, then I
> guess you may benefit much compared with the extra 16 queue approach.
Problem with polling -  It requires some steady completion, otherwise
prediction in driver gives different results on different profiles.
We attempted irq-poll and thread ISR based polling, but it has pros and
cons. One of the key usage of method what we are trying is not to impact
latency for lower QD workloads.
I posted RFC at
https://www.spinics.net/lists/linux-scsi/msg122874.html

We have done extensive study and concluded to use interrupt coalescing is
better if h/w can manage two different modes (coalescing on/off).

>
> Introducing extra 16 queues just for interrupt coalescing and making it
> coexisting with the regular 72 reply queues seems one very unusual use
> case, not sure the current genirq affinity can support it well.

Yes. This is unusual case. I think it is not used by any other drivers.

>
> > >
> > > >
> > > > All pre_vectors (16) will be mapped to all available online CPUs but
> > > > e
> > > > ffective affinity of each vector is to CPU 0. Our requirement is to
> > > > have pre _vectors 16 reply queues to be mapped to local NUMA node
> with
> > > > effective CPU should be spread within local node cpu mask. Without
> > > > changing kernel code, we can
> > >
> > > If all CPUs in one NUMA node is offline, can this use case work as
> > expected?
> > > Seems we have to understand what the use case is and how it works.
> >
> > Yes, if all CPUs of the NUMA node is offlined, IRQ-CPU affinity will be
> > broken and irqbalancer takes care of migrating affected IRQs to online
> > CPUs of different NUMA node.
> > When offline CPUs are onlined again, irqbalancer restores affinity.
>
>  irqbalance daemon can't cover managed interrupts, or you mean
> you don't use pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY)?

Yes. We did not used " pci_alloc_irq_vectors_affinity".
We used " pci_enable_msix_range" and manually set affinity in driver using
irq_set_affinity_hint.

>
> Thanks,
> Ming Lei
