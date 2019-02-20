Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A25C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBTPWm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:22:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44363 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBTPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:22:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so20135413edw.11;
        Wed, 20 Feb 2019 07:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/poT5zSDQYR4xkvE6W+qkDPTxMHyI95yC8gl7wywdao=;
        b=M6or8s/9s5uCRfQAkd3bXPIyPO0ITtzpVnkcQOUjvBxToB+Mv6o+i7H6M6fRQ0VIvl
         g0DF63F1WGL7+LyyRaoz8Qbfb9+njABbzijkdVj6tQKDu2ekbwZAoXExg7i4nlMHxSPc
         AGz0aYVXoYzpblwb63MySw20qrC+IECcWq4TTPx00WOk+VFd+pOn1Ph7+C86vwcCwjr0
         lBpbgqZ5czruzjqyPlEhTOQMi3v25QlNuCvlk1+2RxhrSEGHWVBWYe30kzNo6dCW9ivK
         h0PqxvPhQ7RbBvEF0I8Vp2IZxMaWKLEo5HxfpNct8QGmIMsSo+jr8HAKM5iMQJRnbo8C
         KJvA==
X-Gm-Message-State: AHQUAuYCpfkXTmn8ePhMtG7seqsCYCra3MYxZMs3K5NEQ4pMZvQzGa0p
        FugxoseVCS5X72yw/Ae5p3nE0X3xeTs=
X-Google-Smtp-Source: AHgI3IYOJfaVNifoBEC216S0nlJ6X6wB2M3Ku4atyKubNiDQbbsf4O2AM/rcyZ3UhPp8baCioFh0dQ==
X-Received: by 2002:a17:906:d1c4:: with SMTP id bs4mr24309380ejb.205.1550676159597;
        Wed, 20 Feb 2019 07:22:39 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id h1sm4435290ejx.41.2019.02.20.07.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:22:38 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id h22so4959232wmb.0;
        Wed, 20 Feb 2019 07:22:38 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr7366092wmc.116.1550676158191;
 Wed, 20 Feb 2019 07:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20190216182132.12895-1-mans@mansr.com> <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
 <20190220090617.aprfndnidcamwcvy@flea> <yw1x36oiybbl.fsf@mansr.com>
In-Reply-To: <yw1x36oiybbl.fsf@mansr.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 20 Feb 2019 23:22:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v669BXTtL=u2_yn3K_9zpdGBxGzA+UfrDgpu+zi99P=77g@mail.gmail.com>
Message-ID: <CAGb2v669BXTtL=u2_yn3K_9zpdGBxGzA+UfrDgpu+zi99P=77g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 7:00 PM Måns Rullgård <mans@mansr.com> wrote:
>
> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>
> > On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
> >> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
> >> >
> >> > This adds pinctrl settings for various missing uart options.
> >> >
> >> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> > ---
> >> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
> >> >  1 file changed, 45 insertions(+)
> >> >
> >> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > index af5b067a5f83..2295ff5adf48 100644
> >> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > @@ -944,6 +944,31 @@
> >> >                                 function = "uart0";
> >> >                         };
> >> >
> >> > +                       uart0_pf_pins: uart0-pf-pins {
> >> > +                               pins = "PF2", "PF4";
> >> > +                               function = "uart0";
> >> > +                       };
> >>
> >> We've had the policy of not adding pinctrl nodes that aren't used in-tree,
> >> to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
> >> /omit-if-no-ref/ directive, which would make the compiler discard marked
> >> nodes if they aren't referenced.
> >>
> >> So please add this to all the new nodes. It seems to work regardless whether
> >> you add it before or after the label, though having it after the label seems
> >> to make vim syntax highlighting happier.
>
> Should we also add this to existing nodes?
>
> BTW, I really do need all those uart pin options.

Note that /omit-if-no-ref/ does not work with dtc -@,
as in the node will be removed if no references to it
are found within the same file. It will not result in
a symbol being created.

I have a patch for that but haven't sent it out yet.

ChenYu
