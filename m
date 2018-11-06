Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D79C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8703320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbeKFStB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:49:01 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46594 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbeKFStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:49:01 -0500
Received: by mail-vk1-f196.google.com with SMTP id 185so2695338vkv.13;
        Tue, 06 Nov 2018 01:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDuPHTXdsAhTpvdtEDwHgjMlDzDBjKOHdPtjNUa/hCg=;
        b=oHdsvK/27SBwtJpqFKL6oBVFGh81pAVpPk/dz5J9R+SLSlsnM4AjlGNOK0cdw4qHUq
         C9KgYV4qiWdq8OOcZLpi4eHFYkf0vZ7jYbGxsWjhUecsmorhh+XazxZslHl/znshlooY
         fmDj9HdYy6PjJvqzh7O3t2qcOFV2kMjOejaL/5H2UOUGqGWwdzSZAJ24Fw4LUeRNZYrd
         b5OUb0wfr94tVjnhsoNTzXUBx/XhDvpwO+Z+6HIRZu8Hw89yny8O/6balfkE5nndDL9p
         HLEfj4IBpEqexUN1GqxZVl6vk6UVWalM3BdBFH+D5g20c43nEelJ8i56jxyY7u2xi83b
         ZkxQ==
X-Gm-Message-State: AGRZ1gLsEO1e1y5LHJbDwDTVSluHf6VoCXhHvjRbxgt+VLL7r8D4xOyS
        bbJmkHRgx9QYiK7wsr02VBd8hJUBNpln8np5IvCVnl4v
X-Google-Smtp-Source: AJdET5dsydgndpjOOLMWX668BtiUkLiPc7WliZfme6/VYNP7f9fM9ngvWKPfPw/CcTwKCKfoVZGbVrKayp4C34oKghQ=
X-Received: by 2002:a1f:bfc6:: with SMTP id p189mr7287478vkf.83.1541496282032;
 Tue, 06 Nov 2018 01:24:42 -0800 (PST)
MIME-Version: 1.0
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com> <20181106090756.GP20885@w540>
In-Reply-To: <20181106090756.GP20885@w540>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 10:24:30 +0100
Message-ID: <CAMuHMdWbrA1hgh3kw+fvL0x3ciNKHV52uhDX0FNJzU_Grb_+qQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: r8a77965: Add VIN4 and VIN5
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Nov 6, 2018 at 10:08 AM jacopo mondi <jacopo@jmondi.org> wrote:
> On Mon, Nov 05, 2018 at 06:19:22PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Oct 29, 2018 at 7:14 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > >    this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.
> > >
> > > On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
> > > could appear on different sets of pins, usually the 'a' and 'b' one.
> > >
> > > With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:
> > >
> > > VIN_DATA_PIN_GROUP(vin4_data_a, 8)
> > >
> > > which results in the group being named as "vin4_data_a_8" which is
> > > un-consistent with the canonical group names (eg. "vin4_data8_a").
> > >
> > > This series adds a macro that allows to specify the group 'version' along with
> > > the pin and mux numbers in patch [1/1]. I haven't been able to find a better
> > > term than 'version' as 'group' was already taken. Suggestions welcome.
> >
> > Yeah, the datasheet also calls these groups :-(
> > A possible alternative is to use "variant"?
> >
> > Or, what about avoiding the name issue by making the VIN_DATA_PIN_GROUP()
> > macro varargs, and passing the "variant" as the (optional) third parameter?
> > That way existing users work as a before, while you can also write e.g.
> >
> >     VIN_DATA_PIN_GROUP_VER(vin4_data, 8, _a),
>
> Indeed.
>
> Would something along the following lines fly for you?
>
> #define VIN_DATA_PIN_GROUP(n, s, ...)                                   \
>         {                                                               \
>                 .name = #n#s#__VA_ARGS__,                               \
>                 .pins = n##__VA_ARGS__##_pins.data##s,                  \
>                 .mux = n##__VA_ARGS__##_mux.data##s,                    \
>                 .nr_pins = ARRAY_SIZE(n##__VA_ARGS__##_pins.data##s),   \
>         }
>
> It can be used as:
> VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
> VIN_DATA_PIN_GROUP(vin5_data, 8),
>
> With your ack on this, I'll send v2.

Thank you, that is exactly what I had in mind.

> > > As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
> > > wired, I made sure the macro creates correct names and fields not only by
> > > compile testing it, but with a small C program [1] that replicates the VIN data
> > > layout defined in the PFC module and access fields (and has helped me testing
> > > more easily the preprocessor stringification/concatenation process).
> > >
> > > Final note: Simon, you took the E3 patches in your tree, and I expect them to
> > > land on v4.20-rc1. They use the old macros, are follow up patches ok?)
> >
> > Which patches are using these macro names, and are in v4.20-rc1?
> >
> > BTW, "grep vin._data_[a-z][0-9] drivers/pinctrl/sh-pfc/*o" tells me we already
> > have broken groups names on r8a7792, r8a7795, and r8a7796.
> > Fortunately we have no known users of them, so they can be fixed.
> >
>
> On v4.20-rc1 the grep returns none for me :/
> git grep v4.20-rc1 "vin._data_[a-z][0-9]" drivers/pinctrl/sh-pfc/

I grepped the .o files, to make sure it would see the final strings, which
obviously works in the build tree only ;-)

For the source tree, please try:

    git grep -w VIN_DATA_PIN_GROUP.*_[a-z] v4.20-rc1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
