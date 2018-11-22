Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9912D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BZxpOxQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9912D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406719AbeKWIKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:10:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55674 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbeKWIKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:10:25 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8E9F1EC0946;
        Thu, 22 Nov 2018 22:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542922151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5/hiFA00dLJmnEYPJ4d6aJqIQTQEqNitlD2cEPKjV3s=;
        b=BZxpOxQeWva+WSlAEbHeSSuXCaKps61JTuHxkuwgsXetBccOXZOj+btFZBg2xiBcucTGZe
        XNbtrEoGIRqNhWDRBN0QsHcgJKiwwLdyLdc48lCqSjcS0CqU5v1DCUFMCKo1U8YjsPrKKy
        5i/AYccBn1Q3vdY4khQerIh1lZQcNt8=
Date:   Thu, 22 Nov 2018 22:29:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
Message-ID: <20181122212905.GA13187@zn.tnic>
References: <20181102153406.1528053-1-arnd@arndb.de>
 <13542843.KjxkD9786N@anarsoul-thinkpad>
 <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
 <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:06:59PM -0700, Vasily Khoruzhick wrote:
> On Fri, Nov 2, 2018 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 11/2/18, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > > On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
> > >> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
> > >> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
> > >> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
> > >> into link errors for some configurations:
> > >>
> > >> sound/soc/sunxi/sun50i-codec-analog.o: In function
> > >> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62):
> > >> undefined
> > >> reference to `sun8i_adda_pr_regmap_init'
> > >>
> > >> The new name appears to be more sensible, and as the symbol is hidden,
> > >> there are no downsides in the rename, so use that consistently now.
> > >
> > > Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier
> > > to
> > > fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to
> > > SND_SUN8I_ADDA_PR_REGMAP.
> >
> > Sure, I don't care either way. Please send a patch to do that then.
> 
> Will do tonight.

Is that patch coming up or on its way somewhere?

I still hit randconfig build failures:

ERROR: "sun8i_adda_pr_regmap_init" [sound/soc/sunxi/sun50i-codec-analog.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
