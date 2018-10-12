Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B28C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55D42086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="atzUMKxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55D42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeJLQwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:52:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42740 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:52:30 -0400
Received: from [192.168.43.26] (unknown [149.254.234.192])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E6DB1258;
        Fri, 12 Oct 2018 11:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539336058;
        bh=UJ05W6SZzpfymlli0tYgDunnqRjo9Oit2TZzGcgJcfA=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=atzUMKxhSlzokSo0uhFd6gjfI4c+1fkULuar8Sb4JpcsWd1ATh1In6kpeoCoaqFsd
         mKn2BOzQqhNgKFD/aw1UbSoJj8oNCB9IpvaX8748IeVn2nBYTgdKIXVb11ndOSLbAf
         /0/NzUQs13NjPwqfC86cwemTZWEWRI1f20rFWs6U=
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
To:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-5-vz@mleia.com> <20181012060314.GU4939@dell>
 <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
 <20181012083924.GW4939@dell>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Reply-To: kieran.bingham@ideasonboard.com
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <eef99526-9232-8cd4-9a7c-c30114d58806@ideasonboard.com>
Date:   Fri, 12 Oct 2018 10:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012083924.GW4939@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 12/10/18 09:39, Lee Jones wrote:
> On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
>> On 10/12/2018 09:03 AM, Lee Jones wrote:
>>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
>>>
>>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>>>
>>>> The change adds I2C device driver for TI DS90Ux9xx de-/serializers,
>>>> support of subdevice controllers is done in separate drivers, because
>>>> not all IC functionality may be needed in particular situations, and
>>>> this can be fine grained controlled in device tree.
>>>>
>>>> The development of the driver was a collaborative work, the
>>>> contribution done by Balasubramani Vivekanandan includes:
>>>> * original implementation of the driver based on a reference driver,
>>>> * regmap powered interrupt controller support on serializers,
>>>> * support of implicitly or improperly specified in device tree ICs,
>>>> * support of device properties and attributes: backward compatible
>>>>   mode, low frequency operation mode, spread spectrum clock generator.
>>>>
>>>> Contribution by Steve Longerbeam:
>>>> * added ds90ux9xx_read_indirect() function,
>>>> * moved number of links property and added ds90ux9xx_num_fpd_links(),
>>>> * moved and updated ds90ux9xx_get_link_status() function to core driver,
>>>> * added fpd_link_show device attribute.
>>>>
>>>> Sandeep Jain added support of pixel clock edge configuration.
>>>>
>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>>> ---
>>>>  drivers/mfd/Kconfig           |  14 +
>>>>  drivers/mfd/Makefile          |   1 +
>>>>  drivers/mfd/ds90ux9xx-core.c  | 879 ++++++++++++++++++++++++++++++++++
>>>>  include/linux/mfd/ds90ux9xx.h |  42 ++
>>>>  4 files changed, 936 insertions(+)
>>>>  create mode 100644 drivers/mfd/ds90ux9xx-core.c
>>>>  create mode 100644 include/linux/mfd/ds90ux9xx.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 8c5dfdce4326..a969fa123f64 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1280,6 +1280,20 @@ config MFD_DM355EVM_MSP
>>>>  	  boards.  MSP430 firmware manages resets and power sequencing,
>>>>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
>>>>  
>>>> +config MFD_DS90UX9XX
>>>> +	tristate "TI DS90Ux9xx FPD-Link de-/serializer driver"
>>>> +	depends on I2C && OF
>>>> +	select MFD_CORE
>>>> +	select REGMAP_I2C
>>>> +	help
>>>> +	  Say yes here to enable support for TI DS90UX9XX de-/serializer ICs.
>>>> +
>>>> +	  This driver provides basic support for setting up the de-/serializer
>>>> +	  chips. Additional functionalities like connection handling to
>>>> +	  remote de-/serializers, I2C bridging, pin multiplexing, GPIO
>>>> +	  controller and so on are provided by separate drivers and should
>>>> +	  enabled individually.
>>>
>>> This is not an MFD driver.
>>
>> Why do you think so? The representation of the ICs into device tree format
>> of hardware description shows that this is a truly MFD driver with multiple
>> IP subcomponents naturally mapped into MFD cells.
> 
> This driver does too much real work ('stuff') to be an MFD driver.
> MFD drivers should not need to care of; links, gates, modes, pixels,
> frequencies maps or properties.  Nor should they contain elaborate
> sysfs structures to control the aforementioned 'stuff'.
> 
> Granted, there may be some code in there which could be appropriate
> for an MFD driver.  However most of it needs moving out into a
> function driver (or two).
> 
>> Basically it is possible to replace explicit of_platform_populate() by
>> adding a "simple-mfd" compatible, if it is desired.
>>
>>> After a 30 second Google of what this device actually does, perhaps
>>> drivers/media might be a better fit?
>>
>> I assume it would be quite unusual to add a driver with NO media functions
>> and controls into drivers/media.
> 
> drivers/media may very well not be the correct place for this.  In my
> 30 second Google, I saw that this device has a lot to do with cameras,
> hence my media association.
> 
> If *all* else fails, there is always drivers/misc, but this should be
> avoided if at all possible.


The device as a whole is FPD Link for camera devices I believe, but it
certainly has different functions which are broken out in this
implementation.

I think it might be quite awkward having the i2c components in
drivers/i2c and the media components in drivers/media/i2c, so what about
creating drivers/media/i2c/fpd-link (or such) as a container?

Our GMSL implementation is also a complex camera(s) device - but does
not yet use the MFD framework, perhaps that's something to add to my
todo list.

We currently keep all of the complexity within the max9286.c driver, but
I could foresee that being split further if more devices add to the
complexity of managing the bus. At which point we might want an
equivalent drivers/media/i2c/gmsl/ perhaps?

--
Regards

Kieran


>> Laurent, can you please share your opinion?

-- 
Regards
--
Kieran
