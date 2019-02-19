Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4BB2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KC8U5mYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfBSJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:10:11 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:11264
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfBSJKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJSSVBmFEuloJyJne7RKvzgmumhdSJjRF6+srBzi0tY=;
 b=KC8U5mYDmcglcy7j+wHgpXEtU4t7qBquI5ZeHvrIcOB0a5Lk5WdKlhjzutQ5OJFvwdxbzvs+QupLWfF8yHoIEppUoqlocxQSlXcEnbQi8pBEz3Sr94czt31ZPLLk4U4V9hzMb/iK8FN+RDJEXSB1/2/fmiEyiY/lO6zIQn53cyo=
Received: from VI1PR0502MB3647.eurprd05.prod.outlook.com (52.134.7.141) by
 VI1PR0502MB3789.eurprd05.prod.outlook.com (52.134.9.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Tue, 19 Feb 2019 09:10:04 +0000
Received: from VI1PR0502MB3647.eurprd05.prod.outlook.com
 ([fe80::d058:d17:78fc:969a]) by VI1PR0502MB3647.eurprd05.prod.outlook.com
 ([fe80::d058:d17:78fc:969a%6]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 09:10:04 +0000
From:   Vlad Buslov <vladbu@mellanox.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     syzbot <syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in tc_ctl_chain
Thread-Topic: general protection fault in tc_ctl_chain
Thread-Index: AQHUw8Vzrh30F2c9RUGttr57G9vh4KXmAjOAgADcCgA=
Date:   Tue, 19 Feb 2019 09:10:04 +0000
Message-ID: <vbfa7isqh3r.fsf@mellanox.com>
References: <0000000000006694750581ca4139@google.com>
 <CAM_iQpW656Aafj860Gen-KOg8Pojg=q9+hDTgPvoaSK8qsg79A@mail.gmail.com>
In-Reply-To: <CAM_iQpW656Aafj860Gen-KOg8Pojg=q9+hDTgPvoaSK8qsg79A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:73::25) To VI1PR0502MB3647.eurprd05.prod.outlook.com
 (2603:10a6:803:f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.13.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c253cd-b7f4-480a-b617-08d6964a08cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3789;
x-ms-traffictypediagnostic: VI1PR0502MB3789:
x-ms-exchange-purlcount: 8
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0502MB3789;23:r1dHILhe84DVqYWnpUurMQjU5A5D8282t3d8z?=
 =?iso-8859-1?Q?5BX0KJuYGuEU9Yle/wY5Vpx3HVMeG/PzeZ0MG0/FpVPykwj9OG6X5xT59a?=
 =?iso-8859-1?Q?l+YrzvN9XGvWFOdoPtS1GLvMrJWz0qFxYrezS05MRUYr5kN9qIqgpWzLBo?=
 =?iso-8859-1?Q?d5Mxd4Ld94whTXt9V4NuqdKrwkssRcSHw3W5Mdpqna2fr8/TMT+zr5dCts?=
 =?iso-8859-1?Q?/xPt4i1qyRYB1dF6/Yn011W3kQx0zhZLDPpRaXvCZuAA+k8POcOYadCcH7?=
 =?iso-8859-1?Q?M6R0nJB48gPU1eL/YpefxRVsbZi/ihvgcrrdqJAEd1GRghO5LT/NVysoZ6?=
 =?iso-8859-1?Q?QBFGq3Eprhr67Cl3AbYpRhtP8vhA+J9hG58cd2+zs4qBqhjqUzNbLk4D+E?=
 =?iso-8859-1?Q?AV52s8Z5OqtAg4IE53yUeasfwlFe/TeZIK89/fQdrDqwfm6Lh57rETXs1R?=
 =?iso-8859-1?Q?LSCSky+0yNEIIWW1yFAqsGC5SeDieLV+XOsxcwPR5eg+czJwqN6/Fsv2XH?=
 =?iso-8859-1?Q?89ALzmxO5BqUhUhzQri3KYQA8Edd24Xw8MPPU7MSXWHQNY0guiTTw5YpEZ?=
 =?iso-8859-1?Q?MoGubUYfHkH9+5YMFmavv9JcggfUwvDZzjzJmfoolgjGZD1TGX6Kx/+PPK?=
 =?iso-8859-1?Q?LJGlvW7P4igBZHcljamJSQQ7DjHOA++6yZ80EOWcfMKREA2eIQQfnCAPeQ?=
 =?iso-8859-1?Q?XDNqzwdR2uuG2XxzIOVIKsJPoXVYpFHW+slahkTHrqksiX2gasmQtoLKuI?=
 =?iso-8859-1?Q?4aTgiN230CMpWdW1FqDdVcdtf0ZG+81HdXumlzUvyOJ2ia8vZDrYgIvM4I?=
 =?iso-8859-1?Q?XoQdocRMvvmJgNQmeF+MqVmaFXonwIkLoQnhY4IKEPMh8oMRYZ3pwvHwQS?=
 =?iso-8859-1?Q?jCcgVX2GuJKLdNyKJzW1DZPH0LcX5d1kRm7YCslppIWVKrVYQFnms/RLnp?=
 =?iso-8859-1?Q?SMsMy4E7DFSOcCOkyr+I4clkjaS6kWBoL3nE0cz1zqkBG4wDcTkX6lyp6h?=
 =?iso-8859-1?Q?/mnqAhzA0U5nf2u9bSmpvEvhOG2BdmbPsGJsXZ04z/eaOTKh1etbG+36K9?=
 =?iso-8859-1?Q?z65Is5gJYC12sfQiNNWP/x5GcMhJP4TMOiegbECZtRht6LFr9cPx+XTr+u?=
 =?iso-8859-1?Q?FUfC4DZlSBts6pfJKi+TF3fHh0Ioi6DeWd/+I1xThJ81F1bs7uIENM8jBY?=
 =?iso-8859-1?Q?zzy7PvytU623SmbczsupFHiHw66lbdX2YRZ4Gb4CfigyS7QLHxKj6NuUND?=
 =?iso-8859-1?Q?f9az5jeWDxufzOotgqoI1ximj9okJ3SIsctaEOqkZ7o6j1xoSHQxpZY1c9?=
 =?iso-8859-1?Q?/fWClb7a2Ejo/G+MlyqFOYkw3y5hlGWVV1g9QQwisUYDOskn8e1zJ0gIay?=
 =?iso-8859-1?Q?NdXQjOiTANUd0NiTH/zuTSiAVjVg6qb?=
x-microsoft-antispam-prvs: <VI1PR0502MB37892D1EF642B4BA13E70844AD7C0@VI1PR0502MB3789.eurprd05.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(199004)(189003)(105586002)(6246003)(6512007)(25786009)(6306002)(4326008)(305945005)(76176011)(53936002)(6436002)(6486002)(7736002)(52116002)(106356001)(229853002)(66066001)(8936002)(54906003)(476003)(45080400002)(2616005)(6116002)(3846002)(11346002)(316002)(446003)(6916009)(68736007)(14454004)(966005)(99286004)(486006)(81166006)(478600001)(5660300002)(8676002)(71200400001)(81156014)(71190400001)(97736004)(36756003)(86362001)(53546011)(14444005)(186003)(26005)(256004)(102836004)(2906002)(386003)(6506007)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3789;H:VI1PR0502MB3647.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8nVRGC1eDhlTpI1H7PmuKg5Je+FWKt7+Cj/KNxM+EPAA3pSvdktA5r/lrcIePM9utmV8sqaE58lqNnM9bYOPN30ky7v58q4tlmnnto6PBpC9ztsuRLTtXkBRlGqTFjjCrbf6sttqPgEMY3S2zz0Hj5VL3n/2HarqpgkyqQvEj4JOSthkOux2FqN09JnGe0AqZwGFfLdcUl0rqiOD5a8ZiUxCT/CYCUY6QN/6Ma2TF8SRWmPjlNZXyVJlllh6ltLcVq52D6NZJLZvwvnDEYYC1DTPureEBfnaXG3cdisJDyiy1vKYzSj5RBx63Yz1hfp9xyo7AZkBMv9qZY8Lz4Kpcnn8dqxd1TEWnuUcuT0keGUXP+OesDnzUFoSfVVZ158Uw+x2yc3+LhTp+Uwo9K3Jlef5coHAmzZNcWPQsTqOBkE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c253cd-b7f4-480a-b617-08d6964a08cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 09:10:02.8706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is fixed by Dan Carpenter's patch "net: sched: potential NULL
dereference in tcf_block_find()" that was submitted yesterday.

On Mon 18 Feb 2019 at 20:02, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> (Cc'ing Vlad, please fix it)
>
> On Wed, Feb 13, 2019 at 9:56 AM syzbot
> <syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bd3606c29fcc rocker: Remove port_attr_bridge_flags_get a=
ss..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D121bbf874000=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8572a6e46612=
25f4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Deff9cae063e4b6=
33c6c1
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11cbd404c0=
0000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17fc80d4c000=
00
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:
>> Reported-by: syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com
>>
>> audit: type=3D1800 audit(1550028783.638:30): pid=3D7517 uid=3D0 auid=3D4=
294967295
>> ses=3D4294967295 subj=3D=3Dunconfined op=3Dcollect_data cause=3Dfailed(d=
irectio)
>> comm=3D"startpar" name=3D"rmnologin" dev=3D"sda1" ino=3D2423 res=3D0
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 7669 Comm: syz-executor789 Not tainted 5.0.0-rc5+ #60
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
>> Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 =
5f
>> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0=
f
>> 85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
>> RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
>> RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
>> R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
>> FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:000000000000=
0000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0
>> Call Trace:
>>   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
>>   __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>>   __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
>>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>>   tc_ctl_chain+0x42f/0x11a0 net/sched/cls_api.c:2812
>>   rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5192
>>   netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
>>   rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5210
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>>   netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
>>   netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
>>   sock_sendmsg_nosec net/socket.c:621 [inline]
>>   sock_sendmsg+0xdd/0x130 net/socket.c:631
>>   ___sys_sendmsg+0x806/0x930 net/socket.c:2136
>>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2174
>>   __do_sys_sendmsg net/socket.c:2183 [inline]
>>   __se_sys_sendmsg net/socket.c:2181 [inline]
>>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2181
>>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x4400d9
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 =
f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f
>> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffd09281608 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400d9
>> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
>> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401960
>> R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000
>> Modules linked in:
>> ---[ end trace 25ab48d993ef9249 ]---
>> RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
>> Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 =
5f
>> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0=
f
>> 85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
>> RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
>> RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
>> R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
>> FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:000000000000=
0000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches

