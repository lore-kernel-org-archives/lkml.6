Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E73ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47B320878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="n0fI6AH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47B320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbeGMPa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:30:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36623 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbeGMPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:30:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so22151765lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0dvCFjBNiEogQllyKAyhVPUbq7FYRGAoaPpU9aGIn/U=;
        b=n0fI6AH7M1Z04lk2KfujUE5WUOWe4F2DE2uEQWd9nskRFgThBCsMrG6IPfqcV+/fRI
         IisAi+/ksjij2ZiIXTjMPe7/AJO7glmiaKr6hEpUk379OZKXIbfAfE93EcvKC0DYU78m
         fgoDiHGZEPebYVbEnB6c9JX8mJHIDvIW2/6Yei5Z8ei4lAJc73d69F+v6+dTo5PS8sWa
         Qw755V8+J06J63eyfGt9M8m9BMxinUSM9Zb52ZffRN1qaqVbXhZ1V5762SOyvdPW1NRZ
         nJVQIk8NCpqPN8ETN5AO4Ay9odgvfSLnDR2i4X3DWzBnDxReWzNr90IPfn3sLSrVCglc
         Coqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0dvCFjBNiEogQllyKAyhVPUbq7FYRGAoaPpU9aGIn/U=;
        b=KFwZVuqtBvQ40LEjqvXBkqvuFSlcQzxLe2iaTnT0VADVsoIq9UVLo023rtbqX/A3KS
         FBaGLB4Y0wUQrHiIV5XknX5RRIDg0irWuzYCUCBHOKmWkgi+HKdA3095Ie5WFyJ2w30V
         89QuEiV3ZGKPfV+3SlcGYKMoe/amfwWQV/NK9NHNeju2KUsAvOb7+uT1sOofxbRgD83p
         Wbj20bLsByEA7/JkPltWfL8FbOGgVCZuI3aQoZBIeuS1BHyG46iByuEKuavPzWnxXwiR
         4FCqMmlAvbv8jgXXsY1DJ6Oc362Aw2185ylmWJV+38QcAzsMG5Bt3KgyA87ILFO4p7jP
         qWJA==
X-Gm-Message-State: AOUpUlENheFevI633Jiv18oHgD+JdTVZJ/hKhi03kFQg9uzcMLHTxvra
        CsSFA5KtHWVSI02O0HZZ8sMB2widkkM7e2xqKfr8cQ==
X-Google-Smtp-Source: AAOMgpfJJEgQY3cUD6vFq0HtdI7rdnn3Xx8yjuTpjZV8I7NmVcswPKNxEYpGLoZc7xPiq4A2K6o/qGFIqIKDhv5TJV4=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr3640351lje.129.1531494954226;
 Fri, 13 Jul 2018 08:15:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 08:15:52
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:e750]
In-Reply-To: <20180713150701.GA3049@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com> <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr> <20180710093615.GA30095@arm.com>
 <20180713145910.2mlzip5ssk72cleo@localhost> <20180713150701.GA3049@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Jul 2018 08:15:52 -0700
Message-ID: <CAOesGMhAe=r=TNuTr_u59h2YwL7A_KzEooGtWUc0jM9jfHOO-w@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
To:     Will Deacon <will.deacon@arm.com>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        Laura Abbott <labbott@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 8:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Olof,
>
> On Fri, Jul 13, 2018 at 07:59:10AM -0700, Olof Johansson wrote:
>> On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
>> > On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
>> > > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
>> > > > Thanks, Laura.
>> > > >
>> > > > I'll take this as a fix, and add a comment to the Makefile to justify
>> > > > why we need the linux target.
>> > >
>> > > So this comes down to either breaking fedora/debian toolchains (that
>> > > don't support elf emulation mode) or breaking bare-metal toolchains
>> > > (that don't support linux emulation mode).
>> > >
>> > > Since Linux is a bare-metal project that does not technically require
>> > > the linux target (who said using "Linux" for all things is confusing?),
>> > > I think it should aim for the elf target in the long term.
>> > >
>> > > But well, breaking Linux build in common distros isn't good either, so I
>> > > guess it makes sense to revert this while distros toolchains are being
>> > > fixed. Hopefully, it won't take too long.
>> > >
>> > > What do you think?
>> >
>> > Yes, we need to revert the change since it's a regression otherwise. I think
>> > the best course of action here would be to find a way that we can either
>> > tell the linker that it doesn't need the missing linker scripts because
>> > we're providing our own, or find a way to pass different LD flags depending
>> > on whether or not we have a linux toolchain.
>> >
>> > For now, I've pushed the revert to for-next/fixes.
>>
>> Hi Will,
>>
>> This is regressed in mainline as well. But I think we can just use a (slightly
>> improved) ld-option here? I checked it for x86 regression since it uses the
>> one-argument version. Patch is here, can you pick that up instead and get it in
>> for 4.18-rc?
>
> I already sent the revert to Linus, but I can certainly queue the ld-option
> for 4.19 if we pick up some more tested-bys. Could you send it out as its
> own patch please?

Definitely, separate email shortly.


-Olof
