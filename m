Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA7C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884FA2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTti4wn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884FA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeKOJZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:25:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34129 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeKOJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:25:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so15663574ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isuOJddTU+/EUoXIvjRigMvt+8ae+uIRq8fzkQnez88=;
        b=pTti4wn3S9xD3u/+eGTjizU/rB/YJQFrGqIdtDjl65+ZVRsPpysWMB5mh+Wp7xTWOZ
         iXwJecq626WNM36H0lyzW7joCwu3Xy2wIH/I70bhO/kuuaUXuSbci6H0MvbRglFBd12Y
         rAY1nL8kd87Z+GNuhWjU2CGAb1kI0j6rEdqWdiYl+3FhK6lFCF1Okn/Vr/Co+DNxKx9q
         Cm43Maak7QRxc3+glA884cyQFHPMR9jhIA5e6Xwbivq8FEM1MTGmb+cekGrgo4az6ZQ/
         40DTkE9wjC+Su9N0dOTYLiHV+Kw32dCImeNrUQpX+pvKGA9Qm2qOJM8chI2xOYKsVk38
         12mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isuOJddTU+/EUoXIvjRigMvt+8ae+uIRq8fzkQnez88=;
        b=hWbD7KGtL52ICe6eoNyccqgAz6ka7VfGgNlZmoHgs6jMv+xksUy9ikqAiKzCs+TxAK
         2iHE8LVnB09HKZsYR95pTRDKyad2CFFAp1eQwmRBQ5nIIAWI53p/r1EGPlY9+Kg+w/RI
         MN5cFIZ+2ngPSnYG5qLwLkSbJ/p0/LVE3GEGVXZz06fTf5lBLVYSwKWI76F9dPiWQefH
         iMVri6cwRGfp3P4YBv0IBUuRZE7RZ1AHRlTt65y09tXjV9qXb+A4m9IKoPoulmw4BIvX
         /tzwHXIcAklUKyBAqIWtAj5+JetXsyouXEfo5qY+zGTI2TPOZQkVdg/mxr5ZmweJmxXy
         aMNQ==
X-Gm-Message-State: AGRZ1gKOF+nl/ogVWpMpcjt7kpQyvvfnhRYb6xSOWsF2g8icftZui0i2
        o66I4dB7qtJMtchg3N8tfGKgfMn1nEYxbgosiaayKA==
X-Google-Smtp-Source: AJdET5fREzOuwH2HYCYBE89sOBBKcuDT4DsnqPKsIIR3pWlR5ZVOJJuGzF8tqiLJTl15kAzvn3a4MzKjWpAvey1dLsM=
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr2464720lji.133.1542237622416;
 Wed, 14 Nov 2018 15:20:22 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <20181114230046.GC87768@gmail.com>
In-Reply-To: <20181114230046.GC87768@gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 14 Nov 2018 15:20:11 -0800
Message-ID: <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     ebiggers@kernel.org
Cc:     jannh@google.com, dh.herrmann@googlemail.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 3:00 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Dmitry,
>
> On Wed, Nov 14, 2018 at 02:28:56PM -0800, 'Dmitry Torokhov' via syzkaller-bugs wrote:
> > On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > When a UHID_CREATE command is written to the uhid char device, a
> > > > copy_from_user() is done from a user pointer embedded in the command.
> > > > When the address limit is KERNEL_DS, e.g. as is the case during
> > > > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > > > information can be leaked from a setuid binary that is tricked to write
> > > > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> > > >
> > > > No other commands in uhid_char_write() are affected by this bug and
> > > > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > > > UHID_CREATE only rather than to uhid_char_write() entirely.
> > > >
> > > > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > > > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > > > helpers fault on kernel addresses"), allowing this bug to be found.
> > > >
> > > > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > > > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > > > Cc: <stable@vger.kernel.org> # v3.6+
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > >
> > > Reviewed-by: Jann Horn <jannh@google.com>
> > >
> > > > ---
> > > >  drivers/hid/uhid.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > > index 3c55073136064..051639c09f728 100644
> > > > --- a/drivers/hid/uhid.c
> > > > +++ b/drivers/hid/uhid.c
> > > > @@ -12,6 +12,7 @@
> > > >
> > > >  #include <linux/atomic.h>
> > > >  #include <linux/compat.h>
> > > > +#include <linux/cred.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/fs.h>
> > > >  #include <linux/hid.h>
> > > > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> > > >
> > > >         switch (uhid->input_buf.type) {
> > > >         case UHID_CREATE:
> > > > +               /*
> > > > +                * 'struct uhid_create_req' contains a __user pointer which is
> > > > +                * copied from, so it's unsafe to allow this with elevated
> > > > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > > > +                */
> >
> > uhid is a privileged interface so we would go from root to less
> > privileged (if at all). If non-privileged process can open uhid it can
> > construct virtual keyboard and inject whatever keystrokes it wants.
> >
> > Also, instead of disallowing access, can we ensure that we switch back
> > to USER_DS before trying to load data from the user pointer?
> >
>
> Actually uhid doesn't have any capability checks, so it's up to userspace to
> assign permissions to the device node.

Yes. There are quite a few such instances where kernel does not bother
implementing superfluous checks and instead relies on userspace to
provide sane environment. IIRC nobody in the kernel enforces root
filesystem not be accessible to ordinary users, it is done with
generic permission checks.

> I think it's best not to make
> assumptions about how the interface will be used and to be consistent with how
> other ->write() methods in the kernel handle the misfeature where a __user
> pointer in the write() or read() payload is dereferenced.

I can see that you might want to check credentials, etc, if interface
can be accessed by unprivileged process, however is it a big no no for
uhid/userio/uinput devices.

> Temporarily switching
> to USER_DS would only avoid one of the two problems.

So because of the above there is only one problem. If your system
opened access to uhid to random processes you have much bigger
problems than exposing some data from a suid binary. You can spam "rm
-rf .; rm -rf /" though uhid if there is interactive session
somewhere.

>
> Do you think the proposed restrictions would actually break anything?

It would break if someone uses UHID_CREATE with sendpage. I do not
know if anyone does. If we were certain there are no users we'd simply
removed UHID_CREATE altogether.

>
> - Eric
>
> > > > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > > > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > > > +                                   task_tgid_vnr(current), current->comm);
> > > > +                       ret = -EACCES;
> > > > +                       goto unlock;
> > > > +               }
> > > >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> > > >                 break;
> > > >         case UHID_CREATE2:
> > > > --

Thanks.

-- 
Dmitry
