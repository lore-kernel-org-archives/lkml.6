Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F96C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F72077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KjJj2J4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeICJxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:53:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37629 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeICJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:53:19 -0400
Received: by mail-io0-f194.google.com with SMTP id v14-v6so14976841iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=CQnNB009Cy33AqVFmF/6dcXRaqDruSPNy+a/oLfI11M=;
        b=KjJj2J4/YCaZ4MSMJVgcqHYx4JMQlDYOv36TF1aI549Wp5uPfkTbbBV6EVyyGsyNEH
         Su2lPQ15yJCEyP4dqSKeLDAE5Ug0Gd03df+8Bmh1yGRYfAAP/2SJLiyE1BNf88mTFZLs
         aMv2hK8pyeirvcuyCXigcIR+rrkPqlrrWfNfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=CQnNB009Cy33AqVFmF/6dcXRaqDruSPNy+a/oLfI11M=;
        b=brlUR+XpVKJo8KK00vH9JoHHcL/iCoSK0mvAi1V02Q5lkY/oMzxls5PEfbCUC6dzui
         obbPdRzc0JYcvKuj5AzKmTICuahSJXOOsiNAumfytrbL3wjw5uM8U/TJtqxFaip3+O/Y
         +4SQJE1FobDRmoq17iZid72q+uWXt2W8+1KseIbU+JQ/gp10fRXi1EgcWhZ6S3BQ9QTB
         0qekm+4FQCr+4DZaxZubKFTCS/D0lJBUpw/L8tJPUsv/g+i7pfvzCTWjRhHLoWvwpUIK
         jFPlGpmlEN7y6RTdxFniffhHLtCfMc0yFea59P33+c0CBYGKqIGHHtYq0ZJ1jK7bxQ9+
         UfJA==
X-Gm-Message-State: APzg51BhG4sCG8VxIEkQyXFDn2KOZoxbPADU6C8dvOFpu06wHJM7BYmQ
        5I/TQISm2BAZxyzyuSxPUKkGf+WrmyjqlILdLZcLYQ==
X-Google-Smtp-Source: ANB0VdZ4PcaH3xAVGQUXr4V+xeE4wrWdpFR+gCEo/oVJxbQNAEibHqG8ygKBx4uJS+JIxxYqSIJBpmjCQ+D7wMC5zC4=
X-Received: by 2002:a5e:8d18:: with SMTP id m24-v6mr18497782ioj.217.1535952886312;
 Sun, 02 Sep 2018 22:34:46 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBGBaHbgI3aj7TAe+rdbUBJEp+nAJfSXIOAX62R1ABhljzHqIPoXWQ
Date:   Mon, 3 Sep 2018 11:04:44 +0530
Message-ID: <66256272c020be186becdd7a3f049302@mail.gmail.com>
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

> On Fri, 31 Aug 2018, Kashyap Desai wrote:
> > > Ok. I misunderstood the whole thing a bit. So your real issue is
that you
> > > want to have reply queues which are instantaneous, the per cpu ones,
and
> > > then the extra 16 which do batching and are shared over a set of
CPUs,
> > > right?
> >
> > Yes that is correct.  Extra 16 or whatever should be shared over set
of
> > CPUs of *local* numa node of the PCI device.
>
> Why restricting it to the local NUMA node of the device? That doesn't
> really make sense if you queue lots of requests from CPUs on a different
> node.

Penalty of cross numa node is minimal with higher interrupt coalescing
used in h/w.  We see penalty of cross numa traffic for lower IOPs type
work load.
In this particular case we are taking care cross numa traffic via higher
interrupt coalescing.

>
> Why don't you spread these extra interrupts accross all nodes and keep
the
> locality for the request/reply?

I assuming you are refereeing spreading msix to all numa node the way
"pci_alloc_irq_vectors" does.

Having extra 16 reply queue spread across nodes will have negative impact.
Take example of 8 node system (total 128 logical cpus).
If  16 reply queue are spread across numa node, there will be total 8
logical cpu mapped to 1 reply queue (eventually one numa node will have
only 2 reply queue mapped).

Running IO from one numa node will only consume 2 reply queues.
Performance dropped drastically in such case.  This is typical problem
with cpu-msix mapping goes to N:1 where msix is less than online cpus.

Mapping extra 16 reply queue to local numa node will always make sure that
driver will round robin all 16 reply queue irrespective of originated cpu.
We validated this method sending IOs from remote node and did not observed
performance penalty.

>
> That also would allow to make them properly managed interrupts as you
> could
> shutdown the per node batching interrupts when all CPUs of that node are
> offlined and you'd avoid the whole affinity hint irq balancer hackery.

One more clarification -

I am using " for-4.19/block " and this particular patch "a0c9259
irq/matrix: Spread interrupts on allocation" is included.
I can see that 16 extra reply queues via pre_vectors are still assigned to
CPU 0 (effective affinity ).

irq 33, cpu list 0-71
irq 34, cpu list 0-71
irq 35, cpu list 0-71
irq 36, cpu list 0-71
irq 37, cpu list 0-71
irq 38, cpu list 0-71
irq 39, cpu list 0-71
irq 40, cpu list 0-71
irq 41, cpu list 0-71
irq 42, cpu list 0-71
irq 43, cpu list 0-71
irq 44, cpu list 0-71
irq 45, cpu list 0-71
irq 46, cpu list 0-71
irq 47, cpu list 0-71
irq 48, cpu list 0-71


# cat /sys/kernel/debug/irq/irqs/34
handler:  handle_edge_irq
device:   0000:86:00.0
status:   0x00004000
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x01608200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_MOVE_PCNTXT
            IRQD_AFFINITY_MANAGED
node:     0
affinity: 0-71
effectiv: 0
pending:
domain:  INTEL-IR-MSI-1-2
 hwirq:   0x4300001
 chip:    IR-PCI-MSI
  flags:   0x10
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-1
     hwirq:   0x40000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x22
         chip:    APIC
          flags:   0x0
         Vector:    46
         Target:     0
         move_in_progress: 0
         is_managed:       1
         can_reserve:      0
         has_reserved:     0
         cleanup_pending:  0

#cat /sys/kernel/debug/irq/irqs/35
handler:  handle_edge_irq
device:   0000:86:00.0
status:   0x00004000
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x01608200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_MOVE_PCNTXT
            IRQD_AFFINITY_MANAGED
node:     0
affinity: 0-71
effectiv: 0
pending:
domain:  INTEL-IR-MSI-1-2
 hwirq:   0x4300002
 chip:    IR-PCI-MSI
  flags:   0x10
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-1
     hwirq:   0x50000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x23
         chip:    APIC
          flags:   0x0
         Vector:    47
         Target:     0
         move_in_progress: 0
         is_managed:       1
         can_reserve:      0
         has_reserved:     0
         cleanup_pending:  0

Ideally, what we are looking for 16 extra pre_vector reply queue is
"effective affinity" to be within local numa node as long as that numa
node has online CPUs. If not, we are ok to have effective cpu from any
node.

>
> Thanks,
>
> 	tglx
>
>
