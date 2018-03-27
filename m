Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeC0Jl0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:41:26 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:47952
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750970AbeC0JlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:41:24 -0400
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH]_mm/list=5flru:_replace_sp?=
 =?UTF-8?Q?inlock_with_RCU_in_=5f=5flist=5flru=5fcount=5fone?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>
References: <1522137544-27496-1-git-send-email-lirongqing@baidu.com>
 <20180327081546.GZ5652@dhcp22.suse.cz>
 <20180327090841.ujscbnb54cepencf@esperanza>
 <2AD939572F25A448A3AE3CAEA61328C23750D637@BC-MAIL-M28.internal.baidu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f384fb51-22e6-ddd8-b957-4f358fe1e03a@virtuozzo.com>
Date: Tue, 27 Mar 2018 12:41:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C23750D637@BC-MAIL-M28.internal.baidu.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::24)
 To AM5PR0801MB1332.eurprd08.prod.outlook.com (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24cb2982-4ec3-4662-0347-08d593c6e57b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:vMMqo/droDaibKXCB70p7h06aBtNpXWKdYYSj/kAxkiC9oJvzpYyQf1jGHrZyAxNTO585EMzS7RhDsH1D7XX4HvDBZp4do1D3R4uouqDlUSuvVsCMRic3NLDtQX/rS3bDHd9L743HAbhOTERo4x5njoqFxEBtyr7Yqa6B1TGIa3KyU9lGPvyxOoP989eEJHmlN2RseSL9L8kqDXbZ+T2ymc+u2BlUH/3P937gvzHCvH9tDLjT5DZNhSQIAUEaDin;25:oYUSjCd3pWNjAncD7IboZ3di8NiEk+Ny3N8roN4PcEg9b6hTBl6Ar5qtrIbea4aFm+D61bb9L0mSn73rB+1+OTAinIpFsfGb7K92lUy+1lzFvamUoIWcAmHC2qTE377KG0Pf98+ziQpG81lm4+g+8Rdd50hvtsiOtuqQh6iPIV5UPijp+aiM4R2IollqFyuaua0D3OC5dUsfud7FW3jqpR03jTdGvr7gD++iV9j/UdTlTC7/SUNnET2Oom/X3SKEFSrHZv+oqZzp6GnrbDGI1AzhC+kiTE/P4smxYUPcrvKK6I6d0n/KtCiCJzdxH3xe1vEIoRZp8UT1RwdUcFMUIQ==;31:lDwazVix0yMXQvhRufPpsDg+k+y9vIvH+CYqJNGA2VkTX0Ad7s0kQGQ/8VdmXjwvw/rskF9D15E6GKm8cgSWVx850G29POvlhELFbofuexz9ynWanZU/4vTd1VW170EL0XeaflyCX1hOTWOB1MtGstSIBWEJhINmzC6DlHuUbqkOw83jhrf/tnjz79SMWQCJoiF7zTkrOeda0qpuEgyzHQNwDMtGEnvQ/dqjlncDCW8=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:+7dBnxbCnZu/ge8M018MU0PFv6D3GccDf5JwXVGCTEeDdl5mtdj4mve6o2J3H9pDnxRrX8tmSJUcRz6iJMhJAxwNrUEebBN47Zx45FuSCadblqch9Ow7anS91QOJ3ScTrUQ0kG2PmMsQ3/shdEwNiulFR15SeNR7UvQh0AeeIRmlqEwPSzVN7kAxqXSGdMr8n6AIrIMVASqF5cxb4zWKAQciO9KE1++MAD05ambTYYsB+db6ho4HtXbYNP1LAZAWLqCnwmW2IJcE35wD1cCjte3m1drZNUXQ0IQxcRoWl/KBTSH0stjMxHlIUKNW05Q8qdwrCtdDk1MM0yKc6RRU0fDPB2lBNGpkQnZIvPDgwv2MIz8u83FFstxqExbm7nKYvVx/9/rZkiwkeodZgoRLRSZeyijDk35cFGVoEfvB9vi2/jgr5aruhF/Uhwsh4V9CoMadLKnIorknBoFoegB+9BllHwLE9kBD9/ai7cHioTUsMOPWArFqFpMO5TgbaQGr
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13329EEF443695AF4C1E12E6CDAC0@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(230824228335337)(9452136761055)(85827821059158)(788757137089)(210246017326159)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;4:zgA38T6MXBXKAe8+9j0euhWBBMoA7iu5QHOitoiUS/TkF/JAkNJ93w1zrKDaL2OZeFyI94GaObj7k2wdWg/76md4CQDjxRrq4T0VFW+vJIWCQeFLRpP5x5wo5MmlTaskhqvP6wbpma3NslfRFFEozHrM0e3rKQXYZLaafRPqMTR0AEVHAHd9nazXCs8E2L0QKXk2lxaWoJR/4s4qlGUZHVuh1J87gfvNvVHwsPlGnHxLwYxL08AD0QhiqpnkrBebvbKWRKn7D/j3ljLE+l3YFBsNAhjDNf4nx8HoolWkNkPiea8Oj6pJzHb0Qd6QzhiDW74YVa9CW6Vb2RJW9MmjklQi441xv1f4jC3XHH+11V9dInxN6wnA4aLNjViHcWNPjuaOAvQewMb9nqFo8J8N09592pTPy4UKfGzPkv16NSCmoHdgwRAI5x5d/iMJN9fVSXAspKl4Fv/Ew/Zo8bquD12b9D6NRRA833mQXQ63AVQ=
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39380400002)(366004)(39850400004)(376002)(199004)(189003)(377424004)(25786009)(6246003)(52116002)(55236004)(93886005)(53546011)(11346002)(97736004)(386003)(53936002)(6346003)(2906002)(31696002)(26005)(59450400001)(54906003)(81166006)(81156014)(7736002)(106356001)(23696002)(64126003)(305945005)(5660300001)(224303003)(110136005)(58126008)(478600001)(68736007)(39060400002)(16576012)(65826007)(2870700001)(65956001)(76176011)(47776003)(65806001)(66066001)(36756003)(966005)(31686004)(446003)(316002)(105586002)(8936002)(6306002)(6486002)(186003)(2616005)(956004)(16526019)(229853002)(77096007)(50466002)(6666003)(476003)(6116002)(86362001)(486005)(3846002)(486005)(4326008)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?gb2312?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6TWczU2NlZXJjUSt2YWdJSGJzZFlxMkto?=
 =?gb2312?B?NXNiS0xLaXR5OWIzY0E1d2tQdS81TzJTdkRtRWtaMVZjVWJTVXFsSnRRQlIw?=
 =?gb2312?B?YXVNUnliS0R4ekhBemorMmtQeGtUeFFqUGhkWTB2TnUzQ3A0UW9PWUx3Y3lw?=
 =?gb2312?B?RjNCSXdMY01XYzd3czVzREtoQ1dVM1drUWdpVDFweVJyVkg2VjRuRVYwMk9H?=
 =?gb2312?B?SjhQVWE5T0M5eE4rRUEyRldWaVBLdmdpZmhwZG1BTEdOL2VWN1ZWTXlpd1o3?=
 =?gb2312?B?ei9CK2dNQVBVVlhjV1FVcmRhTGJGNW45SkR3dktSY2grTUZpVVpROGNTNUpr?=
 =?gb2312?B?ZmxKV2RCYklGTEtXR3EyU1VkSGUzQmQ4OXpYalZ2QU9SS1lVak5Ua1ZacFdT?=
 =?gb2312?B?NWRzUGpCdm1rVE41ZzlEWlB1MDNJbTlHcUhDVjA2dWc0akE0N0JwY2FGV1Yx?=
 =?gb2312?B?OUtRRUNFS2FablRYRHY1TUZOMzV1cUtNYmJGU2dBYStsOERyTkhuV2xVVUZ2?=
 =?gb2312?B?dnZQZzg5cnZkdjlqQllkbEkwMy9NSDRhZmplT0tWVnZmelNxeUN4VUMvWGhv?=
 =?gb2312?B?WFk3MitGOFZYUjF0Zjh2aTlxb3hvckIzUU9jZ09ORVk1Q1ZLWnJHOUVGZ1VI?=
 =?gb2312?B?Vnd1UjRBYmFmejFxYmpSaHJqMnpCeTV2bjA2MS9UOFVtNW40OTJZNEw0WHli?=
 =?gb2312?B?bFY1d1QvNDR6dGc3VGJ3SVgwdmFOSjhUeU1vZWZSaDZyZDQ4R3RPY1BZT2Fa?=
 =?gb2312?B?ckhlekVDMnhnOStHaEtwczdYdG41VitRdmw4a1N4TFovRTVLd0l6QkFKd0lq?=
 =?gb2312?B?eTNybmNna3hRRjFDY000Q01Pdm5iREJGVzNNdktWM3pwN2kzZEt2elRyOWdV?=
 =?gb2312?B?MHpyQnVSc3ZSbC9jaGZuRk10Q1VjQ0VGK2dhQlI5WTd6RFpNVlM1ZHBhTWFE?=
 =?gb2312?B?OUVFYnZsZ2FPTFNzRTB1N0x2ZjY1MkE3TlE5bmtQMU83QUJWekliRVZhUngz?=
 =?gb2312?B?aytJWXhBNVZFSUtHTzV4SjFGNldKUSs5KzhPNHdYaFpvQ1JIa1kvbVNrM1Vv?=
 =?gb2312?B?cVVyWHlBckRjWG5HVFQ5VVpwbC9ybU54S3pGZVRNZys0aHVmUk94OEJ5cEYr?=
 =?gb2312?B?YXBtYXNDMG1rYVFHVkVhaEI4ZXhhQzJpRGZrSXNMcEVEd2JFR29vNGsrTlJM?=
 =?gb2312?B?MEFTRFo0RXB0RjIyZXVGc1U0eEtGVE4weGNRT2VsNDdIRkp4d3ZOaDlEOW5S?=
 =?gb2312?B?VUxVdFdGNVZiRU5nbi9CdjQ0cDlPbzRrNmM1SGMyMjJmMGZUNUZtczdDOFJ4?=
 =?gb2312?B?QkZ1QmJYU0RTaFE3TzcxRGZnNFF6cEZpNWhjWWtNWVFJWnI4dUtGMnhEb2dl?=
 =?gb2312?B?Qm0wZzJmMUppYm16L2l4Q3VocXo4VlNtT21JM05jQXRJQ1drUUFuRmhidkYy?=
 =?gb2312?B?UnM1RDRrdXRSVXlRbWZMY1BSMUoxQngyZFFqd21YMXJuMFB2akNBdXVXYUJh?=
 =?gb2312?B?SmMwT3FWU0hqZktVVityTGZSNGVJSEgvOFZ0amRlWTdzeUhjV2xEN3NTeGVT?=
 =?gb2312?B?enk4elJTajZGQzNnelMwMmpUTDE2TzM2RkNPQUJQdVFFdElzTThCYmxkdkxN?=
 =?gb2312?B?LytyR0xhbGtqOGNuQ05NTk9YSDVwd3dzVm9vemlDNm8yUWVmWnJzSGtFeW0z?=
 =?gb2312?B?aW05TzBkTGZmVzByUkFGSWtGMjFXWng0QXdiS296ek5Yem1hdXZNa09GcEhZ?=
 =?gb2312?B?VEYvSVpXQWJKRzdhTFh6akJPbEgwMXd3UHVpMkFKM3EzS05JSk9Ic3FHaFFT?=
 =?gb2312?B?OHphZGJES3ZKQzZ2bFhQaE5wdnAvUHpzZmVENDk4SzNwRDZXNWNhcExNZ2xZ?=
 =?gb2312?B?SWh3S3crcGpiRVdSUXdSK1k2MGsyd3ZKcjR1RmVYUWNabEpSekhZZGcxbE5x?=
 =?gb2312?B?MTd1MTdiVXh4OVp4Q3R4WGlYckRuYlpMZ0tOMkdEeituT2lvVzZwLzZ5dGNG?=
 =?gb2312?B?THpIZlNFWmptbkVhajAzZ1NWVGRYM09kZXZTeHBRckEva01XbkdTMHQxODg4?=
 =?gb2312?B?RmlNQ1crNFdIeE1pVlk3M0pGOTJsMHpuWEtCem1vMWRNdjRITDdFbkdpNWd0?=
 =?gb2312?B?N0F5ZjdVbVN3MExzcHgyVXFIMjU1OEsrTmtxN2VkVlpoOXNPTm9obXNTR09z?=
 =?gb2312?B?NGgrb2w2bGZaYUIvL2J3ZFpRS3ZWdlE9PQ==?=
X-Microsoft-Antispam-Message-Info: SYJ/VA5OAyYYSQPOlaOvkLbcrPDS8Cx9XHReTbLLAD6Y9bbrasuy8WzMc4ZRo5snytkJb917bCCkqntTKmzWtHBoLXBYgTjckj1rTd33XxK16TsL+mawZ5oKrqk5wzHb4u1/Z7Jrg1GF+PKaWBOKwOR76EMIafuFQchC3um9mHdCOxEeu76dFopzirghQsfb
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:ZBDSUXicSC15dn7MvQamrtEZoe1BS457SHytyIdM7CsOq2h8pL6OttN4NEkiHBoKtqMMnaajALhsvVqSJ8qRFEc0pBn1gkBEM8SA4QanWiDXpbi3jNeITBvQ8FO6tyl8JU9Bw0elmIB9TvZwDjBXxO0/dd4d6NYKdp0nWwKlYui4E08qhX+j2lYcKvx6m6JOYv5kiWFAKPlYWP3Zv+YnyVjv+uJ+8pAfBb0d8abUjDBlAqyrKunavjWofKzWgCoicxxQxwcKcVlGkNXFhQC32qP21qWufmDmdF+lfhnA1vsoLANdtTaY+uwTrhk8Nfhv93ASlRKV6VZ8pcR6MPal3JCBObCTBb2EVbzhBxb4gWZkjK3OFQXClNL6KPJJ40shmU0+wzjq/db3VCmHoWBTMrp8+hlqODQz8wO9pnVdulJq/RiAHNVKnp5p43rJvs+wLv1pqwPVyYVwa8k0L2Gq5A==;5:LW2QeRhp7E6ajYEmXOWmEm7UDwbUlLFZRac8JZOlsG/qCBL4TmJgJekDWHcoQXyx1ygBE3weqrSycA9lt9P37lOgoy+NzuNJKLNn/7T143xvG39Vs5qjACCBSZcgrBzjwpI2Z6XDXsdz128cukdNmLUCbR/HjT2V5UQjQjMtT0U=;24:bGKrGol8p6gck7AHl95EQabNqEE+RynfvWa5qKVq/CV1JAOeQLynBpCqJc3Ru56pBqdf3CQVkN8bMSRpRsXEJNGIOu7arK/2ZFX73l9rsl8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:pZ66dWynbFzBfHHpZ+kSjkhapx8ZAoTe1tiAmxZwmZlYv7lJ+oARYznF+xZ+qg3JcfesRmO68lBY9hVqS8h6PTZXm/1c2h6+0i7venJ0AeamI3IgRnM/wggHTBvUhTTksBu+Xk1z567UXjgJjoZh1GmoQfXyEuSo5RtBJpQj2j94BPLt/Oakof4ZkELHWbAw+zDMXmIC9Clnu1+tW8ek+2vcGgDWRujESkO5+HSwEB+ESYcRmzOYU4lrAyz5MaND;20:vVl9rf+rah7v3ve0MKztLkZkAufbbhwi/+Wax5syK9j6MCOiuJ9V9Uy4xAZiheP/XQ54c5DDoLQGlBDR1KIguN0mcAz0NuNq5r4WvdYX4/g9pTY0X7xs+VpCNzsXtoBmSLCIY5kIqJUitLTio3zRtIbFXJ5pf3BKsjFdo6ZlGVM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 09:41:19.8648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb2982-4ec3-4662-0347-08d593c6e57b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 12:30, Li,Rongqing wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: Vladimir Davydov [mailto:vdavydov.dev@gmail.com]
>> 发送时间: 2018年3月27日 17:09
>> 收件人: Michal Hocko <mhocko@kernel.org>
>> 抄送: Li,Rongqing <lirongqing@baidu.com>; linux-kernel@vger.kernel.org;
>> linux-mm@kvack.org; Andrew Morton <akpm@linux-foundation.org>;
>> Johannes Weiner <hannes@cmpxchg.org>; Dave Chinner
>> <david@fromorbit.com>; Kirill Tkhai <ktkhai@virtuozzo.com>
>> 主题: Re: [PATCH] mm/list_lru: replace spinlock with RCU in
>> __list_lru_count_one
>>
>> [Cc Kirill]
>>
>> AFAIU this has already been fixed in exactly the same fashion by Kirill
>> (mmotm commit 8e7d1201ec71 "mm: make counting of
>> list_lru_one::nr_items lockless"). Kirill is working on further optimizations
>> right now, see
>>
>>
> 
> Ok, thanks

Thanks Vladimir, for CCing me.

Rong, if your are interested I may start to add you to CC on further iterations
of https://marc.info/?i=152163840790.21546.980703278415599202.stgit%40localhost.localdomain
since there are many people which meet such the problem.

Kirill

> 
>> https://lkml.kernel.org/r/152163840790.21546.980703278415599202.stgit
>> @localhost.localdomain
>>
>> On Tue, Mar 27, 2018 at 10:15:46AM +0200, Michal Hocko wrote:
>>> [CC Dave]
>>>
>>> On Tue 27-03-18 15:59:04, Li RongQing wrote:
>>>> when reclaim memory, shink_slab will take lots of time even if no
>>>> memory is reclaimed, since list_lru_count_one called by it needs to
>>>> take a spinlock
>>>>
>>>> try to optimize it by replacing spinlock with RCU in
>>>> __list_lru_count_one
>>>
>>> Isn't the RCU overkill here? Why cannot we simply do an optimistic
>>> lockless check for nr_items? It would be racy but does it actually
>>> matter? We should be able to tolerate occasional 0 to non-zero and
>>> vice versa transitions AFAICS.
>>>
>>>>
>>>>     $dd if=aaa  of=bbb  bs=1k count=3886080
>>>>     $rm -f bbb
>>>>     $time echo
>> 100000000 >/cgroup/memory/test/memory.limit_in_bytes
>>>>
>>>> Before: 0m0.415s ===> after: 0m0.395s
>>>>
>>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>>> ---
>>>>  include/linux/list_lru.h |  2 ++
>>>>  mm/list_lru.c            | 69
>> ++++++++++++++++++++++++++++++++++--------------
>>>>  2 files changed, 51 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
>>>> index bb8129a3474d..ae472538038e 100644
>>>> --- a/include/linux/list_lru.h
>>>> +++ b/include/linux/list_lru.h
>>>> @@ -29,6 +29,7 @@ struct list_lru_one {
>>>>  	struct list_head	list;
>>>>  	/* may become negative during memcg reparenting */
>>>>  	long			nr_items;
>>>> +	struct rcu_head		rcu;
>>>>  };
>>>>
>>>>  struct list_lru_memcg {
>>>> @@ -46,6 +47,7 @@ struct list_lru_node {
>>>>  	struct list_lru_memcg	*memcg_lrus;
>>>>  #endif
>>>>  	long nr_items;
>>>> +	struct rcu_head		rcu;
>>>>  } ____cacheline_aligned_in_smp;
>>>>
>>>>  struct list_lru {
>>>> diff --git a/mm/list_lru.c b/mm/list_lru.c index
>>>> fd41e969ede5..4c58ed861729 100644
>>>> --- a/mm/list_lru.c
>>>> +++ b/mm/list_lru.c
>>>> @@ -52,13 +52,13 @@ static inline bool list_lru_memcg_aware(struct
>>>> list_lru *lru)  static inline struct list_lru_one *
>>>> list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)  {
>>>> -	/*
>>>> -	 * The lock protects the array of per cgroup lists from relocation
>>>> -	 * (see memcg_update_list_lru_node).
>>>> -	 */
>>>> -	lockdep_assert_held(&nlru->lock);
>>>> -	if (nlru->memcg_lrus && idx >= 0)
>>>> -		return nlru->memcg_lrus->lru[idx];
>>>> +	struct list_lru_memcg *tmp;
>>>> +
>>>> +	WARN_ON_ONCE(!rcu_read_lock_held());
>>>> +
>>>> +	tmp = rcu_dereference(nlru->memcg_lrus);
>>>> +	if (tmp && idx >= 0)
>>>> +		return rcu_dereference(tmp->lru[idx]);
>>>>
>>>>  	return &nlru->lru;
>>>>  }
>>>> @@ -113,14 +113,17 @@ bool list_lru_add(struct list_lru *lru, struct
>> list_head *item)
>>>>  	struct list_lru_one *l;
>>>>
>>>>  	spin_lock(&nlru->lock);
>>>> +	rcu_read_lock();
>>>>  	if (list_empty(item)) {
>>>>  		l = list_lru_from_kmem(nlru, item);
>>>>  		list_add_tail(item, &l->list);
>>>>  		l->nr_items++;
>>>>  		nlru->nr_items++;
>>>> +		rcu_read_unlock();
>>>>  		spin_unlock(&nlru->lock);
>>>>  		return true;
>>>>  	}
>>>> +	rcu_read_unlock();
>>>>  	spin_unlock(&nlru->lock);
>>>>  	return false;
>>>>  }
>>>> @@ -133,14 +136,17 @@ bool list_lru_del(struct list_lru *lru, struct
>> list_head *item)
>>>>  	struct list_lru_one *l;
>>>>
>>>>  	spin_lock(&nlru->lock);
>>>> +	rcu_read_lock();
>>>>  	if (!list_empty(item)) {
>>>>  		l = list_lru_from_kmem(nlru, item);
>>>>  		list_del_init(item);
>>>>  		l->nr_items--;
>>>>  		nlru->nr_items--;
>>>> +		rcu_read_unlock();
>>>>  		spin_unlock(&nlru->lock);
>>>>  		return true;
>>>>  	}
>>>> +	rcu_read_unlock();
>>>>  	spin_unlock(&nlru->lock);
>>>>  	return false;
>>>>  }
>>>> @@ -166,12 +172,13 @@ static unsigned long
>>>> __list_lru_count_one(struct list_lru *lru,  {
>>>>  	struct list_lru_node *nlru = &lru->node[nid];
>>>>  	struct list_lru_one *l;
>>>> -	unsigned long count;
>>>> +	unsigned long count = 0;
>>>>
>>>> -	spin_lock(&nlru->lock);
>>>> +	rcu_read_lock();
>>>>  	l = list_lru_from_memcg_idx(nlru, memcg_idx);
>>>> -	count = l->nr_items;
>>>> -	spin_unlock(&nlru->lock);
>>>> +	if (l)
>>>> +		count = l->nr_items;
>>>> +	rcu_read_unlock();
>>>>
>>>>  	return count;
>>>>  }
>>>> @@ -204,6 +211,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid,
>> int memcg_idx,
>>>>  	unsigned long isolated = 0;
>>>>
>>>>  	spin_lock(&nlru->lock);
>>>> +	rcu_read_lock();
>>>>  	l = list_lru_from_memcg_idx(nlru, memcg_idx);
>>>>  restart:
>>>>  	list_for_each_safe(item, n, &l->list) { @@ -250,6 +258,7 @@
>>>> __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
>>>>  		}
>>>>  	}
>>>>
>>>> +	rcu_read_unlock();
>>>>  	spin_unlock(&nlru->lock);
>>>>  	return isolated;
>>>>  }
>>>> @@ -296,9 +305,14 @@ static void
>> __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
>>>>  					  int begin, int end)
>>>>  {
>>>>  	int i;
>>>> +	struct list_lru_one *tmp;
>>>>
>>>> -	for (i = begin; i < end; i++)
>>>> -		kfree(memcg_lrus->lru[i]);
>>>> +	for (i = begin; i < end; i++) {
>>>> +		tmp = memcg_lrus->lru[i];
>>>> +		rcu_assign_pointer(memcg_lrus->lru[i], NULL);
>>>> +		if (tmp)
>>>> +			kfree_rcu(tmp, rcu);
>>>> +	}
>>>>  }
>>>>
>>>>  static int __memcg_init_list_lru_node(struct list_lru_memcg
>>>> *memcg_lrus, @@ -314,7 +328,7 @@ static int
>> __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
>>>>  			goto fail;
>>>>
>>>>  		init_one_lru(l);
>>>> -		memcg_lrus->lru[i] = l;
>>>> +		rcu_assign_pointer(memcg_lrus->lru[i], l);
>>>>  	}
>>>>  	return 0;
>>>>  fail:
>>>> @@ -325,25 +339,37 @@ static int __memcg_init_list_lru_node(struct
>>>> list_lru_memcg *memcg_lrus,  static int
>>>> memcg_init_list_lru_node(struct list_lru_node *nlru)  {
>>>>  	int size = memcg_nr_cache_ids;
>>>> +	struct list_lru_memcg *tmp;
>>>>
>>>> -	nlru->memcg_lrus = kvmalloc(size * sizeof(void *), GFP_KERNEL);
>>>> -	if (!nlru->memcg_lrus)
>>>> +	tmp = kvmalloc(size * sizeof(void *), GFP_KERNEL);
>>>> +	if (!tmp)
>>>>  		return -ENOMEM;
>>>>
>>>> -	if (__memcg_init_list_lru_node(nlru->memcg_lrus, 0, size)) {
>>>> -		kvfree(nlru->memcg_lrus);
>>>> +	if (__memcg_init_list_lru_node(tmp, 0, size)) {
>>>> +		kvfree(tmp);
>>>>  		return -ENOMEM;
>>>>  	}
>>>>
>>>> +	rcu_assign_pointer(nlru->memcg_lrus, tmp);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>
>>>> -static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>>>> +static void memcg_destroy_list_lru_node_rcu(struct rcu_head *rcu)
>>>>  {
>>>> +	struct list_lru_node *nlru;
>>>> +
>>>> +	nlru = container_of(rcu, struct list_lru_node, rcu);
>>>> +
>>>>  	__memcg_destroy_list_lru_node(nlru->memcg_lrus, 0,
>> memcg_nr_cache_ids);
>>>>  	kvfree(nlru->memcg_lrus);
>>>>  }
>>>>
>>>> +static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>>>> +{
>>>> +	call_rcu(&nlru->rcu, memcg_destroy_list_lru_node_rcu); }
>>>> +
>>>>  static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>>>>  				      int old_size, int new_size)  { @@ -371,9
>> +397,10 @@
>>>> static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>>>>  	 * we have to use IRQ-safe primitives here to avoid deadlock.
>>>>  	 */
>>>>  	spin_lock_irq(&nlru->lock);
>>>> -	nlru->memcg_lrus = new;
>>>> +	rcu_assign_pointer(nlru->memcg_lrus, new);
>>>>  	spin_unlock_irq(&nlru->lock);
>>>>
>>>> +	synchronize_rcu();
>>>>  	kvfree(old);
>>>>  	return 0;
>>>>  }
>>>> @@ -487,6 +514,7 @@ static void memcg_drain_list_lru_node(struct
>> list_lru_node *nlru,
>>>>  	 * we have to use IRQ-safe primitives here to avoid deadlock.
>>>>  	 */
>>>>  	spin_lock_irq(&nlru->lock);
>>>> +	rcu_read_lock();
>>>>
>>>>  	src = list_lru_from_memcg_idx(nlru, src_idx);
>>>>  	dst = list_lru_from_memcg_idx(nlru, dst_idx); @@ -495,6 +523,7
>> @@
>>>> static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
>>>>  	dst->nr_items += src->nr_items;
>>>>  	src->nr_items = 0;
>>>>
>>>> +	rcu_read_unlock();
>>>>  	spin_unlock_irq(&nlru->lock);
>>>>  }
>>>>
>>>> --
>>>> 2.11.0
>>>
>>> --
>>> Michal Hocko
>>> SUSE Labs
>>>
