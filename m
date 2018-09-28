Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724472170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbYfKAR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724472170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeI1PDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:03:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37647 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeI1PDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:03:36 -0400
Received: by mail-it1-f194.google.com with SMTP id m9-v6so1708790ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8smDtu9rxj1JpRjVUCVoX05RcwsMP6p+uulJdpz1Sc=;
        b=WbYfKAR8yziPHKcZk7hb9IUiFgoJ9Y5vqc5hUvqrQ7MecItSj4jTrbXdHob6Ns2fyy
         aCS5tUxfxQ/z8CLc0Of26I0+eFHGbVlpD2Gnx+kPXIBsEGAuxI/cKaDDoL3/bkuN9d/7
         /t3aUC1Le/7jYItY8AaQ+XdI8wcPFsXFDr68STl1AnLgeEI3tIxZ8Z1M0E0EPBUK8qoK
         c7T7coNt6nAjjXbLIhJh003m6ia0+CcSeyNGw8g4BMThT4gvN0KHe7zrgrolxZewnKmV
         TK+1f72i/PdDMEkacERj1NIpbMhvCfkGgDIQwTEYYaz3Kl0fHgBQm+tEuoc5JMPC8Nfp
         d1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8smDtu9rxj1JpRjVUCVoX05RcwsMP6p+uulJdpz1Sc=;
        b=glv7w8C1iFW+V/kfVhqg0MYBPUyFb3qm4TvJ349CvcNYNTMRdIJo7JzgM8HG8hyH80
         bg2xoTFXorkXG+VvbRUzwyKwAtGwv8Nh5l3IqIJ0IYAUZrfYy5CVepCsyzdmkejnYy4s
         Bf1cgJukmTGOuKbb1oTTiGvNph49ZTunlQOXSBnHeScuuZ0XoNzOcIugFWNLPw1jCRSI
         fpvroRVpy7UtQsPJkfGwzzvWtdAeWMtlsUjje8XwEEVxdbQq2jMapps6E1gQjBwxxme3
         UN6Rs51NVEpflG/+gL9zogch1OwcmXcjN82f9b9/HUQAqDCMVKsAL8yRjaiPY5ADBeyw
         ECWQ==
X-Gm-Message-State: ABuFfoiw/u5IJSUgAXlleFmtIqsuQmTcsAVDn7W0Ds5Y07uN1d9vMluX
        I+bYUKINulL4D1woa0uBKPcaaUsOQezgKywSgt9FAw==
X-Google-Smtp-Source: ACcGV60z0n5aXwhZsqr2guBlE7aNm/z1nM45LXNHECo4EdrADuK6ADY16iMqG1fPOM6k0yIn4qZwsLpc99QLVi88m/Y=
X-Received: by 2002:a24:c0c5:: with SMTP id u188-v6mr870983itf.57.1538124054632;
 Fri, 28 Sep 2018 01:40:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 01:40:34
 -0700 (PDT)
In-Reply-To: <00000000000095faa90576c17f86@google.com>
References: <00000000000095faa90576c17f86@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 28 Sep 2018 10:40:34 +0200
Message-ID: <CACT4Y+bh8-vLrXMDoKFNOuXk8BSqjcHLBoAn4EeMLxFO9koRtQ@mail.gmail.com>
Subject: Re: general protection fault in __aa_lookupn_ns
To:     syzbot <syzbot+9b37e75e781b5e400f65@syzkaller.appspotmail.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:52 AM, syzbot
<syzbot+9b37e75e781b5e400f65@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    dad486875956 Add linux-next specific files for 20180924
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15da1fd1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e793f6258a2ee8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b37e75e781b5e400f65
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142c6769400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af5556400000

This is the same as "KASAN: stack-out-of-bounds Read in __aa_lookupn_ns":
https://syzkaller.appspot.com/bug?id=f0d603856d8b3cc9b8e09228f2f548c18ef907ac
right?

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9b37e75e781b5e400f65@syzkaller.appspotmail.com
>
> audit: type=1400 audit(1537815185.042:10): apparmor="DENIED"
> operation="stack_onexec" info="label not found" error=-2
> profile="unconfined" name="&&" pid=5560 comm="syz-executor398"
> audit: type=1400 audit(1537815185.072:11): apparmor="DENIED"
> operation="stack_onexec" info="label not found" error=-2
> profile="unconfined" name="&&" pid=5561 comm="syz-executor398"
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5565 Comm: syz-executor398 Not tainted 4.19.0-rc5-next-20180924+
> #78
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:memcmp+0x28/0x160 lib/string.c:856
> Code: 00 00 48 85 d2 0f 84 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 55 48
> 89 f9 48 89 e5 48 c1 e9 03 41 54 53 48 89 fb 48 83 ec 18 <0f> b6 04 01 48 89
> f9 83 e1 07 38 c8 7f 08 84 c0 0f 85 98 00 00 00
> RSP: 0018:ffff8801bbf0ef98 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: 000000000836b156
> RDX: 0000000000000002 RSI: ffffffff885fb8e0 RDI: 0000000041b58ab3
> RBP: ffff8801bbf0efc0 R08: ffff8801d8628280 R09: ffffed003b585b57
> R10: ffffed003b585b57 R11: ffff8801dac2dabb R12: 0000000000000002
> R13: ffffffff885fb8e0 R14: ffff8801fda67e03 R15: dffffc0000000000
> FS:  0000000000bf8880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cb090 CR3: 00000001d884a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  strnstr+0x4b/0x70 lib/string.c:934
>  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
>  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
>  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
>  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
>  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
>  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
>  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
>  apparmor_setprocattr+0xab7/0x1180 security/apparmor/lsm.c:759
>  security_setprocattr+0x66/0xc0 security/security.c:1336
>  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
>  __vfs_write+0x119/0x9f0 fs/read_write.c:485
>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>  ksys_write+0x101/0x260 fs/read_write.c:598
>  __do_sys_write fs/read_write.c:610 [inline]
>  __se_sys_write fs/read_write.c:607 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440d49
> Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcbaaf0448 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440d49
> RDX: 0000000000000009 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000000bf8880 R11: 0000000000000213 R12: 0000000000008f07
> R13: 0000000000401d20 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 848eed09df759209 ]---
> RIP: 0010:memcmp+0x28/0x160 lib/string.c:856
> Code: 00 00 48 85 d2 0f 84 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 55 48
> 89 f9 48 89 e5 48 c1 e9 03 41 54 53 48 89 fb 48 83 ec 18 <0f> b6 04 01 48 89
> f9 83 e1 07 38 c8 7f 08 84 c0 0f 85 98 00 00 00
> RSP: 0018:ffff8801bbf0ef98 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: 000000000836b156
> RDX: 0000000000000002 RSI: ffffffff885fb8e0 RDI: 0000000041b58ab3
> RBP: ffff8801bbf0efc0 R08: ffff8801d8628280 R09: ffffed003b585b57
> R10: ffffed003b585b57 R11: ffff8801dac2dabb R12: 0000000000000002
> R13: ffffffff885fb8e0 R14: ffff8801fda67e03 R15: dffffc0000000000
> FS:  0000000000bf8880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cb090 CR3: 00000001d884a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
