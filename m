Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887D3217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZQYUnrn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfAWDjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:39:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40163 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfAWDjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:39:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so403782pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 19:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c1dTBVRT1HR7e5EiW1FfWr3iylU2dvW4Y10iIZ4DHPU=;
        b=ZQYUnrn9pOkV1+KAcGfRsCBZ1Y8I8ilwJOqSqGtI2/EpEcy9sQxo/dqYb5sVvT49rp
         Y8Bk0JQGNkyuI0rv/bTrpsFFC2+kQvTBjcPVeQAzU14NEe4ooQc/oZIOIN+Dbrz/0HAF
         5CqZJJXJmK2unQcv6OZ74hq1nBrn+cNAChYzAToHDJXBzBk1hQsJZ+SJBNvh0EPu3ahT
         LEr2l8hv2KSkaXdLubiPl/wM7XFwOkcF5B0hxp1WYkNDqlBeZ4gemKr3dtLcgSPFv8ox
         uBShW9ocPi8XCmZJhIrdHOOoytfjIrTKpsbN0SrDMGloi2xjyAXdYfXPa//kGx6OVX3W
         ZrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c1dTBVRT1HR7e5EiW1FfWr3iylU2dvW4Y10iIZ4DHPU=;
        b=DHHG3+rAWoyKwmyBAbMXf1RRuZZ9S6xEMkukpQgk3TFZzLKS2x+tEH9iBo4foVIDK+
         mTL0xhPZxU1ye+K7ZPN4H8bpmEHbBgPvfw1ulWfvYLgMi3wmVuYa24r3u3dHzjkNr/2J
         aVn0EzluyoNL/gx+vRu+iuJdU05VeW5w/EjED688gI2BIZpnnSmkOBNaoPD74K6JqAtG
         eOu0Kq8KybEsFnawzOdtJ0KTLUjGZ2oYmroOkN0yu8XG4laCp6t+kfB2DNFfPlBf2+Wx
         Cnnc1vxG4zjbm/YQfHNf6tu09w016XxgCADj0YLrzK0qF1LdZ2q1xTrgtQQhZUPDExIx
         qhkQ==
X-Gm-Message-State: AJcUukergRlYqeh/l5jujsWAE60xZE7SqcMh0itR1l0bwg/e+EkxIVYP
        3eKeF0fvD846engYfjwhO45EzErTIb1jyg==
X-Google-Smtp-Source: ALg8bN7W+KKeKocQ/Pfs/ihaRi0VTPfpm8wFwaz+rW7b1BXvOX4D5ges/YXRDPBIIiuu5PbKOooWCQ==
X-Received: by 2002:a63:5518:: with SMTP id j24mr567693pgb.208.1548214745258;
        Tue, 22 Jan 2019 19:39:05 -0800 (PST)
Received: from [192.168.1.238] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a195sm32233962pfa.7.2019.01.22.19.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 19:39:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: LTP case read_all_proc fails on qemux86-64 since 5.0-rc1
From:   Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (16D5039a)
In-Reply-To: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
Date:   Tue, 22 Jan 2019 20:39:02 -0700
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1903094-A3C8-4273-9869-72D400180E51@kernel.dk>
References: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
To:     He Zhe <zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2019, at 8:13 PM, He Zhe <zhe.he@windriver.com> wrote:
>=20
>=20
> LTP case read_all_proc(read_all -d /proc -q -r 10) often, but not every ti=
me, fails with the following call traces, since 600335205b8d "ide: convert t=
o blk-mq"(5.0-rc1) till now(5.0-rc3).
>=20
> qemu-system-x86_64 -drive file=3Drootfs.ext4,if=3Dvirtio,format=3Draw -obj=
ect rng-random,filename=3D/dev/urandom,id=3Drng0 -device virtio-rng-pci,rng=3D=
rng0 -nographic -m 16192 -smp cpus=3D12 -cpu core2duo -enable-kvm -serial mo=
n:stdio -serial null -kernel bzImage -append 'root=3D/dev/vda rw highres=3Do=
ff console=3DttyS0 mem=3D16192M'
>=20
> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
> [   47.080156] Warning: /proc/ide/hd?/settings interface is obsolete, and w=
ill be removed soon!
> [   47.085330] ------------[ cut here ]------------
> [   47.085810] kernel BUG at block/blk-mq.c:767!
> [   47.086498] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   47.087022] CPU: 5 PID: 146 Comm: kworker/5:1H Not tainted 5.0.0-rc3 #1=

> [   47.087858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> [   47.088992] Workqueue: kblockd blk_mq_run_work_fn
> [   47.089469] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
> [   47.090035] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89=
 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
> [   47.091930] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
> [   47.092458] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000=
000006
> [   47.093181] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea1=
3c0000
> [   47.093906] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000=
000000
> [   47.094626] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1=
033a40
> [   47.095347] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000=
000046
> [   47.096071] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS=
:0000000000000000
> [   47.096898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   47.097477] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 0000000000=
0006e0
> [   47.098203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> [   47.098929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> [   47.099650] Call Trace:
> [   47.099910]  <IRQ>
> [   47.100128]  blk_mq_requeue_request+0x58/0x60
> [   47.100576]  ide_requeue_and_plug+0x20/0x50
> [   47.101014]  ide_intr+0x21a/0x230
> [   47.101362]  ? idecd_open+0xc0/0xc0
> [   47.101735]  __handle_irq_event_percpu+0x43/0x1e0
> [   47.102214]  handle_irq_event_percpu+0x32/0x80
> [   47.102668]  handle_irq_event+0x39/0x60
> [   47.103074]  handle_edge_irq+0xe8/0x1c0
> [   47.103470]  handle_irq+0x20/0x30
> [   47.103819]  do_IRQ+0x46/0xe0
> [   47.104128]  common_interrupt+0xf/0xf
> [   47.104505]  </IRQ>
> [   47.104731] RIP: 0010:ide_output_data+0xbc/0x100
> [   47.105201] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00=
 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
> [   47.107092] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: fffff=
fffffffffdd
> [   47.107862] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000=
000000
> [   47.108581] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000=
000000
> [   47.109293] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000=
000170
> [   47.110016] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea1=
3a8800
> [   47.110731] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000=
007530
> [   47.111446]  ide_transfer_pc+0x216/0x310
> [   47.111848]  ? __const_udelay+0x3d/0x40
> [   47.112236]  ? ide_execute_command+0x85/0xb0
> [   47.112668]  ? ide_pc_intr+0x3f0/0x3f0
> [   47.113051]  ? ide_check_atapi_device+0x110/0x110
> [   47.113524]  ide_issue_pc+0x178/0x240
> [   47.113901]  ide_cd_do_request+0x15c/0x350
> [   47.114314]  ide_queue_rq+0x180/0x6b0
> [   47.114686]  ? blk_mq_get_driver_tag+0xa1/0x110
> [   47.115153]  blk_mq_dispatch_rq_list+0x90/0x550
> [   47.115606]  ? __queue_delayed_work+0x63/0x90
> [   47.116054]  ? deadline_fifo_request+0x41/0x90
> [   47.116506]  blk_mq_do_dispatch_sched+0x80/0x100
> [   47.116976]  blk_mq_sched_dispatch_requests+0xfc/0x170
> [   47.117491]  __blk_mq_run_hw_queue+0x6f/0xd0
> [   47.117941]  blk_mq_run_work_fn+0x1b/0x20
> [   47.118342]  process_one_work+0x14c/0x450
> [   47.118747]  worker_thread+0x4a/0x440
> [   47.119125]  kthread+0x105/0x140
> [   47.119456]  ? process_one_work+0x450/0x450
> [   47.119880]  ? kthread_park+0x90/0x90
> [   47.120251]  ret_from_fork+0x35/0x40
> [   47.120619] Modules linked in:
> [   47.120952] ---[ end trace 4562f716e88fdefe ]---
> [   47.121423] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
> [   47.121981] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89=
 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
> [   47.123851] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
> [   47.124393] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000=
000006
> [   47.125108] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea1=
3c0000
> [   47.125819] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000=
000000
> [   47.126539] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1=
033a40
> [   47.127262] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000=
000046
> [   47.127988] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS=
:0000000000000000
> [   47.128793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   47.129385] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 0000000000=
0006e0
> [   47.130104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> [   47.130823] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> [   47.131547] Kernel panic - not syncing: Fatal exception in interrupt
> [   47.132609] Kernel Offset: 0x7c00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
> [   47.133679] ---[ end Kernel panic - not syncing: Fatal exception in int=
errupt ]---
> [   47.134432] ------------[ cut here ]-----------

I=E2=80=99ll take a look at this, thanks for the report.

=E2=80=94=20
Jens Axboe=20

