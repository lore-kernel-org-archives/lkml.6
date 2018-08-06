Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B1AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D560D208E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd3m+iXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D560D208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeHFP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:57:42 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:50849 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHFP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:57:42 -0400
Received: by mail-it0-f46.google.com with SMTP id j81-v6so15707880ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eNS0ikWuOr1riUnoVxKwuO0tUIWLAzWdBq8R1jryiJE=;
        b=Hd3m+iXONIvfUjJ4K7qOkH/xiSDmgS9OwWHzqmErF3aV1oyB3IKAbJH0GabwK/vcDz
         BsEFkVW2ts35soT3y47eWtEw2YwWniedi0KnFwp2Ec+G0P0kqOOyVC0saYL3hVBq5aFo
         Q+bE3rqrr9rEqlxlwBQxPrhOwGoo26/KDEBKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eNS0ikWuOr1riUnoVxKwuO0tUIWLAzWdBq8R1jryiJE=;
        b=Kb7IcqugZnwZPP651F778I78NPxzO9EgRx8atMLuyx6fh7xLdQVNA47XNP0KWDUjRM
         vjfhzKxTnQX61TM+IWo8Dssau554A7meYvT873AwXn5q4sXpdwmZa12FVepMXbjVKw2X
         8HPHQ8sfQ7s3lksgUIyea4Hi6t/js1A+8kpBh6tlsJkW0X4nS+FbRs6dE0bTKwt4dIbn
         eVhxLU0mGclvOMNkVCl2Qpu9l1RsdZqN1N4cWWlPu+ksZZGfvejDaGPZvBIlS37cE6nT
         1iGX4RRjg1pyGLzF7Bgk+a/iXxejyvx+kgnUd/FKsJFDb6DfHIFnqV6PP9vAQw/C+1ge
         LXiQ==
X-Gm-Message-State: AOUpUlFOZWEDyQ/47IHxWrWE0czkVgB3XUx84aF8lP7dORfhtx02hd8j
        17xtJi2lF9DqsXFneV41N9fmXVQXRp8gALSpX0NC1Q==
X-Google-Smtp-Source: AAOMgpfo70cngSuMZLv+8hEZXFk1lhoGwQE3lnTqiiVCz20Sy1KE/CP6Nq83MvfSM6Hp/rfnSsAB2YnFYfVofoXPOwQ=
X-Received: by 2002:a24:148c:: with SMTP id 134-v6mr15103492itg.50.1533563309700;
 Mon, 06 Aug 2018 06:48:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 06:48:28 -0700 (PDT)
In-Reply-To: <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com>
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
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 15:48:28 +0200
Message-ID: <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 15:41, Marcin Wojtas <mw@semihalf.com> wrote:
> Hi Mikulas,
>
> pon., 6 sie 2018 o 14:42 Robin Murphy <robin.murphy@arm.com> napisa=C5=82=
(a):
>>
>> On 06/08/18 11:25, Mikulas Patocka wrote:
>> [...]
>> >> None of this explains why some transactions fail to make it across
>> >> entirely. The overlapping writes in question write the same data to
>> >> the memory locations that are covered by both, and so the ordering in
>> >> which the transactions are received should not affect the outcome.
>> >
>> > You're right that the corruption couldn't be explained just by reorder=
ing
>> > writes. My hypothesis is that the PCIe controller tries to disambiguat=
e
>> > the overlapping writes, but the disambiguation logic was not tested an=
d it
>> > is buggy. If there's a barrier between the overlapping writes, the PCI=
e
>> > controller won't see any overlapping writes, so it won't trigger the
>> > faulty disambiguation logic and it works.
>> >
>> > Could the ARM engineers look if there's some chicken bit in Cortex-A72
>> > that could insert barriers between non-cached writes automatically?
>>
>> I don't think there is, and even if there was I imagine it would have a
>> pretty hideous effect on non-coherent DMA buffers and the various other
>> places in which we have Normal-NC mappings of actual system RAM.
>>
>> > I observe these kinds of corruptions:
>> > - failing to write a few bytes
>>
>> That could potentially be explained by the reordering/atomicity issues
>> Matt mentioned, i.e. the load is observing part of the store, before the
>> store has fully completed.
>>
>> > - writing a few bytes that were written 16 bytes before
>> > - writing a few bytes that were written 16 bytes after
>>
>> Those sound more like the interconnect or root complex ignoring the byte
>> strobes on an unaligned burst, of which I think the simplistic view
>> would be "it's broken".
>>
>> FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x
>> Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, and
>> it's still happily flickering pixels in the corner of the console after
>> nearly an hour (in parallel with some iperf3 just to ensure plenty of
>> PCIe traffic). I would strongly suspect this issue is particular to
>> Armada 8k, so its' probably one for the Marvell folks to take a closer
>> look at - I believe some previous interconnect issues on those SoCs were
>> actually fixable in firmware.
>>
>>
>
> On my Macchiato I use GT630 card (nuveau driver) + debian + xfce
> desktop and in dual monitor mode, I could run a couple of 1080p
> streams. All smooth and I've never noticed any image corruption
> whatsoever (I spent a lot of time in front of such setup). Just to be
> on a safe side, can you send me a bootlog and your board revision? I'd
> like to see your firware version and type.
>

Hi Marcin,

Could you please try running his reproducer?
