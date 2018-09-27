Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BEB21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Spfm3enk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BEB21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeI0HVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:21:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44447 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeI0HVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:21:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so735469ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qo3KTwYzRtgPpcDcBg/6w1ZcTq4c4fAivvrUz2SB7ZY=;
        b=Spfm3enk2talgjPgG+zBl/rpBM9BtQY01gRjb4HP5CBaZJ7JsCVCQ0o8rqhOLzKG5S
         oacYoS0XimPTRWkDdvzfXPUXCV8DkIycqBg6FpEYK29PGsUHpICkxhZ7N2LUeggz/UYm
         GLPuQcrJSF//galzzUUKFzxBG2Iyb30Tl3III=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qo3KTwYzRtgPpcDcBg/6w1ZcTq4c4fAivvrUz2SB7ZY=;
        b=Ih1nQ9ffsFHAqsHlp49Oz8fBU7Q8/JjCUpbWhLMH37OnaabPqcCleSG/5srsrr1LXX
         DetZe8oRe3epL7ciz4xZHoDIjt3jWFfucTnotTFPvrJ38y5ArrOE68r/wKD0gh4w1NE9
         Hd5WKrX44mGN1SLuY0dgLDIGB3f9W/lVngBRU8sJqfbMR+ebIcUGyT+q9zCNQM8TMwlo
         dYlbcG9Ro9ImRjmM42KYgL6iuwJsXdB7vkRt6PBBn8NkIpCYw1YS6ryv5qqkYJsfNRQq
         w90a9A/EplI0HWt52WdNUz8sVjGnsMPXqOg4Lj23RRBlOQQH9kPF/Dy9wk7Y8DmKLsCZ
         zk0A==
X-Gm-Message-State: ABuFfoiKDpAqXQfEQI1I0u5D7jSnJXEk+ZwZ/5s9GPZQLpjmit0UhL13
        +Pwu/v5mg2GxJUpUNaSZz4FPyxvyG/bzS0+/oH7U1A==
X-Google-Smtp-Source: ACcGV61TM+bCcJUnpBOsMpUBZvsw18oW8aSdyLNH0J5eqpdVCvfFqFvTzmqpNvQcPJ7gnInBGCaChQHmGGLBJX4c82Y=
X-Received: by 2002:a2e:9d7:: with SMTP id 206-v6mr5754419ljj.127.1538010365807;
 Wed, 26 Sep 2018 18:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 18:06:05
 -0700 (PDT)
In-Reply-To: <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
 <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com> <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 27 Sep 2018 09:06:05 +0800
Message-ID: <CAMz4kuLt4ReL=fAY9kAnTQpoq3nY-7NU7S91QsWC03JeF+H=vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2018 at 20:45, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Sep 26, 2018 at 04:30:39PM +0800, Baolin Wang wrote:
>> Hi Linus,
>>
>> On 26 September 2018 at 16:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>> >
>> >> Introduce one property to present the battery internal resistance for battery
>> >> information.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> ---
>> >> Changes from v1:
>> >>  - New patch in v2.
>> >
>> > I'm a bit confused by the physics in this patch.
>> >
>> > The internal resistance of a battery is not a constant in its life cycle,
>> > this varies over the age of the battery, and the reason I thing is
>> > chemical residuals accumulating on the anode and cathode inside
>> > the battery and the energy storage medium aging. (Plus/minus my
>> > ignorance about how batteries actually work.)
>>
>> Yes, you are right. The internal resistance can be affected by
>> temperature or battery age or other factors. But our solution just
>> uses one constant internal resistance to calculate OCV value to look
>> up the capacity table when system boots on, in this case we do not
>> need one more accuracy OCV, since we will calculate the battery
>> capacity in future. So we just introduce one estimation constant
>> internal resistance.
>>
>> >
>> > AFAIK the fact that the internal resistance varies is of high
>> > importance for people developing algorithms of battery capacity
>> > and longevity. Such that some (hardware) capacity monitors go
>> > to great lengths to measure with high precision the current
>> > internal resistance of the battery for their algorithms.
>> >
>> > Sorry for making things more complex, but should it be named
>> > "factory-internal-resistance-micro-ohms" or
>> > "typical-internal-resistance-micro-ohms"?
>>
>> I am fine with this change. If Sebastian also agree with this change,
>> I will fix. Thanks for your reviewing and comments.
>
> Ack.
>
> FWIW for proper battery status you need to collect battery specific
> statistics, that is the reason fuel gauge chip providers recommend to
> combine the chip with the battery cells into a "smart battery".

OK. I will rename it as "factory-internal-resistance-micro-ohms" in
next version. Thanks.

-- 
Baolin Wang
Best Regards
