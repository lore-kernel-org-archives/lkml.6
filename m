Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6B3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCFE2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpLK7tj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCFE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeH3Nl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:41:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37463 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeH3Nl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:41:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1296812wmc.2;
        Thu, 30 Aug 2018 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPi5e3P9wsxI6O7hE6GCCo0V0rIVB55LtevGGPA7Z4Y=;
        b=rpLK7tj8Og6PEZpCwcgH10AAbRmY37VaNZxfR6q3z+TKJOFRugylyJ3v03MmKBP49a
         ZPSGKT/gLeZ8BD3JJRWR2x1tJ2/BKvh5NKymOQhVzwLPndXmE14vNzt6OqjhbYX+gtpc
         +mW3sfnft2IxY6BnR2ZTACzy9XlSbb8MDFXHVc8LATl8RVtb5DuMq4XpxyGte9RDw0X1
         SkyQU5/5IwAWMw3iBunYADJlDEA2/3oMfSXuKKMEN2VfJIzszrw11AAqe+EcRWUV3v59
         M+3v5Zc/7oxBF9Uzb7Cb5Drtz2UyFZcEkctj8qht85UWoZcJ7+nVAyPkpqbObcxkFnmp
         7CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPi5e3P9wsxI6O7hE6GCCo0V0rIVB55LtevGGPA7Z4Y=;
        b=GSzUS4X/ZkMnw06d5gpfNvngLyQhUysHduqCwrYg2vGPJCzzpa7JAxTfUr0gIK2aQ+
         bw3b1w2souA8Nw66YHMipRRvBMiKuiOtQYVaZuGcZQUNxA1FADSANKYeA2mf5qLuCRL7
         22oySSb/JOlFw8chbZ8aJLw/F+M2BllxhNZyBm8l74xmCqhWZJVX3GJozzG6SLCUtoib
         sgQufUuejeVrO2KLDnfiJ2AeFRaH3OAiTVJsMBug/RGe9BwuUzlozn91biv9UL59gAZq
         GPklYqkB9UkWY3l5LfAN2HvaJf7FapPKIK8QoNdBaelFvdzyYel8+7AfqDXIUIn1h50r
         bXUg==
X-Gm-Message-State: APzg51DKa0LLdcbqBwFDxQjsWEpp0gYzfGmQ7z1Lvxy//EI+/FYyz8R+
        WV/MW+Vxl0GmoGhijIiW6niDUuwuYc7TGGJ0WuaYFA==
X-Google-Smtp-Source: ANB0VdZnmC46xPKPCJg2mima/tnzzXtQh2+l46v7d6tqqfezjJOxbeMkiVy+8QaswUG8R5u5JcYLTrCOm1ZVFHZaF20=
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr1239500wme.139.1535622038374;
 Thu, 30 Aug 2018 02:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com> <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
In-Reply-To: <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Thu, 30 Aug 2018 15:10:26 +0530
Message-ID: <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 6:54 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 5:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > From: Sunil Goutham <sgoutham@marvell.com>
> > >
> > > Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> > > multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> > > PF0 is called administrative / admin function (AF) and has privilege access
> > > to registers to provision different RVU functional blocks to each of
> > > PF/VF.
> > >
> > > This admin function (AF) driver acts as a configuration / administrative
> > > software which provisions functional blocks to a PF/VF on demand for them
> > > to work as one of the following
> > >  - A basic network controller (i.e NIC).
> > >  - NIC with packet filtering, shaping and scheduling capabilities.
> > >  - A crypto device.
> > >  - A combination of above etc.
> > >
> > > PF/VFs communicate with admin function via a shared memory region.
> > > This patch series adds logic for the following
> > >  - RVU AF driver with functional blocks provisioning support
> > >  - Mailbox infrastructure for communication between AF and PFs.
> > >  - CGX driver which provides information about physcial network
> > >    interfaces which AF processes and forwards required info to
> > >    PF/VF drivers.
> > >
> > > This is the first set of patches out of 70 odd patches.
> > >
> > > Note: This driver neither receives any data nor processes it i.e no I/O,
> > >       just does the hardware configuration.
> >
> > Hi Sunil,
> >
> > Thanks for posting this first series, I'm glad we're seeing support for this
> > chip family making some progress.
>
> Thanks.
>
> >
> > My feeling overall is that we need a review from the network driver
> > folks more than the arm-soc team etc, and that maybe the driver
> > as a whole should go into drivers/net/ethernet.
>
> This driver doesn't handle any network IO and moreever this driver has to handle
> configuration requests from crypto driver as well. There will be
> separate network and
> crypto drivers which will be upstreamed into drivers/net/ethernet and
> drivers/crypto.
> And in future silicons there will be different types of functional
> blocks which will be
> added into this resource virtualization unit (RVU). Hence i thought
> this driver is not a
> right fit in drivers/net/ethernet.
>
> >
> > We support some couple of similar hardware already that has
> > both support for virtual functions and for crypto offload, including
> > the Chelsio cxgb4, Mellanox mlx5, NXP DPAA and probably others,
>
> I agree, but i guess that is done to support inline crypto.
> Here this driver has to handle requests from normal crypto driver
> (drivers/crypto) as well.
>
> > and we need to ensure that the exposed interfaces are all
> > compatible, and that you use the correct subsystems and
> > in-kernel abstractions for thing that are common.
> >
> >       Arnd

Hi Arnd,

I hope i have answered your queries.
Let us know if you have any more queries or feedback w.r.t to a
individual patch or the patchset on the whole.

Thanks,
Sunil.
