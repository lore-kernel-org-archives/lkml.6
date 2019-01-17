Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F7EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A59320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="losz+YX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfAQJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:12:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36335 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfAQJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:12:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so10110382wrp.3;
        Thu, 17 Jan 2019 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxxz24gKY5aBwImV4VMtmFLIleRU+xZZKrYJMvsCIFE=;
        b=losz+YX42vwzPjQsZzYTyRfuX80AEv0o4kFo+ob2w02nekydRGcD2VIHn/TVvPUNCt
         3OApjCq6tCrRq4umyW/XUtoqDSJgILnTr015I5yr2W81yO6A48LuuaNM4PYopUX9KOT9
         k8PBtl0hs79fZWTi3Puwthr7pBw+AMpk3nBxb+PV57tlz1JzgCTvz7iPL8PSaw1Fx7qG
         A4ZnPbdsDrOUrzf7KvlevIXrLdAnA1ZJ09ITGXiaA4DF/pLnwRrag+FzcvpWsYUnxfhS
         7scZF8YtG/uLhYCcG2SbQM7s5ClncMWviyLwkZkRt/C12WISLAX619nuGXjSqoLP+7Vt
         RpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxxz24gKY5aBwImV4VMtmFLIleRU+xZZKrYJMvsCIFE=;
        b=kgNGOee26Nl+a7J4RxlhUmiEeErH4hb4hamFMu3it2sstOtwS5m6YVO5aTlMBaYbbA
         hWlY8/KkxU5gSm0zVSVfO9zhBBmY0RwmIqsAqI59ucwbOYuS+Ws4yDl/GEw5u8+MmhnY
         EpcK+a1FIEJZRLWIiB824AeO5l5HxRO+vIe1qi/kUwMEY2+DpIfBHo6MviXYu6v2s9TZ
         PYURr8Dm6aFIC72TxFbZGimlJXrY81aAS+Bjdy9RKrffMdfswXf0aoGmYe1o32d0k06d
         sWUT9K4Atb1pErm1pe7zSZwBzajgVLAJccv15LReTs6mVhoWEYWlmfAIGA5vH99IbARH
         6/Yw==
X-Gm-Message-State: AJcUukeWF90AW+Vv5MS2lFttyS6eYqdzVZPbHFK3A3ey9C9+fB9SRwpG
        KTh8ZrTaqlfanJRMO/KuBJE=
X-Google-Smtp-Source: ALg8bN7ZTadRqVjHbDR9TD64E6Od++65T6P5f+vMiENQaTQ21waTfhrQWqY/wSjj453+dJGdERMZOA==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr11679301wrr.67.1547716337170;
        Thu, 17 Jan 2019 01:12:17 -0800 (PST)
Received: from spock ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id q9sm122889170wrp.0.2019.01.17.01.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 01:12:15 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:12:14 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20190117091214.7djttnpo4jjzi4su@spock>
References: <20181025232517.ywnw54qibemosjws@picard>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.20.2-arch1-1-max98090
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, Mogens,

On 17-01-19, Mogens Jensen wrote:
 
> Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and the quirk seems to have fixed the problem caused by commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if running "speaker-test" on my system which is clean ALSA.
> 
> Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is unusable on Clapper Chromebooks as audio played from everything but "speaker-test" as video players or web browsers is extremly low and sounds like played at 10x speed. At the same time kernel log is spammed with messages like this:
> 
> max98090 i2c-193C9890:00: PLL unlocked
> intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
> writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
> writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
> 
> This is probably not related to the problem discussed in this thread, but the result is that I have to use the legacy driver SND_SOC_INTEL_BYT_MAX98090_MACH and therefore still has to revert commit 648e921888ad for sound to work.
> 
> Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MACH on kernel 4.19? Kernel 4.19 is a long term release so it would be very nice to have fix for this version upstream.

I have been reverting "clk: x86: Stop marking clocks as CLK_IS_CRITICAL"
and the patch that initially added the quirk for swanky because of sound
instability issues as you described.  I'm compiling vanilla Archlinux
kernel with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH, using pulseaudio,
and have sound in all my apps.

Baytrail sound has always been a little touchy, especially using headset
with mic, but since the clk patch breaking sound and the quirk patch to
fix it, there is a lot more instability.  Just running pavucontrol, or
plugging in headset sets it off.  It's a head scratcher.

-Dean
