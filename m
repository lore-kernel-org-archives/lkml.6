Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B5FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366FB2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgRFZj4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366FB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeH2QaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:30:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54019 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeH2QaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:30:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so5121843wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eiHIZmEbAmO3AXJTC4Bg8xsG5c9Z2DIdbce96SpbiPE=;
        b=DgRFZj4TB4J+qsdGSW3s6ZnFxBpzFl/9z9z5XCJenSZ59H7uTfPh1mtUqR3dmwS+4H
         j+vmIKN17j0buR8Ofzcw5b1Xv8dBQvSy5mrtOacIcTVpPe1HBOFaoQlKWMSFZZ3oouAE
         9EpIKMYx2uUX1vi8cZbANtOmcvcPaQ69ybQPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eiHIZmEbAmO3AXJTC4Bg8xsG5c9Z2DIdbce96SpbiPE=;
        b=B9FA/UV9MrkwH38hdAwEE09bl29BUbgrQEZz/9HGDWH3YZj6b4kzdW+ZdKx2IV6iaP
         Tu/b8f6UIL/o650T7yjkvuH6/PETwZogU+DidRgtiaCkmzzm+YD967pYLlIiNZWlfBQO
         KtunJBEb2STQlfexSPxABAPBSEiVh2nEoz/Bxflu/LYehZSKOBMInhtM0XXvCITvSynT
         7gUSQN0sW7q1NVoRJvMP8KHDRyVUCpEsok4D3qu7AK11n42nBXnshQ+5vkofMGEpeRe0
         Fp/57F+vVye5/x0lLKcOlODQCdruP/M8YqE/6CWAvdqP1+BMQyXfl8ZTFQ0r/wtTdPy6
         ZM1g==
X-Gm-Message-State: APzg51Dypuln5oH4jfuXMJ5RCDHA3CRU3KtwDZb4HNJAUE5O5PxfmsZp
        p7un0VDwjecFOldJnmmOcksjpw==
X-Google-Smtp-Source: ANB0VdbSoN1SIN94/HcN5Tld1/IkdvMIJuzJyCoohuI+8PHugSdu9IlYIwH/sAUVTataP9op4bbPhg==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr4058652wmh.150.1535546011609;
        Wed, 29 Aug 2018 05:33:31 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 185-v6sm7152448wmy.38.2018.08.29.05.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:33:30 -0700 (PDT)
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
 <20180827151140.luysp2kfbcq6patg@flea>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABzShHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+wsF+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH87BTQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AcLBZQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <ec22950d-ae18-0cec-3bef-a4840618eb7d@linaro.org>
Date:   Wed, 29 Aug 2018 15:33:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180827151140.luysp2kfbcq6patg@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob and Maxime,

On 08/27/2018 06:11 PM, Maxime Ripard wrote:
> On Fri, Aug 24, 2018 at 10:35:23AM -0500, Rob Herring wrote:
>> On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>
>>> Hi Maxime,
>>>
>>> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
>>>> Hi Georgi,
>>>>
>>>> On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
>>>>>> There is also a patch series from Maxime Ripard that's addressing the
>>>>>> same general area. See "dt-bindings: Add a dma-parent property". We
>>>>>> don't need multiple ways to address describing the device to memory
>>>>>> paths, so you all had better work out a common solution.
>>>>>
>>>>> Looks like this fits exactly into the interconnect API concept. I see
>>>>> MBUS as interconnect provider and display/camera as consumers, that
>>>>> report their bandwidth needs. I am also planning to add support for
>>>>> priority.
>>>>
>>>> Thanks for working on this. After looking at your serie, the one thing
>>>> I'm a bit uncertain about (and the most important one to us) is how we
>>>> would be able to tell through which interconnect the DMA are done.
>>>>
>>>> This is important to us since our topology is actually quite simple as
>>>> you've seen, but the RAM is not mapped on that bus and on the CPU's,
>>>> so we need to apply an offset to each buffer being DMA'd.
>>>
>>> Ok, i see - your problem is not about bandwidth scaling but about using
>>> different memory ranges by the driver to access the same location. So
>>> this is not really the same and your problem is different. Also the
>>> interconnect bindings are describing a path and endpoints. However i am
>>> open to any ideas.
>>
>> It may be different things you need, but both are related to the path
>> between a bus master and memory. We can't have each 'problem'
>> described in a different way. Well, we could as long as each platform
>> has different problems, but that's unlikely.
>>
>> It could turn out that the only commonality is property naming
>> convention, but that's still better than 2 independent solutions.
> 
> Yeah, I really don't think the two issues are unrelated. Can we maybe
> have a particular interconnect-names value to mark the interconnect
> being used to perform DMA?

We can call one of the paths "dma" and use it to perform DMA for the
current device. I don't see a problem with this. The name of the path is
descriptive and makes sense. And by doing we avoid adding more DT
properties, which would be an other option.

This also makes me think that it might be a good idea to have a standard
name for the path to memory as i expect some people will call it "mem",
others "ddr" etc.

Thanks,
Georgi

>> I know you each want to just fix your issues, but the fact that DT
>> doesn't model the DMA side of the bus structure has been an issue at
>> least since the start of DT on ARM. Either we should address this in a
>> flexible way or we can just continue to manage without. So I'm not
>> inclined to take something that only addresses one SoC family.
> 
> I'd really like to have it addressed. We're getting bit by this, and
> the hacks we have don't work well anymore.
