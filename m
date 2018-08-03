Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A5421717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A5421717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeHCMkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:40:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49785 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeHCMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:40:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41hkFW6n0nz1qxQL;
        Fri,  3 Aug 2018 12:44:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41hkFW580Zz20xSm;
        Fri,  3 Aug 2018 12:44:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id yKECdL2MZzLa; Fri,  3 Aug 2018 12:44:44 +0200 (CEST)
X-Auth-Info: XVlWAizQk/pyLJCu22yIrEVJDYIDFKkI1hNqs7LqNDI=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  3 Aug 2018 12:44:44 +0200 (CEST)
Cc:     pn@denx.de, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
        sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v4 1/3] iio: Add modifier for white light
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20180802182729.2061830-1-pn@denx.de>
 <alpine.DEB.2.21.1808022117460.25216@vps.pmeerw.net>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <fb30878f-0163-306a-e933-d9fecc996acb@denx.de>
Date:   Fri, 3 Aug 2018 12:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808022117460.25216@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 08/02/2018 09:30 PM, Peter Meerwald-Stadler wrote:
> Hello,
> 
> it is not clear to me why 'white' is needed;
> isn't that the default, i.e. unfiltered light?

Yes, it is. But devices like vcnl4035 veml7700, White LED data one
register and all other sources of light (like fluorescent,
incandescent ,sunlight) in separate register.

So in such cases this WHITE modifier is needed. Should it needs to
come under IIO_MOD_LIGHT_CLEAR?

> 
> thanks, regards, p.
> 
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>   drivers/iio/industrialio-core.c         | 1 +
>>   include/uapi/linux/iio/types.h          | 1 +
>>   tools/iio/iio_event_monitor.c           | 2 ++
>>   4 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 731146c3b138..43e481aed5b2 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1312,6 +1312,13 @@ Description:
>>   		standardised CIE Erythemal Action Spectrum. UV index values range
>>   		from 0 (low) to >=11 (extreme).
>>   
>> +What:		/sys/.../iio:deviceX/in_intensityY_white_raw
>> +KernelVersion:	4.18
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Modifier white indicates that measurements contain white LED
>> +		component.
>> +
>>   What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
>>   What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
>>   What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 19bdf3d2962a..cb939b9fad16 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -108,6 +108,7 @@ static const char * const iio_modifier_names[] = {
>>   	[IIO_MOD_LIGHT_GREEN] = "green",
>>   	[IIO_MOD_LIGHT_BLUE] = "blue",
>>   	[IIO_MOD_LIGHT_UV] = "uv",
>> +	[IIO_MOD_LIGHT_WHITE] = "white",
>>   	[IIO_MOD_QUATERNION] = "quaternion",
>>   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>>   	[IIO_MOD_TEMP_OBJECT] = "object",
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index 4213cdf88e3c..de87a6c7e6de 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -84,6 +84,7 @@ enum iio_modifier {
>>   	IIO_MOD_CO2,
>>   	IIO_MOD_VOC,
>>   	IIO_MOD_LIGHT_UV,
>> +	IIO_MOD_LIGHT_WHITE,
>>   };
>>   
>>   enum iio_event_type {
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index b61245e1181d..a2f9c62a79dd 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -96,6 +96,7 @@ static const char * const iio_modifier_names[] = {
>>   	[IIO_MOD_LIGHT_GREEN] = "green",
>>   	[IIO_MOD_LIGHT_BLUE] = "blue",
>>   	[IIO_MOD_LIGHT_UV] = "uv",
>> +	[IIO_MOD_LIGHT_WHITE] = "white",
>>   	[IIO_MOD_QUATERNION] = "quaternion",
>>   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>>   	[IIO_MOD_TEMP_OBJECT] = "object",
>> @@ -178,6 +179,7 @@ static bool event_is_known(struct iio_event_data *event)
>>   	case IIO_MOD_LIGHT_GREEN:
>>   	case IIO_MOD_LIGHT_BLUE:
>>   	case IIO_MOD_LIGHT_UV:
>> +	case IIO_MOD_LIGHT_WHITE:
>>   	case IIO_MOD_QUATERNION:
>>   	case IIO_MOD_TEMP_AMBIENT:
>>   	case IIO_MOD_TEMP_OBJECT:
>>
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
