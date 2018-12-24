Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F44C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94285217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYQK+K4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLXVEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:04:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37488 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:04:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so12567449wmd.2;
        Mon, 24 Dec 2018 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C7G9XGIiRH0Zj4m9EvyEbKPtIY6IqtgKG8WfsXsRrgY=;
        b=mYQK+K4C/hKNPbBmvtNlsjEc7rZ6UYfz+oNUx5yOjEwZWx5d+mJANI7XE+RSBQ7uPf
         llANCf0elgY8/RCfjCO+eXPnYur0LX0DV9hCEinrbcDxaP1QRoCV4SMpf3RYw/QeKz0U
         gKoMKrdwgc87H6zPTfGCIT6Own7+tqonQNKJjHyRHxR2Ayt2fbovdLaoXTyuXADHKaMv
         Gxxy52SCFW/xdlXALn7wDjCR/2h6IGfP6yNY0i0kyOmVjrKSrs+t+P7JnG4czVYU8Dvl
         0uB2F07ML1vnrRi/fq9D4gNWdGNtw9YwZp1hnnWD9NN820NhGT/36cIir9Nul5+emPnB
         Mutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C7G9XGIiRH0Zj4m9EvyEbKPtIY6IqtgKG8WfsXsRrgY=;
        b=XlHkOIzDPKlqk/y+bnIi0Kvf11lG11tsN5fCjwK1ZHpkSMM6ludI6KJPHCMX3qL1OE
         CFMul3iW/H647ZCDTdGA6WooRCLM74hH0FFF3Uf6lb501U5J0zQXow+Qg78eeaV+0chM
         YrKs4p6wBBH6HuDHoq1RTP5SUMNhWGCkjqPpzXjkmE2Pp6KH/X1eKZAv7tr8sqytoWyK
         rGeEXDAxa2NtzMv5CeF/zUpWkP3NSqIOmkZb+Wkb1qBk7CeeP1a4fQeoFPhNtv3glP9R
         a841akDpvo9/037cEJd1CV1Xz6ysxYLROVwUMEh0tUvueuqrvtPVYHKMLH/UtNwCrz2X
         7AFw==
X-Gm-Message-State: AA+aEWYVqCIA1WUSTTrQey++wutKHW1G6AM2CC5XZpcB/jZiplt4Wjag
        AqRfLPHqYbbi70xOimcbrP8/20k9I6zLeM4bH7A=
X-Google-Smtp-Source: AFSGD/V0tbhpq/oKWCEk6FKwbDgZHy10XSplYN5upviXlbw+HGbpSfT7dvQsGBrpTKnphQfuFt2FagGjlNvnbtLCrqk=
X-Received: by 2002:a1c:8548:: with SMTP id h69mr12543681wmd.11.1545685491858;
 Mon, 24 Dec 2018 13:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20181224125740.lpynxkdqfcqgbxl3@inn2.lkp.intel.com>
In-Reply-To: <20181224125740.lpynxkdqfcqgbxl3@inn2.lkp.intel.com>
From:   Peter Oskolkov <posk.devel@gmail.com>
Date:   Mon, 24 Dec 2018 13:04:40 -0800
Message-ID: <CAGx-UoBq4fHyaEZ+uLP64hMRUP3dk5tB7nRKt2sr6=9jANrPww@mail.gmail.com>
Subject: Re: [net] eedbbb0d98: RIP:inet_hashinfo2_init
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Oskolkov <posk@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzcaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fix sent to netdev: https://patchwork.ozlabs.org/patch/1018304/

On Mon, Dec 24, 2018 at 5:01 AM kernel test robot <lkp@intel.com> wrote:
>
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: eedbbb0d98b2a89250a8bb83d9c71b77881e5247 ("net: dccp: initialize =
(addr,port) listening hashtable")
> https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git master
>
> in testcase: trinity
> with following parameters:
>
>         runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 2G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
> +-------------------------------------------------------+------------+---=
---------+
> |                                                       | 6a95147c51 | ee=
dbbb0d98 |
> +-------------------------------------------------------+------------+---=
---------+
> | boot_successes                                        | 4          | 4 =
         |
> | boot_failures                                         | 1          | 6 =
         |
> | BUG:unable_to_handle_kernel                           | 1          | 6 =
         |
> | Oops:#[##]                                            | 1          | 6 =
         |
> | RIP:inet_lhash2_lookup                                | 1          |   =
         |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 1          |   =
         |
> | RIP:inet_hashinfo2_init                               | 0          | 6 =
         |
> | Kernel_panic-not_syncing:Fatal_exception              | 0          | 6 =
         |
> +-------------------------------------------------------+------------+---=
---------+
>
>
>
> [   11.577638] BUG: unable to handle kernel paging request at ffffffff82c=
ea1d0
> [   11.579009] PGD 260e067 P4D 260e067 PUD 260f063 PMD 7ef32063 PTE 800ff=
ffffd315062
> [   11.580404] Oops: 0010 [#1] SMP PTI
> [   11.581114] CPU: 1 PID: 523 Comm: modprobe Not tainted 4.20.0-rc6-0147=
5-geedbbb0 #1
> [   11.582531] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
> [   11.584073] RIP: 0010:inet_hashinfo2_init+0x0/0x64
> [   11.584971] Code: Bad RIP value.
> [   11.585649] RSP: 0018:ffffc90000997ca0 EFLAGS: 00010246
> [   11.586596] RAX: ffffffffa01aa000 RBX: 0000000000000000 RCX: 000000000=
0000015
> [   11.587813] RDX: 0000000000000020 RSI: ffffffffa01a32b1 RDI: ffffffffa=
01a9dc0
> [   11.589037] RBP: ffffffffa01b12ed R08: 0000000000000000 R09: 000000000=
0010000
> [   11.590259] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff88806=
32d6ce0
> [   11.591475] R13: 0000000000000001 R14: ffff88807ee8fc00 R15: ffffc9000=
0997e98
> [   11.592711] FS:  00007f454c916700(0000) GS:ffff888072500000(0000) knlG=
S:0000000000000000
> [   11.594189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.595215] CR2: ffffffff82cea1a6 CR3: 000000007978a000 CR4: 000000000=
00406e0
> [   11.596436] Call Trace:
> [   11.597014]  dccp_init+0x61/0x309 [dccp]
> [   11.597788]  ? trace_event_define_fields_dccp_probe+0x227/0x227 [dccp]
> [   11.598947]  do_one_initcall+0x46/0x1e4
> [   11.599700]  ? _cond_resched+0x19/0x30
> [   11.600430]  ? kmem_cache_alloc_trace+0x3e/0x1e0
> [   11.601299]  do_init_module+0x5b/0x200
> [   11.602068]  load_module+0x1836/0x1cd0
> [   11.602814]  ? ima_post_read_file+0xe2/0x120
> [   11.603630]  ? __do_sys_finit_module+0xe9/0x110
> [   11.604471]  __do_sys_finit_module+0xe9/0x110
> [   11.605301]  do_syscall_64+0x5b/0x180
> [   11.606037]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   11.606968] RIP: 0033:0x7f454c441229
> [   11.607693] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89 01 48
> [   11.610809] RSP: 002b:00007fff3363ec38 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [   11.612204] RAX: ffffffffffffffda RBX: 0000559e818104c0 RCX: 00007f454=
c441229
> [   11.613426] RDX: 0000000000000000 RSI: 0000559e81177638 RDI: 000000000=
0000000
> [   11.614653] RBP: 0000559e81177638 R08: 0000000000000000 R09: 000000000=
0000001
> [   11.615865] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [   11.617090] R13: 0000559e8180f500 R14: 0000000000040000 R15: 000000000=
0000000
> [   11.618310] Modules linked in: dccp(+) sr_mod cdrom sg ata_generic pat=
a_acpi crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ppdev=
 aesni_intel crypto_simd cryptd glue_helper snd_pcm snd_timer snd soundcore=
 pcspkr serio_raw ata_piix libata i2c_piix4 parport_pc parport floppy ip_ta=
bles
> [   11.622675] CR2: ffffffff82cea1d0
> [   11.623348] ---[ end trace b5a7a7e0716fa2b3 ]---
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in =
this email
>
>
>
> Thanks,
> Rong Chen
