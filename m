Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeC3TIa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 15:08:30 -0400
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:9488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752343AbeC3TI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 15:08:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
To: Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <152236384612.3266.1451709369164076985.stgit@taos>
 <152236409481.3266.6464716993249076762.stgit@taos>
 <cac20ad6-4de7-b722-6ae7-769dd7655c74@amd.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <3eb931c8-fd4f-f08e-3449-00eb02aff52b@amd.com>
Date: Fri, 30 Mar 2018 14:08:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cac20ad6-4de7-b722-6ae7-769dd7655c74@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) To BY2PR12MB0694.namprd12.prod.outlook.com
 (2a01:111:e400:52df::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de3462e6-bd11-4ad3-6a3e-08d596719dca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:Hidg1AKAT4MfJBJ5OwkQnNOMyWS9PdyzZ+PK10c2EOi2NbrONZT6yazSxlkIDG7ZgXSkjsqCdUzPQgz4La6Rv+gU9zKHsEmbAkmv3phwvUDeMo2Y+BQiIqDzTxDixdv5LNuv6r2ZhSebp5vzSdT1sKH4kqYtTMVE4A+nsPIcN2srELAFRQ6YWxsKSaGxgfaSXrgcAVmEG0u/pRImYcobEOdLHGoQI9FWF4bG48LdLlz9PzD9ooyMFepwUiU5agYI;25:HvlTbYc3Beqg4Mhr7YO1uopa7PokylmdIj2GD0mVUtfNKQRU+9b2kLQP4SIw5xKo9iXNG9MbDTX4zcirIlqAZh0bNwlcUOhgUquc6PTf1Mu25wCKv4JQFXTE3kH1t2+WHls5DZqGyUaH/Bc+rQGO18gQpwfdXGoJm6l+USnhIM+fi7JwC+3+BQBVPhTWyp2ZtIo5xufxwtW/75d9MZG5gHliuLU78FC+GXASsuwmLdVugZdUAj3hQ+KUDHzjWUw6AVPfrPZnOkFuib5MKfxCqXOZHGjJyp1fbb24wp04rfdbMaZUe02oHHyI6d9KqApHGWqtB/Iylglus2zNI3SL3A==;31:+XaN6LshCgHjh4yudYfa8r/Y3agnE5PPVlJVKoiKoKTl4Z/nYCr1MWmDcRPEDYZ/JuK4EJ1hjBRVI6PnOS0DjEVn+na5N8vC2fUB0nGnsx+hlr59bkUYZx/qIiiy8DZtxh6qDIs9UsQwIGVkmZ/z/vv1DSWJjf/8QgRE1nQtzOc8PmrBLmQOZxtvxRFrcYxaitlunotM7AOGoej1ShHAEymD9rTCQ5GBAEWeOKBdJds=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:VGH2mqgDX49QS0+4QY68VaBcmWHVa7usTF66GwmTGKF+Epa1tUyyYo34OrvT1P2A45PsisVasKknngOgjcXNrnuu+G8tqWklL1S5Zb/RdvG0SwNSU3/VuPgJ8KxwI0UzTcknBs/7Mft6jT9v/9ed93h+HwtU4MR8S5XxkROyntXYvvBKPRo2f2b1tspdrJg3poMM7Y5NCC3QN5ZmAR91jv6opQioFoZtrxIIugQUaMB/PjCcxfKkTpjlJvsQ0fdWEciFmXB+J1+JM9o8IkXDoTg2yt8Veh0zWA4VlALzZ2ar/Tax9dRkJNBVp964A2mpqPnsKrTE/TqBu3GYPvkI3YDvtyNvsNs5xToiqJoL2IEljJiJSm8d6UZNVOA3U6hdAlex4P2pMcvwlov+Kh8LiScVwaW+rCd6MsjpFgJkJNl+kep6h0ubqc8sCZfQ7M07OiyS/kvGN76saoFhqIv2FKfkqoU83esn61cTuDw17AvtL2bnXwfFCpMVjknkNaUc;4:J/n/H+lJe3aAWlWmtdvU953/yqcJklP3GFW/daC/CM9VmCwOIG1oAiXmxvg37C0zjz72O1lzlrrh568ApOUjBRLpiFODpR13QuEAiNrbVnqN1I8wwaHRH8BD9bXYkd/jF9qjvzZPxpg3pF+7ejh1sGbT1t+6eugWQplSkJ2w1Qi/3bjq3SwA1jqXz5qqfKxwxJ4/wXaHX651VY1i8Ux7W9EptlFkURPLm3H4O58zRoOwAVIhlsZjMnIk3UG8dmAOR+7e+tXWELpqDPEklaILHPr+B+ljeBHzKc4dwlp0O7dGlQG6eJrgUkvMpMn4f+AI
X-Microsoft-Antispam-PRVS: <BY2PR12MB069490C4D313AE8B8091AA7AFDA10@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(956004)(11346002)(446003)(575784001)(53936002)(6246003)(105586002)(6116002)(3846002)(68736007)(305945005)(6486002)(86362001)(4326008)(97736004)(486005)(2616005)(486005)(5660300001)(72206003)(25786009)(76176011)(230700001)(59450400001)(53546011)(386003)(65826007)(476003)(478600001)(7736002)(64126003)(50466002)(36756003)(58126008)(77096007)(67846002)(65806001)(186003)(2486003)(31696002)(52116002)(23676004)(52146003)(16526019)(16576012)(8676002)(316002)(6666003)(2906002)(47776003)(229853002)(26005)(81166006)(81156014)(106356001)(8936002)(31686004)(65956001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOkhLdkFBcFlETW9nREk1WkUwRWhCb2liWTM5?=
 =?utf-8?B?VVJRaUpFc01UOVpxNVlibC8zdFZiWWRQdmg0R0Z1VndoK2NRaktTclhrMUhF?=
 =?utf-8?B?Y24xYTJhYVpUUXpiZ1BHV0FsdFYrWGNlVkVqUmdIN1BLeUx6a1NoRkZwM1k5?=
 =?utf-8?B?dzdHUXJYK3FVNjNrU2RCSy9IRWgrTFE4cWk1NnA1WFkvWDlkaVlYL0VwNWZi?=
 =?utf-8?B?eldxY3V1Uytydmdxald6OFh1UWRuZ01Rb09wQ2oxVTA0Nzk5OStUd2o5akNi?=
 =?utf-8?B?Z2JNYXlGSDVkclFYM1FnbGFVTG52cVYwYVowdGR0M3BESUlwTVd2S3BNSVph?=
 =?utf-8?B?cG9Ibm5vYmhSWHZsdHpHT3ROUFQ1YVFCcnAzdGs5TzZZa1RHek9idS9TSmRI?=
 =?utf-8?B?dGx0LzZQMm5DMmVaaDZZb2dSOTBoM3IvQXVON1dycjJBZ05QWjRObXVCSk5u?=
 =?utf-8?B?bHZBZFl0N2ZvdG8rUHQvbVVMZEtVTC95ZEExV1FFaUVDb0plNnBXL1VPcXRL?=
 =?utf-8?B?ZWwybUxQYnRndEJMbmRiZWNrM3lqbjNhU2ZoWjU0MS9TSkpPZDk0MlhQSG9V?=
 =?utf-8?B?WWhPNkZVR2NudXN5MFluOFhFMXVWL3FtNmQ5UjRXZWdWVUlFSlNKVjcrT2wv?=
 =?utf-8?B?TVY5bmZhUkpDQ05TL21HeE5GMStqWU8yR3BVQlpodFpoOS9IUXNVNGxUMks3?=
 =?utf-8?B?ZDRiajhrdG1sOFQ0QnhTSnZZazZaRkxhRW1WOXdzeE82L0Y4NzhtdmRKeTdL?=
 =?utf-8?B?aXIyVUNXSUVBRW41RFB6SmlvT1MyQVlVTzBOOW4ra1Fza1NMSmd2ekJsM2Ji?=
 =?utf-8?B?dG9URGNwSXVmN3pGNHR6MHpLYmtOcWRDZ0VvVTFUejdxT2RDYXlKTWJYUnpN?=
 =?utf-8?B?NkZFenh5OVM5QnZ2SmhwUThoQnJXR3RZOEh1VVgzczlodVlnVW11cm4rS2ZC?=
 =?utf-8?B?MDRUYm5oaU9lanRzemtFakJ4QmlmSmNNaFZLaVY4UlNlcFlkdXcyYytkMGsx?=
 =?utf-8?B?MWVRcXdEN21CVkl2MDRob0RaNGJJdW9wK0lOQlJFdVl0OFF2RDJtMjRabWQ3?=
 =?utf-8?B?REJoWlhMTm5EMTRRUWRVdkJSUm94ZmdrTWpEZlRWOHFRNW5XSnZiQWdqSmpl?=
 =?utf-8?B?bEUvM3RjcjhJTzF6M0p6QWhJTnNvSnZGYmh0VXk1Vm9iTUs0ME00U3ZtNlJa?=
 =?utf-8?B?SjJwQU5kb1VsVlEzajZUUGR4TW5IcEJsMUhkS1hHa285TUhFamxqQjY4NmRx?=
 =?utf-8?B?NzNFbWtVRTVaU3JDVHpPZWVsM1JWaFdpTjBML2ZBL28zYzdaTlJkckdrdlN5?=
 =?utf-8?B?QzRZVmZNLzB4NjIrYlNWWVlvMTd4VUdEWVFzYTFkM0hBeFFtM3VvUVZaanp6?=
 =?utf-8?B?NXJSeXVsU0V1RjZhL3lKM2RmZVA4azVEamltSkpYVFU2cUw3S2NnQm52R21S?=
 =?utf-8?B?V2xpdktBVEVDajRyOVFndGJlbFBONkVEKzVBTHltWXhmT3VHOUdORjFHZnU0?=
 =?utf-8?B?VXBvbUFmUFQ4SkdDZnR1TUV4b0Nub1BFemFWYXdWdVRRcXVuaGtqcjVTcjBN?=
 =?utf-8?B?MnZVODhxSmJyVjBFUm1aek9nalN3cHpGT01IdmhLb09TelpxQS9SWG00c1hH?=
 =?utf-8?B?MityMG1SR2xVR2FVZlBnZHE4T0tnd1M1KytxUXZDQkRFZTlMK0lSN1JTaVNh?=
 =?utf-8?B?Sk5SMUExRjFnVFBrV2YyWnVhdDdweEJ2S1pxNWczMjdsOEhSTStnVzZIZk9l?=
 =?utf-8?B?cXNSVkhBTnM3bTVrZUlhWmx5eGxTY3lnOHl5VlpFbVF3UU9hSDFCOGcxZVBO?=
 =?utf-8?B?bEVVaUJxS1paLzFOYU9wd0NsTERLSytoV3dQTzVhSFV4UFVHOWN5L0ZRTUFD?=
 =?utf-8?B?TEkvN2JEU3llTmhoanhOVTJEaEFHR1pXN0FGK25UTDhNNkMxT25VZzE1bmIv?=
 =?utf-8?B?b0xjc2J1K0ZVY29VcmtMa3BWSm5LVXI1VFNPK3plekwwa3g2MHBsbnVGVjVv?=
 =?utf-8?B?QmVPc2NsdXI3enp1VkxsQ3hML3VIQVRTOEtwTFNoZlhjMHNxRzNscFZvTUs5?=
 =?utf-8?Q?tqWQ=3D?=
X-Microsoft-Antispam-Message-Info: lCKDzEyvlLtpoXKazSOBBBeAK3i2xaUhcwh3eIGZZMaGzfRbzIQbG3BL6AI9GGaKzWWY9GEtrsk6/A8L+6F6Lt1Q9JlpnFT2Psw83H5wMMBfSBXGvEQXe/muwiBgy/ILB76F6KT/d35Dyp7ZeFV0lHFdow32BWPWnojxSUMV+EtvL32bPsQRbfelughvTPTR
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:powKHPnJInFNkVbChrsXZjwN7iW4Mz+O9mQE7m8riPkQtCxP+DwcAAJmFI2/4Rd4mYGx0AlhAFG/sUs9AdcTs5t66HoWb+ILJ5swuNiPc+POgw/Wt4TphNQaTRsUgFyBy3UycYpcHytRx9shh72X5U9z3is9IYKNLgsnYe7Xv4roXORj085yz6EVRN6MFxH3wEzoq1xjTu4GaliZqR0T71MbnZ5RnDe8eXPQzD3NQFfG99X3btxrf4mdRL17i/zTXCTH6qWVjHEh7edWodbvnDFa6KFJZtMOofVjkSyfjE4Idqvcaa+ocA1o38wVDWM/CIZYGCUtjFNCjdl9Ox52hrB5cFdqlZb9xa25dohVgzCnz0WwKsteD0Ti9N8v8UTRGkdabbSyBrYaV7bb/V31JCIL7BAvTf8ZEqtAaO9SisFSOfCBqkhWqApg5aTyNgqYcMLN4iY0JvgccOggiiGROA==;5:tJ0EsdeOPwtlWBnvLPhXmTnWPeCDw3WmQavPAvb4MdHMEgEJ2LiWs08M3tGThADnrtF6KIU7vWAIs57xfD6gBwORuWNS4TlAUXAljQKcd72hHxTz6SkEhiOwPGkic957PWAcZiadoO+sDTqFg6YLJO7LAPAJWeeLL2yMimTis70=;24:DI1+TyDCo98/wshyszZGKfFIFTMF+Ah/ElSw/h/+oAj+qZPN58XZ2xKbUPjxulg9usQT+jWNiPCyvct8t0zM2eqiYAVePG9Co/c5ilTmr9Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;7:ibF8s6tZiY2LX5AefxEa555gekeJ5BjEqxhOWr9BW6w5pn/5PV2qFx/bcrerDAV/2B7tRdrzJ4NXoEodyUsF/CmQ6JQqyewzniJ18JgazgnTMItgp/jZUiIEIHGvpjglASYLfGNM8GlQBoZc9BOsgL3QyNfFsiicKu2NX/fsRlkMKwo3f1WciBvdSD7/PAqFQ1AawxF2Vl6MbTVW8ChtyGHzO2ri5w3mykZnIPZHTxxQIGmKsVpKg3h/2Uej7bce;20:aTBAnngdKFyatdz2V/P1dj3jpO8VMwKZt+9HkhrtIb2SD7HX2kONd66GY5MauldgysXAVcA6bjHfWNpm9k8yLNLogpT+PhRXjBSSzMnByh0HJcEf5zvwAQPYDRO1t+jKkde/CFkmcmZz3uuG5Fls+/jlh/340XSi8tnHPTWUZRrs1vgZfBHOuKRjWXpIWXLUcuOsQx62JQiBgCzH4AL6tGs/VDeqb0zFX/nSJzaRc/i8zWyHiYErH/T564b06AJ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 19:08:26.1958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3462e6-bd11-4ad3-6a3e-08d596719dca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 11:16 PM, Tom Lendacky wrote:
> On 3/29/2018 5:54 PM, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU.
>>
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig             |    6 ++---
>>   drivers/iommu/Makefile            |    2 +-
>>   drivers/iommu/amd_iommu_debugfs.c |   47 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    9 ++++---
>>   drivers/iommu/amd_iommu_proto.h   |    6 +++++
>>   drivers/iommu/amd_iommu_types.h   |    3 ++
>>   include/linux/iommu.h             |    8 +++---
>>   7 files changed, 69 insertions(+), 12 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d40248446214..8d50151d5bf4 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -65,9 +65,9 @@ config IOMMU_DEBUG
>>   	depends on DEBUG_FS
>>   	default n
>>   	help
>> -	  Base enablement for access to any IOMMU device. Allows individual
>> -	  drivers to populate debugfs for access to IOMMU registers and
>> -	  data structures.
>> +	  Enable exposure of IOMMU device internals. Allow devices to
>> +	  populate debugfs for access to IOMMU registers and data
>> +	  structures.
> 
> This help text shouldn't change just because a driver is making use of
> the interface that was created in the previous patch.

Roger. It should be changed in the base patch only.
> 
>>   
>>   config IOMMU_IOVA
>>   	tristate
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 5e5c3339681d..0ca250f626d9 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> -obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
>> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
>> new file mode 100644
>> index 000000000000..3547ad3339c1
>> --- /dev/null
>> +++ b/drivers/iommu/amd_iommu_debugfs.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD IOMMU driver
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook@amd.com>
>> + */
>> +
>> +#ifdef	CONFIG_IOMMU_DEBUG
> 
> Since the module won't be built unless this is defined, you don't
> need this.

For some reason my build is trying to compile this file, even though I 
have the debug option disabled. Gotta track this down.

> 
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/iommu.h>
>> +#include <linux/pci.h>
>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
>> +
>> +static struct dentry *iommu_debugfs_dir;
>> +static DEFINE_RWLOCK(iommu_debugfs_lock);
> 
> Use amd_iommu_...
> 
> Also, didn't you run into an issue with the CCP and debugfs creation
> during probe using a RWLOCK?  Should probably make this a mutex.

Yes, and had to make a change. I will do so here.

> 
>> +
>> +#define	MAX_NAME_LEN	20
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +	struct dentry *d_top;
>> +	unsigned long flags;
>> +
>> +	if (!debugfs_initialized())
>> +		return;
>> +
>> +	write_lock_irqsave(&iommu_debugfs_lock, flags);
>> +	if (!iommu_debugfs_dir && (d_top = iommu_debugfs_setup()))
>> +		iommu_debugfs_dir = debugfs_create_dir("amd", d_top);
>> +	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
>> +	if (iommu_debugfs_dir) {
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> +		iommu->debugfs_instance = debugfs_create_dir(name,
>> +							     iommu_debugfs_dir);
>> +		if (!iommu->debugfs_instance)
>> +			debugfs_remove_recursive(iommu_debugfs_dir);
> 
> So this might cause an error.  You remove it, but don't set the variable
> to NULL, so the next IOMMU that is probed could try to use it.  But why
> are you deleting it anyway?

Right you are. My thought was to remove everything driver-specific in 
the event of a failure. Do we not like that?

> 
>> +	}
>> +
>> +	return;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index 99d48c42a12f..43856c7f4ea1 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -89,6 +89,7 @@
>>   #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>   
>>   #define LOOP_TIMEOUT	100000
>> +
> 
> Spurious newline.

D'oh!

> 
>>   /*
>>    * ACPI table definitions
>>    *
>> @@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
>>    */
>>   static int __init amd_iommu_init(void)
>>   {
>> +	struct amd_iommu *iommu;
>>   	int ret;
>>   
>>   	ret = iommu_go_to_state(IOMMU_INITIALIZED);
>> @@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
>>   			disable_iommus();
>>   			free_iommu_resources();
>>   		} else {
>> -			struct amd_iommu *iommu;
>> -
>>   			uninit_device_table_dma();
>>   			for_each_iommu(iommu)
>>   				iommu_flush_all_caches(iommu);
>>   		}
>>   	}
>>   
>> +	for_each_iommu(iommu)
>> +		amd_iommu_debugfs_setup(iommu);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -2783,8 +2786,6 @@ int __init amd_iommu_detect(void)
>>   	iommu_detected = 1;
>>   	x86_init.iommu.iommu_init = amd_iommu_init;
>>   
>> -dump_stack();
>> -
>>   	return 1;
>>   }
>>   
>> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
>> index 640c286a0ab9..e19cebc5c740 100644
>> --- a/drivers/iommu/amd_iommu_proto.h
>> +++ b/drivers/iommu/amd_iommu_proto.h
>> @@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
>>   extern void amd_iommu_init_notifier(void);
>>   extern int amd_iommu_init_api(void);
>>   
>> +#ifdef	CONFIG_IOMMU_DEBUG
> 
> Use space instead of tab.

Yep, fixed it.

> 
>> +extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
>> +#else
>> +static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
>> +#endif
>> +
>>   /* Needed for interrupt remapping */
>>   extern int amd_iommu_prepare(void);
>>   extern int amd_iommu_enable(void);
>> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
>> index f6b24c7d8b70..6dca9fe38518 100644
>> --- a/drivers/iommu/amd_iommu_types.h
>> +++ b/drivers/iommu/amd_iommu_types.h
>> @@ -591,6 +591,9 @@ struct amd_iommu {
>>   
>>   	u32 flags;
>>   	volatile u64 __aligned(8) cmd_sem;
>> +
>> +	/* DebugFS Info */
>> +	struct dentry *debugfs_instance;
>>   };
>>   
>>   static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 98527f9b473b..dbfff811aa25 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -412,6 +412,10 @@ void iommu_fwspec_free(struct device *dev);
>>   int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>>   const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>>   
>> +#ifdef	CONFIG_IOMMU_DEBUG
>> +extern struct dentry *iommu_debugfs_setup(void);
>> +#endif
>> +
> 
> Any reason why this moved?  If it was not in the right place in the first
> patch, that's where it should be fixed.

It was in the wrong place, but you are correct. I'll properly move it in 
the other patch. Thanks.

> 
> Thanks,
> Tom
> 
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -696,10 +700,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>   	return NULL;
>>   }
>>   
>> -#ifdef	CONFIG_IOMMU_DEBUG
>> -extern struct dentry *iommu_debugfs_setup(void);
>> -#endif
>> -
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   #endif /* __LINUX_IOMMU_H */
>>
