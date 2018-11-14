Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5435CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A68C223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsSnEbK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A68C223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbeKOInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:43:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41531 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbeKOInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:43:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id g188-v6so15094158oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oKCzlwybmcq+EoB5uAa4f5qcwFA4cXC6SLPhjLEtzc=;
        b=RsSnEbK20fmaGxMPNFsYuFlWKBa3cvMHJ/g1P3u/j2DShfVQdJH/NCM+TMEOUYhy5K
         Yj4Id8WL5yKFokHu9TiVxB1i0i7hz+dIxqkNeRkx2mmxsIdq0wT+54hMmZe8GaQ9pAw5
         bAeON3bFaLkBzhiWfy7+uML0VVfWooSsNYDNaP0SkaNZs7hnmp1qViEtgKC6vytN8Ri9
         T14rADhHsayY1RIPODdrbYp38LTx7WKYennVPzznjl6Bn17UBy5WsUDelpIBRhiKf8VR
         huorSfAZjDFj80Ixrb0grpUXJ45rxcWAG2a+I0tE9Vr3EqjZNXX8CDtHdLHw4p57BsxI
         JKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oKCzlwybmcq+EoB5uAa4f5qcwFA4cXC6SLPhjLEtzc=;
        b=lEkp42fLxBBM1a3mtJLSisrrQ9LM16Nk/hRgK//fApJ7k5FMhs+JaSObdfdx37Rzb3
         Z5brweMgogOzxK2dX7Slx6VQ1o89gV+dgjJC8IncfaGVS74Zl0g2cXl/sQO0xiFJDdqC
         B4WDsXHip6P3tAVpT+G+gwuVKxOTaX6s4tWTllvlD26fUVYN7TjFSIN6QRTOrdvA07iB
         fUaPjzedi3vuQiSFlh1Y+lPRhlexqce7kK7npjXF8M+KDTSO2pWal9vGjIW5Zbl9hhIb
         VqA04spNlgDhu0iqO38GIhMtm8p+FOYsy+qobrgriB4BBCPoULFpdlGWqrW2fe/XuGYr
         pUdw==
X-Gm-Message-State: AGRZ1gKOVZmnd9SbgNhDbB4jG2lwDaSEc2i6cSXuwlnE5YHrEYEVkPHc
        IGg5KlS3PgHhNouqgkAV2UiVsfBi2EI0owqhNoK4LQ==
X-Google-Smtp-Source: AJdET5csTsvIq8wanKg45MdVsvh9IT5zxTrVcRnl1mxqytdSHq13vdQx7vpT3tbOLD3tivhcXa8lrUHIJua+ciu0oGM=
X-Received: by 2002:aca:c413:: with SMTP id u19mr1933244oif.209.1542235093809;
 Wed, 14 Nov 2018 14:38:13 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
In-Reply-To: <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Nov 2018 23:37:47 +0100
Message-ID: <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     dtor@google.com
Cc:     ebiggers@kernel.org, dh.herrmann@googlemail.com,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:29 PM Dmitry Torokhov <dtor@google.com> wrote:
> On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > When a UHID_CREATE command is written to the uhid char device, a
> > > copy_from_user() is done from a user pointer embedded in the command.
> > > When the address limit is KERNEL_DS, e.g. as is the case during
> > > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > > information can be leaked from a setuid binary that is tricked to write
> > > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> > >
> > > No other commands in uhid_char_write() are affected by this bug and
> > > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > > UHID_CREATE only rather than to uhid_char_write() entirely.
[...]
> > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
[...]
> > > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> > >
> > >         switch (uhid->input_buf.type) {
> > >         case UHID_CREATE:
> > > +               /*
> > > +                * 'struct uhid_create_req' contains a __user pointer which is
> > > +                * copied from, so it's unsafe to allow this with elevated
> > > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > > +                */
>
> uhid is a privileged interface so we would go from root to less
> privileged (if at all). If non-privileged process can open uhid it can
> construct virtual keyboard and inject whatever keystrokes it wants.
>
> Also, instead of disallowing access, can we ensure that we switch back
> to USER_DS before trying to load data from the user pointer?

Does that even make sense? You are using some deprecated legacy
interface; you interact with it by splicing a request from something
like a file or a pipe into the uhid device; but the request you're
splicing through contains a pointer into userspace memory? Do you know
of anyone who is actually doing that? If not, anyone who does want to
do this for some reason in the future can just go use UHID_CREATE2
instead.

> > > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > > +                                   task_tgid_vnr(current), current->comm);
> > > +                       ret = -EACCES;
> > > +                       goto unlock;
> > > +               }
> > >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> > >                 break;
> > >         case UHID_CREATE2:
