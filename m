Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67987C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B920857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="OQH26co7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfA2JOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:14:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44195 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:14:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so14032607lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KKMz8nfKF0cy15fJreQndBZXUzFDeBH8q0iWx2o5RSw=;
        b=OQH26co7h8NjuDnpB1hYgEw1lFyu7RXf6aYZxMGRKdi9vbc9kneMY6qH5sEFaNMEnR
         YEHYRpVPhon9UFTTa2rutskIkZtypm7qJbfsWeHbwOKpWlzQNi07GYvQp45Bw+VbQorI
         r4OCgaXQ8MwAL6Wo+ppA2oLhNSidA0AWD+fk2l+QF7i4wKpX8zGwIl1YzhxbBNeQBiN8
         ytQzmO1rQa73JFonygdPJgZ+SurgOnLfdePn7Cizwb7iAD0ws3QEFxd4rCAz2jjSvLPe
         eiupGpMoUur35jU5Nd77S4jXBJac+3BWFGgC39L0XroOVyqH9xi9Vc/GV6oMm7sicjff
         taRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KKMz8nfKF0cy15fJreQndBZXUzFDeBH8q0iWx2o5RSw=;
        b=lkg11DppZKsFtP3qvDFeydSYsh+6PKlhlIyo+et/WIyj6As4F6WZRjozuq1uuyq9/V
         XFrKZyh3tTtIxReIzMvWI85cHCpw2W5Z6mAsRWrunE28zrR6SN0LmGVqwrERnONTtvvC
         rHCjVokB7XQ42OScnjxmZHx81WG7vAC5jMZ0ZxY0rpYklV4iKcgj35rbkIev3DuJWAt5
         CVLlA/u9EMLbx0hCN7Lq69mKOb60Wma8NHN0F8OAnhW0sRkBEnLOfcF51ez4i4WRQPGz
         xrlM7g1OPD/cISaDhueKP7/5S307K2QnW/a7FQKHYGwt98ciY1bse0YEHfGd8GsavR67
         uwVQ==
X-Gm-Message-State: AJcUukeh+Ea7ZCKBF9VZVjYo/pLPNHnKnZBFexyCdBbDIZbyt6NlgduQ
        LMk/sGxEDcLSX83dObB87IxzTw==
X-Google-Smtp-Source: ALg8bN5+hdpZN/H2DMSMO1hlOAXGDMriJ6mqNU9+SWTLXYVquOFHkdkTxRFiGLOBrMoz5mK5p4OtKg==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr20206999lfa.65.1548753261571;
        Tue, 29 Jan 2019 01:14:21 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id u26-v6sm3397635lji.22.2019.01.29.01.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 01:14:21 -0800 (PST)
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
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
Date:   Tue, 29 Jan 2019 10:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2019 10:04, Baolin Wang wrote:
> Hi Jonas,
> On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> Hi,
>>
>> On 28/01/2019 19:10, Mark Brown wrote:
>>> On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
>>>
>>>> @@ -164,6 +166,7 @@ struct spi_device {
>>>>       char                    modalias[SPI_NAME_SIZE];
>>>>       const char              *driver_override;
>>>>       int                     cs_gpio;        /* chip select gpio */
>>>> +    uint16_t                word_delay;     /* inter-word delay (us) */
>>>
>>> This needs some code in the core joining it up with the per-transfer
>>> word delay similar to what we have for speed_hz and bits_per_word in
>>> __spi_validate().  Then the controller drivers can just look at the
>>> per-transfer value and support both without having to duplicate logic.
>>>
>>
>> So spi_transfer already has a field word_delay and it's defined as
>> _clock cycles_ to delay between words.  I defined word_delay in
>> spi_device as _microseconds_ to delay along the lines of delay_usecs.
>>
>> Given that the inter-word delay is a function of the slave device speed
>> and not of the SPI bus speed, I'm inclined to say that a time-based
>> delay is what we want (to be independent of bus speed).  As such, I want
>> to know if I should add word_delay_usecs to _both_ spi_transfer and
>> spi_device?
>>
>> There's only one user of word_delay from spi_transfer.  Just looking at
>> it quickly, it looks like it wants the word_delay in
>> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
>> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
>> that to be microseconds and do the calculation in the driver?
> 
> The Spreadtrum SPI controller's word delay unit is clock cycle of the
> SPI clock, since the SPI source clock can be changed, we can not force
> user to know the real microseconds. But can we change it to a union
> structure? not sure if this is a good way.

OK, so it is the SPI clock.  That's good.  There's a comment in the 
driver that makes it look like it should be the source clock.

The problem with a delay in clock cycles is that the faster the clock, 
the shorter the delay.  The delay is a property of the slave and the 
slave has a fixed internal clock.  This means that if we increase SCK we 
also need to increase the word_delay (in cycles) in order to give the 
slave the same amount of breathing room.

> 
> union {
>       int word_delay_us;
>       int word_delay_cycle;
> } w;
> 

I don't think that's a practical solution.

The register setting in the spi-sprd driver is what... SCK cycles?  So 
you'd want word_delay_us * max_speed_hz?

The register setting on my Atmel board is in SPI-clock cycles 
(effectively).  So I want word_delay_us*clk_get_rate(spi-clk).

/Jonas
