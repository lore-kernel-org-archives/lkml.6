Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ECA20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucu6W5Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKZQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:22:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51358 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:22:59 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so26379311itl.1;
        Sun, 25 Nov 2018 21:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iL9mIYiy752nq90fKWLP0OhkR5arf7Q0NH5cABicMpA=;
        b=ucu6W5Q1Fw9f3zGKtG6F6IIhH+pIiuXhwiL+dh0EbzGA5qhzd/FzQvH7DgM5iqiMz4
         qE1hLieZKwKu3qqvT6Ndy/j1chVIdsvgbsBVYrbVOAbJaxn70wrE9pCV2HgbSy7uhUXk
         MendQUmxN2ZdnySN18ZUgAq/eFyZQvkPNZbgQ0SOXUat/kF4xVbdOW5gjtSGFqUP1v51
         JHc6EE6do2g6w7cx8MbWq+RbaKqmBJvMtiqq/74j3sftRxalHLDyu9c4RslqI/PFkeuC
         ZliZZxSIdyHb0uyRGYTTseArk39b/imqie5MoYNGKilhwzoQ5Zt3tbuxWczV6PFJzu6P
         OKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iL9mIYiy752nq90fKWLP0OhkR5arf7Q0NH5cABicMpA=;
        b=HqSEcemolpunKhpzN31AWNFFgErEW2aJHjhdu99hDi7BC13Zk2uhqbrOuqQVZh3ecs
         58b+zYEEoRLGyg4VhGnySw0JeTfXDIHUaSX3lY0e+SI6zdm87f2rPliYedi4P3b3YZlU
         3B8mxVkKJp9FRcN+XoRRGBgesoaDaKlxxa04/Kyt5UHMmNII9cH1ctLLYrFWYEb2IMcx
         tamJABZQwkzxGo+quFQnVzOrGTXqQzAEsFwi1qGIm07rZwhkO49YPU/t1m1VRPPCH/1I
         s69v0SJmgdykOtjk1zi9UkQSyFIUGO4pOcYbFtX/bjgo7verDPFjQYdQJKuLQQ4iEru6
         vgRQ==
X-Gm-Message-State: AA+aEWb81nN2FfFdm7P9xWOjOpv6cNn/kUKPTwXoJOuHZkb9nZNjsh5M
        FdJtuKsw5DmPwzQlAClS8peOxPkqmxRZKPcanya94w==
X-Google-Smtp-Source: AFSGD/UlyvhwU5e6/Fzr5OaNj7dxWJ0sLYFX3DStJQb2fxuPqVivceC9VJZtvdczolYLx9TZX0f3c2a/kPxkJbNVwEM=
X-Received: by 2002:a02:8a69:: with SMTP id e38mr22710601jal.81.1543210200477;
 Sun, 25 Nov 2018 21:30:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamvKOzcQ4cQuUpDXAKQsq0Rq1+75DhHAp2fYjAk2NnLUOA@mail.gmail.com>
In-Reply-To: <CAEAjamvKOzcQ4cQuUpDXAKQsq0Rq1+75DhHAp2fYjAk2NnLUOA@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 26 Nov 2018 00:29:49 -0500
Message-ID: <CAEAjamtBeQEmzHQqLPW452e0b=T-_697zmZ+x_Buh9U8VjTE4w@mail.gmail.com>
Subject: Fwd: UBSAN: Undefined behaviour in drivers/input/mousedev.c
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Kyungtae Kim <kt0755@gmail.com>
Date: Mon, Nov 26, 2018 at 12:26 AM
Subject: UBSAN: Undefined behaviour in drivers/input/mousedev.c
To: <dmitry.torokhov@gmail.com>
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong
<threeearcat@gmail.com>, <linux-input@vger.kernel.org>,
<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>


We report a crash found in v4.20-rc2:

kernel config: https://kt0755.github.io/etc/config_v4.20
repro: https://kt0755.github.io/etc/repro.5266f.c

In mousedev_rel_event(), "mousedev->packet.dx += value"
(driver/input/mousedev.c:212) causes integer overflow
when the result of calculation is larger than the size of dx.
This can arise because "value" originates from user input
(via evdev_write), and there is no sanity check along the path.

It's not for sure this crash would be tolerable despite its occurrence.
But one way to stop it is to use the bounds check before using it.


Crash log:
=======================================
UBSAN: Undefined behaviour in drivers/input/mousedev.c:212:23
signed integer overflow:
1240408832 + 1240408832 cannot be represented in type 'int'
CPU: 0 PID: 10708 Comm: syz-executor3 Not tainted 4.20.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x2dc/0x327 lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 mousedev_rel_event drivers/input/mousedev.c:212 [inline]
 mousedev_event+0x14ad/0x1830 drivers/input/mousedev.c:370
 input_to_handler+0x414/0x510 drivers/input/input.c:121
 input_pass_values.part.10+0x4ed/0x6c0 drivers/input/input.c:148
 input_pass_values drivers/input/input.c:401 [inline]
 input_handle_event+0x3f0/0x1200 drivers/input/input.c:401
 input_inject_event+0x22f/0x31e drivers/input/input.c:466
 evdev_write+0x483/0x7a0 drivers/input/evdev.c:565
 __vfs_write+0x109/0x6e0 fs/read_write.c:485
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4148cd3c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4148cd46cc RCX: 00000000004497b9
RDX: 00000000000002a6 RSI: 0000000020000080 RDI: 0000000000000014
RBP: 000000000071c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000b820 R14: 00000000006f48c0 R15: 00007f4148cd4700
======================================

Thanks,
Kyungtae Kim
