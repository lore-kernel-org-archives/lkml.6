Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64A214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC64A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJIS1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:27:52 -0400
Received: from mleia.com ([178.79.152.223]:39608 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeJIS1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:27:52 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 48BF841E559;
        Tue,  9 Oct 2018 12:11:25 +0100 (BST)
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
To:     Marek Vasut <marek.vasut@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-2-vz@mleia.com>
 <5631ac17-a1c1-af12-8b30-314880af42df@gmail.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <4569f3e3-3812-f423-eda9-51e7a4d56a58@mleia.com>
Date:   Tue, 9 Oct 2018 14:11:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5631ac17-a1c1-af12-8b30-314880af42df@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181009_121125_320961_0AC7F131 
X-CRM114-Status: GOOD (  25.07  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 10/09/2018 03:13 AM, Marek Vasut wrote:
> On 10/08/2018 11:11 PM, Vladimir Zapolskiy wrote:
>> From: Sandeep Jain <Sandeep_Jain@mentor.com>
>>
>> The change adds device tree binding description of TI DS90Ux9xx
>> series of serializer and deserializer controllers which support video,
>> audio and control data transmission over FPD-III Link connection.
>>
>> Signed-off-by: Sandeep Jain <Sandeep_Jain@mentor.com>
>> [vzapolskiy: various updates and corrections of secondary importance]
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>  .../devicetree/bindings/mfd/ti,ds90ux9xx.txt  | 66 +++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
>> new file mode 100644
>> index 000000000000..0733da88f7ef
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
>> @@ -0,0 +1,66 @@
>> +Texas Instruments DS90Ux9xx de-/serializer controllers
>> +
>> +Required properties:
>> +- compatible: Must contain a generic "ti,ds90ux9xx" value and
>> +	may contain one more specific value from the list:
>> +	"ti,ds90ub925q",
>> +	"ti,ds90uh925q",
>> +	"ti,ds90ub927q",
>> +	"ti,ds90uh927q",
>> +	"ti,ds90ub926q",
>> +	"ti,ds90uh926q",
> 
> Keep the list sorted.
> 

actually the list is a concatenation of two sorted lists, one for
serializers, another for deserializers.

Perhaps it makes sense to keep the list as it is done now and just
mention the selected order, but then it will complicate the formal
description.

>> +	"ti,ds90ub928q",
>> +	"ti,ds90uh928q",
>> +	"ti,ds90ub940q",
>> +	"ti,ds90uh940q".
>> +
>> +Optional properties:
>> +- reg : Specifies the I2C slave address of a local de-/serializer.
>> +- power-gpios : GPIO line to control supplied power to the device.
> 
> Shouldn't this be regulator phandle ?

It could be, right. I'll ponder upon it.

>> +- ti,backward-compatible-mode : Overrides backward compatibility mode.
>> +	Possible values are "<1>" or "<0>".
> 
> Make this bool , ie. present or not.
> 

It is a real tristate property which is represented by non-present, 0, 1.
It shall not be bool IMHO.

>> +	If "ti,backward-compatible-mode" is not mentioned, the backward
>> +	compatibility mode is not touched and given by hardware pin strapping.
>> +- ti,low-frequency-mode : Overrides low frequency mode.
>> +	Possible values are "<1>" or "<0>".
>> +	If "ti,low-frequency-mode" is not mentioned, the low frequency mode
>> +	is not touched and given by hardware pin strapping.
>> +- ti,video-map-select-msb: Sets video bridge pins to MSB mode, if it is set
>> +	MAPSEL pin value is ignored.
>> +- ti,video-map-select-lsb: Sets video bridge pins to LSB mode, if it is set
>> +	MAPSEL pin value is ignored.
> 
> This needs some additional explanation, what's this about ?
> 

Please reference to datasheet, for instance search for MAPSEL pin description
and overriding I2C commands in http://www.ti.com/lit/ds/symlink/ds90ub927q-q1.pdf

I believe it makes little sense to copy excessive information from an open
datasheet into bindings documentation.

>> +- ti,pixel-clock-edge : Selects Pixel Clock Edge.
>> +	Possible values are "<1>" or "<0>".
>> +	If "ti,pixel-clock-edge" is High <1>, output data is strobed on the
>> +	Rising edge of the PCLK. If ti,pixel-clock-edge is Low <0>, data is
>> +	strobed on the Falling edge of the PCLK.
>> +	If "ti,pixel-clock-edge" is not mentioned, the pixel clock edge
>> +	value is not touched and given by hardware pin strapping.
>> +- ti,spread-spectrum-clock-generation : Spread Sprectrum Clock Generation.
>> +	Possible values are from "<0>" to "<7>". The same value will be
>> +	written to SSC register. If "ti,spread-spectrum-clock-gen" is not
>> +	found, then SSCG will be disabled.
>> +
>> +TI DS90Ux9xx serializers and deserializer device nodes may contain a number
>> +of children device nodes to describe and enable particular subcomponents
>> +found on ICs.
>> +
>> +Example:
>> +
>> +serializer: serializer@c {
>> +	compatible = "ti,ds90ub927q", "ti,ds90ux9xx";
>> +	reg = <0xc>;
>> +	power-gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>;
>> +	ti,backward-compatible-mode = <0>;
>> +	ti,low-frequency-mode = <0>;
>> +	ti,pixel-clock-edge = <0>;
>> +	...
>> +}
>> +
>> +deserializer: deserializer@3c {
>> +	compatible = "ti,ds90ub940q", "ti,ds90ux9xx";
>> +	reg = <0x3c>;
>> +	power-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
>> +	...
>> +}
>> +
>>
> 

--
Best wishes,
Vladimir
