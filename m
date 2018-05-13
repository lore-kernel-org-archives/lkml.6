Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEMOcm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:32:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38231 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeEMOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:32:40 -0400
X-Google-Smtp-Source: AB8JxZr2U+HPJg6LqS35fEYbeRyGyyBn4kn5QN6nJGvgYPtoruLXfsNqNuZ6Ud4U5N+jytXc0edhKg==
Subject: Re: [PATCH v3 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
        Borislav Petkov <bp@suse.de>, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <1525464093-20280-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.21.1805131620170.1582@nanos.tec.linutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <abcb0e98-7872-95a6-21c2-4e021b54f8cb@roeck-us.net>
Date: Sun, 13 May 2018 07:32:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805131620170.1582@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 07:21 AM, Thomas Gleixner wrote:
> On Fri, 4 May 2018, Guenter Roeck wrote:
> 
>> Add Raven Ridge root bridge and data fabric PCI IDs.
>> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
>>
>> Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter, if you want to take that through hwmon:
> 

Yes, that was the idea.

> 	 Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
Thanks!

Guenter

> If not, let me know.
> 
>> ---
>> v3: No change.
>> v2: Use naming scheme suggested by Borislav Petkov.
>>
>>   arch/x86/kernel/amd_nb.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index c88e0b127810..b481b95bd8f6 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -14,8 +14,11 @@
>>   #include <asm/amd_nb.h>
>>   
>>   #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>> +#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>>   #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>>   #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>>   
>>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>>   static DEFINE_MUTEX(smn_mutex);
>> @@ -24,6 +27,7 @@ static u32 *flush_words;
>>   
>>   static const struct pci_device_id amd_root_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>>   	{}
>>   };
>>   
>> @@ -39,6 +43,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>>   	{}
>>   };
>> @@ -51,6 +56,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>>   	{}
>>   };
>> -- 
>> 2.7.4
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
