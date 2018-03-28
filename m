Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeC1S3n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:29:43 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:47674 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeC1S3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:29:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com;
Subject: Re: [PATCH 1/1] x86/platform/UV: Fix critical UV MMR address error
To: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180328174010.882366342@stormcage.americas.sgi.com>
 <20180328174011.041801248@stormcage.americas.sgi.com>
 <alpine.DEB.2.21.1803282007380.1496@nanos.tec.linutronix.de>
From: Mike Travis <mike.travis@hpe.com>
Message-ID: <41837153-d677-ffd1-5c17-ad6cae882935@hpe.com>
Date: Wed, 28 Mar 2018 11:29:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803282007380.1496@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.48.179.6]
X-ClientProxiedBy: CY4PR22CA0063.namprd22.prod.outlook.com
 (2603:10b6:903:ae::25) To TU4PR8401MB0864.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7710::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5dbd3d7-a813-4e71-ff24-08d594d9dd84
X-Microsoft-Antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0864;
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0864;3:NeUOZbE/tB3Dgd2uxH11wnSYKSZx8vRqxMK7OnGlWOb1doACY7S3mqOpOPEzQkSwWx7qn2MmtalFe/QMnwDDZXLMPuw1lDGHriQkJdIY9o3FYxeydhTJPrA6Jt+WXVlO8mzXeoy4Zoc+Va7yVJIcPZswv+0845RHWlAKBZoTdZxD6lTBn4E6FKU89q6eNFFz9bXFRdhhgD628Lru91q7xkVPMWgxnmQB0T0Ft4M7HcmfX9K9f3zZPDxbbLgH2Ja31rxgxi/WJruyqVy10GEIKyjWUL0z4dOhj0sgq8J1wgs=;25:dzsIWrE8FkPasBtW3pRu8jEiH3UvF8TP0blSZG6zTgaGe/LLtE/mVCe0qe/CsbsD1jC4vH8lMQ2BHfX82xSCKo9/VhefggiUDopN8gaHAGMJV72OCI62TnAPVUdbB01JUpspo4Hvz4LhpzxMAgPX2FgMwqdDQr7IBeJU2E934L0jUREirz7B9QgOYM1q21TBkOmKhh7GRpupVvZBY+g9simkSI862HyaJ64Jilt7SW/RICgSlVef5ATzqL5sXs6NZhfibsrmqCGHPmZDaaB3gU+bkn0WgIPpnmxKIAr4J/HujUZUN3D+PGpOMtuoQlcpVHJTdspExeLAgCL5Ja/VQg==;31:fXQsIbDwEiph9TwHz863E/nG5phc06n9QBKWFC+cQnch6YgA4Q3kvJIUDTO+MY+p/bSrOFYWbXXpBk2+kB8tY0h1mA5oSotmQSdzJAZ3NspplXvsZbkWSL6P9PtqaAK/AO4Xgm8khyXUmVHaDcl2Sb8lLsA96kK10FpO40g0Cp2Fe1j4slyiR16Mmu+EC2lHXGgFjI84ZeA5aezI93cE0OeiCxMOFqy28/jSxfwGMa0=
X-MS-TrafficTypeDiagnostic: TU4PR8401MB0864:
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0864;20:Yxf37nQ1xZJEWlLcWHEADRxvpizzmO2gte+bSvxlnNjdB7d3m33UHQz1V953ELO+6BnQMRpEEKQEQzGxSGOhngC07wcbEU92mdbliz6ZZbRa3SEMoj9KVL2MLsRTEZyHQhcXBcaEeD8/vmSqSbyAwBMnfJoIeaI0+4kXXGESGvrz9pBIzwe0e/3ejwxdY3ZfFyGKXcE4elvULUwNeGakCFyzPVqLwUbTxg9rDPAmQq5LX6d8unNeuVhjJNUw2T/tN+ud2KLf5THH5Q8TzqcIHV0yOC1A4wQNJc7Yto9BY7OeVfesvR9x7PMhOGj/edCFOHKZY6uGiZvSjEcq1NDxV+n4NyeqS1fQhxsVJftxwjJx+LoCM3idh+2eSQPZ8nCoGueLLPZ1mXdAa3ygnkMmp8FTTvLRQsTcWxsT0XwVIyUetfnPYSF/1NTm1Vm80oBGvJvF1pdjMDA/3Z9pZd3+PP3f0+Vu7bsRXbqTTvNdURQg74PCysC+E7rDqm8zypWP;4:xXsFKo/4BNu7iFPUdvQSQq0A1KGGZKCf3CDY1H56v1O/8CCfcCMB+a7Vbwk9ZI/LdtVdJkL8K3ElxiJbLOEMdE3cRxqx8GdSns72GP+GiYf5WUqoxkeXi67Xil/hw6ksCLZ0tswpCnQkvuVR0PaybAxLUK8HLxWz78RWpkLVMbWDbavhPo+ihcIohh4DYdol1ytvqAFOt/DrDr28kUC/mCHMPnrHwQB64e4myLJ9gQfx+tkYaECnpUP5y81V0xer8SzoknpgSquUTM14fp5tNVm95E7/Yw+K0Piglf9ZacRIfokI8y9wh/0TkUea4QpF1yiU6S4xqWJrczbYO4hFx7ODZxub0A7WdQYrYADWrEE=
X-Microsoft-Antispam-PRVS: <TU4PR8401MB08644109A8F8F20D295AC0F9E7A30@TU4PR8401MB0864.NAMPRD84.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(227479698468861)(222181515654134);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:TU4PR8401MB0864;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0864;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(386003)(6486002)(86362001)(53546011)(67846002)(97736004)(8676002)(66066001)(6306002)(65956001)(65806001)(47776003)(53936002)(49976009)(54906003)(956004)(2616005)(6246003)(76176011)(11346002)(446003)(64126003)(486005)(3260700006)(25786009)(486005)(476003)(16526019)(26005)(68736007)(58126008)(59450400001)(4326008)(316002)(52116002)(16576012)(31696002)(6916009)(65826007)(966005)(229853002)(81166006)(81156014)(8936002)(305945005)(7736002)(50466002)(23746002)(2906002)(230700001)(106356001)(36756003)(3846002)(6116002)(6666003)(31686004)(5660300001)(478600001)(105586002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0864;H:[134.15.0.111];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;TU4PR8401MB0864;23:+s5ONizAB01S5zeLeCWoKRoI06O+bmFFdPs?=
 =?Windows-1252?Q?kAzornWkcgCQqIDS+C0T/HBQnazqSfxuKjFQ+pQ88lK+iwx4JOJFK6yV?=
 =?Windows-1252?Q?jps+v1B45L4x5AvoONnS2TDh86cYgHd4y3MQ2x2G7M4UEUERfoPtm5DZ?=
 =?Windows-1252?Q?x7EMrif6CJFk2Umy4N2vkDkqrg91uLrp7vX/toTC/BvHOrgFg5SnCZbY?=
 =?Windows-1252?Q?uiKqCMTakQYzqe7Vt3g2dbm5DRbNoEUQ4/PrCU3RhCzMI6byez7PYslG?=
 =?Windows-1252?Q?vC2Jw1bUVsMprtYAI9fzvHVccwTVJXUXeF7wM2yRM6QcSsHwxEoAPY2I?=
 =?Windows-1252?Q?5NrG5+MDNklUG0yj6ECDmKpcczdZRtiVpLHxjfE0yV2ps7jvZ/2GS5a3?=
 =?Windows-1252?Q?chUxP+et8/t6bMHwzrDTd/BriX0vXg7dy5UJbkZT9j5cMVfzZFt6VBat?=
 =?Windows-1252?Q?j149MI6hcjbVVJYO+hNFDZsCwOXPFifvUlwqVgDhy4XxtFygYtRzgxhh?=
 =?Windows-1252?Q?DwM3k1nFBaIFKvghDtW+JsQgbOXHcr4UUslbtkSayLuOSrn1yw3zdffx?=
 =?Windows-1252?Q?XdYbAoSlvUwpaYVNI8qCoe5jYHkgsIKAgOhLeuuxEHV62/BGjsgJYEiI?=
 =?Windows-1252?Q?LXa1rj4sax+84quvpzyJOhTbR8+KtqB7Uje8wU3ctCIAkKD88wyFdBDR?=
 =?Windows-1252?Q?cCmgbsGOsF71VS1vzsqk25r2SJWo8e6FXKHj2iw/w3iMVemmJ3eCiLJy?=
 =?Windows-1252?Q?IgInm++q8hE2IV4MOC5NXs36WD45mtCOtWCCyb5DTuuXeTzBrLBOn9pr?=
 =?Windows-1252?Q?4bWxcAxQWzx+Jfdt+caqEvaTNyo8LKSrIb+XkTSIcH5I5ErCrqdyaYmG?=
 =?Windows-1252?Q?EIS6QoTg8qhwH/ooxEKfkOL2UHTj5MrxD2defTv6DvZbwzT5dOTZLtoE?=
 =?Windows-1252?Q?ulKnMOZOVdoi0kOraC/+1MiU/HqTlrcw8D/K1Tg0Mbd6lIkIkls15ScC?=
 =?Windows-1252?Q?d5NJc5pUQhHevoPkWYhZ/kbXrXbLDYR8cgKr3TS81CYHicJiFGbU0+Sn?=
 =?Windows-1252?Q?UOTywRRxXJpNv7RxLUhm9UsPFOKTdoq9m4pqgYGE4rk4QAflHT8l5UTs?=
 =?Windows-1252?Q?KDD0kwf2BshfKfD6rYTHoBacb3XKWgTjFAhV/Kqb1TxRtruWKGCFZpdP?=
 =?Windows-1252?Q?Mxmme85MRdqENKbXSUKtkAqtiiCiIqleceYs0UPEvB8vY9uExiKGZpjS?=
 =?Windows-1252?Q?w6ainR24cqZmT5Vm47XTlGR15qaBqqrEVCyJhFC2zuwWP56ElOwPiMjn?=
 =?Windows-1252?Q?YieC5mNHUSQ4FKgVxjGST3Tz5hVnDCVkAQe9F7/L1qU/bQKS80r1UM6z?=
 =?Windows-1252?Q?aY2aeG+ReL4YUj4Xa4djESNFhQtneM7LGc3obR56F6RtjJQ6kh8CQk3E?=
 =?Windows-1252?Q?uBsGnJTq31CDzr49MkfizPBpfZcWArcU3gU+HdoY98Y/mlxsQKHHH/60?=
 =?Windows-1252?Q?+nkDiGq4htEZmQ7xH9TDl+W5M1W1dLBIMPx4RPwM/islpL3sND81P/U8?=
 =?Windows-1252?Q?8Iw9+JDUFvAe/Lwk9a4ZtBlMgByT242LzJGOoh6CMKYqfP94a3Xu5aDW?=
 =?Windows-1252?Q?xTO+hWILlgkQ37FZgxEwarqTE0GZGz8nySLEWA5wIidKO?=
X-Microsoft-Antispam-Message-Info: iAptXxL6wDahL+/SkZ04Wc4kiOondFgBb/aHVAfimlq1C7GBJUsiM+jMOcZYDzv1fecdoARSd/iebPXxljrC+OQKrwN60idgrMI80iQS2oqlW2sUUcKKXmLSeQhENH8+rOQDR+wS7jlL5JtSk4uOrBaUcqQCgy2HbHlC2g/Yf8ya51PRLfh+ZBPRF7zYCXDP
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0864;6:xFkr0SgIbDRBPqFQxFFV6hjGegCIhyPxe5ySc7vJxQ/W+EOKLcKTtdoZ3NOE5zTmpnfge4KNri9rat4F9F9q4dZ2j4q7hzlYhHkuPOFzblTpoy0lM0qDiTI2WR0hzSf4WOwitg9LuTJZzlm+8KJAwmOFzZE/kQMEc/K8Lb0t2N/1D6nsmfZmSTR0VzxUZPdsN18VhHZbmj8sEkl28FPLNmexTCks5seJa24wNyQAQ7DlbHf4aNQluqrOYrRnsG16kBJowGNX0YWnanCMdCVf1g91HUoYbdm6s4UlBhfYPSeIedH/ehLfg1XAEuzYO8f+3FXiHMI5SjJLvXq8ojLXq4XzRR3bsj/Jwne5GYCxJcZoIiz+E73tUMYv9WcpN5nP9PzmMH7drKlsmEF09/Qjy1sCC0K8xGgKZRMAPwF9kavWh80zT/ewMZ3zZ8vE9WdBXxC4cCrNd/z5pJS/U+vqag==;5:Df8yh6RVgOISuXsey5uha6vRxwmTTiYwZA8fWCMxK0Wh8ZHxXJqtJul8v6L1GEy3JhNZCBXvl7+ZnYWmcuBX3YETJKYEHRdKqJoC36ShBHwPv0F+/fQ2L/RXCgn/XpjuK49SwyDXIPPax6lMYfEun/dI7Fe/ymjPxmENuRwD89Y=;24:53pO2hGIdc9AnpPZTfDQNE3SVXVeWDroJECnXHfOK/eLCanJ1ssU4DqMNnl5ICwEIURritmyqG/gBpPGatGIjtuOmxmUjnmttnNiMUp4Q4Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0864;7:j1cNk61/Thov3uXdLHSpXkTtc4zMpDX/VEZpR5iNWGTZcJ5nM9IYDIN71O+WL40I0NQ7LR3KPufdVI9HpnKT6zxO5lVBEHHDw/eQH4pDwZMaJyBb9X97IOnWsjJvBrPvBR6wgg/eSoHi+MAq2blR/8UDBsFnidxuC+gsp/ZWHsfUIELYs5ObLcwihbV6O2s2UDRTD9XXgs/Uw129Vtxz7NsCUm656kfdg4nwLR1Uzjrvk63Dpjb1wMr1PYDf0vfV
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 18:29:37.3713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dbd3d7-a813-4e71-ff24-08d594d9dd84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0864
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 11:17 AM, Thomas Gleixner wrote:
> On Wed, 28 Mar 2018, mike.travis@hpe.com wrote:
> 
>> A critical error was found testing the fixed UV4 HUB in that an MMR
>> address was found to be incorrect.  This causes the virtual address
>> space for accessing the MMIOH1 region to be allocated with the
>> incorrect size.
> 
> Even if this is not intended for stable, despite the diff

Yes, I realized I missed 'stable' a moment or two after hitting send.
> 
>> --- linux-4.4.orig/arch/x86/include/asm/uv/uv_mmrs.h
>> +++ linux-4.4/arch/x86/include/asm/uv/uv_mmrs.h
> 
> suggesting that this is against a kernel, which receives respiration
> treatment, it would be appreciated if you could add a Fixes tag next time.

Sorry I didn't know about that.  Here it is:

Commit-ID:  673aa20c55a138621d1340d343cd6b07c1cb4e92
Gitweb: 
https://.kernel.org/tip/673aa20c55a13862git1d1340d343cd6b07c1cb4e92
Author:     Mike Travis <mike.travis@hpe.com>
AuthorDate: Mon, 8 Jan 2018 13:39:59 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Jan 2018 03:58:36 +0100

x86/platform/UV: Update uv_mmrs.h to prepare for UV4A fixes

Regenerate uv_mmrs.h file to accommodate fixes to UV4A MMRs.
> 
> That spares me the time to figure out which commit introduced the wreckage
> and therefore the scope of the fix. Added it myself.

Oh, well the above should be the same as what you found.
> 
> Thanks,
> 
> 	tglx

Thank You!
> 
>> @@ -3833,7 +3833,7 @@ union uvh_rh_gam_mmioh_overlay_config0_m
>>   #define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
>>   #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
>>   #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
>> -#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x483000UL
>> +#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
>>   #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
>>   	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
>>   	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
>>
>> -- 
>>
