Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E10C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87FD208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcLVpPki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87FD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbeFOVGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:06:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35221 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeFOVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:06:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id l10-v6so11156242wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FY/2ncmIuV0ZXHdCh9a5YqTC1n9nJU9/ZSC4PSQpWUw=;
        b=VcLVpPki9HHazOPGJxsO4cVSg2XErkgM9WMt32ONJjpzM6HX6qB/+HQVSzSoBJDTK0
         jEZoAM9V/VL+E00MPtzE5pWWsZp17/2HWOWN46V4wkbNsAM94HamimNM7dRTY89BxUtg
         jlMZqagD4HOLlJCR8PmqanKhbg1ePo5k6JMmviUrcTpjL+uhMyNjsPE4vPlpmn5Z9K5O
         OeEH3oTxHPqOc0XlUq4ofym8ZCIvm9abFzH/CzvJNV6E1DNHzB3v+lYL2hetc4NlP9W9
         iGKHTN6wwhftBbMo0zGcNUMjg0ADBruEYVbukPXkekZ98rQGAsSrR1bDOvylz8RI6dk0
         I60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FY/2ncmIuV0ZXHdCh9a5YqTC1n9nJU9/ZSC4PSQpWUw=;
        b=YBuszXpd2QvwooCj61+eiNlv38dMwvTrXEuuwOkcbhUE6b3YCnjNnImDwGdcot3tRo
         ffAnvD3oAqjVtCiAQgFLLxegrsE3eHp6411kmWpYRs69yMamyiLade2/CJ/iJHxNhdDR
         +5gtzVXKPmB8lW9OT5TtU5t0In1UV3bYaHhME905WXZkrYJolEBaLn9BajOxljt+4kqB
         6aQhZP1d15zPzGHVrpJO6xKDdGvV96CxmNZdEid+s+cLRzC7hngjpEPBtEpBdAXkwmx7
         sy2Bi3YOAZTZNmB9kgaGn8NctKMMarwNgR8cGFKcWSxEui1zoBo/h04Lq/6asDcdon+R
         hvCg==
X-Gm-Message-State: APt69E0msJ/GokA6vM+0AV8aNQvvygFEcIbs5q91b+OqW51adnREcqEB
        Pd3vGc1pPFNScKjURffSFbvmPFmJ0fNM1mXooRE=
X-Google-Smtp-Source: ADUXVKKEUxKIp+hJxUBN95MUiLk8e2P8dN9WoiA6b3+kJ47Qil1dSzqi39BQHfvDf++i4ZgJtTmGo4sbnfDTlj2hvIU=
X-Received: by 2002:a5d:4906:: with SMTP id x6-v6mr2926821wrq.66.1529096781180;
 Fri, 15 Jun 2018 14:06:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d801:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 14:06:20
 -0700 (PDT)
In-Reply-To: <aeffa531-d8f9-c57a-1a66-9b5727aa6899@gmail.com>
References: <12d73ae1-9912-49c5-989a-fabfc54447d2@googlegroups.com> <aeffa531-d8f9-c57a-1a66-9b5727aa6899@gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Fri, 15 Jun 2018 22:06:20 +0100
Message-ID: <CAK+_RLmumEQBCEEoVaXdV3i4jW+a1mPBsihdCJcVK=anpXWgyw@mail.gmail.com>
Subject: Re: [PATCH] KASAN: slab-out-of-bounds Read in find_first_zero_bit
To:     tomas <tomasbortoli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000796c85056eb4969d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000796c85056eb4969d
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Here is the detailed information about the bug which Tomas fixed. As
for the word-wrapping --- I enabled "plain text mode" in Gmail.
However, just in case, I am sending the combined patch as a text file
attachment. Is this ok?

Kind regards,
Tigran

On 15 June 2018 at 19:33, tomas <tomasbortoli@gmail.com> wrote:
>
> FYI,
>
> Syzkaller bug: https://groups.google.com/forum/#!msg/syzkaller-bugs/GvNFae8m4fw/hTkBY4r1AwAJ
>
>
>
> -------- Forwarded Message --------
> Subject: Re: KASAN: slab-out-of-bounds Read in find_first_zero_bit
> Date: Thu, 14 Jun 2018 11:04:37 -0700 (PDT)
> From: tomasbortoli@gmail.com
> To: syzkaller-bugs <syzkaller-bugs@googlegroups.com>
>
>
> Hi,
>
> I've looked into this and I made a patch.
>
> The info->si_imap pointer gets allocated by the number of necessary bytes, based on a bit count (though its type is unsigned int).
> Later, the same info->si_imap pointer is used for a read operation by calling find_first_zero_bit here:
>
> https://github.com/torvalds/linux/blob/master/fs/bfs/dir.c#L91
>
> However find_first_zero_bit expects the input to be read in blocks of "unsigned int", therefore there is a misalignment between allocation and usage, so the oob read.
> Fix by allocating the space in blocks of "unsigned int", with a padding.
>
>
> diff -up a/fs/bfs/inode.c b/fs/bfs/inode.c
> --- a/fs/bfs/inode.c 2018-06-14 07:52:32.231412396 +0200
> +++ b/fs/bfs/inode.c 2018-06-14 07:51:51.298428916 +0200
> @@ -358,7 +358,7 @@ static int bfs_fill_super(struct super_b
> info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE) /
> sizeof(struct bfs_inode)
> + BFS_ROOT_INO - 1;
> - imap_len = (info->si_lasti / 8) + 1;
> + imap_len = round_up((info->si_lasti) / 8, sizeof(unsigned long)) + sizeof(unsigned long);
> info->si_imap = kzalloc(imap_len, GFP_KERNEL);
> if (!info->si_imap)
> goto out1;
> I've tested it and it works on 4.17.
> Tomas
>
> Il giorno sabato 31 marzo 2018 22:47:07 UTC+2, syzbot ha scritto:
>>
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> b5dbc28762fd3fd40ba76303be0c7f707826f982 (Sat Mar 31 04:53:57 2018 +0000)
>> Merge tag 'kbuild-fixes-v4.16-3' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=a88c8270030dc5d71e4f
>>
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6431707947335680
>> syzkaller reproducer:
>> https://syzkaller.appspot.com/x/repro.syz?id=6420485734662144
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=6746019962290176
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
>> compiler: gcc (GCC) 7.1.1 20170620
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+a88c82...@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in find_first_zero_bit+0xc5/0xe0
>> lib/find_bit.c:125
>> Read of size 8 at addr ffff8801d7480a00 by task syzkaller291450/4476
>>
>> CPU: 1 PID: 4476 Comm: syzkaller291450 Not tainted 4.16.0-rc7+ #8
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x194/0x24d lib/dump_stack.c:53
>>   print_address_description+0x73/0x250 mm/kasan/report.c:256
>>   kasan_report_error mm/kasan/report.c:354 [inline]
>>   kasan_report+0x23c/0x360 mm/kasan/report.c:412
>>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>   find_first_zero_bit+0xc5/0xe0 lib/find_bit.c:125
>>   bfs_create+0xf7/0x610 fs/bfs/dir.c:92
>>   lookup_open+0x1217/0x1970 fs/namei.c:3200
>>   do_last fs/namei.c:3291 [inline]
>>   path_openat+0xd76/0x3530 fs/namei.c:3519
>>   do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>>   do_sys_open+0x502/0x6d0 fs/open.c:1059
>>   SYSC_open fs/open.c:1077 [inline]
>>   SyS_open+0x2d/0x40 fs/open.c:1072
>>   do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> RIP: 0033:0x4404f9
>> RSP: 002b:00007ffd2305ebd8 EFLAGS: 00000207 ORIG_RAX: 0000000000000002
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004404f9
>> RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000020000340
>> RBP: 0000000000000003 R08: 000000000000000a R09: 6f6f6c2f7665642f
>> R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000000004
>> R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000
>>
>> Allocated by task 4476:
>>   save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>   set_track mm/kasan/kasan.c:459 [inline]
>>   kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>>   __do_kmalloc mm/slab.c:3706 [inline]
>>   __kmalloc+0x162/0x760 mm/slab.c:3715
>>   kmalloc include/linux/slab.h:517 [inline]
>>   kzalloc include/linux/slab.h:701 [inline]
>>   bfs_fill_super+0x3d3/0xea0 fs/bfs/inode.c:362
>>   mount_bdev+0x2b7/0x370 fs/super.c:1119
>>   bfs_mount+0x34/0x40 fs/bfs/inode.c:465
>>   mount_fs+0x66/0x2d0 fs/super.c:1222
>>   vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>>   vfs_kern_mount fs/namespace.c:2509 [inline]
>>   do_new_mount fs/namespace.c:2512 [inline]
>>   do_mount+0xea4/0x2bb0 fs/namespace.c:2842
>>   SYSC_mount fs/namespace.c:3058 [inline]
>>   SyS_mount+0xab/0x120 fs/namespace.c:3035
>>   do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> Freed by task 2830:
>>   save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>   set_track mm/kasan/kasan.c:459 [inline]
>>   __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>>   __cache_free mm/slab.c:3486 [inline]
>>   kfree+0xd9/0x260 mm/slab.c:3801
>>   single_release+0x88/0xb0 fs/seq_file.c:606
>>   __fput+0x327/0x7e0 fs/file_table.c:209
>>   ____fput+0x15/0x20 fs/file_table.c:243
>>   task_work_run+0x199/0x270 kernel/task_work.c:113
>>   tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>>   exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
>>   prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>>   syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>>   do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
>>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> The buggy address belongs to the object at ffff8801d7480a00
>>   which belongs to the cache kmalloc-32 of size 32
>> The buggy address is located 0 bytes inside of
>>   32-byte region [ffff8801d7480a00, ffff8801d7480a20)
>> The buggy address belongs to the page:
>> page:ffffea00075d2000 count:1 mapcount:0 mapping:ffff8801d7480000
>> index:0xffff8801d7480fc1
>> flags: 0x2fffc0000000100(slab)
>> raw: 02fffc0000000100 ffff8801d7480000 ffff8801d7480fc1 000000010000003f
>> raw: ffffea00075d1ea0 ffffea00075d32a0 ffff8801dac001c0 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff8801d7480900: 00 02 fc fc fc fc fc fc 00 02 fc fc fc fc fc fc
>>   ffff8801d7480980: 00 02 fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
>> > ffff8801d7480a00: 07 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
>>                     ^
>>   ffff8801d7480a80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>>   ffff8801d7480b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a dumb bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for details.
>> Direct all questions to syzk...@googlegroups.com.
>>
>> syzbot will keep track of this bug report.
>> If you forgot to add the Reported-by tag, once the fix for this bug is
>> merged
>> into any tree, please reply to this email with:
>> #syz fix: exact-commit-title
>> If you want to test a patch for this bug, please reply with:
>> #syz test: git://repo/address.git branch
>> and provide the patch inline or as an attachment.
>> To mark this as a duplicate of another syzbot report, please reply with:
>> #syz dup: exact-subject-of-another-report
>> If it's a one-off invalid bug report, please reply with:
>> #syz invalid
>> Note: if the crash happens again, it will cause creation of a new bug
>> report.
>> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to a topic in the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this topic, visit https://groups.google.com/d/topic/syzkaller-bugs/GvNFae8m4fw/unsubscribe.
> To unsubscribe from this group and all its topics, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/12d73ae1-9912-49c5-989a-fabfc54447d2%40googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

--000000000000796c85056eb4969d
Content-Type: text/x-patch; charset="US-ASCII"; name="bfs-4.17.1-ver2.patch"
Content-Disposition: attachment; filename="bfs-4.17.1-ver2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jiggp8yy0

LS0tIGZzL2Jmcy9pbm9kZS5jLjAJMjAxOC0wNi0xNSAxMTo0MTo1OC4wOTYxOTY1MDQgKzAxMDAK
KysrIGZzL2Jmcy9pbm9kZS5jCTIwMTgtMDYtMTUgMjE6NDM6MzIuNDQ2MzM2NjU3ICswMTAwCkBA
IC0xLDcgKzEsNyBAQAogLyoKICAqCWZzL2Jmcy9pbm9kZS5jCiAgKglCRlMgc3VwZXJibG9jayBh
bmQgaW5vZGUgb3BlcmF0aW9ucy4KLSAqCUNvcHlyaWdodCAoQykgMTk5OS0yMDA2IFRpZ3JhbiBB
aXZhemlhbiA8YWl2YXppYW4udGlncmFuQGdtYWlsLmNvbT4KKyAqCUNvcHlyaWdodCAoQykgMTk5
OS0yMDE4IFRpZ3JhbiBBaXZhemlhbiA8YWl2YXppYW4udGlncmFuQGdtYWlsLmNvbT4KICAqCUZy
b20gZnMvbWluaXgsIENvcHlyaWdodCAoQykgMTk5MSwgMTk5MiBMaW51cyBUb3J2YWxkcy4KICAq
CiAgKiAgICAgIE1hZGUgZW5kaWFubmVzcy1jbGVhbiBieSBBbmRyZXcgU3RyaWJibGVoaWxsIDxh
ZHNAd29tcG9tLm9yZz4sIDIwMDUuCkBAIC0zNTAsMTUgKzM1MCwyMCBAQAogCiAJcy0+c19tYWdp
YyA9IEJGU19NQUdJQzsKIAotCWlmIChsZTMyX3RvX2NwdShiZnNfc2ItPnNfc3RhcnQpID4gbGUz
Ml90b19jcHUoYmZzX3NiLT5zX2VuZCkpIHsKKwlpZiAobGUzMl90b19jcHUoYmZzX3NiLT5zX3N0
YXJ0KSA+IGxlMzJfdG9fY3B1KGJmc19zYi0+c19lbmQpIHx8CisJICAgIGxlMzJfdG9fY3B1KGJm
c19zYi0+c19zdGFydCkgPCBzaXplb2Yoc3RydWN0IGJmc19zdXBlcl9ibG9jaykgCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArIHNpemVvZihzdHJ1Y3QgYmZzX2RpcmVu
dCkpIHsKIAkJcHJpbnRmKCJTdXBlcmJsb2NrIGlzIGNvcnJ1cHRlZFxuIik7CiAJCWdvdG8gb3V0
MTsKIAl9CiAKLQlpbmZvLT5zaV9sYXN0aSA9IChsZTMyX3RvX2NwdShiZnNfc2ItPnNfc3RhcnQp
IC0gQkZTX0JTSVpFKSAvCi0JCQkJCXNpemVvZihzdHJ1Y3QgYmZzX2lub2RlKQorCWluZm8tPnNp
X2xhc3RpID0gKGxlMzJfdG9fY3B1KGJmc19zYi0+c19zdGFydCkgLSBCRlNfQlNJWkUpIC8gc2l6
ZW9mKHN0cnVjdCBiZnNfaW5vZGUpCiAJCQkJCSsgQkZTX1JPT1RfSU5PIC0gMTsKLQlpbWFwX2xl
biA9IChpbmZvLT5zaV9sYXN0aSAvIDgpICsgMTsKKyAgICBpZiAoaW5mby0+c2lfbGFzdGkgPiA1
MTMpIHsgLyogSGFyZGNvZGVkOiBCRlMgY2FuIGhhdmUgdXAgdG8gNTEyIG1heGltdW0gbnVtYmVy
IG9mIGlub2RlcyAqLworCQlwcmludGYoIkltcG9zc2libGUgbnVtYmVyIG9mIGlub2RlcyAlbHVc
biIsIGluZm8tPnNpX2xhc3RpKTsKKwkJZ290byBvdXQxOworCX0KKwlpbWFwX2xlbiA9IHJvdW5k
X3VwKChpbmZvLT5zaV9sYXN0aSkgLyA4LCBzaXplb2YodW5zaWduZWQgbG9uZykpICsgc2l6ZW9m
KHVuc2lnbmVkIGxvbmcpOwogCWluZm8tPnNpX2ltYXAgPSBremFsbG9jKGltYXBfbGVuLCBHRlBf
S0VSTkVMKTsKIAlpZiAoIWluZm8tPnNpX2ltYXApCiAJCWdvdG8gb3V0MTsK
--000000000000796c85056eb4969d--
