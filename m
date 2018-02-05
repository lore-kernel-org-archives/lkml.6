Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeBESPX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:15:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:55701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752738AbeBESPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:15:14 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: new warning here with kernel 4.15.1: kernel/signal.c:2101
 get_signal+0x48c/0x4c0
Message-ID: <4051a0bc-12da-5630-c5e3-49af460a4cfc@gmx.de>
Date: Mon, 5 Feb 2018 19:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9dJcY4u2u8nQBZaSw+1vqPCB5HQv1zKyQI8MiBn5NBYDGCDomcY
 1JQzwG/I/erWIdy0q6nF3i/9jH8QzEjpLJY+/ampJzev2AAYfcBpIhW3aumKGPF/bC5NYf8
 TjJhDRsN+O12eleoylaN0nxXyD3PBJ0ntpVGbvWP+Ig5TVLhIOWY4gf/kt2W+RBKtEWhZ5R
 frYzS1Hg9fLl1d+P1Kqkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JMoh6XrG/sI=:shZIabE0eLaBWhjtplLgE/
 px5hukmnv5Q51X9MPSFiSrmCai7kCYRwh8wXZpJMHp8Te46Ezrbi6RRoHkOD/MwXq56AIU1xg
 Q//er2RoK9AePAAi33fatImNANv9nE3ntcLKFJky1nieB4nRUu97i1b3Edx5mXkQfIxb5pEGX
 biiks4F2XnkqX7H3wXUR2EXkLFmvkuMeGHT6kq5wDJcUMKjGrWJa+7a9vr1DfdNEBJP0j3Zz3
 HksyKrBiKQk8TSKyoOCAL/dkJireHJB04KE3f/37k7U2lpuEshBU0FGXbkxE1cWRZqhT0z8ZY
 1vCSxa1DK4VONmzUVStk9ZAF2cLwd5fU+cP+7qneQ6YptLCHpU/tFd+Jx8NIY7q4qtmi6oxS0
 7LI0rztlN7T4nS7MBrShhSjA57mC1YqI91+Wqw6GkRiJ2tA58cVCJque1qoTw2WX+J/6XWO7Q
 g0+16sDs2gjpsihzFWXVCaNcLTT3JiIwQe0WCbiECKsEbOnXFUmNqDFWqhiFLnrOJUajwU1QX
 d8My35UeM/RaLWjCCxBTPy7p7hCOC1qfdlEPR+HS9xEsJUETgqa26F/thzB2w7e8XoLHRzr8g
 XEmwQgP+ziapqHkJWxKNgtMMKH/+wevoJLIJJTCtxKgZ0Uv/IEoGyJTtyIWE0vwUZS1lNyyy5
 cq12SZBeo2OSYWFnpP0jfUPzYgchgzwI2KHFM0siRuactQ9/j9kWfZXLav0menvYw3sAGwuwM
 r0JFuFi7WQTlhYvohVMXkv+k5yDy+cHrGLacAU/g9YfSJ/ecptj03udOrALsMGCsidA2RYm10
 AYEV8mkGLYdIua7bmtNl1ripHnbxdVla2FCIr7TwJiFeT8OI2M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got this at a stable Gentoo hardened Linux server today and do wonder how to react on it:


Feb  5 17:33:41 mr-fox kernel: [102822.981295] capability: warning: `capget-54cLBXW7' uses 32-bit capabilities (legacy support in use)
Feb  5 17:33:50 mr-fox kernel: [102831.276626] perf: interrupt took too long (2507 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
Feb  5 17:34:53 mr-fox kernel: [102894.649207] WARNING: CPU: 1 PID: 13199 at kernel/signal.c:2101 get_signal+0x48c/0x4c0
Feb  5 17:34:53 mr-fox kernel: [102894.649209] CPU: 1 PID: 13199 Comm: constructor-O92 Not tainted 4.15.1 #20
Feb  5 17:34:53 mr-fox kernel: [102894.649210] Hardware name:                  /DX79TO, BIOS SIX7910J.86A.0650.2014.0307.0138 03/07/2014
Feb  5 17:34:53 mr-fox kernel: [102894.649211] RIP: 0010:get_signal+0x48c/0x4c0
Feb  5 17:34:53 mr-fox kernel: [102894.649212] RSP: 0018:ffffa1ad93b33db0 EFLAGS: 00010046
Feb  5 17:34:53 mr-fox kernel: [102894.649213] RAX: ffff8ff60163e1c0 RBX: ffff8ff0dcb86800 RCX: 0000000000000000
Feb  5 17:34:53 mr-fox kernel: [102894.649214] RDX: 0000000000000001 RSI: 0000000000010106 RDI: 0000000000000000
Feb  5 17:34:53 mr-fox kernel: [102894.649214] RBP: ffff8ff5fcb83180 R08: 0000000000000000 R09: 000000000001e700
Feb  5 17:34:53 mr-fox kernel: [102894.649215] R10: ffffa1ad93b33f08 R11: 0000000000000000 R12: ffff8ff0dcb86800
Feb  5 17:34:53 mr-fox kernel: [102894.649215] R13: ffff8ff0dcb86800 R14: ffff8ff60163e1c0 R15: ffffa1ad93b33e30
Feb  5 17:34:53 mr-fox kernel: [102894.649216] FS:  00007f6a982c3700(0000) GS:ffff8ff67fa40000(0000) knlGS:0000000000000000
Feb  5 17:34:53 mr-fox kernel: [102894.649217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb  5 17:34:53 mr-fox kernel: [102894.649218] CR2: 00007f6a982c2fb8 CR3: 00000005ed1d0001 CR4: 00000000000606e4
Feb  5 17:34:53 mr-fox kernel: [102894.649218] DR0: 00005555557560c0 DR1: 00005555557560c4 DR2: 00005555557560c8
Feb  5 17:34:53 mr-fox kernel: [102894.649219] DR3: 00005555557560cc DR6: 00000000ffff0ff0 DR7: 0000000000000600
Feb  5 17:34:53 mr-fox kernel: [102894.649219] Call Trace:
Feb  5 17:34:53 mr-fox kernel: [102894.649223]  do_signal+0x3e/0x5d0
Feb  5 17:34:53 mr-fox kernel: [102894.649225]  ? pick_next_task_fair+0x453/0x480
Feb  5 17:34:53 mr-fox kernel: [102894.649227]  ? radix_tree_delete_item+0x56/0xb0
Feb  5 17:34:53 mr-fox kernel: [102894.649229]  exit_to_usermode_loop+0x49/0x80
Feb  5 17:34:53 mr-fox kernel: [102894.649230]  syscall_return_slowpath+0x7b/0xa0
Feb  5 17:34:53 mr-fox kernel: [102894.649232]  ret_from_fork+0x15/0x40
Feb  5 17:34:53 mr-fox kernel: [102894.649233] RIP: 0033:0x7f6a985ca4a1
Feb  5 17:34:53 mr-fox kernel: [102894.649233] RSP: 002b:00007f6a982c2fb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
Feb  5 17:34:53 mr-fox kernel: [102894.649234] RAX: 0000000000000000 RBX: 00007f6a982c3700 RCX: ffffffffffffffff
Feb  5 17:34:53 mr-fox kernel: [102894.649235] RDX: 00007f6a982c39d0 RSI: 00007f6a982c2fb0 RDI: 00000000003d0f00
Feb  5 17:34:53 mr-fox kernel: [102894.649236] RBP: 00007ffea7a38da0 R08: 00007f6a982c3700 R09: 00007f6a982c3700
Feb  5 17:34:53 mr-fox kernel: [102894.649236] R10: 00007f6a982c39d0 R11: 0000000000000246 R12: 00007ffea7a38d9e
Feb  5 17:34:53 mr-fox kernel: [102894.649237] R13: 00007ffea7a38d9f R14: 00007f6a982c3700 R15: 0000000000000000
Feb  5 17:34:53 mr-fox kernel: [102894.649237] Code: 49 89 57 10 48 8b 50 20 49 89 57 18 f6 40 13 80 74 08 48 c7 40 08 00 00 00 00 31 c0 45 85 c0 0f 9f c0 eb a0 0f ff e9 93 fe ff ff <0f> ff be 00 80 00 00 e9 a0 fd ff ff e8 83 ba 00 00 e9 94 fb ff 
Feb  5 17:34:53 mr-fox kernel: [102894.649254] ---[ end trace 75e71e5311ec023f ]---
Feb  5 17:52:16 mr-fox kernel: [103937.607726] perf: interrupt took too long (3134 > 3133), lowering kernel.perf_event_max_sample_rate to 63000
Feb  5 17:52:17 mr-fox kernel: [103938.353509] perf: interrupt took too long (3963 > 3917), lowering kernel.perf_event_max_sample_rate to 50000


-- 
Toralf
PGP C4EACDDE 0076E94E
