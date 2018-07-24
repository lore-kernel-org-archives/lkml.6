Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D7E20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ozhEMe7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxY6uAN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D7E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbeGXBls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:41:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47147 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388181AbeGXBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:41:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BCFA121873;
        Mon, 23 Jul 2018 20:38:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 23 Jul 2018 20:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2dpi+KojVJf+KwA0oDQkZ+G8nKv5m
        9SzE2FYcdiEtWw=; b=ozhEMe7/JYQBWq56SWCN7drJVe8liz10/PYa7pfTOi6To
        /JZT/losUWnl13S7OKZS+8C5eLsh+0glPETh4fQ5mswgUd9f4rIMCdf9ORxJfNIJ
        S5BAiAbOytllBTYAT8dyhng6B/Vpiz0rSWdGzxMv6AlE2LrnLdQNOx0gZmSCfLow
        qt+3+HsrNQqUzsWhQ/VmGtPksZ7kZ2ki8h1HNh5Q1sO7QelZTk2ZKdGNPUe1cPH1
        tH1OxoSYNVFAm1IcnmtzJSzooYwHKxMXRVAPp8cKEnGkX57CAlL1KWR2XU7r1dpH
        fSjBrfAPtThttdj2Se65dCKdEEZ3h6dnExZXPhNaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2dpi+K
        ojVJf+KwA0oDQkZ+G8nKv5m9SzE2FYcdiEtWw=; b=OxY6uAN0gj7ukftMSYV0PJ
        cBQPJ27K3m9yqgl74pbQZUVSHP0nDBlM5A3yBTwBWuiRl8tU5aKejTPB5SsJoxOT
        hmS/tW9DoMrTEx+ejPf9IfdZ10k85GNcoAO/mp0rXmNsn+cYj3SRjGKYZDGd5aM5
        BOFryWdtwXX6sWPF2S7Oy+/ZMUfU7WltcMekVTAbqXywL1COn/40YHJRu67AxDpd
        WGogu2n8DsCMrOUfr4iecaHrXOZSO/t1H1E/Dh+vfLD28t3R0vwJD3wEBQ3HYh1W
        CxAMDGfXrV6CH7Ck23wP1Xe61P69QW4BorCfjrwi0LyTVZy7i23eC40PHhf06hSA
        ==
X-ME-Proxy: <xmx:6HRWWzDV463-YPb1nLB5BFbd4qbY0tlNTwaSwJN0AXV2l9ps1rmbZA>
    <xmx:6HRWWzJz9AfBe5knCfy4pedRhGAiUBREgBRrIfeDMNej60jPl0XyLA>
    <xmx:6HRWWy8Qygg9qaQvIa3anb0C9BDGeeQXIVEysXB0phGCWmJbOUF39w>
    <xmx:6HRWW0IkbfHMBPjk3N6ihkC3Ya4DA3JiOKmzMQE1Ur9645MUqLF5Qw>
    <xmx:6HRWW8pf-AoGRN-wwqkpKbws6Dvqw3tOtkCpXHCYV9Wph1BW5IrOVA>
    <xmx:6HRWW3LqEbyzoZBbd27U-0HafNyOkutPBhsImo9wPLxDcWo6VMtiLw>
X-ME-Sender: <xms:6HRWWzvyjF0KcJa7TOFrrTrhBSeD_v2cJxZxXC2fvd7xXbZKCceQ7Q>
Received: from localhost (unknown [118.209.42.46])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E5181026A;
        Mon, 23 Jul 2018 20:37:57 -0400 (EDT)
Message-ID: <1532392674.3546.17.camel@themaw.net>
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
From:   Ian Kent <raven@themaw.net>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Tue, 24 Jul 2018 08:37:54 +0800
In-Reply-To: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
         <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 09:31 -0700, Casey Schaufler wrote:
> On 7/23/2018 8:25 AM, David Howells wrote:
> > Hi Al,
> > 
> > Here's a set of patches to add a general variable-length notification queue
> > concept and to add sources of events for:
> 
> Overall I approve. The interface is a bit clunky. Some concerns below.
> 
> > 
> >  (1) Mount topology and reconfiguration change events.
> 
> With the possibility of unprivileged mounting you're
> going to have to address access control on events.
> If root in a user namespace mounts a filesystem you
> may have a case where the "real" user wouldn't want the
> listener to receive a notification.
> 
> >  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
> 
> Here, too. If SELinux (for example) policy says you can't see
> anything on a filesystem you shouldn't get notifications about
> things that happen to that filesystem.
> 
> >  (3) Key/keyring changes events
> 
> And again, I should only get notifications about keys and
> keyrings I have access to.
> 
> I expect that you intentionally left off
> 
>    (4) User injected events
> 
> at this point, but it's an obvious extension. That is going
> to require access controls (remember kdbus) so I think you'd
> do well to design them in now rather than have some security
> module hack like me come along later and "fix" it. 

I thought mount name space should be considered too even
though I wasn't considering the cloning of file handles
into a user mount name space.

But can this happen in other ways besides user mount name
space creation (I'm fishing here)?

And nsenter(1) doesn't require an exec for anything other
than a pid name space change so a forced close on exec
wouldn't be enough. Or am I mistaken in that nsenter(1)
actually requires running a program (even though the man
page implies it's optional) ...

Are there other consideration my limited understanding is
missing?

> 
> > One of the reasons for this is so that we can remove the issue of processes
> > having to repeatedly and regularly scan /proc/mounts, which has proven to be
> > a
> > system performance problem.
> > 
> > 
> > Design decisions:
> > 
> >  (1) A misc chardev is used to create and open a ring buffer:
> > 
> > 	fd = open("/dev/watch_queue", O_RDWR);
> > 
> >      which is then configured and mmap'd into userspace:
> > 
> > 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> > 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> > 	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
> > 		   MAP_SHARED, fd, 0);
> > 
> >      The fd cannot be read or written (though there is a facility to use
> > write
> >      to inject records for debugging) and userspace just pulls data directly
> >      out of the buffer.
> > 
> >  (2) The ring index pointers are stored inside the ring and are thus
> >      accessible to userspace.  Userspace should only update the tail pointer
> >      and never the head pointer or risk breaking the buffer.  The kernel
> >      checks that the pointers appear valid before trying to use them.  A
> >      'skip' record is maintained around the pointers.
> > 
> >  (3) poll() can be used to wait for data to appear in the buffer.
> > 
> >  (4) Records in the buffer are binary, typed and have a length so that they
> >      can be of varying size.
> > 
> >      This means that multiple heterogeneous sources can share a common
> >      buffer.  Tags may be specified when a watchpoint is created to help
> >      distinguish the sources.
> > 
> >  (5) The queue is reusable as there are 16 million types available, of which
> >      I've used 4, so there is scope for others to be used.
> > 
> >  (6) Records are filterable as types have up to 256 subtypes that can be
> >      individually filtered.  Other filtration is also available.
> > 
> >  (7) Each time the buffer is opened, a new buffer is created - this means
> > that
> >      there's no interference between watchers.
> > 
> >  (8) When recording a notification, the kernel will not sleep, but will
> > rather
> >      mark a queue as overrun if there's insufficient space, thereby avoiding
> >      userspace causing the kernel to hang.
> > 
> >  (9) The 'watchpoint' should be specific where possible, meaning that you
> >      specify the object that you want to watch.
> > 
> > (10) The buffer is created and then watchpoints are attached to it, using
> > one
> >      of:
> > 
> > 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> > 	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
> > 	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);
> > 
> >      where in all three cases, fd indicates the queue and the number after
> > is
> >      a tag between 0 and 255.
> > 
> > (11) The watch must be removed if either the watch buffer is destroyed or
> > the
> >      watched object is destroyed.
> > 
> > 
> > Things I want to avoid:
> > 
> >  (1) Introducing features that make the core VFS dependent on the network
> >      stack or networking namespaces (ie. usage of netlink).
> > 
> >  (2) Dumping all this stuff into dmesg and having a daemon that sits there
> >      parsing the output and distributing it as this then puts the
> >      responsibility for security into userspace and makes handling
> > namespaces
> >      tricky.  Further, dmesg might not exist or might be inaccessible inside
> > a
> >      container.
> > 
> >  (3) Letting users see events they shouldn't be able to see.
> > 
> > 
> > Further things that need to be done:
> > 
> >  (1) fsinfo() syscall needs to find superblocks by ID as well as by path so
> >      that it can query a superblock for information without the need to try
> >      and work out how to reach it - if the calling process even can.
> > 
> >  (2) A mount_info() syscall is needed that can enumerate all the children of
> > a
> >      mount.  This is necessary because mountpoints can hide each other by
> >      stacking, so paths are not unique keys.  This will require the ability
> > to
> >      look up a mount by ID.  This avoids the need to parse /proc/mounts.
> > 
> >  (3) A keyctl call is needed to allow a watch on a keyring to be extended to
> >      "children" of that keyring, such that the watch is removed from the
> > child
> >      if it is unlinked from the keyring.
> > 
> >  (4) A global superblock event queue maybe?
> > 
> >  (5) Propagating watches to child superblock over automounts?
> > 
> > 
> > The patches can be found here also:
> > 
> > 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h
> > =notifications
> > 
> > David
> > ---
> > David Howells (5):
> >       General notification queue with user mmap()'able ring buffer
> >       KEYS: Add a notification facility
> >       vfs: Add a mount-notification facility
> >       vfs: Add superblock notifications
> >       Add sample notification program
> > 
> > 
> >  Documentation/security/keys/core.rst   |   59 ++
> >  Documentation/watch_queue.rst          |  305 ++++++++++++
> >  arch/x86/entry/syscalls/syscall_32.tbl |    2 
> >  arch/x86/entry/syscalls/syscall_64.tbl |    2 
> >  drivers/misc/Kconfig                   |    9 
> >  drivers/misc/Makefile                  |    1 
> >  drivers/misc/watch_queue.c             |  835
> > ++++++++++++++++++++++++++++++++
> >  fs/Kconfig                             |   21 +
> >  fs/Makefile                            |    1 
> >  fs/fs_context.c                        |    1 
> >  fs/mount.h                             |   26 +
> >  fs/mount_notify.c                      |  178 +++++++
> >  fs/namespace.c                         |   18 +
> >  fs/super.c                             |  116 ++++
> >  include/linux/dcache.h                 |    1 
> >  include/linux/fs.h                     |   77 +++
> >  include/linux/key.h                    |    4 
> >  include/linux/syscalls.h               |    4 
> >  include/linux/watch_queue.h            |   87 +++
> >  include/uapi/linux/keyctl.h            |    1 
> >  include/uapi/linux/watch_queue.h       |  156 ++++++
> >  kernel/sys_ni.c                        |    6 
> >  mm/interval_tree.c                     |    2 
> >  mm/memory.c                            |    1 
> >  samples/Kconfig                        |    6 
> >  samples/Makefile                       |    2 
> >  samples/watch_queue/Makefile           |    9 
> >  samples/watch_queue/watch_test.c       |  232 +++++++++
> >  security/keys/Kconfig                  |   10 
> >  security/keys/compat.c                 |    3 
> >  security/keys/gc.c                     |    5 
> >  security/keys/internal.h               |   29 +
> >  security/keys/key.c                    |   37 +
> >  security/keys/keyctl.c                 |   90 +++
> >  security/keys/keyring.c                |   17 -
> >  security/keys/request_key.c            |    4 
> >  36 files changed, 2332 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/watch_queue.rst
> >  create mode 100644 drivers/misc/watch_queue.c
> >  create mode 100644 fs/mount_notify.c
> >  create mode 100644 include/linux/watch_queue.h
> >  create mode 100644 include/uapi/linux/watch_queue.h
> >  create mode 100644 samples/watch_queue/Makefile
> >  create mode 100644 samples/watch_queue/watch_test.c
> > 
> > 
> 
> 
