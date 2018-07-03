Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14546C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B744324EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B744324EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeGCDVn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:21:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753815AbeGCDVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:21:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8E27AD7B;
        Tue,  3 Jul 2018 03:21:38 +0000 (UTC)
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
To:     Ben Whitten <Ben.Whitten@lairdtech.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Steve deRosier <derosier@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <BY1PR02MB111481D94EB0D68AD5FCA689E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <8d514feb-41c7-8ec4-ace2-94e627187a0b@suse.de>
Date:   Tue, 3 Jul 2018 05:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB111481D94EB0D68AD5FCA689E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Am 02.07.2018 um 22:43 schrieb Ben Whitten:
>> 2) This SPI device is in turn exposing the two SPI masters that you
>> already found below, and I didn't see a sane way to split that code out
>> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
>> any precedence either way?
> 
> In my work in progress driver I just register one controller for the sx1301 with two chip selects and use the chip select information to choose the correct radio to send to, this is based on the DT reg information. No need to register two separate masters.

I had considered that and discarded it. The SX1301 has not just two CS
registers though but also two pairs of addr, data registers. That speaks
for two masters with a single chip-select each, unless I'm
misunderstanding the meaning of the registers.

>> Am 02.07.2018 um 18:12 schrieb Mark Brown:
>>> On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas Färber wrote:
>>>
>>>> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enable)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
>>>> +
>>>> +	if (enable)
>>>> +		return;
>>>> +
>>>> +	ret = sx1301_radio_set_cs(spi->controller, enable);
>>>> +	if (ret)
>>>> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
>>>> +}
>>>
>>> So we never disable chip select?
>>
>> Not here, I instead did that in transfer_one below.
>>
>> Unfortunately there seems to be no documentation, only reference code:
>>
>> https://github.com/Lora-
>> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L121
>> https://github.com/Lora-
>> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L165
>>
>> It sets CS to 0 before writing to address and data registers, then
>> immediately sets CS to 1 and back to 0 before reading or ending the
>> write transaction. I've tried to force the same behavior in this driver.
>> My guess was that CS is high-active during the short 1-0 cycle, because
>> if it's low-active during the register writes then why the heck is it
>> set to 0 again in the end instead of keeping at 1... confusing.
>>
>> Maybe the Semtech folks CC'ed can comment how these registers work?
>>
>>>> +	if (tx_buf) {
>>>> +		ret = sx1301_write(ssx->parent, ssx->regs +
>> REG_RADIO_X_ADDR, tx_buf ? tx_buf[0] : 0);
>>>
>>> This looks confused.  We're in an if (tx_buf) block but there's a use of
>>> the ternery operator that appears to be checking if we have a tx_buf?
>>
>> Yeah, as mentioned this RFC is not ready for merging - checkpatch.pl
>> will complain about lines too long, and TODOs are sprinkled all over or
>> not even mentioned. It's a Proof of Concept that a net_device could work
>> for a wide range of spi and serdev based drivers, and on top this device
>> has more than one channel, which may influence network-level design
>> discussions.
>>
>> That said, I'll happily drop the second check. Thanks for spotting!
>>
>>>> +		if (ret) {
>>>> +			dev_err(&spi->dev, "SPI radio address write
>> failed\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		ret = sx1301_write(ssx->parent, ssx->regs +
>> REG_RADIO_X_DATA, (tx_buf && xfr->len >= 2) ? tx_buf[1] : 0);
>>>> +		if (ret) {
>>>> +			dev_err(&spi->dev, "SPI radio data write failed\n");
>>>> +			return ret;
>>>> +		}
>>>
>>> This looks awfully like you're coming in at the wrong abstraction layer
>>> and the hardware actually implements a register abstraction rather than
>>> a SPI one so you should be using regmap as the abstraction.
>>
>> I don't understand. Ben has suggested using regmap for the SPI _device_
>> that we're talking to, which may be a good idea. But this SX1301 device
>> in turn has two SPI _masters_ talking to an SX125x slave each. I don't
>> see how using regmap instead of my wrappers avoids this spi_controller?
>> The whole point of this spi_controller is to abstract and separate the
>> SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
>> instead of mixing it into the SX1301 driver - to me that looks cleaner
>> and more extensible. It also has the side-effect that we could configure
>> the two radios via DT (frequencies, clk output, etc.).
> 
> You want an SPI controller in the SX1301 as the down stream radios are SPI and could be attached directly to a host SPI bus, makes sense to have one radio driver and talk through the SX1301.
> But you should use the regmap to access the SX1301 master controller registers.
> Example I use with one SPI master and some clock info:
> eg:
> 	sx1301: sx1301@0 {

Node names should not repeat the chipset, that goes into compatible.

lora-concentrator@0?

> 		compatible = "semtech,sx1301";
> 		reg = <0>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;

I would still find it cleaner to have (a) sub-node(s) for the radios.

> 		spi-max-frequency = <8000000>;

Datasheet says 10 MHz, why 8 MHz?

> 		gpios-reset = <&pioA 26 GPIO_ACTIVE_HIGH>;

reset-gpios?

> 		clocks = <&radio1 0>, <&clkhs 0>;
> 		clock-names = "clk32m", "clkhs";
> 
> 		radio0: sx1257@0 {

lora@0?

> 			compatible = "semtech,sx125x";

No wildcards in bindings please, use concrete "semtech,sx1257".

> 			reg = <0>;
> 			spi-max-frequency = <8000000>;

Datasheet says 10 ns - I reported to Semtech that it should probably say
10 MHz, too.

> 			tx;

Might we configure that on the sx1301 instead?

> 			clocks = <&tcxo 0>;
> 			clock-names = "tcxo";
> 		};
> 
> 		radio1: sx1257@1 {
> 			compatible = "semtech,sx125x";
> 			reg = <1>;
> 			spi-max-frequency = <8000000>;
> 			#clock-cells = <0>;
> 			clocks = <&tcxo 0>;
> 			clock-names = "tcxo";
> 			clock-output-names = "clk32m";
> 		};
> };
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
