Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbeBUOyH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:54:07 -0500
Received: from mail-eopbgr00127.outbound.protection.outlook.com ([40.107.0.127]:39168
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753161AbeBUOyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:54:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com;
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: Neil Horman <nhorman@tuxdriver.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, David Ahern <dsahern@gmail.com>,
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
 <5973966e-fcd9-7ee5-a9c4-b79d22c1b9dd@nokia.com>
 <CACT4Y+beZ2+O=XdjKCpAkXOTBDgHYfn1JW8kn-TGRrph_RmV7Q@mail.gmail.com>
 <20180220162622.GA32068@hmswarspite.think-freely.org>
From: Tommi Rantala <tommi.t.rantala@nokia.com>
Message-ID: <7d98027d-e810-a079-49c5-0bf8beef390e@nokia.com>
Date: Wed, 21 Feb 2018 16:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220162622.GA32068@hmswarspite.think-freely.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.176]
X-ClientProxiedBy: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To DB5PR07MB1319.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73cb5af3-2928-4a37-4acc-08d5793af0ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7193020);SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;3:PGDccZTaq96/Gpbo0SP6IiLDdYQK7qcwnzAk5mxm06dG5t37R7LY7rbx6FxOYnwOjjadzFCwRImRN6AFGUEtdHB1oKD/36Ui05jJs+MfcLhHG2EtyuAT1Eov1pzR+iFLNL4m+KtzotJctdP0zpVm5ZLdZyUVkbWRYAUpFLQR5mo51i+gPxufquqX75reR03b82KawDncylFvgdsFLnc0hF5BVNfnDeQf8RJm8MNfRbeJcysuIp+/ibb7MpCHBrvh;25:fUY7TuzRDc/rdlargxBos8etSC1y5bCXYPaFYN1z56vUrBsjIPHymP01rExurtty7vP2g1zqPEs+pnH2/CDONzxXeC/4eg4KGiyQdWK2RXCux/R3+oyJy2xXpQBTO/ujwDHBYgq2/A9eN3uxFTVSGncnQNDlYmP2d2hdrAGXwbJ6b/Kb+YtkQ1OdXm9pZBaw1yTiUEpQS4Qh9nI/eE2fpxwEdO+spIYGFwsgS3LyLO7oezFLRlrF/yYqxhqnCm8ogMhXaMMC7Pvy5FTGF26VcX6Ul/s4wS/KR8dyxlO6IVpLonH57GC6ifYf41ymHgXc4r8NcV0YVox0tqByZL8ZrA==;31:DzFcLDsXs9fwXFq2ehezyi4MCWjwgA6XrlRYbmlr5qXFnN9hRfKKDksLAZ0m1jcxj954kpEqAdM7TRMZnL3Ez9nR7LeNJFMRRKl/tRLN7sbtskVZ8hX2+K5EV8cNgIBOL1oTD1TJda7Rn7VNvusIiSiJlO1hoZEkvbcXlC9rlK19qQUenD3G/Q49ykxh/K/fswUFOQB37kRCg2PTTpM0jS939V35+mOkHbtyHTZS4rg=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;20:pAFUdeLFpo7F2AfV8Mnftgn83qQe2+nQgsa1/ywpiujvaHGMfsCNeuIIWmVku35kjIAxYO/WfZ/1Qqm96j5FYzN95Nji/GW946eeYMsm030MdRmG7V45h+oalbnCTmSm/Wfja8P/Hels0ts+O8ohQoQD3+0koG5RQM/63jyvXuui8kaBd1Xb5/KYd4RjReZe9zJJIHw7o12ipxAx4vjlgvM2huCtgtvgEPcjZS5d4/WXKLdxoU/A8B+GWZkUWRY+MFpXBg1UG9Vjd+t9BfsE5bqeEG1ra5trQT1GbNoDcpyIQN78FPlVTx+2AkmjEy3vJ3BeaEGwnwEy6Kuy5+4tvb/BASJGrr9VFfjS1YLsXV1owpbt4mj/Bk8/KVYnQa31MfuZ+y2MTqCWSuKpSYKxU3dzB++jC6xlY9B319LwUBhSAP4ZXMdk8zy5M9dP8HjMgxACA10T7xGnlVm6b9Zj911YdRf7SCs+8VZR567GZmqM3IhtImd4FTZtiP4KdzH0;4:wQFz/bVtCSvL+EduSQvJE6wFVuK+xAi5RGNdARFWERJnyhI7yzzM2DQEBGMSl5hWTbSBwgT/ADM9IZkRqziVPwhgqfnn3WCy9oONFH9DPBxt99I6VJjXsuyQogQZONNcUSUm3up99G06K3ROQT0eGfO3M+hQw3vAp+mmTOsYCJni8mA7KkmppHlJcxkohhLMbpEcfFhlO/Omb6B7aOXcErZJxM0CTzYZGlN9cE3fX6XEcQefFAaJB88y1CM+c9GlFP8PiIjqTHblWue1JQUWOjJVBRIetcaVfQJSNN6BASP1ALe0itHrx1Qg7w8sGL8uYGbOF0H1NwVMzZ4hBBnc+aG2kRJ4QqVypkjVlZtfhSM=
X-Microsoft-Antispam-PRVS: <DB5PR07MB13194F7A8FEEB5D2A488927BB4CE0@DB5PR07MB1319.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(11241501184)(806099)(944501161)(3002001)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1319;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39860400002)(396003)(39380400002)(366004)(346002)(189003)(199004)(7736002)(186003)(305945005)(52146003)(16526019)(2486003)(23676004)(77096007)(26005)(7416002)(2906002)(4326008)(39060400002)(81156014)(25786009)(16576012)(86362001)(8936002)(8676002)(81166006)(76176011)(478600001)(110136005)(52116002)(65826007)(67846002)(93886005)(2950100002)(386003)(53546011)(65806001)(6666003)(5660300001)(31696002)(65956001)(66066001)(47776003)(54906003)(229853002)(53936002)(6246003)(50466002)(6486002)(6116002)(68736007)(64126003)(97736004)(105586002)(106356001)(316002)(36756003)(230700001)(58126008)(31686004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1319;H:[10.145.143.144];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjA3TUIxMzE5OzIzOmlGOUdMUDZldUZHUDNBSXAyWDI1NExxTW44?=
 =?utf-8?B?NldTMjdxL25Pbk1kMGQwQnFWRDhldmY5NGM0UlFkenlod0thZHpiYkxqS3d0?=
 =?utf-8?B?bThtSmVZSVY3ajJvdFZtcTZ5SWpmOVVUOWNvQ25ndlRKM1FtOHUrU3lSVVI4?=
 =?utf-8?B?bUtyUnBlWHZJeTZMcVdjY1NRNlY5bzJkYlNUaUlqMThnanpxcU10bHZla29I?=
 =?utf-8?B?cXNhdlJNV2hVSzFmWjBuY0JZclM4Z2RiQnVZWDFjbTEvUmN1YzN0MXc5bGFh?=
 =?utf-8?B?RFdwS3FtVkp3aThLWGpFdHRobWQrcTQzeU1CVDJZanFDT2Y4Q3NRcEp3bWJN?=
 =?utf-8?B?S0FnN3RQMUJFTU9FeGtpVUFaZWViR2sySE1ncWdvZDZhTzRjekJXRXBia1R3?=
 =?utf-8?B?UEFsN2NObTQwT2x0L3d6OVIzNGhrWU5FMkhjTUdvMW1NbVZvTWU3L3JMSkIw?=
 =?utf-8?B?U3FaZmpCSjBjZXVOa1NncEQrNlEvSUZjS2NTMjRHMEV4b1lNVXVJM3daRnAr?=
 =?utf-8?B?UUhMNlVVUXZINmtYai9MSXZqVDNCMzJVVWxZTjd2cStkKzMyV1JpSXJSbXpN?=
 =?utf-8?B?ems4WlVzMENrbTlJVjV6bzJWU3pHQVk0blJ4N0hMY2s0dGJQL0YrSmZzQkE2?=
 =?utf-8?B?SVRsQm9IM2M3aEpiUmxQWTMzVTJMd2FyemhhalJCZDZucmgyeWZGb1RiOEFx?=
 =?utf-8?B?a0RNeFhHNWl4UDE5N2Z4SktKT0pUZHVOMkxWVFhCZG1KVEZqazVwYTMwZlI5?=
 =?utf-8?B?YUlEZVFEVXlaSWxwa24xUnducWg3R3U4dWlVZk9ESjBBQllBNmtieUtPRzdM?=
 =?utf-8?B?V1gvak9oMUNacDUrZDBKQ0IraGt0eDFPbTNFdTljeEFFcVNnTGJWQVdkZ2Rx?=
 =?utf-8?B?OUh5dG9iZXRKMG92MU9EdU9FaWRZdzVEclZlV25mdUJPcjVhaGxicnNVL1ZV?=
 =?utf-8?B?K0d2VXlhQmgrSnJpd1lNcUR6WHlpWW56Wi9WcG52dHk5MVNSbEdlak1FZ2lz?=
 =?utf-8?B?eU10K2cyM0l0bnhHUjhROEM0YjVJTSs2K3ZZam1uQTl4SEF4T0ZGa0NMcFln?=
 =?utf-8?B?TFJ0Nzh3WUY1UDhVR2xJNXBOWE1Pa05LZVB4bVk1dGNvZGxyYWFWZU1PZ3pU?=
 =?utf-8?B?VTV2cnNzV1pEc2d2WUFWMFc4aG9WOHRoN005OTZwRzZtYjg5TEw3TzM0NHRV?=
 =?utf-8?B?ckhYanlLSjlpdkxJR3VDbW1wRzhNYzB2U2VXeFpXSXlON3lhRHplNVN6aktn?=
 =?utf-8?B?Rm45U00yV01hVXBzYTBEM1VzRXNFa2pDcFY5ck1OYko3Uzl2YWI5Y3F1eWNi?=
 =?utf-8?B?MjhHOU13aVpUL0dFWTF3cThFejFGdGVpcHdjdjZ6dE9ycUhYVHhBdEZVekZC?=
 =?utf-8?B?cm9OWXVubDg5OTVRc1FHZWxGcUdrM1ArQTErVjdKM1REWUt6bUZvOVlwdDls?=
 =?utf-8?B?Y0FZMkJhcmFLMDZZUkFpcWpvVi9HSktxVnFuQUtNVzRqRkdvZmVtMDFwNlFh?=
 =?utf-8?B?Y2lyUVFyM3l0cjBsYkRoeFYwNGl0VHNxVG9KMVNYYzRWQm9vdExRUUd6TVpC?=
 =?utf-8?B?QnY5NTlkdGwyV0JVSElBc2ZJM1p0WHVQcHpNbTdCbXZJeGVvUVpFbTlZM2FM?=
 =?utf-8?B?SFMyTGQvT1RYczlFYVZrQ0Fod2trYy9FY0UxdWpxK2twVDRRdTdHVlBkOXJz?=
 =?utf-8?B?Rkh1ckkvLzRWb2ZlUzN4b0h3c2xON0hQalpLMXBrcVpwblQzVW1Yc0ZCMThJ?=
 =?utf-8?B?RVNXSGI3dU5GV1VMSlA5SXhCdGFKbk1SZ2dqQlJ5d0lCeHJZMmFIbHkwZkMz?=
 =?utf-8?B?WmRuUTBWNTRnTmpXWG4zY1Q2TndKcHgxUEw3WjV1dStpTTB6am5kVWhEc3hr?=
 =?utf-8?B?WjlEekMrQmk4L1JScGxONVhqMlJlcWpoN2tsbEhBVU03RXE3OG14MDBlRThL?=
 =?utf-8?Q?5ry4evYlC6e8OQOVe++mbkvHiKr3T4=3D?=
X-Microsoft-Antispam-Message-Info: Tjw9UXwlUOQQJ3esX1PJak5P6iRaWj/yL1/gPeaJcnXvrXYJFKvQeBN6gj/oopisKEu+i5CV1h4Nx4jtsME32w==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;6:84FUnT6keFcZRXys+K4rKxnuUTlOwXOCacDDTv7entdUXxF1FFqdgMaURwf3XF63sI3kueCoKdKH9rChsZkLb6Df+Y8OKBm1sqBwKyhmJx/C5Hay2Tsk1BJE8IIYfNcmT7U4a3dhR2jcBO6K4hPClTTIKWjxNBDa7KT4Nu7B2QOeTbllgVjFJ5cqrgLCwvlyS2pX3xaiOBxXUPEajAoKXQmbC8tAmb4AMy6Gg7pmI70xzL7h8dwKe6ncO4zX9KgUGn/AxM2cFMuGMHddmh/jBEJbLe8Sis5A0AZ+wn9JZbZcHBMYP9r3YZbqhtTMoKWXRw5tTq4HOmCLZJOrDzLms1QEP9ha+mEiKgjoB7Zr5kQ=;5:3lD0MfXCGFgnmt+KHsfdh3UJNf0FgdXxfxKddDCqmKzMVe9HkHvlV3dUBTCoAguo5C+27HPX4BRpeiABnN1P7wxQnBMlgc5aYKwD3x4xFjAis5WAEJY0rFW5a13GsB2cs3GIvSd6KyfxYR9pvXb4nI9wkCfm+xCQrU8Gw1td+W8=;24:p0NIzCTKkWQ1j3RydQz01QVWBMB7edQIpnE6IuMiddiKNQ8mpjj7MvSSwmF/XXP0f9dD8lD6H1YpbFYRexXivVGlcqy99mVltJMVEqitVhg=;7:+qLSuHwkQ1hYUeSUtlapwNO5XeHeqVTNmAdPW0Io4lm6UGmP1E/C0eD9hg+SwT/kEPmaOPd6zdSlFKvNKyohl2I7mTiaaAZgOcEdWi88jSaUI69RMn8S4nzWxTk22FNMbaCkfeohVtfbQ+hiiFpv+xfmKldQ7DaNZrq+3dDwuY+uJ4hGkNN7aScxKS2G6Ik63YNzH5EwWpaCdVGWufBOtXq6CzgaUQafDuszKAa4SVjCt7yP78gK60DQ8BNncMvW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:53:58.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb5af3-2928-4a37-4acc-08d5793af0ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.2018 18:26, Neil Horman wrote:
> On Tue, Feb 20, 2018 at 09:14:41AM +0100, Dmitry Vyukov wrote:
>> On Tue, Feb 20, 2018 at 8:56 AM, Tommi Rantala
>> <tommi.t.rantala@nokia.com> wrote:
>>> On 19.02.2018 20:59, Dmitry Vyukov wrote:
>>>> Is this meant to be fixed already? I am still seeing this on the
>>>> latest upstream tree.
>>>>
>>>
>>> These two commits are in v4.16-rc1:
>>>
>>> commit 4a31a6b19f9ddf498c81f5c9b089742b7472a6f8
>>> Author: Tommi Rantala <tommi.t.rantala@nokia.com>
>>> Date:   Mon Feb 5 21:48:14 2018 +0200
>>>
>>>      sctp: fix dst refcnt leak in sctp_v4_get_dst
>>> ...
>>>      Fixes: 410f03831 ("sctp: add routing output fallback")
>>>      Fixes: 0ca50d12f ("sctp: fix src address selection if using secondary
>>> addresses")
>>>
>>>
>>> commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2
>>> Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>>> Date:   Mon Feb 5 15:10:35 2018 +0300
>>>
>>>      sctp: fix dst refcnt leak in sctp_v6_get_dst()
>>> ...
>>>      Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using secondary
>>> addresses for ipv6")
>>>
>>>
>>> I guess we missed something if it's still reproducible.
>>>
>>> I can check it later this week, unless someone else beat me to it.
>>
>> Hi Tommi,
>>
>> Hmmm, I can't claim that it's exactly the same bug. Perhaps it's
>> another one then. But I am still seeing these:
>>
>> [   58.799130] unregister_netdevice: waiting for lo to become free.
>> Usage count = 4
>> [   60.847138] unregister_netdevice: waiting for lo to become free.
>> Usage count = 4
>> [   62.895093] unregister_netdevice: waiting for lo to become free.
>> Usage count = 4
>> [   64.943103] unregister_netdevice: waiting for lo to become free.
>> Usage count = 4
>>
>> on upstream tree pulled ~12 hours ago.
>>
> Can you write a systemtap script to probe dev_hold, and dev_put, printing out a
> backtrace if the device name matches "lo".  That should tell us definitively if
> the problem is in the same location or not

Hi Dmitry, I tested with the reproducer and the kernel .config file that 
you sent in the first email in this thread:

With 4.16-rc2 unable to reproduce.

With 4.15-rc9 bug reproducible, and I get "unregister_netdevice: waiting 
for lo to become free. Usage count = 3"

With 4.15-rc9 and Alexey's "sctp: fix dst refcnt leak in 
sctp_v6_get_dst()" cherry-picked on top, unable to reproduce.


Is syzkaller doing something else now to trigger the bug...?
Can you still trigger the bug with the same reproducer?


Tommi
