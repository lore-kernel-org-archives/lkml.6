Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07690C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22E720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22E720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408126AbeKWPUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:20:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38634 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393167AbeKWPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:20:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so9241367ede.5;
        Thu, 22 Nov 2018 20:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fwaPNc7Zk6NLjlIsR/o2QGZcxqqxf7IiKfFE8lIJeo=;
        b=BmcmjF5pU43XB012MoYyLQGLvgwUA0SwLZDtWeNn86PJ8/4HYBtozLu4J6LrvUKIvU
         3CtXvNhDVg0IK2n0MDhG+/FGyAFh3G8sgpjzL5O5B2IPQhR0+tCcW3b2mNu1HEcuKvW9
         +s7DmpM7a32oTR8dTp/MD6OuKWuxnwbLcSgJf3hcATFz/sS5nkqzhPQ5p3rZtwqY8Bqt
         9RrTNlz/L/8hNwdVhhzmvc7VVTwsiXY56p2yAm6hxqWvzNO8F9xrwPch/ujTEOnD8jje
         fj3YlZL67ZvZ6Zew3MCqmEA6cLBAVWCzmUbS/v4OQhZlZ/nOf29iVJAlK1XtIGCub7mn
         2Ukw==
X-Gm-Message-State: AA+aEWb7o1/gFd2ZX8FR1r4GTpxf0A3nQL4gC4wTFldfcEKxN83iRxPB
        JfWmFjz6dMs0ZKk4qG3/8feZwsRSnC0=
X-Google-Smtp-Source: AFSGD/VNjlH/sAzulDYAVzQXseCkLHMYHXtgF9j642KbjF11tfRNDw6ilzSG48lVsODKzKyRRvqiHg==
X-Received: by 2002:a50:c444:: with SMTP id w4-v6mr11744354edf.232.1542947886225;
        Thu, 22 Nov 2018 20:38:06 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id br3-v6sm8511784ejb.24.2018.11.22.20.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 20:38:05 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id y139so10606365wmc.5;
        Thu, 22 Nov 2018 20:38:05 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr12012009wmd.111.1542947885366;
 Thu, 22 Nov 2018 20:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20181122102325.29495-1-wens@csie.org> <2007258.VzpTJLJblp@anarsoul-thinkpad>
In-Reply-To: <2007258.VzpTJLJblp@anarsoul-thinkpad>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 23 Nov 2018 12:37:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
Message-ID: <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:26 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Thursday, November 22, 2018 2:23:17 AM PST Chen-Yu Tsai wrote:
> > Hi everyone,
> >
> > This is v9 of the A64 audio codec series, originally started by Vasily.
> > These are the last changes to make the A64 audio codec work correctly,
> > and be accurately represented in the device tree and in software.
> >
> > Notably, the new driver changes cover regulator supplies for the simple
> > audio amplifier, which is used in the Pinebook for the internal
> > speakers, and the audio codec's internal headphone amp. There's also an
> > extra patch that enables SDM fractional clock support for the audio PLL
> > on the A64, which gives us accurate audio playback.
> >
> > Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
> > dt bindings & driver.
> >
> > Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
> > bindings & driver.
> >
> > Patch 5 adds SDM fractional clock support for the audio PLL on the A64.
> >
> > Patch 6 ~ 8 add the device tree bits and enables audio on several
> > boards.
> >
> > I have one extra patch for the Bananapi M64 that's not included here,
> > as I'm waiting for an accessory to test the microphone bias. I'll send
> > that one out once it's tested.
> >
> > As always, we'll take the clock and dts patches after Mark has merged
> > the ASoC ones.
> >
> > And a big thanks to Vasily for having worked on this for so long.
>
> Thank you for picking it up!
>
> Just a minor note: hpvcc-supply should be a property of codec_analog in
> sun50i-a64-pinebook.dts

Thanks. I'll fix that up when applying.

> Otherwise looks fine, tested on Pinebook and Pine64-LTS.
>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

Great!

ChenYu
