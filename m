Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6861220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2QuQlBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6861220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbeG0VPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:15:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbeG0VPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:15:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so6157711wrp.0;
        Fri, 27 Jul 2018 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6++HUipI7yNayo/Qz6GvpwOw53sSTnGs456PKlpQSY=;
        b=b2QuQlBUB0MVtPoHQLL8GuOZlSvhOn35p/ew2OseTd0XZhFtIvrB3TnfHdy/H2Wtnc
         T9Im/iyzPwoA7CNr55+3NKhKvq0LNEWhDFtRft8q1APhM7bi2VPX/QZFdCIsUL7BgJu/
         B/HQkiJnu1CkULm9+BcOmjj+BRE4ifrT+bOTUW3yT+CO+SWEPb3x7oHI1QfVZRAEQ21u
         z2X3SWKDokLsAS9JPIQNo+J5Sg0mEJwllGC4uqyka2xy0ku6M1tu8HGK5n1XwwMBxiiQ
         2/BByFutVplEhPtYZeWOLvJ7pT+mYhBBHY5ksaiS17AsJaiaN/z5eFM7HYMnYp7+yqXt
         y1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6++HUipI7yNayo/Qz6GvpwOw53sSTnGs456PKlpQSY=;
        b=jL4cAnSBFH53K4+vcI6VpgViBM4uOyf30/GjzJUaYQSX5YeCP8Ucw9cgsGHn5YMkcC
         LJpKrPGjH5BEx30n/AceBoY7vRE6xjOpxu6t9oAEuFRTdBLZ4IHFAtddRNQnE620ZNHg
         FY96Pf8XWE2OMsZa4PBXEBzfWNgtPMOIZAkBm7RvbjlVrBFejrsGYQk2q62uCP46fZRg
         06J3vPexU0Jj2dyVedEPefb+7o+TEuHDmdxkbAlzwp9SEytdeFysEEMq/7k9iq0pk1It
         3/8PKlHttVoOPne7eSUE/vRWHOliNS2PnpHEKFJJfl6usFO+6UBvy+9CU+oNHt6wQ5B1
         FiKQ==
X-Gm-Message-State: AOUpUlGxHEqxvwgTNseSg6B+kQPSGdYFXsHw3hEJTvmLYDa/9NrfS+as
        c1lW3pjXOjKNgbLhdTCQEo0=
X-Google-Smtp-Source: AAOMgpfpCAnEm7DwGWdXpmUBB1CKV+hkGUUQ0q/FFkzV2RoNFNkfNlUgPibdx7FIwNP9hv5Zs+0ung==
X-Received: by 2002:adf:a401:: with SMTP id d1-v6mr6008899wra.121.1532721135441;
        Fri, 27 Jul 2018 12:52:15 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id b2-v6sm5770291wmh.20.2018.07.27.12.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 12:52:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, marcel.ziswiler@toradex.com,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date:   Fri, 27 Jul 2018 22:52:11 +0300
Message-ID: <4098188.Bd2NGYzoJE@dimapc>
In-Reply-To: <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch> <24fffc2c52b58301c37d95fe5d1ad355@agner.ch> <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 July 2018 20:48:55 MSK Peter Geis wrote:
> On 07/26/2018 01:36 PM, Stefan Agner wrote:
> > On 26.07.2018 18:39, Peter Geis wrote:
> >>>>>> I finally got around to testing this on the Ouya (Tegra 3).
> >>>>> 
> >>>>> Thanks for testing!
> >>>>> 
> >>>>>> I found that the "Got command interrupt 0x00010000 even though no
> >>>>>> command operation was in progress." error occurred when the interface
> >>>>>> is unstable.
> >>>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
> >>>>>> Mhz, probably due to the fact that they are using the internal cmd
> >>>>>> and
> >>>>>> clock pull-up resistors, against the TRM's instruction.
> >>>>>> At 39Mhz, I saw the error this patch corrects.
> >>>>>> With the patch, the error went away, but the interface is still
> >>>>>> unstable under load.
> >>>>> 
> >>>>> How does this instability manifest exactly?
> >>>> 
> >>>> At the very edge of stability, you see write errors under heavy load.
> >>>> As clock rate increases, the write errors occur more frequently.
> >>>> At a certain point, you start getting read errors.
> >>>> Following that you get constant io errors during card probing.
> >>>> Eventually the emmc will fail to initialize, with errors 87 or 110.
> >>> 
> >>> What mode are you running at actually? E.g. what is the ios file saying?
> >>> cat /sys/kernel/debug/mmcX/ios
> >> 
> >> This is the best functionality I've been able to get prior to the
> >> patches:
> >> root@ouya:~# cat /sys/kernel/debug/mmc0/ios
> >> clock:          30000000 Hz
> >> actual clock:   29142858 Hz
> >> vdd:            21 (3.3 ~ 3.4 V)
> >> bus mode:       2 (push-pull)
> >> chip select:    0 (don't care)
> >> power mode:     2 (on)
> >> bus width:      3 (8 bits)
> >> timing spec:    9 (mmc HS200)
> >> signal voltage: 1 (1.80 V)
> >> driver type:    0 (driver type B)
> > 
> > Yeah HS200 is definilty not supported by the controller and really
> > should not be used.
> > 
> >> Now I am trying DDR, but even with the patches I'm not able to remain
> >> stable above 17Mhz (34Mhz clock).
> >> 
> >> I've also tried just straight mmc-hs mode, but even that makes no
> >> difference.> 
> > So you tried timing spec 1 (mmc HS)?
> > 
> > How did you exactly enable mmc-hs mode?
> 
> cap-mmc-highspeed;
> 
> > I suggest to *not set* vqmmc and apply patch 1. It will report that
> > signaling voltage is 3.3V, but that did not really matter in our case.
> > This was our baseline and always worked stable on mainline. I also would
> > use that mode when tweaking pinmux etc...
> 
> Will do, thanks.
> 
> >>>> I've been tweaking the pull up/down values to try and improve the
> >>>> stability, but without access to anything but the TRM it's a lot of
> >>>> trial and error.
> >>> 
> >>> Hm, maybe Marcel's recent fixes in our device tree are helpful?
> >>> https://lkml.org/lkml/2018/7/22/165
> >>> 
> >>> Also make sure to have a complete pinmux such that alternative pins for
> >>> sdmmc4 are *not* muxed as sdmmc4.
> >> 
> >> That was my first issue, which was preventing sdmmc4 from working at all.
> >> Just double checked all of the spare function pins, they are all
> >> assigned elsewhere.
> > 
> > Ok.
> > 
> >>>>>> Lowering down to 32Mhz, without the patch there are no errors.
> >>>>> 
> >>>>> So the patch does not make it less stable right?
> >>>> 
> >>>> No, it did not affect stability.
> >>>> Although I'd conduct some performance testing to check for degradation.
> >>>> Of course I'm nowhere near the limits of the controller, so it is
> >>>> doubtful I'd see a hit.
> >>> 
> >>> Ok, and this is with the complete patchset applied correct?
> >>> 
> >>> Btw, what device tree are you using? Ouya is not upstream as far as I
> >>> can tell?
> >> 
> >> Indeed, I have the full patchset.
> >> 
> >> Ouya is an old android game console that I've been working on getting
> >> mainline working on.
> > 
> > I know, I have one sitting here too. I only tried to tinker a bit at the
> > very beginning...
> 
> It runs Xubuntu very well now with mainline.
> I've got most everything roughly supported with the exception of audio.
> 
> >> I've written most of the device tree, with contributions from Matt
> >> Merhar.
> >> It's almost bit for bit a cardhu dev board, but with everything not
> >> necessary to function removed.
> >> They cut a lot of corners with the board design.
> >> Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it
> >> reported it was running mode 5.
> > 
> > That is what we saw too. With Apalis/Colibri T30 L4T downstream kernel
> > (which is 3.1 with quite some patches) 52MHz DDR worked fine,
> > surprisingly even with ACMD23. However, speed is slightly slower than
> > mainline 52MHz without ACMD23...
> 
> I noticed the same thing, speed with the original kernel on the MMC was
> worse at 52Mhz than it was at 34Mhz in HS-200 mode on mainline.
> I'd be happy with it where it is, but the fact that it worked at 52Mhz
> before makes me believe something isn't quite there yet.
> I selected HS-200 mode just to force 1.8v mode.

What's the card model your Ouya's eMMC has?




