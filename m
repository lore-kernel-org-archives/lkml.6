Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeBSOmE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:42:04 -0500
Received: from mail-he1eur01on0100.outbound.protection.outlook.com ([104.47.0.100]:44672
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751429AbeBSOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:42:02 -0500
Subject: Re: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
To: Jon Maloy <jon.maloy@ericsson.com>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>,
        David Miller <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "roman.kapl@sysgo.com" <roman.kapl@sysgo.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>
References: <001a1143e44e58485f05655fa8ae@google.com>
 <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
 <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com>
 <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <cdfcb6f4-f2db-b710-1b6d-cf15b022c2d3@virtuozzo.com>
Date: Mon, 19 Feb 2018 17:41:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0072.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::43) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d932cd2f-931b-4c11-4f0c-08d577a6ed75
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:R9zmWYqF2RXYEN5XpXSKuLYG/ZZpHEYVQPftJV7vIus3LqHjsu1qbDIJ2aemH0UAImlUu0v8ZFd04dlKdRCk7A0kUdjTGV9vTvXUSqbU129os3JSYnxZb8RE8G6LCIcRQGUBuhkHw/8EzKFnk57OrgN5feW7djHwvv0RxPgIQ42nDVCtz3Hc3kz1gfOVaeboYVEm4gcXUdzPSUZtb4pkiWAzjO/R6we1SVc8sb3GWFfXAT4AgN6eRJTTNrI+yRF3;25:04GWhi/gJs6hFPbivJQdli8K9FxjJOd8ZijW7y2u9LyvYlG+6RAhQWKbIRbk0bPPIrScchAHaxxwORXVgVGyvupG5DSH7Z5c+ktJv1gyue6v3KNzIB1RHudDti5e8jv2YZ694BSqCYJt5jpfZFVdB2f608AALlpEK7yY+EEEPoooPYpb7UoZvHrF+YZy8GAVzYjc3zMcBstuo4s2KT8nGaW3/xfHgx2YSEzbLFixBMnATpA1M7Lc/QX54djWpSBcWLgDYeBGkxcTeAOEndzTpYWcxRnQoU1Er6p1L316/ZNP1ZuIlNKotbhNzrUkn66aP8kv/pzcao/DVlGtfSgETA==;31:6GcRPtqE00bgFnWA0r5Z5WaGp7Ao3KqhoO7tqm/b/9RJXNL1rXg7bXjl7UssUvRKEXMqOGNSC9eKKbDLxm/xiwdVoPjXmbmh9GWkhsHPaAxm/y5goolLPzYUr7QzglzEmfIhdGPpkljeMW+OJGR+8rbWoPEnssNvHapNhUGxUQ6V/CV93lwcCpO1yzI/BpyTE2OuDoOPGvSlzILOD3+R/3nI9tff1e5oMehh59hiUoU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:BjLRuphUKvDXOa0B/zdOz85Eh/d7HQQ9H0vpD2p3dWMDOA7ZTXh/79j6HiOXFtcB7ckjCWk8nHLUudIV3vauuhGrY2uGpjEqSqbl/ZrgxE5ims4n3RkMNxQdk4TozsCg6QUVtrpVHaSmzstqb2oYeTTpCLD8xU1qfNlA01KW8u6192mEshHkQvJ9P5LayjSWWSHSEL6xKJFWNq7KA7HBfgIdQI4WSj43gGRoBjMMH+Bexv29nSsq8z6va8bEIrTG97AVfNzVEDu0YhfgYoAt04pDUdUDOCTt9CXASy4uLd8SBrSGlyH+8IEVPyeD2E3MOcDN77ytZEf25ThKztSRgKoE4nfwbXAaxVYOGXBVd8NJnVEuzuCZVFs56csS0Z8Z8bhFrKaiQyUQ+dFoAHBNTnCVsG5gcqdo/NWKZWdtavhC8x5fEM5cIfKkfMqBq0g4z6KEYIqhLnTL3eYgF8lCzIjDhdMAjScBngEq1fSA6ZwckgJ4ICRuaJB/5O1rf4p2
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13393DE0BD0C184261371BB0CDC80@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(37575265505322)(143289334528602)(215639381216008)(158342451672863)(9452136761055)(211936372134217)(42262312472803)(153496737603132)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;4:exqDGwj8WXP77tv/qmxQH3jFt51QXD/PtpsTQ+z+bR0kKELj/oyjoKzwEChxz/i2U2+2/ZabUm3NpeeKL4qFGTHX8m68opf5T4geX62ynGh0K/XLSFz8Kxi3JxFk5bnkSGlpik9GMxl7SF7LaZYitlkGiEle/z7BAvGu+3OXdyO8UqdE0Pab7E+nYR/Ylg8Y7Eua95+NUBRJ6BghBJChNk7GMPF6EGO2pk8k+3oVOP6kfqYl3Kknb7Mjuhty9djoxQo0h83ozh/Q20AJsk51lQsbG1kCA6aR6/YzJEYx3SnbgJVBzUJ+Br+3mvWjwlQfHcQNnUCiXbImp0QL/JnmMKWScK+n5iIDXcJLTYZB3WMpYjfCCfLxI1sNHd6DWHzNZbZuo6qe46/Ng79w7V/a49+m2cnqkJcl59SU6lsqqtdsy0FycKKbfyqVloUQc4CxZsWBJS/vlojvbtJZueRHEzRjYPqWRGZtwVFC9i/AgOxan2bAAaSwzRUrAf4VBuo5oe2KunyHsg463Ikel7cNMKyJntGcrl20af2ck/oVACP2zYvOSWCOtrBcxfFEhD9W7nmpEaw0Cg1Kcv0TeZPBRQ==
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39840400004)(346002)(366004)(376002)(39380400002)(13464003)(199004)(189003)(106356001)(97736004)(5660300001)(2950100002)(81166006)(25786009)(305945005)(53546011)(7736002)(64126003)(386003)(31686004)(4326008)(50466002)(93886005)(7416002)(55236004)(8936002)(68736007)(6116002)(66066001)(3846002)(65956001)(65806001)(47776003)(229853002)(81156014)(65826007)(105586002)(8676002)(2906002)(110136005)(16576012)(316002)(36756003)(58126008)(54906003)(53936002)(86362001)(31696002)(16526019)(230700001)(478600001)(76176011)(2486003)(52146003)(6486002)(52116002)(77096007)(83506002)(23676004)(186003)(26005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6dmRjb3BPSXdtRkJTQ09kQ01raUVNajlY?=
 =?utf-8?B?MUdORzRZeTFtNXF4YWN0ODk1Mm5PVDFiRVlKUjViZlNEOHhXQTRYS3AyNkRN?=
 =?utf-8?B?K2RwV3VOUlpoS3VXRVVOOXB4cUtlTGc2QmFjLzU3YllrR0tGZEJTQ1FtMXlZ?=
 =?utf-8?B?akViY25XY2V1SlFaUS83OVczNmtZQnkxaUgxTEREYllIQ1JaQWRHM2Jtb3Nn?=
 =?utf-8?B?a0RndEVhYm40UHNrZ1dJY3JpbUM1TDdJNWVhUTFHYjhpdERnNnlsQkRoRDJR?=
 =?utf-8?B?ZzJNWTJqeTBaRGxkdnZJMU9hRjFxSWFac1RZSXFRQjg0dTBaakQrdVJnV2Uz?=
 =?utf-8?B?eVQ5SGUwZXJra2oySmh2ZjhMNVA1Nm56NkdvcGdZWGF2dHl2Tk43UHdmL0dD?=
 =?utf-8?B?aVJHbUJHUFBiY2hFR3hVNHhBWUJublhKNzhzcHlCbkp5d1hUQ2Rjbm43UmVE?=
 =?utf-8?B?VWlVc01KdzBTRUJwN0JCc0p0NldtRndxR0dmZWhObmtRNDNjVVJ1NXpZNXZi?=
 =?utf-8?B?aTFpVTB4RW96d2puWFRDL2JDS1k2YUI2c0x1TlVSWU9KNTI0dFJQT2JkRU83?=
 =?utf-8?B?c0o1cElON0tFOWJaVUcxaitkRTlsZzkvakplOEd3bmQ1U0JzQ3g3MlhyRkVO?=
 =?utf-8?B?L0gwNU9DUk1PS0w2M0xWMGV6eklzNE9lNHpXcFdTNFE2VUFnWVJpYWdQclFo?=
 =?utf-8?B?NjgrQ2RzcTQvSTNVaGxDY3RIc2JCSkFLM3BCYlcvOFAvU2F4L3ZERnJTeEM1?=
 =?utf-8?B?NlpqNHVqNnBWOFVRRHlkRXczNEI5b0hFVjdGU0o5WVhTY1VPak9ZeTFyb0tp?=
 =?utf-8?B?R1cwb1gycjRMb1dGS0cybG0rcGlOUlhqUVc2ZjJnSjdPVHFoSitjVk10OWJN?=
 =?utf-8?B?MDF6ODBUaFd6R0tCYXFqZTNnUnRWeHh0ME5UVVdQQ0d6Q2hLYjAyV3hQVzFa?=
 =?utf-8?B?VGN4Y0d3RTJ5WVBicVdxbXpldUtGQVQxVkNEUVAwUDBoTGxQaXpPZ1J6Vmcx?=
 =?utf-8?B?MSttV3FYMFZyeWFpTDY5bzdzVnFHSDlzdThIOVVtUlNXU3d3cEhnMDAyc2hI?=
 =?utf-8?B?RmFvem5WMU5MNEEwVXo2U2g2M0hTZXlSUWgvck92VGNhc0FTcXNIekRyOThz?=
 =?utf-8?B?ZXdJQnEwU2NxOVBwUlJiRzhnZ1hjNEpielFkaHpFNVJnUDA0NlJpSlJIYkdE?=
 =?utf-8?B?c0swMmdzalhwS0xibDNVa3ZaOHE0d2RNeGpFajdMakFmUjd5cUttRFJNYnc2?=
 =?utf-8?B?ZzNiYVhHYWk5YmZ3U05vZVNkeXJIQ2ROck54aWZFMldtM21xQko0MEorMklR?=
 =?utf-8?B?a1VNQ25XbHRGUGxncGpWMFlqcWh0anhKS09JdU01OS9mL2k2UmJRNTFGdmFU?=
 =?utf-8?B?MEduMUxXYTA4ZTUxTUpEenBRY0FoczF1Z3FPN3JpQ1E5UEZUSEY5elE3MjFI?=
 =?utf-8?B?eG5JUS92dUVWUXlnZDNZcE5DdWZPcFNaMWJJT1hXOGo2cURkNm14WjZPYjBT?=
 =?utf-8?B?QlVpRWlYblY2T1QrWTB3dE92TTBTOTEwN3R2NVlQUDBIZkpyeWFHV2lwMGtL?=
 =?utf-8?B?U2Y0UzBHbEJNazFhTmlIN05VT0JXb1ZYRlF3MkQ1RVI5RnNZV2FYMUFDcVRM?=
 =?utf-8?B?akhzOGlFT0tOYkhseEo3UldacDFvQzZRK0dnZGw0OHF4bnh0SE5SNTV0aWF4?=
 =?utf-8?B?L0Z2LzBHdXdSVEZ4eWdZK2MyTnNJdGtsbnNLOFRwbTNPbWEyQkVackgwRTFZ?=
 =?utf-8?B?UGRHdVBtcXU5Tm9sU0tlOW0zWUxVMCtpUC9NcGJCL1Y3VEtlaGgzUGM1Q3p3?=
 =?utf-8?B?cGNaWGVnVHBIYjB1YXAzOWpDTTluRHhaY2VCdTVKbjFvQnIxQ3dXNUorRXdj?=
 =?utf-8?B?eHRVRXZmNVdMSFo2UmRwbkdvMUdJUEVCNUJDNU9GWmN2b0FYb29WQ2JjcHVD?=
 =?utf-8?Q?MPD0q5EJ+VPegsOwl7vOi3a9yjqYCTps=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:t2hv1lfgZgATllu3O8ZJxNZcyjrB7yin6gY5TXeJrbb+uFR0VPqtZAkGphctCO2/Z/Nrhxzc+2cbSfzp63hbSnd+nhvWDjNpvNYPTZxbc78MKdAaMtTBq7sSGGrssdeXyJJp/aj4mvRb95qBedne1XrF8HMwhIZbE5wzMq5Ra1wMXia7hmU0OgGGDQELKKY5yWGhB/Xvdab8RnblG6Ko5JlZonFt+oYLDj8643cYqp6VgY7Ddpwlq3KHCHDXILW+FQl6qA3E2HmUEsx8WhbwMb3IclaBW1XVAR9UQOOCwGBs5ykei4WZygB1Mh5tZXEqS62V+hdYTLCXKw0ktnFR+dKhhP3zQ2pycJ2DNXGy53U=;5:0fOMW1uZL6lUOMfXDBnd0CMXx7g1yzovMjF0JfrSgkIH382BTIJB4HES8lBdAyWmg9SfflMHjb/kXEW3aGY9HHvJOQ77VdRPKuaXuKvFPVIo81D+w/sSRIj4ahffTrGLbqbWIfWF50yzUxX2nTpHkSmWjp9DEa1TWKf3aSUpyvE=;24:cOSJ0igQvF5uf4Mwgy91R0OEVR2CBE6Wrn3zHLufeYJHSwCslkjtWJYdzDCN5JG4kmQWMtQjvJlMR5uvCdeyqjF14p53AMRDJMMWZFXX6H8=;7:A8uQYh4wE/ymiC3PYJ4bEeN4TNGhnh9rtZRe4Bgs/sBVWP8zCTiSbgnNVs4IdzZtG9yDf6IyH8xseOfyOTcfkPZUkO+O55mZc62d6E6A6nplkD0NwXDCLEVOH/2lZV3fWT8TY6FwcJymQV7BwOV7r1KUT899dvIiGwr+eZWNIDaagiZNHPcpddlCzHeHhi/lTcrSHBF6AiSksXquUJ5UwPHpUhMdjzbxDpiGYUvXWmGH1lq93OY99HfrmShImpHY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:/mXh6NNWzZE3/OOkiYBu4QCX2TsDcNqBhyZQ4BDAnXD6guGDF5SZwVHfEE0bfZMp02Z27xdCtb3GGVfIWJ39MRVJJeTluOv+tjcrfWSBk8RX4IgMHRumYRNPhkDTdFw/xy9NIsc2fnGBYer1kjz37UlwoeRGsp0NplV1XjUsB2Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 14:41:56.9957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d932cd2f-931b-4c11-4f0c-08d577a6ed75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 16:23, Jon Maloy wrote:
> I don't understand this one. tipc_topsrv_stop() can only be trigged from a user doing rmmod(), and I double checked that this is running in user mode.
> How does the call chain you are reporting occur?
> 

In case of CONFIG_NET_NS=y, pernet_operations::exit() is called after last reference
to a net is dropped. So, this may happen not only on module unload path.

Kirill

> 
> 
>> -----Original Message-----
>> From: Kirill Tkhai [mailto:ktkhai@virtuozzo.com]
>> Sent: Saturday, February 17, 2018 23:23
>> To: Dmitry Vyukov <dvyukov@google.com>; syzbot
>> <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>; Jon Maloy
>> <jon.maloy@ericsson.com>; Ying Xue <ying.xue@windriver.com>
>> Cc: Andrei Vagin <avagin@virtuozzo.com>; David Miller
>> <davem@davemloft.net>; Eric W. Biederman <ebiederm@xmission.com>;
>> Florian Westphal <fw@strlen.de>; LKML <linux-kernel@vger.kernel.org>;
>> netdev <netdev@vger.kernel.org>; Nicolas Dichtel
>> <nicolas.dichtel@6wind.com>; roman.kapl@sysgo.com; syzkaller-
>> bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net
>> Subject: Re: BUG: sleeping function called from invalid context at
>> net/core/sock.c:LINE (3)
>>
>> On 17.02.2018 11:15, Dmitry Vyukov wrote:
>>> On Sat, Feb 17, 2018 at 4:00 AM, syzbot
>>> <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot hit the following crash on net-next commit
>>>> 65bd449c32c2745df61913ab54087e77f9d9b70d (Fri Feb 16 20:26:35 2018
>>>> +0000) Merge branch 'tipc-de-generealize-topology-server'
>>>
>>> +tipc maintainers
>>
>> This looks to be caused by commit 0ef897be12b8
>> "tipc: separate topology server listener socket from subcsriber sockets"
>>
>> Thanks,
>> Kirill
