Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95771C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DB92081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="G5ZjkcDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DB92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeKKDzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:55:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41931 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:55:24 -0500
Received: by mail-io1-f67.google.com with SMTP id r6-v6so792053ioj.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQCRPjLT5ADBBh2+pgkugpl73/0Iv6X44wk+2O0TplM=;
        b=G5ZjkcDGEaMCXId5Hx3bLnR73iExcRIdGqr+Q9EWfp6rvLnpXHasVcOwTy7iuThGHU
         Mc/oPt5XzXcrL/QxM7Rh5vZ7Yqq19y59kZNCvg57PEHrkrC9iUFU26ZGxQSiySeXrvKk
         T77/Fwpq59/UmGANwAEz1dhFMnvlo5WLNpG88ZjbpWSzakI1TJY18k9OB9/BDSsWDjDv
         UCuORXFD1PJLyUMJKc9z+J7AqlMQbxAVaQET1kfZ9D4sGaffOU/42kZYB1W3ZgnaWiTQ
         qdcdtrRHtr6EeZS/2zNQmOeD8qpczy+42zxdhG6V5TcmMFoXZX/LuUpKuGYp+avtAJZ2
         ZQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQCRPjLT5ADBBh2+pgkugpl73/0Iv6X44wk+2O0TplM=;
        b=pZI8TYyPHRS2RzOlnrJww3+qHuIiMXs0ulbu6CaKX7RDYAk1zck9+QJDkQ6RG66uiY
         fxVhmnJ1HPta+kW1Aq8QZ7ZW+L/Dp20046a2TPay0WikLVGP5gTornxLioL5sbmdQrwM
         8wUgbARYYmBNtQW/T+TxTC6PXks5uaMiVv0jjJJuLuPZolU/F+A93sUMXeZGQiVbZqlr
         yP4OEJC98MwDGhMTENgntU1/FOov7HobqpfkkusPjfcJIfdFHbmaHl86E52nPJXP94B0
         gmE7dw8jQzpCJlv4dQKksf/xphxee3miPyboSv21ZzgVmwARJHc6p2ye8EMyC46Q5NSH
         0y0g==
X-Gm-Message-State: AGRZ1gKnMnHuONWLyvo5O+4XjyUDiqnJaHsnrhHOkXjrP+JRG8Wu6mNa
        WqkO3cy3IOgk0++ageJvEMe5qdC+oscTJ4ZaUW8a+Q==
X-Google-Smtp-Source: AJdET5cvtMJ1N5itYFMN2e0AMA9FZ0aKGHGWnbs8BkDGu28rG9o2aps/XNoK0vFlHvb4H/EH5VocYhEqeKtm/yXFMpA=
X-Received: by 2002:a6b:ef18:: with SMTP id k24-v6mr4327332ioh.78.1541873371550;
 Sat, 10 Nov 2018 10:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20181107171023.zoo6qox5eewy3pmk@localhost> <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com> <20181108154926.GI56134@atomide.com>
In-Reply-To: <20181108154926.GI56134@atomide.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 10 Nov 2018 10:09:19 -0800
Message-ID: <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        guillaume.tucker@collabora.com,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:49 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Olof Johansson <olof@lixom.net> [181107 09:28]:
> > On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > ARM: SoC fixes
> > >
> > > Pulled.
> > >
> > > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > > and it ended up regressing at least BeagleBone XM boards.
> > >
> > > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > > preempt being off? Otherwise I don't see how/why preempt should fail
> > > in a board-specific manner..
> >
> > The board hangs early during boot and the usual way of collecting
> > early console doesn't seem to work when attempted (I haven't tried
> > personally).
> >
> > It's one of the major non-SMP platforms covered by tests. I'd be
> > surprised if it turns out to be truly _board_ specific (and rather
> > specific to OMAP3), but we don't have enough data yet. Chances are it
> > either shuffles some timing around or indeed hits a may_sleep() test
> > somewhere.
> >
> > (I just realized I might have missed to attribute Guillaume in the
> > revert patch. Sorry about that).
>
> Looks like we're missing the stdout-path for earlycon, maybe try
> with the following patch? I can't find my Beagleboard-xm right now,
> time to clean-up a bit I guess.
>
> At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.

To follow up on this, it turned out to be an issue where the kernel
outgrew the location it was loaded to, and overwrite the device tree
on decompression. So, not a code issue.

It's a known fragile aspect on some of the u-boot setups, and
something I've been hit by myself on my farm a few times.

Still, for now we'll keep PREEMPT off until next merge window.


-Olof
