Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D62C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A5F2652B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkRuMrgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A5F2652B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeFZGEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:04:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36799 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeFZGEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:04:42 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so14819219iog.3;
        Mon, 25 Jun 2018 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=70AnaB5xLNjntSlxb363yExwJsT2YtaMe5ErJQ0Pb6E=;
        b=WkRuMrgqdR1ZjP2NHaG6sOU6vooD9BR/ItPpzVeCF7KzViMgqCb2xOBRmbd1WEbpw/
         rdfKsY8m1qAWwm2VPpj1Kkc023LRGGYmBk0A8J3QCtke0JLU+Svff/6e4KSBoMAz8v4y
         +sTmH0xxxbIqtcLRXwsMRJpdSv71yI7Lvzi4VRh5Esa4KXmgaikmBhQ7Qxss763Zzubc
         X+Sm3G6h1z7HRGFQKeKCxWNS93j1TR1OmyUOa9RRwVyc+ZpwaqJwtoqt3EsVQUHOD1Rc
         THaHMRwvg2ZAu/D232AO1h+hVFZZXGsVIPAwvELWbwKCq4DKc1jh18NZZneq3xTWw7+m
         hi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=70AnaB5xLNjntSlxb363yExwJsT2YtaMe5ErJQ0Pb6E=;
        b=DMLv/3bIJ3nNYIGS6uYrK85k1sy7h/5RYuwNQ9IMRUmeH6CWNp4AGBIzo7Ftqb8B3n
         uIithljP7bnNJnRGBV8Zu5St6r+8XsfcjKI99pk9h3Skp9O2BTfPU+trPmxV5ta9mimv
         +gCSMYbuWmWFPONiwLT//dfY8H97xs5qIwOC4MRsQpbKUXg+2ORJzvpsOF4t38zgUX2r
         iezEubVBOXSCCSxO7y2fJe4Q0qzuFMsFDF21Vh/S2H3je2MpNH+JWIzpziAxiNFkOH2u
         ISAd2E3Q2ICFbZO5WOyEUzXDbLvykNwwRkS4Ei5BKmIFW5U0BV0H/zvPjgI7vk2xxQHx
         GzIw==
X-Gm-Message-State: APt69E19ofbgsvfAmF1WyxFN2p5tx/pJrD5iP79rJO51ygP/qg9B7vp9
        E0mzGGzKIqbMIjTTsiGTonZ/sx5RnvvXvgScABU=
X-Google-Smtp-Source: AAOMgpdIHrdG3170S879u2kzJtda/LK2DugJK24EDPieAdYZriTUDwKaGXrhMJhM3X2rgNB6Vja1ssHrwVry4XuaxnQ=
X-Received: by 2002:a6b:280a:: with SMTP id o10-v6mr121301ioo.168.1529993081649;
 Mon, 25 Jun 2018 23:04:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d188:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 23:04:41
 -0700 (PDT)
In-Reply-To: <0000000000005d2af6056f8474ac@google.com>
References: <0000000000005d2af6056f8474ac@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 26 Jun 2018 14:04:41 +0800
Message-ID: <CADvbK_cCTEp2S2rOot7bu=tuAVJ1x4Py9Zyv7ob3X8_5RcENhQ@mail.gmail.com>
Subject: Re: WARNING in sctp_assoc_update_frag_point
To:     syzbot <syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com>
Cc:     davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:06 PM, syzbot
<syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6f0d349d922b Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a423c0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
> dashboard link: https://syzkaller.appspot.com/bug?extid=f0d9d7cba052f9344b03
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com
>
> WARNING: CPU: 0 PID: 22543 at include/net/sctp/sctp.h:598 sctp_mtu_payload
> include/net/sctp/sctp.h:598 [inline]
> WARNING: CPU: 0 PID: 22543 at include/net/sctp/sctp.h:598
> sctp_assoc_update_frag_point+0x252/0x2c0 net/sctp/associola.c:1401
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 22543 Comm: syz-executor2 Not tainted 4.18.0-rc2+ #117
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:sctp_mtu_payload include/net/sctp/sctp.h:598 [inline]
> RIP: 0010:sctp_assoc_update_frag_point+0x252/0x2c0 net/sctp/associola.c:1401
> Code: 76 fa 45 39 e5 76 1e e8 0c 69 76 fa 45 29 e5 45 89 ec e9 34 ff ff ff
> e8 fc 68 76 fa 45 8d 66 34 e9 09 ff ff ff e8 ee 68 76 fa <0f> 0b 45 31 e4 e9
> 17 ff ff ff e8 7f 3c b4 fa e9 31 fe ff ff 4c 89
> RSP: 0018:ffff8801d7def378 EFLAGS: 00010216
> RAX: 0000000000040000 RBX: ffff8801d8580ac0 RCX: ffffc900133ca000
> RDX: 00000000000001b9 RSI: ffffffff8705a382 RDI: 0000000000000004
> RBP: ffff8801d7def3a0 R08: ffff8801cfaa6000 R09: ffffed002e0421af
> R10: ffffed002e0421af R11: ffff880170210d7f R12: 0000000000000044
> R13: 0000000000000044 R14: 0000000000000010 R15: ffff8801d8580ac0
>  sctp_assoc_set_pmtu net/sctp/associola.c:1417 [inline]
>  sctp_assoc_sync_pmtu+0x251/0x2e0 net/sctp/associola.c:1445
We may need a fix:
@@ -282,7 +282,10 @@ bool sctp_transport_update_pmtu(struct
sctp_transport *t, u32 pmtu)

        if (dst) {
                /* Re-fetch, as under layers may have a higher minimum size */
-               pmtu = SCTP_TRUNC4(dst_mtu(dst));
+               int dst_mtu = SCTP_TRUNC4(dst_mtu(dst));
+
+               if (pmtu < dst_mtu)
+                       pmtu = dst_mtu;
                change = t->pathmtu != pmtu;

to make sure the t->pathmtu never get a value smaller than MINSEGMENT,
also meets the comments:
"Re-fetch, as under layers may have a higher minimum size".
