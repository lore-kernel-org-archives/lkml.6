Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeBAFEI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 00:04:08 -0500
Received: from mail-co1nam03on0045.outbound.protection.outlook.com ([104.47.40.45]:2496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeBAFEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 00:04:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return
 type
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jroedel@suse.de
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
 <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <de21de51-1589-edb1-3dd1-b7065eb8fb3c@amd.com>
Date: Thu, 1 Feb 2018 12:03:46 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: CY4PR13CA0044.namprd13.prod.outlook.com (10.173.156.158) To
 CY4PR12MB1734.namprd12.prod.outlook.com (10.175.62.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47ff5bbb-329c-4003-fed8-08d569313608
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1734;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;3:npKrDeGNsTcl+QTmx0skDOJ/VC9Zfp4GX1uImOgGnCOlDd885Q5XBiGR+eESioFvPDsx66FbiLJ/hha5d6f16b8wyPplvFBKDpq+bSKTRCRo8A47pLbOxavEyhq9Z+CXo43Hk7EreZftisO9Oa/IErt5za31jjBUh1jqRwPNgUFH46kjh0+xPstQduQ5f3H15rcKBoRYfqCr7WClCFg6+gT/Vfch/1gvq19TlYwz7hxFINVVPvaKyLFLG9kbRg/P;25:s0qP5MzPWb2martc7mJ9jQ+i9Q5g8OfxxS6g7ffK69zAc2Sn+qqq1IBIBuT/tsUdowYNDWcbk6T0Avu80Cu9PKZouhYT0NAAdfBz8U1z0Tf6VS3RMLUek0hX2kGDN6gTLz6r68h3HwYEWIbpLfpbYJ6zI9t5JV7Mu/ZIK56Fy9zqSEIQ/gp3BGrHmiUE+VYYUdgSA+53zV9UziEbpfm2OO8IBhKyvaqt1yTWbKXMUH6/bwlWTf+J9wBtlnwbWZtWgquSfTNI2HLziI6MawoPWY7J5sV2kUbrHpIJHEJIJQLe2em0xxIxYt87Wnm4VUJFsvE24bhYw3WDSMF1Rrspqw==;31:56LjRH1PlYHIZXesu4XcXSQdbo/g2SJAt2IRw5fq2FXuBKpTQJtTUD+WJzMnFAIJHabIz4JCPjjZQH4Cd7lfc6BsVgSYuhgCtYMpnrkkAxj1mtKGHqniX5Ps5HrGNi4e8aAxQhAEJ4tCZpkO5eatyT6B+MvQ8zYIsx4rvTeXw2REO/fsYocV5fnyd+rPwTfzVgLQfSCVIFO8lI8bG+CHG2Lx1qWWzdEJS167xg7fu64=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1734:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;20:KeFU38i8Bf5xxQxomLA1TZiTL+VoQAFygI2/1S5nUbNmAO1ZVppNHklrXIuCC1ThNmCwuyI6P3DKkIXdR4NPuESFoSLBu4SFTjyG+n0uv1XACIejl+XvfGpLMCg+eJR3abg+qNT6s/9709pw4Z2s91+DY/Idnp8zCvWQ//LTdx2Ic9fpG7wgk+dgDMY0hUz/R8DSnTXkza33ituU0e8c4++zhn9K+l+A31QP6/9CEU04kGoNnj02LUBIie0I2S+Tm4/XhCVribT7Aozvn/Q654FaXUq6cKkpa4BignLlFkOIp8PrPYeOvYz+t4s1JU6ni+1mKteYg0jU4A51dVM3H4rMMFygATDZQeNuXZ7kVkWqU8N/FnQ49Wsij+gp4HzHVh1FttdpHbzOGO0F8Ybsdt/9SOvuohBEQeb0kkHhk62FY9aaPnWpKONZ1Mx1tRjPZldqIRsODKULa6ptN/6KZDA9lGUpi5KkOkAVLnx5kC/sNuv9N+dlVZKME/LoF4Z1;4:DqmxOrRmgLS5sVRh+R/YwpB3Q/T4NePOZhJtkhu0BQgILtcUvfMCqDA//uuCG5R8URWvmvBl9i0FUWKXzSZFId3BL0mNkj3Phsrhg0Tx9V34eEWKNO3d+lEF6sF/Tpo1cYHS3AXEnwU7md34e4+cligQk8/o815NfFSF6WC0+MsuRJlc/k60tcuq6Ane+5QOQWa16kbcik98aGDpPYTu3Z8Q0rIw8kG90ya3pgKwmxnTv+hP5aOO/iL1NNP/NSVzq40SOWuruzcV7GlnP30Lhlq46xY/Ufj/j15C2sy73Q0+GH/ANcex9pE/oBQVP38A
X-Microsoft-Antispam-PRVS: <CY4PR12MB17349D1AEBB440089E10BC84F3FA0@CY4PR12MB1734.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1734;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1734;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(26005)(316002)(2870700001)(6246003)(386003)(6506007)(2906002)(186003)(305945005)(50466002)(105586002)(31696002)(6116002)(86362001)(4326008)(3846002)(25786009)(67846002)(2486003)(64126003)(36756003)(5660300001)(229853002)(76176011)(53936002)(6512007)(52146003)(72206003)(68736007)(97736004)(7736002)(16526019)(66066001)(65956001)(65806001)(6666003)(53546011)(23676004)(2950100002)(58126008)(478600001)(81156014)(106356001)(83506002)(8676002)(81166006)(6486002)(31686004)(8936002)(47776003)(52116002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1734;H:Suravees-MacBook-Pro-15.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzM0OzIzOklMWVQxbTZKbmFoVWZNdktWZHpUMFA4a09P?=
 =?utf-8?B?REYxOExlKytCeGNZUEE1T0lRMXppejIwdnVvenYzWnRsOU04aFBIU0FaNHdX?=
 =?utf-8?B?dmRxQmYyRnd0MC9OY05iM3hnUlBIVlBZUHkwTEF0QkM4TnlWRVpjSFdVelJW?=
 =?utf-8?B?ZzR6TTZ1eFRuVjhRR01BblI4WnYrY3hVUXFzRDdSaFJPWGFwdTMxUitPWWpi?=
 =?utf-8?B?Q0tiekxxNUNhbUc0WlhxeThPVENhZTVXVjViQWIzZVZuRnJ4bHYwdXpPWFR5?=
 =?utf-8?B?MXBSK2RsV0phbXk4NDVaYm5pRXJ4czN0bjRudVZodStLZVVkN3M5NU9ZbXM2?=
 =?utf-8?B?U0FjZHhvQ3BZM2lVUE8wUmlZcTFiQ29tSnlBczJJeDRBTC9aZFB1YVN1Z1FZ?=
 =?utf-8?B?bFMrcUVNdGZiSTJzYUhraElHUDl3aWlmYXdsdDdwUTUzY0h2dGNBcWV2ZlpI?=
 =?utf-8?B?RFRzRVNFN1lvQTVtRGlpQU95b01JVzc0TFd3MTVBNVVHMEdnVVBOQnRSZHdP?=
 =?utf-8?B?am1KREg1N05QZGduMlJVVWZiemdRYlh6eFc0M1JDTi9iZGVwaitGTmpZQVpB?=
 =?utf-8?B?eTM0WTdPTHgzWDNuUURRVjJuV0krSnhxTXdXU0I1K3VtaTg1VGx0TTE1dmlY?=
 =?utf-8?B?TTVFU3A2T1ZYTDFXZ09aQUJPdENXb0FmSVNiNkRsOXV0RzJiZ1pIWmFoWXBF?=
 =?utf-8?B?SWxkUWNIQy9xSGdJdm9yNUNJNGExZjBzZ2ZQTDRGc2IxTk1qMzNySTNyOGc2?=
 =?utf-8?B?aXJUZHhtYXhEd2JYY2ppOVBWZ0hpYzlwdWRoNVIyUEVyUUR5T2o3TDJQTnVl?=
 =?utf-8?B?TmNLRW5rTjBxdWpVWXRKdHFiMmIzL3NJTlUzTExVTElaTjRHVmkvR0ZiTDdx?=
 =?utf-8?B?cmdIZUQ0cHhxYVhrMi9FQTBTeEY4OVRPVzdaaEl0eFJhR28yYmlCMi9QRzhx?=
 =?utf-8?B?ajRHT01TcW5JSk0wbEhESUMxZzh3bW84WHhoVzV0TlN2SzVuYzFtbTBGTGdO?=
 =?utf-8?B?dWV4Rm0vbVEwNTZMUnNsVjlpZ25yZFEzbHRQNVJGZHFIYnZPZGpkbmwzbnlE?=
 =?utf-8?B?Mk1HM0pBWHFrU1U0ZEhGbUE2Umw3QUFWQzBwK04ySk0vT1FLQ3ZONC8yNXcx?=
 =?utf-8?B?N3BvQjAwUjNRTzRCYkxkZzY0RzhzZndvbFBnQTQ1c0tIbS9yOTVQQzVjYy9N?=
 =?utf-8?B?akN2WS8xRmtkUmI2WWNxZ2c5aTRUeDBXT1B6TDNsNHpJNlVBVEpRNUVIeE9q?=
 =?utf-8?B?YjkyT2tVQjZwa2hNTFNNd1N6Rll3WjJLZlRBdVBmUGxtRUgrT0xLMmZVellL?=
 =?utf-8?B?OG8vZHpJQXBhc0RkU1l2dVVSU1ROYk43a0tlUW9BMXJQN3hZNXlzcG9hRVlW?=
 =?utf-8?B?dXZqTTlWUTdlV2t3MVIwUURKck1QWm1YaG9VMlJUNGpQR3V6STdtVnRpNExa?=
 =?utf-8?B?UVUwVGxKNWFpZDQ3RHRvSnJhR2swNERHdE1RZDloby9WSmJyd010RDczMHk4?=
 =?utf-8?B?R2hDMnpackhkQXRwZXZUVjl5MmQ2RW1DNnNrSFVOZFNlcUNocCsvTzcvc3NR?=
 =?utf-8?B?OWhSQk5ra1FCZkk2Sk9qcnFtWmFUc1E1SHVOTnZ1WlhJZXA5NGI0N1l4TkJB?=
 =?utf-8?B?cDdISzBZVEw5bzR2NkJBWkg3YVZ0NHU0OXBwTlBXYU01b3NXSFlhR1EwdEk3?=
 =?utf-8?B?RnVEWm5qRDZuVVJpdFljNzBUbndSQ3RIaGZ1VVJCNUN6eUp2TXJiQ3VTUGFu?=
 =?utf-8?B?bUxHL2ZnWWx3dUkzemgxNEVrVCtPWnpaa3pWYXVrRFl3ZXRBTFhBWER4eUZt?=
 =?utf-8?B?TjJSdXNuUlQyUk0rRVBURjBQWDFBL1VYYkh1YVdISzVTZXc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;6:fniDMlz4FqzdnBZGXnYkweOD5saq2jeV4Zb6CA9djBhqX2pgTrN8fsRn3vGO5AyEPjnO95kH+yWoamnMD910QVfOCGJFC+L85zw6LKm4ynF+igP30vopPubLhya0V9L6gNTQxByXxL4EogeyxDVN2z2KsB8iINTPXv/pXtDccQGOfniXOXtMlJvXMDp+eDLpNa26PkXCMRzoyb6yHY7AxFCJyRXVJrpJNv+gwjcZYuqEjFmU4zcyVU4zWUAMwx9d9sDz84TAXD9wNWqWqyw64uDx5mTDXpJyAg6xrDnP5u1rq1qCdIMA1y+7y9e9BWbHv5BS3YymSSxeypZIsEkYJCSROkiYFB/HR0k0NKmmBo8=;5:a8EVRPm8sUJTBvuR1Ukc5JYwBh9MfhjTbHsMePLSFP+rbkYN7c/xZnN/DUAux/d0pmTsvWAqHaPTejb8tRbX0wNNFgEDcww36eb+GcO9rE5Std7zP3x+8lMiaLAUqRXmaFm2rd9NBFHPWy4CtumnL7Wti6Nvapi20Rnxn4661b8=;24:RqbfOZHjVYF6mDXgdFWz6JBMy38GBkQfICXFbPolK/J1jNcmf5DNbzpmbSmP5hdnhVR50b5m/pD2ceNBRjsT2EO1aXFpP1P2ZvHm9/iDh0M=;7:Ge76vydM4KFWqabmCpRYy6KX+IW+MokggKHy6FcGMgt2cueu6FlfO4vlUU01l2qUTkDdN7eHzGZW3/FW1W74rxC7omMy6J8LDxk14k/7TUMl/es72P5zIvhJkuovFuu8Ev9/EFv6WPpzhJe9my7JLiPJVuOu7FCUTFR+RvmNQhCq0Yl3wGOfY0FfHrbld7+15xPwGP3xDZHzF9H9fIDmxfODqGfjjcQX+dl4dg7X8np1K52r4eH8tNXv/xvnRMwP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;20:t1DEk9tEsxaS5kxj+jj82dZH+OnBBvlptuo5p4B4XFcDZptqd4/pDbR4YlKxeTZYwe+EP+7BQU6j7l4KtVOY7A6c+YFNnJHONOO9aQ9cBiMckE45d6PzKHbcKIGYDDYST1KwtC12A3DNlil8ZfQIY1dJ0QxyhoGkqdzBokeEftKJCIALFruw9BqskrcyOwz6IKx4YVMtgbqc8Uw6k3SKLPdJAgCi5VL50tao/IZvj5q2i3QBgRs9B9JTJmGoHkah
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 05:04:00.2728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ff5bbb-329c-4003-fed8-08d569313608
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2/1/18 1:02 AM, Robin Murphy wrote:
> Hi Suravee,
> 
> On 31/01/18 01:48, Suravee Suthikulpanit wrote:
>> Currently, iommu_unmap and iommu_unmap_fast return unmapped
>> pages with size_t.  However, the actual value returned could
>> be error codes (< 0), which can be misinterpreted as large
>> number of unmapped pages. Therefore, change the return type to ssize_t.
>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd_iommu.c   |  6 +++---
>>   drivers/iommu/intel-iommu.c |  4 ++--
> 
> Er, there are a few more drivers than that implementing iommu_ops ;)

Ahh right.
> 
> It seems like it might be more sensible to fix the single instance of a driver returning -EINVAL (which appears to be a "should never happen if used correctly" kinda thing anyway) and leave the API-internal callback prototype as-is. I do agree the inconsistency of iommu_unmap() itself wants sorting, though (particularly the !IOMMU_API stubs which are wrong either way).
> 
> Robin.

Make sense. I'll leave the API alone, and change the code to not returning error then.
There are a few places to fix.

Thanks,
Suravee
