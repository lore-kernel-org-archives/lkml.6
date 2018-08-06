Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A467BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ED7219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0734X0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ED7219EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHFLTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:19:47 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:51533 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:19:47 -0400
Received: by mail-it0-f43.google.com with SMTP id e14-v6so16466897itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RCZB0ZVFv8FIOgUmlL30m9L8ABGmQae2nWiAXL6pPFc=;
        b=e0734X0D6CvG96klnOoFsmXUrPtt1v4JBiUgYNtEV9cINU++NOIVLGMplBcpbldh1w
         9NFB5KOPnmO647JB3xfMQbtrSWBYBrjJt2JMTeSQk9kLDFiUD8fvHtAHUlUyZfhPgfIL
         Qrs1PW/74EtYCK6RwUa0gayixSs//gKvgrVbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RCZB0ZVFv8FIOgUmlL30m9L8ABGmQae2nWiAXL6pPFc=;
        b=GRulKTwS16IkOAR3io45YqhI/rHQaVNjQN/qtwTbGxLyq79sQ7158lAZ2BZIlH/nGL
         wOqIRjOAx+BdplVc00q9Po5OR1xJKoZVf2fwRWF8BvNcP/IkCdyNl8bmc69UdszV+C2U
         zJC8NDa89eZf/si87s+JkkYJwo6POsFa3YBgJacJ2Q8qMwZ8OJFbtPb/WwMgILRRePmT
         0y7/2J3E5wP9xQhIyaELpDJj6dgLtwOZJjxdRItlgWCQvpOMe7x9ZgOnlaOfNgGHVEXG
         nVV3YZSmd9olVC4sUkM0/XMsCMwkfBlxkwRnNjiahFgp4b8ALbtJXLqJEnrysR+J6XnA
         4qCA==
X-Gm-Message-State: AOUpUlG1CRIyaWBWs66aMuFX6vxGuRRgZq1bF08v9/2ogCVChYksVnNe
        r2nzQ4kdIT/EA4+hxsuhZ42xt6F7Av117lXAf2gv5Q==
X-Google-Smtp-Source: AAOMgpedlfzvsl+8ZPHIZci03tyCkdiNg248ye3PWmyMG0lw0j5mM/r7V4lG4RlwooyKaHn8yWZxoE1VSWXPiJdl568=
X-Received: by 2002:a24:5242:: with SMTP id d63-v6mr14568370itb.138.1533546699871;
 Mon, 06 Aug 2018 02:11:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 02:11:39 -0700 (PDT)
In-Reply-To: <20180806084451.GB19523@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <20180805213615.GA1862@amd> <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
 <20180806084451.GB19523@amd>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 11:11:39 +0200
Message-ID: <CAKv+Gu8XX=MVhiO5H_0kWokB3vxEjTX_X41aR9N_WXqKwEUzkA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 10:44, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-08-06 09:04:33, Ramana Radhakrishnan wrote:
>> On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
>> >> > strange problem.
>> >> >
>> >> > When I use the links browser in graphics mode on the framebuffer, I get
>> >> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
>> >> > on the framebuffer - nothing else.
>> >> >
>> >> > I found out that the pixel corruption is caused by overlapping unaligned
>> >> > stp instructions inside memcpy. In order to avoid branching, the arm64
>> >> > memcpy implementation may write the same destination twice with different
>> >> > alignment. If I put "dmb sy" between the overlapping stp instructions, the
>> >> > pixel corruption goes away.
>> >> >
>> >> > This seems like a hardware bug. Is it a known errata? Do you have any
>> >> > workarounds for it?
>> >>
>> >> Yes fix Links not to use memcpy on the framebuffer.
>> >> It is undefined behavior to use device memory with memcpy.
>> >
>> > No, I don't think so. Why do you think so?
>>
>> It is undefined behaviour in the architecture.
>
> Why do you think so? Pointer to documentation would be helpful.
>
> Normal access is used for mmapped areas, and I don't think we want to
>  change that.

Pavel,

In this context, 'device mapping' specifically means one of the
Device-{G,nG}{R,nR}{E,nE} mapping attributes as defined by the ARM
ARM, where G, R and E stand for Gathering, Reordering and Early
acknowledgement, respectively.

There is no disagreement whether memcpy() is suitable for such regions
- it is not. These mappings are intended for memory mapped device
registers, not for memory.

The issue under discussion here is whether PCIe can provide outbound
windows with true memory semantics, which is the assumption that is
present all throughout the Linux graphics stack.
