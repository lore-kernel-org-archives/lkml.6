Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E46C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B562075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfBFKk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:40:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46853 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBFKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:40:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so5409878edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1DsxEJkBgzX3d3pPRzK48pnVQzAAs5MLCCbpturF7I=;
        b=AzwkX21Hxt39VSwkzmaIi9aCBRPwK9OAez0Q24xUQS8fFMqDNLFNT7Az3BaWFa3IVV
         IDIqu22Xf4E8FMTwvQ3ciNG+uAlB8l6+EOn/Y0cjII1HijvacQfcCZv1/xBxq3pql7sX
         iMbb3SkPYKCdR0dOj3a5VXQzQ4ziiGmwL77wMcPaYEl6A9Mly/Fxqf/aPtBkuL1vcIZt
         bPP3+jdWUcUcmrYYTg6/LEPpqWUk01Fi5t1o2aYP5GtzwVWQBCa4QVgYPRYKDWFVU5oY
         8A+LWl1eqpGbCdgU4h5zG0LC4HqZ7QKG4H5hiWvSjXyjVC1QvrMBuroSKWZ0/nE1Fkbt
         n/MQ==
X-Gm-Message-State: AHQUAuYnPFM6rOAQGzRDWbv9ewWR4yyBXxwOmIcvI+Kih0zC/l+B9U97
        eTBncvN3wbjR8C4xVZ1wjOIlqGn+IKo=
X-Google-Smtp-Source: AHgI3IZvaUf1WCvOlYALSmFsm3edjhSemcKq41x1/ZZ9B+8Bqy2p3FCUVPVwGkDRdYsRhAvDIPBp/w==
X-Received: by 2002:a17:906:b2cc:: with SMTP id cf12mr7133612ejb.36.1549449624240;
        Wed, 06 Feb 2019 02:40:24 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id r1sm5615516eds.1.2019.02.06.02.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 02:40:24 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id a62so1910431wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:40:23 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr2723477wmc.116.1549449623349;
 Wed, 06 Feb 2019 02:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20190130103945.26692-1-dannym@scratchpost.org>
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Feb 2019 18:40:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v65j+ZC4Bp1MvbyEsPifOpwNsjLho+Cu5H+xz-fUBAZ3vg@mail.gmail.com>
Message-ID: <CAGb2v65j+ZC4Bp1MvbyEsPifOpwNsjLho+Cu5H+xz-fUBAZ3vg@mail.gmail.com>
Subject: Re: [PATCH v15 0/8] ASoC: sun4i-codec: Add Line-In, FM-In, Mic 2
To:     Danny Milosavljevic <dannym@scratchpost.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:26 PM Danny Milosavljevic
<dannym@scratchpost.org> wrote:
>
> This patchset adds some mixer controls to sun4i-codec for the Allwinner A10
> and the Allwinner A20.
>
> It also adds the PGA for the MIC2 preamp.
>
> Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
> of distinct controls in alsamixer.
>
> v15 changes compared to v14 are:
>  - Instead of adding controls dynamically, add an extra sun7i_codec_controls
>    structure and duplicate the sun4i_codec_controls there, with small changes.
>  - Split Mic Playback Volume into extra patch.
>  - LEFT OFF adding Capture Selects since it's unclear how we want to structure
>    it.
>  - LEFT OFF adding Differential Line Source since it might also change if the
>    Capture Select implementation is different.

Thanks for staying on this. This looks all good now.

> v14 changes compared to v13 are:
>  - Merged some of the patches together if it made sense to test them together.
>  - Use snd_soc_component_driver.
>  - Moved SUN4I_CODEC_DAC_ACTL_LFMS, SUN4I_CODEC_DAC_ACTL_RFMS to the correct
>    patch in the series.
>  - Kept "Left Mixer Left DAC Playback Switch", "Right Mixer Left DAC
>    Playback Switch" and "Right Mixer Right DAC Playback Switch" unchanged
>    compared to the released version - for backward compatibility.
>
> v13 changes compared to v12 are:
>  - Added my "Signed-off-by".
>  - Clarified some commit message text.
>
> v12 changes compared to v11 are:
>  - Split up patchset in another way.
>  - Renamed "Mic1 Capture Volume" to "Mic1 Boost Volume".
>  - Renamed "Mic2 Capture Volume" to "Mic2 Boost Volume".
>  - Renamed "Line Capture Volume" to "Line Boost Volume".
>  - Renamed "Differential Line Capture Switch" to "Differential Line Source".
>
> v11 changes compared to v10 are:
>  - Split up patchset.
>  - Fixed typo in Differential Line Capture Switch.
>  - Renamed "Non-Differential" value to "Stereo".
>  - Removed duplicate PA Volume mixer control.
>
> v10 changes compared to v9 are:
>  - Use SOC_DAPM_DOUBLE where possible and it makes sense in order to cut
>    down on the number of controls.
>
> v9 changes compared to v8 are:
>  - added Line Differential Capture Switch.
>  - split Capture Source into Left Capture Select, Right Capture Select.
>  - added Line Capture Volume.
>  - rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
>    consistency with the struct field it's used in.
>  - rename "Line-In" to "Line".
>  - rename "Power Amplifier Playback Volume" to "Headphone Playback Volume".
>
> v8 changes compared to v7 are:
>  - fixed the routes for line and mic capturing.
>
> v7 changes compared to v6 are:
>  - preparation for different A20, A10 controls is now in an extra patch.
>  - all register definitions are now at the top.
>  - sun7i-specific things (A20-specific things) are now less
>    grouped-together.
>  - rename "Power Amplifier Volume" to "Power Amplifier Playback Volume".
>
> v6 changes compared to v5 are:
>  - Mic preamplifier special cases for A20 and A10 now are now not
>    icky: There are two different _widget arrays and the probe() function
>    now selects the right one to pass to snd_soc_register_codec() unmodified.
>  - sun7i-specific things (A20-specific things) are now grouped together.
>
> v5 changes compared to v4 are:
>  - Mic preamplifier controls have more common names now.
>  - Mic preamplifier scale has a 0 dB entry as well now, as documented in the
>    A20 user manual.
>  - Mic preamplifier has special cases for A20 and A10 now.
>  - Gain controls have "Gain" in the name now.
>
> v4 changes compared to v3 are:
>  - names of the input are not uppercase anymore.
>  - bit index constants are now named as in the A20 user manual v1.4.
>  - added Mic1-In, Mac2-In.
>  - added Mic1 and Mic2 Pre-Amplifiers.
>
> v3 changes compared to v2 are:
>  - added DAPM routes.
>
> v2 changes compared to v1 are:
>  - moved Line-In and FM-In playback switches to their respective
>    sun4i_codec_*_mixer_controls.
>
> v1 changes:
>  - added linein, fmin output volumes and switches.
>
> Danny Milosavljevic (8):
>   ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2
>   ASoC: sun4i-codec: Add Mic Playback Volume
>   ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec.
>   ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume
>   ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and
>     sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
>   ASoC: sun4i-codec: Add Mic1 Playback Switch, Mic2 Playback Switch
>   ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM
>     Playback Switch
>   ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line
>     Right, Line Left, Line Playback Switch

The whole series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
