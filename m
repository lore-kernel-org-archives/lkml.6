Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C96DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF86222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TofNvSsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAEXLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:11:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43785 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:11:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so35230754lji.10;
        Sat, 05 Jan 2019 15:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0z3l7a7ogw82l4Av4h1Pip5Us75eGl9f6ddo8qQhFw=;
        b=TofNvSsay6JD/cQ/4Kvqs5TCIFUKCjdg3h/fzk9Lf/078kMMgj3cKY/ncnTTlAP6rz
         aRiWd0RwazpMI8YNJKq5rmHyIFgDl3r8ED9X1szyfkvlePsVqyRfb0vre2RBqPec1Q2U
         aRxBizObKeFMMNJbv3Kmz/bXshaNbOGoopPlWv7gHjNqzsjXNPTl15tutFQt9YpSCdW+
         Fw8WwKOtsBlsoRjOUr4dWtEH43o9jE4Xedpmr93Jr2sy0RGXIlbnHYB7RnQSoCtJZyrV
         22abSq44rrAgF+Wquh48iegLb2VnLWjVmRiHHVIlZY9fnL+op+L9KGWfyBd2kbCNhC3M
         gGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0z3l7a7ogw82l4Av4h1Pip5Us75eGl9f6ddo8qQhFw=;
        b=hkaI1CO9uSYuWDFveddlAyhT/kdP2R0A2M8oz6NIE/TLddwQSRjSYbJr/1qawTqDD7
         8pwvoOI+DUsWCtv9LMmg1+MrrQMXI5qIOos5pOYAjUS+Z8PCY2v7Ode+Xg5b4rzd5KAf
         pzRkJ/+Ik0FXYEISQlZbAg6m3IPU2LBPYNjdfC9r25tehkPBEQJcJSApnGIvKL6VIQEJ
         mre755lA2pUygODW6Vcmrq0/OUkgpRhNj1ot2ItnZHK7SFP8f8SQX4kECbMt0pdgNua0
         1oZlxxTuRLB8F7Thr5pC1tRUKzK/Btx/kkzznHpawEDiTYXRQKI7NAb993kF2MFu9EQe
         P9Ug==
X-Gm-Message-State: AJcUukf7CoRFF5eYSmp/PIC6c7UgxNGtnbfYR7sNBt/gZf7U25Q8d9SK
        DJTzZ8cSQbtvG4latUaHspGuArLFXP9nTRjoHzc=
X-Google-Smtp-Source: ALg8bN59Kkxx6Fbs4QbvhyZTL6KqtkMB79FwPZLIvkoDhoElItO614G4Q3/eDitYeloF/R88EfyyK0hCxBMvlOjHQ0Y=
X-Received: by 2002:a2e:12d0:: with SMTP id 77-v6mr30204477ljs.132.1546729905234;
 Sat, 05 Jan 2019 15:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-3-nazgul33@gmail.com>
In-Reply-To: <20190105202659.20198-3-nazgul33@gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 5 Jan 2019 17:11:32 -0600
Message-ID: <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: rotaty-encoder - Add DT binding document
To:     Donghoon Han <nazgul33@gmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Daniel Mack <daniel@caiaq.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
>
> Add DT binding document for rotary-encoder, keycode options.
>
> Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index f99fe5cdeaec..113640079de3 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,relative-keys : generate pair of key events. This setting
> +  behaves just like relative-axis, generating key events. keycode[2]
> +  corresponds -1/1 events.
> +- rotary-encoder,relative-keycodes : keycodes for relative-keys
>  - rotary-encoder,rollover: Automatic rollover when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
> @@ -48,3 +52,11 @@ Example:
>                         rotary-encoder,encoding = "binary";
>                         rotary-encoder,rollover;
>                 };
> +
> +               rotary@2 {
> +                       compatible = "rotary-encoder";
> +                       gpios = <&gpio 21 0>, <&gpio 22 0>;
> +                       rotary-encoder,relative-keys;
> +                       rotary-encoder,relative-keycode = <103>, <108>;
> +                       rotary-encoder,steps-per-period = <2>;

Do you need steps for keys? They weren't required for the relative axis mode.

Thanks.

-- 
Dmitry
