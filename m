Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81929205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZw2mhTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81929205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJaToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:44:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52701 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:44:02 -0400
Received: by mail-it1-f195.google.com with SMTP id r5-v6so15573105ith.2;
        Wed, 31 Oct 2018 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8NEWjaC2XC79OfIUP7yp2O+Axh+GatGqHoPyYAiOQxg=;
        b=IZw2mhTf2cRUMq7KugfbQseZGkL+1WC0lpETGs5AfcrdmX9byKkJHxJukmjnIVpTbP
         X6Ro7IvlGqWhy3q+gQq0nV/6QoKTng0/jhX88L4l9psMYdPmnExfrAmWpUbD7E9gBMAA
         MuaXZAOsH5mTwXmSnJ791jkQrDvY8shcwFAsqHPX7jLlm7DIUVKmeCGnzsb3Cj+/ZNpH
         Qg0zB1pF4NH9v7JZ6bKUynTw/QrfDnc9bs3hh9Fg4mtwGaYaTx6AYJ1EceNK8n4+Znt5
         VzV5rxdVak4VlAD9N1icni0dhlVfN3G+H9dIanVauYjHalbpNMV0+p/TbZMxm9Q5Kb7Q
         FqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8NEWjaC2XC79OfIUP7yp2O+Axh+GatGqHoPyYAiOQxg=;
        b=Kl48PARn9XeeQa/cd0XHRUlxRAB57nGrMAh5XHKtJJ/Gz4ZTAQVmhcr/RymV9VClSz
         zxo21Pt12HNvaEuCWW1QDdNRCYoxW4qmDgTL4RC1vlTrXCcX6TUnvq62vneLtgQr1qw/
         XAQI9cIY+hcDuee1CDWIpQpIQCYpYXIIexy5nD4DudL176NSwoqw5Wj63A4O8YfzdNfc
         lDm9QjiUcvbMl5fbRylgXYfBDVHq2Q7csRghonIjCMlfXseTfGCOS1PVGJ8fqXy+FV4Z
         b9WgKOgWXIgFX7Rs0qtj4KOfGZWcGNZp4JX5sIQzFbpPsuwCGgxxCV0kZgqdp7sc+Nbq
         e50A==
X-Gm-Message-State: AGRZ1gKEloKe3gJ0y0OkY5lxKeIRKIcTRs7Hp7RErI23Cgyjk+6nZ1Wp
        KWm7ZP5SF0iSgSowZtXBi9YDI3RXIBd45NRiZrA=
X-Google-Smtp-Source: AJdET5fxXv2JQr5VZBuXYkZxMX2IzsgeEqFH0XKIER1y0T+VvXUCxmtgSu7FFCPuCIa3OrWyzHcmze1/j+GRortAWRU=
X-Received: by 2002:a24:c9c2:: with SMTP id h185-v6mr1696537itg.138.1540982787560;
 Wed, 31 Oct 2018 03:46:27 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 31 Oct 2018 06:46:16 -0400
Message-ID: <CAEAjamurFhLE7QOq596Kue8oy-MXeju_68bwn7_Byqi6r2yoUA@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/net/ppp/ppp_generic.c
To:     paulus@samba.org, davem@davemloft.net
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, netdev@vger.kernel.org,
        linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a crash in v4.19-rc2 (and the latest kernel as well):

kernel config: https://kt0755.github.io/etc/config_v2-4.19
repro: https://kt0755.github.io/etc/repro.1e3e9.c

unit_set() lacks the bounds checking for an integer variable n,
which causes integer overflow when it is equal to INT_MAX.

=======================================================
UBSAN: Undefined behaviour in drivers/net/ppp/ppp_generic.c:3246:9
signed integer overflow:
2147483647 + 1 cannot be represented in type 'int'
CPU: 0 PID: 7676 Comm: syz-executor4 Not tainted 4.19.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 unit_set drivers/net/ppp/ppp_generic.c:3246 [inline]
 ppp_unit_register drivers/net/ppp/ppp_generic.c:979 [inline]
 ppp_dev_configure+0xbd8/0xd50 drivers/net/ppp/ppp_generic.c:1049
 ppp_create_interface drivers/net/ppp/ppp_generic.c:3013 [inline]
 ppp_unattached_ioctl drivers/net/ppp/ppp_generic.c:848 [inline]
 ppp_ioctl+0x1652/0x27f0 drivers/net/ppp/ppp_generic.c:601
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f67b6f92c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67b6f936cc RCX: 00000000004497b9
RDX: 0000000020000080 RSI: 00000000c004743e RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005598 R14: 00000000006ed638 R15: 00007f67b6f93700
======================================================

A simple patch below is provided.
Note that in this control flow, negative n is already
filtered out (drivers/net/ppp/ppp_generic.c:965).

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3243,6 +3243,9 @@ static int unit_set(struct idr *p, void *ptr, int n)
 {
        int unit;

+  if (n == INT_MAX)
+               return -EINVAL;
+
        unit = idr_alloc(p, ptr, n, n + 1, GFP_KERNEL);
        if (unit == -ENOSPC)
                unit = -EINVAL;

Thanks,
Kyungtae Kim
