Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D02C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1909C20868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hwgupp3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1909C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeKOIeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:34:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39917 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388009AbeKOIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:34:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so15564974ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyH/bR8fsgxc0/jC8PAgJwtmJsdkPTfdEztcD6TvYEE=;
        b=Hwgupp3f3aVrs3Yasf+bIuHQpXlNl+aC24ZjO5MQFowCDbjPtEGqrBw84uQMpn88xt
         8FtjMSA3O24jrFJR10THqzLuMM45sbd17i7lyqpGHIzQyo39f10GqsdrBwdGzessOuQw
         L2xIOqxDvKFgpxZVMgZgVTHlKOPTDlgTbZW/Gx8MHKnqaPI9fmr7Y9UKb7N5Pc8gHIQ+
         +Ej+s8BLGRNA4f6pIiUs8QtEgL2vGsjibXTBTQSfEENh0LyGxB91+l6+CwrDn4u+VxHI
         kAmYbutQpGzjhEOmEUjjJN8E0TSzpqpaz2CIVKHtggq8IbfyG3r8Z23pjgfG9RxIEV7i
         Irsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyH/bR8fsgxc0/jC8PAgJwtmJsdkPTfdEztcD6TvYEE=;
        b=gm8oFfQRVegwqHs8d7NBGVT6EkdTjRbIwgUhKRWXcQQxZVAFK2XAXpLxyPS8PlB/K2
         WsQ36DsF8U9ZhoIHtanTvPU/eAEuZ+mRty0IewY9l//0O2N6ihXGV20RuTpob34HfRok
         aVJT+4d0k2m69YfWMjyw3JNTpzx4Oc0ckbtLjgG3e1cVL3SVLfurxnlCKhSI2p2LOYP0
         2VSXwi0QSyGHHq03f4akM5OtYZn77tv9kTW6hkG30o7QNmHjN1EYYoOAi/1orl7twk91
         WoTYAQWiYrViUWmn+0qgbqtxDf19CEog5JKniC4Xb5LYN69CVKh93KbXVL5lTMn++jZX
         Ucng==
X-Gm-Message-State: AGRZ1gKpU2wdcwgeNShN0ggIao61wV6EpwUSONIu+nJDqhwXsmmGCz4x
        F8ByLGOrCOd4PuZlfv4JupJFzUv8WB2nXzjqlpc9Hw==
X-Google-Smtp-Source: AJdET5e8Jz+SL88WsmLOgimZ6nmi012Mlp8fiNG81NvBJTeR7DHoP3kXoCJeTg8wWjXE3Tyv58wB7XZHbMiJK49qEgU=
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr2386024lji.133.1542234547723;
 Wed, 14 Nov 2018 14:29:07 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
In-Reply-To: <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 14 Nov 2018 14:28:56 -0800
Message-ID: <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     jannh@google.com
Cc:     ebiggers@kernel.org, dh.herrmann@googlemail.com,
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

On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > When a UHID_CREATE command is written to the uhid char device, a
> > copy_from_user() is done from a user pointer embedded in the command.
> > When the address limit is KERNEL_DS, e.g. as is the case during
> > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > information can be leaked from a setuid binary that is tricked to write
> > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> >
> > No other commands in uhid_char_write() are affected by this bug and
> > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > UHID_CREATE only rather than to uhid_char_write() entirely.
> >
> > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > helpers fault on kernel addresses"), allowing this bug to be found.
> >
> > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > Cc: <stable@vger.kernel.org> # v3.6+
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> > ---
> >  drivers/hid/uhid.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 3c55073136064..051639c09f728 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -12,6 +12,7 @@
> >
> >  #include <linux/atomic.h>
> >  #include <linux/compat.h>
> > +#include <linux/cred.h>
> >  #include <linux/device.h>
> >  #include <linux/fs.h>
> >  #include <linux/hid.h>
> > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> >
> >         switch (uhid->input_buf.type) {
> >         case UHID_CREATE:
> > +               /*
> > +                * 'struct uhid_create_req' contains a __user pointer which is
> > +                * copied from, so it's unsafe to allow this with elevated
> > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > +                */

uhid is a privileged interface so we would go from root to less
privileged (if at all). If non-privileged process can open uhid it can
construct virtual keyboard and inject whatever keystrokes it wants.

Also, instead of disallowing access, can we ensure that we switch back
to USER_DS before trying to load data from the user pointer?

> > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > +                                   task_tgid_vnr(current), current->comm);
> > +                       ret = -EACCES;
> > +                       goto unlock;
> > +               }
> >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> >                 break;
> >         case UHID_CREATE2:
> > --
> > 2.19.1.930.g4563a0d9d0-goog
> >

Thanks.

-- 
Dmitry
