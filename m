Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeD2SYd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 14:24:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37573 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeD2SYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 14:24:31 -0400
X-Google-Smtp-Source: AB8JxZoJtmyZF0F6zJDZ3Jh7t/yxqozokmlNd9Za2LpZHEVzMC23q5b3jsnAn+YGv+QcDIrTY4wdCQ==
Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
To: Borislav Petkov <bp@suse.de>, Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Brian Woods <brian.woods@amd.com>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
 <20180429175305.GB19814@pd.tnic>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a4b1d937-c5b8-67d0-b5f0-312145fefc09@roeck-us.net>
Date: Sun, 29 Apr 2018 11:24:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429175305.GB19814@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 10:53 AM, Borislav Petkov wrote:
> On Sat, Apr 28, 2018 at 06:54:38PM -0700, Guenter Roeck wrote:
>> Add Raven Ridge root bridge and data fabric PCI IDs.
>> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> This patch is a prerequisite for the second patch in the series.
>> I'll be happy to apply both patches through hwmon if that is acceptable
>> (and Cc: stable for 4.16+). If not, I'll be happy to wait for this patch
>> to be available upstream.
>>
>> Since that there is no public documentation available for Raven Ridge,
>> PCI IDs are derived from output of lspci.
>>
>>   arch/x86/kernel/amd_nb.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index c88e0b127810..bd33613ecb7c 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -14,8 +14,11 @@
>>   #include <asm/amd_nb.h>
>>   
>>   #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>> +#define PCI_DEVICE_ID_AMD_17H_RR_ROOT	0x15d0
> 
> I think the nomenclature we decided upon at the time was
> 
> ...AMD_<family>H_M<model>H...
> 
> PCI_DEVICE_ID_AMD_15H_M10H_F3, for example.
> 
> And in this case, it should be
> 
> PCI_DEVICE_ID_AMD_17H_M<which model is RV>H_F<PCI function number>
> 

Makes sense.

> Yazen, which is the first model of Raven Ridge?
> 

2400G is model 17 (0x11). I was unable to find information if there are
other chips/models using the same set of PCI IDs.

I'll wait for additional feedback before resending.

Thanks,
Guenter
