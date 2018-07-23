Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829DE20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K8vCjo1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829DE20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeGWRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:33:33 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:35849
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388236AbeGWRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1532363491; bh=zlMVOPm/LbjgDJ6+9iC6InkYSGFfnKsuGMC1z+//uxY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=K8vCjo1yY5nYKqRptG//slP6fS8/8VPb0XFezd+y60me8SpjXMFevW3fq76TL8sxDOHUhyBC8KFlTdHlwERvmaHhNmFXlNFK9M1RG2D6Z+t7ZZhj5/df+ZDTz397qa1WtIgLtiazffkmArHrnNhdsE7BXq6lyYCzWFmxdL+S1SpTYh+INZAZPNrhWY3Ledcy10moWpdbR/08QlWjveqW21K960dkkHDy0gvhXPFIowMeUfiTy1P1EmEbQ0DWxv0ZZrD0FcbTza4yIb/7CN2LgmAw7OpN5dRfZazaF7pYgx3Ca+kWkcdoc5bHroV1QQz4oNvG4mKmjCl/YIRAgQSf6Q==
X-YMail-OSG: LNFtaqsVM1nUyOSxlgCIV4__byhPmhWzmbX_qyqpKThek2SmUc_pj9Co3TLAh3Q
 UXMF6Hv58aJhaxVtu0wtHHZ0siTuK8gkYCJ0OGBIYMFXoAVEHx7GHpGu5S0377Z7faQ17PhL2.j5
 ir5b7NigqWOj8odORBxE7OU_4mdnoJxWDMQLqzCnwKFYm7jgupzQ7SmrxMj72Sm_na5dApSEhmDq
 PnfKt17954C8o4dYLKWyjnoPrjI_SPmSQ3JPor7qKSzaK4WG3KBPMXd8cOSfVwcjQw2XbKuiroUQ
 zvIFrFw1XhWf.JibcY2b53bF5g4S_9KRaIyffMXIQMUK54ygl.TCL57XioXN_XVCPG6Uq52h2blU
 5MLyt6utZ90K5636AEVadiZMsf9ticW9Re9XK4cHN5CnWUA_Twvb_45WKDXIj495O3eNotm1ekEI
 kXfaIAvVRz55pyfGj8VOSXUXh2CIAJP2eJqovO6RFGUTY99pYZKUNG2s0Rpw9P7M95T3pupr8WVL
 Z9wYeAvOkT_teFNo3ixaHU2FDq_QdS8V_M1mXz1TIwbKPSS13Yy9RoQKRwmQrq1f8gkenMHmfxdd
 wDrZh1F880MJseexRTPFNIAptsYSKW5lguIV0XxhaJ_y_rEbQKs.3NsJTnQNEdjOaKn2pr9OWl9P
 Y1Rhx6SRjm6mVrAe1Yr343oOvlddP30bkt9jWFj7kfP_5c9eG.Xyst9uAKAXrneCEE_CxEX4SLXz
 7_mSl0caRr.aNB5I0RB1gKBtdkUxUbNDmzZujOu5nDS4SmL1a1B7O13927ZfkfVDPk.VMiNUwHFR
 t0trp5wW6FVaHc3ThK6QxdndSFv1.29A2M89ChvaBJjOXCDfJOsnk6HL.PzTYKCpVpmIJPIOtlXN
 _esl2qCbHwou14F0uOK5DzxCRl.NvGUndG2OWTPHP6anaRmmmotnsi7z0iJeB6sQafeQZWvyv3Uc
 jGn.n.FhU4zxXlykB612ISzk3VbdaIPevjZijSFzaGoOa8pG981SJDtNtCTcFK2QszL8HkSM1Qwi
 lEdSVCOYOcmpFLTIrLgURi9bE0EPl_msL8tfKsUvT2fMWtfVoOprtVrX2Y2elg5i4bzphZEgSRds
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 23 Jul 2018 16:31:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8aee8643299d67b118d04f94bb367efc;
          Mon, 23 Jul 2018 16:31:30 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        raven@themaw.net, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
Date:   Mon, 23 Jul 2018 09:31:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 8:25 AM, David Howells wrote:
> Hi Al,
>
> Here's a set of patches to add a general variable-length notification queue
> concept and to add sources of events for:

Overall I approve. The interface is a bit clunky. Some concerns below.

>
>  (1) Mount topology and reconfiguration change events.

With the possibility of unprivileged mounting you're
going to have to address access control on events.
If root in a user namespace mounts a filesystem you
may have a case where the "real" user wouldn't want the
listener to receive a notification.

>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).

Here, too. If SELinux (for example) policy says you can't see
anything on a filesystem you shouldn't get notifications about
things that happen to that filesystem.

>  (3) Key/keyring changes events

And again, I should only get notifications about keys and
keyrings I have access to.

I expect that you intentionally left off

   (4) User injected events

at this point, but it's an obvious extension. That is going
to require access controls (remember kdbus) so I think you'd
do well to design them in now rather than have some security
module hack like me come along later and "fix" it. 

> One of the reasons for this is so that we can remove the issue of processes
> having to repeatedly and regularly scan /proc/mounts, which has proven to be a
> system performance problem.
>
>
> Design decisions:
>
>  (1) A misc chardev is used to create and open a ring buffer:
>
> 	fd = open("/dev/watch_queue", O_RDWR);
>
>      which is then configured and mmap'd into userspace:
>
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> 	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
> 		   MAP_SHARED, fd, 0);
>
>      The fd cannot be read or written (though there is a facility to use write
>      to inject records for debugging) and userspace just pulls data directly
>      out of the buffer.
>
>  (2) The ring index pointers are stored inside the ring and are thus
>      accessible to userspace.  Userspace should only update the tail pointer
>      and never the head pointer or risk breaking the buffer.  The kernel
>      checks that the pointers appear valid before trying to use them.  A
>      'skip' record is maintained around the pointers.
>
>  (3) poll() can be used to wait for data to appear in the buffer.
>
>  (4) Records in the buffer are binary, typed and have a length so that they
>      can be of varying size.
>
>      This means that multiple heterogeneous sources can share a common
>      buffer.  Tags may be specified when a watchpoint is created to help
>      distinguish the sources.
>
>  (5) The queue is reusable as there are 16 million types available, of which
>      I've used 4, so there is scope for others to be used.
>
>  (6) Records are filterable as types have up to 256 subtypes that can be
>      individually filtered.  Other filtration is also available.
>
>  (7) Each time the buffer is opened, a new buffer is created - this means that
>      there's no interference between watchers.
>
>  (8) When recording a notification, the kernel will not sleep, but will rather
>      mark a queue as overrun if there's insufficient space, thereby avoiding
>      userspace causing the kernel to hang.
>
>  (9) The 'watchpoint' should be specific where possible, meaning that you
>      specify the object that you want to watch.
>
> (10) The buffer is created and then watchpoints are attached to it, using one
>      of:
>
> 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> 	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
> 	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);
>
>      where in all three cases, fd indicates the queue and the number after is
>      a tag between 0 and 255.
>
> (11) The watch must be removed if either the watch buffer is destroyed or the
>      watched object is destroyed.
>
>
> Things I want to avoid:
>
>  (1) Introducing features that make the core VFS dependent on the network
>      stack or networking namespaces (ie. usage of netlink).
>
>  (2) Dumping all this stuff into dmesg and having a daemon that sits there
>      parsing the output and distributing it as this then puts the
>      responsibility for security into userspace and makes handling namespaces
>      tricky.  Further, dmesg might not exist or might be inaccessible inside a
>      container.
>
>  (3) Letting users see events they shouldn't be able to see.
>
>
> Further things that need to be done:
>
>  (1) fsinfo() syscall needs to find superblocks by ID as well as by path so
>      that it can query a superblock for information without the need to try
>      and work out how to reach it - if the calling process even can.
>
>  (2) A mount_info() syscall is needed that can enumerate all the children of a
>      mount.  This is necessary because mountpoints can hide each other by
>      stacking, so paths are not unique keys.  This will require the ability to
>      look up a mount by ID.  This avoids the need to parse /proc/mounts.
>
>  (3) A keyctl call is needed to allow a watch on a keyring to be extended to
>      "children" of that keyring, such that the watch is removed from the child
>      if it is unlinked from the keyring.
>
>  (4) A global superblock event queue maybe?
>
>  (5) Propagating watches to child superblock over automounts?
>
>
> The patches can be found here also:
>
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
>
> David
> ---
> David Howells (5):
>       General notification queue with user mmap()'able ring buffer
>       KEYS: Add a notification facility
>       vfs: Add a mount-notification facility
>       vfs: Add superblock notifications
>       Add sample notification program
>
>
>  Documentation/security/keys/core.rst   |   59 ++
>  Documentation/watch_queue.rst          |  305 ++++++++++++
>  arch/x86/entry/syscalls/syscall_32.tbl |    2 
>  arch/x86/entry/syscalls/syscall_64.tbl |    2 
>  drivers/misc/Kconfig                   |    9 
>  drivers/misc/Makefile                  |    1 
>  drivers/misc/watch_queue.c             |  835 ++++++++++++++++++++++++++++++++
>  fs/Kconfig                             |   21 +
>  fs/Makefile                            |    1 
>  fs/fs_context.c                        |    1 
>  fs/mount.h                             |   26 +
>  fs/mount_notify.c                      |  178 +++++++
>  fs/namespace.c                         |   18 +
>  fs/super.c                             |  116 ++++
>  include/linux/dcache.h                 |    1 
>  include/linux/fs.h                     |   77 +++
>  include/linux/key.h                    |    4 
>  include/linux/syscalls.h               |    4 
>  include/linux/watch_queue.h            |   87 +++
>  include/uapi/linux/keyctl.h            |    1 
>  include/uapi/linux/watch_queue.h       |  156 ++++++
>  kernel/sys_ni.c                        |    6 
>  mm/interval_tree.c                     |    2 
>  mm/memory.c                            |    1 
>  samples/Kconfig                        |    6 
>  samples/Makefile                       |    2 
>  samples/watch_queue/Makefile           |    9 
>  samples/watch_queue/watch_test.c       |  232 +++++++++
>  security/keys/Kconfig                  |   10 
>  security/keys/compat.c                 |    3 
>  security/keys/gc.c                     |    5 
>  security/keys/internal.h               |   29 +
>  security/keys/key.c                    |   37 +
>  security/keys/keyctl.c                 |   90 +++
>  security/keys/keyring.c                |   17 -
>  security/keys/request_key.c            |    4 
>  36 files changed, 2332 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/watch_queue.rst
>  create mode 100644 drivers/misc/watch_queue.c
>  create mode 100644 fs/mount_notify.c
>  create mode 100644 include/linux/watch_queue.h
>  create mode 100644 include/uapi/linux/watch_queue.h
>  create mode 100644 samples/watch_queue/Makefile
>  create mode 100644 samples/watch_queue/watch_test.c
>
>

