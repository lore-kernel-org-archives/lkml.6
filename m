Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B512C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A6A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uu5l6zsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfAVN6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:58:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37380 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbfAVN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:58:52 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so20123265iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF4BC871O2Dk1wll+Ha0pIljRxxk2JF7IAPB89GFj9k=;
        b=Uu5l6zsBg+B6rdXx9lRuJTJ7xrReOyArTzCLLqFlrwt8FBGIdh2/kDV8PPBZ/UEu4y
         C3V4kT7b13x7ZFMSF4m508fFe3lku2dcKpmOtu6kZkYa90wfPzX3LTWBlczlXGcNntv7
         fI6XwpKNZHtbT/we2LltEQw6DHVZ2U0BtjRZVvVn95xbE5wWUVjUfeYPwJK684X338Ft
         auaXrzP8Q6XlxpuJV8LUjoZSq7qqVAN9LuRYTxiiMU+LceFRRTIpA96GbymvcNDjAa2O
         a/dpqoac0zQDjawQLIZqNHtix+0Z+krZZEf7bKxTivmybV6XGnARGCP8LC6UXbLQkWct
         HbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF4BC871O2Dk1wll+Ha0pIljRxxk2JF7IAPB89GFj9k=;
        b=Lzs8Y0fVq0ep4lcRiiSu5ltaHksNgcxJOfXkiwWcZW607mIZuTXAsfaoUCUslFE8R+
         i5EMTMmFfHjHwheB0fsg3Wj92AIE8N/A80zgbgRqPguIcp03J3HGfDRxU1e11NCFlncY
         ZnCVlWsAjsETAEpJtk4fS3DFXkiTR3CSCqjdtzjt/cn4Le+xLL/fg8xkYEFXgOHoEhr9
         OeZtjW4poC362qEdP9bP76xusiJPkIq8BBrTg/37RTfeqN7G/+n4DmzcJWgXW7qCShmE
         3wKbaOz1sqdsF/FvEY+oa7aBirhEkuX2QpGuHXXRl02AbXYSLGCpxmNeM715+5JgtUsV
         c4DQ==
X-Gm-Message-State: AJcUukdJ0jV+0Btg7nAuXSLi3pDUOTuuKftSiRZKLl2iIJukkeaFsCdL
        5JrnUGVN7QFwuYObFpCxZNgaWGBQr/6RJcW/K6Zq+w==
X-Google-Smtp-Source: ALg8bN6k5iCbTwO0QIojfb+xHKIkvKS4NZNA/FEIN4XyTFF8t8g/A5ZHGbRE3ZCWKy+DyuA35yTHyVj4BNYWv271p7M=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr1833184itl.144.1548165530258;
 Tue, 22 Jan 2019 05:58:50 -0800 (PST)
MIME-Version: 1.0
References: <000000000000194520056affab14@google.com> <20180509075715.GH711@sol.localdomain>
 <CAHRSSEwAjrxZLRa3tPhjvz2MFiqVbCysTTgp6oKc=3Pcr1b2JQ@mail.gmail.com>
In-Reply-To: <CAHRSSEwAjrxZLRa3tPhjvz2MFiqVbCysTTgp6oKc=3Pcr1b2JQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jan 2019 14:58:39 +0100
Message-ID: <CACT4Y+YNgYqynkhv7DMCCkO+xFebrpWfTXwdyeYsN=RkWmLiYw@mail.gmail.com>
Subject: Re: possible deadlock in vfs_fallocate
To:     Todd Kjos <tkjos@google.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: multipart/mixed; boundary="0000000000007cda1305800c609a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007cda1305800c609a
Content-Type: text/plain; charset="UTF-8"

On Wed, May 9, 2018 at 6:57 PM 'Todd Kjos' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> +Joel Fernandes
>
> On Wed, May 9, 2018 at 12:55 AM Eric Biggers <ebiggers3@gmail.com> wrote:
>>
>> [+ashmem maintainers]
>>
>> On Sun, Apr 29, 2018 at 10:00:03AM -0700, syzbot wrote:
>> > Hello,
>> >
>> > syzbot hit the following crash on upstream commit
>> > cdface5209349930ae1b51338763c8e029971b97 (Sun Apr 29 03:07:21 2018 +0000)
>> > Merge tag 'for_linus_stable' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>> > syzbot dashboard link:
>> > https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
>> >
>> > C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5054004375584768
>> > syzkaller reproducer:
>> > https://syzkaller.appspot.com/x/repro.syz?id=6438048191479808
>> > Raw console output:
>> > https://syzkaller.appspot.com/x/log.txt?id=5404215203594240
>> > Kernel config:
>> > https://syzkaller.appspot.com/x/.config?id=7043958930931867332
>> > compiler: gcc (GCC) 8.0.1 20180413 (experimental)

Let's test Tetsuo's patch

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master



>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>> >
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> >
>> > ======================================================
>> > WARNING: possible circular locking dependency detected
>> > 4.17.0-rc2+ #23 Not tainted
>> > ------------------------------------------------------
>> > syz-executor715/4492 is trying to acquire lock:
>> >         (ptrval) (sb_writers#6){.+.+}, at: file_start_write
>> > include/linux/fs.h:2718 [inline]
>> >         (ptrval) (sb_writers#6){.+.+}, at: vfs_fallocate+0x5be/0x8d0
>> > fs/open.c:318
>> >
>> > but task is already holding lock:
>> >         (ptrval) (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xac/0x560
>> > drivers/staging/android/ashmem.c:440
>> >
>> > which lock already depends on the new lock.
>> >
>> >
>> > the existing dependency chain (in reverse order) is:
>> >
>> > -> #3 (ashmem_mutex){+.+.}:
>> >        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>> >        __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:893
>> >        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>> >        ashmem_mmap+0x53/0x460 drivers/staging/android/ashmem.c:361
>> >        call_mmap include/linux/fs.h:1789 [inline]
>> >        mmap_region+0xd13/0x1820 mm/mmap.c:1723
>> >        do_mmap+0xc79/0x11d0 mm/mmap.c:1494
>> >        do_mmap_pgoff include/linux/mm.h:2237 [inline]
>> >        vm_mmap_pgoff+0x1fb/0x2a0 mm/util.c:357
>> >        ksys_mmap_pgoff+0x4c9/0x640 mm/mmap.c:1544
>> >        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>> >        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
>> >        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
>> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> >
>> > -> #2 (&mm->mmap_sem){++++}:
>> >        __might_fault+0x155/0x1e0 mm/memory.c:4555
>> >        _copy_to_user+0x30/0x110 lib/usercopy.c:25
>> >        copy_to_user include/linux/uaccess.h:155 [inline]
>> >        filldir+0x1ea/0x3a0 fs/readdir.c:196
>> >        dir_emit_dot include/linux/fs.h:3378 [inline]
>> >        dir_emit_dots include/linux/fs.h:3389 [inline]
>> >        dcache_readdir+0x13a/0x620 fs/libfs.c:192
>> >        iterate_dir+0x4b0/0x5d0 fs/readdir.c:51
>> >        __do_sys_getdents fs/readdir.c:231 [inline]
>> >        __se_sys_getdents fs/readdir.c:212 [inline]
>> >        __x64_sys_getdents+0x293/0x4e0 fs/readdir.c:212
>> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> >
>> > -> #1 (&sb->s_type->i_mutex_key#11){++++}:
>> >        down_write+0x87/0x120 kernel/locking/rwsem.c:70
>> >        inode_lock include/linux/fs.h:713 [inline]
>> >        do_last fs/namei.c:3274 [inline]
>> >        path_openat+0x123b/0x4e20 fs/namei.c:3501
>> >        do_filp_open+0x249/0x350 fs/namei.c:3535
>> >        do_sys_open+0x56f/0x740 fs/open.c:1093
>> >        __do_sys_open fs/open.c:1111 [inline]
>> >        __se_sys_open fs/open.c:1106 [inline]
>> >        __x64_sys_open+0x7e/0xc0 fs/open.c:1106
>> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> >
>> > -> #0 (sb_writers#6){.+.+}:
>> >        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>> >        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
>> > [inline]
>> >        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>> >        __sb_start_write+0x1e9/0x300 fs/super.c:1385
>> >        file_start_write include/linux/fs.h:2718 [inline]
>> >        vfs_fallocate+0x5be/0x8d0 fs/open.c:318
>> >        ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:447
>> >        ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
>> >        vfs_ioctl fs/ioctl.c:46 [inline]
>> >        file_ioctl fs/ioctl.c:500 [inline]
>> >        do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>> >        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>> >        __do_sys_ioctl fs/ioctl.c:708 [inline]
>> >        __se_sys_ioctl fs/ioctl.c:706 [inline]
>> >        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> >
>> > other info that might help us debug this:
>> >
>> > Chain exists of:
>> >   sb_writers#6 --> &mm->mmap_sem --> ashmem_mutex
>> >
>> >  Possible unsafe locking scenario:
>> >
>> >        CPU0                    CPU1
>> >        ----                    ----
>> >   lock(ashmem_mutex);
>> >                                lock(&mm->mmap_sem);
>> >                                lock(ashmem_mutex);
>> >   lock(sb_writers#6);
>> >
>> >  *** DEADLOCK ***
>> >
>> > 1 lock held by syz-executor715/4492:
>> >  #0:         (ptrval) (ashmem_mutex){+.+.}, at:
>> > ashmem_shrink_scan+0xac/0x560 drivers/staging/android/ashmem.c:440
>> >
>> > stack backtrace:
>> > CPU: 1 PID: 4492 Comm: syz-executor715 Not tainted 4.17.0-rc2+ #23
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:77 [inline]
>> >  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>> >  print_circular_bug.isra.36.cold.54+0x1bd/0x27d
>> > kernel/locking/lockdep.c:1223
>> >  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>> >  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>> >  validate_chain kernel/locking/lockdep.c:2417 [inline]
>> >  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
>> >  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>> >  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
>> >  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>> >  __sb_start_write+0x1e9/0x300 fs/super.c:1385
>> >  file_start_write include/linux/fs.h:2718 [inline]
>> >  vfs_fallocate+0x5be/0x8d0 fs/open.c:318
>> >  ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:447
>> >  ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
>> >  vfs_ioctl fs/ioctl.c:46 [inline]
>> >  file_ioctl fs/ioctl.c:500 [inline]
>> >  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>> >  __do_sys_ioctl fs/ioctl.c:708 [inline]
>> >  __se_sys_ioctl fs/ioctl.c:706 [inline]
>> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>> >  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > RIP: 0033:0x440179
>> > RSP: 002b:00007ffc165d4a28 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
>> > RAX: ffffffffffffffda RBX: 6873612f7665642f RCX: 0000000000440179
>> > RDX: 0000000000000000 RSI: 000000000000770a RDI: 0000000000000004
>> > RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000004 R11: 0000000000000217 R12: 00000000004016a0
>> > R13: 0000000000401730 R14: 0000000000000000 R15: 0000000000000000
>> > random: crng init done
>> >
>> >
>> > ---
>> > This bug is generated by a dumb bot. It may contain errors.
>> > See https://goo.gl/tpsmEJ for details.
>> > Direct all questions to syzkaller@googlegroups.com.
>> >
>> > syzbot will keep track of this bug report.
>> > If you forgot to add the Reported-by tag, once the fix for this bug is
>> > merged
>> > into any tree, please reply to this email with:
>> > #syz fix: exact-commit-title
>> > If you want to test a patch for this bug, please reply with:
>> > #syz test: git://repo/address.git branch
>> > and provide the patch inline or as an attachment.
>> > To mark this as a duplicate of another syzbot report, please reply with:
>> > #syz dup: exact-subject-of-another-report
>> > If it's a one-off invalid bug report, please reply with:
>> > #syz invalid
>> > Note: if the crash happens again, it will cause creation of a new bug
>> > report.
>> > Note: all commands must start from beginning of the line in the email body.
>>
>> Looks like yet another locking bug in ashmem.  ashmem_mutex normally ranks below
>> mmap_sem, but ashmem_shrink_scan() inverts that order, via the
>> file_start_write() in vfs_fallocate().
>>
>> - Eric

--0000000000007cda1305800c609a
Content-Type: text/x-patch; charset="US-ASCII"; name="ashmem.patch"
Content-Disposition: attachment; filename="ashmem.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jr7trhnd0>
X-Attachment-Id: f_jr7trhnd0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jIGIvZHJpdmVycy9z
dGFnaW5nL2FuZHJvaWQvYXNobWVtLmMKaW5kZXggOTBhOGE5ZjFhYzdkLi4xYTg5MGM0M2ExMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jCkBAIC03NSw2ICs3NSwxNyBAQCBzdHJ1Y3QgYXNo
bWVtX3JhbmdlIHsKIC8qIExSVSBsaXN0IG9mIHVucGlubmVkIHBhZ2VzLCBwcm90ZWN0ZWQgYnkg
YXNobWVtX211dGV4ICovCiBzdGF0aWMgTElTVF9IRUFEKGFzaG1lbV9scnVfbGlzdCk7CiAKK3N0
YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqYXNobWVtX3dxOworc3RhdGljIGF0b21pY190
IGFzaG1lbV9zaHJpbmtfaW5mbGlnaHQgPSBBVE9NSUNfSU5JVCgwKTsKK3N0YXRpYyBERUNMQVJF
X1dBSVRfUVVFVUVfSEVBRChhc2htZW1fc2hyaW5rX3dhaXQpOworCitzdHJ1Y3QgYXNobWVtX3No
cmlua193b3JrIHsKKwlzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsKKwlzdHJ1Y3QgZmlsZSAqZmls
ZTsKKwlsb2ZmX3Qgc3RhcnQ7CisJbG9mZl90IGVuZDsKK307CisKIC8qCiAgKiBsb25nIGxydV9j
b3VudCAtIFRoZSBjb3VudCBvZiBwYWdlcyBvbiBvdXIgTFJVIGxpc3QuCiAgKgpAQCAtMjkyLDYg
KzMwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IGFzaG1lbV9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICpp
b2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiAJaW50IHJldCA9IDA7CiAKIAltdXRleF9sb2Nr
KCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3Nocmlua193YWl0LCAhYXRvbWlj
X3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCS8qIElmIHNpemUgaXMgbm90IHNl
dCwgb3Igc2V0IHRvIDAsIGFsd2F5cyByZXR1cm4gRU9GLiAqLwogCWlmIChhc21hLT5zaXplID09
IDApCkBAIC0zNTksNiArMzcxLDcgQEAgc3RhdGljIGludCBhc2htZW1fbW1hcChzdHJ1Y3QgZmls
ZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiAJaW50IHJldCA9IDA7CiAKIAlt
dXRleF9sb2NrKCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3Nocmlua193YWl0
LCAhYXRvbWljX3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCS8qIHVzZXIgbmVl
ZHMgdG8gU0VUX1NJWkUgYmVmb3JlIG1hcHBpbmcgKi8KIAlpZiAoIWFzbWEtPnNpemUpIHsKQEAg
LTQyMSw2ICs0MzQsMTkgQEAgc3RhdGljIGludCBhc2htZW1fbW1hcChzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGlj
IHZvaWQgYXNobWVtX3Nocmlua193b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQorewor
CXN0cnVjdCBhc2htZW1fc2hyaW5rX3dvcmsgKncgPSBjb250YWluZXJfb2Yod29yaywgdHlwZW9m
KCp3KSwgd29yayk7CisKKwl3LT5maWxlLT5mX29wLT5mYWxsb2NhdGUody0+ZmlsZSwKKwkJCQkg
RkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxfS0VFUF9TSVpFLAorCQkJCSB3LT5zdGFy
dCwgdy0+ZW5kIC0gdy0+c3RhcnQpOworCWZwdXQody0+ZmlsZSk7CisJa2ZyZWUodyk7CisJaWYg
KGF0b21pY19kZWNfYW5kX3Rlc3QoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKQorCQl3YWtlX3Vw
X2FsbCgmYXNobWVtX3Nocmlua193YWl0KTsKK30KKwogLyoKICAqIGFzaG1lbV9zaHJpbmsgLSBv
dXIgY2FjaGUgc2hyaW5rZXIsIGNhbGxlZCBmcm9tIG1tL3Ztc2Nhbi5jCiAgKgpAQCAtNDQ5LDEy
ICs0NzUsMTggQEAgYXNobWVtX3Nocmlua19zY2FuKHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLCBz
dHJ1Y3Qgc2hyaW5rX2NvbnRyb2wgKnNjKQogCQlyZXR1cm4gLTE7CiAKIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUocmFuZ2UsIG5leHQsICZhc2htZW1fbHJ1X2xpc3QsIGxydSkgewotCQlsb2Zm
X3Qgc3RhcnQgPSByYW5nZS0+cGdzdGFydCAqIFBBR0VfU0laRTsKLQkJbG9mZl90IGVuZCA9IChy
YW5nZS0+cGdlbmQgKyAxKSAqIFBBR0VfU0laRTsKKwkJc3RydWN0IGFzaG1lbV9zaHJpbmtfd29y
ayAqdyA9IGt6YWxsb2Moc2l6ZW9mKCp3KSwgR0ZQX0FUT01JQyk7CisKKwkJaWYgKCF3KQorCQkJ
YnJlYWs7CisJCUlOSVRfV09SSygmdy0+d29yaywgYXNobWVtX3Nocmlua193b3JrZXIpOworCQl3
LT5maWxlID0gcmFuZ2UtPmFzbWEtPmZpbGU7CisJCWdldF9maWxlKHctPmZpbGUpOworCQl3LT5z
dGFydCA9IHJhbmdlLT5wZ3N0YXJ0ICogUEFHRV9TSVpFOworCQl3LT5lbmQgPSAocmFuZ2UtPnBn
ZW5kICsgMSkgKiBQQUdFX1NJWkU7CisJCWF0b21pY19pbmMoJmFzaG1lbV9zaHJpbmtfaW5mbGln
aHQpOworCQlxdWV1ZV93b3JrKGFzaG1lbV93cSwgJnctPndvcmspOwogCi0JCXJhbmdlLT5hc21h
LT5maWxlLT5mX29wLT5mYWxsb2NhdGUocmFuZ2UtPmFzbWEtPmZpbGUsCi0JCQkJRkFMTE9DX0ZM
X1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxfS0VFUF9TSVpFLAotCQkJCXN0YXJ0LCBlbmQgLSBzdGFy
dCk7CiAJCXJhbmdlLT5wdXJnZWQgPSBBU0hNRU1fV0FTX1BVUkdFRDsKIAkJbHJ1X2RlbChyYW5n
ZSk7CiAKQEAgLTcxMyw2ICs3NDUsNyBAQCBzdGF0aWMgaW50IGFzaG1lbV9waW5fdW5waW4oc3Ry
dWN0IGFzaG1lbV9hcmVhICphc21hLCB1bnNpZ25lZCBsb25nIGNtZCwKIAkJcmV0dXJuIC1FRkFV
TFQ7CiAKIAltdXRleF9sb2NrKCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3No
cmlua193YWl0LCAhYXRvbWljX3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCWlm
ICghYXNtYS0+ZmlsZSkKIAkJZ290byBvdXRfdW5sb2NrOwpAQCAtODgzLDggKzkxNiwxNSBAQCBz
dGF0aWMgaW50IF9faW5pdCBhc2htZW1faW5pdCh2b2lkKQogCQlnb3RvIG91dF9mcmVlMjsKIAl9
CiAKKwlhc2htZW1fd3EgPSBhbGxvY193b3JrcXVldWUoImFzaG1lbV93cSIsIFdRX01FTV9SRUNM
QUlNLCAwKTsKKwlpZiAoIWFzaG1lbV93cSkgeworCQlwcl9lcnIoImZhaWxlZCB0byBjcmVhdGUg
d29ya3F1ZXVlXG4iKTsKKwkJZ290byBvdXRfZGVtaXNjOworCX0KKwogCXJldCA9IHJlZ2lzdGVy
X3Nocmlua2VyKCZhc2htZW1fc2hyaW5rZXIpOwogCWlmIChyZXQpIHsKKwkJZGVzdHJveV93b3Jr
cXVldWUoYXNobWVtX3dxKTsKIAkJcHJfZXJyKCJmYWlsZWQgdG8gcmVnaXN0ZXIgc2hyaW5rZXIh
XG4iKTsKIAkJZ290byBvdXRfZGVtaXNjOwogCX0K
--0000000000007cda1305800c609a--
