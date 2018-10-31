Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22616C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B2520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmyzws/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B2520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeJaUDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:03:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34908 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeJaUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:03:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so10192326ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HUxuzMPte6AmoUFHVUW/BGR7pNMQKFL4+foGss8Ed7U=;
        b=mmyzws/9p6B/8k3c0+mK+cFpXmvMavAlngVppytKJCIlzHfu4X/YY3Rg54vCw0BF4L
         7EzD3DK0AIr6JZBBdviz0+kN4VSKrBNI9FVqtBqkFyIEUGDpEKq2rCdkSFteHmc4R581
         D+v485ZQ1XwnT4xW1GHtqUKyKChV994hbuJzpKPGmEW+cbJtL49yBEXZf24jPvo0fQhu
         LHJvBVlPpHsUpSc2DAf7H32G/MfGh/P1fKB2BBe/UDqg/xHwVM1GOpTiv2Jio8eS4DeH
         ZDN4lDdwCWPy+Ulv4Yi5sTzA72BfDi6ne9wTJq6z1slnOqd1XvFtQhVOUnHkAPnSi94y
         rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HUxuzMPte6AmoUFHVUW/BGR7pNMQKFL4+foGss8Ed7U=;
        b=rW6BziQVzZMogH/ff9r2zhQlP6bHSluRabC5UVAtkB0dmm+p/2QIsUHh4vvueYwAXq
         wewrgiw9ecFnoIV54NrQzw8OYRZxg5VUiC4GUB7brg6kEHsEvOqrWs85tfrE7o7tX3rV
         itTfU5sxJWVFaKY0nkv5On9p0H3ZxppJDvy3PO4aTu8TS2mOzvw00lXnUezyJcf6r+Mf
         lBMt4S7GhYhNzLRdF9dRhAMooYL/xWIBcRqbxOC91o45eucvdR+u6ndy5ByNotTUgO2a
         iqmn9mXTOQ23Wv/nOkOXE3Vwc/DeHz3uS5q5LJ8l30G/1YOTCjVu2ixI8Vx8C8iVcU8c
         UsLg==
X-Gm-Message-State: AGRZ1gJww91OiaM027tPTxgTvuMsI5J0f7wCAyAYW8gP34IlC9qXXtKN
        AvRMzLuMylo+UNBC3vJDq7F8YhwZd/NGsNj3K84=
X-Google-Smtp-Source: AJdET5cc7Qn/O6Q2u3xCDqz6yBoeq890Jezau+7H5Ran1QZqvRrMWI7mPyHv1xA/zv9HBp3ed4TrMg96U3X33AQcup4=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr1472770ljb.104.1540983974643;
 Wed, 31 Oct 2018 04:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCfXKTdxPW2OKVyV9-49WqNmQT+mHsui3XXxDBJbkJ6=jA@mail.gmail.com>
 <d7fd18ae-ac93-2c1a-1f6a-21b3c5da8de7@huawei.com>
In-Reply-To: <d7fd18ae-ac93-2c1a-1f6a-21b3c5da8de7@huawei.com>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:06:03 +0300
Message-ID: <CAE5jQCdS5dfFBP7YxyJH-E6wM0pkJ=r4VXhepOuGJzcxBOL0EQ@mail.gmail.com>
Subject: Re: [BUG] Kernel BUG when mounting and then unmounting a fuzzed F2FS image
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I have tested torvalds/master and it works OK with respect to this
test case. So please excuse me for disturbance.

Best regards
Anatoly

=D0=BF=D0=BD, 29 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 14:14, Chao Yu <yu=
chao0@huawei.com>:
>
> Hi Anatoly,
>
> Could you please try pending v5.00rc1 or v4.20rc1, since in this round we
> have fixed this issue with below commit:
>
> edc55aaf0d17 ("f2fs: avoid f2fs_bug_on if f2fs_get_meta_page_nofail got E=
IO")
>
> Thanks,
>
> On 2018/10/28 19:50, Anatoly Trosinenko wrote:
> > Hello,
> >
> > When mounting and then unmounting a fuzzed F2FS image, a BUG is
> > triggered at fs/f2fs/checkpoint.c:127.
> >
> > How to reproduce with kvm-xfstests:
> > 1) Checkout v4.19, copy x86_64-config-4.14 to .config, perform `make
> > olddefconfig`, then compile
> > 2) Place the attached image (128M unpacked) to /tmp/kvm-xfstests-$USER
> > 3) Inside the `kvm-xfstests shell` execute:
> >
> > root@kvm-xfstests:~# mount /vtmp
> > root@kvm-xfstests:~# mount /vtmp/f2fs.img /mnt
> > [   11.456857] F2FS-fs (loop0): Found nat_bits in checkpoint
> > [   11.460360] F2FS-fs (loop0): Mounted with checkpoint version =3D 1c8=
a6001
> > root@kvm-xfstests:~# umount /mnt
> > [   14.592761] ------------[ cut here ]------------
> > [   14.593218] kernel BUG at fs/f2fs/checkpoint.c:127!
> > [   14.593739] invalid opcode: 0000 [#1] SMP PTI
> > [   14.594129] CPU: 0 PID: 368 Comm: umount Not tainted 4.19.0-xfstests=
 #1
> > [   14.594710] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   14.595497] RIP: 0010:f2fs_get_meta_page_nofail+0x41/0x50
> > [   14.596030] Code: 00 00 4c 89 e6 48 89 ef e8 1c f3 ff ff 48 3d 00
> > f0 ff ff 76 17 48 83 f8 fb 75 05 83 eb 01 75 dd 31 f6 48 89 ef e8 bf
> > fe ff ff <0f> 0b 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > 31 d2
> > [   14.597784] RSP: 0018:ffffb95ec095fad8 EFLAGS: 00010296
> > [   14.598257] RAX: ffff9982b9d2d280 RBX: 0000000000000009 RCX: 0000000=
000000000
> > [   14.598935] RDX: ffffffff00000001 RSI: 0000000000000007 RDI: 0000000=
000000246
> > [   14.599608] RBP: ffff9982babe0000 R08: 00000004d0a24803 R09: 0000000=
000000001
> > [   14.600286] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000=
001201aef
> > [   14.600953] R13: ffff9982b9d14c00 R14: 00000000009008ef R15: 0000000=
000000001
> > [   14.601625] FS:  0000000000000000(0000) GS:ffff9982bda00000(0063)
> > knlGS:00000000f7bdab00
> > [   14.602384] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > [   14.602899] CR2: 0000000056c95460 CR3: 00000000785ea006 CR4: 0000000=
000360ef0
> > [   14.603550] Call Trace:
> > [   14.603779]  __flush_nat_entry_set+0x118/0x620
> > [   14.604182]  f2fs_flush_nat_entries+0x239/0x290
> > [   14.604585]  ? __submit_merged_write_cond+0xa7/0x200
> > [   14.605026]  ? up_write+0x1c/0x80
> > [   14.605324]  ? __submit_merged_write_cond+0xa7/0x200
> > [   14.605764]  f2fs_write_checkpoint+0x45c/0x720
> > [   14.606161]  f2fs_sync_fs+0xb9/0x1a0
> > [   14.606482]  sync_filesystem+0x71/0x90
> > [   14.606818]  generic_shutdown_super+0x22/0x100
> > [   14.607214]  kill_block_super+0x21/0x50
> > [   14.607558]  kill_f2fs_super+0x67/0xc0
> > [   14.607893]  deactivate_locked_super+0x2f/0x70
> > [   14.608292]  cleanup_mnt+0x3b/0x70
> > [   14.608598]  task_work_run+0x9e/0xd0
> > [   14.608919]  exit_to_usermode_loop+0xb7/0xc0
> > [   14.609299]  do_fast_syscall_32+0x267/0x2f0
> > [   14.609672]  entry_SYSENTER_compat+0x84/0x96
> > [   14.610082] ---[ end trace d15a41554e67c0ec ]---
> > [   14.610500] RIP: 0010:f2fs_get_meta_page_nofail+0x41/0x50
> > [   14.610979] Code: 00 00 4c 89 e6 48 89 ef e8 1c f3 ff ff 48 3d 00
> > f0 ff ff 76 17 48 83 f8 fb 75 05 83 eb 01 75 dd 31 f6 48 89 ef e8 bf
> > fe ff ff <0f> 0b 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > 31 d2
> > [   14.612632] RSP: 0018:ffffb95ec095fad8 EFLAGS: 00010296
> > [   14.613096] RAX: ffff9982b9d2d280 RBX: 0000000000000009 RCX: 0000000=
000000000
> > [   14.613720] RDX: ffffffff00000001 RSI: 0000000000000007 RDI: 0000000=
000000246
> > [   14.614347] RBP: ffff9982babe0000 R08: 00000004d0a24803 R09: 0000000=
000000001
> > [   14.614974] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000=
001201aef
> > [   14.615610] R13: ffff9982b9d14c00 R14: 00000000009008ef R15: 0000000=
000000001
> > [   14.616240] FS:  0000000000000000(0000) GS:ffff9982bda00000(0063)
> > knlGS:00000000f7bdab00
> > [   14.616949] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > [   14.617457] CR2: 0000000056c95460 CR3: 00000000785ea006 CR4: 0000000=
000360ef0
> > Segmentation fault
> > root@kvm-xfstests:~#
> >
> > Best regards
> > Anatoly
> >
>
