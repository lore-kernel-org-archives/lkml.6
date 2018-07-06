Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69B24003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69B24003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeGFKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:02:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:33336 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeGFKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:02:03 -0400
Received: by mail-it0-f69.google.com with SMTP id p82-v6so565922itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=B71XJkvIaU8M3TzNuiJ7t59olbHSPtpn+o2uAvxM0rg=;
        b=j+2GCv0nFMPvhxPMrhBr/upV8jqmGzs9StCR1X7l+bPIa8ZEPfLAtttU5SJRQCSinu
         bR9gVUfI0Oxu0jp5Z/QtrCWpciiNxW7FDEkLRwMORKXrMVyQuc+hlVaExCVdBJlsvzlu
         JAuKU3n6yPfboXz/QFpjeg26iXV3sqJ91efEdYuP5uHLPoj81HjGoFGucREHofQT8IAe
         qmtVkMBuVtZpmcaZY2vzwzHYGsaT29qewhQXcPdjYlRq3lWrGyn7T5J9wyRqcmuxO8Ci
         RD1jkO01yugHXhtqh6GmQ0s5fRsviLghN0qrnTRjSyVMe0S2yWuGMcdYShfK5KTu6mTd
         0G5A==
X-Gm-Message-State: AOUpUlFQyRM0b4qkY4q1towHGEoGlbF0sxsBz5OM0r2cGbL1QlGZX/ID
        o0d4wunNf6Dqg4vXtwqhX0yzC98zcWQPkQOk2XJFK17s9iPH
X-Google-Smtp-Source: AAOMgpdsggSH1ggEbjblxYEeTIkZugQgA+2DwdskfNnro1gNuoqBIcpIK4V/nWa5yMXoYJ6KBRbucu3YWxCCcLViV6lDK0f4sj3l
MIME-Version: 1.0
X-Received: by 2002:a6b:5d1c:: with SMTP id r28-v6mr4073617iob.47.1530871322556;
 Fri, 06 Jul 2018 03:02:02 -0700 (PDT)
Date:   Fri, 06 Jul 2018 03:02:02 -0700
In-Reply-To: <00000000000098e65b056d184a11@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060bff7057051c10c@google.com>
Subject: Re: general protection fault in bpf_tcp_close
From:   syzbot <syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, dvyukov@google.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6fcf9b1d4d6c r8169: fix runtime suspend
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1600b10c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d264f2b04177ca7c
dashboard link: https://syzkaller.appspot.com/bug?extid=0ce137753c78f7b6acc1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15ba0a1c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100c8170400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4705 Comm: syz-executor133 Not tainted 4.18.0-rc3+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_tcp_close+0x215/0x1050 kernel/bpf/sockmap.c:327
Code:
------------[ cut here ]------------
Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected  
to SLAB object 'TCPv6' (offset 704, size 64)!
WARNING: CPU: 1 PID: 4705 at mm/usercopy.c:81 usercopy_warn+0xf5/0x120  
mm/usercopy.c:76
Kernel panic - not syncing: panic_on_warn set ...

Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

