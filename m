Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDCRQS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:16:18 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:60190 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeDCRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:16:13 -0400
X-AuditID: c1b4fb2d-1f6969c0000073d9-41-5ac3b6dbddbf
From: Jon Maloy <jon.maloy@ericsson.com>
To: syzbot <syzbot+4859fe19555ea87c42f3@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
Subject: RE: general protection fault in tipc_nametbl_unsubscribe
Thread-Topic: general protection fault in tipc_nametbl_unsubscribe
Thread-Index: AQHTykgM4wuO31XXiEmzD0aG2jIsLaPvScXw
Date: Tue, 3 Apr 2018 17:16:02 +0000
Message-ID: <BN6PR15MB155377C9481B35729260748C9AA50@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <000000000000a7c16a0568d750ce@google.com>
In-Reply-To: <000000000000a7c16a0568d750ce@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1441;7:85vhrLNr1hC6+Z5RX36AWJYz8CuD2FNT84BP3cyqbzLNCxCLXvorcVdQkivpdKLj01J4fL5HLj8mrzAvDr+HDWqpSslqfEZU8SWEwyxlIXMZIedNMDGr9781pIIIjOqegNVaocFiml612br2QzTSD6+IrHEa8ZTUVSQohb1pDQdh/X5J5T1KW+xosblrTGQz6wzreUe2U1bD1/REFoLp4pL++WlJLeBGiwg6WJglDliqpeaLLk1yDUAMa6y4bs43
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bd441add-db9a-4663-857f-08d5998693f6
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1441;
x-ms-traffictypediagnostic: BN6PR15MB1441:
x-microsoft-antispam-prvs: <BN6PR15MB144164849EB5024B2A20F3999AA50@BN6PR15MB1441.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(215639381216008)(9452136761055)(148501403981450)(42262312472803)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR15MB1441;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1441;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(13464003)(11346002)(2501003)(76176011)(55016002)(6116002)(3846002)(9686003)(6306002)(6436002)(53936002)(186003)(476003)(97736004)(99286004)(486005)(486005)(26005)(105586002)(77096007)(59450400001)(86362001)(229853002)(446003)(53546011)(5890100001)(7696005)(6506007)(2201001)(575784001)(102836004)(33656002)(5660300001)(110136005)(8676002)(68736007)(81166006)(81156014)(11609785009)(74316002)(478600001)(45080400002)(106356001)(6246003)(25786009)(316002)(14454004)(2900100001)(966005)(3280700002)(66066001)(8936002)(7736002)(3660700001)(305945005)(2906002)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1441;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jq99TASE0H14AIvdTnLTIa+2f6Tfhz85dVOYnHk0o51/EnseCazEM7833bTdfAAzSSuiLm1JGTxA9slzUTmU2Z/HlzAQEXoTrNFwp6kSZQy0+fBvM7qApNbbdmo5Aauw1SUvKIedoUXGybkgSUlPmSUyitVm03xesVseBVZmGa634soROFtmf1j6iigKgsUwHDH4l/jaP0M1Msr4NQIyyc8qpV+Qud0osulGxM5HA1jC+u+uoCRHvmU+uIO0BpHoHlmty3zlAEZYSLKQwuROAPz9cXTa5sigCBgkj0vcjw4jO3NW6DPL5/KS/vQ8WFM55RUelzByVO1DVzBfoZSw+XDPrxk6svoHrbibMBGpf8urCfJ6YQNgxZ4fhP6FHuo17CpAZyorK78E3pSgVjDfnzN/YnhUHiM+rVTndcgGJSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd441add-db9a-4663-857f-08d5998693f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 17:16:02.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1441
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z+zy1Ec/FtOXxRFV0hKXrKUE4hoZOxLEHQhl6CjHXR55Rwz
        Lap9CApdF8Vl3pqiEk5DcdN0WngvrRA1dNa+ZDOyCDVNEy9r2zHo2/M+P3ie94WXIqWtQj9K
        k5PPsDmqLLnIU1B58cW5cFvXkDJKayHpmok7AnraUiOiR+t8aMPvs7TVXEvS5okr9JfZWTJB
        rDA3zxGKvtIxkaK3bpVQVP4MUax2BCrazJ3EGZHSM07NZGkKGDYyPs0zw1bxWpRnjC98N7kl
        1iJbXDHyoAAfg7v6cVSMPCkpHkZg2ykRuYAUmxD82Q3lwTqC7g+jYn5oJKD663uhaxDgXwR0
        DC8IeVJGwJsGB8EPIwgM0+2EK0yED8Hi43vuFm/cRYJjR4dcYD9OBPvSmrvRG5+A59ZqxOto
        0G32O2MpZ8dBmFghXbYEp0Dd9jpy2VIcA4ZXRS7bA8dCk33cnYKwD2yMt7prSewLH+0Ggj8U
        Q2PfBMlrGSx+2XWnI5wMbxeSeTsYBrrbhbwOgClDiXtjwGYCKiy9Ih6Ew7Jev5dzGowtI3v+
        HILSUQ9eh8GU476Y15mw+6CB5INqEJj0HXugiYTh+pOPUFTVf7tWOXcicSi0WSJ5OxjKSz6L
        q9zX74OxSrugDgmMSMYxHJedHn00gmE1lzkuNycih8nvQM4fGjBvhXejlh+JgwhTSO4lEVYP
        KaVCVQFXlD2IgCLl3pIgk9OSqFVF1xk2N5W9msVwg8ifEsh9JRHGPqUUp6vymUyGyWPYf5Sg
        PPy06GZtoG9CSWzPbj+Xbls+H4Oo47YAYYpONqOvUGuMZfW3Ziy6tOkDrcVL1hVjTbnV0Z56
        Q+1lUk4Obgjmzbqn2m8r7Nrh72hqrNW/PzbvVPN20m15UuMzuXe7rPOTQxnSHVAe+bDMfsE0
        Up+V8eRl7/yml9c0HdRTeM3n0samXMBlqI6EkSyn+gsNmgajPwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w33HGOWm017246

#syz dup: general protection fault in __list_del_entry_valid (3)

> -----Original Message-----
> From: syzbot
> [mailto:syzbot+4859fe19555ea87c42f3@syzkaller.appspotmail.com]
> Sent: Monday, April 02, 2018 02:01
> To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net;
> ying.xue@windriver.com
> Subject: general protection fault in tipc_nametbl_unsubscribe
> 
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018
> +0000) Merge branch 'perf-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=4859fe19555ea87c42f3
> 
> So far this crash happened 3 times on upstream.
> C reproducer:
> https://syzkaller.appspot.com/x/repro.c?id=4775372465897472
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4868734988582912
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5073802094444544
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4859fe19555ea87c42f3@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for details.
> If you forward the report, please keep this part and the footer.
> 
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000 Name
> sequence creation failed, no memory Failed to create subscription for
> {24576,0,4294967295}
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN Dumping ftrace buffer:
>     (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 4447 Comm: syzkaller851181 Not tainted 4.16.0-rc7+ #374
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> RSP: 0018:ffff8801ae1aef48 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801cf54c760 RDI: ffff8801cf54c768
> RBP: ffff8801ae1aef60 R08: 1ffff10035c35cff R09: ffffffff89956150
> R10: ffff8801ae1aee28 R11: 000000000000168a R12: ffffffff87745ea0
> R13: ffff8801ae1af100 R14: ffff8801cf54c760 R15: ffff8801cf4c8cc0
> FS:  0000000000000000(0000) GS:ffff8801db100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dce15c3090 CR3: 000000000846a002 CR4: 00000000001606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Call
> Trace:
>   __list_del_entry include/linux/list.h:117 [inline]
>   list_del_init include/linux/list.h:159 [inline]
>   tipc_nametbl_unsubscribe+0x318/0x990 net/tipc/name_table.c:848
>   tipc_subscrb_subscrp_delete+0x1e9/0x460 net/tipc/subscr.c:212
>   tipc_subscrb_delete net/tipc/subscr.c:242 [inline]
>   tipc_subscrb_release_cb+0x17/0x30 net/tipc/subscr.c:321
>   tipc_topsrv_kern_unsubscr+0x2c3/0x430 net/tipc/server.c:535
>   tipc_group_delete+0x2c0/0x3d0 net/tipc/group.c:231
>   tipc_sk_leave+0x10b/0x200 net/tipc/socket.c:2795
>   tipc_release+0x154/0xff0 net/tipc/socket.c:577
>   sock_release+0x8d/0x1e0 net/socket.c:595
>   sock_close+0x16/0x20 net/socket.c:1149
>   __fput+0x327/0x7e0 fs/file_table.c:209
>   ____fput+0x15/0x20 fs/file_table.c:243
>   task_work_run+0x199/0x270 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>   do_group_exit+0x149/0x400 kernel/exit.c:968
>   SYSC_exit_group kernel/exit.c:979 [inline]
>   SyS_exit_group+0x1d/0x20 kernel/exit.c:977
>   do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43f228
> RSP: 002b:00007ffde31217e8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f228
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf308 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 00000000204ee000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> Code: 00 00 00 00 ad de 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48 89 da 48
> 39 c3 74 65 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00
> 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8
> RIP: __list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51 RSP:
> ffff8801ae1aef48
> ---[ end trace ba18c1598e2d5535 ]---
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch and provide the patch inline or as an
> attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report If it's a one-off invalid bug report,
> please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug report.
> Note: all commands must start from beginning of the line in the email body.
