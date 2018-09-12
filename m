Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E151C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D4D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D4D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeILTHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:07:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40178 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeILTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:07:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so1158404qkd.7;
        Wed, 12 Sep 2018 07:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lV/UqnuqRHDU0staNgFvRQDud1dwez67gcAXgd0IAE=;
        b=ii1qn/UlzkuQ8/E+WqWmKNMpppOjGIal53YE9+kpQe5Wz4kSK6j/4qKctJF1Azj2iQ
         7lb95+hu3UvTnUfjYwVeDYsHdkPA9snM0C3r1OnBivN7alDq2j6HeMCZDfOm4eiGHTBE
         6J8PvXHjwXqTt1W1eF4yxs4Gd3eLUgNG3ZVKkLBY4JqzEgmP3dMKupDoH98q2aiQ1Vd9
         m+H8aLb96XBqvzokq+fQE5IpWOCurKG4L/ei35J9+s5RgtZv1zrTkkX06wMBx7WVVxXK
         aZidhFdXmlZuXKck8znXEM4X0CuhFgzKqmw/7a1ttrmRnVAk5GBXhq3f5nPnNMoCW3V6
         rUfg==
X-Gm-Message-State: APzg51Ce5lAIfn6f6LKWcLS0TnvbtCc+eIctAtgmKiDqqmqo91GCMryV
        f84eCeZ41WU6qu6KhC/Vuwj7BT7zDmyXMXej+ho=
X-Google-Smtp-Source: ANB0VdbRAW2pAoU5z2J6P4WK5a97KwJs48hUO2DyYRKP7yGlDvGKWU2/BKfiWckyI49OWtHVHAUGLRRgfF5709oCCsk=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr1511338qkc.291.1536760976598;
 Wed, 12 Sep 2018 07:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-6-arnd@arndb.de>
 <20180909041114.GD19965@ZenIV.linux.org.uk> <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
 <20180912072854.13b4c3b8@mschwideX1>
In-Reply-To: <20180912072854.13b4c3b8@mschwideX1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Sep 2018 16:02:40 +0200
Message-ID: <CAK8P3a19rCHbtuV65A4rZbUkxHngep44dtitmEM3p99VdWcjdA@mail.gmail.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 7:29 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 11 Sep 2018 22:26:54 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Out of those, there are only a few that may get used on s390,
> > in particular at most infiniband/uverbs, nvme, nvdimm,
> > btrfs, ceph, fuse, fanotify and userfaultfd.
> > [Note: there are three s390 drivers in the list, which use
> > a different method: they check in_compat_syscall() from
> > a shared handler to decide whether to do compat_ptr().
>
> Using in_compat_syscall() seems to be a good solution, no?

It works fine for you, but wouldn't work on architecture-independent
code, since 32-bit architectures generally don't provide
a compat_ptr() implementation. This could of course
be changed easily, but after this change it, your drivers
work just as well with a couple few lines, and more consistent
with other drivers:

--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -93,12 +93,8 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 static long sclp_ctl_ioctl(struct file *filp, unsigned int cmd,
                           unsigned long arg)
 {
-       void __user *argp;
+       void __user *argp = (void __user *)arg;

-       if (is_compat_task())
-               argp = compat_ptr(arg);
-       else
-               argp = (void __user *) arg;
        switch (cmd) {
        case SCLP_CTL_SCCB:
                return sclp_ctl_ioctl_sccb(argp);
@@ -114,7 +110,7 @@ static const struct file_operations sclp_ctl_fops = {
        .owner = THIS_MODULE,
        .open = nonseekable_open,
        .unlocked_ioctl = sclp_ctl_ioctl,
-       .compat_ioctl = sclp_ctl_ioctl,
+       .compat_ioctl = generic_compat_ioctl_ptrarg,
        .llseek = no_llseek,
 };

This should probably be separate from the change to using compat_ptr()
in all other drivers, and I could easily drop this change if you prefer,
it is meant only as a cosmetic change.

> > According to my memory from when I last worked on this,
> > the compat_ptr() is mainly a safeguard for legacy binaries
> > that got created with ancient C compilers (or compilers for
> > something other than C)  and might leave the high bit set
> > in a pointer, but modern C compilers (gcc-3+) won't ever
> > do that.
>
> And compat_ptr clears the upper 32-bit of the register. If
> the register is loaded to e.g. "lr" or "l" there will be
> junk in the 4 upper bytes.

I don't think we hit that problem anywhere: in the ioctl
argument we pass an 'unsigned long' that has already
been zero-extended by the compat_sys_ioctl() wrapper,
while any other usage would get extended by the compiler
when casting from compat_uptr_t to a 64-bit type.
This would be different if you had a function call with the
wrong prototype, i.e. calling a function declared as taking
an compat_uptr_t, but defining it as taking a void __user*.
(I suppose that is undefined behavior).

Unless I'm missing something, compat_ptr() should
always just clear bit 31. What I'd like to confirm is whether
you have encountered any code that actually passes
a pointer with that bit set by a user application in the
past 15 years. As Al said, it's probably best to just always
apply the compat_ptr() conversion in each case that s390
needs it even for drivers that don't run on s390, but I'd also
like to understand how much it matters in practice.
(A separate question would be how long we expect to need
32 bit compat mode on arch/s390 at all, but for the moment
I assume this is not up for debate at all).

       Arnd
