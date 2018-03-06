Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeCFKGt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:06:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42327 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbeCFKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:06:47 -0500
X-Google-Smtp-Source: AG47ELt6bsn8cECwG84VG64v83SQHzuYd8u3bZ4QNkaQx/xFWG9k72qLKyTtLsLAw/QLV2g6eo2s4A==
Subject: Re: [PATCH] k10temp support for AMD Ryzen w/ Vega gfx
To: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>
Cc: linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        linux-kernel@vger.kernel.org
References: <1769691A-DD1D-4641-B7BA-62C1BA571EBF@exactcode.de>
 <20180305230350.GA13099@roeck-us.net>
 <E39517F8-AEF1-444D-BA90-DE84CF656D7F@exactcode.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4938bed8-e612-959a-1b72-29dba0839ceb@roeck-us.net>
Date: Tue, 6 Mar 2018 02:06:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <E39517F8-AEF1-444D-BA90-DE84CF656D7F@exactcode.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 10:48 PM, René Rebe wrote:
> Hi,
> 
> On 06 Mar 2018, at 00:03, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
> 
>> On Mon, Mar 05, 2018 at 11:38:24PM +0100, René Rebe wrote:
>>> Hi,
>>>
>>> This enables k10temp for the new AMD Ryzen APUs w/ Vega Mobile Gfx.
>>> Tested on Ryzen 5 2500U, the temperature looked plausible.
>>>
>>>  Signed-off-by: René Rebe <rene@exactcode.de <mailto:rene@exactcode.de>>
>>>
>>> PS: 1st RFC - might get white-space damaged, will resend when ACKed.
>>> Sorry my Xemacs/Mew broke.
>>>
>>> --- linux-4.15/drivers/hwmon/k10temp.c.vanilla2018-03-05 22:22:30.974331180 +0000
>>> +++ linux-4.15/drivers/hwmon/k10temp.c2018-03-05 22:24:17.186327291 +0000
>>> @@ -40,6 +40,10 @@
>>> #define PCI_DEVICE_ID_AMD_17H_DF_F30x1463
>>> #endif
>>>
>>> +#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
>>> +#define PCI_DEVICE_ID_AMD_17H_RR_NB0x15d0
>>> +#endif
>>> +
>>> /* CPUID function 0x80000001, ebx */
>>> #define CPUID_PKGTYPE_MASK0xf0000000
>>> #define CPUID_PKGTYPE_F0x00000000
>>> @@ -89,6 +93,8 @@
>>> { 0x17, "AMD Ryzen Threadripper 1950", 10000 },
>>> { 0x17, "AMD Ryzen Threadripper 1920", 10000 },
>>> { 0x17, "AMD Ryzen Threadripper 1910", 10000 },
>>> +{ 0x17, "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx", 20000 },
>>> +{ 0x17, "AMD Ryzen 7 2700U with Radeon Vega Mobile Gfx", 20000 },
>>
>> Do you have a confirmation that the temperature offset is correct ?
> 
> I tried all of the three currently used offsets and this was looked the most plausible.
> For me having some indication of temperature is better than having none at all.
> Maybe some contact at AMD can shed some light on it, too?
> 

Per the information I got (not from AMD), those CPUs are not supposed to have an offset.

Does the system have a Super-IO chip ? If so, what temperature does it report ?
Also, what temperatures do you see with 0 offset ?

Thanks,
Guenter

>> Thanks,
>> Guenter
>>
>>> };
>>>
>>> static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>>> @@ -289,6 +2944,7 @@
>>> { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>> { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>> { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>>> +{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
>>> {}
>>> };
>>> MODULE_DEVICE_TABLE(pci, k10temp_id_table);
>>>
>>> -- 
>>> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>>> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
>>> the body of a message to majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> -- 
>   ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
> http://exactcode.com <http://exactcode.com/> | http://exactscan.com <http://exactscan.com/> | http://ocrkit.com <http://ocrkit.com/> | http://t2-project.org <http://t2-project.org/> | http://rene.rebe.de
> 
