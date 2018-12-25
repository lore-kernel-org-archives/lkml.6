Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350692173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD6Itty6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeLYFdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 00:33:05 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44986 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLYFdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 00:33:04 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so10156026iod.11;
        Mon, 24 Dec 2018 21:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+A74NzcsU5jVuDJexZfDXwDFdTQppxIwyEi8thauB1U=;
        b=LD6Itty65NVQOUp5+dFsoJDFfawIvngvgt+5luRb4ulzCCaVXWiPqHigY15fSLSp9a
         L2NK+JFcdgPLhLEJMoVpMO/+PhMwMA0mQ2oa9UdsBFxmQnl5bBn+F4zs1Go0kjBQGLxp
         2zPzuFgQje4HS64tiWW9NOL1ZNlvvPeeiQgxmJuRunzJbMZTU8gAhwJFFDcy72YyKGiX
         gwtnqkEy8v0rnCaqZ5IjKmNL/MbGh91devGii1SGMgkZh0isP7cdheaMGZ8Pm+As3Elh
         uHTYdWuMAHy6h+F3PYHIHBvOXEeijwQRz2OGJfR7Z5XfLniCPBtmEXLC08G3hMjaycId
         +14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+A74NzcsU5jVuDJexZfDXwDFdTQppxIwyEi8thauB1U=;
        b=lTRpZHl2N7ztk2iZEyq81tZbGDArWzglvk7LDnich1wpecanFGDQeskV09yPuzb7l7
         ho/ND8eL4/N+HJNBJ1NOtm3xd/9ZgBHFlOm2sOtrAoIQR1ZAR4LDEhrg9z/k+7XNu2Nd
         oBLLdD+4mfqdLiJviImhSIz88xkR4KgjV9GEmljCTJrrBDzlhWJwlx76pal8+0vc7ntA
         tr39CTwLq2ChINSaDwio+LbHNSh69wx+XoHcfkv4JbUGEGtz4plaIQu2XP3g7DCoULJK
         10Fv5b4KsP8OR7y52o2DlVWFTLE89GFh6WaFnUTUeiBcAMYBDpTB19F4cSInklVIrC86
         elKQ==
X-Gm-Message-State: AJcUukePPdYFqxzG0kZjCIA4UqurEpbdZmGYThsPk53L2ytkmhNHGc8V
        7QOh0hd+WKlzcqPBhXrnHfGWVy/Wx75YAg92cfM=
X-Google-Smtp-Source: ALg8bN5nNYUU6yCI9Hk6/V529D2OTffFHX/ZStk3Dro4WYhwVvP/DO/uvIp2KdSPR3vnxUxxFGrpSUc59m1bTAE86yI=
X-Received: by 2002:a6b:600b:: with SMTP id r11mr11206750iog.259.1545715983251;
 Mon, 24 Dec 2018 21:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io> <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com> <20181203180224.fkvw4kajtbvru2ku@brauner.io>
 <874lbtjvtd.fsf@oldenburg2.str.redhat.com> <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
 <87y392h4b7.fsf@oldenburg2.str.redhat.com> <C5E71146-DE79-4145-B54B-E161E7372D95@brauner.io>
In-Reply-To: <C5E71146-DE79-4145-B54B-E161E7372D95@brauner.io>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 25 Dec 2018 13:32:51 +0800
Message-ID: <CAJhGHyC=Zc=iG+iL+Ny8GsMd-5xypxdk4Et_1ZViMao5aXreCw@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to avoid adding any syscall?

Since holding /proc/pid/reg_file can also hold the pid.
With this guarantee, /proc/pid/uuid (universally unique identifier ) can be
introduced to identify tasks, the kernel generates
a uuid for every task when created.

save_pid_uuid_pair_for_later_kill(int pid) {
  /* save via /proc/$pid/uuid */
  /* don't need to keep any fd after save */
}

safe_kill(pid, uuid, sig) {
    fd =3D open(/proc/$pid/uuid); /* also hold the pid until close() if
open() successes */
    if (open successes and read uuid from fd and if it equals to uuid)
        kill(pid, sig)
    close(fd)
}

All things needed to be done is to implement /proc/pid/uuid. And if pid can=
't
be recycled within 1 ticket, or the user can ensure it. The user can use
starttime(in /proc/pid/stat) instead.

save_pid_starttime_pair_for_later_kill(int pid) {
  /* save via /proc/$pid/stat */
  /* don't need to keep any fd after save or keep it for 1 ticket at most *=
/
}

safe_kill(pid, starttime, sig) {
    fd =3D open(/proc/$pid/stat); /* also hold the pid until close() if
open() successes */
    if (open successes and read starttime from fd and if it equals to start=
time)
        kill(pid, sig)
    close(fd)
}

In this case, zero LOC is added in the kernel. All of it depends on
the guarantee that holding /proc/pid/reg_file also holds the pid,
one of which I haven't checked carefully either.

On Fri, Dec 7, 2018 at 3:05 AM Christian Brauner <christian@brauner.io> wro=
te:
>
> On December 7, 2018 7:56:44 AM GMT+13:00, Florian Weimer <fweimer@redhat.=
com> wrote:
> >* Andy Lutomirski:
> >
> >>> I suppose that's fine.  Or alternatively, when thread group support
> >is
> >>> added, introduce a flag that applications have to use to enable it,
> >so
> >>> that they can probe for support by checking support for the flag.
> >>>
> >>> I wouldn't be opposed to a new system call like this either:
> >>>
> >>>  int procfd_open (pid_t thread_group, pid_t thread_id, unsigned
> >flags);
> >>>
> >>> But I think this is frowned upon on the kernel side.
> >>
> >> I have no problem with it, except that I think it shouldn=E2=80=99t re=
turn an
> >> fd that can be used for proc filesystem access.
> >
> >Oh no, my intention was that it would just be used with  *_send_signal
> >and related functions.
>
> Let's postpone that discussion a little.
> I think we don't need a syscall to base this off of pids.
> As I said I rather send my revived version of CLONE_NEWFD that would serv=
e the same task.
> The same way we could also just add a new open() flag that blocks fs acce=
ss completely.
> I just pitched that idea to Serge a few days back: O_NOCHDIR or similar.
> That could even be part of Aleksa's path resolution patchset.
>
> >
> >Thanks,
> >Florian
>
