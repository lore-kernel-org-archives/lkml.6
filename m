Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC005C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7399020870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O3RZjlLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7399020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ3GCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:02:25 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42820 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3GCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:02:24 -0400
Received: by mail-lj1-f182.google.com with SMTP id f3-v6so9280324ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXJ9v5cNmnvrVzHocIF6v4kXOg7XbDEkZHv+I+2MwJA=;
        b=O3RZjlLW5BT2l9xx2REH1tgivRw7i21l3OcJ9+VQ4GTAS3pTnJ4CzBBk9JjFTgTrBM
         KvpN1rnQ9lE8aMknIQGLO7gSO/6t9zGI2473MuNwyigxNGdS2O89SV37CTnqfMnFGnrb
         gpX+l5caNoDPrM8E6gweXcV3J6tDS1uMEeyYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXJ9v5cNmnvrVzHocIF6v4kXOg7XbDEkZHv+I+2MwJA=;
        b=YilV72gfHJdDX9kt/vSG9dJAyYkcmikGTQ/b/lyvS8KLmF/IM765SFhth511ruu8tK
         glQd4IGZa7GhXGYV0FFposnYVOUt1ZMU6lyxYXz4ioCNFpqy1I+qsml7UzZ09wDrdUQX
         AuBT4TfslQm0pw+AWE+z1zz5zMXop6f4rEZwOHVX5lfsiIIPnQgN9eVNVNjKV+ZP+bcu
         dWaOKajxt0KcON68BmIvZnW52wmKXHyxyfx7TJD6Yg7CmIQMwVZvHAxgfMCtu6uTHcLI
         eeKjH2pKx2f2kT3wALWifvoxd+0sLu1fDXjxBEaLQzKW4uASni7YDHVoh9pRQm4PLq6I
         JSmQ==
X-Gm-Message-State: AGRZ1gI+RBPqT0eUw19upBAvjWPLM4G2+hBG6yH+s91xgJDSVX1Fy5O8
        LiLvvFLFrMn/V0fHDfhpEgBcg9wVb4jl5w==
X-Google-Smtp-Source: AJdET5cknFjW/y9Lr97n3Af/2o+8dVMxYqW05KwqAMLuRFWfr5DfqKQq0AvEVNAbL5CkJe0kvkde6w==
X-Received: by 2002:a2e:59ca:: with SMTP id g71-v6mr9947510ljf.79.1540847516838;
        Mon, 29 Oct 2018 14:11:56 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3244120lfj.85.2018.10.29.14.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:11:56 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c16so7207970lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:11:55 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr197857lfi.138.1540847515262;
 Mon, 29 Oct 2018 14:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com> <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
In-Reply-To: <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 14:11:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
Message-ID: <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Harry Cutts <hcutts@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peter.hutterer@who-t.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:17 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> I don't really understand why the half-multiplier thing would cause
> the instability; there's still a low-res threshold every 8 high-res
> units whichever way you do it

No there isn't.

So what the half-multiplier did, assuming a multiplier of 8 (which is
what my MX Anywhere 2S reports) would be:

 - remainder starts at 3
 - high-res is +1
 - now remainder is 3+1, and it triggers the >= half logic
 - 4/8 is 0, but then the code added 1 because high-res was positive,
so the code decides to add 1
 - the code does a wheel update of 1, and updates remainder with -8,
so now it's -4

Next time around, if the high-res update is 0 or -1, it will go the
other direction. And then it will oscillate.

Notice how tiny movements of +1/-1 in the *high-res* count can
translate into +1/-1 in the regular wheel movement.

And those tiny movements very definitely happen. Maybe it's just my
mouse, but the undeniable fact is that the old algorithm was simply
not stable.

It was literally unusable. I had to be careful not to even touch the
wheel at all, or it would scroll randomly.

I do not believe that you actually ever *used* that code, or if you
did, you only did so with applications that were high-res aware and
ignored the regular wheel entirely because you were testing in an
environment with other changes than just the kernel.

                    Linus
