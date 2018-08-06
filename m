Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267421A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="lwf7pWpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267421A29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeHFQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:17:09 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36330 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHFQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:17:09 -0400
Received: by mail-it0-f44.google.com with SMTP id p81-v6so18331211itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jB+b2rQfqYqiW/BTiYcRUZHBqMB7h8NsIMT4NbCUBiE=;
        b=lwf7pWpb+29Kby5cOzw4m3UmLdvTBdwPIi+DIZBBHpwwhjVx6Ik+5heWmT+2e8vrzS
         u+hehcs6+oW0RyqxxuAALnnSUDGuv/SxzsrSvnDtaUhv9ILa7SAAzAz4FZ4YmBKsXbc0
         H/9a4RRHo/053pCjrw9iVQQmAfGRoB/W0NslXOg5UjWB+QyEtE/4svxpEEKrSoTrqFZm
         zPfi/pBzYfDn670XipomYKaVrOLp7ZEp7tyA8k0yMJY4xJblSUv8fVxJeD8x6OAeDULg
         5JGDjib39zfrrVQxU1G5nypALGSh049GItXZDeugwC3GVSfTFx7ns3VHsyfAE6kcZp7c
         pFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jB+b2rQfqYqiW/BTiYcRUZHBqMB7h8NsIMT4NbCUBiE=;
        b=au3uCW63u6MdxWDgr6uZuP4eRCys+55yy3Y/oV524kxkDoehQEl9mCjGKZFD+SgelK
         Ba5qU881YYoUMk94aWwV6BFRYF583/YFpUAoOubAwcePsyse0qT9y6gx48S3QQkPy5jU
         l7l0mqmFZMcuid1kBu3Dlu6jKoBxoUgKzt6CrcTSZkbnSH3mh3jllOYslZx2n3Ew5l/p
         vJswfUCuhw60Ewf5tMc/RNMCHXt4GFnTpTaHKZDuwucBLqsoCsNSS3egzL+qwGGwtdAa
         jWed47WzwwlpGP/vZhUpCh2XcFZxEnfxIUilrjgGMn8df/M7bLMbTkAvAeqpUtfKmyHw
         9tbA==
X-Gm-Message-State: AOUpUlEMtFSFT0jnwbFct7AGxdUSuxq7V39BxNRqEB5bO7xRip9nCeRE
        SRwHgJUcrwXxRPJsQpTTk4uQigGM9L1V14phKH8I3w==
X-Google-Smtp-Source: AAOMgpeJZUCncJ6bXngTFAAtc/yRXRVRXOLS26ff12d//F9qi0Bq4Ymi/YkKq1RNg8mK8dOhCZIeBVy9NDzMiW041QM=
X-Received: by 2002:a02:7e82:: with SMTP id g2-v6mr13295449jae.80.1533564472124;
 Mon, 06 Aug 2018 07:07:52 -0700 (PDT)
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
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com> <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com>
 <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 6 Aug 2018 16:07:39 +0200
Message-ID: <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, mpatocka@redhat.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
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

Hi Ard, Mikulas,

pon., 6 sie 2018 o 15:48 Ard Biesheuvel <ard.biesheuvel@linaro.org> napisa=
=C5=82(a):
>
> On 6 August 2018 at 15:41, Marcin Wojtas <mw@semihalf.com> wrote:
> > Hi Mikulas,
> >
> > pon., 6 sie 2018 o 14:42 Robin Murphy <robin.murphy@arm.com> napisa=C5=
=82(a):
> >>
> >> On 06/08/18 11:25, Mikulas Patocka wrote:
> >> [...]
> >> >> None of this explains why some transactions fail to make it across
> >> >> entirely. The overlapping writes in question write the same data to
> >> >> the memory locations that are covered by both, and so the ordering =
in
> >> >> which the transactions are received should not affect the outcome.
> >> >
> >> > You're right that the corruption couldn't be explained just by reord=
ering
> >> > writes. My hypothesis is that the PCIe controller tries to disambigu=
ate
> >> > the overlapping writes, but the disambiguation logic was not tested =
and it
> >> > is buggy. If there's a barrier between the overlapping writes, the P=
CIe
> >> > controller won't see any overlapping writes, so it won't trigger the
> >> > faulty disambiguation logic and it works.
> >> >
> >> > Could the ARM engineers look if there's some chicken bit in Cortex-A=
72
> >> > that could insert barriers between non-cached writes automatically?
> >>
> >> I don't think there is, and even if there was I imagine it would have =
a
> >> pretty hideous effect on non-coherent DMA buffers and the various othe=
r
> >> places in which we have Normal-NC mappings of actual system RAM.
> >>
> >> > I observe these kinds of corruptions:
> >> > - failing to write a few bytes
> >>
> >> That could potentially be explained by the reordering/atomicity issues
> >> Matt mentioned, i.e. the load is observing part of the store, before t=
he
> >> store has fully completed.
> >>
> >> > - writing a few bytes that were written 16 bytes before
> >> > - writing a few bytes that were written 16 bytes after
> >>
> >> Those sound more like the interconnect or root complex ignoring the by=
te
> >> strobes on an unaligned burst, of which I think the simplistic view
> >> would be "it's broken".
> >>
> >> FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x
> >> Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, a=
nd
> >> it's still happily flickering pixels in the corner of the console afte=
r
> >> nearly an hour (in parallel with some iperf3 just to ensure plenty of
> >> PCIe traffic). I would strongly suspect this issue is particular to
> >> Armada 8k, so its' probably one for the Marvell folks to take a closer
> >> look at - I believe some previous interconnect issues on those SoCs we=
re
> >> actually fixable in firmware.
> >>
> >>
> >
> > On my Macchiato I use GT630 card (nuveau driver) + debian + xfce
> > desktop and in dual monitor mode, I could run a couple of 1080p
> > streams. All smooth and I've never noticed any image corruption
> > whatsoever (I spent a lot of time in front of such setup). Just to be
> > on a safe side, can you send me a bootlog and your board revision? I'd
> > like to see your firware version and type.
> >
>
> Hi Marcin,
>
> Could you please try running his reproducer?

This is exactly what I plan to do, as soon as I can plug my GFX card
back to the board (tomorrow). Just to remain aligned - is it ok, if I
boot my debian with GT630 plugged, compile the program with -O2 and
simlply run it on /dev/fb0?

Best regards,
Marcin
