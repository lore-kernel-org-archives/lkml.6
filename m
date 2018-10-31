Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FF6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897412082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=logitech-com.20150623.gappssmtp.com header.i=@logitech-com.20150623.gappssmtp.com header.b="nSa3TVbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897412082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=logitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeJaWq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:46:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43325 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeJaWqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:46:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id g75-v6so6616339yba.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=logitech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SClc0V8aqFpX8plRleDD84T0Y58wXcNRcSrkcQr6Mqk=;
        b=nSa3TVbXVYB7t/HUkXfIk1hMD4Rfn3yBDHk/9D3HX6HZEzqdvp3sf6Sr5uj16Bp6wO
         EEhpqV+Zq+8LsrTbeoGNPtQxnLXw1c3IzPEczeu/Yg9f17OgYHHKvGts/IJKWXXk8dlJ
         Aamov5ToQxx2JZZ06cD69ekNNUblJ7/F2jSNilU2tkaWAdW0ZBqRH4/iNo0EDUM1T9ik
         zEJcZiUm630Z7dcwqV9o0+dV0a6GVJDOHzXp6FakmbXdqshXjLbUKokjhdmhvWQDj8tn
         NsWAXNjeUkjM/pY7Q8Maog9fbtEO2fCchaim68LK69OJMvHEfOPhHOP5C+T8sqVKCVNg
         vU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SClc0V8aqFpX8plRleDD84T0Y58wXcNRcSrkcQr6Mqk=;
        b=DAZIVggIIF3F3TagfM+fGHzHalu+J97Hr9nlAYzAG0pDTY7Gs/Zr+XT52Z0KpjQWXZ
         zxht5SA3fP959P9dFbMBNGgP7ZPiLXOgEplhLWb/kr74TSX4pTXVdGs4AtOjjG9JPCRW
         /zc4i/XWMXASXb0dDfaJxaqO74VloiTyzawMLUgLUYqn6w71oecE1Rzrffmu5WNXPVvi
         CDyWKAgD/ftY5kflFAeHTjX4PaGt553cTN5S1MAGlorGySzoe0//FsUjofLefz25Q7Uh
         xx2+Z/smeICyZa7664WVn/5yEF4R3kl2sD6FddHI8U4Wd9GJIhMKzA2Kp0wnkGIou58q
         eYow==
X-Gm-Message-State: AGRZ1gJLAAZL5gqSp5HJfE60v07OtIr9op0T9Ba/AEi/CpG3w2Opxj4Q
        lb4n/79qWPL4GMUFNUk9Xjz7iq8EzQszsGlgqyEiFQ==
X-Google-Smtp-Source: AJdET5cqXGaB2X92qfZp+GvbVJ7jEHIm2P8R4/vo+V43zLfqub/kh6AgUpEbga6PeA5uO325hz7rZHe37Um/0k92VnQ=
X-Received: by 2002:a25:1dc3:: with SMTP id d186-v6mr3018237ybd.485.1540993698802;
 Wed, 31 Oct 2018 06:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
 <20181030062657.GA5380@jelly> <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
 <CA+jURctDNnVjKEZD6jm3ACv1r8_Me9f+6T_aRiApR=Nd_+upvw@mail.gmail.com>
In-Reply-To: <CA+jURctDNnVjKEZD6jm3ACv1r8_Me9f+6T_aRiApR=Nd_+upvw@mail.gmail.com>
From:   Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Wed, 31 Oct 2018 14:47:52 +0100
Message-ID: <CAE7qMrpdNxbbN3PX5=GASm1U_N4Phd_diDrsagC+GSTo=cvhsQ@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     hcutts@chromium.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        peter.hutterer@who-t.net, jikos@kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've read the discussion, I think I understand the problem and I'll
get back to this thread with more information as soon as I've got some
internal feedback.

BTW, lovely to see so many MX Anywhere  2 users :)
-nestor

On Tue, Oct 30, 2018 at 6:48 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Thanks for the analysis, Peter.
>
> On Mon, 29 Oct 2018 at 23:27, Peter Hutterer <peter.hutterer@who-t.net> w=
rote:
> > IMO this is a lost battle because you cannot know when the ratchet is
> > enabled or not (at least not on all mice). Users switch between ratchet=
 and
> > freewheeling time and once you're out of one mode, you have no referenc=
e
> > to the other mode's reset point anymore.
>
> It would be a lost battle, if it weren't for the fact that on all the
> mice I've tested, putting the wheel back into clicky mode causes the
> wheel to jump to the nearest notch resting point, which should mean
> that the remainder resets to 0 (or maybe =C2=B11 if the mechanism is worn=
).
>
> > So my suggestion is to combine Linus' reset with your approach and use =
the
> > center-point for the trigger. This gives us a few events to slide and s=
till
> > do the right thing, and any direction change will reset anyway. Biggest
> > drawback is that the first event after a direction change is triggered
> > faster than the next event. Otherwise it feels correct to me, both in
> > free-wheeling and in ratchet mode now.
>
> This sounds like a reasonable approach if we find that we can't keep
> the triggering point consistent.
>
> > Also, WTF moment: I managed to get the mouse into a state where it woul=
d
> > only give me 1 hi-res event per notch movement but failed to reproduce =
that
> > again.
>
> Interesting; let me know if you manage to reliably reproduce it. The
> only time I've encountered this in the past was when connecting to the
> mouse over BLE, where we don't seem to be able to detect if the mouse
> is power cycled (meaning that the mouse resets to low-res mode but the
> kernel is still expecting high-res reports). I held off on enabling
> high-res scrolling over Bluetooth for this reason.
>
> On Tue, 30 Oct 2018 at 09:29, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > I wonder if there's some docs on what Logitech does internally in the
> > mouse. It might involve a timeout (ie "if not moving for a while, do
> > the rounding _and_ reset), which would probably be too expensive to do
> > on the host side.
>
> I've been wondering this as well. Nestor (CCed), is there anything you
> can tell us about this?
>
> Harry Cutts
> Chrome OS Touch/Input team
