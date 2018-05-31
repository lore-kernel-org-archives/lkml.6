Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeEaLeh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:34:37 -0400
Received: from mail-db5eur01on0132.outbound.protection.outlook.com ([104.47.2.132]:24647
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754522AbeEaLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:34:35 -0400
Subject: Re: general protection fault in requeue_rx_msgs
To: syzbot <syzbot+554266c04a41d1f9754d@syzkaller.appspotmail.com>,
        davem@davemloft.net, ebiggers@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tom@quantonium.net,
        viro@ZenIV.linux.org.uk
References: <0000000000000482ce056d7c1436@google.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <215d6d32-0131-a1dd-33c4-23866f399d0d@virtuozzo.com>
Date: Thu, 31 May 2018 14:34:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000000482ce056d7c1436@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0402CA0023.eurprd04.prod.outlook.com
 (2603:10a6:209::36) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:DZ7ZQCKzt12s8TnD5XkfRx8NXZbx6OpgN0xzzclq6r9X0CiqRp2KSosSpKz/pvh4NbDI55BvCA4nPabMV4xm7+7W0It+m5Llzcy0sPsKkH4YY41mZN8PemhlwE8TDKGkGIaiVaP29jp/10CV+Pd8Cu3chq1zn4YUqMU/UoFdq1LJB4XmTvC08uj57kcm/qEEpOGQwMvKqb+6QLitpXkMDjyd5S3ab6keoTHNpdWnh+NHF1ESLUJj/BznDq/RgKkb;25:ss1UBASI2flG2gZVrfwS7nBLisfbuG7uM7p3QITbaP+iruETfCgeH5eeyqrml4qCduCJAwOpxD+PHtBjNBCQVawLPIhkX7JPZeRoobEN/6ZHjCq/vjq9vyzBjXpNpeiHN4Opz3pxkkEbnobEXhBCz193yU6jynmRgfUpeRUxLFWMFh7RmRo/9nMpaRTaxim5kgflwUta4Le+YCAUloH2tlRiT13DyUUakuum8dUbp6jUBI62fal3F0fEJQRlcsZOWhWhvCdy8jv7UeXlMt8gpjCEF7i7ccDbNAe0Whf1XsZv7n5Zv6Yg1vqe9gsFLUMtqy19nHIArTA51jEr+lyXBw==;31:Bfh4f4Q4aZo6QZ4yI9ENWDxqS3WfkmeoEMGtnR1yPZiH7FKMI+NsWL/iZKruM31Cb+8UXtEo6M7Mf5FA7Qv+T76/rl1sEKFP2n7Wmw507mWsNwdwot6tp5IJDXLrKHYF9oCE7H2macq7t8tMP6WXZyaYcMvRQCqdc4LrmPJpoC1DUGsHq1sqUkaOpbJWbmN9TjhZGpNuU7zrSaOwS1x+7M0mJwDD2wyvJuYtPJDWE9Q=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:A5aLhzvHa7wtX5TeJVXItVUgTcmVXTvUZvFgYNYLFPq+QdNlP3GxWgnneQGHnXjC4m4wNMRxIYg6c0VJTYuMzwGh+E/L3EHKa1Ln0huYoxDZfR9iOcD/WQJX2sSSCCEDcc139RKF97sUTabmkcsdoinWyoTE/5s125JxMN3HdfXLl47AFVfTdhVDfVav7UWZCCg+/AYY2O7R12+gdFWWuwgiIMsD964ebeBuwkLGPqmCX/+oTVRnJl6QK5Hx9iOj7D0FX6c8FXFMYMyWK1oOCbdluRL/0JsI7qUwX1mdqMMpMhgzNPAcaDzItMWITvQ3LljP24AgBsTo/peIrno3bxoH4gGSkSle+hceblKVo557tHqiaq+YtWK0LuCn34hBOPH5A780mbFCpL6eKfBizcwKV1OXZ3AhTbbkJPauA5YkVn1oMJCv1gcNo4bB+9oxUzI2LF5e6T6H+4s8wVJTs/XRcZSvUjllFKctLcbzKJJYM6exDq/NG7kj7CJfhk4C;4:ZvsPUzRdLZC7kRfpLNpxqIXfAWoGVmYUeUnTgx/w3IX6ZP0pBYa/6n9FZQXyNCNP/KkuX5gATB4q73xqiiJTjWAiYVCys2eF9NQ/yJVCuv2y2/S+WGi6sFNGqg2bTBuaqP9YHl5a/4oyU6NscB3jAXQMLWfEcMnH95c0ByeBJiLPUNnZZD78zK3bPNSGpn/8Yj0pcvqWWb1/8PO1IRQ9Y1C5w8eZJEw03a6v2lqV2HiH6GACQBr4AkHNBb6S6h7yZY63GTAcq8VhjrZG5XaN1w==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334D7BEE5FD2D05A0A14BAECD630@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(39850400004)(346002)(366004)(376002)(51234002)(199004)(189003)(3846002)(2616005)(65806001)(5660300001)(478600001)(11346002)(6116002)(65956001)(66066001)(6486002)(65826007)(6666003)(229853002)(956004)(64126003)(105586002)(53936002)(476003)(6246003)(97736004)(31686004)(47776003)(6306002)(25786009)(305945005)(77096007)(8676002)(81156014)(316002)(81166006)(8936002)(2486003)(23676004)(52146003)(52116002)(76176011)(59450400001)(26005)(106356001)(386003)(53546011)(2906002)(68736007)(58126008)(7736002)(486006)(16576012)(2870700001)(55236004)(446003)(45080400002)(50466002)(186003)(31696002)(86362001)(966005)(16526019)(36756003)(575784001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6MWJWdkxoVGorS29POXBzaTZSNngzWWY3?=
 =?utf-8?B?TWlSSGY2bG9uUlJ6YW4yS0VjY0NpN1IyVzBmc041aDJHMHdzanNoTEVJTkQ2?=
 =?utf-8?B?MUlVRGVEanluS1o3Q3pBUHcyNjErVnZLZU9IeUozZW5ySzcyMjFaQWZNL2I4?=
 =?utf-8?B?Z1JFLzRWdVVWWUpBMEsyR0l4dzFyVDY5T0dwWXhKeHpVUmI4RHN3bnFlS0pY?=
 =?utf-8?B?SjVyc0NQaXRqc1RmZElONm9LbFN0TTNxYkRkcDN6c3o3N0R1WDFZQitJVjVU?=
 =?utf-8?B?eExsYzk1MnRSY0V5Ulh4WVBHNEVZSXBOTUFLTHJQYWVHQWc3a0R0UUZWS2hH?=
 =?utf-8?B?TzZva1NaL1ZPV1dSZlNIRmE5dHJja3RQclRvZVRQVmh3T3NGK2VvZjhnNXpt?=
 =?utf-8?B?ZHlxbUUyb2U3K2ZpRW00RUVQb2Nwcko4empONlNpYmxhUU80aC9tU0RwdEZ3?=
 =?utf-8?B?WERXSFE0cTBxOUI5cUlmbWh0YStpVld6TmtHUDVXaStxbUZOZnZJRWV1Q0hX?=
 =?utf-8?B?MU9PTWVVQm5UYUMvdEtSVEZOK3BybWxTOS9IN21sSDAxWHB4ajA4QUNVSEdV?=
 =?utf-8?B?Mkd3bnVHWDFoVTEycUl5YzBsRzNLZm9HcUJTTlVOaTdVVUdhdE5KZEhuK2Uz?=
 =?utf-8?B?bWVHR0xVY0pxQk9VVHJNZ0xXdU41TUhQekpZcnBPVGVWK1lKc0VURjRReVpL?=
 =?utf-8?B?aHkwRFQxSUpIVmxmbEdPOFdTK1kyMWlnZnY3YW9ZNnMwZTNFVVFrb2JwRU9t?=
 =?utf-8?B?RnBXQlYrbHlhT010R2VZbEE2VVI3M21YcmhGNEFraDE5YXZJOVJ2eDZSM3hy?=
 =?utf-8?B?THZYZFcyUHJ6bnAzSkpROXVHanp3LzBXR2VDcmhaaElhTTJBekNJNHBZU2ZH?=
 =?utf-8?B?TG9ndFpiam9obk9KWlZDZWhyWjhtRFVaa1RMeER2dzhVQW00eENPdVdhOG9m?=
 =?utf-8?B?OVIrR2pwQ0EyMmppUlg4S2c5RDkrbmMrc0lERDlnU1dHa2lhU0Z1U1o0U0Qz?=
 =?utf-8?B?a3R5c0o2UDhhUUFXem9jaE03R2NLZVd4UFY0d0pKczdmcXNPNkc1VmJmak52?=
 =?utf-8?B?bUJYbW5KOU8xVGRCbWxaemJBMnF5ZGlxcU5BRklCQ1hPTkp3NGwvSDRlemVR?=
 =?utf-8?B?OXg0UUhVTmN4emx1eUsvaEVDUlMvVGE4cndpZTBtRTNhU0VQdWdhcFVmOGtG?=
 =?utf-8?B?d1FUS1FzWm53UUlOZCtZQi9TWW05em9RZVFGZWxQMnh3MGQ5K3llTEdWM29I?=
 =?utf-8?B?eDQ1a0ZyRWxIb0w0ZnFZc0FySC9sYThGNjdzZHJxWFM1Y0xiV1lRdkFtN2I2?=
 =?utf-8?B?TlZKaERreFNVcmY1dkd2K0xwemNHSUJuck00Q3plaENuUENEK3VQWExyZUdW?=
 =?utf-8?B?d3RVMm5mazRVRDdBT3MxOXVrZEtsanlJOTNoeis2d0VqLzVMOUQ5M2dpUmsr?=
 =?utf-8?B?RGFpVkJFdWt0OFV5VnJnb0NoaVV6TmJzMWUzRDhLaERCdjdUbnN3dlBWZzJp?=
 =?utf-8?B?MFErMTREckZDbXFlWGd4ekFmeEw0bjJocmVTRXJwNVU1L0E4bHpTNGZCZm1P?=
 =?utf-8?B?WjNNUHVKc2FiVXhXS3RJbXZQVEgya2tJS0VJQk9VdGdHMHRZc2NIdE81QW1Q?=
 =?utf-8?B?UEpkUzVQZ3p6RDVqTHZmVEZPbmVXY2U1MVNvejFGdEVPbEJoRFNNK3ZpeWRp?=
 =?utf-8?B?b2hzT203STJ3WUg3aEVsaXRubnhZa0J6R2Ruby8zT1lqd20rQnJsL3o2STlt?=
 =?utf-8?B?YnNiemlwcExwOHdZMlBnZHpVN3YxUVpXRzNDalhiRUxzME5CYWgrVjRheVhP?=
 =?utf-8?B?QXZIa1AzSTRmTXl3UjJGSjhJQm8zdGRzVGpOZ2lxdGJrVVpPQVpvMmZJM1BV?=
 =?utf-8?B?QWhGemFQWm1tazMvTXFlN0tEYzNZemovQXc0UGppQkxFMkh0VGtDWmZOZ3Fq?=
 =?utf-8?B?dUVpNHdBNFBQTzlua3diN3RrS2dBbThXbURWK2RrVTZLWXYrWVpjUG1MZnQ0?=
 =?utf-8?B?QU1IR2tUSzM3K29OUjgvMnZHeW1CMnUvS3BIQlYyWmI0NEVCMWcvaFprZDE1?=
 =?utf-8?B?MmEyZTJOeHprblN3dkxqWUYwZ09BVjVPa014WlY0YlRiWVB0SDVkbDFydHJJ?=
 =?utf-8?Q?u+VdgyXVhyreBW2cGz8E5/T68=3D?=
X-Microsoft-Antispam-Message-Info: T+M+exH5pAOTvF8CP4R7ibZQn1ZzcrCDrU4oDhZxIO6eKHfaodrGj7ReGZ+Ijl+1mzW6fHlx7H6a3lWD8CZhZNf/imh7op/IDOyWaRElMf4w9PeAxNUosMaqTK8/Dguozm2CVNSMHUi+ta2rLTJCSZqzKGhYL0dkNuj7RPjB4i9a/X8p6rpuCNcj8JkTAu2y
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:2am/+r/qsYCief4LX4xBD1v1h69iRbesQJ0vQT71NrJ3tw72ZVTKV0fbJVwAdgh/HPReHP8KDHvPhbCS9gek2K7MWpidIYKUlT0gUMafi/jIzqDpcczXVPsjwIXLakEFy4zWD6628AG76z1+GwlmcTwc+l/jcGnLVJ1TotBH8V4jQvnInO1D3eJ+2ZOo1uiOvLgWvJa8vt+0QgbPto+1XIeXlDtJAeAcXhVmfF0Zrwbcpua8Dv6UeEiaXx5eto4syQwvy2Rsb+MQJ3LFlofpD86VacHkzqYuJ501eL1cqu8mNtl5En9bQKyrY9mus7yUweal1xdJPl4UKL3Ljjf9Hpe5gMTl1V4AnNYd3Nn5AF0SupTlakUJ7soSpbkKmhCSyY9p0Qs9c65XZYJdpkqyArV6h/5UPFNrwScVUzNTAGSgsZ/+/QV+Hz+fBdieyk0RTVCHlnwTn6j/ppvXRTQWqw==;5:/Lxb38aoGwM8xL3mlOIjcIL0tLiFoTP6w6tr1RNh4UTzQmPWicUYNiDaXk3dSPN8LQQPjCtTahyNFdZ40WERM8o0Walst/E+CwCX/fDXtkOZgfUHkXR/MkWkq0bR82uJv4Vwjlp6lsw41BsPunNVwnDzkTjLZ8T0LylQrpDYl4k=;24:fWYrawDOaIDApoWBsKpxD5CTkqn/AkJYUkjfut3een2ezeAsMpqaQmZqurKcoNrWww5WlPdSuiaMCgiURpmtt0ZclKZxZTxbnM2lBGNDtT4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:2HClSc+3zv554/acC60VdBhVmM7pWWiNuHUu7ercux9PSMozW/iceyYDlG+AtZ8uCy5DQpxZo7PKKIhjCjwkmpvy7NkrJNPZnuMAX4olW/KVjYdtb307jPP4nEn7QglClQIxQdupGwKrtAXKVTZJ5FCdJge2MFdSXIlG0AWUvwxKi/8Ao7R4rEOzvoqWD8K7DXEepKZ1HENezwsKJGPdK7lgLEyGGTcwDFaaRYLda9aInxfeqgSlp60qwoB5s2Z2;20:tUVI57cG7Cc1uwFP9j0PTufjfq9OQhilYWrBBpC+iQgjpEd7ck4CPNDzJSJTXoHWMojl29Oe1iBGPSSmSoipxm7MSJqH5gUparsnuAT+qdTmxxs5QT2JEbwKeeVMpCVdJaqpnS5+bOaXfLrhbrfLt5bYaMpHSFzBp6/zAwcb874=
X-MS-Office365-Filtering-Correlation-Id: 5b00ccec-93e5-4b8a-93ce-08d5c6ea7a60
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 11:34:31.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00ccec-93e5-4b8a-93ce-08d5c6ea7a60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2018 11:16, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0044cdeb7313 Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15aeff0f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=554266c04a41d1f9754d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=131a208f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+554266c04a41d1f9754d@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4788 Comm: kworker/u4:3 Not tainted 4.17.0-rc7+ #74
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: kstrp strp_work
> RIP: 0010:__skb_unlink include/linux/skbuff.h:1844 [inline]
> RIP: 0010:__skb_dequeue include/linux/skbuff.h:1861 [inline]
> RIP: 0010:requeue_rx_msgs+0x14d/0x620 net/kcm/kcmsock.c:226
> RSP: 0018:ffff8801aa97f0b8 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff86d54ed3
> RDX: 0000000000000001 RSI: ffffffff86d531e2 RDI: 0000000000000008
> RBP: ffff8801aa97f1b8 R08: ffff8801aaa8e3c0 R09: ffffed0035f0a0e8
> R10: ffffed0035f0a0e8 R11: ffff8801af850743 R12: ffff8801d4407000
> R13: ffffed003552fe22 R14: 0000000000000000 R15: ffff8801a6bb06c0
> FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fba7c5099a0 CR3: 00000001af6f6000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  unreserve_rx_kcm+0x471/0x520 net/kcm/kcmsock.c:334
>  kcm_rcv_strparser+0x109/0x8d0 net/kcm/kcmsock.c:375
>  __strp_recv+0x34b/0x2130 net/strparser/strparser.c:328
>  strp_recv+0xcf/0x110 net/strparser/strparser.c:362
>  tcp_read_sock+0x2aa/0x810 net/ipv4/tcp.c:1652
>  strp_read_sock+0x1a1/0x2d0 net/strparser/strparser.c:385
>  do_strp_work net/strparser/strparser.c:440 [inline]
>  strp_work+0xcd/0x120 net/strparser/strparser.c:449
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Code: 80 3c 1a 00 0f 85 70 04 00 00 48 8d 78 08 4d 8b 74 24 08 49 c7 04 24 00 00 00 00 49 c7 44 24 08 00 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 a7 04 00 00 4c 89 f2 4c 89 70 08 48 c1 ea 03
> RIP: __skb_unlink include/linux/skbuff.h:1844 [inline] RSP: ffff8801aa97f0b8
> RIP: __skb_dequeue include/linux/skbuff.h:1861 [inline] RSP: ffff8801aa97f0b8
> RIP: requeue_rx_msgs+0x14d/0x620 net/kcm/kcmsock.c:226 RSP: ffff8801aa97f0b8
> ---[ end trace e4c0e45094907eaa ]---

This looks like the same as syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com:
"WARNING in kcm_exit_net (3)". This may confirm the theory. It looks like after async
pernet_operations the race window became bigger, and now the work has more chances
to have no a time to complete.

I'm not close to this code. Tom, could you please to say, whether kcm_done_work()
can be called for in-kernel kcm sockets (created via kcm_clone())?

Also, is there a possibility to create !kernel socket in kcm_clone()? I forgot
the reasons, why we can't do that in some places.

Thanks,
Kirill
