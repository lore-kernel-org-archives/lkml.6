Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E9C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331F420664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwP+Bz54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331F420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJaArN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:47:13 -0400
Received: from casper.infradead.org ([85.118.1.10]:55408 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJaArN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VPLhdhOn13t3h4YktDspTKfhCKswTH0LCwd2AQH47zQ=; b=cwP+Bz54JZqoMZoR0tgF3PcxvS
        t4FOr0aPnORZoqnx1c1R2KMUyMcw9Pd8PloUB9UQxlh/ObeIxnhhobWORda7ML2WneJB4iGKORKO/
        2HZcLoQWMQiyzdWq7Kc1HutlslNahhLqih+tE09NUUDjqA5UEJNF3lDBFihbMS26LRFhN+BdKM7FP
        d684kAX8xzpeYnW/bK4UUNiR255AANO+vM/jrTxCM7ifjEsmSO6mE7mddMXaimujyEU3+URLLBV/K
        CKle93ElEPSfUoYCiTM9Gr4PgSj1oQ+ij3VYkNDqh/JkK+Z/e+FSkgioxfUsfDTnhCNuqCFDfDYFZ
        b0urOyLg==;
Received: from [191.33.133.96] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHWKK-0003SC-Hf; Tue, 30 Oct 2018 15:53:09 +0000
Date:   Tue, 30 Oct 2018 12:53:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Logitech high-resolution scrolling..
Message-ID: <20181030125303.0f94b6e0@coco.lan>
In-Reply-To: <CAHk-=wjisf8Bmgbtf3y0W+Lu58t3nSnvKGc0J=Zo=rmz3eA+Cw@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
        <CAHk-=wjisf8Bmgbtf3y0W+Lu58t3nSnvKGc0J=Zo=rmz3eA+Cw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 28 Oct 2018 14:08:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Sun, Oct 28, 2018 at 12:13 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So the recent change to enable the high-res scrolling really seems a
> > bit *too* extreme.
> >
> > Is there some middle ground that turns the mouse from "look at it
> > sideways and it starts scrolling" to something slightly more
> > reasonable?  
> 
> Actually, I think the bug may be in the generic HID high-resolution
> scrolling code, and I only notice because the Logitech support means
> that now I see it.
> 
> In particular, if you look at hid_scroll_counter_handle_scroll(),
> you'll notice that it tries to turn a high-res scroll event into a
> regular wheel event by using the resolution_multiplier.
> 
> But that code looks really broken. It tries to react to a "half
> multiplier" thing:
> 
>         int threshold = counter->resolution_multiplier / 2;
>    ..
>         counter->remainder += hi_res_value;
>         if (abs(counter->remainder) >= threshold) {
> 
> and that's absolutely and entirely wrong.
> 
> Imagine that the high-res wheel counter has just moved a bit up (by
> one high-res) tick, so now it's at the half-way mark to the
> resolution_multiplier, and we scroll up by one:
> 
>                 low_res_scroll_amount =
>                         counter->remainder / counter->resolution_multiplier
>                         + (hi_res_value > 0 ? 1 : -1);
>                 input_report_rel(counter->dev, REL_WHEEL,
>                                  low_res_scroll_amount);
> 
> and then correct for it:
> 
>                 counter->remainder -=
>                         low_res_scroll_amount * counter->resolution_multiplier;
> 
> now we went from "half resolution multiplier positive" to "half negative".
> 
> Which means that next time that the high-res event happens by even
> just one high-resolution tick in the other direction, we'll now
> generate a low-resolution scroll event in the other direction.
> 
> In other words, that function results in unstable behavior. Tiny tiny
> movements back-and-forth in the high-res wheel events (which could be
> just because either the sensor is unstable, or the wheel is wiggling
> imperceptibly) can result in visible movement in the low-res
> ("regular") wheel reporting.
> 
> There is no "damping" function, in other words. Noise in the high
> resolution reading can result in noise in the regular wheel reporting.
> 
> So that threshold handling needs to be fixed, I feel. Either get rid
> of it entirely (you need to scroll a *full* resolution_multiplier to
> get a regular wheel event), or the counter->remainder needs to be
> *cleared* when a wheel event has been sent so that you don't get into
> the whole "back-and-forth" mode.
> 
> Or some other damping model. I suspect there are people who have
> researched what the right answer is, but I guarantee that the current
> code is not the right answer.
> 
> I suspect this also explains why I *sometimes* see that "just moving
> the mouse sends wheel events", and at other times don't. It needs to
> get close to that "half a resolution multiplier" stage to get into the
> bad cases, but then tiny tiny perturbations can cause unstable
> behavior.
> 
> I can't be the only person seeing this, but I guess the Logitech mouse
> is right now the only one that uses the new generic HID code, and I
> guess not a lot of people have been *using* it.

I remember I submitted in the past some patches adding a different event
for the high scroll mode. I have myself a MX Anywhere 2, and even wrote
some patches for Solaar[1] in order to allow selecting between low
res and high res wheel modes.

The problem I faced, on that time, was similar to yours: when the
high res wheel was enabled, it was very hard to control the mouse,
specially when using the wheel in "free" mode (with I do).

I remember that the patchset I sent was not actually applied, but I
didn't followed what happened after that (got sidetracked by
something else).

[1] https://github.com/pwr/Solaar

Thanks,
Mauro
