Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeC2SQF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:16:05 -0400
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:54982
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753544AbeC2SPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:15:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-2-christian.koenig@amd.com>
 <20180328123830.GB25060@infradead.org>
 <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
 <c81df70d-191d-bf8e-293a-413dd633e1fc@deltatee.com>
 <5498e9b5-8fe5-8999-a44e-f7dc483bc9ce@amd.com>
 <16c7bef8-5f03-9e89-1f50-b62fb139a36f@deltatee.com>
 <6a5c9a10-50fe-b03d-dfc1-791d62d79f8e@amd.com>
 <e751cd28-f115-569f-5248-d24f30dee3cb@deltatee.com>
 <73578b4e-664b-141c-3e1f-e1fae1e4db07@amd.com>
 <1b08c13e-b4a2-08f2-6194-93e6c21b7965@deltatee.com>
 <70adc2cc-f7aa-d4b9-7d7a-71f3ae99f16c@gmail.com>
 <98ce6cfd-bcf3-811e-a0f1-757b60da467a@deltatee.com>
 <8d050848-8970-b8c4-a657-429fefd31769@amd.com>
 <d2de0c2e-4c2d-9e46-1c26-bfa40ca662ff@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e4d94265-e35e-316c-34ef-99ffaee8b657@amd.com>
Date: Thu, 29 Mar 2018 20:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d2de0c2e-4c2d-9e46-1c26-bfa40ca662ff@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:9cb2:851a:ba0a:aaa3]
X-ClientProxiedBy: AM5PR0102CA0033.eurprd01.prod.exchangelabs.com
 (10.167.167.46) To BN6PR12MB1716.namprd12.prod.outlook.com (10.175.101.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea038fa2-14f1-4528-ae30-08d595a11710
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1716;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;3:4vNs9q2Vhj9OW3gnk3AU9+5NivDTfwQ4YisgsPGtTMbNQPYL5rifHtnSUJjz/oD2NdFqDzMzTvNGCrpxE2RFE3tXqLefpQwqgcHGQOKq+cm6SkLHNoXN5xzmnO2/kopZETPYty3YW8+mCvEDhK10i5X8S0L1srp052otZHUdqdjDe6HcmV+/Oogp28dlmBUi1w2NR7ishDdQ9Ahh5161QlatVBto66orSJktyM1Bul85XCHLD4RUN2ncLnNRr17d;25:1YM0YjMJ+3jveGUCyqZKTlvTiRGDEtv5Ev2Aw5e9sGRP9aMnyu71HSJUXVCy5YbHhgB7nVW4twtidpRh81i9HamDy30BUsrNDjElmFzee7BQVHYG54GEHCfbSCXu1q8NTD6dv/TAWHnU/9prfN1sTCSauyRc6t7K7MeFGnj4k3St6n/hbPYUqvHotdLowvCRxBeoHxJIUVRksC/l1yj+unIXG9TRdJ8GkV2o4A/5jDCoYAvhDOx65jUZnW+upCJ0mmWwzOH01Mz/gW/wszdIN6S5fzCydHrOxcruXWaurDdEgjKvx2kNXlRYuqsmU3DvrZ89PM+7JBqa0cHiu6lGaA==;31:/ZnDUW7kdRS7M5LZxtN4xmBj3F3rwPywjAGjanMK01kXF5At/RK5DYj+TftjMe61mJXbvJ0torTxUZFNws1hGkwO3cl4hqxsQVnkSB2EmC1CYudU63kaCkGbnLLFq2Qp/dIQJKD8WZ8zWsGX6hMy/xfrpQl8kLJZ9jamlXzZRXxVGZPbkrsylqS0RJqlyR4OJAyUNyF2fKSnC2KRy0H80OH5F8IvyI6Sd27skYW1Fgw=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:tSeX+BchuR/W0uXcvpZ14W3hZpauf/8MzLIXv5u7RTtJGPwvuvnInQITVU3H5+Ya9nSdOX9z2qjrJiXuiKjoDpkbBC95nGrk22I0tYF7g3IY23aldpNFQS139nOFRt27tjlwidL6HxByzsbfdRwC48XGxXrbcQGLsZ0t7HFhkR+vKStP5fBCAlw2QsKBN04IEy/5Sqzi3fD8voTDp6S5RfNCw6649h4IifDWy3LVbfxmFZ79JrDWFuIgjPXOA3m0p0an2Lxdn5bDycOto7jx7/h4hXXVlj8OuhZNqq0cD0UCSqgQN4cBBQBubCEaVXd3Qo4TDrI9JYM/9g9ZnzX/mXjuD2vRm001GBeRBJPooMMkbR08QWauBYwireG6WFMvRd7tcGJPfcK1B70Nc7tUGzSdC68hClsBQQL/ErmoWMLqOmmmVFjY5miP/ESLF2TUoIpdz3o5dEYgTBy2JwoVBwnJiXT+dhhzQLPXBNcmitc6CONr+kHEw3pbJ23iMNCD;4:cqFjpA0qChvU1Q5ynWVh93o6sjJhPO+kIfhvNMblgLokvRGH9FLga4hVBD+PiL1bWgJDQ4w6HH4jXgfuWb4PSJRc+UUf3VRtSQVXQCse07OHMfYXDjQMAc7vbofNu4G91wIMTr7gKG89f+ZSfSet75OGuXKbj82ryKFzzx9jO/IRIPJ51fIkYLjzXAtNcDs/Wbpnt/nn2kX4DbzaVBnH7N0yFw85iOvm8ASvhmwOTimFEq2rnGdgvTmFYTX8Tt21qoKo1i2Jz9gyv6bk3fJILA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716E5AACCA8D8E63F74497A83A20@BN6PR12MB1716.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1716;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(110136005)(50466002)(5660300001)(478600001)(4326008)(65826007)(305945005)(25786009)(86362001)(97736004)(58126008)(105586002)(7736002)(2616005)(68736007)(72206003)(476003)(486005)(46003)(6116002)(53936002)(2906002)(1706002)(52396003)(52116002)(52146003)(65956001)(229853002)(23676004)(47776003)(2486003)(486005)(2870700001)(31696002)(76176011)(106356001)(31686004)(65806001)(67846002)(551934003)(386003)(81156014)(93886005)(11346002)(36756003)(8676002)(81166006)(6246003)(8936002)(6486002)(59450400001)(64126003)(53546011)(16526019)(186003)(446003)(6666003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1716;H:[IPv6:2a02:8109:500:e1c:9cb2:851a:ba0a:aaa3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE2OzIzOlA3MXoyeW1YMTU0K01tb0RvdFd6M0NjeXJp?=
 =?utf-8?B?c05sWkdMWVZ0NllEcmM0U2FINjNwd3EvaWUvNmFRWU15cVVIZEZ1S0lQcllS?=
 =?utf-8?B?VHFSMUVnZE5pbFh6bTNzWk1jT0c1dzFIMVVLWEtNVnZTSnI0UjVUNUVEUGNQ?=
 =?utf-8?B?WnpxUFlvMUZEcGZrTG9Mek5Hd3N2M1grNFBCN2wwckljS0pzTGwwa00zKy9t?=
 =?utf-8?B?bmlrM0hROVZpaVQxcDRrU0NZbjFRbHQ2bDdVRG9DMFpZR2FXWkdaUFYydmlj?=
 =?utf-8?B?V0pQZlQvVi9BR3I1Ym1zZmpCWXZNMGpOalM0NUw0dy8wME0yeCtzNzliZW1N?=
 =?utf-8?B?cGZvYjMzWGtzcjdkcFBndkQyTkh1M2lYQkh6MFFzTE54eUh2NkgwVzN5dTMv?=
 =?utf-8?B?Z29zRWl1ZWUvZFFzSXU0UWNoNE5Vd1owRkY3cHp3alJIclA1VTZvWngwZXhr?=
 =?utf-8?B?QWIvVG9jT3lneVloZ29lZFRKNTFtekZ2cVI2aXRFUTN0SDhaaTZySk83Rm5w?=
 =?utf-8?B?K2JBSENZYktIL2U2N2hCeUI0ZjZPU0VmaXRlMzNteHFnMzhPME5SRjR1cjRG?=
 =?utf-8?B?NElzQW04OVFzQVRzNXpBZm92YXhHaU1ib285dDdweitzbnJGUlNoemJjcTFM?=
 =?utf-8?B?SDhETmpVUHFzeUhXNFBQMHZtR2xOMzc0eE9KQlVnQkplUmNIVjdPeUo1R1Nl?=
 =?utf-8?B?MUUrWHFrTG9lb0dZS2lOLzhYMDQ3ZGRzWlN2WnRXQ2FNdDdDdzViSE03U01T?=
 =?utf-8?B?QU9NTlNHYkoyc2IwcGN1ZDI0bHgwNXBVeXhOaUFHZFFSaVd4Mk4ya2FXTlAw?=
 =?utf-8?B?R0xkWWtWSFNsQjZNeGlKKzdnMW93dCtoVUpzRzlvK1RCWnpWTGNRYWZ3RVlk?=
 =?utf-8?B?ZXd3bHZ5Vi9yUEk5emgxQ1RsWXBTM2JuQjFWcmJUUWNlcHZYN2VPZkdGQVo0?=
 =?utf-8?B?TUtlY1VLM21GWnBUV1EvRlFoYk5lQU8reHo4dFR2dEZWU3dhREFtd2l2Y3d6?=
 =?utf-8?B?YldxV0w4ZVppWXNBaVFqZXJoRkpOZi9PdTJiamdDZVJIWFhrVHZEbVIraGxB?=
 =?utf-8?B?SGlZYys4T2VPeTJzUW1kVFoxMnI0UXF1NmFiQTBOOXRZeWE1ekRhejRSQ2ht?=
 =?utf-8?B?TkFidng2aTdWMUhDL0g1S1dVTEhLbDBLWmM0T3pwMWVWRjl1MWJhRkNCcS9v?=
 =?utf-8?B?WlR2VnVHWURkajFvNFJnUHJUU2l1ZEliWlRsbnNXdzlZZE05SkVqOEFMYkNP?=
 =?utf-8?B?KzRGaDA1R0MwcW91T2JaSWoranNISUYzU1NCcGFsU3VYZ1BwYzdiNXhYTTIz?=
 =?utf-8?B?cHZTSlMvNkh1c2d2THlESE8ybXpYZklHTTdxSDVhSWs0OW9Qa2RKZVpMczFB?=
 =?utf-8?B?R3RNM2I1eHJqVmZRNUJWTjVCT0FaQzhxT1c5dWQ2MGFPZ3Vab0wzRHFwVTZU?=
 =?utf-8?B?dTl6S052U20zMWpZZzFVNG5YLytSWUk2ei8wMVZUOU9OVjlYdGdXalJ4a3dG?=
 =?utf-8?B?SU9hejBPR0ZaNnBucElHU0VXczRsTHEvdWFVZnkveEovQ0JXM0luTXlNS3Ur?=
 =?utf-8?B?WFU1ZGhGdTcvOGEyOUcrSDFGS2JNNHVuQlVmNEhLWllGYlBNS2FlUlpRN3lE?=
 =?utf-8?B?ekhvY1ZQcVdFUWI5c0pLTFd4NlB5NFpMVjBsSTVvUGpPaTJib3JFL2hER1R2?=
 =?utf-8?B?Y2h2WkpNcUt1ZkVBSVBJYUFDcUtjNmV1ei9jSVJiSEplMWsxT1VkMmZvaFdC?=
 =?utf-8?B?VzliNHN2b1k3TDlVNTJWM20yOEwvd2NsMVRWT01EMHpqbStkem5pSDR4eU1u?=
 =?utf-8?B?bktybVROdlIrb0g1QmJhSWNWZ1Iwa1pvcFBlMmZtSjYydlBWdk10eldGdHJt?=
 =?utf-8?B?dXdHbXhSZlluUkkzTGVoeEVuNmdRQlBwcDdNd1dRVGE5VzNBWHl3U3E3c0h5?=
 =?utf-8?B?YVhmUjdDZkhaSzlXQ2VNd0hqRi9tb2dnUWpiZm9XTCt6R3UxOEx4U21OUEk1?=
 =?utf-8?Q?cwwxA9?=
X-Microsoft-Antispam-Message-Info: twGtDTCI0lS9844+aBNev8buf5TV45oRvNILTz1BnvMXW8yTewE3YkF5qbQhD2nKa7xHxbS0cp+M0k5Ip5VvDGL24vtcspI3YC30X6/WDxZAPm/z8IcX15oAVT9akwHZTxucjOZyj6soyKXCxw8YM5o6m4TcmUxUf1ce3RD7KsWBjg9bdqgHGn6/tcD/j3gY
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;6:mJt8Vq1G8KO+ZL9hgTlgfBII5E6pbuOMAR0UHkq6tH8YVTSRoMbFmVUZA8kNmBjDGIwaCsON2qo5J3qqSx2iDlir7c9seZTNvs78pI8mhr7U38s91WDj3vLWQYR7dO3Z70qT/qw1+lNyl3K9jZRgR0+Mf1XloFLjexfuzx5Osc2SXrHYPpNlppJh8NSHUa4BnxonUA8MIZGe7Bi4jOnz9K/xQ+W8i/JPdXHjtKyKi7rwWS5m0+5vCXtFbov6n7kO4Turcrr7SVe4/DC486MequujmIt/b+LFNyslsbehhPQvup9ei2PJNzLprDE0v0LCHLhuge0P2jFEcnUMmNh9UZts87F6Bxuq3d4dMah8eMA1Xtbvytjz3I5JdwxODtAEYZ46dy4rzpyhA/uXe1lfd1S03b716ip+JUkQGA6aFYcAkm8Fp05MdaHn/iHH1qFy5dmZyyMcncYX52ogwMvgcw==;5:w2+uQxJi/5R4860tdag4WHAylm9ts0uAMG1CzfRa4hpqcQiic+T0GBCdD/WX5e95cK1574086ZJcNeTRj8tclM0qSJoX8EqwJbKltxjdc9Rxj9fr+zTOIr/8BMZiHgKnfoeMsAMIJ/A7NGGCMNfiNzxjwOgCtEIFcssp4FQHaZk=;24:8EyrCG1bHEaJHw/lf9TRA+xSHMMV4vxas7U2fxVswcmcFQYxPHPhxInSSkwuYrjeFfUHvyC8xnk+6cLsjyuWtvgPQiT7MNg2ZPfkUbsMsRs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;7:8kXnWVTdnila7/K1KWBg6ip+VtN1TcbOFDMTOB0dGC0YJR5udjxxxf1T+yxVNCeFh8a4VzRsMPKSw8+NKV+4CKvzrnJrOBF1sYH5SwzBI/enxAD1AgC16DmbOdCWGK5jlpZOBs1m8QrVQfAu5+n1glgBZTH8u5lO8X0MZSmsufeWieSAhY5+Vxln3NRuEUHNxv5bYL6AYeILZ4QVr1ftW7HWGvNaVpI892IC2NLXt6DiwVfNwegjDiDff0Wo1VG0;20:Ki13Svdm6RjkR/jO2lEyh26NUuOG3ApVny0Jpg+DxS2lonTzZVwrVNQeQiQwNtcHMxlFbfTWHA4l33PnmOdsKL0Nxw/FcH5jMbOp80H3DHBJHq36jN15q5Vb6jndQvixiwVToTS07i5XnXPLKa+JF/8jNFPx+KtUNOeHmSSR/E/MDraVKYNzhJTljO3VXn92jn0CbIPmfWfsHWw6YX+5pCHPKY9QjJ0eXRca+qdeIRlN6VcfWT9Z6FVR4z7sTeiM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 18:15:43.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea038fa2-14f1-4528-ae30-08d595a11710
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.03.2018 um 18:25 schrieb Logan Gunthorpe:
>
> On 29/03/18 10:10 AM, Christian König wrote:
>> Why not? I mean the dma_map_resource() function is for P2P while other
>> dma_map_* functions are only for system memory.
> Oh, hmm, I wasn't aware dma_map_resource was exclusively for mapping
> P2P. Though it's a bit odd seeing we've been working under the
> assumption that PCI P2P is different as it has to translate the PCI bus
> address. Where as P2P for devices on other buses is a big unknown.

Yeah, completely agree. On my TODO list (but rather far down) is 
actually supporting P2P with USB devices.

And no, I don't have the slightest idea how to do this at the moment.

>>> And this is necessary to
>>> check if the DMA ops in use support it or not. We can't have the
>>> dma_map_X() functions do the wrong thing because they don't support it yet.
>> Well that sounds like we should just return an error from
>> dma_map_resources() when an architecture doesn't support P2P yet as Alex
>> suggested.
> Yes, well except in our patch-set we can't easily use
> dma_map_resources() as we either have SGLs to deal with or we need to
> create whole new interfaces to a number of subsystems.

Agree as well. I was also in clear favor of extending the SGLs to have a 
flag for this instead of the dma_map_resource() interface, but for some 
reason that didn't made it into the kernel.

>> You don't seem to understand the implications: The devices do have a
>> common upstream bridge! In other words your code would currently claim
>> that P2P is supported, but in practice it doesn't work.
> Do they? They don't on any of the Intel machines I'm looking at. The
> previous version of the patchset not only required a common upstream
> bridge but two layers of upstream bridges on both devices which would
> effectively limit transfers to PCIe switches only. But Bjorn did not
> like this.

At least to me that sounds like a good idea, it would at least disable 
(the incorrect) auto detection of P2P for such devices.

>> You need to include both drivers which participate in the P2P
>> transaction to make sure that both supports this and give them
>> opportunity to chicken out and in the case of AMD APUs even redirect the
>> request to another location (e.g. participate in the DMA translation).
> I don't think it's the drivers responsibility to reject P2P . The
> topology is what governs support or not. The discussions we had with
> Bjorn settled on if the devices are all behind the same bridge they can
> communicate with each other. This is essentially guaranteed by the PCI spec.

Well it is not only rejecting P2P, see the devices I need to worry about 
are essentially part of the CPU. Their resources looks like a PCI BAR to 
the BIOS and OS, but are actually backed by stolen system memory.

So as crazy as it sounds what you get is an operation which starts as 
P2P, but then the GPU drivers sees it and says: Hey please don't write 
that to my PCIe BAR, but rather system memory location X.

>> DMA-buf fortunately seems to handle all this already, that's why we
>> choose it as base for our implementation.
> Well, unfortunately DMA-buf doesn't help for the drivers we are working
> with as neither the block layer nor the RDMA subsystem have any
> interfaces for it.

A fact that gives me quite some sleepless nights as well. I think we 
sooner or later need to extend those interfaces to work with DMA-bufs as 
well.

I will try to give your patch set a review when I'm back from vacation 
and rebase my DMA-buf work on top of that.

Regards,
Christian.

>
> Logan
