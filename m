Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E757F208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzHJzdor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E757F208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbeGJT5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:57:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43739 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbeGJT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:57:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so16792982pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3L3AeXDNrz8cXgrYVp69bwaC//rZ2c4TLmf7DVQWcc=;
        b=bzHJzdorySRkEan+1AtYpOu76LwupTlOiw4I4WIuHKAZxa5DC/v5IRjFTacmisCj2h
         Z6nKMfuL4u3LSgqfoJ2h3n8/0wiBqimz3IcCDbeH9qSuqfdqSeYAy7p8qGEPWFm+M/63
         Ft0PC2iR9xrWHpdUa/eBGn56qxnGxbkPOiY9x+Ip2rdYGSdBREardv88VEkKZCEYz275
         zfZQ0gFWGFlIJ62lsMOGoewwN6XNv5J0sehTdqk6l7p0nCHXGYGrWVovvZwq+f1oGNMC
         Tcd5tTUAui2tfRx8p22SfR+7BMhKG7ZXi56ZjhKZvnMdJG/SptXdtU3wle37/L5wpxLa
         y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3L3AeXDNrz8cXgrYVp69bwaC//rZ2c4TLmf7DVQWcc=;
        b=oRut8s6abAKs4CyziRsLmHrpLwlmEFGUjsRtXTAhw8/P0CqpJfKb69UVVIzI5/cCGS
         E+b0u/IhuFuES+fSVfsDRU5Fh2Rkw8NPOQdKxbtLnq8fWLvVWiYXmypsGGcZc7Y0kjNF
         P8EySbewrA//w2LMuQpMfVrL3LQMPs8NXXmlxGmGV9QjYJqDp2MY33LTURsJnQKRoEzV
         uQ6NThrAPtCeGkQw1bEPY6zDWiCqK9AX4pbEZQiE93vSt6TXByg6/EZ0CWPW+nehob6H
         VmoVkZoGVAGgtwzbRpBQThQfqhtgzZlzXBkcuJp5fx9eXWCRr/xNT51nldWAQChSEIxg
         jNSA==
X-Gm-Message-State: APt69E0cw6QrMZZDDs/vcDD60zI7kWIW/59QxLdEGFRUY4OVrkfQ0XeR
        zZtNBUA14ARaAOL0oUIOgtnsHP+NKGBhVbL94ce4lg==
X-Google-Smtp-Source: AAOMgpfHr+pu4MzTSNSYhlyrLGAqrmFRYpHi8l+ol6sJbZyjnTIbgfg87mZY/n6CUGvIHw00Y5ahF9j1EHEHkv1MEnM=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr23549757pgu.96.1531252637106;
 Tue, 10 Jul 2018 12:57:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Tue, 10 Jul 2018 12:56:56
 -0700 (PDT)
In-Reply-To: <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
References: <000000000000c242e90570aa0062@google.com> <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Jul 2018 21:56:56 +0200
Message-ID: <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 9:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 10, 2018 at 12:19 PM syzbot
> <syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com> wrote:
>> RIP: 0010:in_aton+0x3e/0x180 net/core/utils.c:63
>
> That's
>
>                 if (*str != '\0') {
>
> in in_aton().
>
> The code disassembles to
>
>         movzbl (%rax,%r15,1),%eax
>
> which is a bit odd, because
>
>> RAX: 0000000000000000
>
> Ok, NULL pointer, looks sane, but:
>
>> R15: dffffc0000000000
>
> Yeah, that's unusual. But I'm guessing it's some KASAN artifact. One
> of the big problemns with KASAN is that it makes the generated code
> completely illegible because 90% of the code is just KASAN overhead.


Yes, there is a problem with paging faults under KASAN.
For more complex bugs like use-after-frees and out-of-bounds there is
usually no need to look at disasm at all because KASAN provides all
relevant info in the report (actual access address, object start,
object size, where is was allocated/freed). But for paging faults
(notably NULL derefs), that's handled by the standard handler which
does not know about KASAN (except for printing "kasan: GPF could be
caused by NULL-ptr deref or user memory access"). Long time ago I
asked if it's possible to get the fault address in the handler, but I
got reply that it's close to impossible.

What KASAN does is reasonably simple: before each access to address
ADDR it inserts:

if (*(0xdffffc0000000000 + ADDR/8))
        report_error();
... *ADDR ... // original access

So if we would have the fault address, and we see that it's
[0xdffffc0000000000; 0xdffffc0000000000+PAGE_SIZE/8), then we could
simply say that it's NULL deref.

Is it really hard to get fault address? I know that userspace
generally receives fault address in siginfo.


>> Call Trace:
>>   rdma_create_trans+0xdbe/0x1ed0 net/9p/trans_rdma.c:678
>
> Well, rdma_create_trans() certainly doesn't verify 'addr' before using it.
>
>>   p9_client_create+0x915/0x16c9 net/9p/client.c:1062
>
> p9_client_create() just blindly passes on "dev_name"
>
>>   v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
>>   v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>
> .. as does v9fs_session_init() and v9fs_mount()
>
>>   mount_fs+0xae/0x328 fs/super.c:1277
>>   vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>>   vfs_kern_mount fs/namespace.c:1027 [inline]
>>   do_new_mount fs/namespace.c:2518 [inline]
>>   do_mount+0x581/0x30e0 fs/namespace.c:2848
>
> This is "name" in mount_fs(), vfs_kern_mount(), do_new_mount() and
> do_mount(), also just passed through.
>
>>   __do_compat_sys_mount fs/compat.c:125 [inline]
>>   __se_compat_sys_mount fs/compat.c:92 [inline]
>>   __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
>
> And here we have the source:
>
>         kernel_dev = copy_mount_string(dev_name);
>
> Note that copy_mount_string() just passes a NULL user space pointer
> through as a NULL kernel pointer (otherwise it does a
> "strndup_user()".
>
> And no, this is not a compat issue. The native mount does the same thing.
>
> So yes. The device name can trivially be NULL, and either rdma or the
> p9 code should check for NULL.
>
> Adding in the 9p people, because I think it's for them. Note the
> syzbot info below.
>
>                Linus
>
> --
>
> syzbot found the following crash on:
>
> HEAD commit:    092150a25cb7 Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1687b168400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a831e062bb4aebd8755
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=158cc2c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e7ef48400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CA%2B55aFyEZR%3Dv2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
