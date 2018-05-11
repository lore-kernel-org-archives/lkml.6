Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEKSeT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:34:19 -0400
Received: from mail-ve1eur01on0103.outbound.protection.outlook.com ([104.47.1.103]:21318
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeEKSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:34:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Fri, 11 May 2018 11:33:59 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: syzbot <syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com>
Cc: avagin@openvz.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in sk_diag_fill
Message-ID: <20180511183358.GA1492@outlook.office365.com>
References: <000000000000169606056b793179@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <000000000000169606056b793179@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:301:3b::38) To DB7PR08MB3257.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:kxjvHHz0Y/EarQ7ioQGhbMyXN4OzVTZv7WPMYVe7CgCMAP+LLXARUdzL+1cR6wrOAaBMnGQF7trMtGAvi5ioYVc8N5SqhKvxSnEkyE22yDcX/wbU6fsqQ0pyZ++HY7fPpfciK9hpdzdd4xVg6lZ6CmYZQ6utDlO0XjxuTssrXRlHJn/FjU1ZB4A095JcEAbBVc0hIaW7YfuI2IMYCk3x/9lkDFx831AuRvjGFe9Oay6R0cPXRQxWidlm2TJj6RMR;25:w+vhQLHup/9eGNit6N8oMHf+/3N1CkcqEwOXAJTuodqxXb2fOhpcSbAS9Sq+Q2Yq60JAnNEEDEEdt+WjqeTL/8b6bkkWQCiLnKFLUD8SK5DxZEXwj9pqCDM+H1aKzNRdUpe1I+X84Oyg1hUYRQRq9gXnX1UQdgJH3GGlUi2ydWdVRF00jwFDywJbWGCHJrxvvNlF++n4I/BRZ0j/4hef5HE2nSv1eB69Uiw8b+MZHOc1h95KP3oCPsorD4elRfvAR1YSYkeuf+QGwm0jDLynwhNDocMfkq2ymX21HZmw1c8gV1FAx5xuWHYgRcUe9wB0qg+OukpNrSN99up+yMQXVQ==;31:ulM5om/pEgpZzN/JChYU6Po2ngO86EEeGTl44sAkK22/9ZEcB7Ujz40qMmLm/TGMUCrXbVmRsN0QL555DmRNcBZm0U+9JG5txDQn+4uM5XroSIFqOPHM37SBjmvfL9H6lyz6StxMYgQOFDK0Xdi/7GwzOX4UmU0yOFcb4j4gXW43JeGUugoxNIiiwZm9+pBwrpKTsqH0WIu9u91B1Wpwl7+wTIAPFn3kCQRIuRTxi6Q=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:X8KQ6MR8yQ088B7WOD39cLusYw3LRr1ZRTkSeeZcLseYbz/BbIRkEvsUpDlQXyBVAlp4S9qph5Fjtz09v2GzutjDaXTE2l+xQHOh54muEH3p8NdZKPGAfWy6U5m5M8/8k/YZyVFjHMxj0hIyVLV8pCrbgkXThjC3R6cOsBrq4f42CqwHNh6UNtdpTjAPAiNtplBPXORhlmRiH5ybrO1spelw0f8kg8HjKUnFee6snBFmeTsAS6iyFA03Z6p+v5piIleqd8qQXMNQGW1xcOg61rBgwbunAaXx2hi70MN1l472ToQOGEnZvdY+4wK33KcJBMFfcA0NYz2JAxtOf+C2GQH6+lR0o1EN9wofre2lWsIRBGIlREdmGp1y1Y6EzFs7Lh2cVY8qRRxjlIcuXTxCGjRYjecNJIuwZxJvBhqcjFaM+H8eZX9MWvQu0bH9eNc69vyc1sTj+QeE43uJRtcdQVflimfX6aQ8TFqHdjf7Om6WIY7Il4jcP4dVTCYQhmSR;4:6A4+p1OXHn/KC0EHe3R2uYYvFO7bXlPiCwTAu0AzYKFlRnmfNOHnf/DfwOuRtwGrxZQln0exNp9+FpPQ3KH8qIqsyhVje3LCtY4UmnFlDZHSqfIRD0i456X5C0FTe6p5kUlafnYLKM6N6cNfWNQTqAng6YQdXjPOULggqLhdAQT3CQFFlElGXPBcRW4jI4kbMlZZK209LtMYPPG/9HZ86BbWTPSW2JF4hlzkNUvcLfccjyJQF9MRbPMjexxWJ/LL2IG3d5SD7fMh9TBP4a/H6uxY/auMoe++9+vG3/ZaWikiRXEWV1sS/aDwWqBlZj6i
X-Microsoft-Antispam-PRVS: <DB7PR08MB32576A67AA3DF63CB190C9DACF9F0@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(39380400002)(376002)(346002)(366004)(396003)(189003)(199004)(97736004)(1076002)(4326008)(53936002)(9686003)(6246003)(33656002)(68736007)(37156001)(55016002)(6306002)(23686003)(305945005)(47776003)(3846002)(6116002)(66066001)(7736002)(50466002)(81166006)(8676002)(81156014)(69596002)(8936002)(2906002)(6666003)(966005)(478600001)(58126008)(7696005)(52116002)(229853002)(106356001)(105586002)(25786009)(11346002)(446003)(86362001)(956004)(476003)(76176011)(59450400001)(26005)(386003)(316002)(11609785009)(16586007)(16526019)(5660300001)(6506007)(186003)(486006)(53416004)(18370500001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;DB7PR08MB3257;23:IIeh+35K87twGAl+/zhblA4RCjtvzFqkh4uGcDiHC1e?=
 =?koi8-r?Q?fzooy4uiTEPsGGrLZSMJIFJ7ZHXGDpaTX4uhK4610RchZj5Uu8MUw7OwJlX5or?=
 =?koi8-r?Q?angMZT0BqPKiG2Z4MNnjyCCHdCrrzABK8bnbaMsZS3WPJfBLxw4bNMgbG2tqPa?=
 =?koi8-r?Q?jh6F1vYlCvB6hrIHltMnxv26/6M2HnmmfVb4+nC5Zu/WR4O2DztSM9ueqJ7SmP?=
 =?koi8-r?Q?I9Td8wgJyGyh+ImxDlkkOjOrf92xz1svQcZZWiC4AQSk4gFGJGgeWJRNBzES6M?=
 =?koi8-r?Q?EJEAV4m6vLMBiCeKCVlhhoVROwjzXbJSg/WGKBlYXs6D7jl8b32Iuh3PctYnXw?=
 =?koi8-r?Q?XXz+maUQpEfLTBhqVoh0BEEg+b+sepR4gT45rnedsmpAmtDM1XQIejfkFzSUj9?=
 =?koi8-r?Q?+vHWGhhsbocwF6v7wv63OFSQhbTES4+pjTfN/fS+Z2RahLoT7AXCObPxepm0C5?=
 =?koi8-r?Q?Kh36idfUZcXM0S3hPmTf1BidlH/NV1ffDvJed4jivC2nLM7J9tFpa4+KH7uwUD?=
 =?koi8-r?Q?j2WY8btzXGaPY7sSkoGEQWhlvJwoo8KA6uDw+bMhpZs6BnF0joZr1N/Ry3Vci8?=
 =?koi8-r?Q?5PhxekEbhTNAg3VFwEzc+8XvVh795qSw5a8LgtgVPtsk3o97ejUV0yhzFiw9VD?=
 =?koi8-r?Q?Kgzr7c8JklEpxJrg616QsDqh/jjVP39+oWeXmSWDueWjXtxaWvvlLw5KeESOQL?=
 =?koi8-r?Q?MJK18EBkOXYdGqFafzTfrLD5m3zhRArG+qD97yYmhEKuPiFlhyoPEFpNUXfAmk?=
 =?koi8-r?Q?AVOO8ygxyvk5641iwIpqauTN3IEsdEXKSWmpP8/Yzmje9KU7xp5SWTdq8NX70u?=
 =?koi8-r?Q?gQuNsLzHFJ8tuDlPjNndM4MjW7oTsL9zaVPes+vpvarp0hDQpDhi0AieNLL8fZ?=
 =?koi8-r?Q?TFUMQVNTKyMI+2Pm6KDhiCDlYnfHD/66wHvSiXj+nvP0vZTp8yz0qH6cm77bmd?=
 =?koi8-r?Q?E5QyH8uBI6HkF90qJZQsKEMLHYN5BXb1f539XwZ6ZvIj7s5mHWhwgssxDC3kNq?=
 =?koi8-r?Q?UeHonvW7D7rBQzy3v2nPG7Nq8GcApaKAb3PZEpp/9BgkXJSY0urE72VLrClzbi?=
 =?koi8-r?Q?gwlPFA3iM/rrCyiLYiNtuTIycY4WqHIY89z/iWdMpeK1CKBwgYmaEloBOeLCzu?=
 =?koi8-r?Q?syAZY9MWeiCw6gFQ6BJXCRt+bPzngaPfzVdpcSho55KyMziGpgAqLATWVjmsXc?=
 =?koi8-r?Q?DVbyG45V6M7B7QGvsOq2Kt8I2tXEEg0ELUhuqre0l9hY10n3J4NGZI0jkrRp3p?=
 =?koi8-r?Q?XqYldc3BnABDVWERZSHmKHeuoA9Y1gmuA9C6byycBWWO1aZsrCNPCUuZoTEt8d?=
 =?koi8-r?Q?HdTgfmRw2Y+02cfcQa49EjDrBInEGKSznTSU5v+C4ss5uq0dXKZu52X6lcet4k?=
 =?koi8-r?Q?eaI9eP0regYEwz4fVIPfHig=3D=3D?=
X-Microsoft-Antispam-Message-Info: Nye2dNrdfyuxXy3vK0sGb2nKYoGTsf8zZgsDJvpBlc5dyW3l0GRi/O3p0V11aZ0uO7w6ylK/7S98lsFVBkLpTSVamd2aZ8Gc87wkxYY6D2McA0McKAkJ55Za3mlyfauYjgxPpn80f8ligsYZrHKodjLptr3GxPDEMWde4lTPt9/GU3szh743RAsearUXKVaS
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:9Q4Oz9qUw+IFPru134naiP0No3Kh6FgPifsSxOEjIC1M3LO+KKxllCewjZ+y7vqp3a1KXTpUne2zZ5WIgwU8AtYYX/acBOauZqQepZzY8jS9RFQ9I/SFCZE2HwL9nA+xuVT18gqkXTevMHUV5WoL00mORx53y8TLClbHoCiwbciGYcEaWfx8Ulhl6er1w0yoHxQ6HaPR900VtRFruQQBcWDMzfMmImTyR8z89V4gRZ+DQai8tckgN8SgLbWlWMe4Ei3TP8iGt/6smlwgaUuX69AJ9CjTvxAv4a5wtMdPvRx2u5Xv2lFM/+RtSPrdaMwZsTm+PcxU0cJhvUH/Ssn6l59bZcqUHuyV4/O429SSANRwFCnIAUEiFXu1ZJFO4Eo2PGTEyYS712QGG7Gr6cD9kwz0wdMn+wr2R6w5p62ZvcAbOMteXuYIOVf8+pL1HmEtq200JFJ2zFQv9jPAzpePHw==;5:SJUVYNyMklHMm9cgIxY2P01YZWXxZ4Q6A9v8XYKsrYTQxiNQoH/cPw+5gB8CkNOLe367UBkE317iynpVjudzVtDFDbAIV/D2p4pPiGf5ue5s5V0DNSfrSKLNq76iVySDX5noK/ji6B2B1XXyNJRx7Ypw86rwsiSpYQXV0a2zbM4=;24:C552/HzG+gsKMDVmuzIh5WbGhNt2IMkGVdQT3YQPEZaSHfw47Gc62+WOhd94S5rOXTGHiS6iObLAqpt0fgaezcBliypF2//quhRpWXQnVkc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;7:RivlQDtvzYvYAsQgsPrXYLVCpjkIny3zRNbKGvYICSWFtL1QmzLPIvXTjsy/P/gwZAXANWuVM5fmJ37iwwuW1p7Plt6mtF2DEKNPRNLabIUK7gripFNUFLuagrnK/BbAQ2AdT0mOQaWvCp6CWD/quSafmwvHxxV1nwTJVQE9RGfDcyjwDj84tIqPcBYXC0AyahNBOlMvVdVGPpXdmRywshsmIOGoCQvHgLciRxzbwE7FwOoJyRyqyDdoOXbyTLwp;20:foUn+zcC1rpnb9VVZIR3anibe3L6eRHe/E0MB0KP6G1C+NX4MJesv5mPg/cmT84IA2/s7xcLrqIswoXuS1pMyKwMB3flz3CjJYGUsB2cx678qb19bJWw1q4hTf8fvSMS9TCCJaKEoiwkcqW2YfuQB+eHJNuwIp+MDfkejrit2xU=
X-MS-Office365-Filtering-Correlation-Id: f54ee994-3346-47bf-506b-08d5b76dcb51
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 18:34:12.1027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54ee994-3346-47bf-506b-08d5b76dcb51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 10:59:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12164c97800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
> dashboard link: https://syzkaller.appspot.com/bug?extid=c1872be62e587eae9669
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c1872be62e587eae9669@syzkaller.appspotmail.com
> 
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0-rc3+ #59 Not tainted
> ------------------------------------------------------
> syz-executor1/25282 is trying to acquire lock:
> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at: sk_diag_dump_icons
> net/unix/diag.c:82 [inline]
> 000000004fddf743 (&(&u->lock)->rlock/1){+.+.}, at:
> sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
> 
> but task is already holding lock:
> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
> net/unix/diag.c:64 [inline]
> 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_fill.isra.5+0x94e/0x10d0
> net/unix/diag.c:144
> 
> which lock already depends on the new lock.

In the code, we have a comment which explains why it is safe to take this lock

/*
 * The state lock is outer for the same sk's
 * queue lock. With the other's queue locked it's
 * OK to lock the state.
 */
unix_state_lock_nested(req);

It is a question how to explain this to lockdep.

> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rlock-AF_UNIX){+.+.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2900
>        unix_dgram_sendmsg+0xf77/0x1730 net/unix/af_unix.c:1797
>        sock_sendmsg_nosec net/socket.c:629 [inline]
>        sock_sendmsg+0xd5/0x120 net/socket.c:639
>        ___sys_sendmsg+0x525/0x940 net/socket.c:2117
>        __sys_sendmmsg+0x3bb/0x6f0 net/socket.c:2205
>        __compat_sys_sendmmsg net/compat.c:770 [inline]
>        __do_compat_sys_sendmmsg net/compat.c:777 [inline]
>        __se_compat_sys_sendmmsg net/compat.c:774 [inline]
>        __ia32_compat_sys_sendmmsg+0x9f/0x100 net/compat.c:774
>        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
>        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
>        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> -> #0 (&(&u->lock)->rlock/1){+.+.}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
>        sk_diag_dump_icons net/unix/diag.c:82 [inline]
>        sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
>        sk_diag_dump net/unix/diag.c:178 [inline]
>        unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
>        netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
>        __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
>        netlink_dump_start include/linux/netlink.h:214 [inline]
>        unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
>        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
>        sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
>        netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
>        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
>        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>        netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
>        netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
>        sock_sendmsg_nosec net/socket.c:629 [inline]
>        sock_sendmsg+0xd5/0x120 net/socket.c:639
>        sock_write_iter+0x35a/0x5a0 net/socket.c:908
>        call_write_iter include/linux/fs.h:1784 [inline]
>        new_sync_write fs/read_write.c:474 [inline]
>        __vfs_write+0x64d/0x960 fs/read_write.c:487
>        vfs_write+0x1f8/0x560 fs/read_write.c:549
>        ksys_write+0xf9/0x250 fs/read_write.c:598
>        __do_sys_write fs/read_write.c:610 [inline]
>        __se_sys_write fs/read_write.c:607 [inline]
>        __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
>        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
>        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
>        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(rlock-AF_UNIX);
>                                lock(&(&u->lock)->rlock/1);
>                                lock(rlock-AF_UNIX);
>   lock(&(&u->lock)->rlock/1);
> 
>  *** DEADLOCK ***
> 
> 5 locks held by syz-executor1/25282:
>  #0: 000000003919e1bd (sock_diag_mutex){+.+.}, at: sock_diag_rcv+0x1b/0x40
> net/core/sock_diag.c:271
>  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at: __sock_diag_cmd
> net/core/sock_diag.c:225 [inline]
>  #1: 000000004f328d3e (sock_diag_table_mutex){+.+.}, at:
> sock_diag_rcv_msg+0x169/0x3d0 net/core/sock_diag.c:261
>  #2: 000000004cc04dbb (nlk_cb_mutex-SOCK_DIAG){+.+.}, at:
> netlink_dump+0x98/0xd20 net/netlink/af_netlink.c:2182
>  #3: 00000000accdef41 (unix_table_lock){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
>  #3: 00000000accdef41 (unix_table_lock){+.+.}, at:
> unix_diag_dump+0x10a/0x550 net/unix/diag.c:192
>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at: sk_diag_dump_icons
> net/unix/diag.c:64 [inline]
>  #4: 00000000b6895645 (rlock-AF_UNIX){+.+.}, at:
> sk_diag_fill.isra.5+0x94e/0x10d0 net/unix/diag.c:144
> 
> stack backtrace:
> CPU: 1 PID: 25282 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #59
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.54+0x1bd/0x27d
> kernel/locking/lockdep.c:1223
>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>  _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
>  sk_diag_dump_icons net/unix/diag.c:82 [inline]
>  sk_diag_fill.isra.5+0xa43/0x10d0 net/unix/diag.c:144
>  sk_diag_dump net/unix/diag.c:178 [inline]
>  unix_diag_dump+0x35f/0x550 net/unix/diag.c:206
>  netlink_dump+0x507/0xd20 net/netlink/af_netlink.c:2226
>  __netlink_dump_start+0x51a/0x780 net/netlink/af_netlink.c:2323
>  netlink_dump_start include/linux/netlink.h:214 [inline]
>  unix_diag_handler_dump+0x3f4/0x7b0 net/unix/diag.c:307
>  __sock_diag_cmd net/core/sock_diag.c:230 [inline]
>  sock_diag_rcv_msg+0x2e0/0x3d0 net/core/sock_diag.c:261
>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
>  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
>  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:639
>  sock_write_iter+0x35a/0x5a0 net/socket.c:908
>  call_write_iter include/linux/fs.h:1784 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x64d/0x960 fs/read_write.c:487
>  vfs_write+0x1f8/0x560 fs/read_write.c:549
>  ksys_write+0xf9/0x250 fs/read_write.c:598
>  __do_sys_write fs/read_write.c:610 [inline]
>  __se_sys_write fs/read_write.c:607 [inline]
>  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
>  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
>  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f8ccb9
> RSP: 002b:00000000f5f880ac EFLAGS: 00000282 ORIG_RAX: 0000000000000004
> RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 000000002058bfe4
> RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
