Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D689C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D3021874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="S/zEGxF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfA3IKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:10:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42675 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3IKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:10:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so16674234lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgIp0yacHAj0MuoiDVX3TymhWQBcahRzjDABtOysZwI=;
        b=S/zEGxF3D5hrWsBCOgam4D2qUmxTLcgR4guIn2woDgI2FFxDeAerleknWc7I1C3ec+
         Cz3OSL9BdJJkAEdMoBfahHlaKzSvRk3Z1Xj7Y5Mym5iNJWh2u6iaxcP9VbDqwI+LDcTq
         wr3Y8z4NtNYNtX/PL+xCGgWkQy6q9TagWdYT3J+/0e7xqwispFJ6EC7ljz/WqojBvl/V
         kyEP+fR+pOvSi8pgs/Iha6io74giSRlSsKOLrSqty2T7/Tmr7Hy2E6sZMbRtUjENiBz1
         WyK22GdN1y5gGoBych4C4HX9YnvqVW00Ebx1bxEOfMX6vRY1+0qR+onWf3GoNd/CRB0v
         Eqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgIp0yacHAj0MuoiDVX3TymhWQBcahRzjDABtOysZwI=;
        b=oTBdFthor15y/+RIwFgafHBxmMIah9N2/1nzLu3oTHuNWVJTQKXP65GKsji4YP2kSi
         GdTnWguxFTvxuTZjyiwQuYkORGoL4Icbg13VzK8p1c23yDPfAlmKw/n4M6LB3Bc8atUA
         wYivprLdVNUUrr9bTiSt9PtSyupzMSeCZz8eCvKaRK/T23Fv+bpTWABbjjyPy1LN1bkp
         OyYih9k6ZVK3guJSZTNg8KkH57tyDTD2ukydaKvEwEWmer3H87TTGumjGBJ5+7so7Ilx
         P5CrtYgnrvTniEhnXsiKUZu5JLSNhQW+r7gnjAsMjJfImY3pj6ps2/M1cLbUu6ewlgVL
         STTQ==
X-Gm-Message-State: AJcUukdkphUseVwT3DYfJ2SS++z9hj4PCoYTxXH77UHLyQHgnPOB+KRr
        WDhXC2frTy3we2avCLoScdI/Tg==
X-Google-Smtp-Source: ALg8bN6hkVn+7nqdt64ad3W1tc09CGX+LgXWdJTAclzxVzF5D0JtInfcN/JbX6VfPGHmWYqTLjTDHw==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr20426969lfi.2.1548835814836;
        Wed, 30 Jan 2019 00:10:14 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id 15-v6sm164345lje.18.2019.01.30.00.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 00:10:14 -0800 (PST)
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for
 devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20190129205502.7741-1-jonas@norrbonn.se>
 <20190129205502.7741-2-jonas@norrbonn.se>
 <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <d9c495ac-825e-6dd0-5455-817c3f27b840@norrbonn.se>
Date:   Wed, 30 Jan 2019 09:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 30/01/2019 08:35, Geert Uytterhoeven wrote:
> Hi Jonas,
> 
> On Tue, Jan 29, 2019 at 9:55 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>> Some devices are slow and cannot keep up with the SPI bus and therefore
>> require a short delay between words of the SPI transfer.
>>
>> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
>> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
>> bytes on the bus fast enough to keep up with the SoC's SPI controller
>> even at the lowest bus speed.
>>
>> This patch introduces the ability to specify a required inter-word
>> delay for SPI devices.  It is up to the controller driver to configure
>> itself accordingly in order to introduce the requested delay.
>>
>> Note that, for spi_transfer, there is already a field word_delay that
>> provides similar functionality.  This field, however, is specified in
>> clock cycles (and worse, SPI controller cycles, not SCK cycles); that
>> makes this value dependent on the master clock instead of the device
>> clock for which the delay is intended to provide some relief.  This
>> patch leaves this old word_delay in place and provides a time-based
>> word_delay_us alongside it; the new field fits in the struct padding
>> so struct size is constant.  There is only one in-kernel user of the
>> word_delay field and presumably that driver could be reworked to use
>> the time-based value instead.
> 
> Thanks for your patch!
> 
>> The time-based delay is limited to 8 bits as these delays are intended
>> to be short.  The SAMA5D2 that I've tested this on limits delays to a
>> maximum of ~100us, which is already many word-transfer periods even at
>> the minimum transfer speed supported by the controller.
> 
> Still, the similar delay_usecs uses a u16.

The delays are not comparable.  delay_usecs is the "end of transfer" 
delay and represents the processing time to handle a command or a bundle 
of data.  The inter-word delay is just a stutter to give the slave time 
to get the next word set up.

On the Microchip (Atmel... these name changes take a year or two to sink 
in!) board that I'm using (SAMA5D2), the inter-word delay is limited to 
8192 SPI-controller-clock cycles (not SPI bus clock, input clock).  At 
83Mhz, that's about 100us, and it only gets shorter as you clock up. 
The Spreadtrum board has an upper limit of 130 SPI-controller-clock 
cycles which is just a few microseconds.

Aside from that limitation, consider what's reasonable in terms of 
delay.  More than 5x the word-transfer time and things are pretty 
questionable.  A 250us delay with a word transfer time of 50us gives an 
SPI-bus clock 160kHz.  That's already pretty slow in SPI terms and well 
below what the SAMA5D2 is capable of driving with it's 83MHz input clock 
(max divider is 255 which gives roughtly 400kHz minimum SPI bus clock).

So with that, setting an inter-word delay larger than 255us is barely 
reasonable.  If somebody finds a concrete use for such a setting, then 
the size of the field can be expanded at that time.

Just for info, the inter-word delay that I need to communicate with an 
Atmega MCU running at 500kHz is ~20us which is on the order of the word 
transfer time itself.  This chip is a poor example of how to design an 
SPI slave so I suspect it can only get better from here! :)

And with that said, if you insist having a u16 for this, I'll change it. 
  Just let me know.


> 
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
> 
>> @@ -803,6 +808,7 @@ struct spi_transfer {
>>   #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
>>   #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
>>          u8              bits_per_word;
>> +       u8              word_delay_us;
> 
> us for µs
> 
>>          u16             delay_usecs;
> 
> usecs for µs
> 
> Can we please try to be consistent?



I can change it to usecs if you want.  Is this a serious request to do 
so?  _usecs and _us are used pretty interchangeably across the kernel 
with a slight advantage to _us.

/Jonas

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
