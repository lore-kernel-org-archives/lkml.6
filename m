Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeFENzj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:55:39 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com ([40.107.1.118]:38995
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbeFENze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:55:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
References: <0000000000006e4595056dd23c16@google.com>
 <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
 <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com>
Date: Tue, 5 Jun 2018 16:55:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:7:28::28) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:fAKza+Q1hgYvHzrjITTig8yWkBCf7eAMMfv+1I0weh1NQHx1zkUuT7vSDzyDSxp4tgMdPFXuh4WByBNLDpxNlFSBZSw3mf8h/jOw++tLufCdeqsEY4M8Ge/oJ5A0tmJQwtfLo0gR4fXlgnU/+AjGJDdqASDTvyy2XpDEMtVSUH40qpyA0T+AUBMOm5DKHQbFXng+NrkOqDSWKNg/Lzi5XMhn/vlm1H2qWf++BTRZYwFp3vAZARHpOcXfm2VyP/io;25:Q7JKHCuUagvUZycUKc0hZJc036sgaifjFSCLWFXRiP0M5n7voRJfA4wKSaUGv0J7qOTWpYB5BVu5sojK6ZHOkeJ16iU7LRJlECyuc/16dSqgK0FECf+quNUvRX7hIfcCB56QxoDTIWb5NyngTVXPEk46M5CLYhDRjQp/Ay+2Rv5tOkr1G6kvmME4GLYBo8b5jmk6qNZRlQ0A+ToEETxlMQ2HwNwoT5oAcs+V//RMb8T9YYczdI/jyGHLaChJnHLOsLZlvk5nJacxCh8rvgVW5Yzj22HPJ8CDnLA5FDWQF70RHFfkPBKOp2aTVdDhpaEMh9/AatEwWf2BA9uoQFKnCQ==;31:SMlpiSvJdYxnSNt7wuOtQnzwXxaegtD/j9/rIDMn6Na+ygoY09iHGhua685OpAoA50CWhQ1maaQTa54PRNv8ISjyQq96qgEwfXbOTBBs3evgvND0K3lqoMpwLqLan7FOySaXMhulrSS9wLbynlwGW5BD8A78A4UBOOrkzNE7fY10fMKjlH84GtcF1k6bqNcOkHjefT0NIPgmwrFWxQUkc5ncgSfh3aEhE4fM2pC6msA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:AlRPOJgD07cc3D4wi2zbliDQPJN1XFcm1W74+T1ugVETc7OcN9o7PUbzJpQst5DwTC/O3pfI3Jpy5hgvuEs9sQbiTcMB+QU65pLGstwV9qycJxNRfZYmbjfCi7zAeNbcrL7BE6MCJjJxy013JbXmUZdB7QihYTelwOk5k9erAMPlY4loAcXAe7jWv9lNWYOCW3qeXCfWj0pHrrIy1SWsZp8M2t882ePqY5BYfpZg1NROdDEpQb1bmIuihbNddsV5yPWgUdVRticRWJrdNkM00zSTEUI2i1F9R7cWXSS/gG7ct/Q1rg23o7BtJW5ILtQ/OOO/6luJDyhCrOlgNyqxCa2TC8EK8KOqU++y0yDH3GHErjAVkB50JU5yR22a0pM6A47GHBQP+gY312UQDA9Q0jAw9TGU4y+TGLqXDjAi+WhuaQrbFKVPGrg4CrPRFSsE+ydumHOHkA8u2Yyt7DWHknTuR3zs+JMy+FFEeVQAjZYRkapVfbhLI61lDFmmYQd5;4:Ruwqp4t1e7e0wXMJwx70XtYmzjxUoAABObL891YXSxpUvZxUGad7B/3lW3Xv73Tk5RpSD6N83pE2zzea7Lsjb1qYMwc/nYfi7yiCBBwOpJpl9TSWtrpv23Zxkx6+ELCgZUT08DiuY2vTfBW6nu8WN48zgj84r0XzS+ua59iPfC/KLdLzG4gs2geo6MecF2cehb2T/VzCC/HslfHY4Ji+CQugqmaUAAmUkZny4lqYDuDKSoLm62gIrjCQDF8j1xubWJ3NZGXaz2adTJPI6qFz3g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337864B9C3CDB8B176720BFCD660@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39850400004)(39380400002)(396003)(376002)(189003)(199004)(31686004)(53936002)(966005)(478600001)(25786009)(39060400002)(6246003)(4326008)(105586002)(106356001)(7416002)(65826007)(230700001)(5660300001)(6666003)(6916009)(6116002)(3846002)(7736002)(305945005)(6486002)(229853002)(50466002)(64126003)(6306002)(81166006)(81156014)(8676002)(8936002)(76176011)(52116002)(59450400001)(2486003)(386003)(53546011)(23676004)(52146003)(486006)(55236004)(186003)(77096007)(956004)(97736004)(476003)(446003)(2616005)(11346002)(47776003)(36756003)(316002)(2906002)(16576012)(93886005)(86362001)(65806001)(58126008)(15760500003)(65956001)(66066001)(68736007)(54906003)(31696002)(16526019)(26005)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6bmdobk5paHRUMUV0VlAvc0NxRENTWmlz?=
 =?utf-8?B?Ujl0cnBkNkJlbDlRWklESDhJek45elVIQlI5WkJWUWFxR1ZjOHdROVdOUStu?=
 =?utf-8?B?NlpaeWZvTGdwNTBFK3kra3BDVTU5TUE5cERtSGNWRDhxdUluYmtLMjVzamFO?=
 =?utf-8?B?STV2MHRoOS9HTSt1ZkxXNzVIaStRL0JxUDdjL0s0OGdLMHhOdTNZaFF3dzQr?=
 =?utf-8?B?M1pqUndLOXExalY3WU9CZG1HOVFFU2hKU0pWYXZQbGtnQXllSHNGbGtiVHFK?=
 =?utf-8?B?MlUyaTZDcStMQy9uY0JmT1NMNkZxOXRTTlh6SzBIemJVSWNTalpNcXV6NEcw?=
 =?utf-8?B?Q2NMTDVSWXF3MUltQTZwRWVzbDMwd2xpQ2J3b3BRRUpNbWJFVmVtNExJQjJX?=
 =?utf-8?B?Vk1OcmlhZmhOOFRkSExtQ2dUeVJwclZMMjBmOVcxdUFaVU9UUkgyN3lleXJp?=
 =?utf-8?B?azRWek91VkhmSEc1UTdyYVpnYVJoa0ZkVEJITndEZ0F4THlEM2xVZWl1SDU0?=
 =?utf-8?B?dkZHN2hzcnZXU1J6OXNPYlVxcmYvUHZtemlVSTlMdjVRSmxUcXlnci8zRTYr?=
 =?utf-8?B?VzR6MFNTN3JWWVFBbE9aTFF0a29HeHEzbGNtejN6WVRKWTUzanlaTXN1V0t4?=
 =?utf-8?B?a3QvL0NvaEZvelJha3J1bXBJakVibUw1SUVmV3V0U1RLZXJsZy9uRDBWRFFN?=
 =?utf-8?B?ME9CaUZ5RkhPdWhuQVQ0K3lNNWhtT1FFSHNvaWQyWi91TnhRNGxicUJQWnNU?=
 =?utf-8?B?RWhHQjdBa0JoSW52WklxaDRLYjlOZElJZCtveHd6U2JCbEIxS3hhZG5PWUFy?=
 =?utf-8?B?djl1QWs0VFVVWkdKdTcxSTMzL0dVMUZJNHlHU1liVWJpZXlsR3Q5SS9MaVJh?=
 =?utf-8?B?VTVsdGpubWZNQ2UzaGJJSFdUTWw3R0JWeXo0aExIMXVRLzhhTmdwM0VGOThX?=
 =?utf-8?B?blpybHYzUHFTcnhTUjlOZVAybjBWTlFIV2kxeVVzdmxLeXBROWRNb1ZvTnI2?=
 =?utf-8?B?TXJZek5PSGNSdUw4L0NoOVh1ckVjVEkvMktYL3ZpblpJeEkveHhhK1VGcFpq?=
 =?utf-8?B?NW5wTWZWaWF1OUZDTEYvK1M0c2JuWlQ5QlRveG1NT054QXV1SW9iTGt5LzZJ?=
 =?utf-8?B?NFdkMHVlMTB1c3UxVmNQd042OVdmcnZuZkNnVGw5SUdsZnlCcWR6RnJCeDRt?=
 =?utf-8?B?WEk0eHQ3SGpZQ2Qzd2pGU3F5S0xJTkVOQWg4WXlHUThQbHlqUDY4eHpGdmFw?=
 =?utf-8?B?TTZuSUo1dEcwMVZXWWRLNTNvUEY4eWhZeWJUMHZoUnliRGNUam11SU1CbnI5?=
 =?utf-8?B?VEZZZDJrdVF1dkZ3REFTaURLSUpTYmpZNEwyTmlQdVJqNXlFNWhOdDJkN3Jq?=
 =?utf-8?B?OUtWc0NDU04xQ3pVTTdyR2lNUk9lM2J6RUorUGRPOGY3eTJHV2JlRmI3alFZ?=
 =?utf-8?B?bkFFaEVqUVl3aW1IWG1Ydzlad3h3dzdXaXp0WGh5MEIraExKZ29YdytCUGp0?=
 =?utf-8?B?TE4zUW9sekZKNm9GdzIrWTl2Q2VLMXBidmtud1B2WUZXL2VNbnErYTI4OVdq?=
 =?utf-8?B?UnJIVzI2VFREaFhvOGpZOVNyRGZPSHBGR2hvWkZicGU3VWc5OCtkY0pIMzVK?=
 =?utf-8?B?Yk5XWkpBUm8zbmtKMSs1Z0M0YkpjbjFvUSsyQThGZC81NnFFemZUZTFITjBX?=
 =?utf-8?B?cllrWDdDV1ZyWUxEYndOeFVOdjQyaHorZTRPYjM4blRzVkZDRUZ0SWpFdnhK?=
 =?utf-8?B?TXNwY21HRlYzN3BlTTJXU1RwUW9iOEUrampOVUxCbGFyaHcrdDRmS2xrYVkx?=
 =?utf-8?B?Y25BdU1DMS96cTZBN2FBMUZrMEVickptN1VmeDc3NDYxZVZyYlNpNzVFK2FF?=
 =?utf-8?B?STFMTy9oQXdKOHBQZ1NNN1A5cFUrQkF3bk1JQWY0aWVDeGJ6UStJY0l1OE5o?=
 =?utf-8?B?UnIyc3BydlJpbDcxdzd1RWRmMVNXalhHVHMyTm5CRE9pSGZBekF1RnlGcDVJ?=
 =?utf-8?B?NmVKRWRKY0dUcC96a0c3cUpkeFBDLytDRXFSaUlwSEpka2pXRGJUdjIxUitX?=
 =?utf-8?B?cytDTXFaMWpBd0ZhS0VkTW1NSCs2aCtTOGVKM0tjc0gwQjdSTzRzUE9rRnBD?=
 =?utf-8?B?TUJaSExLOFU4N3NKY09wbm5PcnZML3B6Mld5bHYxQ0hnSTNPUnNlczNMaGxx?=
 =?utf-8?Q?jC7uDAFnY882z000NWesJXv+7dnW6534w11tdNryU6xA=3D?=
X-Microsoft-Antispam-Message-Info: elCgn/HJEKM11v/e7cBcZ2dOdkJmM+vGOOi/OD/1hwxhSPpO6zfYAbnSo73KFs4gZlQrO+vN2ft8oLWN9lIiCjcnUT77BFU99X9Wk2ku1fyEJxawcgjjKWj3Z55pRrtBR9wp1iAeu3sX0g2h36Wnn6PX+YS1wvO8ZFOQ3c8OmK5XqqGy9UzPR+bBf/wqzawm
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:iBBCXRMZP4cHnYKVkmNiuDMZ92Qr5SEES1jvrchvLk0ZqO1MB9zmy7M8RX+aRRs1E4nVGXzFiqNPw8ppqC/zKfB5GrV9m/qW7r/xYqMVmwabk10RSQYEj/DqOhKprSLlFrqvITcaCtUAjmL8KWuzaMGnd3e3kFZDb7d/1rBdQWuTBdKH5IaiRUVrxjLuXCdvZNgM9BfiZ7waD47xDevzMqdoudHVtCrDJ5j8iJPAyrYKxdo1vS02R+4w1rdrG0r2YrVJ2fifg0dZ/jEM8Gwikeiuh3J4gM0cPZJR8OeRQKxMpj74TZmlZ8RpBrwGv43RuJssO2Hv6Mmw8FM+0TThQBPtOji3vw3wXJ2tFcbVReL88yt+CSjTJYcffBTN2OIlDBI/N+BgrMyFCiZdinvTcl1o6CrJI+3l11taZccDnWW8CsJVjDpQdVmw4/lnfLU60WJoEd+IoVU8okLHzPbvcQ==;5:/exiielUjKkSOM/TFbMVXj46ayGgzSi9047FJUGrNJSeCNtyWYYw8aWWnnZdhZaMQzjAlmlGgxI5ibZHnzwZfAkPBv2qqbcCZJED/vC5DacYprHqHoc3knOBfE6V3LEOgQQOlXapH3924Vuv+lJzuAlzVzvzp4ll7bPsRA10nsw=;24:GrAZJ5FuG8fcMflm2crIloiqgqF0BxHhS2sLxF3q44sT348uCLFXvkjzTdjx8v5n7Oqmm05AQfZDNN29WfBEoq4rH+V8nmjFH1TnyKtqptU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:jrGm/85ggKRwGGw5M3buc9dIpLDKUqwDioDe8KCrlXxtS4m/TuSeY6RHQP33qdThbYy0QM+MNg3xv+lMgIgSDUvHbQNR3Kh9TuZTczJgY3ZpNDPD1HU8sjAnU+heSm3o4WE8eWfzBt+xIXj06M7nnWHsZJfcshw9USmpkHvKZq6nwIsd5wxCo1WF+GVn+Pqkienn6My/ecvzvVc5SMbXGAlalvFoH3DoTaxIn75ea45YZImHRA/UIwn6UjqbKPu+;20:ev3TktPzxIqTyzFBwA/IMxaP/mOcPTYZqft+amg7JKuawJEBaXAVMD0QxUSP4ZRs96dKE8G0arhqJBp3mlU3ukTPMdHZ8Aq40yWLXz0DBkIMxeF+udlU4rUCL0eAbT71i3Zby8Dns1Xx5/bVx7/EVVrZwaB9AB54k+qzF2+6ruM=
X-MS-Office365-Filtering-Correlation-Id: c0c08d05-ead3-47a4-5764-08d5caebff07
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 13:55:28.3058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c08d05-ead3-47a4-5764-08d5caebff07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2018 12:36, Dmitry Vyukov wrote:
> On Tue, Jun 5, 2018 at 11:03 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> Hi, Dmirty!
>>
>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>
>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>
>>> Another hang on rtnl lock:
>>>
>>> #syz dup: INFO: task hung in netdev_run_todo
>>>
>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
> 
> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
> be something different.
> 
> 
>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>
>> To exclude the situation, when a task exists with rtnl_mutex held:
>>
>> would the pr_warn() from print_held_locks_bug() be included in the console output
>> if they appear?
> 
> Yes, everything containing "WARNING:" is detected as bug.

OK, then dead task not releasing the lock is excluded.

One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
(I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
There may help a crash dump of the VM.

Also, there may be a locking code BUG, but this seems the least probable for me.

Kirill
