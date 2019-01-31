Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20450C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E278C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Dwmu10gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfAaC06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:26:58 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10256 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:26:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c525cf30001>; Wed, 30 Jan 2019 18:26:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 18:26:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 18:26:57 -0800
Received: from [192.168.88.246] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 02:26:55 +0000
Subject: Re: [PATCH v2 2/4] mfd: max77620: add documentation for backup
 battery charging
To:     Rob Herring <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <blaws05@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190129085531.32364-3-markz@nvidia.com> <20190130195154.GA30939@bogus>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <068e92a6-716c-8144-d504-3e8236dbf591@nvidia.com>
Date:   Thu, 31 Jan 2019 10:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130195154.GA30939@bogus>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548901619; bh=TDEQSDMtsbxRVVviDpShfWae/R5jEPcR04nyGJeCKRg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Dwmu10gzU8Jx0smBXe2hVSqQapp89NB2jOAGAT0rZPG+JcE2s0zg2fYfasC/6FiO8
         QGkN9a/3GVJ9Dv5kPnUgu/9HZgRSo4JP/VxpsiFCh8wwodX9Vx0QTUC2gNIErGa5y+
         VtX14U2s8KBdjobnB/Z5p+YpDNzAPKbeQiFJa2mahcSrYljenQYePLRjg/u+yXJN5v
         prVnJvs+zx/M2rjbLn1h1ihSSfIS7dmD5z76JALQIwZmiKZYw4EOR8x6F2CBCrovtQ
         OA1qHvKcgygxrd46xncKRry3PR1zoQRMp9Y/K3VN1HOovvSD6U3fQu1MJVSNUp6wG7
         qNwcq5D0OHDxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 3:51 AM, Rob Herring wrote:
> On Tue, Jan 29, 2019 at 04:55:29PM +0800, Mark Zhang wrote:
>> Adding documentation for 3 new backup battery charging dts
>> properties:
>> - maxim,backup-battery-charging-current
>> - maxim,backup-battery-charging-voltage
>> - maxim,backup-battery-output-resister
>>
>> Signed-off-by: Mark Zhang <markz@nvidia.com>
>> ---
>>  .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
>> index 9c16d51cc15b..484b17e4fba5 100644
>> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
>> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
>> @@ -122,6 +122,26 @@ For DT binding details of different sub modules like GPIO, pincontrol,
>>  regulator, power, please refer respective device-tree binding document
>>  under their respective sub-system directories.
>>  
>> +Backup Battery:
>> +==============
>> +This sub-node configure charging backup battery of the device. Device has
>> +support of charging the backup battery. The subnode name is "backup-battery".
>> +The property for backup-battery child nodes as:
>> +Presence of this child node will enable the backup battery charging.
>> +
>> +Optional properties:
>> +	-maxim,backup-battery-charging-current: Charging current setting.
>> +			The device supports 50/100/200/400/600/800uA.
>> +			If this property is unavailable then it will
>> +			charge with 50uA.
>> +	-maxim,backup-battery-charging-voltage: Charging Voltage Limit Setting.
>> +			Device supports 2500000/3000000/3300000/350000uV.
>> +			Default will be set to 2500mV. The voltage will be roundoff
>> +			to nearest lower side if other than above is configured.
>> +	-maxim,backup-battery-output-resister: Output resistor on Ohm.
>> +			Device supports 100/1000/3000/6000 Ohms.
>> +			Default will be set to 1000 Ohm.
> 
> These need property unit suffixes as defined in property-units.txt. The 
> names are kind of long, so perhaps shorten them a bit.
> 

Thanks Rob. Given these properties will be under "backup-battery" section, so how about
changing them to:
- maxim,charging-current-microamp
- maxim,charging-voltage-microvolt
- maxim,output-resister-ohms

Mark

>> +
>>  Example:
>>  --------
>>  #include <dt-bindings/mfd/max77620.h>
>> -- 
>> 2.19.2
>>
