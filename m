Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3EC21A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c//2gDAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3EC21A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeHHQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:14:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33350 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:14:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id c135-v6so1586724ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV6kZWG6ULjz1x2FDhRC8jMAsWuzGxEmcn5Uc6/mhFc=;
        b=c//2gDACl4HQcy6JQGB56qQ7nlxvFtzOoU70mFL45UEOtWbdQEe3LG3rWG9PB31OhG
         gvtm7ivBeHW7tqzo0bkq7ceSY0Zg4SHxLSRW1iQSUeUDX3YoLQVAx/jbtEUkSs5rU9Kh
         d7guoYE+BIH0SjmR9iyWdmUMlFJdwp7E7tWh9UFUxJdPnwxaiW6dNZ7uUkz+5Kve1vTF
         BKnJfEplgn2uDIwJKLNkhTcQoV1nNOzje9HG/KNNqT4hwQsGvnP1GdY+Zvnb8+QcS+aO
         1O5Y16ib9MhBlQ2y8A4/+oZxuv/jpr9DHbZA8yvrLQiYuf6bSuXXfUnYPyCQnon2k3rQ
         qRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV6kZWG6ULjz1x2FDhRC8jMAsWuzGxEmcn5Uc6/mhFc=;
        b=H9bSltwork/smGzyBSLn2kwmM+rst4DA/YIYVJKakWgODoa6+KTcl+vLEt7LwLosTp
         oTp0HCKI5wEgvgdW7DNi4QikSpxSIzeDJPSqIankkHKLa6KnZ6OW8A3QQi6fY/NNacON
         tQfwZ0dg8VezWPHZuHL0eoXrR/lE+pWs+IcgdVnNPJx2X7L24ZKPxYWpzba3Ba/h3t3U
         qDLmXDuIQXXy+FzMV8jBYG7r99sM/tVNQUV4P+ILdCEa2qj7fphNo1DywS0NPRo1oL4i
         GJR+qufznftSOkup3KnGijgTHDEZevGbZxF9YU8r22RiurfiSO5GqTMN2CwkzDbCu+c3
         f3Xg==
X-Gm-Message-State: AOUpUlFHEEbuno7PU3l5i6RkkwzrnWmZNF4dlHL71dcA5HfHiyuNABcF
        x2c5+zkqLLdLJ5alaMIlU4/t+Us6Anbo0SbqLBgw
X-Google-Smtp-Source: AA+uWPxxUHG6pqTQ5L0ACHn5wTUFqz4SQCumkXTjLxsoyNBs/LfyqvpUlru4KIC0CTF3iKhsuN2FyT5nE8T7BKqlTFU=
X-Received: by 2002:a81:29d0:: with SMTP id p199-v6mr1464614ywp.286.1533736480189;
 Wed, 08 Aug 2018 06:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180801173132.19739-1-punit.agrawal@arm.com> <38ad03ba-2658-98c8-1888-0aa3bfb59bd4@arm.com>
 <20180802143319.GA13512@red-moon>
In-Reply-To: <20180802143319.GA13512@red-moon>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 8 Aug 2018 08:54:28 -0500
Message-ID: <CAErSpo5i7AAXq4vmfsH2WjheXpzzM1iaehdeM24eQZjzYY39Rg@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Remove node-local allocations when
 initialising host controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, punit.agrawal@arm.com,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc linux-pci, linux-kernel]

On Thu, Aug 2, 2018 at 9:33 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Aug 01, 2018 at 02:38:51PM -0500, Jeremy Linton wrote:
> > Hi,
> >
> > +CC Jiang Lui
>
> Jiang Liu does not work on the kernel anymore so we won't know
> anytime soon the reasoning behind commit 965cd0e4a5e5
>
> > On 08/01/2018 12:31 PM, Punit Agrawal wrote:
> > >Memory for host controller data structures is allocated local to the
> > >node to which the controller is associated with. This has been the
> > >behaviour since support for ACPI was added in
> > >commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
> >
> > Which was apparently influenced by:
> >
> > 965cd0e4a5e5 x86, PCI, ACPI: Use kmalloc_node() to optimize for performance
> >
> > Was there an actual use-case behind that change?
> >
> > I think this fixes the immediate boot problem, but if there is any
> > perf advantage it seems wise to keep it... Particularly since x86
> > seems to be doing the node sanitation in pci_acpi_root_get_node().
>
> I am struggling to see the perf advantage of allocating a struct
> that the PCI controller will never read/write from a NUMA node that
> is local to the PCI controller, happy to be corrected if there is
> a sound rationale behind that.

If there is no reason to use kzalloc_node() here, we shouldn't use it.

But we should use it (or not use it) consistently across arches.  I do
not believe there is an arch-specific reason to be different.
Currently, pci_acpi_scan_root() uses kzalloc_node() on x86 and arm64,
but kzalloc() on ia64.  They all ought to be the same.

> > >Drop the node local allocation as there is no benefit from doing so -
> > >the usage of these structures is independent from where the controller
> > >is located. It also causes problem during probe if the associated numa
> > >node hasn't been initialised due to booting with restricted cpus via
> > >kernel command line or where the node doesn't have cpus or memory
> > >associated with it.

I do not support the avoidance of kzalloc_node() as a means of working
around the problem of a NUMA node not being initialized correctly.

We got that node number from acpi_get_node().  I think we should be
able to pass it to kzalloc_node() and expect something reasonable,
i.e., either a successful allocation from the desired node (or from a
node that is present) or an error return.  I don't think the caller is
in a position to figure out whether it's safe to use kzalloc_node() or
not.

> > >Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > >Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >Cc: Will Deacon <will.deacon@arm.com>
> > >Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >---
> > >Hi,
> > >
> > >This came up in the context of investigating the boot issues reported
> > >due to restricted cpus or buggy firmware. Part of the problem is fixed
> > >by Lorenzo's rework of NUMA initialisation[0].
> > >
> > >But there also doesn't seem to be any justification for using
> > >node-local allocation to begin with.
> > >
> > >Thanks,
> > >Punit
> > >
> > >[0] https://patchwork.kernel.org/patch/10486001/
> > >
> > >  arch/arm64/kernel/pci.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > >index 0e2ea1c78542..bb85e2f4603f 100644
> > >--- a/arch/arm64/kernel/pci.c
> > >+++ b/arch/arm64/kernel/pci.c
> > >@@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> > >  /* Interface called from ACPI code to setup PCI host controller */
> > >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > >  {
> > >-    int node = acpi_get_node(root->device->handle);
> > >     struct acpi_pci_generic_root_info *ri;
> > >     struct pci_bus *bus, *child;
> > >     struct acpi_pci_root_ops *root_ops;
> > >-    ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> > >+    ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> > >     if (!ri)
> > >             return NULL;
> > >-    root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> > >+    root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> > >     if (!root_ops) {
> > >             kfree(ri);
> > >             return NULL;
> > >
> >
