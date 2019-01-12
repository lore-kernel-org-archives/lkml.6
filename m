Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF2BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34D206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAwGPxWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfALVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:04:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53612 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfALVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:04:00 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so8009055ita.3;
        Sat, 12 Jan 2019 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXf0DCd6MUag5f9mkVxQ93xGBchBD9WryxVXCzuHuRU=;
        b=UAwGPxWsJi3ZkhxWAlvuXSmjmo5fzifUR/bun415O19Rd1sJfx46Eop3oUm9j0pcDR
         dn3IuzUl34IwAh0lIptTcgettWRkZ61nPstTH7+y1AkQIk4ibUH/pi5Fd7DtQy28uM0m
         9dtGyWbRrAFungN3pcbA8pbrJtAuUWmvSZ+Gkoqc6P0KlAUW8+gFvg0gEjc0tQjiscMI
         AJ8HR1I4Z6SaMXzmzx4Opl7cPKHDrz9TqMNBimyuFeM17lThxy5J2fBTmuyW+YubrxYU
         zVLe4vYrS9Mw861O2C6BmwlIsKwGOMEE2cse29RuNRAXokqIlzpu/dsGXg4AUOZEUNg9
         BSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXf0DCd6MUag5f9mkVxQ93xGBchBD9WryxVXCzuHuRU=;
        b=KzjWsOTo3WCNYzHowruEdI9OKbzZjIkjMcO3vjKJZJYJx2f33vbFxrFfxjwjonijIM
         fs9a7F251c+TWEi3KvTkulrc03+Gnv1q6SpRZmXJBq9pV12BjJqROpFMHRGL9FTScrcG
         OEkfo84Y+y4WKuXsrDgWicV0eOybTZg4mzeHEswU9CLjNTUrY6518rU2Joig/aFV78mw
         XtD+nKkpxA9Mezo6WxgQ/1l81z2xN60geXmH9n5ZTIP+Lo9sr7KwB2COZJvS0bGV2R/M
         wXcUtyi5ZKCgq7tPvg1ZZgoaATWj4XCdzMbKv1T9/s2hoApXSFhYY/BpUPIDdkNO4p8V
         vdUA==
X-Gm-Message-State: AJcUukclFhJXT8FD1rJeBEQb5e29wnEB5F3A2iOF291oUFHKdkPnkaF2
        lT/LrRH/cOSaFqocDQVqkMm6d9Vzg9PtvCnTywY=
X-Google-Smtp-Source: ALg8bN4eWNxdaUW4SUB9hX0SdGFX3Fp6yA/++GwXveb/q90Jg/CWW7IwYDZ6ys1bDT7j2GyM6RDldZ61G4wf1s9WwEA=
X-Received: by 2002:a24:eb0f:: with SMTP id h15mr4752068itj.138.1547327039339;
 Sat, 12 Jan 2019 13:03:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamvf8LzpRauFhxeh-EGY_ttqeds6_UQwikc5sm7ORKdjjw@mail.gmail.com>
 <c3a95ad5-5eae-6392-f263-9f05e7f51333@hartkopp.net>
In-Reply-To: <c3a95ad5-5eae-6392-f263-9f05e7f51333@hartkopp.net>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sat, 12 Jan 2019 16:03:48 -0500
Message-ID: <CAEAjamsw9uu-VwHtREqetCsQBrF4B_Hy87xxsZRhAbHUOvzF4w@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in net/can/bcm.c
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     davem@davemloft.net, Arnd Bergmann <arnd@arndb.de>,
        mkl@pengutronix.de, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 3:02 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> So there could potentially be some other users of timeval_to_ktime()
> that might have the same issue.
>

The following would be the one related.

=========================================
UBSAN: Undefined behaviour in ./include/linux/ktime.h:42:14
signed integer overflow:
-3428892174463270912 * 1000000000 cannot be represented in type 'long int'
CPU: 0 PID: 7024 Comm: syz-executor6 Not tainted 4.19.13 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
 bcm_timeval_to_ktime include/linux/ktime.h:42 [inline]
 bcm_rx_setup net/can/bcm.c:1189 [inline]
 bcm_sendmsg+0x35ea/0x3fd0 net/can/bcm.c:1355
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:631
 sock_write_iter+0x24b/0x3d0 net/socket.c:900
 call_write_iter include/linux/fs.h:1811 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6045f43c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6045f446cc RCX: 00000000004497b9
RDX: 0000000000000048 RSI: 00000000200000c0 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000ba60 R14: 00000000006f4b00 R15: 00007f6045f44700
=========================================

Thanks,
Kyungtae Kim
