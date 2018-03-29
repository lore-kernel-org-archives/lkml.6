Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeC2QKb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:10:31 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:16101
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeC2QK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:10:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8d050848-8970-b8c4-a657-429fefd31769@amd.com>
Date: Thu, 29 Mar 2018 18:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <98ce6cfd-bcf3-811e-a0f1-757b60da467a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:752a:d121:cb42:c252]
X-ClientProxiedBy: AM5PR04CA0010.eurprd04.prod.outlook.com (10.167.167.151) To
 BN6PR12MB1715.namprd12.prod.outlook.com (10.175.101.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 084fa0ca-d633-4fe5-b3b7-08d5958f95db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1715;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;3:wTCecyZNQXZEZAv1vKz8kQU35C1uPU+iNVVY4hvU2OK/nA1UUSl4aPsaEwvl5m/7pFU02TbPnRfmJWiold0GCgo/neXNq6vBP4nSsxnuljFw5HmKXKuG5+4Zc0NcDpka1WRiJXRE7HceHcrnvULuKWS3emnpae7D8v+WyISj3uuDs2MTwCOEjbMpZrpgU+1uZ8lQr40E1eIMcXtZpROSeL1LQwhH2Qh0Pj7BK8ea9DADir0XlePjBjq9ZpElRQ9j;25:TGOFclq8NSV/vQ4D51d/rHdO2g3ASL9SajUMxZQk/Awf7iu1qU+S1rUb1th8lsyTTilakubKka7Gz4DhAg332oGNn3WC8libFT2d/55pDpd/+sRF3pfBbs1KkFC5nxCRdk99TTfjcPtcopiHUBhr0mCodw/+mMMaDHL3PChX0es7jAB8bT4YwLJ3iCvcOEcGSduuLwnErgw3z+X30ihqHKntQ43G3TEaLcMIEWOuHX181hyJhFYciVFupaQTfBbn5gdL0NaG3l/mrFGEXcvmlERi0N9f/Hh2WsVK15e84RstjGkzGUfCP7gwnJAB+nksjrfVDZJ4vyqUOm3NqjrkEQ==;31:a347DfyT4TK2GWTYi+7bhr4sen3tk6uNDUbinqvtBs7e+8GLPVEmgWNKYJxEbQ87JSg6jGW7QjVBW4KLuqbCZeXhf0ZshWzRZcBBdQ1QvZOVwoXDZ1FxJ0YwNTU5SNMNu4QLxzVlZv6uPELrxFdMEsZ1F9XB/HGRwYeW65sSAu4weIddFpqPHl4/WhhUddKsy0EMDa2jjJzNgEiL37bEWz5PtfbMTC2HjTMFYm/DeaA=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1715:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;20:OqBb0/9P6FruCAyEQKeOQnn3I/SJdtfbtq6jEpbP0A5COhznRQm207w3HhanYNfrMta8GF0Rhsxr27InjRal3ybtXr6EKjHKodNcEIl2u3dia6CN9eSSGkq5CDkhWLD8LgQQusRxoPQl8lpIvC71Clo6GC+yHSAkPUziP2fJG/pRzljgeyPhHmY8DIehd+kyd6unvUSwljMFTUDa+l0WB8Yb2lSM/6mOGPG6EUkAMIQ6lZPF7hP+N6ev/ZkQaODt+JddRjt0+p+PQsBOnEsCDcGvE5zP7P5/gIFNQYiRTKZWMz0XmXojcyPpKrpNdEOeIf0qhh1NFUrgD3QaeYMcgHSw7lX2O5i+uynEABpG4lIiROCiEZkhGuV6kYnMBVtpzK9paeIvhW95cCezXP+eNAhF287sS3r7EbOlfrI7VVHZVDwMheLWvP269gvxbzPq0zYXhsmRQGZOEQsn1MWm/GhqxJoNWPWvTZAZ4VCFqhZlzLZAiILH4G5KYlf21tM0;4:sRn6FCML63nPShIGNYfRy70prWWfwyktSssCw8NpanTjpaV5vXPTtq2AZdN8zvAQqCSnXoFospI/LyWPfZI0KkjBu2D/k67BE3NMB3P76iw6Zym9FSJmwzC0hGk5Oi/S2Ph69ng86THrZg3N3429eQ+aylXIE9NZ6Z0sOUyYzrdWeGq8cjOnIZP3m5OPPyVyFQZpxSmmvsi2/QoZTgD5vfyNqalj/qZpAwNG4Qqiu+/c84OuKVJkKVe8KsR3I5UBuKptfWk9ZD4QfIIjxlYwmA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1715D0B025901D4CE9633D5983A20@BN6PR12MB1715.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1715;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1715;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(106356001)(58126008)(68736007)(6486002)(65826007)(25786009)(81166006)(97736004)(6666003)(305945005)(8676002)(81156014)(8936002)(551934003)(5660300001)(6246003)(229853002)(2906002)(53936002)(31696002)(6116002)(1706002)(36756003)(105586002)(31686004)(7736002)(72206003)(110136005)(50466002)(486005)(446003)(478600001)(59450400001)(4326008)(52146003)(65956001)(86362001)(386003)(486005)(476003)(47776003)(186003)(16526019)(64126003)(2870700001)(67846002)(52396003)(46003)(53546011)(316002)(2486003)(11346002)(2616005)(52116002)(76176011)(23676004)(65806001)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1715;H:[IPv6:2a02:8109:500:e1c:752a:d121:cb42:c252];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE1OzIzOnc3cng1WDVyakVkWXQ1RTJ5R0ZqNlBSZitm?=
 =?utf-8?B?VktMakRwSEpvdExSajFlS1NZUDZBaGlYSXpGdHJzM3dmWGtkRnltSW5MSDFp?=
 =?utf-8?B?NjhUSWJQYWZ6VlJ1QXpyekdaanVwOCtTclZ2K25UN2lXbjZqNERuRzVIUk5H?=
 =?utf-8?B?cXZHWUs2L04rUkZRaWpjeGE2Uyt2K1YrV21uTnZ6NDZmazluWUlNSm5yVU10?=
 =?utf-8?B?YXo4M2s3aG41OFRoMmxhQk5vUmxFOXpLbDdlOGQrS1ZIRkNUMXJicllURFdH?=
 =?utf-8?B?Q0c4VWJqQjlLeVdSdFR4T1QzSHptVU9GajR1N2RhNkk1Wk02bFloWUNHWGJs?=
 =?utf-8?B?Z01PWFZrSlVLT0FndFQ4cFdXVlFFWmVEc0pHYk5wYWgxdjUvWDR0MUhQM3p0?=
 =?utf-8?B?dFo5TEdtOWlFL29jVVhOQ1VXZVBLOEdJSUNmWTVrNS81R291cUpMNEJEQ25R?=
 =?utf-8?B?ajZGM1NGKzA2NE16UDlOTThTcFhSS2JTczdqNm9oLzhvb1NFbVR0YnRrRGYw?=
 =?utf-8?B?Z1lpWC9IOG9hZkxIZVk4UGgyTU42cE1MdXordENmcGJzQUg5Si9zUVI5VWYr?=
 =?utf-8?B?aWxnTXI1ckdEY1dsWElPb2ZlWXB3MXoyOGorMm1WTjdhQkRIWUp5TGxFQlRv?=
 =?utf-8?B?Ymk2NDVheGlkTlVreUNid0U1NXZ1ZkVVWDRBRStNNDZsS2tvRklOOUJxTyto?=
 =?utf-8?B?RTZWZ3hBVkRYR2FjQ1BYSDh0cjNia21QdUlMQUo1WWN5dVhBNFdLdTZQL2N2?=
 =?utf-8?B?blEzYWo4bHd0TzBuK0NsK2N2b00wcko5UWxlQ3drNnRQclBBZTFVdzQ1Rk93?=
 =?utf-8?B?TWxTcEpLSmhXaUZqR0Z5N1dqa0ZUbFdaRlJzVHBWckxQakRQa2xRSDRVVW1m?=
 =?utf-8?B?Q0QxdGxXNStKSjUzNnV0NVR0anpic09UMG5MRzFOY2hmMzlvU2M4UHhPV0hB?=
 =?utf-8?B?N1hER0Rwa0N5d2NZWFNNT3JMRm1rZXBFbzdHTnVWcktiVWUzMTlhVVczaCtQ?=
 =?utf-8?B?MFVvSFRWbVdnYjltWktBeUxFeHhjMTd2NHQwRUprZ3NmNGdIMmJqUTM1UDQr?=
 =?utf-8?B?QXhXTzBBVGpJQzJWRUt2Ym5OL3R6QkNNOVlUTit2aFVFcnZkbFZpczR3U0xZ?=
 =?utf-8?B?bTY1d3NpUG9haVc2TDVPUW05b0dTOXpOR1lIOG1tT2ZpaWdKK2VjY1g2MGdl?=
 =?utf-8?B?SVp6dk1QQXVMaXJIbm9BdEVIYURNZ3pjWkNvQTNFMElkWm9YMWhUaUREMWwr?=
 =?utf-8?B?Z0FhZkJKd2QxVm9GZWZEZ1B2Ym95RTU0c3R5MVhDb3pZS2FCd1pkWTJGMkxC?=
 =?utf-8?B?WWhzb3BBc3dIY0JHQThKajQrUGFHQ2hhcVhyM1gvQWhhRHUxV0ZrTEZ3LzVU?=
 =?utf-8?B?SDE2NHU3NlN2V25RSVBRbFJDR3U4NWUzMlZCSTNodHVseXZ6ZjROK1MrS0E2?=
 =?utf-8?B?TVViV0Nwa2txNURKZkV1NXFJVlRSM1l6RjAyTVdNZGxCeHo1MTVabjRQdkJJ?=
 =?utf-8?B?S0FQYjl4c3hzL1pNaVFJOTEzR21vSkZYNEJMVWJNQnlTR3lyTGdQWmt5TmVx?=
 =?utf-8?B?TEIrZnkzRWZJVDFUV21tZW1WM00xQXRkeEJudUlkU1k3RVU2bGlFUUhseVNY?=
 =?utf-8?B?aklWSFBSRjZwdVZSZEVscDA4N1BzSU9rZ1hsbDVoaDQ0WE9nUG5QeDB5SnFi?=
 =?utf-8?B?VlNMYU42MlUxK0JxN3d2ZUxFVkg1TUlFK1FjdUYrZ0pGTm9UV01GdVQ4WVc3?=
 =?utf-8?B?cEg1SEY4MDlpcEF1M2MvVWIrRS93S2pMMHE4eUVJSmIxS1RiblJiYnkvMm54?=
 =?utf-8?B?Tmw1MVJaYXRVRzV3WExPMzAvVlpKL3ZKOEVCZ3ZhOTI1UHAyNk41d3VWcnJy?=
 =?utf-8?B?ejE4YUF2RHVseHdoN2hXa0ErdWJ6Tnp3cjYvRWFRZno2SXVIVUtpV0lSWUhj?=
 =?utf-8?B?RWZaYzVKVjUrbThUZmZwUzRNZ1luazkyaFNrL3pHVmtCNm93T3VySXFEdzZI?=
 =?utf-8?Q?CZfzhD?=
X-Microsoft-Antispam-Message-Info: Xt1iJY3+B/Ynddp6T0+Gqddu/SLsxdt/ufdkr18V00S+8qICv/N3wNEIfOElzHPXx9ke40Fd6jWN3SwA+Jd9kBqKReK1xIdbOhP5i4z3tIkMj5tjhDbHy+y+2+79zF35QFhW87S8I24y3QEs9OXkwtd7TdGr+68DpArA3v2U/j+O0jBRF9YoDBlu7EWST9Jd
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;6:kwOSUtwcsUgMc0VwBTVi8IbcC6GsKw4TfWk9PjMcSdw3datTxfutsTuxbBlOosEWSqis6f1JL88fiCynKo0mq6jaXPpXMT1xDQwU68i1Jm25u9SRFeB5prNrmgBTrmre+abmyeBnjQZnnE2qIlHgsn+Elxg73kmshl9W+NmCM+KIaUU1ciK/JZ/28GxBb8AATKw+DVpNv+ytrol8itRRoU0cZX/K3PDXEgZesRmtXN3cToIPHqpHajxszDr4jaLQbqK9wf6SVyY3AFSsr5u4le/532/9Wd++Hxy7wafH0Qpmog3I+6xfyvF0UKuulVP4ySBrY2wHc26/54m3bILI0ASVVL3H/XY6/BDc4hRjD4U47meMoi26REv/68wJrH5B3YWSnd15w99XWJsye2ygewFa32ggUVcG0VL5XREf3xDqrhvT3eVpYnNNVDtvD8Egf/JmsidZaJK8eqvwJDN3hw==;5:3qxajdThYBCV9jDDQcuwrRp7YO9Y2oiBB9dzrfV8gKAKUkn+7kTNW1ij3nAnBNVp1yyxt3wrudf4V0tkBJZzHa7NgmsV24GblvEnQrYqj1VEYV2g4zZywZFk399NOrtdb4nOrnHxRg33s2MaDhLWSAQ+fldABCX/HmYHcD/zFBE=;24:saTfud8FURQYIEYDUl+7MlhzfmBAD+aGXau0jXfA/xGqg3EUq3YGkooqcTZYID14d/tt0ZwcnCEKywHaYl2R1Hv24vyF1p2wJKo8Ec9DBxQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;7:7uTxhZCVTlecICecEG1mavfQwH8se1Awl3zo6fQLrlTLYpongOYL9uaDJCR55F+h8ZoaUKhT12EbMiF4pqwVL8jp1JoJ8xREpOEFC8iWox6QavNqFM1uVU/2P3PoshLKXIEu90N/2Pw0Ddh5/Ka6+ki6MgsB/oTrT3YWiMzwIVizF42fvI9abTO6P6JuD266PW8hPJD63Bi8ZPIi9DOLQ+DXGKQV5uWBl4SOcVjc2Mx8VSW8kUJalB/KNVS7usYe;20:Q0khxKTgUw8jQju57eGuqS17hyrkFKV08rEBWYZ3H2qsAX7RXmivw9IsHkXh3LVartYuEU8NLKQ8CJ9BRcdvOvstJJi6Hz96U/9ilsMBQM3T7jM/kKWQI7KPftLfhXsegLN3RGY5m19+yycV+ZGMk699XBOTK7kmb+dt3cKCb5ppRn0s5HhMo4DMrpM3XAZAzo6vn0c7q1wHwm2+fkJPuUSYPQ4fFeGwkSsK8fdICUSRGD3TqkQNLvwsxD5u2x5P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 16:10:25.6257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084fa0ca-d633-4fe5-b3b7-08d5958f95db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1715
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.03.2018 um 17:45 schrieb Logan Gunthorpe:
>
> On 29/03/18 05:44 AM, Christian König wrote:
>> Am 28.03.2018 um 21:53 schrieb Logan Gunthorpe:
>>> On 28/03/18 01:44 PM, Christian König wrote:
>>>> Well, isn't that exactly what dma_map_resource() is good for? As far as
>>>> I can see it makes sure IOMMU is aware of the access route and
>>>> translates a CPU address into a PCI Bus address.
>>>> I'm using that with the AMD IOMMU driver and at least there it works
>>>> perfectly fine.
>>> Yes, it would be nice, but no arch has implemented this yet. We are just
>>> lucky in the x86 case because that arch is simple and doesn't need to do
>>> anything for P2P (partially due to the Bus and CPU addresses being the
>>> same). But in the general case, you can't rely on it.
>> Well, that an arch hasn't implemented it doesn't mean that we don't have
>> the right interface to do it.
> Yes, but right now we don't have a performant way to check if we are
> doing P2P or not in the dma_map_X() wrappers.

Why not? I mean the dma_map_resource() function is for P2P while other 
dma_map_* functions are only for system memory.

> And this is necessary to
> check if the DMA ops in use support it or not. We can't have the
> dma_map_X() functions do the wrong thing because they don't support it yet.

Well that sounds like we should just return an error from 
dma_map_resources() when an architecture doesn't support P2P yet as Alex 
suggested.

>> Devices integrated in the CPU usually only "claim" to be PCIe devices.
>> In reality their memory request path go directly through the integrated
>> north bridge. The reason for this is simple better throughput/latency.
> These are just more reasons why our patchset restricts to devices behind
> a switch. And more mess for someone to deal with if they need to relax
> that restriction.

You don't seem to understand the implications: The devices do have a 
common upstream bridge! In other words your code would currently claim 
that P2P is supported, but in practice it doesn't work.

You need to include both drivers which participate in the P2P 
transaction to make sure that both supports this and give them 
opportunity to chicken out and in the case of AMD APUs even redirect the 
request to another location (e.g. participate in the DMA translation).

DMA-buf fortunately seems to handle all this already, that's why we 
choose it as base for our implementation.

Regards,
Christian.
