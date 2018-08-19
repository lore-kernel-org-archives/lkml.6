Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D38C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D97208D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3YBEKz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D97208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHSO1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 10:27:52 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39757 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeHSO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 10:27:52 -0400
Received: by mail-yb0-f194.google.com with SMTP id c4-v6so3580526ybl.6;
        Sun, 19 Aug 2018 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Yed7q5xbiVlgZhNf+rfpiyfVraS1/7BMXeB7IOXba8=;
        b=p3YBEKz0lo1sA1uwApg/Zb8E7E7gtDEMJbZbKG76VBWHbfintMfk1+jhmr486ZVp/A
         g7BalGSOTkEeT3upTQnAQXy5ZRMYFPUn61z9GRFepuStz4dZnEpSddSGnr/YblKWwzAZ
         kT060i/01NA1uj/GWsMimj//GMfTtYIj1QSL3eC/sza+0oeA7KAqmL9+21jiu7IQCBrc
         K6IYOJP6dupj7Z1y8a9SP5KJCaYwih2RYjJXAOMFMlF6VTJNuJEHuH81r6Sh/utXXq4a
         VCrzkbhrAST7imISd85uTTgov9wrXfgox5EDtr3HJ8ne5Y6YLXFf2v6baddj5uiDU1lP
         XUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Yed7q5xbiVlgZhNf+rfpiyfVraS1/7BMXeB7IOXba8=;
        b=ljwdckI3rgfM2uUcIjmODW7djA8fB1gUWH6mdZhJ5HdM9Jf4Ozw+WqNVUvgTypYQzf
         1W8r+08oJ9AeycEHLThbeUnlPDOedxg+9JomUxKC7f+/E/Nc0mB/q3g/pehfTSViG6Mh
         j3iJWEouAnVhYGzzMEkYf/EqnbiM5kIFXC7zNHqN1L8/E0Gn+2rfJTlso2ffviZv2DBz
         2T7SSbKi6XlUM2lI2FyotGmvJNKaCNs+S3PKhy5KZe7IlNpm64B3LFSD1lseDDR99XwQ
         JPeD/lwWOi+2gUYdDGlQ8043e79m3P/Zroaz16q4uARdismz07K58uA9SkUj69SAa62m
         /EuA==
X-Gm-Message-State: AOUpUlF4IsMJofHoKMWpoqdrgKamfzwbEIPiYjRNEfEp94XQMPVx3RMv
        ZZVQ+RgFBXkd4nLQdUGa+tJKI9UXBwbGAt4ZxOm4lNln
X-Google-Smtp-Source: AA+uWPzX896F/4PF5OoObPFJSz/EG1pT/KAhE+6CVpNZu7TBUw5wvSgBRN2wGY+ao9cHnBXobwc/44pSjJSIR4Qy0Nk=
X-Received: by 2002:a25:ddc5:: with SMTP id u188-v6mr17548704ybg.32.1534677404821;
 Sun, 19 Aug 2018 04:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dd8b740573b821ec@google.com>
In-Reply-To: <000000000000dd8b740573b821ec@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 19 Aug 2018 14:18:31 +0300
Message-ID: <CAOQ4uxiA2ba2EuQkgttA7rRMYgGnEPZQX-f8g12M8gDTaeht7Q@mail.gmail.com>
Subject: Re: WARNING in __fsnotify_recalc_mask
To:     syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000008f4dab0573c7edcf"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008f4dab0573c7edcf
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 18, 2018 at 7:26 PM syzbot
<syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1f7a4c73a739 Merge tag '9p-for-4.19-2' of git://github.com..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10cccef2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68e80edb3c9718c5
> dashboard link: https://syzkaller.appspot.com/bug?extid=c34692a51b9a6ca93540
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11c12e86400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com
>

Hello syzbot,

Thanks for the report!
Please test:
#syz test: https://github.com/amir73il/linux.git fsnotify-fixes

FYI, I wasn't able to reproduce with repro, but didn't wait for more than 1
minute so maybe I was being impatient.

Jan,

Patch attached for reference.
If you don't like the empty else-if statement, you may
merge it with the else case.

Thanks,
Amir.

> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> WARNING: CPU: 1 PID: 12015 at fs/notify/mark.c:139
> __fsnotify_recalc_mask+0x2d7/0x350 fs/notify/mark.c:139
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 12015 Comm: syz-executor0 Not tainted 4.18.0+ #195
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   panic+0x238/0x4e7 kernel/panic.c:184
>   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>   report_bug+0x252/0x2d0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:__fsnotify_recalc_mask+0x2d7/0x350 fs/notify/mark.c:139
> Code: 90 00 00 00 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 eb 2d a2
> ff 49 83 ec 04 eb 82 e8 e0 2d a2 ff 0f 0b e8 d9 2d a2 ff <0f> 0b eb a5 e8
> 60 24 e1 ff e9 11 ff ff ff 48 89 df e8 f3 24 e1 ff
> RSP: 0018:ffff8801b509f5c8 EFLAGS: 00010293
> RAX: ffff8801b2c0a180 RBX: 0000000000000002 RCX: ffffffff81dabc96
> RDX: 0000000000000000 RSI: ffffffff81dabd67 RDI: 0000000000000005
> RBP: ffff8801b509f658 R08: ffff8801b2c0a180 R09: ffffed00398cb796
> R10: ffffed00398cb796 R11: ffff8801cc65bcb3 R12: dffffc0000000000
> R13: ffff8801cc65bcb0 R14: 0000000000000000 R15: 0000000000000000
>   fsnotify_put_mark+0x523/0xab0 fs/notify/mark.c:240
>   fsnotify_destroy_marks+0x2d1/0x5c0 fs/notify/mark.c:741
>   fsnotify_clear_marks_by_inode fs/notify/fsnotify.h:39 [inline]
>   __fsnotify_inode_delete+0x19/0x20 fs/notify/fsnotify.c:35
>   fsnotify_inoderemove include/linux/fsnotify.h:136 [inline]
>   dentry_unlink_inode+0x48b/0x5e0 fs/dcache.c:370
>   __dentry_kill+0x44c/0x7a0 fs/dcache.c:566
>   dentry_kill+0xc9/0x5a0 fs/dcache.c:685
>   dput.part.26+0x66b/0x7a0 fs/dcache.c:846
>   dput+0x15/0x20 fs/dcache.c:828
>   __fput+0x4c2/0x860 fs/file_table.c:264
>   ____fput+0x15/0x20 fs/file_table.c:282
>   task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>   exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457089
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fcfa3e50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
> RAX: 000000000000000a RBX: 00007fcfa3e516d4 RCX: 0000000000457089
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000008
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004cb6d0 R14: 00000000004c31f3 R15: 0000000000000000
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>

--0000000000008f4dab0573c7edcf
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-fix-false-positive-warning-on-inode-delete.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-fix-false-positive-warning-on-inode-delete.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jl0rbt9p0>
X-Attachment-Id: f_jl0rbt9p0

RnJvbSAyZGY3OWEwMTk3NzZkM2FjYTI0MzZjMmI1YmU2YjViNTU1ZTY0MWZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDE5IEF1ZyAyMDE4IDEzOjU3OjA3ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IGZpeCBmYWxzZSBwb3NpdGl2ZSB3YXJuaW5nIG9uIGlub2RlIGRlbGV0ZQoKUmVwb3J0
ZWQtYnk6IHN5emJvdCtjMzQ2OTJhNTFiOWE2Y2E5MzU0MEBzeXprYWxsZXIuYXBwc3BvdG1haWwu
Y29tCkZpeGVzOiAzYWM3MGJmY2RlODEgKCJmc25vdGlmeTogYWRkIGhlbHBlciB0byBnZXQgbWFz
ayBmcm9tIGNvbm5lY3RvciIpClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+Ci0tLQogZnMvbm90aWZ5L21hcmsuYyB8IDcgKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9tYXJrLmMgYi9m
cy9ub3RpZnkvbWFyay5jCmluZGV4IDA1NTA2ZDYwMTMxYy4uZDU1OWE4ZmZlN2VkIDEwMDY0NAot
LS0gYS9mcy9ub3RpZnkvbWFyay5jCisrKyBiL2ZzL25vdGlmeS9tYXJrLmMKQEAgLTIzNiw2ICsy
MzYsMTMgQEAgdm9pZCBmc25vdGlmeV9wdXRfbWFyayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFy
aykKIAlpZiAoaGxpc3RfZW1wdHkoJmNvbm4tPmxpc3QpKSB7CiAJCWlub2RlID0gZnNub3RpZnlf
ZGV0YWNoX2Nvbm5lY3Rvcl9mcm9tX29iamVjdChjb25uKTsKIAkJZnJlZV9jb25uID0gdHJ1ZTsK
Kwl9IGVsc2UgaWYgKGNvbm4tPnR5cGUgPT0gRlNOT1RJRllfT0JKX1RZUEVfREVUQUNIRUQpIHsK
KwkJLyoKKwkJICogZnNub3RpZnlfZGVzdHJveV9tYXJrcygpIGRldGFjaGVzIGNvbm4gZnJvbSBv
YmplY3QgYmVmb3JlCisJCSAqIHB1dCBvbiBsYXN0IG1hcmsgb2Ygb2JqZWN0IGxpc3QgYW5kIG90
aGVyIG1hcmtzIG9uIHRoZSBsaXN0CisJCSAqIG1heSBzdGlsbCBoYXZlIGVsZXZhdGVkIHJlZmNv
dW50cy4gV2UgZG9uJ3QgbmVlZCB0byByZWNhbGMKKwkJICogbWFzayBub3IgdG8gZnJlZV9jb25u
IGluIHRoYXQgY2FzZS4KKwkJICovCiAJfSBlbHNlIHsKIAkJX19mc25vdGlmeV9yZWNhbGNfbWFz
ayhjb25uKTsKIAl9Ci0tIAoyLjcuNAoK
--0000000000008f4dab0573c7edcf--
