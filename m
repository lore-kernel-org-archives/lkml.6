Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58873208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IW4YLQGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58873208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeGMPQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:16:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46197 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbeGMPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:16:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so13720014ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NBi05MrU2A563QxjjJRW6e6inYtkWLp2cu+E1TjM1G4=;
        b=IW4YLQGxkl8XUyjzjbpXkzrMXaFnlvMM+Ur19509Nd76g08AfjnFrSrRUPgn7Mcwf2
         dX9vUvXpxYdJDYvkr710vCkJTzc1JPPFEmwvFTfMqul4xduEav86WgLaf1gr5xfEveqW
         /BeicFF1fErD9V1npATUCF6tUqs92pSrKXVqakkjG7cCHf3GRD5Aaf8ngw7oSVvqUwOn
         lOFe+g9Qp19922IuoitvQsb0seQJmkUF+mtgmC1LVJod77l/e6dwu1ncxLDFb6vro6K7
         6Q6KY6KMreCNL+q0kQuQ74TZM1oGUbL1QZ4H8ndhflAuiqeMUBN1g1MUC34kDhGVDUYP
         eCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NBi05MrU2A563QxjjJRW6e6inYtkWLp2cu+E1TjM1G4=;
        b=M7ddnSrmtJBrKWXpBJ0eGkVtvGpcrQ148f2pX35sIDt/U5v3hYfw+aXkDz4iqasNyA
         4kwDQ65FVjscnUdzSuUFDiVHL00qa5oWe2r2bkYjneDZyiKRs0U79Cq4a0tOK2SNqn8N
         DdNZ+11zp0yqt3EkJArutPn24VLiO6E3KKO8cp5KwFoVfXxTLRb5FdXiNcXbbO1XeyzB
         GSFbSHY7EZF1Jm65skwedtEFrTYKAV1jZRC5FZFImtdX/ZdwOtbn596bspgsQ+u277k2
         5cfw8Kc2lxeQEktw6/R37UvpKEKgwMilcJZyq3ptnOfTtUPekc3ZNqf5VsVoEGB6p6b9
         6iNg==
X-Gm-Message-State: AOUpUlFsL8wzM6mIwc36IuY5uie0qetUrQ7MQeM/7UdQ7IPlptC0AvW8
        HkFDp3K4ojVyIPg62j/D3JQSuSrVDSBLgTq+gd0KBw==
X-Google-Smtp-Source: AAOMgpcjx11nkWktcEdFjuLWRxmGinSumukml0lADYZNQqjgTjSnYs+ZYLBQWb1p5ixJ1NXoYoo5CDYuXkXlH1P1Oq4=
X-Received: by 2002:a2e:5519:: with SMTP id j25-v6mr3449165ljb.124.1531494096162;
 Fri, 13 Jul 2018 08:01:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 08:01:34
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:e750]
In-Reply-To: <20180713145910.2mlzip5ssk72cleo@localhost>
References: <20180709200956.31158-1-labbott@redhat.com> <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr> <20180710093615.GA30095@arm.com>
 <20180713145910.2mlzip5ssk72cleo@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Jul 2018 08:01:34 -0700
Message-ID: <CAOesGMguQk_buucvNyKD6NmtdE0Re5_98Af+PME-HzZGHmeQGQ@mail.gmail.com>
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

On Fri, Jul 13, 2018 at 7:59 AM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
>> On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
>> > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
>> > > Thanks, Laura.
>> > >
>> > > I'll take this as a fix, and add a comment to the Makefile to justify
>> > > why we need the linux target.
>> >
>> > So this comes down to either breaking fedora/debian toolchains (that
>> > don't support elf emulation mode) or breaking bare-metal toolchains
>> > (that don't support linux emulation mode).
>> >
>> > Since Linux is a bare-metal project that does not technically require
>> > the linux target (who said using "Linux" for all things is confusing?),
>> > I think it should aim for the elf target in the long term.
>> >
>> > But well, breaking Linux build in common distros isn't good either, so I
>> > guess it makes sense to revert this while distros toolchains are being
>> > fixed. Hopefully, it won't take too long.
>> >
>> > What do you think?
>>
>> Yes, we need to revert the change since it's a regression otherwise. I think
>> the best course of action here would be to find a way that we can either
>> tell the linker that it doesn't need the missing linker scripts because
>> we're providing our own, or find a way to pass different LD flags depending
>> on whether or not we have a linux toolchain.
>>
>> For now, I've pushed the revert to for-next/fixes.
>
> Hi Will,
>
> This is regressed in mainline as well. But I think we can just use a (slightly
> improved) ld-option here? I checked it for x86 regression since it uses the
> one-argument version. Patch is here, can you pick that up instead and get it in
> for 4.18-rc?
>
> Thanks,
>
>
> -Olof
>
> From 0d73b2d1774d5edce20aac919ba356b61d098646 Mon Sep 17 00:00:00 2001
> From: Olof Johansson <olof@lixom.net>
> Date: Fri, 13 Jul 2018 07:56:11 -0700
> Subject: [PATCH] arm64: Fix build on some toolchains
>
> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones in
> particular. So, probe for whether it's available and use the previous
> (linux) targets if it isn't.
>
> Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> Signed-off-by: Olof Johansson <olof@lixom.net>

Of course, please add:
Reported-by: Laura Abbott <labbott@redhat.com>

or other suitable tag. Sloppy of me to miss.


-Olof
