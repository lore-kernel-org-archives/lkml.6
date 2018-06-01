Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeFALKj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:10:39 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:49888
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751337AbeFALKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:10:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: WARNING in kcm_exit_net (3)
To: syzbot <syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com>,
        davem@davemloft.net, ebiggers@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tom@quantonium.net,
        viro@ZenIV.linux.org.uk
References: <00000000000000dca5056d7c1442@google.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9f485659-6d6f-9047-b9ad-b0e4084be88d@virtuozzo.com>
Date: Fri, 1 Jun 2018 14:10:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000000dca5056d7c1442@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR03CA0028.eurprd03.prod.outlook.com (2603:10a6:20b::41)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:M7n4vjoQ60ev+YU6K5eY9qb2V74sztV6lHViq9a3yqZH/fgqxHtYnlLWHPlMEAazKQQG7EN5PE3x3lwWA7nj2cVnrx6wQ23gUpwqXS1jp88ZICNbhx6OZC9m4mbVVV/USdO71nJSfrBieE/1l0vzE0Rb7j+U1/mWNbRM8BTKJ6lDWcR8KxgzEAn5rlh1P7T9bIzyNYDv3xVFaEfBChX1gw0faPuZp4vJQR78xumCf91ncn7rhdRlwSYbkBTaCvuZ;25:kYfyhhrdnqhMoQH+V+S1MvnoMTGTScb56nS7f3a8kQoQDckWQ5qM16ym7P9gT/pUEQTDz2wJnzef2Lhkc0iRGShop1B+m30VGnnJZ6J+TxMgqHSiYlYKtzbLSc2iCXPNqorbICst/B8IlvOF8cVZekFJU9Z5D81C+X/OCqHc+7Lmnp+JtItkDYBRgeB1z0RGHqDUR4p+HL9E/wVrXS7wHlNVuYi3oPcA3Qc/NpOOF4d/sMfB1CaJtfwod/SLeSWGeQQW2olfyaZLdrsHVJrc2RthSyb9DK0XyWyFTuqfz9uUO6WCxAhQMSQo8tdpUMJTKbIYwOdIZoTOoqftDKQs9A==;31:8fhdU9gP2BoB5QqTjgVy/MNyN6xRsPhfAessWqOV1gqhMrujiL+6rjAgB24F+iUNAbTZvyimZpAsQLA/PCr/9/ns0ALECmUbShdNqCwojJdzlxVqrav5gjwV87HKSmM+/vk98qjVegRdwdShjBEqC56uGIDdfBZK3ojYWhDo/DsZQvwEG/Dw+tS/nBW6OXuTsROb+Ux1Q4fDfiyUuFqHkR3qWBYQU2cYL+j1kCG9T7k=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:Gc51+rYGuZPynpehE0MoVzHHRB06JoiwQwOA4gWb3+4wv9isLuWQhKRX7DzQYbaJEHBdhFg5U6Tp90yo7gI5vcHMchFr75t2npLGbRCGGG4IS0FFtdbbS04lH90tud+811u0xSUGB6eYWSvLekWEA2GaRuRhTOacdkLJtKpY6iGfjPr/EvtoyxJklsL/sOei8hA948IrkN6tCkk1hxeMLsuwg5FwoKm28coEImVoeCIH+38iplgCPMlls9Nj6EmINiMUB3Ia5G1PKLK05ksFcQTKx+/dH0Hgn0J78zYxi99J/8VIhku51WEuN0JVM49RmxXA9q4ARvdKUZiTKUSjtfMt7IBxzZmMEV3iJIZ0NL5GPvVjCt6k6azz8ewIuV4Mjg2v782OfmfiJPmJKq3uH2PtnWkeLrsURPEMB4FShM09FnNCi0Gd8sY/y+OuaZ5tPNXS2ZTyBKLtHAkh8hj6wHsZ/1cc9oCtfjhz5eAxNLOYs4mcLfZptGuXnXw4vxHp;4:ImEtOJYJAJNzOrX8SAVVJUw1dVcEm6Hqq5YAcgufObgJBEnClmL4dOF2OLfEUPzsnR0a4bU1JfHFud1ql+lNWUTOuZ6PclYVV70uxANuwhUm6U1ov5lNErU0tiT0jx2F0l6DHmdlyI9fViUA0zjCwbxrumYmIn6pjZCetn/EVYp280rMfiNpJg8v+K9W9UvuqboAnRjxkmUmU2VDQ+FyF1cqt97PN57XKvI+VRwzO9QuE1rXKrmFZAeQFsiYarVWeiJCk/5DvdTVPrWdCaB4XQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331DC70315A3D02304A065BCD620@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(51234002)(189003)(199004)(575784001)(31686004)(68736007)(65826007)(3846002)(65956001)(25786009)(6666003)(966005)(5660300001)(6116002)(7116003)(66066001)(65806001)(47776003)(23676004)(76176011)(81166006)(2486003)(8676002)(7736002)(8936002)(53936002)(52116002)(77096007)(186003)(52146003)(478600001)(26005)(305945005)(386003)(16526019)(81156014)(97736004)(956004)(31696002)(2616005)(446003)(476003)(486006)(11346002)(6306002)(36756003)(6246003)(53546011)(6486002)(55236004)(59450400001)(2906002)(50466002)(2870700001)(16576012)(316002)(86362001)(64126003)(106356001)(58126008)(105586002)(229853002)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6dFRUSndzV2o2aXBJL1VQdCtiTlNvR211?=
 =?utf-8?B?ZXFEdjNFWjRIU1gxVXFJSmYwcVp6NDg3dmd1dXBOQWoyN0ZlYTRCcEVUcFpp?=
 =?utf-8?B?b0lkM3ovSHQ4YWZKSEJQVXUrYTR4TFU0WENVTDQ1S2dNSzU5RDJEQ0NNNHc3?=
 =?utf-8?B?RVF5dHQ4TFpGSDhYWTBWUVlycVZqZk5CWkx4ejRTZjFOTkYzSlJPQjJLSXY3?=
 =?utf-8?B?OWRNRVRXYVd0MmZWQmFmMXl1OERiWnRwSDhQZlM4bWpZUnkybFdGWDBZNTdK?=
 =?utf-8?B?dWZTK0ZQSVhNeWdTTVV2UWRLWTJsaTY2MnRXZGhiWlpKNkZWdEVHZzgwWWc4?=
 =?utf-8?B?aXN6RHFydDBJNUJZTk1VNFRRMktNWnlqQ1A5b0l0UHJjUTk3QnRTZmI4WnZD?=
 =?utf-8?B?c09WZ2d5UWw5UThaK0xJOWtPQjY3OEZ5c2IxT25oRE44N2pkN1JQZzZWaVhk?=
 =?utf-8?B?N0g2T3NIOHRFZ0Q1WVhoT1NJWHZVTHJINGN3dVdzRzc2ZDc1bEgvZDdGTk1N?=
 =?utf-8?B?aXNzdkJscjhWVVdZcm5KaFk1M0NMajd6b3phNnR4MFVqQ1FENjlmRGRiM0VO?=
 =?utf-8?B?eU92cGR3SW1RSlhiaElvNHJBTHBZZys1cXg4Y2FJYWk4NnUxdzV0b0FYTVJx?=
 =?utf-8?B?SlRKbkdMM0hpU2dTMGljUlZnUW1LaFNoeEdGNjAzMzRNNnVKSGgrbkh4cTFB?=
 =?utf-8?B?S21oMzl5ZmE5c2I4RVF0aXFra3cyRkZhUld1QTBLRmU2MFZFcVFVZXlUWi9i?=
 =?utf-8?B?MnpoSWNRRkJRNGlpbTd4b2NzNlRBN3hnMEc3cE1EU09BaHNOY2psWEhtY29u?=
 =?utf-8?B?Z2tDcUo0NnE5VFFzaW05U2NkU0Q2VzU0c1MyQkgxalRSUGlPVEdtZzZ2aXkw?=
 =?utf-8?B?R2dCc3RoU21jQXpDNE96L215dURDRGtOR2ZyK2NUQVE2UHRqazVvNHVZMmVU?=
 =?utf-8?B?SU1hUW1BdFF4bTVlUVRRdkFTeS9wOW5JejdVZ1g4Qnk0azU1eThJS0ZQdGsy?=
 =?utf-8?B?dGN6a2hEbWFWdGJKRk5leDdEZlBvejNzOWNXV1V1NkVVaHVQWmdmSjdXdU1C?=
 =?utf-8?B?b1RvWW9FdFAyVVNqSFRjc0pHbzVwRWZOTUJOUFRNREliMWFTaHFtZHc4RHNz?=
 =?utf-8?B?VHAvVUhySXNwUzNWV0lybnduUGZiSXBiREcyRFp3bnBQVmVVZmorTklSTHRl?=
 =?utf-8?B?UUFKa3N1TC9HWnNrRmF4YUlsOTFyem9ObURvNDA5QzZYanM4TW16VWkxTXR3?=
 =?utf-8?B?R1RQN3hpN09kSnF1TThXOU5SdmErUGNwREtzUElCVmRvZ1F3WWRJWFp6QkdN?=
 =?utf-8?B?MUNENXo4U2gyN3d3OXlnbkw2L1FTb3hPY1ExRldUbEhnV3o2VDJrQVhRR3d4?=
 =?utf-8?B?eEp1RWNPQXZ4bjVqSkdQN2J1Y3djVHJxZk8zaGM0NjBLQ00vbWpoWlAzSjBp?=
 =?utf-8?B?SkVHTkhpU0lBcGpSODVJS3dZN2d4Rmt1amFOaHdWaUxmaXpqYWdIbWFGajhi?=
 =?utf-8?B?WmJsQmtMR1RkTFo1MklCUktKYjI5dHU4bllvTE5TNm1wNDRLRkJaZ0pNZklB?=
 =?utf-8?B?Z1paQ1kwTC9uM05yZHlPK3pqdmZ1U3c0TWFvK1lNU1h4K2xYVUlTZmpPamla?=
 =?utf-8?B?eDh4UlpkK2grak55NWlZNFQvdjZ3ZHcwbk0wcnR1UkEzVFBpcUwrd1EyTGdr?=
 =?utf-8?B?WDMrN2pFbGlVcWlhbWJzVTVYNG5sNW93dUYwWEZiRGRKeWcvbFhOSFY5REo2?=
 =?utf-8?B?cnRlcy9VZm5sR3djQ0RwaFJGdkxpTjZ1WXdMWHUyUHVQTUszaGNTMmE4bHRK?=
 =?utf-8?B?YW5EUkRNaTQ2Rm5jWU9wZFJXRm1KaTVDWHJ0eU43VW55R0pJbFo2SGhkemxF?=
 =?utf-8?B?ZUwzK2NOSEl0L0QzWkRGcytXQjNiSGFST2NBeXU0eitNcktHbjQvdFhmVWpX?=
 =?utf-8?B?U1pHci90UEpEM1JWZmdLbkZOUi9zeStaRmx1QmlwRUM1aER3NXBDZzRGeTli?=
 =?utf-8?B?SDFveWx1azdIM0V0SnNxQVRLVFp0QWRBQ2pyTG45SDFwN0NiZE15ZUZJUFV5?=
 =?utf-8?B?RlV0YlNINmIxYk95R0RZN3pFQlVFRmxDSWYxSDg1cWU5bXVmRTNkS3A5d0hw?=
 =?utf-8?B?MXpSQT09?=
X-Microsoft-Antispam-Message-Info: tPYrmKWDmPaltqGeUPOUACGrG5UBrP6FiKFPZUe9TJgIKJdRkkStH5YfdipDK7lkabgOI3yiY9JkJIyS5/DmKpir/XdM9IST/azr/aa+zb5hA3BbUH60KBnCsqgJOTApZN2JMj1YGaTQuh8vF1tewh0JKXd7uD0Fv9W2OxGd03uJIu8LZ5yACkCUzkLquwfM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:XLJsNH9o8EoTDVxS3NZaoJPfD11jwMPvIzeVDV/sJ1TLDLNCEOxmdPKIHFZ7X3hdnWVICixPRdtfwDpqvgwlceozscfSH5qyUUTmQCxSBbUd8ZztrmiLOIet/ijetswf4jVsFOLK0kBZEPkrK9ObRTqKYnQ3v9BFFYEZT3UaIBpOT5UdrqUiiS304qpHyJTZ1fKLLA2QLsAY5uLIMrjh3Qf0dKPmVWsnfmJIj5TNK52qbgRdH99iKX8eNQu9zkNmKl3ak6l4XOsLLlBGvoY0HiOVRyoF2sndzPRP/t/fJVbhPVUhV367ZUNOlduTtnnwQyCYY5/tfQZ1jB/eFNHGM14+KBRMcuWaq+Yzf0wAIfJvzcKYYCSoWpcgSmoE5MPSI9y/5JTQyqeMxxWZEsfKOGuo/HQi7EynVSzwKJlGF81nMDahip3sIrz0oHQciGq3R7cvlNiGnx1bL5Wg+iWa8g==;5:yjJwUufOOKo7Nijd9sqPqPIqpkN+jitmpPNYTMwVHhZHvzA0jmEMXFzMpNsr2FU/lYEB+a7dVmIeiJBephjbRzDOsGRKSnN6bMpicZo/cWluSJ5GGNeWXv59gt8WLun1KCtl9rS8UmSyrSIxJ+dunnlg6imkt5gNusRuVk3ywCw=;24:lFJv7ND8V3okP5uMjS4KMvEqPrW+5Nxenp2uSf+uN5E0LDz6ES+wDNsEtMIhKYjzbncni6e82mbS+DNc8drWc5u4QttHNR0SOL2LGREAaB8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:r6fi6Ks2s0c2V4R5FTWbKHCd87I1Ka6sHsrOdzk2L8y+1C2Y1inUynH/5C62+XojMqu/tvnFTdlfyumJFqhoz5SvkC2g6GJjWJp7fv/i3yU0UhwKhnqh5OXT78dMZ7I0lGxtYtZgvieG9t4MdKL2kDSSWBzf4wSU+rcG9yA+KPNBzTJxI2R2xOaDHaYBBP+4jo7QlCfDTqg8GBMJxMjNJctjaLIjaippepKo8r9Xpoo/Whilb2+liiJTQiLVo/mj;20:hM5Cp/HIgh2jjtQWRfCGxaMUUmKqn6UNYGabEqUb/tuNZnW10/i9neshpUqNIZvrLPeFnze7wlTl9nHDGC/gJdr7A41mNfGf3mXJ9QrTy/rx/WJktUeTtpG/jMU7Z4aVRCmanpK+pNSvLmVLqOefYLol9BDyW6KNafGfY6/iHGY=
X-MS-Office365-Filtering-Correlation-Id: 095aea17-6283-41b2-11ab-08d5c7b04970
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 11:10:29.7733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095aea17-6283-41b2-11ab-08d5c7b04970
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2018 11:16, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d60d61f36b8f Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101bb52f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f1a04e374a635efc426
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13b9ed2f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com
> 
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> IPVS: ftp: loaded support on port[0] = 21
> WARNING: CPU: 0 PID: 6 at net/kcm/kcmsock.c:2023 kcm_exit_net+0x392/0x3e0 net/kcm/kcmsock.c:2023
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.17.0-rc7+ #75
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: netns cleanup_net
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  panic+0x22f/0x4de kernel/panic.c:184
>  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:kcm_exit_net+0x392/0x3e0 net/kcm/kcmsock.c:2023
> RSP: 0018:ffff8801d9a97430 EFLAGS: 00010293
> RAX: ffff8801d9a88180 RBX: 1ffff1003b352e86 RCX: 1ffff1003b351135
> RDX: 0000000000000000 RSI: ffffffff86d56942 RDI: 0000000000000286
> RBP: ffff8801d9a974f8 R08: 1ffff1003b352e67 R09: ffffed003b5c46d2
> R10: 0000000000000003 R11: 0000000000000003 R12: 1ffff1003b352e8a
> R13: ffff8801d9a974d0 R14: ffff8801d96763d0 R15: ffff8801c51d0e00
>  ops_exit_list.isra.7+0xb0/0x160 net/core/net_namespace.c:152
>  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

How about this?

[PATCH]kcm: Fix use-after-free caused by clonned sockets

kcm_clone() creates kernel socket, which does not take net counter.
Thus, the net may die before the socket is completely destructed,
i.e. kcm_exit_net() is executed before kcm_done().

Reported-by: syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d67734c99027..84b7d5c6fec8 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1671,7 +1671,7 @@ static struct file *kcm_clone(struct socket *osock)
 	__module_get(newsock->ops->owner);
 
 	newsk = sk_alloc(sock_net(osock->sk), PF_KCM, GFP_KERNEL,
-			 &kcm_proto, true);
+			 &kcm_proto, false);
 	if (!newsk) {
 		sock_release(newsock);
 		return ERR_PTR(-ENOMEM);
