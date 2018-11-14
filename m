Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1550FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F3A2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PucQOP9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F3A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbeKOIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:51:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43740 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeKOIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:51:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so12743091lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zp48KnARUujJPgt98cu1edg5zA2vF5X1wfL/aDUBBfM=;
        b=PucQOP9SfVPzJkK5UPVVenlN3yfrY1yyxc0QQdMc21gRRg9QWHGfa+DcMlrqvQ61JE
         XJ4a88dVRGbrWUUGXiypJG4AIhiHKjpyO9mX+meEoqPO4T/3qxipoMh9vx8pYtFCisxz
         /kW8hA/XpX3G3TZjVj/C0592l0IIaLK5i3JlwJ8QUqM0fpBfCxhR2kpr/M/SezNmQ/Ps
         FQzAw5PjRNE+PxtbA3S3wNYXTUsMyBo2G/lUsdpQnbdHvyKDU5ex8W0gVQC/pWrVbXov
         fb905K+gcsXRuSLjfyHphbBxwCoT+H05jv95WVwnydxGI/YFrAwBob2+T7/+cKYj/fEY
         7twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zp48KnARUujJPgt98cu1edg5zA2vF5X1wfL/aDUBBfM=;
        b=coV8uzrDCzTHksx8YzHq1XUabalJcxo1+qJaERgoVLDf08fU2VHFefhbzo7u3dDYu+
         UL1s0GojKc2xlnDAOfDqQm/G8EAfUVLLfkLcHqB+QoYgLJuilf2X2IDUer6b63dmhs+g
         OSPrGHeMQ1Hm2CN23esGNP4cL+4KaG6fn5tfLSrM2tbEwejoBAADir5NQhj5M2prxxX/
         a6U0Ys6l8GQLm0gSPYmmTTeK1Tjk9+LkNL5bGinyT34fJ7LMrxQSEIfRxSp0tj0qrbBg
         6pcVb/f2HWsPXqH5dEjWuqpcAkypPsAQrOZZ2rbyp0l/yKctrBPd3bSo0rFOZ6JYTRyN
         7mQQ==
X-Gm-Message-State: AGRZ1gJROBhgCw+5iTDvOBKIEihWmMZBklJFSPivYJEDmXXLShuxnjhR
        W0iE+tkQX0/necRTQhDOuDbvxi5gLH9L4UwhiPZAkw==
X-Google-Smtp-Source: AJdET5cvnD0BdbNLtmDMuVKf+LV1+5FpQSpLxkWhlf5qfDOrMadgwydfFOWf2fxfHyD2s4sUQyNde39zj9hETiiNVr8=
X-Received: by 2002:a19:9904:: with SMTP id b4mr2000480lfe.95.1542235605801;
 Wed, 14 Nov 2018 14:46:45 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com>
In-Reply-To: <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 14 Nov 2018 14:46:34 -0800
Message-ID: <CAE_wzQ91=FQ1HYYvbOi5R5VSXjJibLwYWsAPFtvUemPa9+Turg@mail.gmail.com>
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

On Wed, Nov 14, 2018 at 2:38 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 14, 2018 at 11:29 PM Dmitry Torokhov <dtor@google.com> wrote:
> > On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> > > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
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
> [...]
> > > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> [...]
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
>
> Does that even make sense? You are using some deprecated legacy
> interface; you interact with it by splicing a request from something
> like a file or a pipe into the uhid device; but the request you're
> splicing through contains a pointer into userspace memory? Do you know
> of anyone who is actually doing that? If not, anyone who does want to
> do this for some reason in the future can just go use UHID_CREATE2
> instead.

I do not know if anyone is still using UHID_CREATE with sendpage and
neither do you really. It is all about not breaking userspace without
good reason and here ensuring that we switch to USER_DS and then back
to whatever it was does not seem too hard.

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
