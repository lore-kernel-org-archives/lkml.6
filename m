Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002BCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A4820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EaeXmM/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A4820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeH3VSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:18:46 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53621 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3VSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:18:46 -0400
Received: by mail-it0-f54.google.com with SMTP id p79-v6so3593773itp.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=kMloL3k/6fw70hU7N+eWpV+TlfWGevqpwdtYS+RCvWU=;
        b=EaeXmM/rPwkSr4dWPimpHTlFQLrqihqKblBVIbTYXmVyTLxFGmNC5fMIO2MS9w79D5
         p/XNBvakSrIqdQVRkc49taeGWDZH5flQuUdhN3pgRsK8wmbsrbgzDKb7MKUVnpjNgKnc
         tD5s3e7s/+o2GFSvoJ2ePKS8KBSHSz6NzyPtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=kMloL3k/6fw70hU7N+eWpV+TlfWGevqpwdtYS+RCvWU=;
        b=nD4AbKSlGTEKM+oCZDD6md//oj996SQ01GunzJczqIwtdl6vm6No555LaZ6sHWwhG2
         DCh7mGL6j4YcPWPvZyXe83pMjwUTllVaWz05L+o6o155GlHh58R9QcAlwfwT952cwADt
         GJwlr+T+Jz2fVNlfUS1okX3f91kCoe6L/fc0vmRP8tfQtl188d1qah0zTcPFLJIdnsDm
         YpFes5pUXwE94Jb05mDA4DeUcgYUmu1vMWFWVjgFB2fTUdrTCVaRXY58GtL3/SPlnMcH
         CTaXMH/Q84BS0PnMBjntCl4xtfA022gUhMQlATgxc/ZLuIEuww+XQToofXA24iMxH2tZ
         1LRQ==
X-Gm-Message-State: APzg51ATRDfQtl6/9RiJv2XhCrHJGDucUkmdqz+4IT7IGqE+QPZOJ6LS
        k9AWkw7cBrGN9CERq4+NHcDH50BI7yYX0ycz4URL8A==
X-Google-Smtp-Source: ANB0VdaeOBQM/HDmV/oCGgIytL62yuTl/CJHSTeY2F/JEoV3NiTN4hEK7wWtUocCMh8VCg8d9b3L+2vHW8jpKqPFkfU=
X-Received: by 2002:a02:39a:: with SMTP id e26-v6mr10141913jae.135.1535649338479;
 Thu, 30 Aug 2018 10:15:38 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
In-Reply-To: <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfuiaGEY8A==
Date:   Thu, 30 Aug 2018 11:15:37 -0600
Message-ID: <51f07ed08d4369fe513bd13f59656a8b@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     tglx@linutronix.de, hch@lst.de, linux-kernel@vger.kernel.org,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Ming, Chris et all,

Your input will help us to do changes for megaraid_sas driver.  We are
currently waiting for community response.

Is it recommended to use " pci_enable_msix_range" and have low level driver
do affinity setting because current APIs around pci_alloc_irq_vectors do not
meet our requirement.

We want more than online CPU msix vectors and using pre_vector we can do
that, but first 16 msix should be mapped to local numa node with effective
cpu spread across cpus of local numa node. This is not possible using
pci_alloc_irq_vectors_affinity.

Do we need kernel API changes or let's have low level driver to manage it
via irq_set_affinity_hint ?

Kashyap

> -----Original Message-----
> From: Sumit Saxena [mailto:sumit.saxena@broadcom.com]
> Sent: Wednesday, August 29, 2018 4:46 AM
> To: Ming Lei
> Cc: tglx@linutronix.de; hch@lst.de; linux-kernel@vger.kernel.org; Kashyap
> Desai; Shivasharan Srikanteshwara
> Subject: RE: Affinity managed interrupts vs non-managed interrupts
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
> >
> >
> > Thanks,
> > Ming
