Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeERVC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:02:56 -0400
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:40576
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeERVCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:02:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Randy Dunlap <rdunlap@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
 <20180515134603.GD18595@8bytes.org>
 <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
 <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
Date: Fri, 18 May 2018 16:02:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN2PR01CA0065.prod.exchangelabs.com (2603:10b6:800::33) To
 MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1453;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;3:rWV5Spl2h4ky0/KVTy/caTPPi9kzIiACm5K5lWJNaVM6F61dVDy7Df22yEU684geNt5s5K6DVPZ+UYaQ8obo8cwaTND4vmacFpTKJEkStZZx+wW/N/xu31ExXtyESmtUSuL6YgqfMKc70MGBj6/LwG7joO5NV3mfR0lJm7U0cRdlsLumKyjnk6dz+VttXLl0XcNSJW+F23As5sRpDjxxKG/d2miF9XNk06geMOlIbQGy3o4XMXXza/d4GJKwmKPH;25:/rMXkWmoHVg8LEtOFlLFd4ll/lGXNNCSnDPmJV6wSK5MBB8qO1ZYpunj/fkKfZFBkXyKxBn6nd0plPf84IvDrVO2QAkCMaxgPEm/0UrKGuPAdckFuqSfxYJHpuFAjwOOVcPJexmsKoEUe+iegF9k3yKHRqH9o5i50YmLH6Gr5qY4ER9UmsVDRI6/wRwZnOallXUx8Xz5w8fv7tOWyBQm4iC0/DYGt4JgjBobSGAtIVuSsscrkaZPeWiuMXaPhwNY/9y5aKz5ZQ7APzov9xn6h4BM8LIGvLQzcO5B/MpgRPV45sfy3W+WMcnRd+qhqy0GwkZPbRuRYJDCuH7aIevIww==;31:A1mgaXLFT69vyBwkz7JpnoA9ODXyiNlcdi2f8gcoIMON87upx+m7Sq+cZsCgXmVv8FkL6vZLqDexVAV+OI97v1gxmn1IPVvTvRJO2YTbUpTqvOZYV1VkrxwjV21YUDGdUEZln96Q3euZc2rbBHnTK6F5HxMvVoJk//+GXeCE66ReEm1+LFsAFmFkdFo6MfcC46sC2LYxx8XG7jVaQM8b2+bfvt/NIWiZOOpWJrhLV24=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;20:5LCE5Z1HUy5ep6auKcDvWzP6H29xRrG02tfBzntjf+yHWnWlXaH3mLzxWEMFrspgfitmubisPrshSC7P8/EYkCiDyPtMGtMQ6f+qvASV47SXDkncniESPxp3tB6kXe9bgZM7brrsPeIS802okK47ELBI6WJEdIKrtno2nl95P4Wd7vifngsVftu8dS7Y6foJfd04+vMRO0XJ064LORBo3kufK3DxvMlkAgSImJ1fZrYIH+Eax4OvIYhld5yqaJMXjJVuRQp0+L+4AWpu8tIeveLMuF+ek31sMWEMDlHe1EJkeoLQf7MNRhwnco3tUYRSWXLoo1a8DHGNl5WiDlirmQK6IvPLvnW6krYzi5yVV8MV6mzLTt4FXPJSyKH8ROQv059JZXOIPQS/gePzqT9q1jk7ckmBj2iPwFbvbB4XMWONLas6h5Yahp85l5FSAUkS6+POrro+vnt0c13BxHrOhPKbs6CDMFsc7tRIEonTKD6Y8RMwq4tT5RPbtGIn+Umy;4:qwVCrUxfOPqEBOupP8gc89kzmd2WaTFxnI4B+x1dLkH6lwm6Pdb2EvQoVuIo5BinD6IvKqiuDA/jAUBzCA3dO//HG+05qAa6uUVUijqty+xFKYeOpLyZ2RzZ1f+WcxhSzOw5/Zr30J6xZ3QS6dLcFP0Er2EaOU6kSdub47oJ68PJUiN+mW8birBrWtA9k9IUPZYRJImZPhjdHctz84jkgiF7SFE8cWs1E3QC9bKDWIgfUO3U4ou4U2T4G8wRVRs1q5LjjYGDPFzViEDBQj5L5A==
X-Microsoft-Antispam-PRVS: <MWHPR12MB14539BB6C4C8E5F364E15085FD900@MWHPR12MB1453.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1453;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1453;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(199004)(189003)(31686004)(3846002)(11346002)(486006)(23676004)(97736004)(52146003)(386003)(7736002)(76176011)(2906002)(2486003)(2616005)(305945005)(956004)(476003)(6246003)(5660300001)(8676002)(52116002)(81156014)(81166006)(8936002)(53546011)(4326008)(186003)(86362001)(229853002)(77096007)(446003)(6116002)(26005)(47776003)(66066001)(65806001)(65956001)(31696002)(16526019)(65826007)(230700001)(93886005)(25786009)(68736007)(50466002)(110136005)(58126008)(316002)(53936002)(16576012)(6486002)(67846002)(106356001)(105586002)(36756003)(478600001)(64126003)(72206003)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1453;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDUzOzIzOmV6RjlVQk9nS1RieFFJU1QwN1RVWEVISU9t?=
 =?utf-8?B?MXBGSzAwQVVoazFvR3hxeVRydWRtYWhFU0MvYVVvb3habHRXQm90aHIxOUNH?=
 =?utf-8?B?Q1hXS2lJZ1dWSGVDMG9hUHc3aTdlUVFQSWlOWmVhamhFNFNPcUg4UUhENGZ3?=
 =?utf-8?B?VWUrd0gwRjU3T2dHYVQ2Vk9PSHdzUzBjSnFQbCthR0k0b3dzdjhyQmhDQTFQ?=
 =?utf-8?B?d3piYnkvODdSc1RhdWtFcmdtcktzbHQvNlAybmU4MGVuVHIxL3lyOEx1bWQ4?=
 =?utf-8?B?WXQ3eXVzOU5uMUEwV1NEa3E2cnNNZlZpZFdlYU1SR21YL3Nxa3JXWU50Njkz?=
 =?utf-8?B?MFNuTVZTQVFSdVRqNEFNRWxRaUozcHFjNXZpRkM3TG40a25QTVhxa0NwTDg1?=
 =?utf-8?B?dlR5K01sQ01MQys2akZYTzg5TXRNVkxhRm8vNWl5ako1bFkzejl3Rk1QVHcx?=
 =?utf-8?B?bGZtVG9SeFl2WnJpcWJOSXpkeXQwMlRFWC9pNXBsb2ttNjZWb2N6czRzV2JW?=
 =?utf-8?B?NFo2UTNVYVovV3VFckgySTk2ekk4SDRDSWRxdVVYTlBKUHplZVV0Q3BoQnVF?=
 =?utf-8?B?MkpBZzZvTkRPSEtKWEc2M0p6b3g2UjJCUDc2MUo3T0hQSVNjaTEwZUVKcThX?=
 =?utf-8?B?TXJ6WUxCYzJqV01LNm9ndFdxRDNPaThjcDZ3VkIxSjhhb1hST1dJMXB5M1Rv?=
 =?utf-8?B?RXNpZnpva1ZKNVJVQnBlb3krYnhoOHJIRStpdEhQckJEQzFGQ3YrK1liVHBU?=
 =?utf-8?B?V0xOTkRwYXlQRVZ2d3d2MklUOWFiSFdQS2h0bW5vSllaY3VlTnN3am5IZkFB?=
 =?utf-8?B?d3Fxc0UzZS9ONDRjdGxvb1M0akVpUEx5QlkrUDY4cEpKMXpmbmZSUUY0bW14?=
 =?utf-8?B?RTVmUkZCem5MM09rR0EydDgxbmdJNkZrK0EyM2Zmc0FLamcxa1JkT3o3WHpB?=
 =?utf-8?B?WnBCZlpMTDlWbEczRlZwR2dmWkdFYXFjU0lYTkVSVGRmbFhydFVoMWNWM1U3?=
 =?utf-8?B?UktRU3B5OG9Ua0NqeDJhdG1hOWxWVmo1Z2Ivdy93U3UrcFBNMmZkTmYyRmU2?=
 =?utf-8?B?dUVYL0h3bHFGbXBSYUFObE5SS0E3ek4yZVE4NExZQ25kK2VzOVZVczc4WDY3?=
 =?utf-8?B?dTJGN05EZ1F5NlpSREtyZ1hPL1VCN20ya09NQVRrNnNHLzBrUzV5TWd2bnVr?=
 =?utf-8?B?SXJ1cS81bENFQmpnbEdFSUJZWkMzL05iYWw1d09kN0k4Yk1PQ3M0ZTZlaWtn?=
 =?utf-8?B?SGcveTVrdm9NbG5hMGFJOTc4bitnSkl0MVp2SENBSEZYOVMxaHZ6c3pCcGU0?=
 =?utf-8?B?NnllbEl1enViL0FsZTEvZ2VudW1rNlcxTHhlUG93RDNnNzk2a3Y5S3VXd0gx?=
 =?utf-8?B?VUNMWXd1K0Fyd0c0NTRNUnQxT0hGNCtZNlVITWNCOVlUaFBROWpUMFp5QmNM?=
 =?utf-8?B?Z3dQU0xoZk5Lck00bCtOTTNJcGZ2ZGxaRDBVZ0RSaHJ6NFNCU0ZjQ1FFd24w?=
 =?utf-8?B?NHZwci9TMll5MG00emVhdjZ3c1MvU29xQk42S0dpZlU0K2VtdWJCWm1pb0FS?=
 =?utf-8?B?MU5XZ3ZqVU9wN1FXcEU2eUNjZnZCdHFYdGFESHdwU0dHWGxmTUF5WDN2TUFx?=
 =?utf-8?B?MzEvN293eUxFRGlxelNhMUgvZENQU05WbnRDTFZWN0JkU2pTQWFTUHAraUJO?=
 =?utf-8?B?aVdVWk9KUVEzeWplNC9QTVhVeVNqdGhqMDlOc3Bwd1d6djZNTFQvazB3RGVU?=
 =?utf-8?B?OUMwd3h1MGR6QTI2SXI4Yk0wWXQ1WDkvSnUwMjRybkk2dmhjRjhVMjNEelMy?=
 =?utf-8?B?TXlmQXRIaEE3dFBhRVdoNHd6ajhKUGFiYUhjZXdOajVETUdGaGZreXVTTTE4?=
 =?utf-8?B?ZFArTkNzdm5CNjJobnBDSEd2bFlxT1B4UGQrNklsNGhPRGRZYTJDSSt6YXFP?=
 =?utf-8?B?K1pvNjhwVElKZndNWkovdUJ0KzMxUHJqSGtWNU9lbXAyNFJ2bEhaT0tIMlZX?=
 =?utf-8?B?VDNGNkVZUTdCZDdoRnIyK0kvSWN0RXNGcW5mdz09?=
X-Microsoft-Antispam-Message-Info: 8DQAnWs3Vgsuzy8LoDFrge1iBptL5Vw1i1B0BAYQseIbedR3TTDuFkxH4vYviOCojChsXs992H5qBmyKT0+Ofh4cWGUzWstXh2AaLfZ+f6BhkOf+0ruF9bU6xc3/+1YKfWzxn4ZlGnbI9OIOTl9MKIFcYujFvxvsRryL1Qgl/K9+4kpMBKrY1faVCLtCK+Vw
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;6:pMMU+AaGrdUmLqX6qn6QpncnVouC2S+t1Js3VfQXj1Hu59yu8fI9ZeKst2Lealet/rMstKtkJ9f1xcTuKvwdia03858R1FeC34oHRX8AZzvus0jbngcVXxQJYHm0AOiGHzky2h0KoqVXIMdL8qF0idgrFkeTvnOhe56/AUIeA/2g5lSNtHnVmx4Mj50S1yGzP+n5d7jHdtwi9sX6Bvszy+003HH6F+w0MsDOT22iNG33UGjG3hg9b7tbjQubAwL+5/CECP37qFxdVVKuHbyQ+lHFu7gsrLr5/PczcJ2cJY+QIKIOITo/iav7TdIihn8cXmABn4/V8MIF7T6hsPr2M0qNKKjafe74S/0ZdolpFDMEKHvmJt/qHLNaLnk9DC+LM3rVX+9OUd8+UDadzhPYeh/SEyTNEQFWkPtipM4P1MIhSpYnFeQ3CN7ItCW9xGBeBfYr1yH+ZOy89Fqj0wwyfQ==;5:Dba+GufqkKHhppzBilpbBDRpTWtZZjc8/y1TDovT/qu3DtKUTCNCHsRC/yfi2RBcuh9DPt+bSI1LW4bzKEGoLi8jncjVzY617wOboPlDYgux04Ix8inbd2ydvlCJjj7iRKwnFlEMwst4z8yyx6/F19mZQhmtVNPqAC1XGZ2jugQ=;24:9G0b2EqPtLPTOkV1QR23GmSI88CFFoAoGZTF+K0hfvW8rq0F7iTEsIFCn1Sm/WrHoQT3O7LRrPd2CZJZlG8y0jCJXb6tBOz8w5UcpRFPYsQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;7:FKw2gyqMC/2IrrO4jTDNjNHrqqMCqfGg03PVAly7RWkQtGa1OCHCRyP5t03D4O6P/ZsGi/gs6Cl3clw9+7BHh7yY3Ee1VfqwREReIhnWV/x0KW1UhMr6UrwKsxocNeuK/DpDN7+o1T27P4CejfHMohXuZBe2KVlK6XpeBkPF+pG1U2BFNQfira28WWoVajdWUbq8KmyO6lYLUjF3IaJ3XotZ2JN6rrShumf7Hj4Dff6sf6w0f4zvkYryuJrw8uRE;20:UOIZc8kiBdyOBL6XEjUfB3Mxt/5tENcgb+fY0tvhZUO+svMOW0HNjFZ0Nu7bAK/SPyWLw/zacmU4Dx8FZU9JDripCUg9b+VcShh77hKx/7mSsW2z2ITxf2WKamMnR+LQQcO1Te4ZcFMSW31k7yxTHQ04E3v+d/S+9B8E3D9FyQAbUmZ2gBG9pQMsi4LlsoO+hcCr+FPqpyEHlblZuypolneH6ztICysO7iK0UKGmgZ2F+fMle4Lr0Ak8e6GRWa/t
X-MS-Office365-Filtering-Correlation-Id: a9ceaf2c-efb3-45b1-4c1b-08d5bd02b83d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 21:02:51.7496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ceaf2c-efb3-45b1-4c1b-08d5bd02b83d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 11:49 AM, Randy Dunlap wrote:
> On 05/18/2018 08:20 AM, Gary R Hook wrote:
>> On 05/15/2018 08:46 AM, Joerg Roedel wrote:
>>> On Mon, May 14, 2018 at 03:00:50PM -0500, Gary R Hook wrote:
>>>> This was brought up a few weeks ago in, I believe, version 3 of this patch.
>>>> That question was discussed (because that's what I did the first time out),
>>>> and _someone_ _else_ asked about why I didn't just do it the way I've done
>>>> it here.
>>>
>>> You don't have this problem if you put the code in amd_iommu.c in an
>>> IOMMU_DEBUGFS ifdef.
>>
>> Of course. My preference, however, is a separate file to avoid size creep. That's why I've done it this way.
>>
>> To whit: there have been threads discussing the advisability/acceptability of using #ifdefs for debug code. My take-away was to avoid them. Perhaps I misunderstood.
>>
>> So: I don't understand your comment. Is this an observation, or is it an imperative statement? I'd like for a maintainer to clearly indicate what is acceptable, and I'll do it.
>>
>>
> 
> Hi,
> I looked back at Robin Murphy's comments on April 17:
> 
> <quote>
> Well, you could do a makefile-level dependency i.e.:
> 
> ifeq ($(CONFIG_IOMMU_DEBUG), y)
> obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
> obj-$(CONFIG_BLAH_IOMMU) += blah_iommu_debugfs.o
> ...
> endif
> 
> Or alternatively have an intermediate silent Kconfig option:
> 
> config AMD_IOMMU_DEBUG
> 	def_bool y
> 	depends on AMD_IOMMU && IOMMU_DEBUG
> 
> The makefile option is arguably ugly, but does at least scale better ;)
> </quote>
> 
> 
> I think the Kconfig option would have been the correct choice.

"Preferred", perhaps. Neither is incorrect. And really, the 
Makefile/Kconfig choice is somewhat separate from the organization issue.

So I've made the changes for this. Now I'm waiting on Joerg to make a 
decision on the code/file organization. I still prefer a separate file 
for the debug fs code.
