Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeC1QDD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:03:03 -0400
Received: from mail-by2nam01on0051.outbound.protection.outlook.com ([104.47.34.51]:44962
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751193AbeC1QDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:03:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-2-christian.koenig@amd.com>
 <20180328123830.GB25060@infradead.org>
 <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
 <c81df70d-191d-bf8e-293a-413dd633e1fc@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5498e9b5-8fe5-8999-a44e-f7dc483bc9ce@amd.com>
Date: Wed, 28 Mar 2018 18:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c81df70d-191d-bf8e-293a-413dd633e1fc@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:fc63:9264:3a5e:4920]
X-ClientProxiedBy: AM6PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:209::39) To MWHPR12MB1725.namprd12.prod.outlook.com
 (2603:10b6:300:112::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 391f07a8-1ab1-4fb9-0f44-08d594c560ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1725;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;3:Tvjh+0O0Taiz1Of5Fw7gqkdKBzRpIFD27G2aAUn1CnvqHWyV8UnyS2ZpD6lhaesyiuUUoE+VcC0osv8e2LZdf9YKZXiH6TdEBDujR4x9kJUvz4mWNHYao6ydTBP6R/MIvmC4O6AQ0AJ9XVcuehbFk2oVu7rdXaBwbEvzRFwB0xA6ipvu9kABO14GJ/K/dCfkAMsIlkbklSnu3YKqFFsOLtkRx5lT1UKEgNR7nWmkJQ2Ma6okxIuiwBNagkRdRS6J;25:tM26m5EKVd+arVT/oF9WInKC0EF1lCCDPsHr7enFyyQeK8oR0zpPhW6sTL4j4SHqLE3wdSxNAECUl2iK9Ynrvzo/HlkBiM36rmd7fo5RpeRA1mAsn2TiyGpEh8SIlBl4zsdLzx/J/e3lEu8LmjakE+QyM4vlVjify93uZM3i85UuGXNhzSWWHnaOE5sCGht8W1IJouUAxrqsUvUoEXpWTVQrVTUgQ+a9EXU2J8+oLwTn3qN+tKbjotfcs+DR8DpDS0buniW+kGVgZZCzWU3e9xJgcgxM8Ib2FWNW6+ymamQRfUo4KI035acQAiGNjGmwYkArCbWa0IJjGYi2dY90Aw==;31:1/94s1EZ7hEKaAkhsR3BL6/gnniFWn9WeDSezbiFct9m7d+Lk/i2e8fExBOeXQ2oBxn8C5KO2/M/c8fkj4/h22v6ko68PwmSDuXvEBxT8bErm2r6EHAS6YqbK6utIhYgn9tHe4pwYLwK0fgrE++70COdV4e7JS0LJfxFODb0aajPJ4r9UcBTwIkx4jWtGug7j/7rmKAHQqP6pTZPSQrusEdEXLXjUHnunBmsct1+xUU=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;20:rljWyb9AVUECSaakJm/yelrD3ROooD4OevC/yBabqlAnIOPxnkMYwQGPHV1AI0u5/PQW+hs/tFv+m8tLH3osVQxFPeYtSHaXWOq0/+7TGuGM4SjPjGKs97uecFM8vTut3M7vVIg2Qc9/MxVpIaV+HyB35HLtalV9jfHfNZnFvBxraowksvyLhO/X1V3uFJSkqCXlkN/KP1uDOf4W16+PByMYA3PmQwlsMEvmvj4JteWRhJnbpgVt/J7+W1FnJXXq6ns3I9bbBgca8O2KkWOOPeiMu9MNwTvQlHCl5RgVUdBSQkGab7XAfXtJbnXwiXkAgCKMftHGOhSoCJOJgan06g9+Go3zqvF59i61/LabdTCW49JlpiTjP0sjXgBpOH2QTOF3hJuKoZVrLitID6RUIPlCkPhwYgk2ijq7GUQamcbO9pTtXh7H2ME4VgKbSDBnThneR20G3ULqhmffuCVFYhwQeB4/W5bH98nxJyrf4eEKrioiaoTdR63qsJoajSPi;4:2/qYt4ZQOD9yxXJw6c5QPLhbZ0wTioQwxGzjBdtzIK0iPcuFETW6zOBTsv/UctPPnsdvdBXQtjzXRJnvm1DLA0n8qACgR1lM8inqE4MxRSZdG/HkHSGhILUzbizzIHTusb3WcBTRCJgE+c6g8QRid1DMYzlcJllXIvlL1JXix7hchOeDnZQn94ljXmBSVcy4gzfQxpYJwq/VByKL4wREDeiTdhC+3/T8sw5O2MOqK0YiRUEOkQt0b5aPCeArAx0A5wBuhhqarBBu9KsrpLQu9gxzgxRPeAZQJW6sTyQyt9zr1/RtiXqrl0xTViesIGzJ3qpeImPpaphROhY+dQjbckmspB3Ddbf2a0+ylEAkc20=
X-Microsoft-Antispam-PRVS: <MWHPR12MB17258184BC91B7C59F26C13983A30@MWHPR12MB1725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(18589796830644);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1725;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(199004)(189003)(25786009)(46003)(6306002)(6486002)(476003)(16526019)(53936002)(305945005)(7736002)(105586002)(4326008)(31686004)(486005)(486005)(36756003)(6246003)(2616005)(68736007)(229853002)(52396003)(65956001)(186003)(64126003)(86362001)(23676004)(2486003)(52146003)(65806001)(53546011)(386003)(76176011)(6666003)(52116002)(97736004)(316002)(966005)(72206003)(2906002)(2870700001)(81166006)(6116002)(81156014)(8676002)(106356001)(67846002)(110136005)(58126008)(65826007)(93886005)(50466002)(47776003)(5660300001)(11346002)(478600001)(1706002)(8936002)(31696002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1725;H:[IPv6:2a02:8109:500:e1c:fc63:9264:3a5e:4920];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI1OzIzOjNsQnBKYUF0dE14SDVyYWFpOURkM2lSVnNY?=
 =?utf-8?B?clA2V2cwU1RTNXBIRUM0bGlHZFpaUUhvNUxhM3VCdW9QbjdFb0h0OUJuRUlP?=
 =?utf-8?B?Z2U2bDVRcW5Jb0kxM1ZFSWUydnJKYnpobCtuQkhQbE8wYVQzQ1d1bjRLWjhl?=
 =?utf-8?B?ZXdXbkV6SlAxemN6dmVvcyt0eWhRaXFOQ2M4Vjd1RlBhQUoxWURuSDlsMmpN?=
 =?utf-8?B?cGtaNDU2M1pVUVNDUklHc3JHVHJuVHJ5Ulhwck9RQmIxNGhjbXhGbStmUUhV?=
 =?utf-8?B?YnhodkFTRGZxZU1WWXBHRDkwVkp1OEZZcG8rcXF6VkNIUVZZYWNDOEdmczRJ?=
 =?utf-8?B?TE9PSXpsZk92a2VUOCt6aksrNXNmWXdkY05GVU8yUUJJUndzQUdyaVBzZ3B3?=
 =?utf-8?B?aUQvMXJkOGdoUE1CTEN3MFQwbzJjclpsWjhjdWo0V3p1YkJid29UUWpoNDEx?=
 =?utf-8?B?SVo4RmNIS3F0MDhKb1orQ1FzTTlkSVdUT1UxVWxxZEhHQVVyczUzMnNzTzhE?=
 =?utf-8?B?SGJiMTlaSGJza3Awd0x2OE9sd1VQNjUvSHlzbU1ERnFkbjg0S2k4b2xPSExX?=
 =?utf-8?B?M1NyWFVRbFlMNk9scTFTT0tqMnNyOXdmS0JlWm1SV3ErWkY3azRIQ0hmOVJL?=
 =?utf-8?B?QitzWmZYNDQwT0JnTmlnZFlZNG1VdG1VbjVSS0lMWDcxbUpnK1YxZ1QyTWhB?=
 =?utf-8?B?SVNXOUsxRzhaZ1hRelBDdTRIVlJzUXJsWnVXbUg4d0RtK1lrRTVmZiswV3ZV?=
 =?utf-8?B?a3NTUXZRZXlXanhZcHF3UVVYN04xQmFlSUZCNTFGU1pjZHdZbkRZYU1VZkl4?=
 =?utf-8?B?c2hWR2k3TDlNckxXRTlPY2JPYzFQWmJQalZPWFF6NDNxUEFWVDVpYWdaMXdX?=
 =?utf-8?B?VlUwVTRwMkdqVEtnYnk0dVVlem1xOWtUMFNqd21qb2ltUnl6RnhQWmxJYTRT?=
 =?utf-8?B?eXZRekVucWhUdXRXUENzektLRVBXUHgvVXRvbzdzVUxHNEhIZW5SbHJydGRi?=
 =?utf-8?B?NzBWL2p3aE0rYS9Xc3kwNW9DbUF3NE4rQzJrS2V1Zmprekc4UkZaU2dDM2ZB?=
 =?utf-8?B?aVQ3VUxJYnUrSFhMVldnQjMzNW5UT0dwU1RuN2hwSGYwR2ZZdXhJQjNSbVNw?=
 =?utf-8?B?NTVIYUxNMGZWR3RFdmxWOHptcVEyRHhxVXJySEYwd1g3TWVlSGNwakZuZWpq?=
 =?utf-8?B?UFl3K0JScVNUTnFGRGNSZC9VQ3o1Skg2aFl5M0I3NmJBUE5EOUltekxpSk9t?=
 =?utf-8?B?bUFXbm15ZFUwWDdoQmN4WnE5OGtJVm5nWXFhcnFOdUU5MjVWVUFFU3ZWby9o?=
 =?utf-8?B?VmtGV2szNXZRQUZGVmNkYnpBV1Q0bzNFbWJIR2dxbGIyc1JEV1FDYlVrVGNE?=
 =?utf-8?B?dXpKQk5DN0FGOHNnMWtlcVFiYzZKam9LNnZ4SjFia2tHVnI0TUh0K0xLaFAv?=
 =?utf-8?B?QVAzV092S2R1MXNsR0M4WHRRYkFIYSs0V1F6WklodmJacVp0dURDVWo3Q1cv?=
 =?utf-8?B?RXpBUGFMUE92eTZ1WWZYVFd4RE84SVpFTjFHTzFTVGVaMTd5SE9HWnV2K2Q2?=
 =?utf-8?B?Y1FsclM1a3d0NFNLTitOaXVsdHFRTzd4Vmp2TWt6OHQweVFOYWovMHVEeUp6?=
 =?utf-8?B?cG1WRHJ3QnRnWWZPU205UzNuTEhiVWpCOUlKRWIvZGMzU0hhWU55alFBSThr?=
 =?utf-8?B?WUVGdkNWQXUxdlVXU3d0cFlxSXBpQnF4K3g5OTgyWEdVYVpOODkrWU1Qalhq?=
 =?utf-8?B?UFdjd3BkaFYzUDF6RDlkRzVBcTZKcEFRRnoxV21HV1B5UVowWDQxWE9rWmtM?=
 =?utf-8?B?ZVR0RFNzV2xrd3hXdWY0Qy9kUWdENDB4N3JzN090bmQwSmVkejFKeGVnbmFl?=
 =?utf-8?B?VTRYSmRxTWI5WVdhUi9pVW4wQURyU3J6eWpEUk0yNkt2N0xSL1FWMkZuWEpp?=
 =?utf-8?B?MUdWZEx4Rk9HendNekNIN1FJdGJFN2JycEdkZzllQytScWw2aFU2MVlRQjhr?=
 =?utf-8?Q?1Qui3z?=
X-Microsoft-Antispam-Message-Info: wABjOKGkgOehx1ZIT1y4iUYK5mGqDUQGvAZ+/INo3Ef+NjgHic8exSTR9Vw/Q6UaEhRLwsb53mKv53UwTKLLCd+Y2Bm9IZw0uAr7t2Lv5Df8WXcCENs3aOMyuLR/ML3I002o0+nA1xPw5gpF6E1cRafPYP41eDxjHqKQspDKZ7hUjviCsPFckQfotevSQqbo
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;6:+w2gj4vtNGT4rlXmlw8+3F2Dkk2tD/iF01Ay08elnpavZVVXbt1LFmId0nSfaGkUdHN6Xujl8uLmLWzqsdsZMWEk8oV4x9ELmVNd/F+aTxY/BLx/gK14R4Xjwl66rl8cPQzjFCtjLwuiEygI30GmfnbxsaJ5MlC6PNVnDYYwD7xD2WirtUNGC2dqcfi/JLookf60V7tnmRZyHr31LDqhF8FDaUwgAkTz/JCt5dgf0sHb3hxYY5JQMrOhYghGeTUCJCgrp+45WR0t2ltN2hUP/ToD7xnbb74UN5ymew0oBn+p/qSojAPGp4GJKWAJ951TMStv6p5zuBJbNlt5cf4rQc/Glh4wRL8BnGGfqDtvhmuf1z6hU7OXLhxzBJtCb2+O/dxR26nM3O9kDvglkOo19FR6lmHnxPW+ZT9tkrRRsEM9vU1IENLXYuhn/WMO43Yxn/qf4q+lH/bxbBXZaAN6Zg==;5:KDm2lTuc7bIprZHOd79dmd/aInOc2PMg5sKLRrOTAmKXB9tTM6u9go/aZdaz5IyVww16OS5ONmQzBsVi/D3waR5QYWXbykC0h1ugZBlkvMYYx8ScPDP8s0zvLkSHJCM3TYUxK4kvLsCM2ddy2KjysiJbCBpShQQQn4+tf9/9VvI=;24:2HDzMLDy9MKA7wll6JIfy8/9d8S6kdV1gi+B5xbPx0y8AWJ6bVGSMx/ON/1xp7dX0AxgWZCd/uC3LxN/reH7QeWet5Dgr8iBXoR6G12CidA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;7:DAhnx0rhrrHWYvEMeB4W7bTuhYhO1nl29yr9qtUMM6CFYsgNp9i6nbio1kDxoPttHvGjGNhdRupQsmN0EKYSfwCMdKZ+UdO5DlPeDHxKw466sAOlC/Ny/wfxU2TANgIfYbysSwJs5RQyXnplQvzL3RCUnW5s3Laqps3Uk/EFLUqZFa0QC5V6oBFQZQl92C2fnq6KiLpR7TdsB3ilDw5YYZyNYVNQ2GyEO82u9CLbHNGZm55zN2+jkba4oYfOSrsE;20:H5j7z+yNqmXDzXSZmO88D9mqoFbyfFppY2CRp2AWSAfAp1ncrQ9f7RlgjnolPi4IvxNSYMTLfRHb32dRqtbF1ymCywk7Ybiy6L34nQxo2Z4jeSDV+wm7D3XbEvpI53vLCo+jr255OaNRHjUVh0L+xaS6qQkqdJFFVOBBna4CUh9TcKaUM0+KHMJgig+HEcLfWvAijr6H1THxMbioBQUczjQl0GlAOpNydeJvVObtbLdeVmT8oan6AroaYiE6k/yu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 16:02:57.6871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391f07a8-1ab1-4fb9-0f44-08d594c560ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.03.2018 um 17:47 schrieb Logan Gunthorpe:
>
> On 28/03/18 09:07 AM, Christian König wrote:
>> Am 28.03.2018 um 14:38 schrieb Christoph Hellwig:
>>> On Sun, Mar 25, 2018 at 12:59:54PM +0200, Christian König wrote:
>>>> From: "wdavis@nvidia.com" <wdavis@nvidia.com>
>>>>
>>>> Add an interface to find the first device which is upstream of both
>>>> devices.
>>> Please work with Logan and base this on top of the outstanding peer
>>> to peer patchset.
>> Can you point me to that? The last code I could find about that was from
>> 2015.
> The latest posted series is here:
>
> https://lkml.org/lkml/2018/3/12/830
>
> However, we've made some significant changes to the area that's similar
> to what you are doing. You can find lasted un-posted here:
>
> https://github.com/sbates130272/linux-p2pmem/tree/pci-p2p-v4-pre2
>
> Specifically this function would be of interest to you:
>
> https://github.com/sbates130272/linux-p2pmem/blob/0e9468ae2a5a5198513dd12990151e09105f0351/drivers/pci/p2pdma.c#L239
>
> However, the difference between what we are doing is that we are
> interested in the distance through the common upstream device and you
> appear to be finding the actual common device.

Yeah, that looks very similar to what I picked up from the older 
patches, going to read up on that after my vacation.

Just in general why are you interested in the "distance" of the devices?

And BTW: At least for writes that Peer 2 Peer transactions between 
different root complexes work is actually more common than the other way 
around.

So I'm a bit torn between using a blacklist or a whitelist. A whitelist 
is certainly more conservative approach, but that could get a bit long.

Thanks,
Christian.

>
> Thanks,
>
> Logan
