Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F354C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D525075
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C7vTKiVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D525075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGBTY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:24:59 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55448 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGBTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:24:58 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so13625904itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3d4DzoG5csRWzT7fWXqBopNmuerctPcQIFjPZdmANU=;
        b=C7vTKiVOJCQG/Qn7EAOg+8azMbbnnVC7CT/5zHBe1+joz8UIgX6z9EjYwuuxI9uxYY
         APbVDn9F4Opv+9JW0wFe8vtCOQgy33Kcoo+9RZJh9gAttfB8HhVWa9+51rFflZDfd8Rd
         ZN7Qm8ip6iPz4e0IK92eroO+Q9sp3tjrKsh+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3d4DzoG5csRWzT7fWXqBopNmuerctPcQIFjPZdmANU=;
        b=pi98khmuxhfM+j4yTZ+VScOlOuz+LzMA5FcFtheGrcCp4sw0xrXPcI/V5DHQxlY4mN
         vJkvEPiXqQVki8dlg7qszNfdwHpZokBZ4HsJQjwwAw+GpLeatK+M9kMfpPgDgL6khKcL
         DNARp9Mx2s56qI2hWx1dXmivLC5cHu2J0t2bT1gV0kQw7JZW46KGBeB+BeyXR80SS1Tl
         BaylEUcBGvgmK2l9smbOpfVtk+tOjRsr6D9T5WsaCoTD0IOXBdkPXOTG3ebN0NZ3VAhI
         hvyuoNTyrfHo6OjiB0ixVETLiK2jNnwHMTvIoU50Tp6NMGIvpPRth/3EpGAmbVagN/sj
         OqBw==
X-Gm-Message-State: APt69E1LlAVBBlfSVhU2akjr4fuhBh+0Wz26voH0S7fGlcYLcytBvfpE
        GBgjz9Ajk8ZzpCdam9ZMBe3l2Hk//FVJqMAkv5M=
X-Google-Smtp-Source: AAOMgpfKFBSe6AvnpWl7xutWHir5guPjBUnJqbW+eBSw7wfHACwrPGIH1HGfklP4nP+0o4UqxwK7bCbyOmw8PcTKXRI=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr6841922itd.16.1530559497744;
 Mon, 02 Jul 2018 12:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
 <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
 <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
 <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
 <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
 <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
 <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
 <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org> <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
In-Reply-To: <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 12:24:46 -0700
Message-ID: <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:23 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Let me try one last ditch attempt to convince you using maybe a
> different perspective: this is how sysfs is intended to work and how
> the device model already does everywhere else except the gluedirs.

So don't get me wrong. I don't think that patch is _wrong_. It may
well be the best thing we can do now.

I just think some of the arguments for the patch are bogus.

I still think that the auto-cleanup is actually a good thing in
general. Not because it simplifies things (which it can do), but
because it fundamentally *allows* you to use less locking.

And that ends up being my real reason to not like your patch all that
much. It depends on

 (a) an extra reference count

 (b) on fairly heavy-handed locking (ie the whole "lock on release
too, not just on allocation").

and I think both of those are non-optimal.

So:

> The actual lifetime of the struct device is handled *separately* by
> device_get/put which are just wrappers on kobject_get/put.

I agree that that is the end result of your patch (and perhaps the
buggy intent of the original code).

I just don't necessarily agree it's a great thing in general. It
basically uses sysfs visibility as an argument for why lifetimes
should differ from the refcounted lifetimes.

And that may be a practical argument, but I don't think it's a very
good argument in general. I think it would arguably be much better to
be less serialized, and depend on refcounting more, and make less of a
deal about the sysfs visibility.

For example, if we *really* add back the exact same device immediately
after removing it, and the device was still in use somehow (ie the
refcount never went down to zero), maybe we really should not have
reused the same name? Or if we do re-use the same name, maybe we
should have re-used the device node itself?

See what I'm saying? I understand where your patch is coming from, but
I am suspicious of the fact that it seems to want to re-use a name
(but not the object) that is by definition still in use.

Maybe that's the right thing in this case. Considering that we have a
real oops and a real problem, and I don't have an alternative patch, I
guess the "patches talk, bullshit walks" rule applies.

                Linus
