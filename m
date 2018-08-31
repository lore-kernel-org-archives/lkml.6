Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE651C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F9520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjWUPimh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F9520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeHaLAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:00:21 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55392 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:00:20 -0400
Received: by mail-wm0-f54.google.com with SMTP id f21-v6so4117807wmc.5;
        Thu, 30 Aug 2018 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7b849tg0B2AeAQpYcHCJh3ZDwCrGblVrliBrEc/MOio=;
        b=MjWUPimhcVuk2IvzHF+0kkrxRKyxtFghA0YdGFG91d4BeFjEfE3HPNVwvFUm7PvzQb
         YRg5MWjOgNU1K9PkIK1BLlUaAwqglkPjSJ7Gt1Su9c90Tz7f4ePFTwsRyJpe87x0CpOg
         tvxCMzG2g48rZYsX1B/Yt+nTrx4nSGE8NFHf+ezqVEQ0mywDooNrYFRN9hZGY0u3KZhS
         r3UDnqWUfEzCZCiKZRJ8X/m5FAjxP2Srb+YcsWD8aDJRD1/adQtMwoV6db7DzrvjWYaD
         F5Bnly+NA0u0PFTLHTTCMRIJ44BRvKINPlU5AXVPkmoiM7P45Y7auoIBqS8mSNce1GvB
         sn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7b849tg0B2AeAQpYcHCJh3ZDwCrGblVrliBrEc/MOio=;
        b=clFHDB48mNlY4geZDCFX3Q3zCOH/pgkzz6h7tn9zy0kV0P2aTRyHa/MDX2/0JqEWk6
         oWmgi7BiCAoii/MaR04cC6LUjZXirJwz/1snTqg+Byx6pboRbeRko2P3VhiNDnwT3gJU
         r0TrbAwGuHjIGfCsq0/5n3CejC7rMkqAkIIbbpQw5i7LG3HWTK2sIGhRC2GOv4FOeEeF
         YWbkp4OtldEbzRXTr5hZvOxXBQ4/6e0fVC4YR1avcyqq/Sa+8nQnul9lcNywNx2OUN/X
         f3eZlQMrCwBlcyzVHqdgC0m8ralancc8vY24+TkD0/EemnWy02nVzxVctt0885nTVDlb
         mPSQ==
X-Gm-Message-State: APzg51B3/jT+AUIIS/okZH4dDwojhLLSDtdjNgGdS2Z3wHxpXl66jY1l
        ZqZusXgadgFhsGD9vzv7p8gU3vNQt2Zh+UrV+ArM2xxHh1w=
X-Google-Smtp-Source: ANB0VdZjmnbm40FazpIbk0q1ZuWqwhgGYOvnA8S6rX4RrrpLEt65Bo7dHd8xOa6TBbzwpfXTGTPY0+uTax9RBOHQjwI=
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr3637304wme.54.1535698460299;
 Thu, 30 Aug 2018 23:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
In-Reply-To: <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 31 Aug 2018 14:54:07 +0800
Message-ID: <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To:     sumit.saxena@broadcom.com
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:47 PM Sumit Saxena <sumit.saxena@broadcom.com> wrote:
>
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Wednesday, August 29, 2018 2:16 PM
> > To: Sumit Saxena <sumit.saxena@broadcom.com>
> > Cc: tglx@linutronix.de; hch@lst.de; linux-kernel@vger.kernel.org
> > Subject: Re: Affinity managed interrupts vs non-managed interrupts
> >
> > Hello Sumit,
> Hi Ming,
> Thanks for response.
> >
> > On Tue, Aug 28, 2018 at 12:04:52PM +0530, Sumit Saxena wrote:
> > >  Affinity managed interrupts vs non-managed interrupts
> > >
> > > Hi Thomas,
> > >
> > > We are working on next generation MegaRAID product where requirement
> > > is- to allocate additional 16 MSI-x vectors in addition to number of
> > > MSI-x vectors megaraid_sas driver usually allocates.  MegaRAID adapter
> > > supports 128 MSI-x vectors.
> > >
> > > To explain the requirement and solution, consider that we have 2
> > > socket system (each socket having 36 logical CPUs). Current driver
> > > will allocate total 72 MSI-x vectors by calling API-
> > > pci_alloc_irq_vectors(with flag- PCI_IRQ_AFFINITY).  All 72 MSI-x
> > > vectors will have affinity across NUMA node s and interrupts are
> affinity
> > managed.
> > >
> > > If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors =
> > > 16 and, driver can allocate 16 + 72 MSI-x vectors.
> >
> > Could you explain a bit what the specific use case the extra 16 vectors
> is?
> We are trying to avoid the penalty due to one interrupt per IO completion
> and decided to coalesce interrupts on these extra 16 reply queues.
> For regular 72 reply queues, we will not coalesce interrupts as for low IO
> workload, interrupt coalescing may take more time due to less IO
> completions.
> In IO submission path, driver will decide which set of reply queues
> (either extra 16 reply queues or regular 72 reply queues) to be picked
> based on IO workload.

I am just wondering how you can make the decision about using extra
16 or regular 72 queues in submission path, could you share us a bit
your idea? How are you going to recognize the IO workload inside your
driver? Even the current block layer doesn't recognize IO workload, such
as random IO or sequential IO.

Frankly speaking, you may reuse the 72 reply queues to do interrupt
coalescing by configuring one extra register to enable the coalescing mode,
and you may just use small part of the 72 reply queues under the
interrupt coalescing mode.

Or you can learn from SPDK to use one or small number of dedicated cores
or kernel threads to poll the interrupts from all reply queues, then I
guess you may benefit much compared with the extra 16 queue approach.

Introducing extra 16 queues just for interrupt coalescing and making it
coexisting with the regular 72 reply queues seems one very unusual use
case, not sure the current genirq affinity can support it well.

> >
> > >
> > > All pre_vectors (16) will be mapped to all available online CPUs but e
> > > ffective affinity of each vector is to CPU 0. Our requirement is to
> > > have pre _vectors 16 reply queues to be mapped to local NUMA node with
> > > effective CPU should be spread within local node cpu mask. Without
> > > changing kernel code, we can
> >
> > If all CPUs in one NUMA node is offline, can this use case work as
> expected?
> > Seems we have to understand what the use case is and how it works.
>
> Yes, if all CPUs of the NUMA node is offlined, IRQ-CPU affinity will be
> broken and irqbalancer takes care of migrating affected IRQs to online
> CPUs of different NUMA node.
> When offline CPUs are onlined again, irqbalancer restores affinity.

 irqbalance daemon can't cover managed interrupts, or you mean
you don't use pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY)?

Thanks,
Ming Lei
