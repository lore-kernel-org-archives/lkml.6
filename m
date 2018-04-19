Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753804AbeDSQM0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:12:26 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:11092
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753412AbeDSQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:12:24 -0400
From: Parav Pandit <parav@mellanox.com>
To: syzbot <syzbot+17c13600b3977aa8ef7f@syzkaller.appspotmail.com>,
        "Daniel Jurgens" <danielj@mellanox.com>,
        "dasaratharaman.chandramouli@intel.com"
        <dasaratharaman.chandramouli@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: general protection fault in rdma_resolve_route
Thread-Topic: general protection fault in rdma_resolve_route
Thread-Index: AQHT1/gKA6ulhJ8+pkKdf+NDZqWPhaQIQXUA
Date: Thu, 19 Apr 2018 16:12:20 +0000
Message-ID: <VI1PR0502MB300899AC682257A6D3539E68D1B50@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <0000000000005c2cc4056a35b85a@google.com>
In-Reply-To: <0000000000005c2cc4056a35b85a@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=mellanox.com;
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3757;7:NZ/UZxXEoN4bWjuGmhytkS5rx+Unp76dylNDooCrxMkyNyC7ENW1atj48+9JGXJCjUBbi94GtTUwvUCFVw3fgmy/7WQxm7SXb+QXddSha94bFR8fUiUMGugUhdoI7HaVAEOAwKRQGPQt2hs4Jf5UdkZVSpDggOPrn+pPcG06c96ov3jWwadnkBTCux5yQ55HxVDRQF60l+r5E+Nj/GxmTLOX+XjtM5/qhAZXu6Dv/GAXPt3D/JMSM0ecu99xcZzy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3757;
x-ms-traffictypediagnostic: VI1PR0502MB3757:
x-microsoft-antispam-prvs: <VI1PR0502MB375731BCB3136F419B02C71DD1B50@VI1PR0502MB3757.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(9452136761055)(148501403981450)(84791874153150)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501383)(52105095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0502MB3757;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3757;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(13464003)(446003)(110136005)(476003)(966005)(45080400002)(11346002)(478600001)(305945005)(3280700002)(6436002)(7736002)(3660700001)(9686003)(229853002)(81166006)(316002)(2906002)(5660300001)(11609785009)(33656002)(66066001)(8676002)(6306002)(55016002)(8936002)(5250100002)(53936002)(6246003)(6506007)(53546011)(59450400001)(102836004)(26005)(186003)(74316002)(2900100001)(2501003)(2201001)(575784001)(86362001)(6116002)(3846002)(25786009)(7696005)(76176011)(921003)(99710200001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3757;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: MH9RilTJVfALABzhiPstnoOAp/sFVaqTPBjwWK51LMziRVO4FS53rFuUIwkCYHXFp7+Xjcr+Y7p1sbVXfDfM5PyK6TxOHaiYCHZEMqGx0hMu05N4DRWpOGDfrvUj7Gn8BYOoQX32846dXx5znXLez3aGxSQUcAxuJx2yLf9hJzrK3zySxepbRbiA6Tyy5VHd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c470e9ae-efee-405f-c976-08d5a610541e
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c470e9ae-efee-405f-c976-08d5a610541e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 16:12:20.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3757
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JGCXam012468



> -----Original Message-----
> From: syzbot
> [mailto:syzbot+17c13600b3977aa8ef7f@syzkaller.appspotmail.com]
> Sent: Thursday, April 19, 2018 11:04 AM
> To: Daniel Jurgens <danielj@mellanox.com>;
> dasaratharaman.chandramouli@intel.com; dledford@redhat.com;
> jgg@ziepe.ca; leon@kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Moni Shoua <monis@mellanox.com>; Parav Pandit
> <parav@mellanox.com>; swise@opengridcomputing.com; syzkaller-
> bugs@googlegroups.com
> Subject: general protection fault in rdma_resolve_route
> 
> Hello,
> 
> syzbot hit the following crash on upstream commit
> a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018
> +0000) Merge branch 'parisc-4.17-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=17c13600b3977aa8ef7f
> 
> So far this crash happened 2 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6198183931674624
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+17c13600b3977aa8ef7f@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for details.
> If you forward the report, please keep this part and the footer.
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access general
> protection fault: 0000 [#1] SMP KASAN Dumping ftrace buffer:
>     (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 750 Comm: syz-executor4 Not tainted 4.17.0-rc1+ #6 Hardware
> name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> RIP: 0010:rdma_cap_ib_sa include/rdma/ib_verbs.h:2840 [inline]
> RIP: 0010:rdma_resolve_route+0x134/0x2160
> drivers/infiniband/core/cma.c:2668
> RSP: 0018:ffff8801b3e87850 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff8801abf92c00 RCX: 0000000000000029
> RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000148
> RBP: ffff8801b3e87a00 R08: ffffed00357f25e5 R09: ffffed00357f25e4
> R10: ffffed00357f25e4 R11: ffff8801abf92f23 R12: 1ffff100367d0f12
> R13: dffffc0000000000 R14: ffff8801abf92db8 R15: 0000000000000000
> FS:  00007f673e752700(0000) GS:ffff8801db100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000a3eab8 CR3: 00000001b10e7000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Call
> Trace:
>   ucma_resolve_route+0x179/0x1c0 drivers/infiniband/core/ucma.c:741
>   ucma_write+0x328/0x410 drivers/infiniband/core/ucma.c:1664
>   __vfs_write+0x10b/0x880 fs/read_write.c:485
>   vfs_write+0x1f8/0x560 fs/read_write.c:549
>   ksys_write+0xf9/0x250 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455329
> RSP: 002b:00007f673e751c68 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f673e7526d4 RCX: 0000000000455329
> RDX: 0000000000000010 RSI: 0000000020000100 RDI: 0000000000000014
> RBP: 000000000072c010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000006c3 R14: 00000000006fd2e8 R15: 0000000000000002
> Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 14 1c 00 00 48 ba 00 00 00 00 00 fc ff df
> 48 8b 03 48 8d b8 48 01 00 00 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 d7 1b 00
> 00 45 0f b6 ef 49 c1 e5 04 4c 03 a8
> RIP: rdma_cap_ib_sa include/rdma/ib_verbs.h:2840 [inline] RSP:
> ffff8801b3e87850
> RIP: rdma_resolve_route+0x134/0x2160 drivers/infiniband/core/cma.c:2668
> RSP: ffff8801b3e87850
> ---[ end trace c34c2fb6aeff4a19 ]---
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is merged into
> any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report If it's a one-off invalid bug report,
> please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug report.
> Note: all commands must start from beginning of the line in the email body.

For short term, we need helper similar to ucma_get_ctx() as ucma_get_ctx_with_device() which performs NULL check for cm_id->device.
Currently its done at several places in ucma commands such as ucma_set_ib_path, ucma_notify etc.
