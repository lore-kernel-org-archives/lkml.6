Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 93C60C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C14208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C14208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935635AbeFMNhF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:37:05 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:55169 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935107AbeFMNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:37:03 -0400
Received: by mail-io0-f198.google.com with SMTP id p12-v6so2178743iog.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zuD9ElIj/sbUVPXgWtSTrvhrkfk8Z8lBr1rN6NSCDhA=;
        b=BEmdzkEF0vCYR+kU4LO9yXeckG+qtHO5OUesHQrJckphzhQCqhfPCG8k6gcwuO1Fyz
         GSFXD4IfhUvsELTHppFLaxE0enbs1KViItKLLhEoiEUtAKGVUrhRokrUkR86YW61GQI/
         jutpqBVdHbwEYqqZqAd0xk0I/2llIc+HnN99S4cjc8HtN2CRh9OxRcb6ichLM6Zbrvlr
         RstFAQOc/cwdsEZcZc9lkaNcYsp033nuO/dIOsLL1/z8ODrRL6l9RTCylDmZnGRVfFfJ
         wsSy6iKcODvlOWIeL5eOcx24JXozmigfXwzd6BHdo6zq7AUrVWN6230hHygBIUm/X7qL
         jywg==
X-Gm-Message-State: APt69E2j2r3DNkaO2uSZixszchhsUX2QxGXEVL/OCGADISLMBKx6uyvr
        1YBbrVbLQMRbddXXi7SFT37WCy2mDMUva8ybQm97EIb9xl62
X-Google-Smtp-Source: ADUXVKLZTPWymO5rZFSMhIv3LWHc6fwjmRFkoChDodr1UnXeDRlYa8rwIVk9lmzW6xfZNy9tXaUCeqmTqOkKI43W0v8+Goi3z+jv
MIME-Version: 1.0
X-Received: by 2002:a24:2815:: with SMTP id h21-v6mr2101429ith.53.1528897021868;
 Wed, 13 Jun 2018 06:37:01 -0700 (PDT)
Date:   Wed, 13 Jun 2018 06:37:01 -0700
In-Reply-To: <00000000000040ef1a056e85de5e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e30245056e861322@google.com>
Subject: Re: KASAN: use-after-free Read in crypto_morus640_decrypt_chunk
From:   syzbot <syzbot+d82643ba80bf6937cd44@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109f9037800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d82643ba80bf6937cd44
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1799185f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1241e1bf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d82643ba80bf6937cd44@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crypto_morus640_load_a crypto/morus640.c:111  
[inline]
BUG: KASAN: use-after-free in crypto_morus640_decrypt_chunk+0xcf8/0xd20  
crypto/morus640.c:278
Read of size 4 at addr ffff8801c0fc6003 by task syz-executor042/4573

CPU: 1 PID: 4573 Comm: syz-executor042 Not tainted 4.17.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  crypto_morus640_load_a crypto/morus640.c:111 [inline]
  crypto_morus640_decrypt_chunk+0xcf8/0xd20 crypto/morus640.c:278
  crypto_morus640_process_crypt.isra.12+0x153/0x230 crypto/morus640.c:376
  crypto_morus640_crypt+0x42e/0x9f0 crypto/morus640.c:442
  crypto_morus640_decrypt+0x23e/0x3d0 crypto/morus640.c:485
  crypto_aead_decrypt include/crypto/aead.h:370 [inline]
  _aead_recvmsg crypto/algif_aead.c:315 [inline]
  aead_recvmsg+0x13cc/0x1ba0 crypto/algif_aead.c:334
  sock_recvmsg_nosec net/socket.c:818 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:825
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2323
  __sys_recvmsg+0x112/0x260 net/socket.c:2372
  __do_sys_recvmsg net/socket.c:2382 [inline]
  __se_sys_recvmsg net/socket.c:2379 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2379
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445b19
Code: e8 5c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 51 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0fc4fccda8 EFLAGS: 00000297 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00000000006dac9c RCX: 0000000000445b19
RDX: 0000000000000000 RSI: 0000000020002840 RDI: 0000000000000011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dac98
R13: 558bdd1ccff55d26 R14: f09319918a28f2b7 R15: 0000000000000001

The buggy address belongs to the page:
page:ffffea000703f180 count:0 mapcount:0 mapping:0000000000000000 index:0x1
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 ffffea0007208788 ffffea0007026148 0000000000000000
raw: 0000000000000038 0000000000000000 0000000200000000 ffff8801d9a42c80
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c0fc5f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c0fc5f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c0fc6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff8801c0fc6080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c0fc6100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

