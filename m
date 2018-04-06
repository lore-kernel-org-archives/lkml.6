Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDFRVB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:21:01 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:44496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751312AbeDFRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:20:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Jean-Marc Valin <jmvalin@mozilla.com>, airlied@linux.ie,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com, labbott@redhat.com,
        akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
Date: Fri, 6 Apr 2018 19:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::46) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031cd338-45c0-4c25-c2a0-08d59be2c2cb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:cX5LJ+cR/7SOBa8E5IOixRYOGn/hT8WpIbdx7N9/IeCKw3SE7uXYfVwdaZNrhmmXIY9s3dipf+k+u2VeYjGVBGCjeMzGV8zjE5+CjBRR1NDloqI3D0tPBZ6QHKnI0bJrNDJkQLSDyNfCVVD/y5f3N7I17gAd06wPyt/IvhXFjjQGeRfdjGhALb6BhCdSpYb/McN4HFQ/uYJioi8/3skF2VeFBfTCp5vWxSTbnUrbBtQ+eQmPyfUhzf9jJhYvfPxG;25:/wzcP3hRgPBXpFOfT2b1uQZ47aeJsxjlsX6XjhW7C71uTSHzHzYAdiAFiGNE48GQwLSiaqc4oD5tpGjzEpsn1iWLQDErvI2FHlLkaUWD36byLvDGRrdY2wV5coJOZrQgstEepDWUsEXNY9FcsFZ3VYZ9jG5OgJKGco8x6fQKDIwVfmqT8Ff1tLG4RK9xZgH6nhQ3lbk/msWeTkJY6LytyH8gsT9M0tbb8YqE/UWZz+XKO7v1XNf8bAD6YQPIu/vObEX+E5gc931/EQcnhcw0isPmtZsSKk+EZ/NefxfZA6fPIYMqoYMtZZMFtKk5z/bbPig+athkdJSICJE0afgSBA==;31:qrFLc+Vkj3zCvi8IT3Mi8CVaR2lD/vJ7FymnfoPDRMgkyGXmOY/Y9lBrjCTZZt3ro3GRfWBKv6Mh+XiY83iGVt/Ute2afFXClt9Y1H9H2eJroX4FgkDjfZZOiJpYkXsspd/20+ChzyjDmYBqR+3c+OKmG8L9ZwQeIbpVSjNJl2zxSV4IDCjHrjTPCKzUJB3XI/ZFvjobAAMI6MyQZtVOPXLzjaioTMkzvxhfpilwbpU=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:HzlHUCW36NrmAGMdP3MVTH85qwCj+Yr6fXarvjgHzvkUFSiYrlk5hv8OgAq87Fmqh5bivpRbTWo3F3vzEaoDJ4Lt86E06z8vy5gNcK81yk6wq7U0T9CaqzDvtKl3RQ3eOESRC/Km4y90QYJJmxpW6FTCAtzDDYKnZPzizBz2ekvgT5rVe16ttcQrqTZO1nbSE2Hs4HTVsTYSdxr6WgAMzV/OeeJa+AQX4D6qAa3/RkZNgBNH+2Hom5ex2qvreHfrcagyBqvE8STjxtdMIuKCZK6yPpyEHplJguFw3xR3SB7y4GretGJWLWzP79XCretinQlE/Hsl68HGMNoYdptaNxm6Qgs7WTE4bMs/xm9u1GlYjJnMXrZQAxckeX3oh8FhpkU9pwDiKqaKRtTkv6Sjm8Sl8s2MmCWZ0dQ/79rjhvODErFUZyfAhA5na4lj+HduFGaXfqNBpdd/+JHqz+2Q5PNymaGVvQHQ1empqmhl0Aw5nqu+aC1zaw9y6D8kVmED;4:8ncQDlv50PNzhaIEInTo5f1PpY7FjG7hRPikWYcYiMHEWNGLSrnM6dgrKAKSeOxoB3j4d93WwCFrRyXFBlB/UKL5AEHtiupZHW5qenel/LlI5S4sthuyu1Z/RlFHadkwU3VrXMzmWRRkmLsziMopPdoZHrl+MU2Cww0Pt0clCs95gyFYEYGKQCM7ga+hKRQt36ZHMzN8jsByfggzNsl/xK8LbWYTjT1Hzv86M6G4OFwq5K+RjCAqeZdRcKsy/hhcPLTwlAuqBfizclmmUSAZdA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB172176B340FF62AE9BF20F4083BA0@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(52314003)(199004)(189003)(966005)(6666003)(36756003)(52146003)(23676004)(72206003)(64126003)(2486003)(52396003)(52116002)(386003)(67846002)(53546011)(76176011)(229853002)(5660300001)(53936002)(6306002)(6486002)(105586002)(65826007)(68736007)(31686004)(305945005)(2870700001)(2906002)(47776003)(478600001)(8936002)(8676002)(97736004)(7736002)(65806001)(50466002)(1706002)(6246003)(6116002)(58126008)(65956001)(81156014)(86362001)(476003)(93886005)(106356001)(446003)(11346002)(186003)(2616005)(46003)(16526019)(31696002)(81166006)(316002)(25786009)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOklNQkNUOTNCUGpIMENZaXNzSWFmTmZPYWJs?=
 =?utf-8?B?bTk2UDBUSzhZSVBvaFlQKzF4cWhjaE90dktLM0FaL24wKzR4NFcrSWNGSWcr?=
 =?utf-8?B?ZjR1bDZuQ0F1Tm9QZkp2ZU13VkdTV01VQlFvQlNHN3F5aCs2cm1salRjZDBy?=
 =?utf-8?B?UWNUWndxbDNaOWt0a1BzWTVqNFNHUWtVT3NTdzZCY3BhS0hZcGczQkdodkxG?=
 =?utf-8?B?Q25hcTR5SXIyR3R3RkFVNXY0UTMyTUIwbkpFYlJTRER1bFNOVHVkbkk1V1FD?=
 =?utf-8?B?NUNyVVJoaVYrd21RVHNZVFdVTGRXNFFqNEQ1bVZLM0ZRcUZKalBocVI1L2Vn?=
 =?utf-8?B?Q0tERUpwNEVrOUJmSkRzbzdBa3ZwNHpBSXltS3F2dVdWZ0YwTVdlSStvQjM1?=
 =?utf-8?B?TnZ1ME5OQVJndWUvMGtlcWFwN2VxYklTbUl3TnJzZDVodTREajk3Y3o2N2Fk?=
 =?utf-8?B?d0RIaEU5UVdlUFNrRXRyY0FrM1NZMGhHUG0rcUFERjZTYlN3Y3BJMjhmSC9w?=
 =?utf-8?B?N1VOdUlaSTM0ZGgrUmh3ODQvaUZrWS9oT3EvbmVSK01FUjdJWUJaZkNYY3ND?=
 =?utf-8?B?dWl3MFFWTEN0bXVGL1k2N0tjd1FscUh3dmVacGxqc0d0ZFlxWkhOc2FoQmh2?=
 =?utf-8?B?aXkrUi95UEV1STBmM2I5WnVUWW1lUE1yczBPWGZyL21DcjMzQmo5UEVGZFpt?=
 =?utf-8?B?VEJndEYyYUpzVnl5aStlRDM5TUJ6OCs4UFVuYi9xc3NJMVFjQlNnNmtBekJo?=
 =?utf-8?B?TXNmaE9uZytsK3Jnb1RPclRoSkNjVEtYTUdBR0ZwbHM4N2tZNDErYlJMaXNL?=
 =?utf-8?B?dEQ2d0VtT3NKeHdkWCtCdjZpQll3aUpyTkdKcjJtZmZESFhxUGpiZ2o0ZytF?=
 =?utf-8?B?SStJd3ZoRjZrNDgwbU5panVyZjgvRlJsdk5QVUVQNm80ZHdDalFxUnpOZDNW?=
 =?utf-8?B?QjV0ZTRPcWE2U0M1eERWbkJ1NkN1aHlERXo3a0F3SHpCREJBVXR6cld1ZGwy?=
 =?utf-8?B?dlpFZWVIM1hCN05PMTNsRG9IM2F5ZEh3RG1XaGZYcW04S1hFRGFRcTZBUkFy?=
 =?utf-8?B?SE9MclZwYUxzbG1hMkxjcGM1OHE0aHVMM3QwZWpUeUhXUlV2aS9vREhRSGZ5?=
 =?utf-8?B?eU5teDRHQXR4NzZrMXR2MWxPMks5TUlSYW1jQUZMUkpRU2VKZGQwUEEzNThT?=
 =?utf-8?B?ZTYxSzZaWjNwWm9MVVR5Q0tQUS9PMmFBeEdUVkIrcDNzUzRJUVF6cjlDbVFJ?=
 =?utf-8?B?dXdvaHBiS2hEaVJrWmZtZ1grRVZicU8vV2hpaURIWG5Uc3kwdzMvRGF4Vkov?=
 =?utf-8?B?T3VRTWJ1bDQ0QmU0a0ZKdFVuZmpDTDU4YjRPZk0wcXcyWGEvNEE1bjUwNnky?=
 =?utf-8?B?aEhwejN1b2c0aFArb3JkSVJ3eGtvSjdQdEQ1VkEycWhydm9seWpzYThab3pW?=
 =?utf-8?B?K1labzN2K0FHQ3JYeENKRHNGdm0vL3ZCYk1sTWFjM2tGWkVrM0kveTdMbEVs?=
 =?utf-8?B?dU9ocUgrclhIeXpiZk9hS3picCsxWWVQdzJSc1YzeVNEUUR4OFEzdS90K2ZL?=
 =?utf-8?B?MGFySkJyQW5mRFF6TVZDZEJhKzhHOUcwa0FKZTNmQWN2K3UwdWw1NzRGR2dF?=
 =?utf-8?B?UmhNQ3BRdG4vVWFMaVBTenozcjFqbzNqZTVMMkQyY05YSXBXaGNvamd6bjNi?=
 =?utf-8?B?QzRwY1ZuOTBJeWFtTGo4NzkxclZDdm05d0VoTjFnOERzdWtZNWFGNXl5Ny9i?=
 =?utf-8?B?MVNyOHU2eWJsaGc4ajNXaGYrbGM5VitCbW9kLzZwTVBBbHordnBEeWxQVmRC?=
 =?utf-8?B?ZnZsOVNrdzV0Z3NKSUI0cDdnd0xQb2hJTHAxUW1rSkNlWHpJTkI0bUZmaFlm?=
 =?utf-8?B?UkNTdFZEemREWEREYU5nWWxZNkd4YkszS0pxQ1FWVlpvcDdTK0lMU29kMFBv?=
 =?utf-8?B?L3NaQVIxQ3R3PT0=?=
X-Microsoft-Antispam-Message-Info: CdjpBnqWxVchXkm4ZH1wn6qPPJKwMzK1z78ZK7Om1nNwibviGu3iksSp4OtH5BzyoB9Duz9EGD3VJqS1gdZnDhyLcl/jEb4sOrFNbD/cdANnsxFRWvmEkJJBXwDPEj0pCk9q2aesYRSvbvyMtUtcNJddQbV3aB3D69JqGRbCG/AdYV/ZI0UZBbXUrsVfYAfv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:sKQ4NI6tUKD+Ml0ZnxXoNUorTpsyfuhLh1phYIdx1/63R0YFvZz3ru9ykKCd4JRmOL731CZgZd0QNoohD8L2OeN7NpfR2WJUsQgJgTUVOSgEcSvCnM8J+fciRHLOCeX0uaukhtVB4XSOz8lX1TKtxL20CQSASFgnxx3MWzNwzG8h2j6eJQmWJyNzp4o+Snd0huiEO59T8XFgcIRdO4rBCPZL8JJ2Ck1nIRsHoMWRT47klPARYh7irOqnNWg+TsqkXEDB6uSfkubhfLD/WF3k3iP7Ke2dc+IHDRckcL9rQXi7z4WOHzdBuryhUqFN66ybd61b+RlOKJUpIakmaqvbYmi/xvbk/tPRziY/JFcWMFIE2QktBKhw4cImM1v8KV6ePsEMFAz93zOTnXyv8HoUk+uufvawW4CQm/Y8mgBiJqDZ6pmle6iidE++Ghikkqmrjb7VPUyPEmKULI16hmrVpA==;5:WiUtcPFrm3M88Ql7Hf/M/sUPRKSCQITDmO1/fzovdIpGck51JqLRDGPFDHKh1+tddgb0HSpGehlRVTWkeEXB3wL4/Ni0CVy9Te1gWJh20vo6Yy1RY7Ryk4JQ6Gs+nU/DiICSkIRPZ0E3uJU3wFLfZRwuXNy+exEIuS8TYqZjiJc=;24:jveLzuDiDkUVtncGiv/5EujQZWbEBcwBQX7NS3lrKW8baMWvnB0rkTFGqs38nsa1v0wo2Zjh6UAIXmBcfn/yiGEQ7PfCMO1OXGRQ+f1YXac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:sN3KIjaQMfIEsVGgv0xFJrYzxZ73cbpDLdtH5cAbBlYc1ai2+LyrbHDUpPEjps8cFr0y5gUfmgzGlmoa0VlVnEetFaBLmI4qE/oOstcR0mErz8SfmA75AvYuRJ4+PvsvhAUt3D+6NAQ2fbsZo40jQspq9W3biml7o7/VMap+xLifwln87cww7KmRZZu4HR2Nd5FPX83UtYfXbLWqBr9auX0K5iIJFs/eRTTvgIoZD3nVHukx2TvCQ5a9UqxtDrXk;20:sFdBTotZHr9XTOjG9+ZmqbYUWlmkI63/VkPLhswSWeJmPca/pam27VEy5hwc3cq2SaEe68BofW0P10YSh6/JtuFUx9KWeCU+jG4A5weDEfYIqFDtZP+4tZyK0zgoHsa2eQzvD7h/QgTyl9v2NSuJtDVdYIasrF2Ua3nEH5q6ziYS09aZ3mY1atzyaQzb4Tv6OJcQpYGM35AB3UVPBIT9CZZkfitJMJs/dS6C4Oa79GfC12+PRgg+lV9TSf0PpOR4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 17:20:55.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031cd338-45c0-4c25-c2a0-08d59be2c2cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.04.2018 um 18:42 schrieb Jean-Marc Valin:
> Hi Christian,
>
> On 04/09/2018 07:48 AM, Christian König wrote:
>> Am 06.04.2018 um 17:30 schrieb Jean-Marc Valin:
>>> Hi Christian,
>>>
>>> Is there a way to turn off these huge pages at boot-time/run-time?
>> Only at compile time by not setting CONFIG_TRANSPARENT_HUGEPAGE.
> Any reason why
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> doesn't solve the problem?

Because we unfortunately try to allocate huge pages anyway, we 
unfortunately just fail in 100% of all cases.

That basically gives you both, the extra allocation overhead and the 
still bad throughput.

> Also, I assume that disabling CONFIG_TRANSPARENT_HUGEPAGE will disable
> them for everything and not just what your patch added, right?

Correct, that's why I wrote that disabling SWIOTLBs might be better.

>>> I'm not sure what you mean by "We mitigated the problem by avoiding the
>>> slow coherent DMA code path on almost all platforms on newer kernels". I
>>> tested up to 4.16 and the performance regression is just as bad as it is
>>> for 4.15.
>> Indeed 4.16 still doesn't have that. You could use the
>> amd-staging-drm-next branch or wait for 4.17.
> Is there a way to pull just that change or is there too much
> interactions with other changes?

It adds a new detection if memory allocation needs to be coherent or 
not, that is not something you can easily pull into older versions.

>> That isn't related to the GFX hardware, but to your CPU/motherboard and
>> whatever else you have in the system.
> Well, I have an nvidia GPU in the same system (normally only used for
> CUDA) and if I use it instead of my RX 560 then I'm not seeing any
> performance issue with 4.15.

That's because you are probably using the Nvidia binary driver which has 
a completely separate code base.

>> Some part of your system needs SWIOTLB and that makes allocating memory
>> much slower.
> What would that part be? FTR, I have a complete description of my system
> at https://jmvalin.dreamwidth.org/15583.html
>
> I don't know if it's related, but I can maybe see one thing in common
> between my machine and the Core 2 Quad from the other bug report and
> that's the "NUMA part". I have a dual-socket Xeon and (AFAIK) the Core 2
> Quad is made of two two-core CPUs glued together with little
> communication between them.

Yeah, that is probably the reason.

>> Intel doesn't use TTM because they don't have dedicated VRAM, but the
>> open source nvidia driver should be affected as well.
> I'm using the proprietary nvidia driver (because CUDA). Is that supposed
> to be affected as well?

No.

>> We already mitigated that problem and I don't see any solution which
>> will arrive faster than 4.17.
> Is that supposed to make the slowdown unnoticeable or just slightly better?

It completely goes away. The issue with the coherent path is that it 
tries to always allocate the lowest possible memory to make sure that it 
fits into the DMA constrains of all devices in the system.

But since AMD GPU can handle 40bits of addresses you would need at least 
1TB of memory in the system to trigger that (or a NUMA where some system 
is low and some in a high area).

Christian.

>> The only quick workaround I can see is to avoid firefox, chrome for
>> example is reported to work perfectly fine.
> Or use an unaffected GPU/driver ;-)
>
> Cheers,
>
> 	Jean-Marc
>
