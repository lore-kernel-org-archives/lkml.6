Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBTH4y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:56:54 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:26229
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751391AbeBTH4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:56:50 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com;
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: Dmitry Vyukov <dvyukov@google.com>, Xin Long <lucien.xin@gmail.com>
Cc: David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Streetman <ddstreet@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
References: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
 <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
 <7fd7e3b3-77b1-0936-b169-d08b946bedc7@iogearbox.net>
 <991243e2-e7c2-f2b2-72b9-d37b0d569b3b@gmail.com>
 <efa5811c-0a01-a4af-ade2-71ef5dbc4eaf@gmail.com>
 <CADvbK_dgEa5g0ynY4F8pX6LuuBwW4e42rK_TFuRhY1=2G5zinw@mail.gmail.com>
 <CADvbK_fKDbUnAkdLrgm6rgj895Gb06AK7HaT0s9VD=zdF+vf6Q@mail.gmail.com>
 <CACT4Y+aV_v6zNS6Ac1u1cB2GZ7QhjNxBeg0FNabUhrndt5CqZw@mail.gmail.com>
From: Tommi Rantala <tommi.t.rantala@nokia.com>
Message-ID: <5973966e-fcd9-7ee5-a9c4-b79d22c1b9dd@nokia.com>
Date: Tue, 20 Feb 2018 09:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aV_v6zNS6Ac1u1cB2GZ7QhjNxBeg0FNabUhrndt5CqZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.238.75.105]
X-ClientProxiedBy: DB6PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:4:29::16) To AM4PR07MB1314.eurprd07.prod.outlook.com
 (2a01:111:e400:59ec::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a394d0a-9019-47d7-74bf-08d578377d14
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:AM4PR07MB1314;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1314;3:EKUT3/x/Xvvt8L1A/iGTbu2fnmBPgl4ZHWOoTxt34IfVcT04RYro+kRAEpVE2w9NWtrLfOYz8vjTF9oOZa5IrSA/AiY0sZq19GWxmHunkYZXbdI4eO5SXrrZ2dEpr78+RIWruoQJgY+SBPEpdDcV6n/6Hyrxf8bWHfQ2NMHk3irh+6zEKMMDpquNZqn2xaqZGqBJtpSmE8hEsztNypy6nR+E2ZcZioD379c9hM62lRbpbDY0Z4EAv+48gfgWQM+h;25:Nhakv8id7uz7fPmDUJpqvgG7/HTT0MPNKueu4LadbIEENx1xnv3GGQ7Ub7wr2niXQkz7f9Tl/QmgIB41s1T4vpwiL5m/p8R8jV5dnu8I89fZH1PSyKNkoW+NvrXBFiZdbFnMCtUXsdfbBl0Wx4IeFOe8IYzcrYHG81h2iLHDDvpDua38AU1PT189V1BHxYcHiWzbx1psT6HNthfNvoiykxG6/H48/gjRXEPRf11GY9+RuxNx/c7dl56wNJSYchr5jIeD9SpkaeBNGJtsDAQWaj68MV/RigVKKJSFcbo84tdBKdOAVmVFFQbQOIFzMB+KPkFtFeG5YRyDDHPjiV0ijw==;31:sOTbxKaWMq93Ge12AUbml130cFvGI+HxNYf7WJM1fNl1Mhmpn00pdYebKq9ARxMXdjfXjew3pGILzmFh0u2b+6En+etIF/s1x6+hOcUXMlgqyKPMcs7PBnze5DEQ7cX0YvBwVUVZpNtZmay/SV3knNxTLZEqgc3Lt3emT0DFOxMq24Ybn2vPLBh9LsQAPary75qnEbuAk19wrMbSCE+1lDLei5pw0wIGX24fTHyPH7Q=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1314:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1314;20:dh9Mn1QNKkRVaMglB5TJVSd7mXGWsk8B8CD5vA2W8qYoR3rM8BX3zDkTEMJ03+pTtt6qpY7jjFV8w/EuXTjplqWi3BTNu0NfNY/qEE61my6SjGNLrlejqSUn8sCmWwNDcZGySTxffRvusxNbBZ/OAuqpUFW4PqI9U9cDxfHAD5CFJOnj8DDVmxbtlqfpGx0v6e4ZcpJwJZEgtblEeOxNpWU+xTmwgPB4dEnYuZznYUDDgYon5NP7bVtGG+ENXVJQ0+Kwp9JBAko0uZC2IkhOWNfpTy7ViW7Pr6X0td34Mzl3EwDJ476Wmw3PzvpA9Yg2U2TIDZRCOqDX2m+kBeXi9sKuBbbtjLS0PRT9lo+HlsSQhdSCWXnq7nDeBByiw9dvrjqBeR0fGmRRU8FwHxx74rNRxShKkWBGy3rtdpfsvezR259kr+fguHUbsYjy9tVLswCFP8AV4bwojJhL+7njrxIjMT5px5RspN2DYQWsigxMHB8BjwNYdO4+LN7pOQ0v
X-Microsoft-Antispam-PRVS: <AM4PR07MB131495ED8C43F96F47F80B32B4CF0@AM4PR07MB1314.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(85827821059158)(211936372134217)(153496737603132)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(806099)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR07MB1314;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1314;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1314;4:lGtz99ediCaoFPRTNhhLJyDCdyZ5Ehs+CdAYlX+h8tP4vqrEC9Y/w8acMNGL/ULAnlDYG+npHRhZq8iu8N+UtV36xvu9h2XoKr5l1ZyHqQeM8Ypxwg/DmTrverx0f1X8sfVbK9dfFSwH0Y72EZMm+BfW0X3j/aoCXOieTg2DdlrpXve9pk7q+SGBSS2JKYjkwHdqVF0xQOwT+yhSF6AXnF8X0x3o4po69iWxhNSFnTG6Q/v3OiPGqMVS0mfLadjtchiEb6SYHeZ5zUB2wOcHqBFxnaUHLD2aoF7PJxG7RBaH5C5Zk89qWVhecioBWJCnf2pVM8EvO088OlLVyRIOwP0EFt25u+RHEaaIBAT3/7jITrBKehIlUCor82ZcH3CUlqqRsj9GfYseCIMOnN4uRdMN1i9vKlgwnzTJ0j3JHO94UyFIiWtZYI8v9jfPt2tkwORJkNUd7JoWkYthtazDgQ==
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(39380400002)(366004)(39860400002)(199004)(189003)(47776003)(81156014)(31696002)(68736007)(8676002)(36756003)(39060400002)(50466002)(81166006)(6116002)(3846002)(97736004)(67846002)(2906002)(230700001)(52116002)(52146003)(23676004)(2486003)(86362001)(31686004)(7416002)(16576012)(65806001)(65826007)(65956001)(106356001)(105586002)(83506002)(53936002)(2950100002)(6666003)(77096007)(76176011)(5660300001)(26005)(66066001)(186003)(16526019)(93886005)(64126003)(386003)(316002)(54906003)(59450400001)(478600001)(6246003)(117156002)(7736002)(305945005)(4326008)(229853002)(58126008)(110136005)(6486002)(8936002)(53546011)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1314;H:[192.168.8.101];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIxMzE0OzIzOmhrUlFzNlNVaUFsTzV3YXVjRXJlOUgyMU04?=
 =?utf-8?B?VnlJdlVSZGF0clhKTFNGdDZnTWxxN2xHRG1GWHBoQ284eGZqM1ppVjlqdXFq?=
 =?utf-8?B?MWZrMzdPQjdPekxwaHMxT1ZEVk9QeHoyQmxHRWplM0RaNVErNjJuamFNRTBT?=
 =?utf-8?B?d0M0NklLZWZIUGpmQ0pzZnlUT251Smx2VlFXanczb0hrTUg1cmdWbE1VWSt4?=
 =?utf-8?B?MmFsYWNHcFFUemVhY1pSQzF6VTcrRkRuS0twQkJ1bjl6ZnhqOHQ2MXlyUmRO?=
 =?utf-8?B?UlNKeldwTG1jaTZjTXAwMzlKUEtiek0wWkp4TE5TbEx6dlJ3ZitlZnY5OG42?=
 =?utf-8?B?SWF4aVFueU1FM2tIaExZSnNGdE53K1gwYkJqdDJFUDNHcmxvN01yZjZOV2I2?=
 =?utf-8?B?MTFMN0FWUEtMU2Nuc29IS2wrVzNPNGUrYVlOcXEyQ1BJTHJTeHduREZFaVJo?=
 =?utf-8?B?TW1oK0M0WENjMVVsck05WXdkZlJhTHdMTE1helVsMHpMb082TzdsaTFpaVdN?=
 =?utf-8?B?dXBySWhUWTZhWTREUHRJaUtGeEVRdUZGS1ptZlhudzcvMFVmcWNRZzZha0hw?=
 =?utf-8?B?SitFclFzSU82YzFpYS9TN0dBOFczV2ZWbFJaYW92NkhNSVN3Y3JzRHF3VXZk?=
 =?utf-8?B?cEtGTnZOVElqeGM2SmJlMVJ6VUZNQnBjd0tQZmpqVm9kT0ZQK0l2SzkyazI0?=
 =?utf-8?B?UXp2T2tOSGxDbjRzWnBJczhVTjdHTVNpNVY3Wm52UW03OWpFRlJucVZ0eTZn?=
 =?utf-8?B?aDJxeE1qOTFiMVpTelcydzlMVDhaaWxXRytlT2RWM2FXRitaZkxMR21Cc1gx?=
 =?utf-8?B?TzdFUFE5c2I3ajJSMEg2MzkrOTlmNWtMUUxwaWx6V25IcStWTDJkSzhaanlz?=
 =?utf-8?B?VERCZ1JUa09NeXlGNXU0YnR1ZkUxT3IvcExEMStYUXFZeFNDUkxmY1pFR09w?=
 =?utf-8?B?VjVuV1YwWUYyeUFUTTlOVVNaemJzSmNvamNkemk0TmhIOEJSdjZQK0k0NE9Q?=
 =?utf-8?B?VjA1RXk2dFlSMExCbitZZ09Qd0ZVeDRESVRHNC9WZjJQQUlxemlDUmFzUENU?=
 =?utf-8?B?VzhvbE1vaWpOdm9uRW9ZaVA4UExnb0NWWHRNV1JMNDdYWjd0U2VhU2FCOE9Y?=
 =?utf-8?B?THlzRWpmMGxjQXhTZkQyRGZDMzlvVGdVSVhtWElxSzRGczY5UGlLWnB1Rk0r?=
 =?utf-8?B?ZUdFR05RYnJNU0FDQm52eFRUUDkxOTFPcTc1SGRjWU1SR2ZrTHBRNUs3L2pI?=
 =?utf-8?B?dmVhMFAreTNnbkk1MlhaSzJaUFd2ZUowdXhtdjlNSEd3VGJmeWJSTEFxYXNC?=
 =?utf-8?B?Z2lWN0kxVHBuNy9NVXNTKzh0cDhOV2xjZEhBemdBak9tTmIwZU5hczNEUFpu?=
 =?utf-8?B?TEY2NC9iVzM3VFF0ZGNPY1NmZk5ESTRCQ3Zzd2lBSFJlZkhVSUlWQ2tEV0ts?=
 =?utf-8?B?cXNnUUdOMGhwWkpDdndiQmU0RExDSUQ5dy8vZHFtSXlvdThYMUM0MHB1dENu?=
 =?utf-8?B?NFEweHdzVFpMZzlpQ09zbzhEckRLSXdSTEJGbU95TXpmNUpCMStFMG1mTEtH?=
 =?utf-8?B?OWFuZkx0My9lcytKSWR0ODNubTJCLzkvV3I4ME44YStFbGlsRG01V25BVVc2?=
 =?utf-8?B?SzdST2wxTDBwcDkwaHJSejQyODNCTjJkb0lud0hIOFF3dlRzamU4REtLcDVG?=
 =?utf-8?B?V2ZGREN3Q0ZNVW9meHFLTWtvU0hMdVVvVGZnS2MySlBJdmNOdVg3UlhCcDNH?=
 =?utf-8?B?RG5YdDFTNmF5ZDZRZ1RTd1NjbGY3NGgzRmp1QkZheWZ2dldDWW9OZDdlOW92?=
 =?utf-8?B?ekdsMU9oVkVVREdpNFFLZi9uS2E1ckRoTmUyVmN4VjhUM28ydU5OUEtNVlRK?=
 =?utf-8?B?dkM3NTVpTkpOTzR1NGdQRTRnbVQ5L2Y5MDJEVVZRVytKWUtiVjdFYnJmSzZy?=
 =?utf-8?B?NjcrdHozb0FYK3ZCaC9Eb0hZdWp5ZHYwYS9VTWl6azRLVE1yUVF6WnB2WElP?=
 =?utf-8?B?VGQrZW1PZXNpQjE3OVorUjMwdEE2bWVUa0ZNZ3VpTGFnVlVkNjVDbmt5YW4y?=
 =?utf-8?Q?ZExQ=3D?=
X-Microsoft-Antispam-Message-Info: O/68z9hw6YY1hhK9+4XIiUCUKsVfaqBW+cHfur9yihyovyJZUurb7o7afOYj0c7TWVk1niNUXPQxMy1AL/FUiw==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1314;6:019rZxxjaxWt07WejE63ENpsqzQwnquqQiZJsTZZat0ui8OMPhPKdTCjUjclb/rjIN3LVJqh5f41bPBmt3T84LpY2MDdmI41liUXSRy/hL/7p9b/6DfjvZ7JhVs/K5JXAP8J+PKvNzuKRZSIFs3nCfZS2VufsFtyu7iZ79XoN4Ui8mRVgtD3ok+lRPfwc6fx9ApfJggMrHr9flXi9BkRusivGV30xUeZ00BJt1iPn/D4E9NYbph+WPoRCsEnsDJMzzwOU4vrFyHAAr9KbpqVMUzpXbXnsSVkzXqmJ/n8AVjY+i1x9lLJE5NaRtWUUMrN+LmmKNdVDEmBACLT9ESJiRNCy3PYq2ofRr3oBJNsKRI=;5:M4plsVgUSN/S4bt5XePLcplkhlmB1HHH267e0kfN8abx01qYYb37Hxt4CZkfznAXEk5GnIV9DXnm20AOLIonJ++5Jzl4y7mu2QvZHS3dsWpQ+Y5O19Ozj2OfkX37nupCPZq1RynGUeFt7wUaEpgmDH9RGL42jr+fQfMUinQi26M=;24:7HL2LVJeKYHdxhvXiYUadk7AuBRGcaXTX2kwdaliIG8rzNBliokjIKzD3CsHEoYsiOTDaq6sU7j2iJcsB8RZ11UCP7RCd+TF92ET2h8nHHw=;7:fKpar1jCD5nFQArB8jKcvB9Xs9nhqcHwfGp9eum83d4ksSgJMdxqGhDt6lbbskCHSrKi4cjYMX08oWDa7ZNBSvqMLtV9uzsAEZ7w9RNyFBM6WrtZeFKsISRLI4y5GmVt0484pmu6fk6RIwhKhk6VHjPpCqt9CG825h+x3iH/i8eyzug3ptFbQDeYL20fVeUXPTXZsVB1f2jUxqb1JL+hBwIAp8iQNEi4kaF+vCraXLeQPH9bgSJf4jNNxacKxHmS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 07:56:43.7006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a394d0a-9019-47d7-74bf-08d578377d14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1314
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 20:59, Dmitry Vyukov wrote:
> On Sat, Feb 3, 2018 at 1:15 PM, Xin Long <lucien.xin@gmail.com> wrote:
>>>> On 1/30/18 1:57 PM, David Ahern wrote:
>>>>> On 1/30/18 1:08 PM, Daniel Borkmann wrote:
>>>>>> On 01/30/2018 07:32 PM, Cong Wang wrote:
>>>>>>> On Tue, Jan 30, 2018 at 4:09 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> The following program creates a hang in unregister_netdevice.
>>>>>>>> cleanup_net work hangs there forever periodically printing
>>>>>>>> "unregister_netdevice: waiting for lo to become free. Usage count = 3"
>>>>>>>> and creation of any new network namespaces hangs forever.
>>>>>>>
>>>>>>> Interestingly, this is not reproducible on net-next.
>>>>>>
>>>>>> The most recent change on netns refcnt was 4ee806d51176 ("net: tcp: close
>>>>>> sock if net namespace is exiting") in net/net-next from 5 days ago, maybe
>>>>>> fixed due to that?
>>>>>>
>>>>>
>>>>> This appears to be the commit introducing the refcnt leak:
>>>>>
>>>>> $ git bisect bad
>>>>> dbc2b5e9a09e9a6664679a667ff81cff6e5f2641 is the first bad commit
>>>>> commit dbc2b5e9a09e9a6664679a667ff81cff6e5f2641
>>>>> Author: Xin Long <lucien.xin@gmail.com>
>>>>> Date:   Fri May 12 14:39:52 2017 +0800
>>>>>
>>>>>      sctp: fix src address selection if using secondary addresses for ipv6
>>>>>
>>>>>
>>>>> v4.14 is bad. Running bisect in the background while doing other things....
>>>>>
>>>>
>>>> Interesting. The commit that avoids the refcnt leak is
>>>>
>>>> commit 955ec4cb3b54c7c389a9f830be7d3ae2056b9212
>>>> Author: David Ahern <dsahern@gmail.com>
>>>> Date:   Wed Jan 24 19:45:29 2018 -0800
>>>>
>>>>      net/ipv6: Do not allow route add with a device that is down
>>>>
>>>> That commit does not intentionally address the problem so it is just
>>>> masking the problematic code introduced by the commit above.
>>> Thanks, David A.
>>>
>>> I'm still on a trip. will look into this asap.
>>
>> Alexey and Tommi already had the patches for this issue on
>> both SCTP v4 and v6 dst_get, Thanks.
> 
> 
> 
> Is this meant to be fixed already? I am still seeing this on the
> latest upstream tree.
> 

These two commits are in v4.16-rc1:

commit 4a31a6b19f9ddf498c81f5c9b089742b7472a6f8
Author: Tommi Rantala <tommi.t.rantala@nokia.com>
Date:   Mon Feb 5 21:48:14 2018 +0200

     sctp: fix dst refcnt leak in sctp_v4_get_dst
...
     Fixes: 410f03831 ("sctp: add routing output fallback")
     Fixes: 0ca50d12f ("sctp: fix src address selection if using 
secondary addresses")


commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2
Author: Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Mon Feb 5 15:10:35 2018 +0300

     sctp: fix dst refcnt leak in sctp_v6_get_dst()
...
     Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using 
secondary addresses for ipv6")


I guess we missed something if it's still reproducible.

I can check it later this week, unless someone else beat me to it.

Tommi
