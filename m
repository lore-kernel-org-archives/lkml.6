Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF88C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9A26D3C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cHfvQ2Gg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eUonRzDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC9A26D3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeFZQsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:48:09 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41096 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeFZQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:48:06 -0400
Received: by mail-yb0-f193.google.com with SMTP id y187-v6so5889836yby.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kzv1rHx2HuWg9ObKMHhh2FKo3Dg4yM3+RYYvFSio+JQ=;
        b=cHfvQ2GgpoWHKdooMOwJv5eX3CJUyyeDSht5hm+518ZehHEElVzS/naENC9kkp0au/
         azDyM9NKG0swKNomsR2pMoscwIURHK08FhujiQudg3P1XLVHpbWZsUVH4cCfYhmnL219
         mgJR/lZXnK6Z8mjLxgiP5rzRp+LBm/dY9B3HKmLcLRFamZ1eiCZ+iwTkONW4ELGDeCfe
         eYXAzzq+cTj7xWHT/s/L+Lz4DxS9YhF7dS+OVmIx8F9JKkYDjUJuz1cdj/eYbSUkjCwv
         S2s/SHAtCoqMkIJuQm89OYfsFB9Zu6LRYdtnwjQ6hRZ/xoDvnGZ14i9GFzRRBEjSlrgc
         ofQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kzv1rHx2HuWg9ObKMHhh2FKo3Dg4yM3+RYYvFSio+JQ=;
        b=eUonRzDkFTih9YqSr/wRMhtdzS60Rr08doF0CUawy93keS5qkK+ByC9SprGsnCjisa
         7v7fNRy9eNGUIhceAag5Kj4ScrkPRBz5M0Z+cj5BhKO8THV44359cahoYz3dZ16L8WdS
         07xflli5utDFEyx3pgIR7CRA3C1wazqJBU8KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kzv1rHx2HuWg9ObKMHhh2FKo3Dg4yM3+RYYvFSio+JQ=;
        b=unTTmjDhNoTgJK2mdQxCID3KebjWwOESyGkJnuHCxN6mPFNWs4Fg3FDdKwtm49lRou
         8mCdL4/ZL9Npy0zVXX9yydHwGyaReySqSDowrFJjGbS/vmZ7ye7e+D8iytPvg1Lsx843
         SvmllaVI3cczH7qmpCTzuULFMV3JtWRmZzSaRNDPEvODod7Vu7XreEFr+6g5U0QTN9KL
         xl/g1eo/gDc0vgQqTOWokrNuqDaCHstfg8BybupkE3tjbCaJe5t5lz38P7cpwkovALkO
         hNrw5UJBZA3oQaBnYUq8wfykKWOL7OTzKcm8IYWCooTt+HMFiUj9v1z802yTyYStj1WI
         0Gcg==
X-Gm-Message-State: APt69E23qkovydyeelhJqE8NULB9Mz4+j42Su7+wFCaKzKC8r97fA+YW
        Z3JnvXdeIhjY8/W/eA/4W6lnVJmqpzKc8vBJuRrCVQ==
X-Google-Smtp-Source: ADUXVKJAboaYXbKnuznBeDK3PZJfJioQL6VGks3uRbAzMHiBOMTbZSZsgKii8vJ09UowZwKhWkLHcz1zHHblxl73yJQ=
X-Received: by 2002:a5b:b4e:: with SMTP id b14-v6mr1226216ybr.463.1530031685534;
 Tue, 26 Jun 2018 09:48:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:48:04
 -0700 (PDT)
In-Reply-To: <20180626012433.GP11011@yexl-desktop>
References: <20180626012433.GP11011@yexl-desktop>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 09:48:04 -0700
X-Google-Sender-Auth: D_V99NrQBP_U8fJZ4XFMku2KnEI
Message-ID: <CAGXu5jJU6qa4W5kbU1O8p2JZ+ikb_=9RY16ya6tmDp4z8yS4SQ@mail.gmail.com>
Subject: Re: [lkp-robot] [bisect done] ca90800a91 [ 1.761734] WARNING: CPU: 0
 PID: 1 at mm/page_alloc.c:4061 __alloc_pages_nodemask
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Jun 25, 2018 at 6:24 PM, kernel test robot
<xiaolong.ye@intel.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit ca90800a91ba723d78ded634d037c1d2df8b54d6
> Author:     Kees Cook <keescook@chromium.org>
> AuthorDate: Thu May 10 16:40:03 2018 -0700
> Commit:     Kees Cook <keescook@chromium.org>
> CommitDate: Tue Jun 5 12:16:51 2018 -0700
>
>     test_overflow: Add memory allocation overflow tests
>
>     Make sure that the memory allocators are behaving as expected in the face
>     of overflows of multiplied arguments or when using the array_size()-family
>     helpers.
>
>     Example output of new tests (with the expected __alloc_pages_slowpath
>     and vmalloc warnings about refusing giant allocations removed):
>
>     [   93.062076] test_overflow: kmalloc detected saturation
>     [   93.062988] test_overflow: kmalloc_node detected saturation
>     [   93.063818] test_overflow: kzalloc detected saturation
>     [   93.064539] test_overflow: kzalloc_node detected saturation
>     [   93.120386] test_overflow: kvmalloc detected saturation
>     [   93.143458] test_overflow: kvmalloc_node detected saturation
>     [   93.166861] test_overflow: kvzalloc detected saturation
>     [   93.189924] test_overflow: kvzalloc_node detected saturation
>     [   93.221671] test_overflow: vmalloc detected saturation
>     [   93.246326] test_overflow: vmalloc_node detected saturation
>     [   93.270260] test_overflow: vzalloc detected saturation
>     [   93.293824] test_overflow: vzalloc_node detected saturation
>     [   93.294597] test_overflow: devm_kmalloc detected saturation
>     [   93.295383] test_overflow: devm_kzalloc detected saturation
>     [   93.296217] test_overflow: all tests passed
>
>     Signed-off-by: Kees Cook <keescook@chromium.org>

This is the expected output. i.e. the kernel will issue giant WARNs
during this test, since the saturation is being tested to correctly
refuse to perform tha llocation.

-Kees

>
> 610b15c50e  overflow.h: Add allocation size calculation helpers
> ca90800a91  test_overflow: Add memory allocation overflow tests
> 35773c9381  Merge branch 'afs-proc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> 4b373f94fe  Add linux-next specific files for 20180615
> +----------------------------------------------------+------------+------------+------------+---------------+
> |                                                    | 610b15c50e | ca90800a91 | 35773c9381 | next-20180615 |
> +----------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                     | 57         | 0          | 0          | 0             |
> | boot_failures                                      | 0          | 37         | 19         | 50            |
> | WARNING:at_mm/page_alloc.c:#__alloc_pages_nodemask | 0          | 37         | 19         | 50            |
> | EIP:__alloc_pages_nodemask                         | 0          | 37         | 19         | 50            |
> | Mem-Info                                           | 0          | 37         | 19         | 50            |
> +----------------------------------------------------+------------+------------+------------+---------------+
>
> [    1.756827] test_overflow: s8 : 19 tests
> [    1.757722] test_overflow: u16: 17 tests
> [    1.758673] test_overflow: s16: 17 tests
> [    1.759738] test_overflow: u32: 17 tests
> [    1.760677] test_overflow: s32: 17 tests
> [    1.761734] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4061 __alloc_pages_nodemask+0x172/0xa40
> [    1.764050] Modules linked in:
> [    1.764815] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc4-00006-gca90800 #108
> [    1.765046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    1.765046] EIP: __alloc_pages_nodemask+0x172/0xa40
> [    1.765046] EFLAGS: 00210246 CPU: 0
> [    1.765046] EAX: 00200140 EBX: 00000000 ECX: 00000000 EDX: c0039e14
> [    1.765046] ESI: c0039e14 EDI: 00000000 EBP: c0039e5c ESP: c0039dd4
> [    1.765046]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
> [    1.765046] CR0: 80050033 CR2: 00000000 CR3: 13ce6000 CR4: 000006b0
> [    1.765046] Call Trace:
> [    1.765046]  kmalloc_order+0x13/0x30
> [    1.765046]  __kmalloc+0x2f/0x140
> [    1.765046]  test_module_init+0x1128/0x1ab0
> [    1.765046]  ? vprintk_emit+0x3a2/0x400
> [    1.765046]  ? vprintk_default+0x12/0x20
> [    1.765046]  ? vprintk_func+0x55/0x60
> [    1.765046]  ? printk+0xe/0x10
> [    1.765046]  ? string_selftest_init+0x2a1/0x2a1
> [    1.765046]  do_one_initcall+0x65/0x148
> [    1.765046]  ? do_early_param+0x75/0x75
> [    1.765046]  kernel_init_freeable+0xdf/0x16a
> [    1.765046]  ? rest_init+0xc0/0xc0
> [    1.765046]  kernel_init+0x8/0xe0
> [    1.765046]  ret_from_fork+0x19/0x24
> [    1.765046] Code: 89 f6 8d bc 27 00 00 00 00 39 5d bc c6 45 cc 00 74 07 89 5d bc 8d 74 26 00 83 7d b0 0a 76 1a 81 e7 00 02 00 00 0f 85 ae 08 00 00 <0f> 0b e9 a7 08 00 00 8d b4 26 00 00 00 00 89 f8 25 00 00 48 00
> [    1.765046] ---[ end trace ed0d4aa536181e08 ]---
> [    1.792892] test_overflow: kmalloc detected saturation
>
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 3e592428c3e9499beb29b6d32c897cefdb78736e 29dcea88779c856c7dc92040a0c01233263101d4 --
> git bisect  bad 28433e0629539b932e1e92e034a52d41a99946db  # 01:52  B      0     3   17   0  Merge 'linux-review/Bart-Van-Assche/btrfs-Fix-a-C-compliance-issue/20180616-064505' into devel-spot-201806170104
> git bisect  bad 0c165328cd075dfd6a7f3a0ebb936f6a6d4e19eb  # 02:10  B      0     3   17   0  Merge 'linux-review/Nicholas-Mc-Guire/MIPS-Octeon-assign-bool-true-false-not-1-0/20180616-153047' into devel-spot-201806170104
> git bisect  bad 3ef1cb6222d11fa39e73582183e272bf79ce308d  # 02:25  B      0    11   40  15  Merge 'rcu/rcu/dev' into devel-spot-201806170104
> git bisect  bad c1676433a88101f37352f4e226690ca5e40f0daf  # 02:40  B      0     3   31  14  Merge 'l1k/pciehp_runpm_v2' into devel-spot-201806170104
> git bisect good db5af21ace0378d0a63ae0fc047519391d25d58b  # 02:50  G     11     0    0   0  0day base guard for 'devel-spot-201806170104'
> git bisect  bad 3d65675feaa6336996694ae20c49d54aa663237f  # 02:55  B      0     1   19   4  Merge 'hch-block/kill-bio_clone_kmalloc' into devel-spot-201806170104
> git bisect  bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21  # 03:09  B      0     5   19   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect good 135c5504a600ff9b06e321694fbcac78a9530cd4  # 03:20  G     11     0    1   1  Merge tag 'drm-next-2018-06-06-1' of git://anongit.freedesktop.org/drm/drm
> git bisect good ffbc9197b4721634dc6c0fefa9b31e565fa89cee  # 03:26  G     11     0   11  22  wcn36xx: improve debug and error messages for SMD
> git bisect good fd129f8941cf2309def29b5c8a23b62faff0c9d0  # 03:38  G     11     0    1   1  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> git bisect good d4d5a1cd298e67cb68cca8dc7dd1ea3942cce3ff  # 03:48  G     11     0    0   2  Merge tag 'asoc-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
> git bisect good 311da4975894aab7a4bb94aa83f38f052d7ffda4  # 03:54  G     11     0    0   0  Merge branch 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
> git bisect good d75ae5bdf2353e5c6a1f83da5f6f2d31582f09a3  # 04:08  G     11     0    0   1  Merge tag 'printk-for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
> git bisect good 8b5c6a3a49d9ebc7dc288870b9c56c4f946035d8  # 04:14  G     11     0    0   0  Merge tag 'audit-pr-20180605' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
> git bisect good 5eb6eed7e0fe880dc8de8da203cc888716bbf196  # 04:19  G     11     0    0   0  Merge tag 'trace-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> git bisect  bad 285767604576148fc1be7fcd112e4a90eb0d6ad2  # 04:25  B      0     2   19   3  Merge tag 'overflow-v4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> git bisect  bad ca90800a91ba723d78ded634d037c1d2df8b54d6  # 04:35  B      0     3   28  11  test_overflow: Add memory allocation overflow tests
> git bisect good 6d3344324b5ae49fc8cb599a2c687e5607ba6e9f  # 04:44  G     11     0    0   0  test_overflow: macrofy some more, do more tests for free
> git bisect good 610b15c50e86eb1e4b77274fabcaea29ac72d6a8  # 04:49  G     11     0    0   0  overflow.h: Add allocation size calculation helpers
> # first bad commit: [ca90800a91ba723d78ded634d037c1d2df8b54d6] test_overflow: Add memory allocation overflow tests
> git bisect good 610b15c50e86eb1e4b77274fabcaea29ac72d6a8  # 04:52  G     31     0    0   0  overflow.h: Add allocation size calculation helpers
> # extra tests with debug options
> git bisect  bad ca90800a91ba723d78ded634d037c1d2df8b54d6  # 04:58  B      0     4   20   2  test_overflow: Add memory allocation overflow tests
> # extra tests on HEAD of linux-devel/devel-spot-201806170104
> git bisect  bad 3e592428c3e9499beb29b6d32c897cefdb78736e  # 05:03  B      0    15   32   0  0day head guard for 'devel-spot-201806170104'
> # extra tests on tree/branch linus/master
> git bisect  bad 35773c93817c5f2df264d013978e7551056a063a  # 05:12  B      0     1   15   0  Merge branch 'afs-proc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> # extra tests on tree/branch linux-next/master
> git bisect  bad 4b373f94fee5acf2ff4c1efbb3f702060379df1f  # 05:25  B      0     4   29  11  Add linux-next specific files for 20180615
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation



-- 
Kees Cook
Pixel Security
