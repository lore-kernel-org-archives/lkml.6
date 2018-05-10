Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525935571; cv=none;
        d=google.com; s=arc-20160816;
        b=ir5uIC645eNC3tInV991p1MFMU+0kubiVgYy/gD0boQY69YF/dRVRgAPBtFKH9lZLC
         Zbvk/bE5HvBIMuWQe/NnKgfQ2OJ/02luGs3oQ1cwt+rIpXqFEnhny5RX32/gcGud2/wf
         83p5J2ZbIGXmMYYoslDvoC58TdXsXMvamWZC8ibmZsVg+FBl8zsFS2qzqaKpiDgd81g7
         ziXZ8MS937qZkeOzoN/WXPkngn3k5sK8QZmbv9INpx/EFeyOVJFooZVdSssadumgVFrg
         9qpKW2cvfPYhUkydZy9V4H6Dp9e8h3MKyfXJWcd98UTUn/E/4txdHXJ0Qjcjhf5W4M06
         6Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dV7J7pPNy72lPEyyE9WMlvngXzqomhIB0806Eb1MwGM=;
        b=acTBmfNJCHmZSyxi+e9Zr18n1m9zrabwzy31piGJaf9qJ4MrcRVyjHRey9LsQwvfny
         dxX8xA3Chr0O24PntmZLUEtVcNgcEWJbuzlyKDCNrMA7YwHW32ildpeWQI+7d11y7r4H
         8M9Y5jHRPfKptRVWqdWYTkh1bNQVkgYogM7Ye+bZxxdvF4TFupcdZSZUZeLVG91Q0ygZ
         v923/oBbZ57wXzmwINVyqnw7hISXiDRgDHZ7UFKD7jfj+olZY4cxpjlvn/BpZVR2mjAN
         Vzu6ZHfQ+4Ur2LI8WgtEPtpEJNUWgI04ydVWOyAQAHkld0YkXghwJrpAtvCve8jfpDWo
         Jv0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eVkQtaS8;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eVkQtaS8;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZolBcjbz8dhgZ8YJCbQaALbsXgMkmnBuVFPJ6+PEy60HDHHaOEc0or0BqBVFc4zH2xqkomJyuIVzxBHkX6Kmzs=
MIME-Version: 1.0
In-Reply-To: <ee1d01fc-a6a4-9480-9755-b6f25304d08b@redhat.com>
References: <001a1144928eca24f605625fd8f9@google.com> <ee1d01fc-a6a4-9480-9755-b6f25304d08b@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 May 2018 08:59:09 +0200
Message-ID: <CACT4Y+b2Q86dQxsd9_9casAsE9jE8ef87E9WEdKFCYxLkT0Z8A@mail.gmail.com>
Subject: Re: WARNING in ion_buffer_destroy
To: Laura Abbott <labbott@redhat.com>
Cc: syzbot <syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589157489839025899?=
X-GMAIL-MSGID: =?utf-8?q?1600059417603695271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 10, 2018 at 7:14 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 01/09/2018 02:58 PM, syzbot wrote:
>>
>> Hello,
>>
>> syzkaller hit the following crash on
>> 06d41862286aa7bc634a1dd9e6e7e96f925ef30a
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> C reproducer is attached
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>>
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> audit: type=1400 audit(1515538424.230:7): avc:  denied  { map } for
>> pid=3499 comm="syzkaller239906" path="/root/syzkaller239906633" dev="sda1"
>> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>> WARNING: CPU: 0 PID: 1467 at drivers/staging/android/ion/ion.c:122
>> ion_buffer_destroy+0xd4/0x190 drivers/staging/android/ion/ion.c:122
>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> CPU: 0 PID: 1467 Comm: ion_system_heap Not tainted
>> 4.15.0-rc7-next-20180109+ #92
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x194/0x257 lib/dump_stack.c:53
>>   panic+0x1e4/0x41c kernel/panic.c:183
>>   __warn+0x1dc/0x200 kernel/panic.c:547
>>   report_bug+0x211/0x2d0 lib/bug.c:184
>>   fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>>   fixup_bug arch/x86/kernel/traps.c:247 [inline]
>>   do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>>   invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
>> RIP: 0010:ion_buffer_destroy+0xd4/0x190
>> drivers/staging/android/ion/ion.c:122
>> RSP: 0018:ffff8801d3a9fd28 EFLAGS: 00010293
>> RAX: ffff8801d39ee700 RBX: ffff8801c00e57c0 RCX: ffffffff8415d2a4
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801d5ada5b8
>> RBP: ffff8801d3a9fd50 R08: 0000000000000000 R09: 1ffff1003a753f8a
>> R10: ffff8801d3a9fc18 R11: 0000000000000000 R12: ffffffff86e4c980
>> R13: ffff8801d5ada580 R14: ffff8801c00e57e0 R15: 0000000000000001
>>   ion_heap_deferred_free+0x290/0x650
>> drivers/staging/android/ion/ion_heap.c:236
>>   kthread+0x33c/0x400 kernel/kthread.c:238
>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>
>
> This is catching that a buffer was freed with an existing kernel
> map still present. The problem is this can easily be triggered from
> userspace by calling DMA_BUF_SYNC_START without calling
> DMA_BUF_SYNC_END. It's clearly not appropriate for userspace to
> be able to trigger a warning so I'll see about switching this to
> a pr_warn_once.

Hi Laura,

Any updates on this?
