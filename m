Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966878AbeBNE5v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:57:51 -0500
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:65504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966813AbeBNE5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:57:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
 <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
Date: Tue, 13 Feb 2018 22:57:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:404:13f::29) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efea679d-4aed-45ef-f147-08d573677d6e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:yg+Ow2U2LBI0iP2ib0kUJGxg7PM3OgaXtjwbKI7SQm8H5sgvhrsY9UzQivoHbqQweabVgKo5DKZkjNPNY/CXfQ4wYtTQGu4MBGCezvIZUYcaDA+AsAMmk5QsvH5b/DDVFPOFp4+fYGDX5y0fNHmDjRMAp9cq1z9UaX2jXDNjhNuJKOm+NX1DOaoSlhRwRinC4oBmrkNK2s04au+H7bqmf+dOwnpSZQtUPsiegqPKtjJ9vkckUVBnUb7x2Uvxax1a;25:W3owz6Sa+lriLg1FBCrg3cf1SEyC2dM1w8OMJ8y1QdQXl4hUu56OuS6wukx8E+iTYNIM7j74okrVdNyRxqa6LptGCpMaFgjLSOriSQRQU7ezj/m5zmL0eAaB20QDD9LjRoQ5yHxsZOKqlzwLDsLFwzeV3vqXA5xxOAHoaCeJ1W1BiA16drfNanZtHDvjaSAx62Sg/hNyVMgx5ICVwdEk+Vm7/lC9hjvpWJY5kwp/paTnzTa4Ri2XpDYiT18SqL3mPsYTOWHW3IQaTvNOQdvB+MgIz4LcCOceDIz6sL/IcRTQgINsUlSwxp8Jva6Mmu34FMbzYM1/WN0WkVFd7Z0ytg==;31:gPvUE/kosuoP2zUX9wxwzJjff7lpDjxc63hBOwiQupu6h1iXhsV74deq11OT23sIhnFYp4nBWXTm75Ys4LrXhVPP42O2nCOdJOccC0sa4ZqzwoKZa541H6pVZbVJ9Qfk7Hf2o0T1zum8rOuzc9z6rPUQ0vmI0P6QLMZOBHGU6pXhO2sztAN9+P6rmUY6P/sN3mOE2CpW69PmQCSXYkzrDKG6rbL4uyfBzw9jf0cw6Gw=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:BksPQ4zI7PWX6hEeMJmzLTGeD4TQBzvuXTP0X7KsMY5YggCKuJXdF2w0qvkZ/MvbZ9jsv2bQ2rrmv+JjCVO+NQeGXEZ4/Lmx+ohIrjGZTU7qKafEcJfqp1/pQUrXF4k18o4S0smGxRgbXHbUtoonRNmV3RpzmxjdC8nvDzxD9fw1b4p1NiKUel3YKmvAnADF9bBSHoKdzLu944KrosYRClhu3YDcSQHtWWC+3JhJc7syEykiTmnOJX1jObiaE/nCjVFRNcEjhhW/ay2CVJkjfCOlJ6iyWL80Lk4oCInxnHBuwZoL5dkrfxGiLsGO9W+u/fuFN+8AQjxbRHSwxZb/Hv+TxIZ8Cf/hS+V+Z/z41Bn+DBCR865Fhshg2Bf631VAh+URlXVJTHFRzcqtFdd84alH3jBN3E78Rx2t1CzwLALyreJXiX3b/jZb6BrvB1Lc9uVhTad7ZKxYZXHXHwMtbq2zCvyH8JzcX60JzK57bZlSHdcRUcDnaJXz9idCTJy8;4:qdIYp3CFFCZdAevZvlvmijKYpQED6pZn/gLpDQtCfIvj2Ef2P7eI5L+QEOnWeqbEVgCtY8m1JTay9NBi0MFI2wuSwbOIiAqJYVJventa15EeiZc3i9lPPoJKDq+fT+8ljl2ql0pNq6yDg7iSBwVCdf1/22irHIX74wFXXYj2HX3rkXZ4VIGL3CSWAgCAwRuI8J6F+gTL4aFkU3HxPlXZCH9Q9pRZlCnL4RtsCziAxwnFXvk2+qa3XuB4rH3gNYx16Tc9V9dKnuYihoveky9ZHg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141A017E1C8D7B82C9FA4D6ECF50@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(189003)(199004)(966005)(16526019)(31686004)(76176011)(53546011)(230700001)(386003)(186003)(6486002)(72206003)(106356001)(3260700006)(105586002)(4326008)(25786009)(86362001)(77096007)(478600001)(305945005)(26005)(2486003)(7736002)(31696002)(6116002)(3846002)(23676004)(316002)(54906003)(6916009)(81166006)(50466002)(16576012)(81156014)(8676002)(6306002)(47776003)(97736004)(229853002)(64126003)(52146003)(52116002)(66066001)(65956001)(65806001)(68736007)(8936002)(6666003)(2950100002)(6246003)(5660300001)(58126008)(36756003)(83506002)(2906002)(53936002)(65826007)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOnFicHI5RUpzd20rc3pkbHFkVjlDeGI5WkxT?=
 =?utf-8?B?YlFveVM1Tm5YMzhLRjV5bnRKUmRkMUJCN0lXZWJVM0lFUTFXRlZOTnRqSjl1?=
 =?utf-8?B?aHA3V2c4dW0yZ1hqamJpL2Rld0JBdmt5T2JhdVdwcDhPWGgzb3RyUUpDaXBt?=
 =?utf-8?B?ekxvWTVsSU9PckdaYzJTUkdhSDRjUmxEVFVUdHBHSVZkaUJ4dVJvcjRRVFJr?=
 =?utf-8?B?YXQwNkNYU0ZQaUdONlpLUlNObTBIcU1UVUM1WWxnZi9kWnZBVkxkZ1VxNCtx?=
 =?utf-8?B?ZEZwMG9KZEI3VVdnbDhsdzB0eDJyWmVxUktFWTlyMW5tNUtQTzFEd1Z1bDBU?=
 =?utf-8?B?SmNXazVkT0Y3ZjdSSkZ6NDRGdnUzdHZmOW9CWk95VTRmb3g3dkd3ZmNtNWZI?=
 =?utf-8?B?M1RVVlMzdHYzc215eTdPc1B0T0wzelRCNzhQMUs0UzRwSkl0V0JTOVEvUTVM?=
 =?utf-8?B?TlprNVkyQTUwUC9ET1ZnS2IraEZzSmhLdUNWUnpRWTM3V2tnNmxXQlgxU3By?=
 =?utf-8?B?bklFc3l4czY1dHF0S1N3ZkpVYnBESC9ZODN0aDNUVmxoUVowOXdHdkdydER5?=
 =?utf-8?B?YzI5MTJaQXZ2UXV4ckNnS0l5YVIvYm9idkYrQ2cyU3EvRUtZYXFGWDg2Vk4z?=
 =?utf-8?B?eVVKVFZhRWVrL1Brd2ZRSkJ3dmNXVFlGTlozTGp2V09pcXNaTkQvQjk5ZTlu?=
 =?utf-8?B?eTlwOVFKVEFLajlnajJrSk1aTncrdEkreFFRT2YvZ3FkMDh4YlEzMGJjd2Y0?=
 =?utf-8?B?YVBacm1nSndNMXhuZGdEZFdpTDNyR0RWWXI4S2lZbEFzWXZwdnd6TzRZQjRl?=
 =?utf-8?B?OVVBUCttcGp0RU5URndYMlV3ZG5IT2k2UkF0Mk44aFJMalkwckxSa21lU2U4?=
 =?utf-8?B?a2haenl3OWNGeWJJWWhuRWxNTEFCV1Fpc2hWaXRZNVZiUFY4Q3N4eTNQSDhY?=
 =?utf-8?B?Q1lWMS8wWU9YS1djTCtaeHIwWnR5L01aaUdTVEdQcm5OZ2dGbkNadjZCZ1dP?=
 =?utf-8?B?eEVNenNjODJzTUpDOFNlb1ZFN0hZVmV2RGZwcTZlSkt4bHAwZ3lMT2ViRlRm?=
 =?utf-8?B?SlJIL2NldlVmUzNsOTJsQ0RFU2tVSTY0RXdRME04VjF1TnpteTNVeEk5WG96?=
 =?utf-8?B?enVaT29abFV4N3NzcVZ5YzVYNjF1eHZ4aURjcTVVeEVKT0xwUnFwSVBkWUdW?=
 =?utf-8?B?OFVyT0NPNWJpRkJuN0hYelY1T2xDcU5DQUFtSWxyMit2bHdhQTdMRlpXZ0I3?=
 =?utf-8?B?YXlBSEpqaHd2UzlLTmhHc21laW9mUERVcjhzbHkvZHg2M2E5eEdWb0tJTHF6?=
 =?utf-8?B?MzBmbUlPZENIa0luN1N3eEZQUXRISVJpaEJXK0x4VFlqVFU0eVJGUlNuOTNI?=
 =?utf-8?B?c2R1U2cwUVlQZUE4enlPOEloa2tNMndXTTh0Zmg3bCt4VmkvN1k2Tnpma1RF?=
 =?utf-8?B?YWRPMG8xWXJIR1Y0emNDWlBuMytMZjhkc1VWNFoybDN0U21DenUzRkxKMitI?=
 =?utf-8?B?bEFBcCtyT2wxbGVFQ1pNMFh2dEtrZTRWMm5peE1YWGlBTmZzSHpNcFBQMG50?=
 =?utf-8?B?NVZ4WG9kVGFDd1VhVUhrK1JzeE1yMFFEaElGQ1hlS1VDY2J4NWUrN2E0YmNl?=
 =?utf-8?B?YUZVWDVzZFVaUDQ4WUlmT2IyMDhxUEFvVUdyajdMc0x4TFNMVTZlaTRsZEtG?=
 =?utf-8?B?ZXRoM09mRVc0OUtiWU8yckZablNPYXFDaFhZV2ZGQWhNd3cvS0Z5OHJUUzY3?=
 =?utf-8?B?N1loUGJSM3NTbjRqdGhTUjZLR2pENXNTRTZaWDZkVnJaRmhsK0p4b2RWNWtq?=
 =?utf-8?B?VVVnbE5jb0ZORVVNblJHNU15RU1iOHpCSmxJa0ZKTE5zKy9KdGF5emY5c2V2?=
 =?utf-8?B?S2hrbzBVTGc4bVR1TUtrN0dkbHNaVkRxWStROWhGTW9iWlp0S3ZiajRlY0Ev?=
 =?utf-8?B?Ly85ZXlJSmNhaHZMZVhiaDdpNy9tMFRlQ0JpZG1hVjAzQWsxSEthNTM2WDN4?=
 =?utf-8?B?ZUFHYTBXOVY3M2ovZGlxeC8wOHF5cHFGWkd0QT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:4Ur24F62XlMKxctWsU7F3OEoRuMV17ZaksPJ1mnkSJuzvvvyzuYXMtjWOvSn89pjjLVz6GSR742Vl2OIkGYx1Aomze553tMpUAfbkQeVS6yATng6vvandKN8JVvFKdzvqysi0FBIWn/UOjE/WYRlMlWIi9qYXwg+oOJxef9TwwwKJCVGiRcXG1qaA9X/tpoFZW3HLS2FQqmVwxxpcZID0VQAScrECv3jTL4VuJuyP+LG//joJ6jUkPGvRDr07ksf0iBbQKnMkQ8njLAdFxe4AisaM4HnPdazh1/KnWBQF5RYke1l3qmjHTTexdl+Ey/0juHzWdHq/40E1x/LjY/CPiDWGUjxbqUD7kxf1IQ4NLM=;5:QpBbMSZkuAEG3Onf2toEUOZ+3TT5e3J0cozPHH2RPSdbM+DpCgk+1o6zjVHCciogXnem0opOSYed/8pVXC3DIQsx/K+5gXVs7kSiBHltZ/KHQzqay47yjBRWVNNf9d4eGQkYQ6hmrQU8rebbyxtqkz3vtvfrf8x1+yC071pCh8o=;24:gGTGa1fDFks/YyuNiGlkE+JvGRSTOn9typveUubRgFvp1CdaEuji5OIm0OGLz+z8eXiryFVdZebaVMFd/FK0FGcMFrQF/skGn033KGe7Qww=;7:qedx93+S1nsE13DasuxjcZjdUYvq29h0BM87pUGdy2xq+KKLeumhKpDCC5DrOfiUz8I1GPWC5kvUKv/PLi2KpLzWzACE1n5fnFwltdPblaiCEDCwzjPdH6QbvCAEc6SmDCBNu41SOtNm9y6i5NJHYBuhAdsxHqjlScVbPzN8U1jFoi1LCNNsn2Un8/CkwZQFILHwgEtwsvWPaqul94rDf0iX5bvyJ1objfvBV4M2Pd7QgVJ/2m/Xx6cAZCkLo8ma
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:eyvTuINhwamAdsUJ+Kb0ehMx77zMjUxx3+Rpz6wxfeACzZoXtOupkWjfRWjGKVfO6Y+qkXGBccdke+DT6k20gEHzx335CvwQg0FpfZb2caJDtMostZ7J+BXwSuEMRDvwUHjDotadgEskiLh2igcoT1V/7KpU1E7XE6bkNMANhrkkSMqj4VXdtzcXAAEpIsbPIxFN4Y5RQOtnTzoCMLfT3fwaU7YRxF8e0gHBP2m8NHBCp4Vr8ySymPBHztrh/m8G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 04:57:45.4947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efea679d-4aed-45ef-f147-08d573677d6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
> On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
>> On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
>>> AMD SME claims one bit from physical address to indicate whether the
>>> page is encrypted or not. To achieve that we clear out the bit from
>>> __PHYSICAL_MASK.
>>
>> I was actually working on a suggestion by Linus to use one of the software
>> page table bits to indicate encryption and translate that to the hardware
>> bit when writing the actual page table entry.  With that, __PHYSICAL_MASK
>> would go back to its original definition.
> 
> But you would need to mask it on reading of pfn from page table entry,
> right? I expect it to have more overhead than this one.

When reading back an entry it would translate the hardware bit position
back to the software bit position.  The suggestion for changing it was
to make _PAGE_ENC a constant and not tied to the sme_me_mask.

See https://marc.info/?l=linux-kernel&m=151017622615894&w=2

> 
> And software bits are valuable. Do we still have a spare one for this?

I was looking at possibly using bit 57 (_PAGE_BIT_SOFTW5).

Thanks,
Tom

> 
