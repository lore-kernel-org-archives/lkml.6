Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111D72177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="cUMukSke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfA2Jtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:49:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35619 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfA2Jtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:49:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so16927900ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r4OgAu/r0jEU6lujj2lT+uSpRTg9en/HeuGEXeyCIEQ=;
        b=cUMukSke9EktEf0iHUFzMRF+MVGR/o7JaXot6tJNgn6NSnpJ/9p7yb4xouDkeLiM2h
         dhhLH1l7ju7aN2bwmF0HxGEsIQL8vQz0NIQKZehXHgLsqxVNupNv6n25PfaG0T7QavMz
         ryy2pFxfr45Wv113RZx5kwv2IJr9HE2iHRDwVRFRllmtc9HpESIq0b/nfW6HYy66Fctd
         BJ98LMx4nGQRlI3UK3qv88mRTqKh4tNkZ/drwN28lRqEAYswp8/hDdw9hAgvfkVGPZg7
         /gh6mqjzi+aEQa/P/D1HhD8x/Oacqz2UTbM2cng+RuF1LXAkTSR1sxmfSLFWJSN8QDkb
         KsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4OgAu/r0jEU6lujj2lT+uSpRTg9en/HeuGEXeyCIEQ=;
        b=JInRSWoLw/4VeAmA001a5sbdDOr2oYnsokcEKt7SYSVoiMkodahYlq/+gYPydGIwHd
         0Gs/NB2QxjnHqW4M6MyG4UhRt50qdzSdT+TltJ/x/tYGCvS+gE/QR5EWEmgAwVxVmHoh
         EwYDdgR5wgJHPiYGTYep7Y9Xz5ZaxA0vgGukqKNhbkc4wVY/9NssSJ7eUIvN77Fkc/2Y
         f+ZYsYfXkbG4DxB53jqC7eRgPRQH1bF4Kry0D/SzjFSRGx01+9uLOrtmnbITEhTNyfyZ
         v0N6OViwJISv4jyGeuqTUGxKyZ6uOi9YSPqNXPZaFR3imybYA1NLU4+rNrlqWBGSCsew
         n+gw==
X-Gm-Message-State: AJcUukcnXLawh9e6FRztIEzUIrZLALhMhGid80f7aqYt5GNlTXQHPdUf
        MgS3sJWcyHVNszzD6JeptMMLXg==
X-Google-Smtp-Source: ALg8bN6/dMM71foM0/49OZ3ApNPRjYs6Vrz+s+klBIjK11mJzpsMLtADZSFuEkV2tOisFcWrCUW4Iw==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr20230673lji.130.1548755378851;
        Tue, 29 Jan 2019 01:49:38 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id y23-v6sm3562457ljk.95.2019.01.29.01.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 01:49:38 -0800 (PST)
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk>
 <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
 <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
 <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
 <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <abb0749c-629f-5a81-1dba-0be260b0fb8d@norrbonn.se>
Date:   Tue, 29 Jan 2019 10:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2019 10:35, Baolin Wang wrote:
> On Tue, 29 Jan 2019 at 17:14, Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>>
>>
>> On 29/01/2019 10:04, Baolin Wang wrote:
>>> Hi Jonas,
>>> On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 28/01/2019 19:10, Mark Brown wrote:
>>>>> On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
>>>>>
>>>>>> @@ -164,6 +166,7 @@ struct spi_device {
>>>>>>        char                    modalias[SPI_NAME_SIZE];
>>>>>>        const char              *driver_override;
>>>>>>        int                     cs_gpio;        /* chip select gpio */
>>>>>> +    uint16_t                word_delay;     /* inter-word delay (us) */
>>>>>
>>>>> This needs some code in the core joining it up with the per-transfer
>>>>> word delay similar to what we have for speed_hz and bits_per_word in
>>>>> __spi_validate().  Then the controller drivers can just look at the
>>>>> per-transfer value and support both without having to duplicate logic.
>>>>>
>>>>
>>>> So spi_transfer already has a field word_delay and it's defined as
>>>> _clock cycles_ to delay between words.  I defined word_delay in
>>>> spi_device as _microseconds_ to delay along the lines of delay_usecs.
>>>>
>>>> Given that the inter-word delay is a function of the slave device speed
>>>> and not of the SPI bus speed, I'm inclined to say that a time-based
>>>> delay is what we want (to be independent of bus speed).  As such, I want
>>>> to know if I should add word_delay_usecs to _both_ spi_transfer and
>>>> spi_device?
>>>>
>>>> There's only one user of word_delay from spi_transfer.  Just looking at
>>>> it quickly, it looks like it wants the word_delay in
>>>> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
>>>> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
>>>> that to be microseconds and do the calculation in the driver?
>>>
>>> The Spreadtrum SPI controller's word delay unit is clock cycle of the
>>> SPI clock, since the SPI source clock can be changed, we can not force
>>> user to know the real microseconds. But can we change it to a union
>>> structure? not sure if this is a good way.
>>
>> OK, so it is the SPI clock.  That's good.  There's a comment in the
>> driver that makes it look like it should be the source clock.
> 
> Sorry for my unclear description, what I mean is that it is the SPI
> source clock cycles.
> 
>> The problem with a delay in clock cycles is that the faster the clock,
>> the shorter the delay.  The delay is a property of the slave and the
>> slave has a fixed internal clock.  This means that if we increase SCK we
>> also need to increase the word_delay (in cycles) in order to give the
>> slave the same amount of breathing room.
> 
> Sorry for my confusing description, our case requires source clock
> cycles for word delay.

OK.  So the user (perhaps in userspace using spidev) has to know the 
rate of the IO clock that the SPI controller sits behind and then has to 
match this to the required delay of the slave device...  Doesn't sound 
very portable.

> 
>>
>>>
>>> union {
>>>        int word_delay_us;
>>>        int word_delay_cycle;
>>> } w;
>>>
>>
>> I don't think that's a practical solution.
>>
>> The register setting in the spi-sprd driver is what... SCK cycles?  So
>> you'd want word_delay_us * max_speed_hz?
>>
>> The register setting on my Atmel board is in SPI-clock cycles
>> (effectively).  So I want word_delay_us*clk_get_rate(spi-clk).
> 
> Okay, so your case is different with Spreadtrum SPI.
> 

No, if your register is source clock cycles then it's the same.  On my 
board, the register setting is source clock cycles, too.  It's a 
straightforward conversion from delay to clock cycles... rough, unscaled 
formula above.

/Jonas
