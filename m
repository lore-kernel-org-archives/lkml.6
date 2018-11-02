Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC6C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B092082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRzb7zYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B092082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeKCHPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:15:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41748 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:15:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so2987401otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebf3/FRmT5qR/3l9u1MUSPVIR4dXM7Tla1ANQP8R4pY=;
        b=hRzb7zYeDo5K16e3BUHLIYZdpwH0e4CBpWWDHyC0FCnlvD8aiX/fGcUumKsji0MAig
         q9l2tJC9VL5DWgyWXXnM5otYBgni/Dan5HOhcOneXqqpttVO0FFfgvY5rPP8rTnhAaBu
         YAQ6GY1+FOziI6Avk9BNQ3+l9QzpOdpFE45t0/aukAqaVSU83IcXrE9WK9k7NuJu52KR
         cRUqt0P9dh3etUDOi0SP+gJpNKzE0IeF8evs/+Hiryc4JGKCfA5ar2QTlWJN+haTuVTZ
         wjop5fY278Ah0dGphvpzBRmb/j1Fz2yXOox60JdUofmrzXTEMd0QKFvZFsAW55y9s4ci
         oA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebf3/FRmT5qR/3l9u1MUSPVIR4dXM7Tla1ANQP8R4pY=;
        b=IxeYZkt5/9I286SP2GgTdK9XyoTt2mR8nXWRUUPLsO7qxavnf7cXlMKMhTtlcUkzZx
         N4793Gd8Ph9x3AxUcYaznmE/W6NM4SB0nwHQ9DaJbop2F4qRdVlJgfZjb2pDBth3QbzT
         uN11tT+4hQpqvvMtnfqtswM/ql1tRKF+to6XSh/RYYDEZ+eCjD9QQo+lXjgryMoaeYVT
         Mql8ER4zIXzlZcbdz7bNgb5V1OGl1dCuPy+oHTNJM5ji88xtzPlJV8cwu4UoGhlQYc0M
         iT7hLeB7UrGQ99XFn6bPkOMn7Pcqe947RK/+coSB8Ytet0hfl1jOnBkgBGXnhr/DFW5e
         cYWQ==
X-Gm-Message-State: AGRZ1gIY9BzJJreJfG+qoCkYdxoJkwCGHVeeThzRDX56om/gu2MAkSen
        ctY7XpZnej2aJ40A9BwfxM9sCexPmx0M+yDxDl8=
X-Google-Smtp-Source: AJdET5dU38CZMmE8IYN0gr/7fxLupWc127x8kZteUPgazsGCdQLdtj0fuS7rYHIrH4uXL3+xc5P4kdn/8dTiEQeUT0Q=
X-Received: by 2002:a9d:2084:: with SMTP id x4mr7575719ota.111.1541196405642;
 Fri, 02 Nov 2018 15:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181102153406.1528053-1-arnd@arndb.de> <13542843.KjxkD9786N@anarsoul-thinkpad>
 <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
In-Reply-To: <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 2 Nov 2018 15:06:59 -0700
Message-ID: <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/2/18, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
> >> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
> >> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
> >> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
> >> into link errors for some configurations:
> >>
> >> sound/soc/sunxi/sun50i-codec-analog.o: In function
> >> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62):
> >> undefined
> >> reference to `sun8i_adda_pr_regmap_init'
> >>
> >> The new name appears to be more sensible, and as the symbol is hidden,
> >> there are no downsides in the rename, so use that consistently now.
> >
> > Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier
> > to
> > fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to
> > SND_SUN8I_ADDA_PR_REGMAP.
>
> Sure, I don't care either way. Please send a patch to do that then.

Will do tonight.

>
>       Arnd
