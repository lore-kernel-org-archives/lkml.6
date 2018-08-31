Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976A7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EpgpHDSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5C82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIADrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:47:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52768 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:47:12 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so9210340ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=qZhzncD5NA/H9u+4HtHTRzLD7QnibnBEhBm00h0yGDs=;
        b=EpgpHDSyU5oFOcu7Ovn6E/O4fW0p/IVJ00rdtzDR8BAEJ3Q8OAWj6neu+auLRkIsB/
         LpaZMk9v1XHaPUZJA63Wq7oDs+7GMtxe4fHUyWmr4j2ibXh7yFPeLRD+p1I0skTWXqjO
         IVd88Nv6mYqIpXmud8ptzxO/jafPN/5jwZ6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=qZhzncD5NA/H9u+4HtHTRzLD7QnibnBEhBm00h0yGDs=;
        b=eKkXnxzmvuQU3PRXZ+O7+2f5g/B9ZErUK//tAZYascXfcC/3wDzX9DOkK44WLWfwGL
         QR7zrjVYnquJxMB49Js5qiWKE4fz8JateCErYvoA3RVwjjDf3veGDE1evOBmYX0anJ1s
         QiavJVMm6NiY4f01tkWf9+FVJ55rxfBiXefNa7O9lsV1RS3Swx94lp5MudQVj79wc1j/
         IoyoXHuZvA22XH8MoRgdaUb3ZGzVIFfBCyTw82l0noqvfoP6EkGti3vk2+jInMEm24qT
         vHSf5GImrV1UkuCRcOst2eaGreTuQUuegXtyexYnvvXPwmOj243XXo/lJV7fyirJZlCU
         cw6Q==
X-Gm-Message-State: APzg51BmjHR+pFPMfrEpVvX9PWE/aQ6COr1tif+/c6g9Or6WVoqCer81
        MA0ULmFaCgbBs+7XyEyi722l1dOrll7MRHl11dwsMQ==
X-Google-Smtp-Source: ANB0VdZZIYusM7oJb/JSkCQvbdRGlzhGxrZpzInCJmFXEKOjx5xJZbjzUID3YqRFX2yKmZnF1CEluzjWJvR0f0HLTno=
X-Received: by 2002:a24:eec7:: with SMTP id b190-v6mr6468166iti.32.1535758643836;
 Fri, 31 Aug 2018 16:37:23 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBGBaHbgI3aj7TAe+rdbUBJEp+nAJfSXIOoiRGsIA=
Date:   Fri, 31 Aug 2018 17:37:22 -0600
Message-ID: <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > It is not yet finalized, but it can be based on per sdev
outstanding,
> > > > shost_busy etc.
> > > > We want to use special 16 reply queue for IO acceleration (these
> > queues are
> > > > working interrupt coalescing mode. This is a h/w feature)
> > >
> > > TBH, this does not make any sense whatsoever. Why are you trying to
have
> > > extra interrupts for coalescing instead of doing the following:
> >
> > Thomas,
> >
> > We are using this feature mainly for performance and not for CPU
hotplug
> > issues.
> > I read your below #1 to #4 points are more of addressing CPU hotplug
> > stuffs. Right ? If we use all 72 reply queue (all are in interrupt
> > coalescing mode) without any extra reply queues, we don't have any
issue
> > with cpu-msix mapping and cpu hotplug issues.  Our major problem with
> > that method is latency is very bad on lower QD and/or single worker
case.
> >
> > To solve that problem we have added extra 16 reply queue (this is a
> > special h/w feature for performance only) which can be worked in
interrupt
> > coalescing mode vs existing 72 reply queue will work without any
interrupt
> > coalescing.   Best way to map additional 16 reply queue is map it to
the
> > local numa node.
>
> Ok. I misunderstood the whole thing a bit. So your real issue is that
you
> want to have reply queues which are instantaneous, the per cpu ones, and
> then the extra 16 which do batching and are shared over a set of CPUs,
> right?

Yes that is correct.  Extra 16 or whatever should be shared over set of
CPUs of *local* numa node of the PCI device.

>
> > I understand that, it is unique requirement but at the same time we
may
> > be able to do it gracefully (in irq sub system) as you mentioned "
> > irq_set_affinity_hint" should be avoided in low level driver.
>
> > Is it possible to have similar mapping in managed interrupt case as
below
> > ?
> >
> >     for (i = 0; i < 16 ; i++)
> >         irq_set_affinity_hint (pci_irq_vector(instance->pdev,
> > cpumask_of_node(local_numa_node));
> >
> > Currently we always see managed interrupts for pre-vectors are 0-71
and
> > effective cpu is always 0.
>
> The pre-vectors are not affinity managed. They get the default affinity
> assigned and at request_irq() the vectors are dynamically spread over
CPUs
> to avoid that the bulk of interrupts ends up on CPU0. That's handled
that
> way since a0c9259dc4e1 ("irq/matrix: Spread interrupts on allocation")

I am not sure if this is working on 4.18 kernel. I can double check. What
I remember is pre_vectors are mapped to 0-71 in my case and effective cpu
is always 0.
Ideally you mentioned that it should be spread..let me check that.

>
> > We want some changes in current API which can allow us to  pass flags
> > (like *local numa affinity*) and cpu-msix mapping are from local numa
node
> > + effective cpu are spread across local numa node.
>
> What you really want is to split the vector space for your device into
two
> blocks. One for the regular per cpu queues and the other (16 or how many
> ever) which are managed separately, i.e. spread out evenly. That needs
some
> extensions to the core allocation/management code, but that shouldn't be
a
> huge problem.

Yes this is correct understanding.  I can test any proposed patch if that
is what we want to use as best practice.
We attempted but due to lack of knowledge  in irq-subsystem, we are not
able to settle down anything which is close to our requirement.

We did something like below - "added new flag PCI_IRQ_PRE_VEC_NUMA which
will indicate that all pre and post vector should be shared within local
numa node."

    int irq_flags;
    struct irq_affinity desc;
    desc.pre_vectors = 16;
    desc.post_vectors = 0;

    irq_flags = PCI_IRQ_MSIX;

    i = pci_alloc_irq_vectors_affinity(instance->pdev,
                instance->high_iops_vector_start * 2,
                instance->msix_vectors,
                irq_flags | PCI_IRQ_AFFINITY | PCI_IRQ_PRE_VEC_NUMA,
&desc);

Somehow, I was not able to understand which part of irq subsystem should
have changes.

~ Kashyap


>
> Thanks,
>
> 	tglx
