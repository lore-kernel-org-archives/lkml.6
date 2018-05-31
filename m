Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbeEaJ7J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:59:09 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:24640
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754212AbeEaJ7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:59:04 -0400
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
Message-ID: <4b0d0053-60f4-ac5e-f228-4c19c46d85ef@virtuozzo.com>
Date: Thu, 31 May 2018 12:58:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000000dca5056d7c1442@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::17) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:4gfoh7AvBzpfTf4MYuVIuwgqzMfIpii0buTqlysZC5oFHCuzDbD3H9OkcPs8CamHBOUpwB+RODZAeIAMzCYnFkvHBXlUD7E3z2MBWguv/R9ZExJYrJ/GCUA9RzY/U/c1tw0/F7dB0RqY5DsaPN9KjsrzUvBBrIv1HmDsubxwTlC+KV4Ba3MwxGZ4QzzX4+xW7t8uZGz8v1H+jKgbrbHTPm/LAJ4fYkl1TGNIex/b/TYVkzY42CfsRMbm+wzsf+E8;25:4/vZXf+gROZPywtU0MEDc5d8I28kov5Yeq5klJdNrrCpwRBSR3i3bnz/bRyN5gQBiGG2A1ObE/uMMOFbwYJHyoesC35mzkroHkpvo/BpQjh1LYVLPpxkSA5vOyvLMgytnnt76yKirAO3qZexZoj0JfqjiPenpb4kJLuelQjgLLUMAvUBWxYigAsw6Ttkg9V4+Xhzlg/u3m5iFQvQm3g3J3wxtbWelT+PHb+k8y1AbCWxcXmN8AAa5yKwlsG2wa0qhoQn+BAbeIFrsdXkPnm6bstpyGg0JTOGCDvsv4tJBGyfh03yuOBaPkYa5aumihhdw/60v0SXDpp5VEsZpgMArw==;31:MfR21G+OT6yiXHLKaluZ45v/F7X1NDNeG5e0MJEPRK9OnbIf+3GX9WEC7IQ3bKyiYShLmmDIPIOPLUNXp62yRmc/87lWLVjGv9aWlEz5jis1QqIi1hyIfYSZnVkm9sKdDLca54MjsZbMOOqzAOts9Orwjb44GjblYzJfQPyULIyPcjst9aagDv1NUFbxzrF/sXC1bN4hGAmoet3+8OUPgxj58mQhJxaGB9QipAu6WFE=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:uW7c5usMrlwNJnrc5Jgj/Oo1eAwVJMO4ADvUZHB1JbvJh2ztxxQ8DZxsXZfu3vmKFhQT+58KnnVhtPtQzp+h4CP5AggNxiIF+w5/WmS/4cDhhMzQ+vb7EYYKooOuBz1lwLQyAmB2j4n3yhm6zJ9xDTQeEMz+ySQqXBS1AX1OPSD7ZxN2Tgb6U9y4eQLaan9WKxn4ARjL8GUJS4YUEBUXDQzsvbPVPQW73oj46XW7Ngcj5IAXwe7or+Ag0FUoR+mBlXNvEMxeGNPv7tpy1o1npn3Nh2h0Qz8UHvZJ2iijc2XVwtGq6PS+o1NdU6ALp+MlHwZMUTwvUH9MSBw9BkCYVq22yT6TcR5pGCMuIaaayFzZtBEFdfS9GOjsLv3LLN6vObmBqJ4//Dcz96qo0s8yDlPTfvAciRLzvw+LG41gDSlgYiy1AMfAJ0vofiIxlmFf+mMfk/a0h53cRZvlPbSwVjmoqSE8BkMWg+mSFY12FgiQLp0A+J7BdJUK+mUYNFIh;4:tpKb7PO6ZsaRK1nsU6qLRtg9wGOpjgNYSPE+j/uQOl9lplUvMX88UJQGC8ohojjCCPvNW/sq6Kg7XzLgiWKNZAW7Tjn8IvODFW/7ZFLZKkGVmpQQU6l73Glcl6tTdVCmHsDJbGgYBSdQwbXf/XMEXG+9C1eA//LSmV4I7eG5LUbO3/oaoe3Tehj3ng6+ZzWOJtHEWtcLKQVh8dEHGMOsafRCZi892IhUaqT3k3dfkST3UqzyoxXdPpDp4RRYSQtw2eTO3ldzuY7kwAmKL5uSoila/D8+ZLCY/zvc0YUarpZnadAWEkSbzHfNHpPCzIR/
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344324B259BD2C247871FBDCD630@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(396003)(376002)(366004)(39850400004)(199004)(189003)(51234002)(186003)(53546011)(106356001)(86362001)(77096007)(16526019)(6666003)(446003)(11346002)(31686004)(65826007)(55236004)(386003)(59450400001)(52116002)(76176011)(53936002)(2486003)(52146003)(23676004)(68736007)(6116002)(3846002)(476003)(50466002)(26005)(956004)(2616005)(105586002)(11609785009)(7116003)(65956001)(66066001)(65806001)(486006)(6246003)(5660300001)(47776003)(64126003)(58126008)(16576012)(6306002)(478600001)(36756003)(316002)(25786009)(8676002)(2870700001)(81166006)(7736002)(305945005)(81156014)(2906002)(8936002)(229853002)(6486002)(575784001)(31696002)(97736004)(966005)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6QmkrMUU5UWkzaXhpSWRHMWJOUmZYVlR3?=
 =?utf-8?B?d1V2YzhzT054c3J3enA4TzRsS0UzOEpOVGdwd1R5cFBvN0xKay9DTVRPekhP?=
 =?utf-8?B?Wm96NlBIZktzVjlVcWprclBGNGtrbG9CNC9EVjhtQWQ1Z1JqOTJsZ2I0TnQz?=
 =?utf-8?B?NG1IajByZGJSTm42ZHowcFE5MEw4NFhUdElwNjRmYUhoTzhRMStwUUp3TDJD?=
 =?utf-8?B?MDRzbmZLTzR0MWR6NDg2ajRvb0JMZzdTT0ZaUjB4NDNIOWFNWnRaTE1ObFRE?=
 =?utf-8?B?NXB2UnZqT2ppcGdtVlhSd3VSMUhtOW1BY1ZVdXZHV2w5S3ZEMVFsai80VHJ4?=
 =?utf-8?B?ZXNWN0p3MktuRDdwbmtHUlJKcVVLRWp5ekwwY1JBWDF4UXI1SGFxcDY0SmZE?=
 =?utf-8?B?dXV1N09XN3hJTXRYcDlOcXhGc1dlNmVpZVNiY282amhFSVhrQ1F1TE9Uekpo?=
 =?utf-8?B?ZktQL3NuRlJNQi9oTWxLaWpCaDFzdWpRMHBTZXRESU1obGZjd0pvMnZsTUNx?=
 =?utf-8?B?WGEzNnJ6NWNwNFNvVk9wN3NVRDFlU09GVlAxV1Q4WDJSRWZGbDVmNlpVOG0z?=
 =?utf-8?B?UEhXZXR4NXB5U1ovUjcxUUhvbjVlOGVSbTVRSGRPLzl4cFptcTdhcTBRWjJ1?=
 =?utf-8?B?UzdBMlFoV000cmx3TnVpQ2drZkdqek5tdHAzTnFMS3ZmbVMvT2xYZy9ObXRj?=
 =?utf-8?B?ZlFxaldZMmF1T1dlVjFMVEtDUmFzV2VOZjhYMDJONU02bjFBeEJLTUZvN0Ra?=
 =?utf-8?B?dU5ZR1NHcHhQSjdyQSs1N3VnUUlXOThMRnVPeWhSbzhNSHVKR2NibTdFaE9J?=
 =?utf-8?B?NTFwT3hvT29VaWQ1YXNST2FPSkl4NHlGNFR3SWljcFdBYXozQU5DV3lFVXdq?=
 =?utf-8?B?K0ZiUTlMaytha0NMa2pia3NWT0dIMUpKemxqMFY4dFpubXJhVFNaTmQwcnJN?=
 =?utf-8?B?dDQ1QjRZbWppeElMS3ErVllLYUtsQVpRdlkzWW5MaGsyUEoxVW9xOVptb1pF?=
 =?utf-8?B?MjhhRlQzaDVoNTgvc3lwNUxXa3RFNHlEMlJDQlF5bkpaRXV4UFJmYkgyQ01o?=
 =?utf-8?B?ajQ0bjFUYW91ZnJSVlZjUVgwVExScHpacDdaQmNrYjE0QkE3TTdUUHkzbnNP?=
 =?utf-8?B?enR0VzJzU0pxZ3M5ZlhGNjAzTXBRYldNajBzbkxqeVpRRmN0d2JXZFE2SHBp?=
 =?utf-8?B?SWJTTW5UaENsU2Q4R1hhQXhQTklnSDFCbTdicVZHVGF6S3FQUGdJbXg0UDNk?=
 =?utf-8?B?dDQ2ZFFmYXhpY2pZVXpKam1rRUFRVW54SEh0L0Z1bnFXZFNybkRDRDlOSmZE?=
 =?utf-8?B?a24zUXJtYVZMYUJZNkFXNWF0bFlHNWk3bm9hUjVHOUVZdzVEZHdWcmFHYmRU?=
 =?utf-8?B?c0EwRUVZSlJRSGg2SldiZDNwN1JHRW5oRDhBYWlFbEZQQVFUZVp6dDBRbE1y?=
 =?utf-8?B?N29JQkdnVGVXMXFla29MRjJTT1ZyUTkvaGJBV3k3YzJiUVl3Qys4Y0UyekJv?=
 =?utf-8?B?UG5rQ1ZPWUlRWjRVQzZGQlRpcFM4UldjYzY2ZnJsbE5Ed21TY2YrR2c5eU9S?=
 =?utf-8?B?bm5EazZhYm9zUEtEVjFsRUs3dGFjZ3B0TVA4OFNvTWlraUE0czVKOHJKNUoy?=
 =?utf-8?B?cjd6OUo5R01zS3VVSUdGVXZtT1JSaWw2cUpSUnA3a09icVpVM2Q4VUc0dGI4?=
 =?utf-8?B?azI0SlI1U2ZDYmRTUmVUWFIxZDZmTjY1eEpQbVpVUHJPb2NWaVNsUjNOZHdM?=
 =?utf-8?B?LzNUWUhhQmFuM3k3bWp4S2ZBTXNzcXROZ0syL3JFdjVDUHJwWUFnaEM4aXhs?=
 =?utf-8?B?SGZnZE05clpjQmpacDdENFJIZDhadDhLOGFKeE5XQlRQcGVWYXk1NmIyb0tR?=
 =?utf-8?B?RU1pdWdScmQ4SS9BSGUzTTdyeGd5TTlJeUtuaWRPbEIyb01sSW1qVkx4TlVw?=
 =?utf-8?B?cDZCcmRtNlhqZ0NPMVVoNDNjdmthcTVzaXVreVgrTTRCOEczK3piZktZVFN2?=
 =?utf-8?B?L1dXYnpkSFk4aEd1Ky9jNURSWitzYjJiVFA5eHpRMUhrUVl2eHg3OHc4WUJT?=
 =?utf-8?B?Z1dSelJTTUtVbDlsOS9yQWJHYnRlTHA1ek01Z3BXQXZDT1JUTU9saXdLeHIx?=
 =?utf-8?Q?Cb8TotN23pWZlhlXEixOFqq9QbR9eRF7gHh/HIyGk1f7lh?=
X-Microsoft-Antispam-Message-Info: 13U+WkWChtCXAK+4mi0ap5nU622y8Lbvokzh1TLF0g/rByHsBVcioMuO6NJjPoNXJZpfFqnpIj5zcXv3EHnRcAy7UcRjepR2PRdoQco9cVD7mqjTFs08sccy3w0SgJH6ztrWyXNgCXbjZcHcg/s1wvo9a6RXbz7x73GrulplUpZQKl6vjUMgvXJz7pjluA6l
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:N/93Wv5abLzHenh5zsJlDgDK5EvCEnJ/B6rZQuGSutjGHFx5+MSkQX1XmNwgn0xATxqhxaDFec8y1aX23zIB7CFQPSyLE0PubGMwzK9ZFlumTsh8dHHx8jvJSjqy5zWVPHrgMQVIMJFUnhztnj1fO9QFre8eMkHnMVL0wd4cgfek2cKhnj+ORaVb6LUumCXXRDawt6zZjjY7UnvJzJvm8Sj0SmCvCN3gYmJ1qkFaU2rs5i/d2ITBKmIkqhEFfoAtainVt5k2Kt9TI4DRsa789+sR7CQb470BzNZjoWxT7lM0XF6yL3AtUIp439kYTwQMFN8AEmXKgmTOl9Q4u6cyFwoD75dLfGXk0LXTa1lB2guzLfM9qyS8A8iaEb9KJO6o4XwmteJhG8NtuWSx1rK5v0BcMcPGkTStIxRQ0EYgtVO7VduECuquk2RV3soRqTsTnitYTU+lXk08I9yjB3wYYg==;5:y8B0fYjkyoygrtw2Ffix0frht31K+oy3FCOJ7J10Lf88uLgjkzUJXFAvAW7diG3VRLfhexQpKin6vKDujdJiJUEQOK16tXQw47w7u4lm8jzFUKz0DW1i1hPC6ymkelX8B4L1fTwBZ659zyeEpx/XEK1/i0ZOjCiWPf0HhKBw+Ec=;24:HlO6Vxl08w2pBb5OrgvniKwscyRwVAaP7KUGaO1zPpsujUJ1T9aOWnBnZP2scxS2YFzJXV29JSPkN1MtySkOTAA76ombrAcGjOyE6fybQgU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:TMccgBq4mU+E862dp+pjmGuW+6x16xQOg2KJVjSoPAaoN6Sj1WlNtWdUZgnc8tTnxcR84PA/HnTVOvb8GjOWmIPmXJrjfyfPfjlNux7T9U+tVv1OhuEbxWKXlIcxcRHqQnOlF1KyD8aUtxkMhqYH448FifHaz6MHq6Ul/bXHQKzYafgEZv7mz6H3pF5H+4JIaSoFyjso3dkx6rnWqsdKaJsNxnJ5jvLIdh6tbGhYrgiSFckex+nN/wvWCmr6fQqs;20:cBrwmXBkDq4D3Rnae4FeJ3sVKwpuEfugdQ18J4ygAw+zDtbAG1phn6nLMpJpxvvxE4/X7Oy74ffBTRS2ilVhEeBMG8fNHeXnwQzw419OE5CNu7cvbwQ8qiC4OA8UeI+45Ps9bbFo1/1KFhT+DvRxLbf69J3yVyqBqHRpDT3dK98=
X-MS-Office365-Filtering-Correlation-Id: 76ec9725-45e3-4c49-d78e-08d5c6dd2248
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 09:59:00.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ec9725-45e3-4c49-d78e-08d5c6dd2248
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
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

Hm, there is allocated a kernel socket in kcm_clone(). It does not get net counter
and it seems kcm_done_work() may complete after kcm_exit_net() is completed. So,
it looks like we have to flush work queue in kcm_exit_net().

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
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
