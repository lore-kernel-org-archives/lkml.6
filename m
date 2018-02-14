Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030861AbeBNOaP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:30:15 -0500
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:32031
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030836AbeBNOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:30:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
To: Kai Huang <kai.huang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
 <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
 <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
 <1518593420.13066.11.camel@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <ea032035-e526-378e-3184-ff037e03940d@amd.com>
Date: Wed, 14 Feb 2018 08:30:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518593420.13066.11.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:404:65::13) To CY4PR12MB1144.namprd12.prod.outlook.com
 (2603:10b6:903:38::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b969718-db2f-4cbf-a856-08d573b772df
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1144;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;3:09tCbsd9OxLtRs2ywzvalShRoP3/G1yfrnvuIHUz4dOFezRra7JiuEhwK6J2y77wOb+EjkcGBrxveNqbfxA8J+rSXrdVFa5TnKDQ0PFOnHZoNsgyQ9U3tRuY0e6xW+96FJmW6WsR5aMQNFj3AaJQaVMU7g5kvqNHmRyQpvm6riRPLi5uG2Z7W4/Xvp70xNXRxqwgNaz5WUcuIwMpyBOAsBWm3kOtAJiuXr6nmsAZJt5uBol88g8SeXCAKbBOoLvm;25:YzNakMv/2Hrnr0QyLotBzQpNBWJLOKf/0en7JQk2cbUUKF7RLuxhuJSkchARtxjyRmaMaJ6T08DRATQrwwNLxBaMdZXRJcaZbDmWlCllg1tMcm330/ToMS1nfmSmUzT5io/vUniiCICVoMQJ5yH5W6ODO2PlN1QD9ABVtRIBZTzavyBzo2n0Ie7qermpRBdj41lG0Qpzx09+t0tjhYF7bk5CYN/S/WBpyc0y8waZS8I58nRb4i0/3ANZ6wUFfG1e5QjaDue2Z7/7P5b82DMhc4YWvP3n6E2SwaItj6Sm5YESac7Cny3O6Lhw0ELvwXFC7h5fHWu9iNW2RLlR6hk58w==;31:2uyHu5zxWiIXt8OpDpu/HalOUcDWWCNVwITjlg4BA0pmY6xJS8sd3D5IYiMaY3M4HnFqemAA5HUx/8JM9IWSRIw23dSQv3oIwDShVpOL7E4FCrUU0p2t87tHOK4flolSYKH+DmSq6ivEyloR9gwvoC2w874/sOJrqqffWNIHCvHeQmDJoe0dn/8k//w6XA7DOOjoddtEZ38IL+Ijyl9EDsahefvjL/ayp6AQLN7gWRg=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:nBnxjbBVmbvlePMs6B8eA6+oymTJvb4QFgiogpQEqTeX0SUrhsp5ylot70/6lFjZMTB/Tt9AVzM04E6mAKQA2z/sZtR8jxeX8u/kS8uSN0WYbwY7LaOrmp/8opLiI9ID+dNb7LwE49Uh5G7Q8U9NAhCSBs9mNBEgkvPt9O7JGvQ18Npm8uS2e1Da5yx5WgGCFatfriXHmNWXd8VOh3FJJ8XDqmYO90qE50CxcCPXSdfn0yvo5rqu1uoKq2NYSdUm6b9/bcIR4PF+eA5eoeeAuS7IeO0Els3GIgFz9ZBzxpeHk+WWy+busrRLv+hHxh3nVwEKZtDWbtQVqCtLUCiQ6mwnA+TCbFdIVo5Ki/8qfRWpqAfnMRl4vyMsGMUWJfptkOofCtFPXE0wvrDF8+b2gUkEj5jsN7pUK1IjOM3l6CxJ7KWvr4Br6YnBwBfwNuD0jZr4FyuBg2MGmHGLPo0fU4ohkTGlR4VBYCwcJrxJnxXVQnSmS51jMAVqYw3sAcL5;4:k5fCRUvzNc6JOeuK0j5EPEq6g4QQKKb5eDkKqZcpqv/7PVJvGGc3Dlh5tWDpbP17aTkOL115BarMTckG85Hww+OmR3M1gMyNmg7O1FBQrDS8IAvgkWzLhVaAoJlPNlvbBlqEWN42hZAL7E0ISRWDAXui/C55g+0EYe4HUtzT2u2OzHleA76FVZ1mI7YrA92842pmZOVJaXcMaOCaW/GIPPFwNpzrjp5q8p/lVcp6dNxNEDKGX2L+FoROpT2ZH1yMlcBopD3a25+5AfJKVg9cMg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1144A756F56112A0B384F8C3ECF50@CY4PR12MB1144.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1144;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1144;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(346002)(376002)(366004)(39860400002)(189003)(377424004)(199004)(6666003)(72206003)(26005)(83506002)(105586002)(93886005)(53936002)(16576012)(77096007)(68736007)(23676004)(31696002)(106356001)(16526019)(186003)(229853002)(316002)(66066001)(65806001)(53546011)(47776003)(386003)(54906003)(65956001)(6246003)(76176011)(6116002)(6306002)(5660300001)(52116002)(2486003)(52146003)(3846002)(305945005)(81166006)(64126003)(478600001)(7736002)(65826007)(6486002)(230700001)(86362001)(2906002)(966005)(4326008)(50466002)(97736004)(3260700006)(81156014)(8676002)(58126008)(8936002)(25786009)(31686004)(110136005)(36756003)(2950100002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1144;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQ0OzIzOmZuQWdOZGlaOHRSY1J3Vm1OL3I4amhObGFT?=
 =?utf-8?B?UUpsNTRzYnd1Zlc1bjlWRncybjZhNGhTV01YNFZod1h3eWdCNEtkQ2hJZVE2?=
 =?utf-8?B?cVE4Q3JqQlRJNk5wT09zMTd6VzlQbmVaZXd2aER3N1NNOHVaYlFMWE53L3lm?=
 =?utf-8?B?RFBhQjE5b0QyWjVjb0FUSS9OdXlGRXRITThyRW4vdlFmdDhZaXRNaHIyU2tw?=
 =?utf-8?B?MHl3VTlxR3h3YXAvbndUeWR2MlUyY1BmQ2NRS29kaWl0ZW0yM1NyUUl1WFh0?=
 =?utf-8?B?Z0tZS0daWVc2YzZtSE1yRU93aTRMZE9TMCt1MXpkWnIrT0xub1cwRldFS1o1?=
 =?utf-8?B?UkdnaXFWdXZnOHJob0FvRHY0V0RCUHoxQ3BGVFVvWDdGYmhEMzhCNHZycjJx?=
 =?utf-8?B?eGREdEcrd1BWZERESDUzY3J5NE0xdUh1MWZyNWtxd0FXMEJrdnlBSlROYzdj?=
 =?utf-8?B?VVF0M0pnZmZVZ0lwbTZnNTlPdUkvYXpoVTBXcWF1djNFaTNnbFFZWmlCVUZY?=
 =?utf-8?B?UElhM0FKYVRNZHRHNzl2aTlpNDhIWWNHRlJMUHBzVWcrK1ZIcGtrbm1HekhV?=
 =?utf-8?B?Ly9BbkQ4bkt1UUF0L3NodUsraXNMWFZwREY1aUlrcnZxL0JMTWRxSzBhMmRn?=
 =?utf-8?B?ejZhbzFvSUE5aUdSRzk0UjY0OW9QbTFKSUlTdjFpOTN6M2ZoNlp1bEhRNHdm?=
 =?utf-8?B?aEt1UHI5L2wxVStaL3pRVjZlc2hnTnVNQXFQaHZUT21XMjhWdVBmNmQ3a3lY?=
 =?utf-8?B?OUpQVm1mZ01xbG5CZTgvbzVJTjlRdXc5MEYrU1NtSVVoZXJJTlA5b2dUaHlK?=
 =?utf-8?B?bVExV0NuNVVZSE1XbHFVWlFtSERTYTZHZnM5WjN2SmpPaHc1VGMwNkpZY3JP?=
 =?utf-8?B?UmlMY2V2UTlRU0dCVnl1QmtnN1VzL25nbXVDY2MvYWl1WGdlZmdUZGROS2ps?=
 =?utf-8?B?MGRpRnN6c2w1QXZic1VFWnhQSXppcmNHYUFOSFZ4TEx5TC9ZWHJqMmRlSlda?=
 =?utf-8?B?dTBHS0RDU2Rob0JvNEUwL3BwRlJtL05hOWt2YjRGMVh6M3RSUFpXWi9teDRu?=
 =?utf-8?B?N2doSC9UajlWeFZNcmtBTGRmUVQ2TklEeSt1VmlKVVFaNU1kM1RZQ3VoWGhP?=
 =?utf-8?B?SGVYdy9pYWNYclRFQU43MENRcFRXczk2ckR1cis5RWltdS90TFU1azM0dFB2?=
 =?utf-8?B?bEpMNm82ZXY0emdGT0V5YytlVE84THZFN2hRaXp6ZDhuV3NTQkFnd0lRSHU5?=
 =?utf-8?B?WThIdk50citjb1FsRGZuWjc1S25Wb1RaYUdFNDdRUGpOelZ2QVAza2VucEFB?=
 =?utf-8?B?K2RkVmtBVEtoL09PZmE0dG1URUJQSTg0eGJJS0wzMFZCdjlhZ0w2c2Z2d2xy?=
 =?utf-8?B?QzZsa3pJckVDSlZpdzNpNllrZXdmNndJK0dCTi9yMTVTVGRnZU0vckpPU1Fx?=
 =?utf-8?B?R1lLM2RCUkQ1amNERC9aL0w3WkhQdWtETHE2WnpNK2FkWG50ODd2TmhETmM1?=
 =?utf-8?B?UXI5TmR2Zmk3dmF2bDBWTjdjQWxEaTJnaXpFSVQ3cTBaQmxFZW9pNE4zVndL?=
 =?utf-8?B?RUljMThpM3U3MkdybEFiY0J5bktDWkNhd3drQnVXVWMydVlDU0JGbEJKMHpB?=
 =?utf-8?B?SUpVR2pwenJnWk1iSEZ0Qm5xQWZ5aHozYVN0VmlicWNYWUJJZDlmalhyNnFC?=
 =?utf-8?B?Mnh3SThZaDRkeVVxdDBKK3ZmM2JGU01oSWxLUnVJSzJpc2dlbFR1OUlFbHFY?=
 =?utf-8?B?SVN3elIzbC9SWjc1SS9leXBYbnNWY2RoZ2F5eTlGRlRxOFFETVhRL2dURmVX?=
 =?utf-8?B?eDhwblVmaCthUk5lbjJqRlEvTnR0VS9Pa0h1WHB4VnM1ZVhBbzhYVVk5Mk8r?=
 =?utf-8?B?aHlTY1lNbWlVazkvUDBNU0hZRWlPVDhkNkc3QW5mVWc3ZkRSci9IdnRJZm04?=
 =?utf-8?B?dEJodXJEelFiUE9PMUVTRzY5c0wybGwrN3Uzb3hYK3dHTWpYczJJRG1sU2VR?=
 =?utf-8?B?TElVSXFOQ3Vicjl1RWNHcUMvWGUzbmdvS005ZTV6Y2dNSE0vU2I0UklqeHZQ?=
 =?utf-8?Q?+G+c7Aq/Cji3r2MpSw5BIlh/M?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;6:cmtZ6AAje/or0nJ9Pn3r9ksnjyi0+v7SLo7x4BsJJMpzcK+cTGzuvOr5wMnnFfHLfYh8A3f30VGUutHEl76dG2ERIqm0dC0MXwxqrNRJF2BYQ8/GZIs7xBB89yIqOJKC1bIDdOzDwOrJny9JYBasvLR4IKFDAUBl4dTiWry8JHAfj6bq8kRDugNuPmCZfhRnrvBPWR9EKXHrs8w1JnD/1cuGnySC6VGhJ/AljGHRfcBJ1riArUHff9sWYYjLJ3GG9e++EcgkSuWtvAKJgF37CdibYnvGqogHD/6hOXHb30n82r42x/Fb6GomarxS1DoUvTQv25dLfQS3bkxJhcRIEqCqg5UXm832ghwbx+aGNs0=;5:1mOsHq05NLimw54XsEexT3x5vBmuHXegOohwkmiHldo+0m/tqTouaovt1NcW/S+ddNcNl7xc+3X96nrwIYyfJtVyt3Ml4KD1jQDXfbKUy8rMc6Yqu2OJpubEMcfhHFzPJFNT3PRTpR38VQUgnhQtB4PsdZI231ooinKd/EL7JOo=;24:Jla/gAXaGEjN8P9Qt1DwMCxCCZpDHPtSBbxVvyzLWI83FgclwMO3j4Mer32bXCztJIvJ2RDdcnpevm6zcCcjDVEmNbTJx3YXehf/cqfEiNs=;7:kWd7KHaR59mLt5lueTzNRcfBQID/O/d2yetFLkspAM2MXSyxk8OsmkafCcRzE2rKIzFUMeQaXK9wHHcdd4BneRdM2gC9cMr04b9R4dLUi8FuEISvKcsfLnxs06Zaf63s/UR6dVFZ4GjDjfC2DcD1+ks/z+ewPw4XGU2rJoEooJJm9R6tfhitB4Qe0W32iJoJQwDO8Yw9pKpTrjzYwNVMzyYFCAfZFnGvsQCHxV1h+yY6vdYb/nCH9dJNibuFihX7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:oJBCqfgb0MTcxCBgiJN8P9T7WNSFvY8BhGqUZaVWTHqZGTqYAgLGCy19+HHKqDa62kg3iOM8QwhWcYv5Op3yi8xF+9TC/Ako5lsB+aSLe43h0Q6+s7n5RXNoZv5yfZy8G6CImtfvhfMkw8gBmQFCbpzBY1hbEU56i5WshWJ/tX9dHMJHGn9cQKyzWYjYlNzRLgMaG58nA2rKwIK/NRGew3+kDKzQ9MeCTvhCJtxFqSRnr3ZJf1pby6+eirFDQc7M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 14:30:07.5481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b969718-db2f-4cbf-a856-08d573b772df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 1:30 AM, Kai Huang wrote:
> On Tue, 2018-02-13 at 22:57 -0600, Tom Lendacky wrote:
>> On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
>>> On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
>>>> On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
>>>>> AMD SME claims one bit from physical address to indicate
>>>>> whether the
>>>>> page is encrypted or not. To achieve that we clear out the bit
>>>>> from
>>>>> __PHYSICAL_MASK.
>>>>
>>>> I was actually working on a suggestion by Linus to use one of the
>>>> software
>>>> page table bits to indicate encryption and translate that to the
>>>> hardware
>>>> bit when writing the actual page table entry.  With that,
>>>> __PHYSICAL_MASK
>>>> would go back to its original definition.
>>>
>>> But you would need to mask it on reading of pfn from page table
>>> entry,
>>> right? I expect it to have more overhead than this one.
>>
>> When reading back an entry it would translate the hardware bit
>> position
>> back to the software bit position.  The suggestion for changing it
>> was
>> to make _PAGE_ENC a constant and not tied to the sme_me_mask.
>>
>> See https://marc.info/?l=linux-kernel&m=151017622615894&w=2
>>
>>>
>>> And software bits are valuable. Do we still have a spare one for
>>> this?
>>
>> I was looking at possibly using bit 57 (_PAGE_BIT_SOFTW5).
> 
> But MK-TME supports upto 15 bits (architectually) as keyID. How is this
> supposed to work with MK-TME?

I didn't know about MK-TME when I first started looking at this.  Is there
any way to still use just the single bit to indicate encryption and then
have logic that provides the proper bits when actually writing to the page
table?  I'm not sure what it would take, but it might be worth looking
into.

Thanks,
Tom

> 
> Thanks,
> -Kai
>>
>> Thanks,
>> Tom
>>
>>>
