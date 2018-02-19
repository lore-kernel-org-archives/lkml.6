Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeBSJsc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:48:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37791 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeBSJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:48:30 -0500
X-Google-Smtp-Source: AH8x227L3GtOJE/2jgJb8w4y8hi50h5U2VyIdXysSkOqAXElqiU/eRnQl+zt+vAwkn5Ebm/kqfSXpA==
Subject: Re: [PATCH v2 3/3] power: supply: axp288_fuel_gauge: Do not register
 FG on ECS EF20EA
To: Sebastian Reichel <sre@kernel.org>, Carlo Caione <carlo@caione.org>
Cc: linux@endlessm.com, rjw@rjwysocki.net, lenb@kernel.org, wens@csie.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>
References: <20180216082616.25084-1-carlo@caione.org>
 <20180216082616.25084-4-carlo@caione.org>
 <20180216142655.heommid67q3g22qt@earth.universe>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ea75cd5f-9937-8b95-d96a-761fcd091594@redhat.com>
Date: Mon, 19 Feb 2018 10:48:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216142655.heommid67q3g22qt@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-02-18 15:26, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Feb 16, 2018 at 08:26:16AM +0000, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> The ECS EF20EA laptop ships an AXP288 but it is actually using a
>> different, separate FG chip for AC and battery monitoring. On this
>> laptop we need to keep using the regular ACPI driver and disable the
>> AXP288 FG to avoid reporting two batteries to userspace.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
> 
> It looks like this could be applied independently of the ACPI
> patches to the power-supply tree?

Yes this can be applied independently.

Regards,

Hans



> 
> -- Sebastian
> 
>>   drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
>> index 4cc6e038dfdd..903891a9bcf0 100644
>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>> @@ -708,6 +708,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
>>   			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
>>   		},
>>   	},
>> +	{
>> +		/* ECS EF20EA */
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>> +		},
>> +	},
>>   	{}
>>   };
>>   
>> -- 
>> 2.14.1
>>
