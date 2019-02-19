Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208CB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eAZCStvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBSCJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:09:49 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14051 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfBSCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:09:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b656f0000>; Mon, 18 Feb 2019 18:09:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 18:09:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 18:09:46 -0800
Received: from [192.168.88.246] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 02:09:44 +0000
Subject: Re: [PATCH v3 2/4] mfd: max77620: add documentation for backup
 battery charging
From:   Mark Zhang <markz@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20190212064353.7451-1-markz@nvidia.com>
 <20190212064353.7451-3-markz@nvidia.com>
 <CAL_JsqKiL8A+SBwqLzYa9djWBT1S+2kxUUB4iuKWX7EoqXouCw@mail.gmail.com>
 <91d3d8f8-0b96-c442-5674-3eff8209848b@nvidia.com>
Message-ID: <b808a706-19d0-4cae-8c99-2163a64d7884@nvidia.com>
Date:   Tue, 19 Feb 2019 10:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <91d3d8f8-0b96-c442-5674-3eff8209848b@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550542191; bh=l+QX7W8zpi2Ltb5LY3hVoTSMUzGiW1nlP0bUpE54K28=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eAZCStvzdtquVwVLmpwhJlzvY6TvXC/+gU/N4N7p81tZ6DunMn1hL+LPknuOlZDJ1
         /KXX5f8n8CXafOfZ+agWh82kVjjj8nqpWQ4J79iOS4if1LZiWNhGWdzkgTfMtL65dl
         Xq2d/vrCDBNKqvIHYYOIIvFYRgDJhV5gBXKiDzCZXU8WEj2esjEK4yzv2T2VwoC51E
         AjL1piqtQOP74+ZdUO8OuS4bIsUbUHYzB5wLTJMLSLLOmblvqqbPRjVlfeaToSlM95
         P2DK18nAQ+wImDAYcp0oYQ+Cx9Bd4tpiQAMHXUv7A5c34ba2UZgo7Is2n7rxeIsem5
         HUr3bmlktSFOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2019 10:07 AM, Mark Zhang wrote:
> On 2/19/2019 2:06 AM, Rob Herring wrote:
>> On Tue, Feb 12, 2019 at 12:44 AM Mark Zhang <markz@nvidia.com> wrote:
>>>
>>> Adding documentation for 3 new backup battery charging dts
>>> properties:
>>> - maxim,charging-current-microamp
>>> - maxim,charging-voltage-microvolt
>>> - maxim,output-resister-ohms
>>
>> What's the difference between the 77620 and 77650 as there's patches
>> on the list for the 77650 too. The properties are similar, but seems
>> to be main vs. backup battery charger. We should have common
>> properties for this.
> 
> Rob, it's different. The RTC in max77620 is supplied from a backup
> battery and consumes 2.0uA (IBBATT) when no other power sources are
> available. So unlike max77620 battery charging, which provides features

Oops... s/unlike max77620/unlike max77650.

Mark

> like:
> 
> static enum power_supply_property max77650_charger_properties[] = {
> 	POWER_SUPPLY_PROP_STATUS,
> 	POWER_SUPPLY_PROP_ONLINE,
> 	POWER_SUPPLY_PROP_CHARGE_TYPE
> };
> 
> For backup battery charging in max77620, what we can do is just setting
> those 3 parameters. We don't know whether it's charging, whether the
> backup battery is online, the percentage of the charging progress, and
> etc. That's why I mentioned before that it's not appropriate to create
> it as a power supply driver.
> 
> Mark
> 
>>
>>> Signed-off-by: Mark Zhang <markz@nvidia.com>
>>> ---
>>>  .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
>>> index 9c16d51cc15b..88825eaf2567 100644
>>> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
>>> @@ -122,6 +122,26 @@ For DT binding details of different sub modules like GPIO, pincontrol,
>>>  regulator, power, please refer respective device-tree binding document
>>>  under their respective sub-system directories.
>>>
>>> +Backup Battery:
>>> +==============
>>> +This sub-node configure charging backup battery of the device. Device has
>>> +support of charging the backup battery. The subnode name is "backup-battery".
>>> +The property for backup-battery child nodes as:
>>> +Presence of this child node will enable the backup battery charging.
>>> +
>>> +Optional properties:
>>> +       -maxim,charging-current-microamp: Charging current setting.
>>> +                       The device supports 50/100/200/400/600/800uA.
>>> +                       If this property is unavailable then it will
>>> +                       charge with 50uA.
>>> +       -maxim,charging-voltage-microvolt: Charging Voltage Limit Setting.
>>> +                       Device supports 2500000/3000000/3300000/350000uV.
>>> +                       Default will be set to 2500mV. The voltage will be roundoff
>>> +                       to nearest lower side if other than above is configured.
>>> +       -maxim,output-resister-ohms: Output resistor on Ohm.
>>> +                       Device supports 100/1000/3000/6000 Ohms.
>>> +                       Default will be set to 1000 Ohm.
>>> +
>>>  Example:
>>>  --------
>>>  #include <dt-bindings/mfd/max77620.h>
>>> --
>>> 2.19.2
>>>
