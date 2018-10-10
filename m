Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64FC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlY2xdhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64FC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJTeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:34:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34997 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:34:07 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so3685900iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPqLW0ERcpQFXDnwG0gwUfHmcH1FUvqa0lFAAokn+2U=;
        b=XlY2xdhcPIIsNPqf6sr0kbHgJDMY5xAhFgJJvNl6I04X17n1CkREow/kvtD4Kb8xcd
         e5381OVlIRX41U/ACjFCR8mdn5FejC1Uwtji5KNM54Fi/BaqFddIvOcegjv98z21tOax
         Gu7RN6vCOJ0g1CzQuiEn3JEXK2CJfeRnbHZM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPqLW0ERcpQFXDnwG0gwUfHmcH1FUvqa0lFAAokn+2U=;
        b=hTQT9WA8J/egI4PbyGjgAsauyFgs6FwUwX+ccZYi1THw7Ybp6tN50TfXANVmtiUbyU
         zB2941iUV+WCkfTHTjNc+y7loILDivxe9SYKSQkxs4f5g5fUSywyw4eaS83U+ZOv/s+N
         OsZyxGtrfmEyvfLd42rdRupC9UUc6n+fh5FjLAgut0XU2MgnA+gGex3hxkXvwBjw0R58
         Ri1i7QVAZj/VC/wKL17l8AQhXLhIGptzgvbEwlx/UDIt14H3v7UVEPDr19pK46eRPioS
         iUQVRMsrfo54hV6WB5+4zLhppdk3gjW4456p+sEYbLMv6JcabtF6uDHxyDIL3gNXLK6B
         2Hvg==
X-Gm-Message-State: ABuFfojg5CPpqp8QONQbZEsSAQUjrNxfdhWyCjDJZrnXAOjoHcu2wCjU
        wAdUdTu5DVNPA+beBQueRDksmAhia2/v16tNWWsi8w==
X-Google-Smtp-Source: ACcGV61Irhmr3muR0NbZQmmWEANaxGPTT54MWxhBisfWlxrNTRx8C0r/j/lWMAJQ4q4jS9qVjARzUYSN3CJ3G8IFwg4=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr15640466iog.175.1539173533849;
 Wed, 10 Oct 2018 05:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175530.864641368@linuxfoundation.org> <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox> <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
 <20181010075337.GA13524@localhost>
In-Reply-To: <20181010075337.GA13524@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 14:12:01 +0200
Message-ID: <CACRpkdZN4q_gZ27rjD-Yrw5PqsJPRDW2n4u3VaoqBFfwrmhHcA@mail.gmail.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 9:53 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Oct 10, 2018 at 09:12:58AM +0200, Linus Walleij wrote:
> > On Tue, Oct 9, 2018 at 8:33 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> >
> > > Sigh, sorry, I caught this after I sent my initial all good email but
> > > this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> > > apps that want to use it ask to enable it). I can't say why, I'm more
> > > than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> > > done out of tree. I'll leave it up to you how to proceed given that I
> > > can't run mainline :(
> >
> > Which NFC driver is this?
> > Just want to make sure it looks sane.
> >
> > Yours,
> > Linus Walleij
>
> Hi Linus and Bjorn,
>
> These two files should be it I believe:
> https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/nq-nci.c
> https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/ese/pn81a.c
>
> Sorry I didn't get around to digging into this further today, I will try
> to get to it in the morning.

I'm confused. These are not in the mainline kernel and presumably
not in the stable kernel either.

So when you say "this commit breaks NFC on my Pixel 2 XL" you
mean that when you apply this commit to the android msm kernel,
which has a few other stable fixes backported, it breaks?

I know we have some kind of semi-tolerance for outoftree code
and we should preferrably try not to break it, especially not on
stable kernels, but the responsibility is sometimes just
overwhelming, sorry :(

Yours,
Linus Walleij
