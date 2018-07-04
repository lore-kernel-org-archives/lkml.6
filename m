Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9939BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5210A21738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="juX+08nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5210A21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933921AbeGDLtq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:49:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52721 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933160AbeGDLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:49:45 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so7475362itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bv/A7PQPM0JDFZ8T86jQbjGXy07ss2vWS5WVC27elZE=;
        b=juX+08nj4EkhszZuCu0ebtI3nNGRCS2t3VKBZHFC5laPQrhxfY+k0UUUs0QAAw+6Bu
         G+Uf50H3lN6j45xD7bLIdMYZ9nucanmL79rKqEk1fZCT4xI46YL+AA934MFtk0OnNeeV
         9y/dz7LoHBJKNJDU2BetMCCnuOklsIKpEATOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bv/A7PQPM0JDFZ8T86jQbjGXy07ss2vWS5WVC27elZE=;
        b=dh4bIh6hnwHhctdQxzo5B17qcZ+wWG55CE07YsSd8Qtld63ou4/tVr1ZTaDcL1ITic
         HslzbRiFhpkhPEkTFB0ocTzNP2ITqttz2Hlf7qWD1d+GDW7MFPuw7Y0n2NgYc2h1nprH
         klmB+S3Npt/odUiloX1XdKTJkY3rpu0Gysr2jgwK1NKgP6aJY5pR/WEdKyHnnnqxhjmE
         A5AAYC+i/avZBvEkwfvGtpPblqrJd4KuwAtQlWcMSltajQW5Wr3Ic4pdtJFc8jYim6jB
         y/zrPvk8FkZrL/sy9wmXlFZxLoFJPzPVNJ8ZjpCvJFLFP8/E2plHT+qbtOtBNKpsg45n
         nRJg==
X-Gm-Message-State: APt69E1opO2jmUMdbvyaVn91VFI2wC69vsPaWKCu2SVnyQDl3W/8O6kP
        sTl8pyZf/BsaD284idVUee6jsvESoB+a37EF0wtPzA==
X-Google-Smtp-Source: AAOMgpeouDFqIis04ydywXYW69PEOaDUNsc/IdyumpZ/PY+IrAEPC4tHcbYY9/KMwT+yf9u5Fllc8vKYmLcJAD7tZ0Y=
X-Received: by 2002:a24:8602:: with SMTP id u2-v6mr1409592itd.23.1530704984694;
 Wed, 04 Jul 2018 04:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 04:49:44 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180704103401.GB496@dell>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180704093447.GU20176@dell> <20180704093816.GV20176@dell>
 <20180704100506.GT3891@phenom.ffwll.local> <20180704103401.GB496@dell>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Jul 2018 13:49:44 +0200
X-Google-Sender-Auth: YOhdPLLnOcVgu8zvo7uFwLDyzzk
Message-ID: <CAKMK7uHwKOzf9wxPd_5YcWD06C+aSyL3hkoLNidTGdMPEEVwQw@mail.gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, Jul 4, 2018 at 12:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 04 Jul 2018, Daniel Vetter wrote:
>> On Wed, Jul 04, 2018 at 10:38:16AM +0100, Lee Jones wrote:
>> > On Wed, 04 Jul 2018, Lee Jones wrote:
>> >
>> > > > Jani spotted this when reviewing my earlier patch to remove the driver
>> > > > internal usage of this field in
>> > > >
>> > > > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
>> > > > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
>> > > > Date:   Wed Apr 25 19:42:52 2018 +0200
>> > > >
>> > > >     backlight: Nuke BL_CORE_DRIVER1
>> > >
>> > > FYI, sending patches like this is not a good idea.
>> > >
>> > > I'll clean it up for you this time, but in future please send patches
>> > > properly and place any additional comments you may have below the
>> > > '---' line.
>> >
>> > Ah, I see what you've tried to do.  This hurt my eyes! :)
>> >
>> > It's more conventional to reference commits like:
>> >
>> >   Commit 3cf91adaa594 ("backlight: Nuke BL_CORE_DRIVER1")
>> >
>> > Again, I'll make the amendment to avoid further confusion.
>>
>> So the first mail doesn't even bother to explain what's
>> objectionable
>
> In the first instance it looked as though you'd copied and pasted `git
> log`, which if you'd done so would have been obvious to you and would
> have required no further explanation.
>
> Also bear in mind that I took your standing within the kernel
> community into consideration, so speaking to you like a n00b or going
> into unnecessary detail could have been considered superfluous at best
> and condescending at worst.

Unfortunately minute details like this aren't consistent across the
kernel at all, and white space and layout issues are the number 1
reason I get shot at for random patches I'm sending out. So maybe
there are people who learned all these local expectations (Arnd
perhaps, or Kees?), it's definitely not me. Not after 10 years for
sure.

>> the 2nd mail still says "This hurts my eyes!".
>
> It certainly did, yes.
>
> Usually taken to meaning that it was hard to read in these scenarios.
>
>> Over whitespace in the commit message.
>
> Nothing to do with white space.  It was the format by which you chose
> to reference a previous commit.  Instead it looked like a patch
> formatting error.  I have received patches pasted from `git log`
> before, and this looked just the same.
>
> Once I'd realised what was going on, I followed up to explain and
> provided some feedback on what to do differently in future.
>
>> This kind of stuff is why graphics people really don't enjoy contributing
>> to the kernel at large. A friendly request to resend with the color choice
>> adjusted would go a lot further.
>
> I apologise if my brevity hurt your feelings.  I have 290 emails to
> get though post-paternity leave before I can start to think about
> getting some real/paid work done.

This ain't about my feelings, but working together efficiently and in
a constructive environment.

Also, failing to have adequate maintainer coverage over absence, or
generally being overloaded, is never a valid excuse for how you deal
with contributors. It takes some effort and a bit of time, but group
maintainership in one form or another can take care of this very well.
Brevity justified as efficient communication tends to torpedo that,
since at least in my experience it just drive prospective volunteers
away to more welcoming places.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
