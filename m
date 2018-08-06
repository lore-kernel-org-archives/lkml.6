Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F59C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06A721A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="IlKdP9NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06A721A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbeHFPu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:50:57 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:46806 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeHFPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:50:57 -0400
Received: by mail-io0-f177.google.com with SMTP id i18-v6so11007528ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L0G6oMYYhD0NxNhpbcFNQ4gfl9x0Q4SL5Gu+ZGMDyi0=;
        b=IlKdP9NOR+27FOl5X6DjKR1Jas98ynFaCVebwxEMtsg+X5hZP7UdcJI1I2tVQTrrtL
         9dv3Zvgtd7+y1GoZh4E0RAQ4V4O/FlZvEsmNOxxiRWLFFRR4fXHazLQOqomhgmn/X3lh
         dQPrPf/VI5XV2hZfCU1j8jgSJMnH7FOsC7fkexhLrSM9rmHrdlx6la6d1TMGaJICR0WP
         YqRKx6BNs5AoGAy73EOYhCU6OWW+8zkMcTq3kZvNv5zNLvMeKRegI7sSNnW5L1px9qPr
         BtDHrE6YAxDcbnXKa8QtDln5uVcHgX/8Z3BOjgizdQwvY01WGFr/jOcISqOXS5MWR1g3
         k3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L0G6oMYYhD0NxNhpbcFNQ4gfl9x0Q4SL5Gu+ZGMDyi0=;
        b=GM2ARHHLU2M5i3lHVbMc2qI8e/lpv72WJknoUD/IfU3lJwMnXpMHGkDk9crm+twAuP
         fik2WnBGk4CLAdaKZW3ZWrJHxEgiehZm7pvEMCG7eX7/MQpWT7FFbSj+GuZ7bXvJggPa
         uvodVDbtBAp+1+78SqtboWs0y9sMkSu9kIaRMX5u79R22iWvQQvN1PQfrleotxmafLFZ
         Q76qtO/abJyNbtPSqDj2YhSIMvMj69+d7ZoG49+sz39mRkHbbNbLjnV2PQDyTNr2m6Sr
         gTjCiRlE2iI1Us16qt6OvBpOS8ZyjqfhdxKcA6H8EjGD4R6a781zlmXT3rsMztIvK34g
         bIdA==
X-Gm-Message-State: AOUpUlE3vvK32diX7fIcjbaw80OgeSa2fn6F4Y7iN/0c59+xlo1wy23Z
        e588zQabEBk6g3rs9FRtZA6cDVMkCuc1lenjuiZ85Q==
X-Google-Smtp-Source: AAOMgpcJYVlA0+nXTi+X32SgMsM70LkQeJGOKT512OSNqYLLnepvlNfoUDJ8e97DfxYqIlNwszbDYPfFGJs2p0ULb20=
X-Received: by 2002:a5e:c60c:: with SMTP id f12-v6mr15916104iok.108.1533562906924;
 Mon, 06 Aug 2018 06:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
In-Reply-To: <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 6 Aug 2018 15:41:34 +0200
Message-ID: <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     mpatocka@redhat.com
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikulas,

pon., 6 sie 2018 o 14:42 Robin Murphy <robin.murphy@arm.com> napisa=C5=82(a=
):
>
> On 06/08/18 11:25, Mikulas Patocka wrote:
> [...]
> >> None of this explains why some transactions fail to make it across
> >> entirely. The overlapping writes in question write the same data to
> >> the memory locations that are covered by both, and so the ordering in
> >> which the transactions are received should not affect the outcome.
> >
> > You're right that the corruption couldn't be explained just by reorderi=
ng
> > writes. My hypothesis is that the PCIe controller tries to disambiguate
> > the overlapping writes, but the disambiguation logic was not tested and=
 it
> > is buggy. If there's a barrier between the overlapping writes, the PCIe
> > controller won't see any overlapping writes, so it won't trigger the
> > faulty disambiguation logic and it works.
> >
> > Could the ARM engineers look if there's some chicken bit in Cortex-A72
> > that could insert barriers between non-cached writes automatically?
>
> I don't think there is, and even if there was I imagine it would have a
> pretty hideous effect on non-coherent DMA buffers and the various other
> places in which we have Normal-NC mappings of actual system RAM.
>
> > I observe these kinds of corruptions:
> > - failing to write a few bytes
>
> That could potentially be explained by the reordering/atomicity issues
> Matt mentioned, i.e. the load is observing part of the store, before the
> store has fully completed.
>
> > - writing a few bytes that were written 16 bytes before
> > - writing a few bytes that were written 16 bytes after
>
> Those sound more like the interconnect or root complex ignoring the byte
> strobes on an unaligned burst, of which I think the simplistic view
> would be "it's broken".
>
> FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x
> Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, and
> it's still happily flickering pixels in the corner of the console after
> nearly an hour (in parallel with some iperf3 just to ensure plenty of
> PCIe traffic). I would strongly suspect this issue is particular to
> Armada 8k, so its' probably one for the Marvell folks to take a closer
> look at - I believe some previous interconnect issues on those SoCs were
> actually fixable in firmware.
>
>

On my Macchiato I use GT630 card (nuveau driver) + debian + xfce
desktop and in dual monitor mode, I could run a couple of 1080p
streams. All smooth and I've never noticed any image corruption
whatsoever (I spent a lot of time in front of such setup). Just to be
on a safe side, can you send me a bootlog and your board revision? I'd
like to see your firware version and type.

Thanks,
Marcin
