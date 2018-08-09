Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1CC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECCB21C3B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjjBcobq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCB21C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHIFqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:46:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44258 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeHIFqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:46:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so7412265oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CwSipAou66N3ZN2m/+x0Jk1AqyK1aR4jnQAWexfrwho=;
        b=IjjBcobqDJz9ObBmRfodUMwFvRUyrjL75FUNO86PnIjGX1ReOnqht6N12EatlIw1zV
         RLfQDl96pGrTyn60XUNzVArCVxBkffKXg4jAmCaZ5kYGvWPzVc5bhc7c5sioDk7xaS6O
         Zx/MH8xe6dt1T+2O/FQJxR9sY+iaYGPxNCDrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CwSipAou66N3ZN2m/+x0Jk1AqyK1aR4jnQAWexfrwho=;
        b=jhoVOxjNJbyx8ctKmg/vsEAubHbaRWw7nx2nKu+7zsAc4nzDKX+qT7N0033lct+1yc
         oOoBy1iJVjWhtAUNkX39GDsQr6TkpTNTsC6JGrcKzqhuqnucpjp4lU9DJepoN4Re9Etr
         2O7b88ndJkmm6FdgqGSZKP9KqyyXs9KDF5k71nLYt3m5Nu3j2VSiRJVGYj/MHOtjLBTR
         Mo0+dn0FSvgqvxCxco0YdNKcYYHt+lWnCxVujtf0832VtbsjiuJG0YtMEOC4ZioghqAY
         HWEYZ0lCt+IFGJHc8GzTjzB55ZK+knvGQnLaYuL5MtSdZPuJnCK26uw6toI1nFfcWPBf
         oTXw==
X-Gm-Message-State: AOUpUlHeXkJNbYln73Y+xq+wpRfUBmn2S9RMYdE2fU3kZubjvYGmbnLm
        et72thHIH98GWhhIi3QHvaNOYHvEoVi11aYpx4Sbiw==
X-Google-Smtp-Source: AA+uWPxIDmtEhba5jv7EIG5vb0v6JgLtiHGBw+mmRoKskZplHJ10KPszgZK58EfBLw5ikImpMrt5DyfAdna5YNWc9bw=
X-Received: by 2002:aca:dd07:: with SMTP id u7-v6mr337974oig.177.1533785032461;
 Wed, 08 Aug 2018 20:23:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 20:23:51 -0700 (PDT)
In-Reply-To: <1533755337.2283.280.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <1533661818.2283.264.camel@impinj.com> <CAMz4kuJrzaZn9560tF73a-WPNhhRj5S2ezTKr0HHpcGRXMw-Ew@mail.gmail.com>
 <1533755337.2283.280.camel@impinj.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 9 Aug 2018 11:23:51 +0800
Message-ID: <CAMz4kuKCvN-dpSw3ZXj5CvahWkb6-4a93DDFJ66vkqeA=3=o5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trent,

On 9 August 2018 at 03:08, Trent Piepho <tpiepho@impinj.com> wrote:
> On Wed, 2018-08-08 at 11:19 +0800, Baolin Wang wrote:
>> On 8 August 2018 at 01:10, Trent Piepho <tpiepho@impinj.com> wrote:
>> > On Tue, 2018-08-07 at 18:43 +0800, Baolin Wang wrote:
>> > >
>> > > +static u32 sprd_spi_transfer_max_timeout(struct sprd_spi *ss,
>> > > +                                      struct spi_transfer *t)
>> > > +{
>> > > +     /*
>> > > +      * The time spent on transmission of the full FIFO data is the maximum
>> > > +      * SPI transmission time.
>> > > +      */
>> > > +     u32 size = t->bits_per_word * SPRD_SPI_FIFO_SIZE;
>> > > +     u32 bit_time_us = SPRD_SPI_HZ / t->speed_hz + 1;
>
> There's another flaw here in that the transfer speed, t->speed_hz,
> might not be exactly what is used, due to limitations of the clock
> divider.  It would be better to find the actual SPI clock used, then
> use that in the calculations.

Right, will use the real speed to calculate the transfer time.

>
>> > > +     u32 total_time_us = size * bit_time_us;
>> > > +     /*
>> > > +      * There is an interval between data and the data in our SPI hardware,
>> > > +      * so the total transmission time need add the interval time.
>> > > +      *
>> > > +      * The inteval calculation formula:
>> > > +      * interval time (source clock cycles) = interval * 4 + 10.
>> > > +      */
>> > > +     u32 interval_cycle = SPRD_SPI_FIFO_SIZE * ((ss->interval << 2) + 10);
>> > > +     u32 interval_time_us = interval_cycle * SPRD_SPI_HZ / ss->src_clk + 1;
>> >
>> > If interval is greater than 31, this will overflow.
>>
>> Usually we will not set such a big value for interval,  but this is a
>> risk like you said. So we will check and limit the interval value to
>> make sure the formula will not overflow.
>>
>
> Better would be to limit the inter word delay to whatever maximum value
> your hardware supports, and then write code that can calculate that
> without error.

Yes, will define the maximum word delay values to avoid overflow.

>
>> > > +static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
>> > > +{
>> > > +     /*
>> > > +      * From SPI datasheet, the prescale calculation formula:
>> > > +      * prescale = SPI source clock / (2 * SPI_freq) - 1;
>> > > +      */
>> > > +     u32 clk_div = ss->src_clk / (speed_hz << 1) - 1;
>> >
>> > You should probably round up here.  The convention is to use the
>> > closest speed less than equal to the requested speed, but since this is
>> > a divider, rounding it down will select the next highest speed.
>>
>> Per the datasheet, we do not need round up/down the speed. Since our
>> hardware can handle the clock calculated by the above formula if the
>> requested speed is in the normal region (less than ->max_speed_hz).
>
> That is not what I mean.  Let me explain differently.
>
> An integer divider like this can not produce any frequency exactly.
> Consider if src_clk is 10 MHz.  A clk_div value of 0 produces a 5 MHz
> SPI clock.  A clk_div value of 1 produces a 2.5 MHz SPI clock.
>
> What if the transfer requests a SPI clock of 3 MHz?
>
> Your math above will produce a SPI clock of 5 MHz, faster than
> requested.  This is not the convention in Linux SPI masters.  You
> should instead of have chosen a clk_div value of 1 to get a SPI clock
> of 2.5 MHz, the closest clock possible that is not greater than the
> requested value.
>
> To do this, round up.
>
> clk_div = DIV_ROUND_UP(ss->src_clk, speed_hz * 2) - 1;

Thanks for your patient explanation. After talking with Lanqing who is
the author of the SPI driver, we think you are definitely correct and
will fix in next version according to your suggestion. Thanks a lot.

-- 
Baolin Wang
Best Regards
