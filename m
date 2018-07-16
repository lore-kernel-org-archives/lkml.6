Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18137ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC82E2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="TiGEu8oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC82E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPHbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:31:05 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.134]:29530 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeGPHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1531724704;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3s86vrZ+NlhkRsq8foYeWGtcnFt029Mr69ahmB4n260=;
        b=TiGEu8oEB2hNKK4+p+0ebcNZ/VIZcgkhefYcVZpazskdPn4hZmttxQ1wEUA8wC556m
        fkDjB29VwECR/TBwOaIOknhYfuGuzUHKWEe5PnyTmh8u8vQ21xu4Y8CYR12WuiRQ0Gv4
        /Mhq0CYBscUnjaskL3GQD/nazcvji+MmNDyoCkYXJyGAC9wpoMli8LI1fBITGHmF9cH3
        LTSN8L6Rd2R1wdty932UsV3JGR2f931qLPYEMnNwaSzucgnDeyrXOv6ODZ451kBGojU0
        ZJsr8s6iZFA2mvmD7KU6BUcGRHUL5WZ6/Ewf0jfWGaF52akN7e9aK38zs8wTFEad5x2L
        +E8g==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 43.13 AUTH)
        with ESMTPSA id f09e1au6G74D41u
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 16 Jul 2018 09:04:13 +0200 (CEST)
Subject: Re: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the
 FSL QSPI driver
To:     Rob Herring <robh@kernel.org>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, david.wolfe@nxp.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Han Xu <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
 <20180711160521.GA16884@rob-hp-laptop>
 <9fd871dd-3d10-044c-db80-d65df161a7d9@exceet.de>
 <CAL_JsqLYiiLNabGWnriL7UoUpVmYfAii+3y-o8od6wU7=xpz1A@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <ef0e2cba-a060-0495-98ac-7a78b480281e@exceet.de>
Date:   Mon, 16 Jul 2018 09:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLYiiLNabGWnriL7UoUpVmYfAii+3y-o8od6wU7=xpz1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12.07.2018 17:20, Rob Herring wrote:
> On Thu, Jul 12, 2018 at 2:14 AM Frieder Schrempf
> <frieder.schrempf@exceet.de> wrote:
>>
>> Hi Rob,
>>
>> On 11.07.2018 18:05, Rob Herring wrote:
>>> On Thu, Jul 05, 2018 at 01:15:01PM +0200, Frieder Schrempf wrote:
>>>> Adjust the documentation of the new SPI memory interface based
>>>> driver to reflect the new drivers settings.
>>>
>>> Bindings shouldn't change (other than new properties) due to driver
>>> changes.
>>
>> Right, I added an explanation below, why I think the changes are necessary.
>>
>>>
>>>>
>>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>>>> ---
>>>> Changes in v2:
>>>> ==============
>>>> * Split the moving and editing of the dt-bindings in two patches
>>>>
>>>>    .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
>>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>>>> index 483e9cf..8b4eed7 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>>>> @@ -3,9 +3,8 @@
>>>>    Required properties:
>>>>      - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>>>>                "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
>>>> -             "fsl,ls1021a-qspi"
>>>> +             "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
>>>>                or
>>>> -             "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>>>>                "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
>>>
>>> So the 2080a h/w was compatible with the 1021a h/w, but now it is not?
>>> How did the h/w change?
>>
>> I guess this should be posted as a separate fix. Formerly there was only
>> "fsl,ls1021a-qspi" handled in the driver and the bindings here claimed
>> that "fsl,ls2080a-qspi" is compatible.
>>
>> Some time ago a separate entry for "fsl,ls2080a-qspi" was added to the
>> driver [1] and it adds a quirk, that is not set for "fsl,ls1021a-qspi".
>> That's why I concluded, that these two are actually not compatible.
> 
> So before the driver change, the driver didn't work at all on the
> ls2080a? If so, then removing is appropriate. If not, then removing
> breaks all kernel versions before the change if you use a newer DT.

Before the driver change it couldn't work fully on the ls2080a, as the 
quirk was missing. At least that's what I deduce from the driver.

> 
> 
>>>>      - reg : the first contains the register location and length,
>>>>              the second contains the memory mapping address and length
>>>> @@ -15,14 +14,15 @@ Required properties:
>>>>      - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
>>>>
>>>>    Optional properties:
>>>> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
>>>> -                              Each bus can be connected with two NOR flashes.
>>>> -                          Most of the time, each bus only has one NOR flash
>>>> -                          connected, this is the default case.
>>>> -                          But if there are two NOR flashes connected to the
>>>> -                          bus, you should enable this property.
>>>> -                          (Please check the board's schematic.)
>>>
>>> You can't just remove properties without explanation. Why is this no
>>> longer needed? What about backwards compatibility with existing dtbs?
>>
>> You're right, the explanation is missing here.
>>
>> The "old" driver was using this property to select one of two dual chip
>> setups (two chips on one bus or two chips on separate buses). And it
>> used the order in which the subnodes are defined in the dt to select the
>> CS, the chip is connected to.
>>
>> Both methods are wrong and in fact the "reg" property should be used to
>> determine which bus and CS a chip is connected to. This also enables us
>> to use different setups than just single chip, or symmetric dual chip.
>>
>> So the porting of the driver from the MTD to the SPI framework actually
>> enforces the use of the "reg" properties and makes
>> "fsl,qspi-has-second-chip" superfluous.
>>
>> As all boards that have "fsl,qspi-has-second-chip" set, also have
>> correct "reg" properties, the removal of this property shouldn't lead to
>> any incompatibilities.
>>
>> The only compatibility issues I can see are with imx6sx-sdb.dts and
>> imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
>> (see explanation here: [2]), all other boards should stay compatible.
> 
> Add this to the commit msg.

Ok.

> 
>>>> -  - big-endian : That means the IP register is big endian
>>>> +  - big-endian : That means the IP registers format is big endian
>>>
>>> This is a standard property so it doesn't really need to be redefined
>>> here, but just reference the definition.
>>
>> So I will change that to:
>>
>>          big-endian : See common-properties.txt for a definition
> 
> You can drop "for a definition"

Ok.

Thanks,
Frieder
