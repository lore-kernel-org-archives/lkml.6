Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3BBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF6F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hffAn+U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF6F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeH2Omo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:42:44 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45414 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2Omo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:42:44 -0400
Received: by mail-ed1-f41.google.com with SMTP id p52-v6so3557447eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=dCPgzwY5E8r4rznxW5IcZSLsQxkGu4EWlnNdSTnPyic=;
        b=hffAn+U4lO0wE+7bNOK2AwS78M7qhpB9I4tw7508/h+jz5Vgjdw8yn4q0vdKyfIjGv
         IG3DhZ1mIG4NSuaAuwUAf8qJG7W29EEYESEPgh6pLnSseE16EXRgo4ttjE6JDq799Im3
         lCBd3Wb7brfDrKcA1HVBV734wY4XC/twmyxeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=dCPgzwY5E8r4rznxW5IcZSLsQxkGu4EWlnNdSTnPyic=;
        b=L7EOvpqHzE+2EaMsqKgToS+5fPZGeTK7hEiN6VyPkSgVAYa1gg0mc8w907iQtRQilF
         nnmvDGGmO+jBL23RvQT8cJze9gwFLjQU6T6yEAFAv9sZCsnwYi3b3WAEBXck++Ig4jiK
         vi547P4lO3mVTDShcNUojgkWYKBGwF19LdZmY37n9yTrGV8cSsyVT4eBtgta3C4MKAY9
         /Uz8rQXJ6LTqhhhK1pRJ2u9wmOQKljwTqySEZOCQPBkz3qRvyfVm3zflwbCx4Vz3k4oe
         Mcd+i071nPBkzaVT5mlljanOqHQhAwMHkn3FqMBIuRHDSAcJwiYVcLADtjX8dz/bU3UL
         9h8A==
X-Gm-Message-State: APzg51CyuTK9dbe/+3reQ4j1TTrZs8+v44zmr9eKHC36S88/9zkb+UoF
        xFLIP79Tsj1ES+xdrqYc08ZO+47goLNmkWlZHAdCcA==
X-Google-Smtp-Source: ANB0VdYkvhO5QXFZj5GpyA4jhIPXgWFiuhBzykVONz48/pEGyZobn9+YKJPyE2QIF7l2Bn0uX351HWbM0+awRsH+U3M=
X-Received: by 2002:a50:9d4f:: with SMTP id j15-v6mr6750974edk.74.1535539585926;
 Wed, 29 Aug 2018 03:46:25 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p>
In-Reply-To: <20180829084618.GA24765@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UondyhZA=
Date:   Wed, 29 Aug 2018 16:16:23 +0530
Message-ID: <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Ming Lei <ming.lei@redhat.com>
Cc:     tglx@linutronix.de, hch@lst.de, linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Wednesday, August 29, 2018 2:16 PM
> To: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: tglx@linutronix.de; hch@lst.de; linux-kernel@vger.kernel.org
> Subject: Re: Affinity managed interrupts vs non-managed interrupts
>
> Hello Sumit,
Hi Ming,
Thanks for response.
>
> On Tue, Aug 28, 2018 at 12:04:52PM +0530, Sumit Saxena wrote:
> >  Affinity managed interrupts vs non-managed interrupts
> >
> > Hi Thomas,
> >
> > We are working on next generation MegaRAID product where requirement
> > is- to allocate additional 16 MSI-x vectors in addition to number of
> > MSI-x vectors megaraid_sas driver usually allocates.  MegaRAID adapter
> > supports 128 MSI-x vectors.
> >
> > To explain the requirement and solution, consider that we have 2
> > socket system (each socket having 36 logical CPUs). Current driver
> > will allocate total 72 MSI-x vectors by calling API-
> > pci_alloc_irq_vectors(with flag- PCI_IRQ_AFFINITY).  All 72 MSI-x
> > vectors will have affinity across NUMA node s and interrupts are
affinity
> managed.
> >
> > If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors =
> > 16 and, driver can allocate 16 + 72 MSI-x vectors.
>
> Could you explain a bit what the specific use case the extra 16 vectors
is?
We are trying to avoid the penalty due to one interrupt per IO completion
and decided to coalesce interrupts on these extra 16 reply queues.
For regular 72 reply queues, we will not coalesce interrupts as for low IO
workload, interrupt coalescing may take more time due to less IO
completions.
In IO submission path, driver will decide which set of reply queues
(either extra 16 reply queues or regular 72 reply queues) to be picked
based on IO workload.
>
> >
> > All pre_vectors (16) will be mapped to all available online CPUs but e
> > ffective affinity of each vector is to CPU 0. Our requirement is to
> > have pre _vectors 16 reply queues to be mapped to local NUMA node with
> > effective CPU should be spread within local node cpu mask. Without
> > changing kernel code, we can
>
> If all CPUs in one NUMA node is offline, can this use case work as
expected?
> Seems we have to understand what the use case is and how it works.

Yes, if all CPUs of the NUMA node is offlined, IRQ-CPU affinity will be
broken and irqbalancer takes care of migrating affected IRQs to online
CPUs of different NUMA node.
When offline CPUs are onlined again, irqbalancer restores affinity.
>
>
> Thanks,
> Ming
