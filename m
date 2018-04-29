Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeD2Qab (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:30:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35546 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeD2Qa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:30:29 -0400
X-Google-Smtp-Source: AB8JxZq13c4vLghDInD9e/4q7T5n4ihnZJ28AhjR55ppq1i7pv+KNQyIvyICxjq94eJQTaAbqatu9w==
Subject: Re: [PATCH] hwmon: (k10temp) Add support for Stoney Ridge and Bristol
 Ridge CPUs
To: Gabriel C <nix.or.die@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Brian Woods <brian.woods@amd.com>
References: <1525018605-22302-1-git-send-email-linux@roeck-us.net>
 <CAEJqkgic1kvLiGwOtEWOWh7V_icht_cGpCTis+1NH-31sw+BGw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1787a000-15d8-1477-a3b8-9ac9840fc575@roeck-us.net>
Date: Sun, 29 Apr 2018 09:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgic1kvLiGwOtEWOWh7V_icht_cGpCTis+1NH-31sw+BGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 09:28 AM, Gabriel C wrote:
> 2018-04-29 18:16 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
>> Add support for Stoney Ridge and Bristol Ridge (Family 15h Model 0x70)
>> CPUs. Registers match those of Family 15h Model 0x60.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/k10temp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 34b5448b00be..f014e03eee5a 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -36,6 +36,10 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
>>   /* Provide lock for writing to NB_SMU_IND_ADDR */
>>   static DEFINE_MUTEX(nb_smu_ind_mutex);
>>
>> +#ifndef PCI_DEVICE_ID_AMD_15H_M70H_NB_F3
>> +#define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3       0x15b3
>> +#endif
>> +
>>   #ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
>>   #define PCI_DEVICE_ID_AMD_17H_DF_F3    0x1463
>>   #endif
>> @@ -319,6 +323,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
>> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M70H_NB_F3) },
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>          { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>> --
>> 2.7.4
>>
> 
> Is working fine for me on an A6-9220 APU.
> 
> Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
> 
Thanks again!

Guenter
