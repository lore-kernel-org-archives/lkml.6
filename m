Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04175C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B646321527
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B646321527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeGGRGs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:06:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52746 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeGGRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:06:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41NJ0f5ZhNz1qvTc;
        Sat,  7 Jul 2018 19:06:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41NJ0f3974z1rZMW;
        Sat,  7 Jul 2018 19:06:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OPZrrfr6mzlG; Sat,  7 Jul 2018 19:06:40 +0200 (CEST)
X-Auth-Info: TZCJ7sGufiZcZjLZCol3RlV07B5jmprrIdqgWclGmsw=
Received: from [192.168.178.26] (unknown [62.91.12.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  7 Jul 2018 19:06:40 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
        sbabic@denx.de, hs@denx.de, pn@denx.de
References: <20180628123021.1628338-1-pn@denx.de>
 <20180629153802.1639514-1-pn@denx.de> <20180629153802.1639514-2-pn@denx.de>
 <20180706203439.GA30529@rob-hp-laptop>
From:   Parthiban Nallathambi <pn@denx.de>
Organization: DENX Software Engineering GmbH
Message-ID: <2205f688-748a-2f68-490d-2225839cad91@denx.de>
Date:   Sat, 7 Jul 2018 19:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706203439.GA30529@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 07/06/2018 10:34 PM, Rob Herring wrote:
> On Fri, Jun 29, 2018 at 05:38:02PM +0200, Parthiban Nallathambi wrote:
>> Adding device tree binding for vcnl4035 and vendor
>> prefix for Vishay Intertechnology
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>  .../devicetree/bindings/iio/light/vcnl4035.txt        | 19 +++++++++++++++++++
>>  Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
>>  2 files changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
>> new file mode 100644
>> index 000000000000..7ffdc0246300
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
>> @@ -0,0 +1,19 @@
>> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
>> +
>> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
>> +
>> +Required properties:
>> +
>> +	-compatible: should be "vishay,vcnl4035"
>> +	-reg: I2C address of the sensor, should be 0x60
>> +	- interrupt-parent: should be the phandle for the interrupt controller
> 
> Don't need to document this as it could be in a parent node.

Will remove it in v3, thanks.

> 
>> +	- interrupts: interrupt mapping for GPIO IRQ (level active low)
>> +
>> +Example:
>> +
>> +vcnl4035@60 {
> 
> light-sensor@60

Sure, thanks.

> 
>> +	compatible = "vishay,vcnl4035";
>> +	reg = <0x60>;
>> +	interrupt-parent = <&gpio4>;
>> +	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>> +};
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 7cad066191ee..3cc46d5735a9 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -395,6 +395,7 @@ v3	V3 Semiconductor
>>  variscite	Variscite Ltd.
>>  via	VIA Technologies, Inc.
>>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
>> +vishay	Vishay Intertechnology, Inc
>>  vivante	Vivante Corporation
>>  vocore VoCore Studio
>>  voipac	Voipac Technologies s.r.o.
>> -- 
>> 2.14.4
>>
> 

-- 
Thanks,
Parthiban N
