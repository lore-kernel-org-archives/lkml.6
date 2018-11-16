Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E785C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36C02086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JO5NojQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36C02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeKQJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:09:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34444 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:09:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so2652397oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cVwU96N2XYZtJG7MGhw5JAB55a0CKIl5sIXk+pMEgk=;
        b=JO5NojQoepeIpmHcVnh6lMvFByEYuBFay2UOZVzj9Iab+YDNSvsNzR+Lm9FCemI73R
         2PtyWjf5utyCcE/XIKx3uTnLM6H9y8K8DvOynq9C2w+6fbrBGz3P9s2Z1FimUuURAbFI
         9r5zlKPOCjALu2zlkhaN9HgCrRxeYVvopj8UMHbKAHtPGNUP2nVvEGJYAfouD0Z9Icco
         OmuAhtFFj5Wztwi9eLtiVIz5t3O3lBgM7bIt9n5shHzKQAN6dU2ktUn649OA1cBdltNI
         YaGk2rs2QVBGqvf29ohgn/WCLUqz7Hbsxl76yCS+zpnxWkOEPzXO705ma76AVeBJfKlP
         61Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cVwU96N2XYZtJG7MGhw5JAB55a0CKIl5sIXk+pMEgk=;
        b=fQkxTHI3X+7gC47ILEW84a8KTbhe1bNeNSzNOWWj1wtCZWgyqf7JVVTZR3C1gWPj6h
         /RJ0mEXHnyP19ce4+0PA83eXbXFXpzSq0pPoztSN7l4fXM+AAGg4M1EIPsRUoyyyCP/s
         bSQfsWGJ11hdRhDiaCbC+pCYYmVMMR3VhOEFZ1Cxce7Bw+8DuaKGYutKiJBsoG0vqTaR
         IKARSE1EdsffsfVpiJ9zoJsYXxsP2c4R44Au09i5IKE+sqjKCGiE0iEnGmEdiZPRhiAc
         JLshkoG73bdS053P3B67E8KITlYXg17vObCDasQSGHLnviF3QE9JX0Cssm+ZnjE6T8lr
         lJ2g==
X-Gm-Message-State: AGRZ1gLZuRkceHsjYzspb7B7cqBdLO6Y4JJ95782qduYruhRdXRbfqwq
        SmFRFx/+QCAab8Xc846000dCNWMeHTJLLn3E1PXD9A==
X-Google-Smtp-Source: AJdET5cEHP626S4ub1yjKbiuBY+tBz3vYvNocLHqsS/4WIgZ1AlN/vqI4u+laGiKM5cOYUBHTOB19dZ1DROcadcZMYM=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr2147356oih.244.1542408938666;
 Fri, 16 Nov 2018 14:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain> <20181115203654.GA28246@bombadil.infradead.org>
In-Reply-To: <20181115203654.GA28246@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Nov 2018 14:55:27 -0800
Message-ID: <CAPcyv4iBL74HN5N+f1x_BxGJ4xjk7rb8V-DGLHQEtG7zkeWKpA@mail.gmail.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:37 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
> > On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
> > > On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> > > > Memory-only nodes will often have affinity to a compute node, and
> > > > platforms have ways to express that locality relationship.
> > > >
> > > > A node containing CPUs or other DMA devices that can initiate memory
> > > > access are referred to as "memory iniators". A "memory target" is a
> > > > node that provides at least one phyiscal address range accessible to a
> > > > memory initiator.
> > >
> > > I think I may be confused here.  If there is _no_ link from node X to
> > > node Y, does that mean that node X's CPUs cannot access the memory on
> > > node Y?  In my mind, all nodes can access all memory in the system,
> > > just not with uniform bandwidth/latency.
> >
> > The link is just about which nodes are "local". It's like how nodes have
> > a cpulist. Other CPUs not in the node's list can acces that node's memory,
> > but the ones in the mask are local, and provide useful optimization hints.
>
> So ... let's imagine a hypothetical system (I've never seen one built like
> this, but it doesn't seem too implausible).  Connect four CPU sockets in
> a square, each of which has some regular DIMMs attached to it.  CPU A is
> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
> special memory extender device attached on the PCIe bus.  Now there's
> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
> not as local as Memory B is ... and we'd probably _prefer_ to allocate
> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
> this seems hard.
>
> I understand you're trying to reflect what the HMAT table is telling you,
> I'm just really fuzzy on who's ultimately consuming this information
> and what decisions they're trying to drive from it.

The singular "local" is a limitation of the HMAT, but I would expect
the Linux translation of "local" would allow for multiple initiators
that can achieve some semblance of the "best" performance. Anything
less than best is going to have a wide range of variance and will
likely devolve to looking at the platform firmware data table
directly. The expected 80% case is software wants to be able to ask
"which CPUs should I run on to get the best access to this memory?"
