Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFEQ6V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:58:21 -0400
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:52544
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeFEQ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:58:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Greg KH <greg@kroah.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
 <20180529183917.GA10618@kroah.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <f0780139-5322-a028-0091-3255e0596eff@amd.com>
Date: Tue, 5 Jun 2018 11:58:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529183917.GA10618@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0073.namprd05.prod.outlook.com
 (2603:10b6:803:22::11) To CY4PR12MB1445.namprd12.prod.outlook.com
 (2603:10b6:910:f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;3:oDVttFNTFlK5gTMTgK0aCm1CjkkShk/luVJU/ug44RCX4YfZV9gyesVcDm95j7UDfmlF4h4+LzYnbHVNdOQtBJOcgRGO2Ly6mi66MlmsAZsCzaxDVR0isU+62l2SVuqmsBueeZbLamsrcrT3Lodhyk6tUB6eKe9CiIDfiDk/+klG1s3s8czak0yankNG+StzvgvhkMNVQip3hYi640WR8xpe/AaTZNB4MJ1DaU9HCESvgRy7Lsf9AIH339MBg67B;25:Xa3lp6nDmznUoyPWld8BvwPUSil5hCRRPAVGGHvXcat7/jQt61dtec3O4K/SpTVmr83dY7b6gfZEzHG2tVDu2IXnLzKC+Nd1zD0m4u7rnraouaT/bT48bR7QBJiRqPjm67AXaClFpAiRQDWYpTI5iGhat7yqtUJa7wFeDWb/X/VEHh//i/hK3VpWA6jdtF22hK3U3dZfwWmDJPKdvj6UaRCAQkoxg1fbP/ma65pwhHbPl+vxHYM0/7Ccqu9O4dp7boXX9LTvwS15UbMBRZYDW5dv5YdELwJ29UXI8NbIfB7l/Lf790Mgr6gHWbrGaQ3WNObFI+PalZuLjrAZWNIF5w==;31:LCjbtGTZ1skkd7AZsAb3NjrtYg7N+/5fte4ozc64/PscVgEZ9dCtvMG9t4yKZxm685/SC64KMIUVlqo3lI6n09f1i4KbWmVdsTAD/b7Cr3CZN6n1nwqFUNJa3Q1nTqDRhtRbeV/Qw5cryR+UaurWtEKWQFiSnqc8oMWUTXqktysWsi9fbNZNdTy0mqaMFBaAKzkNhpeh2MRmO5Ma3qu2+HpFVUlINOBDCxTMwGS4rwk=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;20:ashevRBmPgAsQ8Pa6jazXRLo9aTlZKcydOZfKXKvkJ2SAhrEdqXQMEIDKo4yOCSg3Mt/6jOwo0WJtevk0y+rf7igZfy69e/t/izBdUi+gZC8bv5QsTHwB+W8bKkDGSn6YVxULjn9J90QW2s2k2RxYqETjhRacZYcZy4MNui5i4fosOquX75CrdCnPAh8abDfvsqhA91Ovovd0cS0JL3W+JwJZlpYQZgrSduDFrvnqGam47WDn6rMVnJJdjBHQGlOsVwCBKNESszyJLt/2s5i0DwzfUifFi4zgvM5HaWQDpkttNQ73FCEmrxsELWsor9HPiVq39Ji7/wEmRbxnREy+1puSZExCbEn9aE6FhPPfgC6tyOJgSEigCQM9xiokYUvb3yJJPsQlpA9iWh+tV1fEccTL+HQPpFG9cR1L6ms0H96inE+3oAYOsw99XZHJrzKpIwlBPfmBYh6naQ1TqHsXyOxfXmShLBZdzVQ3yL0yzK/5G43KbtcHi0tz9WotVzR;4:aG0I/iXb3XzY0rcQJJiY3GylaCTUKEjFFIlEP47/eaV7qOxieBXbT6K7wdhFYhBYYcPNElJcPV5MvPU0o0QNWELy71XPv6wElgfoL75SKeYoDfQE+FQvh30s2vFpyBw8/peHNciIFVSYNWeuaxD5djvoldmW0+ft9J2TmPH0jRmtjkRQ0h6mQgOhhnW0BUjESEpda/VcsRq/ZlcTm2/nAJu7kKIGA5J9yEmzBtnukV0kZGwLGr6q4q41cIEiwWogw1CcoxbdCrXZi/t021UOOXeipFQHwx8jlskQkihQVQNBIEc3HuYkcEyt+Mt6V1Lc
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445880E11C10700193CB9B6FD660@CY4PR12MB1445.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1445;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1445;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(376002)(39380400002)(396003)(346002)(199004)(189003)(229853002)(59450400001)(66066001)(65806001)(305945005)(65956001)(81156014)(81166006)(6666003)(6916009)(53546011)(65826007)(5660300001)(6486002)(72206003)(67846002)(68736007)(58126008)(186003)(316002)(486006)(105586002)(31686004)(16526019)(16576012)(6116002)(8936002)(7736002)(50466002)(6246003)(8676002)(77096007)(97736004)(26005)(53936002)(52116002)(36756003)(106356001)(4326008)(476003)(52146003)(25786009)(47776003)(2486003)(230700001)(2616005)(31696002)(478600001)(64126003)(386003)(86362001)(23676004)(956004)(3846002)(76176011)(11346002)(446003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1445;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ1OzIzOmI2VmRvU2pEZ2hnckR2QmZWc1pIZnh3SWlP?=
 =?utf-8?B?blBnTjFSbmg2eHRDZVZtQmRKZ1R3UGpTRXJQWDRzUjF1cTJRdHJLL0VTUGxj?=
 =?utf-8?B?V0c4amptN0NVL3Jsci9DTmxmRXY1QjZodlBncHpJNTVac3pBOVlBQU9GbkdI?=
 =?utf-8?B?Zmx4a3JqZkNCM01VdUYrUkFISThobkdvWVNJTU11RFR5czhhQ0NWTjZSVkRS?=
 =?utf-8?B?ZlBReTJBWVA0U3dSS080eWt0dEd2bVk1SFFVZjBtRzBRaGV2aW1uMnpvVFow?=
 =?utf-8?B?UWIxZHFaUktYSW41M0w0ZEVVT2hiazRGRUN4RGlEV3J2cFZzL0E5ejdvQlg0?=
 =?utf-8?B?aTAxQjlsWXl3akczN1A2L2dNMFd3VkJ3LzZncGJuU2Q3Q01xT2lYSGc0enNV?=
 =?utf-8?B?WkhRS0lRZmlNZXFsck1EWkY1UTV2Rmh4ejNJWG9tK0grLzU4cHNVenpZS1Vk?=
 =?utf-8?B?TGpDUGYwaVN1MG92emJQbFhtWXRMRjgxN3RvYldjTWVXZE1wckVjSS9mQkJq?=
 =?utf-8?B?WWFudFJQd3J3dE5CTHBKUUZSMk9pdUs0b2pTWEZsRWhFMHFaMzlabkNmcXo4?=
 =?utf-8?B?aWV4dlhvVS8zRHJyREN3M3JMaGNrVHdtWXluMlgvRFBldkV0RmE5MHp2Q3JP?=
 =?utf-8?B?WlplN3loOXh4dWh3WVg4RXo5am9JWDVWa2hmT0VnZkdQZDJDRzB0TXZXSm9U?=
 =?utf-8?B?MjVSaE1jMkc1TEtRZmFHWGUrb1ZLVkxYcEdPOHRxSTVOZlNEQU8wa01EdVp4?=
 =?utf-8?B?dC9oejgxcWl4RDh2Q2puWUdDZEROa093QzVkRjIrd0N6UFdnZlZqRmZsV0Uy?=
 =?utf-8?B?MWFhQ0k1Q3ZkSkFWWHJlR3V1MjJVY1VvMVZUcUUzMGlxemdyUFZsYVhXVDJH?=
 =?utf-8?B?OHljSmFIeENaNGg4akFaSHlZUmZHTHJDRGF1UUpLcmM2UU1ZMGU4MWJwOWZR?=
 =?utf-8?B?dVY4TnhUSHJpaFpMQ2dhN2RqenhsRXBZRCtONjAvZmRqSS84eU95b0g1OWsz?=
 =?utf-8?B?QXdqeTlPMXhqK3pzLzVMemJTaC92d0g2aVdITGNZL09HYm9kV2JaWks0VmxE?=
 =?utf-8?B?bVVVTmtKeEZ4ak1ab1NEWUFNaC9McU5lbWg3ZmVhSW9MTnRuOGVuL09jRVpn?=
 =?utf-8?B?U0l5ZCs0YkFqUUxzOGlrSC9pZnh5bTduNFJxREFSVlJTcmp5YUxJMjcxekVj?=
 =?utf-8?B?R3dRd0F1VHhyL1FlNmZ1aTlYWmlBYmZYTG1CR3VRZzNxWmVqc2JmTlhXZVRO?=
 =?utf-8?B?S3JVK0hlai8yeHlYbkFvUnhhOWtnZERUdVVDUWFGV0lJWUdVQUN2Zit4bUgv?=
 =?utf-8?B?ejlpWE8rcW05UDZpK2pqWlZwTEhlaklrZlhZY01vKzhnV3hnQjBCeXROb1R4?=
 =?utf-8?B?L01QamFWMGp5UmxHUno2Tjd2bDlLNlkybWNSOEpzcTJHeDhKTEx4SUFhZDNG?=
 =?utf-8?B?SWpQQThwbHBQTVZQa0NOUnpLNDJlVC9ieGd1UFFYMmxUbXVlYUNrVlJwb2dP?=
 =?utf-8?B?YXZ3RnRMbVhzQzdJV0dFdWgzSExmZFBQUU8yZVF3ZnliMnZJdXY1czF0bHRh?=
 =?utf-8?B?Z2MvL05qM3Rqc2dGK004aEwwNm9POXpNb2x1dDdzNktJMzlteDV3S0o5Tlhm?=
 =?utf-8?B?VjhuRm9vOENLL1RlM3dDVmZGd2tEd1BmL3VJM1BSZmtNYnF3QmsxYWJnQ2Ns?=
 =?utf-8?B?c2FDSGlnbVpQbTRTNDZLbE9NSGV2VmJLQUVFcExKNUF2SzZ4SnNDOGJFVndF?=
 =?utf-8?B?aWNSaldONWFzOXBvZzFza1RraFlyRHZVU2J3M3Jja1hpRE95VDJYTGl3djFr?=
 =?utf-8?B?RkxwV05WUzNrWXk0VzlMSE5qeWk2YllFWS8rSHRwMUFrVStLZkdYbVZ5TTV4?=
 =?utf-8?B?aG03RXUyNEZwMEdpSm1HSVRiaW1tRzN0aXA5Ky9yTFZ2cEJ0NFpBL3FQM0ow?=
 =?utf-8?B?ZDdMQlFHdkYwaEV6UVNlbU0wZlUxRHVsM21RTFRLb3lRZ3dzNzZnRmcxUEJu?=
 =?utf-8?B?eExkWUl5R3YzQ0t6Zmp4NTJTRjJzeHcrSm1Gdz09?=
X-Microsoft-Antispam-Message-Info: Hj1pgrKlbc314PMa1vHTegZ5e/Xjuon/85H2K9rKsmfJ2LkzlGL4rP2oUIZOVLjAl669ViPoWaAqkkzwkZyw4mxNuSUwRoRrgYHNyG0pHi2fod8UQYiZ1yWWIqfijxTeSsWT51a47tLe6E4OA2a9bP0tIsKxUPD8aULn0IIvdO7I3Wns5sbbHzRKaMPzWgT/
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;6:6JzX4CWESIn86wRnrBdq+CByaO0WQMMuPyJEemDSiSIOTEqRnRrQAOu8Nok/gniSkexxSSgDzxjBKHdO67Zx3dP6flYbqZTAQ3zdB+IXuPYcY0QPf64cSinCDRJp3GSyfRrkh85XJx1CxP4hH9Ukw5C02w97LVVwGKrVQYg6DYa5N1WHuxuBEO9rbl8WawpDpOvhbe1I9IoYmw2MB5RHXjCAfS9ShqXmzmqSAAcjcnoL9nt/flkkuK1xmfADDZHW333BRNgMNr7bop74+VaBLfizPzLnsSXPl6oWOrBUOqfNaAwjzTJZmyuSP9TdsZesBglZkI2rPuNgIg+TiZ/f3jBJCGCajySzZN45wZUWDf2X+zRji1NtKSSV5D/KjxTDmk15DxsxNWpIQPyeRafcB5wTVjqhSJjd8291uVFcK7m3WuQT+ILABkYq0Umcf7ApGNWbJB/1rTomL6NOXLXlWw==;5:fsbn6fntwc4d2SRCwu9suibIBA2rnfAbNTdyxl1a/AUqG3A6WrG5+E+apTNbPcJFGFWpk3ROOiaLUSnOvRiyyQXXnQ5DraoI2SQsSRvpmeiy8L0BKe/w/dEI6qmKHUshk9NBUJ/ikPi3ppKLBSLAcv6fnf9Ro+5hrtymA7YeojA=;24:w5nIsxV7SOotc2A+TML+B/QJFTDGmuKHcA1JMYfvG/MMCg91fKnpc3QYH09cngwAR0bSweYOVtj7CVID/qq0R76JGy2P2wF+Wj5dTaDbVPo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;7:l2lnIkzenEekC4SoC+BCZ08QRwBwh2D9DoNQDDWIZh+W/LrU8x9cW1Z5Lj4Hu3iR6Oli+UMDby1sRo1fyr9kVUFNapZaaJIMLpZ/PhSq10KuU/ahj9G5q0156KszuBRpCzXnhkFDRapsG0WtxOpc6LAqT9PZ6+RpJXcKcd8JymhVmwGtBXylv2G9058f2jfeG62LGdaaCC42Be6sVEyYTIP42BshQJt16+CAyn997hvB9IGsH1RQnXqHH0UOhwdJ;20:fSiL66FV3c1lEKKiqdfRsviMXS1OwhAlkmwg3aBzvAWtqyA+2uYUakdZVUY6/4JXkAeeNCyN2Rc8Ti/qLHLU6vA1hleAVjbrJE6I1NN7cFLYVF6ykZyL/U+ze3fZBChIjXbnk/ugBdUgruOntkBUXkoNA6W2ECE6bphIsFtAem7myy5af0EEFcIt99XppPQQlRwz1yDQfLNr64ZG5/d8IFBYjn7mQr9libDxBB2UtReieBMI8zaAeXAp2wLK+w50
X-MS-Office365-Filtering-Correlation-Id: 708bd338-6f04-4349-3760-08d5cb0588cd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 16:58:17.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708bd338-6f04-4349-3760-08d5cb0588cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 01:39 PM, Greg KH wrote:
> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>> for the AMD IOMMU when general IOMMY DebugFS support is
>> enabled.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig             |    4 ++++
>>   drivers/iommu/Makefile            |    1 +
>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>   drivers/iommu/amd_iommu_types.h   |    5 +++++
>>   6 files changed, 59 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f9af25ac409f..ec223f6f4ad4 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>   	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>   	  table.
>>   
>> +config AMD_IOMMU_DEBUGFS
>> +	def_bool y
> 
> Why default y?  Can you not boot a box without this?  If not, it should
> not be Y.

Again, apologies for not seeing this sooner.

Yes, the system can boot without this. The idea of a hidden option was 
surfaced by Robin, and after my first approach was shot down, I tried this.

Logic: If the over-arching IOMMU debugfs option is enabled, then 
AMD_IOMMU_DEBUGFS gets defined, and AMD IOMMU code gets included.

This issue was discussed a few weeks ago. No single approach appears to 
satisfy everyone. I like this because it depends upon one switch: Do you 
want DebugFS support enabled in the IOMMU driver, period? 
Vendor-specific code can then choose to implement support or not, and a 
builder doesn't have to worry about enabling/disabling multiple Kconfig 
options.

At least, that was my line of reasoning.

I'm not married to any approach, and I don't find clever use of Kconfig 
options too terribly challenging. And I'm not defending, I'm just 
explaining.



> 
>> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
>> +
>>   config AMD_IOMMU_V2
>>   	tristate "AMD IOMMU Version 2 driver"
>>   	depends on AMD_IOMMU
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 74cfbc392862..47fd6ea9de2d 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
>> new file mode 100644
>> index 000000000000..6dff98552969
>> --- /dev/null
>> +++ b/drivers/iommu/amd_iommu_debugfs.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD IOMMU driver
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook@amd.com>
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/iommu.h>
>> +#include <linux/pci.h>
>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
>> +
>> +static struct dentry *amd_iommu_debugfs;
>> +static DEFINE_MUTEX(amd_iommu_debugfs_lock);
>> +
>> +#define	MAX_NAME_LEN	20
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +
>> +	mutex_lock(&amd_iommu_debugfs_lock);
>> +	if (!amd_iommu_debugfs)
>> +		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
>> +	mutex_unlock(&amd_iommu_debugfs_lock);
>> +
>> +	if (amd_iommu_debugfs) {
> 
> Do not test this.

Okay, noted. I'll stop worrying about this.

> 
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> +		iommu->debugfs = debugfs_create_dir(name,
>> +						    amd_iommu_debugfs);
>> +		if (!iommu->debugfs) {
> 
> No, you don't care about the return value of any debugfs call.  Just
> save the directory and move on.  If it's not correct, find, nothing is
> wrong, just keep going.

Roger.

Thank you,
Gary
