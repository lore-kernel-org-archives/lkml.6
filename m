Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721B9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EDD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeH3SKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:10:14 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37408 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeH3SKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:10:14 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so9957534qtl.4;
        Thu, 30 Aug 2018 07:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHZHt0ye/IrA8JrqHHfSjYTcILdqtj7X4aGCmlABFZk=;
        b=CRPdJWyuYZGP+euD0bVjR2D9reCWEV0omFkUtLM1swH+il4OPEWKtBtWGHT/GnTlnT
         eHeIO2i7AZOiOcmBePLVt1/rKS5h0kMuG+EXSnTxlSybkuSViFC4sA3oBzuH1kXwNXdu
         4NfDDaNOuMjiAtBoZnT9kMdxJaI9j/2RKd5fb/ypN1Td4PdPfmX5S4oIBEn9CtjuPkR4
         T4S5VIIwcwvUR9yeSEFqpqkdE+7TdBTtFn3hMId5xauaebVgKW2qG8AvZqjRF9qiBEUk
         dmjec2eueeVuEkftT2v0gMKUNJzxkQs+qPDqzQ2bnXj2ByD0xIVCqFp1L5uHHwVwdMEF
         DTmA==
X-Gm-Message-State: APzg51AAra8Z3xL8pUm68i6AaB1I9qqIEtrTJJjzX2k8A65lWEzvrUA2
        Nb7R5T5LA/TPEy+tZKnGz5ESUI9q9x8HHpF/b7s=
X-Google-Smtp-Source: ANB0VdZ/mVbtPoToxekz+4oizlUNUGGeWdwqnVtAHQ3Qt/4kzDc7/jMBg9v0sLhFVvPaqFe5HMvGjxotHJfUccGB+JY=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr11433010qkc.107.1535638075157;
 Thu, 30 Aug 2018 07:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com> <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
In-Reply-To: <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Aug 2018 16:07:39 +0200
Message-ID: <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> > > > If this is a regular PCI ethernet driver, why do you put it into driver/soc
> > > > rather than drivers/net/ethernet/ ?
> > >
> > > No, this is not a ethernet driver, as mentioned in the cover letter
> > > this driver and AF driver doesn't
> > > handle any IO. There will be a separate ethernet driver (will submit
> > > that as well in future) which will
> > > communicate with these drivers for configuring hardware.
> > >
> > > The driver in question here is for a serdes controller which handles
> > > physical ethernet interfaces.
> > > Admin function driver gathers info w.r.t current state of physical
> > > ethernet interfaces from this driver
> > > and notifies actual ethernet driver about changes, if any.
> >
> > Ok. Can you describe the structure that the PCI devices appear
> > in? It might help to be make the connection between the differnet
> > patches to understand how things fit together. In the final
> > picture, how many different pci_driver instances do you have,
> > and what part are they for?
>
> List of PCI devices are CGX, RVU PF0-PFn SRIOV physical functions
> and RVU VF0-VFn SRIOV virtual functions. No of VFs per PF is configurable
> and done by low level firmware.
>
> List of PCI driver instances would be CGX driver, RVU PF0 (i.e admin
> function) driver,
> PF1-PFn either netdev driver or crypto driver, VF0-VFn functionality would be
> same as their PF.
>
> The current plan is to have CGX driver, Admin function driver, PF
> netdev driver,
> VF netdev driver and PF/VF crypto drivers.

Ok, I think I understand the PF/VF distinction now. One (to me)
surprising aspect here is that you not just have one physical function
that you can use to assign resources to multiple virtual functions,
but also a second level of virtualization that is used to assign
resources to "physical functions" that are less physical than the
name suggests.

The part that I have not grasped yet is what the split between
the CGX and the AF is for, how they relate to one another, and
what the software abstraction for the two is going to be.

> > Is the idea that an ethernet device driver always attaches to a
> > virtual function that gets created by the main driver, and that
> > the two drivers share no interfaces on the kernel side, or do
> > you have multiple drivers linking to each other?
>
> Ethernet device driver can attach to both physical function and virtual function
> whose HW resources are provisioned by admin function driver.
>
> Yes the PF/VF ethernet drivers and these drivers won't share any
> kernel interfaces.
> Physical ethernet interface is owned by ethernet driver only, this driver just
> configures which ethernet driver instance uses which physcial interface.

Ok.

         Arnd
