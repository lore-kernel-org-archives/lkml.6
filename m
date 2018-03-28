Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeC1To3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:44:29 -0400
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:11456
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752732AbeC1To1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:44:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
To: Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <73578b4e-664b-141c-3e1f-e1fae1e4db07@amd.com>
Date: Wed, 28 Mar 2018 21:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e751cd28-f115-569f-5248-d24f30dee3cb@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:1814:ae48:f2b7:3c91]
X-ClientProxiedBy: AM6PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:209:1::31) To MWHPR12MB1727.namprd12.prod.outlook.com
 (2603:10b6:300:112::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56711089-18cc-4f66-ca3c-08d594e44f73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1727;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;3:pcRnyCDFPbXOSsSpVgmUdPH2ZIDNn7N8vEVLwZW1TT+p/9rm6uSboJsKUb/VVfrs48XbQYNVbCij49dRUYzPah1tjDhqb7ok9MecAntNUR2bx4GCEChZvjRAAxvah6MT6tbvu9ock56N5jy6saf+rEpbgsUjIauk0fOqE64D7GNlmERugcKzmt1sjzQL1x4dOmX5c+C2NZelcMDB3eICRj/R5Uz2eQWqJfnjQyPYFiZ5ZRJkZbWyxXUj1t0tGjcG;25:7z4G9ZnhxVao/TKZx7uRohhjM/vw+A5QUzDLmO8ivQ452hG6FxZwmjhoDl9EeTay8rt7aHz2x/EkhPwBVgPI+KEvbihwX5WZfM/cdW4oOfx3CQ2rT4kAAO1Ws/O9URNw6ZaZzcixl1LrZ3oH2AIuoRe5ojOuoQeQEFxDBWgHTe6M6L4hQNsSr3iee1qyMocbFu0japjfqRktZO0WU570+pZS7/i19akJPC1oL2wSvGnVw+hOT7dRMO0vhN0SFOMD/t6KaC7bDgFfJeu08xQgV2fRF3u4Ca2w1ltzneGCwLwuDxslAZ0rgd7yVfzd2J4TIcLwG4qnTL57bkVa5kjCKg==;31:Wsfe2aXfJR+vopFh0i4xdrfoDy/GuH7GrEBnnszka2Hu+4xHZl7EcZYG9bW7cxFbhsiqxzFPYJQSBT6G/trNkQcHBBoCXgA6dB1zPfulfkBvAczdsn9nVDOu8FDDMcvQR8ADwvne1Rsib4C9XkPPgi1kpk5bI1SaQkGpsSHj+Z4o+tk+pePvlczpDaJLMxz0Z/5xUMbEUKDiOfyl/l0Jijh7FeFExx6vptSC6h5lZdQ=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:v+MYJcVcH5I0CpYLN7VzJO5rVdhYuzC6WhuWai87W1JRnXpCisNKRR7urL4hKdAPPmlTY0sRtEOHzNWEf8ztrCYkjirtneT/w6kM0iN03Fib3tmrMX0XonXq7PsSvXuzu0EWtcdAnapUaAmTz/lxmbkJhMKVMW6WXvMr1+Xm5NiDhxCt5j7sEi8wXdrkpt93KiOdVYjDUgKSBSj9zEb72kZMiD92naig7vTRpo2erBPQITvn1D4bCl0v+/dWBM3QuHsVwHE+Rjm+rmH6gxcvFKAyEcl9ikm15znkESLhMx1RYOOOIRtIRN74PiHPXt1tiSvmlQcRJ33XxtOqmzrZP/GC6Nw9hDblT/F7YP7rbl4O+CrI9Zjsngt/EwfxPpoLjtPtcbgRzGaXZoWtssANkU8CURxgmQX7NwAnHfDUYbifW9foo6S8kqZcjPYC6CHPlq8YvgSF/OyRjrj41e3tJPetFMHgGYljNmVMH1B3jR/wdR1sVzLnAv1BR+m10RaD;4:oEBwHlXshQHfKOmMV2djABV6UK/5eykeEtgQwRu6JJhiuf9HHbXXv00mIusEXOUi9NP+tkPx+c0aIabccAMX2kkD3QPJ2TUQlejZkLMFmHmOjZrPIi/2sNLCx6a1Zk/Z1xGsEB87Cxd0yfJyn0opaZZW+HxZhiaM6VZ9oK0Pe/FR20tIx/gvzxrMGfrMGUVNmkIGv+hKkiKXLfT5a7xT9m/pJ+hZ521sjc5hCvVZF0i4meg0O4yjMmK+2biwRr7UIp9HMoXeTwSmsLWYd1t2LY5txd/61fl+yGuEmeVF0jF40PYWH2piwCzPFKem43lVJR/FwVy68PEi+QiZmJEk9bFboRHMnBr2VNV1GaiK0Oc=
X-Microsoft-Antispam-PRVS: <MWHPR12MB1727C029793A2BE2014337EE83A30@MWHPR12MB1727.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1727;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(23676004)(76176011)(53546011)(52116002)(2486003)(386003)(52146003)(31686004)(6486002)(59450400001)(105586002)(31696002)(52396003)(1706002)(478600001)(6116002)(97736004)(2906002)(36756003)(110136005)(58126008)(16526019)(2870700001)(186003)(316002)(4326008)(67846002)(8936002)(68736007)(81166006)(81156014)(8676002)(966005)(7736002)(25786009)(106356001)(72206003)(47776003)(229853002)(53936002)(476003)(305945005)(486005)(5660300001)(486005)(46003)(2616005)(65806001)(65956001)(93886005)(6666003)(446003)(86362001)(64126003)(65826007)(6306002)(11346002)(50466002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1727;H:[IPv6:2a02:8109:500:e1c:1814:ae48:f2b7:3c91];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI3OzIzOnAyKzFYYU1FKzFkdktWRUNXZm1XZmJnN3Ju?=
 =?utf-8?B?d1NVV293c0Q2ZzQ2ODNkcm9YS3ZNWTN5SStZQ1AvSURaYmpUcmlxL2ltMHk3?=
 =?utf-8?B?dHFvNnVaWTc5VjdUVDRraWVieFBJMlJaL0hRaExVcFFPZmd6N1J0dlF3SUhJ?=
 =?utf-8?B?RXI4WUhZdU5RblRwSmt0dDA3NFlLUDBMejdZOURBMmRKYnRIMWxhQXhSbHVx?=
 =?utf-8?B?Z0FzVk5iYjRSbGJGOFhCaTJJWGVCS256anpEMy8yREhON2FrYlYySnlHTnhv?=
 =?utf-8?B?YitmRzZRV29HM01URndHeGdtN2ZyVWNGVjU5b3RaZkxaN2RHd1FiSllCT2Fw?=
 =?utf-8?B?bG02VGRiSlNTb0dRbE5HeVpGSTFWcHhQOUhhRVVhMEJGei9PKzBsc1ZvWDVX?=
 =?utf-8?B?b3BaQ1VmbTZjczE1c2dDUE1iVk5PRGk0c0hOL3MzSFUrKzZRekhrTmJNOFBw?=
 =?utf-8?B?QW9lZDRrdVh3TzhqeThNeTBrajBxeGJTRmtnTlFxdGNGNUwwQmlldFpGSHpR?=
 =?utf-8?B?aEZ2WkhvdHF1ejFtYkhreGNNdjRRSEdGVTNra29IWFVsek9FUVU2bDZPTWt3?=
 =?utf-8?B?Vm9xOEN6Nll6TjhrUjZNQ3ZKY2phNTNSRUZyQUhYdWtsdlVwcFRlUllkcXBL?=
 =?utf-8?B?alJaOHdyYlByR3FscDR1bnBFYWFkMnpXaU8vMlJwT3YvTklNK005OG5GZmVH?=
 =?utf-8?B?RVZBTnN5ZnhJOXdiRUVEcUgxbmpzcy9QdjZQMmszODVoWHViR0xzQ3lqNWFH?=
 =?utf-8?B?UkNPSmlOSTZwaytiUjlxcnBhUnZqbkN4UXYxTVBqcm4rZTd6YVk4Y0xRUS9H?=
 =?utf-8?B?emZsRENhVzBsMDNXbDJERXVqMTVUVGZqU0dKc0xaSGw4dVdwMGxoUUZNNmQ4?=
 =?utf-8?B?U1BJNjdLenFlWEdRNElZNnpSZ0xnNVo5TDh2RytCZ2YrNVJseERSNzVJOUJs?=
 =?utf-8?B?SWljcUljTzVSRTdFUEZRVG9iS1p4bDJkUEFmdVY3ZUlmYW5RZmNTS1lKSWxC?=
 =?utf-8?B?WU1zVnYyd0x6eW5RN0RnZXh1L0k5WGdQd3NJWGd4T2ptLzJuLzRSdlhKZUp2?=
 =?utf-8?B?VjBCeWUxUUNPVmUwT1A3b2pocHgzd0ZWdzBidG80RkQ3QUVSMG5iKzNhdlJP?=
 =?utf-8?B?RjFpM2Joa0lsZWxqbFY5bjNrWTduTU9zaDIvQ3RDS1RDNzhJeEU2REdHY2Q1?=
 =?utf-8?B?SFlyYVJFcUgvK29SY1gzOWczOExjbjJTbGtVQTQrSUpxdjFNZERlYXpWamdk?=
 =?utf-8?B?SlNCcGphck5IZGRGSzgrdWNyNGRYZzkzNUhrZDQ5d3g4M1J0S04xTXVDbEFy?=
 =?utf-8?B?Y2VBOVE4NVlsSkZRWktxMWF0dDZlc0xaUXN0Vmxic3hiSVI2WDFwd1NTcklp?=
 =?utf-8?B?R3VtZk5tdURUSTZPT1VCcnV3MHk0SUhFNk5UNUJmeTU2SnlncEp5cUdvN1hj?=
 =?utf-8?B?Qkh2Unc0VDM1NDJOUzJyZjgvNE5VKzVMRUF4NXhYM2lUc3NGT1IzTHk4KzBJ?=
 =?utf-8?B?NS9LV1pRTzF4Nm5MRXlXb0xOS3V5N3Q2Z0UyYTBubUZLSUFhd2xoUnI1ZkFx?=
 =?utf-8?B?UVFkRURiTTBuVlVqeGdjNHBBOXdvbGQ0cmgyemFQMndCcGpwaEJQNUZvVzNH?=
 =?utf-8?B?NUlBME50bXZIY0RPMmIwSnNEWGhtQkVxSVZ6dklIRGswc1FBWklzYzh3N29P?=
 =?utf-8?B?cWlwck9kVXNvMlJhUUJkak5ZYnE0ZVNJMUV5bGdDdk9lZkE1VlpJWmVlQk5p?=
 =?utf-8?B?VEJ0aVRodnM0ajJueTl3WE1Mbzc2SFc5N3h6VkU0WHYrVVJ5K2c1dDZUbHM2?=
 =?utf-8?B?dUM2d1dmTGVvN1FLN0Z1QXp3YW12V2RqVHBxdTAveWZET2ZVa01FUk41Q1BQ?=
 =?utf-8?B?WDV1UllBQUN3cWhVRE5lM1NUblVQRnh3N1dDMHJVaHdITU9qenlTNmpjbm50?=
 =?utf-8?B?czJ4OFBibUJnT0JjRGlWUXBWanhxYUU1RnBZMGlVSksxKzgwblYrZEpyVDJn?=
 =?utf-8?B?aFlRRm40YlE0anlSNEtLNGJFbHVDei9POWtZUT09?=
X-Microsoft-Antispam-Message-Info: dJdIkC/da4BewHy8gsyd62gV1jktxPwUSlR/ol0b4x2rdzpgi+1L6UGpGscjyjpjpFXdqpIgm6ggFckunwFy+mmTZB7oFucZeVqZdz7w8rRGwOhXPUYk2vuvIUIOba2N3AiJorBNd312elZafxj+6SBMJJT0oOQu4LIM9bkzyDIryiN3+o09dBjuJWG+a5Rd
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;6:IIqonJlKyMNatQhO3cV7ya8efIDrWsU0jAlytQEo7APPkgCwPnbBTzUjstZ2DKfL4DDa9fGIJ3LLm3LCih/mHOxovjRoAG1idE7UBs7NyfBspYDYFRoVPKcISHe3XZ3cddtjJ227UFJ7tMIffaa+XrXEzkU0m/rs57Ntk2iRTdYSETqf9tbcilN98VW41STXZbg/Yydq/CNqK7Lx24xriQrsZzzF7gJVCo3PbJ8NTHtJb3g6rI/WTkCJHgD7PXi8OvAsE5ukPVwhG3irzL66gJCy0uy25rER+JFQw4AVVZ+56mLR8Uw6GC+sLsBFl1nqV9SIbH9vP0RB4TsWUeBJOQzZArLca7YggThrtL+ICcyGiC84O2pbb9ElyMrpFE+8A5sfy0rPixL4HKbomiWvI13+1kPIWkhdhzQtevbX8OW3jBGPSi4pV0L1wcC/lCpjkGpgCQPz+3qJFSBU+MpUmA==;5:Q6Vn29O0wapWuYsLvgo+cNfeGesryPA8jEtk7Jhj/DHOSSRnbNZs5fOW/XUWGikoapPEZxIp6TUdbQW1EV/Whz30Aq8UnhLYGaSlXGtvGfArYLFJe4pK+ABFjJYDNQWc+IZk9ay+IbadPlXwYzO0U/D2WRna/dXh3NMnQ3Ag+kw=;24:FUpJNaYkTBZsIhr1+ZDLznZ707gD056ZhUpvB4Jn5wtI/mWhzSOsD7ljWO8Nkxk0a2GT3PWKC68eDjqV/SXnBZwxVzqXdgSyG4ZjaFut9Wo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;7:yZtbjnfplfiTL+8HLwzdwSajCZrVtbWUvOY75QkYrRg508mMaHcacDY4gXk9WsVkflarCl9RGTviPa9ulLB/EZA2PkL2YobXUdX4LW0ZO1dgIqta1PfLUToN3GMZQfosskzTU8Hzkh5R1AIntIwf7GSepgSXcnQoHHM1RH36ObQa2EPBs/zrLa1VgjUu8op+rrAnI1ixLYI9HPlbjmaqfuRdo3O/HC2aso2Zfi1LBucNBnfEUbPLbOE+5RLwzBpX;20:uRYNUE6lZux+45D8him7rWLlxHpU0ADMBB366sWV1CGM11gyVauMN3Lqf1BucKBOgfR8ER5lx+4TQ8U1qo+Lj36fpETEhbYKkDrcSrDPen0zv7kPt8xIUxgyPErruNVooSqMmwIInUackYDl3FJiuebexmQDFrULnDsB2FSgywMfRiopTHSIySiOAYAr42AtvUhWc+B542uVCoxGqnK54CUrPDTizEmasFTVmReDk/oj9f/o4wVBFmUEXbLm3e76
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 19:44:22.9860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56711089-18cc-4f66-ca3c-08d594e44f73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.03.2018 um 20:57 schrieb Logan Gunthorpe:
>
> On 28/03/18 12:28 PM, Christian König wrote:
>> I'm just using amdgpu as blueprint because I'm the co-maintainer of it
>> and know it mostly inside out.
> Ah, I see.
>
>> The resource addresses are translated using dma_map_resource(). As far
>> as I know that should be sufficient to offload all the architecture
>> specific stuff to the DMA subsystem.
> It's not. The dma_map infrastructure currently has no concept of
> peer-to-peer mappings and is designed for system memory only. No
> architecture I'm aware of will translate PCI CPU addresses into PCI Bus
> addresses which is necessary for any transfer that doesn't go through
> the root complex (though on arches like x86 the CPU and Bus address
> happen to be the same). There's a lot of people that would like to see
> this change but it's likely going to be a long road before it does.

Well, isn't that exactly what dma_map_resource() is good for? As far as 
I can see it makes sure IOMMU is aware of the access route and 
translates a CPU address into a PCI Bus address.

> Furthermore, one of the reasons our patch-set avoids going through the
> root complex at all is that IOMMU drivers will need to be made aware
> that it is operating on P2P memory and do arch-specific things
> accordingly. There will also need to be flags that indicate whether a
> given IOMMU driver supports this. None of this work is done or easy.

I'm using that with the AMD IOMMU driver and at least there it works 
perfectly fine.

>> Yeah, but not for ours. See if you want to do real peer 2 peer you need
>> to keep both the operation as well as the direction into account.
> Not sure what you are saying here... I'm pretty sure we are doing "real"
> peer 2 peer...
>
>> For example when you can do writes between A and B that doesn't mean
>> that writes between B and A work. And reads are generally less likely to
>> work than writes. etc...
> If both devices are behind a switch then the PCI spec guarantees that A
> can both read and write B and vice versa.

Sorry to say that, but I know a whole bunch of PCI devices which 
horrible ignores that.

For example all AMD APUs fall under that category...

> Only once you involve root
> complexes do you have this problem. Ie. you have unknown support which
> may be no support, or partial support (stores but not loads); or
> sometimes bad performance; or a combination of both... and you need some
> way to figure out all this mess and that is hard. Whoever tries to
> implement a white list will have to sort all this out.

Yes, exactly and unfortunately it looks like I'm the poor guy who needs 
to do this :)

Regards,
Christian.

>
> Logan
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
