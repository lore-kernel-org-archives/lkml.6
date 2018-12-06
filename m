Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D02D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBfuNCNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D02D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeLFJtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:49:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45949 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:49:51 -0500
Received: by mail-io1-f66.google.com with SMTP id o5so13199777iop.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0KIlzZELJVLYVe19PyEtQbi4RpFjlas2MpPq4GEk1Y=;
        b=VBfuNCNqQwRbb8h3QXvoRkFgv7+EjGEbxDaqF/mzDW5NUAIpnhn/X9pysR0uZEIxAi
         n8XL1IbzKU6yeag5uCOjdx4fjohbN1AbsOUAOUNGUmv7vrTaWWsMNEOdT4CboWGAv6FR
         03tci/j6OoffLEhfI0u9tnbwoVyFmwvGhbUpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0KIlzZELJVLYVe19PyEtQbi4RpFjlas2MpPq4GEk1Y=;
        b=K2BfzG6bKyifmTxsTJb4a5voCSzdGyPs0QfesOQ339TUVrV/sfIMYA5+iWmyXvwsr0
         Q6Jr9eQY7pxr9g73z5lb24NcwAQVrv4MqK50gXi0xCdwbwc/TGHat1KqiEC0FWUVA7E3
         KvfVohpODpCtqKi7hh7IGcevu5zHRSdtVWCB13PZuJqstL9CGLrxvYWDBqgN7CzMp5s3
         GZ5NTqD9ZXap794YhJHyKkYJyVpTKr7wQlgqs9dVcl2VGLfiVemnnotaC36mjwqJqzjw
         3764G3KLojW4vJcd8nCSikzPwY8VqqQCL546u7id19tWnzSmgtPHZ59Tk2wOv48usqDv
         n3bw==
X-Gm-Message-State: AA+aEWamQn5p9Rn9t//542S5FsRH6JYT/DmirBr0cHUibX5hrw9Va8VI
        L/SnWQLzfwvDb27ZyQWVLjoeavCZ1JXBKvEZkDducg==
X-Google-Smtp-Source: AFSGD/WBEWCuOwCCo2hvhEJ4Z0csNylJCE7h5moXE8MSk8NDNdhhqR2vQz3TsHKgiGd/5bbD14vQjRc0SBG4Jh6ga8A=
X-Received: by 2002:a5d:8415:: with SMTP id i21mr13738731ion.173.1544089789848;
 Thu, 06 Dec 2018 01:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20181206091719.GH23332@shao2-debian>
In-Reply-To: <20181206091719.GH23332@shao2-debian>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Dec 2018 10:49:38 +0100
Message-ID: <CAKv+Gu9upt+zHPB3Qc2P6fd4jc7yup71nj0VsmFuLnYdS5dX1A@mail.gmail.com>
Subject: Re: [LKP] [x86/jump_table] b34006c425: BUG:unable_to_handle_kernel
To:     rong.a.chen@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 10:17, kernel test robot <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: b34006c4258c9c86597b6b7123d6a9a3513d6cd7 ("x86/jump_table: Use relative references")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------------+------------+------------+
> |                                          | 9fc0f798ab | b34006c425 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 4          | 0          |
> | boot_failures                            | 0          | 4          |
> | BUG:unable_to_handle_kernel              | 0          | 4          |
> | Oops:#[##]                               | 0          | 4          |
> | RIP:memcmp                               | 0          | 4          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 4          |
> +------------------------------------------+------------+------------+
>

From the attached log:
[    0.000000] Linux version 4.19.0-rc5-00006-gb34006c

while

$ git tag --contains b34006c
v4.20-rc1
v4.20-rc2
v4.20-rc3
v4.20-rc4
v4.20-rc5

If this is reproducible on a clean rebuild of b34006c425, I'm happy to
look into it.



> [   21.261613] BUG: unable to handle kernel paging request at 0000000001001893
> [   21.262316] PGD 0 P4D 0
> [   21.262578] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [   21.263139] CPU: 1 PID: 252 Comm: systemd-udevd Not tainted 4.19.0-rc5-00006-gb34006c #1
> [   21.263952] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   21.264797] RIP: 0010:memcmp+0x7/0x1d
> [   21.265179] Code: 39 ca 75 e7 41 c6 41 01 00 c3 c3 48 01 fa 48 89 f8 48 39 d0 74 0c 0f b6 08 39 f1 74 05 48 ff c0 eb ef c3 31 c9 48 39 d1 74 13 <0f> b6 04 0f 44 0f b6 04 0e 48 ff c1 44 29 c0 74 ea eb 02 31 c0 c3
> [   21.267043] RSP: 0018:ffff880110aebc50 EFLAGS: 00010293
> [   21.267579] RAX: ffffffff8101b80d RBX: 0000000001001893 RCX: 0000000000000000
> [   21.268299] RDX: 0000000000000005 RSI: ffff880110aebc6b RDI: 0000000001001893
> [   21.269015] RBP: ffffffff824019a4 R08: 0000000000000044 R09: 0000000000000008
> [   21.269736] R10: 0000000701029ae0 R11: ffffffff82a42360 R12: ffffffff8101b80d
> [   21.270458] R13: ffffc90001029ae0 R14: ffffc900010297e0 R15: ffffc900010295e0
> [   21.271185] FS:  00007f22ad10e8c0(0000) GS:ffff88013b300000(0000) knlGS:0000000000000000
> [   21.271989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.272571] CR2: 0000000001001893 CR3: 0000000110ae6000 CR4: 00000000000406a0
> [   21.273290] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   21.274006] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   21.274724] Call Trace:
> [   21.274993]  __jump_label_transform+0xb6/0x11f
> [   21.275455]  jump_label_apply_nops+0x5d/0x72
> [   21.275894]  module_finalize+0x18d/0x1c3
> [   21.276323]  load_module+0x1800/0x236d
> [   21.276710]  ? vfs_read+0x108/0x116
> [   21.277068]  ? set_fs+0x9/0x20
> [   21.277390]  ? security_kernel_post_read_file+0x67/0x75
> [   21.277916]  ? allow_write_access+0x13/0x24
> [   21.278346]  ? kernel_read_file+0x1d3/0x1fa
> [   21.278773]  ? __do_sys_finit_module+0xae/0xd4
> [   21.279238]  __do_sys_finit_module+0xae/0xd4
> [   21.279675]  do_syscall_64+0x20f/0x224
> [   21.280063]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   21.280602] RIP: 0033:0x7f22abf8b229
> [   21.280970] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89 01 48
> [   21.282830] RSP: 002b:00007fff5c9d38e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   21.283599] RAX: ffffffffffffffda RBX: 000055e996bd96b0 RCX: 00007f22abf8b229
> [   21.284316] RDX: 0000000000000000 RSI: 00007f22ac8a4265 RDI: 0000000000000007
> [   21.285027] RBP: 00007f22ac8a4265 R08: 0000000000000000 R09: 000055e996bcd860
> [   21.285743] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> [   21.286459] R13: 000055e996bd04d0 R14: 0000000000020000 R15: 000055e996439cbc
> [   21.287186] Modules linked in: button(+) ip_tables x_tables ipv6
> [   21.287800] CR2: 0000000001001893
>          Starting LSB: Execute the kexec -e command to reboot system...
> [   21.346498] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
> [   21.347338] evbug: Connected device: input4 (Power Button at LNXPWRBN/button/input0)
> [   21.347665] ---[ end trace 3282d04b21b84631 ]---
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> lkp
