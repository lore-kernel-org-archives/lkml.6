Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C632C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044BD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdwBVJJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044BD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeH2Q2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:28:04 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38962 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2Q2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:04 -0400
Received: by mail-wr1-f44.google.com with SMTP id o37-v6so4650889wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8dgOrA3DVw+rJtxgo/08bxcnVOYzlSLPCxMQo+vsOv0=;
        b=OdwBVJJyeL5Ub2ACFpMv0ddXtqxOXDPDG4BgknvaEq7pPMd6fHvAnZ5zZnQHhDnrP9
         li8+KFA6DPft6A2Cb7qd5u5QHNScHbpCyMahgFM1rPsnLQ9akWlw0MGyT9cQtxmE/Ik9
         M2zRrARRIQlGP4IdphDfR4Zv6RWuDWW597MRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dgOrA3DVw+rJtxgo/08bxcnVOYzlSLPCxMQo+vsOv0=;
        b=fdcHfe4tryyKItZlZ754jP3ZiTf2NgnQDtzOQfeYz9pHxURKp1oDOHd/Qolp6mMInW
         BNmg2TDFjEii8ZfWgnM8aWcPnRQqUFtQ6ZZ7a30ASrIqrx0fzABEngMegCmutKosKJz5
         cwg5OnG4HK6JyW22zD7mPH5m12q3mfluLJ2VN8FteXThGGRkr1wQ7sDSDHxw9Rtinnua
         ZvRlWn0jEI4WXz/aCRw5wnlTIv8wswwii7dnB4BVScmwlexZP0jwy0MbB0FDw8hXWahE
         txGFwmRJrLAgrpsGmlfUFuHO3B8epAnt8dJ0rPYrTnijynhsteSxneK9UirSpQS0fEJX
         elOQ==
X-Gm-Message-State: APzg51Aw9SYAaMfXuX1fIzYLaZZJGoHd34VL1hUEJpL/Nx1iYfKlGKJS
        +Smz7FHc7WQ+h0ua8LfsjqvHUg==
X-Google-Smtp-Source: ANB0VdaVLN7fgiy9uLEV19F1NO/DQ8/Py4wF3E8iX5ebjSyruByOyXOoUgenrypGwVe7fhQYOQTGOw==
X-Received: by 2002:adf:9e06:: with SMTP id u6-v6mr4167946wre.51.1535545880784;
        Wed, 29 Aug 2018 05:31:20 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u7-v6sm6463380wmd.46.2018.08.29.05.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:31:19 -0700 (PDT)
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        skannan@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <20180827150836.shl7einpuvuw42p7@flea>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <75f1d8f8-84e8-e621-b91d-84b4d15edfa1@linaro.org>
Date:   Wed, 29 Aug 2018 15:31:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180827150836.shl7einpuvuw42p7@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 08/27/2018 06:08 PM, Maxime Ripard wrote:
> Hi!
> 
> On Fri, Aug 24, 2018 at 05:51:37PM +0300, Georgi Djakov wrote:
>> Hi Maxime,
>>
>> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
>>> Hi Georgi,
>>>
>>> On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
>>>>> There is also a patch series from Maxime Ripard that's addressing the
>>>>> same general area. See "dt-bindings: Add a dma-parent property". We
>>>>> don't need multiple ways to address describing the device to memory
>>>>> paths, so you all had better work out a common solution.
>>>>
>>>> Looks like this fits exactly into the interconnect API concept. I see
>>>> MBUS as interconnect provider and display/camera as consumers, that
>>>> report their bandwidth needs. I am also planning to add support for
>>>> priority.
>>>
>>> Thanks for working on this. After looking at your serie, the one thing
>>> I'm a bit uncertain about (and the most important one to us) is how we
>>> would be able to tell through which interconnect the DMA are done.
>>>
>>> This is important to us since our topology is actually quite simple as
>>> you've seen, but the RAM is not mapped on that bus and on the CPU's,
>>> so we need to apply an offset to each buffer being DMA'd.
>>
>> Ok, i see - your problem is not about bandwidth scaling but about using
>> different memory ranges by the driver to access the same location.
> 
> Well, it turns out that the problem we are bitten by at the moment is
> the memory range one, but the controller it goes through also provides
> bandwidth scaling, priorities and so on, so it's not too far off.

Thanks for the clarification. Alright, so this will fit nicely into the
model as a provider. I agree that we should try to use the same binding
to describe a path from a master to memory in DT.

>> So this is not really the same and your problem is different. Also
>> the interconnect bindings are describing a path and
>> endpoints. However i am open to any ideas.
> 
> It's describing a path and endpoints, but it can describe multiple of
> them for the same device, right? If so, we'd need to provide
> additional information to distinguish which path is used for DMA.

Sure, multiple paths are supported.

BR,
Georgi
