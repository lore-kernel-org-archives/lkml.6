Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D7721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RiFSGZo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D7721557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeHXTNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:13:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35337 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeHXTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:13:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so7209502ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tasj2NiXLPdtD0MrrwkTNPbne5CEOGFnTahzuE2KIvg=;
        b=RiFSGZo+bN6fC81OfLfXpic+Ah7NMQJcKw191jJ05zTg3eGiN/w33DsF+lfCaoa77d
         SCAz2ndQZ6CKv6HRAKdAP50qy+BUoZtPhGJYV5zOLSsd4+I0KJMp9xREg++jWZ/eQIGF
         p9GWy2qqghTdahibLMo5SzcuNZlM6LyG8jNOrwcEQMGifBNvbHvErMFU/bd1TJM64FWT
         D9+xgMC+hOx3lKIuJ/J+ACyqbZsBlmbd/8A5SIVXUiqwkgqxB2/pS2cNu6gmRluxujkm
         4e4U6rOvtFpkByViB12A37eTN0Br2pnvd2jltgbiDLHq8XlQ5KE+tfPAVGhGh3sbe+dq
         zVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tasj2NiXLPdtD0MrrwkTNPbne5CEOGFnTahzuE2KIvg=;
        b=HrSLH2ZA/GfJ/4csjRaTrUgD5fbbD0OycaT0UZPL1uUi87QPz6eLnyfm8SuoN4/N1F
         xLXbAQov+BQe85iLZM/btbrSGwRbgGvmu3ToX7D3g8/LhKYV6vsB3BmQaJMWo1c/BS9s
         9NjH5AxjeHqM7EwvJbvu7zYyPUMQnQY05HLp7soFrauJwwhU93E1pgMy2oKi8nSpx9/N
         2ZODHsQAD8rsszkJtBjly2LDme8G7i8i3wUjtVaf4l67IjX4FRk4H+8IPpJp1kbVUuA6
         S8xbYHTMm7pBkLsGmEoX33COYbxJlJvvywsfyGIuybIrCKT4ouAwOmbM6bG4nmJw6TI0
         8dLQ==
X-Gm-Message-State: APzg51A88su/eNiteHvnTSwWXDn8e7rGROIFD6JDrHdrCdSs7xbHUFK0
        T2oI5KDM6D1R3tBBv/Nk+A8mPiC8CW7fbkbXAPnMPg==
X-Google-Smtp-Source: ANB0VdbDmWENXwjzBze09daHjiQib4icHUgAdqp3jzjvUUpiNkkUJDsD2qAhyJ9+HegXSXt3Os+xtTZMbsJKn4A75tU=
X-Received: by 2002:a2e:8188:: with SMTP id e8-v6mr1714882ljg.138.1535125085828;
 Fri, 24 Aug 2018 08:38:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:dd41:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 08:38:04
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::7:ad41]
In-Reply-To: <CAHLCerNoRj6GQRF=NJXwc0U+mJNe=06JGADQr7uT-chD2W-J+A@mail.gmail.com>
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
 <20180823153110.GA19131@e107155-lin> <CAHLCerNoRj6GQRF=NJXwc0U+mJNe=06JGADQr7uT-chD2W-J+A@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 24 Aug 2018 08:38:04 -0700
Message-ID: <CAOesGMjcs=h4DHn7coo5iixUUY2GR2wWeTyMWQ_SBE9rrPZQgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 1:02 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> (Adding arm-soc folks)
>
> On Thu, Aug 23, 2018 at 9:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Amit,
>>
>> Thanks for fixing this.
>>
>> On Thu, Aug 23, 2018 at 02:23:29PM +0530, Amit Kucheria wrote:
>>> The idle-states binding documentation[1] mentions that the
>>> 'entry-method' property is required on 64-bit platforms and must be
>>> set to "psci".
>>>
>>> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
>>> bindings examples") attempted to fix this earlier but clearly more is
>>> needed.
>>>
>>
>> In fact, I assumed I fixed things with commit 978fa436231a ("drivers:
>> firmware: psci: unify enable-method binding on ARM {64,32}-bit systems"),
>> but I was wrong. I left quite a few instances including juno dtbs.
>>
>>> Fix the cpu-capacity.txt documentation that uses the incorrect value so
>>> we don't get copy-paste errors like these. Clarify the language in
>>> idle-states.txt by removing the reference to the psci bindings that
>>> might be causing this confusion.
>>>
>>> Finally, fix devicetrees of various boards to reflect current
>>> documentation.
>>>
>>> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
>>> idle-states node)
>>>
>>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>>>  Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
>>>  arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
>>>  arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
>>>  arch/arm64/boot/dts/arm/juno.dts                       | 2 +-
>>
>> For all the above files,
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Thanks for reviewing, Sudeep.
>
>> How do you plan to merge ? I prefer if you can send it via arm-soc as
>> fixes for this cycle with all the necessary acks. Otherwise you may have
>> to split this to send via platform maintainers which is bit mundane.
>
> I was hoping to get this merged thru arm-soc tree instead of creating
> a patch per platform. But if anybody feels strongly about it, I'm
> happy to split them up and feed it through the platform maintainer
> trees.

Given that we're at the tail end of the merge window, before -rc1,
it's easiest if we just take it directly and platform maintainers base
their new contents on top of it.

Applying to our next/late (i.e. merge-window-fixes) branch now.


-Olof
