Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s91wEyxFGFsLZwAAmS7hNA
	; Wed, 06 Jun 2018 20:39:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ECD28608B8; Wed,  6 Jun 2018 20:39:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvCKnJx8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EA3460290;
	Wed,  6 Jun 2018 20:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EA3460290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeFFUju (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:39:50 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35074 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeFFUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:39:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id v131-v6so2324088ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwyLPXPMeq4ID4LexmBIzoDMQSY/4oEud+ShC7hlPVU=;
        b=nvCKnJx8iJIRaPJGLu2PoGF7k/P5y0EpaQy6Ca9ORv1gc4FnSQv6uyLhlR/r7iyFSo
         0YTJlKfoFcA8iFcvVRwtD5Pkr24DVJ2Fe3OsINEZgfB9UrPwNs/m2mluwK9z+jABlw6G
         E7bq/w/qceZkMylpOQBXNrSbHRcH0Ns3dKcoVqoW6DwyauiS8Cy6mRPZLyhTI4DZ/Zx2
         ei4Eg64XU2Zdao59xWKG740VK8OJR5siip0OskQy4kXrvC3J41UrWfAT/OJ7d5Co1QIz
         T+YsE40YLrIN+9BxzJb6oSljLlSLDm/l2suMhj5ldXJa+h/kiXYKhjJb+FtlHBmTIpvm
         +4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwyLPXPMeq4ID4LexmBIzoDMQSY/4oEud+ShC7hlPVU=;
        b=Pop8Kwxzc2+GnvyJWOX3rIqyENuYkSR7TS/AISfEes7heXrepFLnQsXzPocpUunR1b
         G/RauHxwBc7oQyq+G122HGtEvCzk9C17GK0pLW4jZMEDqUur0N4744YSpD3eo3gErvrM
         Qc1sYhncweIbyarTFP7CyOI5OOMr7avL3faafDrZNzJhgV/o0b2/mvgE+h8I/feUKgAO
         Cssm5mCrurIc0vCPGnGSspUyzNCYH4Pcb/2+RkQ3svm1lSBXwljHWHwpUlpPzt0v7fFP
         cp7PWxnGZGFhAThETiRgu+VN9T2Ku8p8dycRb4ymH7rYr/aSYPFUXArKijbbBEyEzwtZ
         zSvA==
X-Gm-Message-State: APt69E38+wtVWK6gV0usQVSoMjufOjwmOo+J2DLlC0A6oldyVqm9jqFX
        cpQluqjAXxwUuSAW7FfSmXqyWyORqqRaMP24/kaF
X-Google-Smtp-Source: ADUXVKKo5PSk2R8KHRvMa+F1p2BC1pLjXvyP28vpL6qDN25BKIxW3m1F+5aCt0fFyBqA/LOlRNE/tkFeBGepldSD5t4=
X-Received: by 2002:a81:ae47:: with SMTP id g7-v6mr2120973ywk.349.1528317587100;
 Wed, 06 Jun 2018 13:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
 <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com> <20180606154516.GL6631@arm.com>
In-Reply-To: <20180606154516.GL6631@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 Jun 2018 15:39:34 -0500
Message-ID: <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
To: Will Deacon <will.deacon@arm.com>
Cc: xiexiuqi@huawei.com, Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, wanghuiqiang@huawei.com,
        tnowicki@caviumnetworks.com, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc akpm, linux-mm, linux-pci]

On Wed, Jun 6, 2018 at 10:44 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, May 31, 2018 at 08:14:38PM +0800, Xie XiuQi wrote:
> > A numa system may return node which is not online.
> > For example, a numa node:
> > 1) without memory
> > 2) NR_CPUS is very small, and the cpus on the node are not brought up
> >
> > In this situation, we use NUMA_NO_NODE to avoid oops.
> >
> > [   25.732905] Unable to handle kernel NULL pointer dereference at virtual address 00001988
> > [   25.740982] Mem abort info:
> > [   25.743762]   ESR = 0x96000005
> > [   25.746803]   Exception class = DABT (current EL), IL = 32 bits
> > [   25.752711]   SET = 0, FnV = 0
> > [   25.755751]   EA = 0, S1PTW = 0
> > [   25.758878] Data abort info:
> > [   25.761745]   ISV = 0, ISS = 0x00000005
> > [   25.765568]   CM = 0, WnR = 0
> > [   25.768521] [0000000000001988] user address but active_mm is swapper
> > [   25.774861] Internal error: Oops: 96000005 [#1] SMP
> > [   25.779724] Modules linked in:
> > [   25.782768] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc6-mpam+ #115
> > [   25.789714] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B305 05/28/2018
> > [   25.798831] pstate: 80c00009 (Nzcv daif +PAN +UAO)
> > [   25.803612] pc : __alloc_pages_nodemask+0xf0/0xe70
> > [   25.808389] lr : __alloc_pages_nodemask+0x184/0xe70
> > [   25.813252] sp : ffff00000996f660
> > [   25.816553] x29: ffff00000996f660 x28: 0000000000000000
> > [   25.821852] x27: 00000000014012c0 x26: 0000000000000000
> > [   25.827150] x25: 0000000000000003 x24: ffff000008099eac
> > [   25.832449] x23: 0000000000400000 x22: 0000000000000000
> > [   25.837747] x21: 0000000000000001 x20: 0000000000000000
> > [   25.843045] x19: 0000000000400000 x18: 0000000000010e00
> > [   25.848343] x17: 000000000437f790 x16: 0000000000000020
> > [   25.853641] x15: 0000000000000000 x14: 6549435020524541
> > [   25.858939] x13: 20454d502067756c x12: 0000000000000000
> > [   25.864237] x11: ffff00000996f6f0 x10: 0000000000000006
> > [   25.869536] x9 : 00000000000012a4 x8 : ffff8023c000ff90
> > [   25.874834] x7 : 0000000000000000 x6 : ffff000008d73c08
> > [   25.880132] x5 : 0000000000000000 x4 : 0000000000000081
> > [   25.885430] x3 : 0000000000000000 x2 : 0000000000000000
> > [   25.890728] x1 : 0000000000000001 x0 : 0000000000001980
> > [   25.896027] Process swapper/0 (pid: 1, stack limit = 0x        (ptrval))
> > [   25.902712] Call trace:
> > [   25.905146]  __alloc_pages_nodemask+0xf0/0xe70
> > [   25.909577]  allocate_slab+0x94/0x590
> > [   25.913225]  new_slab+0x68/0xc8
> > [   25.916353]  ___slab_alloc+0x444/0x4f8
> > [   25.920088]  __slab_alloc+0x50/0x68
> > [   25.923562]  kmem_cache_alloc_node_trace+0xe8/0x230
> > [   25.928426]  pci_acpi_scan_root+0x94/0x278
> > [   25.932510]  acpi_pci_root_add+0x228/0x4b0
> > [   25.936593]  acpi_bus_attach+0x10c/0x218
> > [   25.940501]  acpi_bus_attach+0xac/0x218
> > [   25.944323]  acpi_bus_attach+0xac/0x218
> > [   25.948144]  acpi_bus_scan+0x5c/0xc0
> > [   25.951708]  acpi_scan_init+0xf8/0x254
> > [   25.955443]  acpi_init+0x310/0x37c
> > [   25.958831]  do_one_initcall+0x54/0x208
> > [   25.962653]  kernel_init_freeable+0x244/0x340
> > [   25.966999]  kernel_init+0x18/0x118
> > [   25.970474]  ret_from_fork+0x10/0x1c
> > [   25.974036] Code: 7100047f 321902a4 1a950095 b5000602 (b9400803)
> > [   25.980162] ---[ end trace 64f0893eb21ec283 ]---
> > [   25.984765] Kernel panic - not syncing: Fatal exception
> >
> > Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> > Tested-by: Huiqiang Wang <wanghuiqiang@huawei.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Tomasz Nowicki <Tomasz.Nowicki@caviumnetworks.com>
> > Cc: Xishi Qiu <qiuxishi@huawei.com>
> > ---
> >  arch/arm64/kernel/pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 0e2ea1c..e17cc45 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -170,6 +170,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >       struct pci_bus *bus, *child;
> >       struct acpi_pci_root_ops *root_ops;
> >
> > +     if (node != NUMA_NO_NODE && !node_online(node))
> > +             node = NUMA_NO_NODE;
> > +
>
> This really feels like a bodge, but it does appear to be what other
> architectures do, so:
>
> Acked-by: Will Deacon <will.deacon@arm.com>

I agree, this doesn't feel like something we should be avoiding in the
caller of kzalloc_node().

I would not expect kzalloc_node() to return memory that's offline, no
matter what node we told it to allocate from.  I could imagine it
returning failure, or returning memory from a node that *is* online,
but returning a pointer to offline memory seems broken.

Are we putting memory that's offline in the free list?  I don't know
where to look to figure this out.

Bjorn
