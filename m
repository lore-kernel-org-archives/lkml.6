Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96699C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851420651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z85Zr+st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfBYPv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:51:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfBYPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:51:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id a16so7999219edn.1;
        Mon, 25 Feb 2019 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kAhK+uBzcDW/sfrS4FAzFOMfe7UXUTrqFRB04jK+4xc=;
        b=Z85Zr+stosqySFWIW+KiE8rjr7jc/qqX6untjUDcxmFJdSLpIWzehVU5KfAnHCaBWV
         FUO6jqixtID0O7pOCZmQHDIPB2XjBOsqDSq3WxUnFYgNpX5t0xEafT/SR9IFbddhwPLV
         8R7GwpLJfWtJT1agygEeK2FysYYfgsaQLJlHMc4cNcPW9TqDAuVFiTAeNTQsuqAzdvpl
         od/6nLobjB8yxIW4wJiAucZJ/ptXY4iaVxRm6rqVK9ctysng01dzRJUGRswzj1cMU9+R
         5J/7Lu0QztPxYUQf31CKaYOIX8yxp7AY2qy3x1VdC0Xio5n7eHbPi86H6PV7edXuFXxV
         MyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kAhK+uBzcDW/sfrS4FAzFOMfe7UXUTrqFRB04jK+4xc=;
        b=lPKwgCv0/SXAj+1UXNRsNGfxzqivtrVlrVYrhUgKpV46cqyqi55/Fqxc33ODeoOtQN
         8X/MWzJ2jfVzKVkZBd8sclgDPXoRdOY6CnPKiXpV0fUiQhioRslVNvkFWQQiHDml0qPf
         b2lt8O6BOrTbbXe0ScR579w3+Tuhx3oMzVcefz0dDW7w//9Ulc8EnJV9XtWr/+PSkCfu
         DKX2f0FrdXKiOSkCp5BhO/w3OTqcOXVCN7O++ZqDDpLncSS+oYXfsu44r1rNGJkFbyw1
         aX+7yJmiqC7B0vzax7/H1fUTHjfexIm8Hfy0sxZuT+bVbLE6jEoChf0J3NHUS/TgNV/o
         OAXA==
X-Gm-Message-State: AHQUAuZ9A8qXpuSFhb35IzbQ4mWN0oYE4tjg8fmhmI6KXy83Fm5o1fvE
        DklHcMaLJOYZPB2MNpMjwAVgWmfBCFDgPQLSOZU=
X-Google-Smtp-Source: AHgI3IYPg0/pxvaYJddtR+NslKmyRSVO1t8TRWMfxjGEQ23NxNSiUfnMDhOqWsxF6cK5zPjJET/5e9Cetu3OGyHVcTE=
X-Received: by 2002:a17:906:28c7:: with SMTP id p7mr13737616ejd.235.1551109881805;
 Mon, 25 Feb 2019 07:51:21 -0800 (PST)
MIME-Version: 1.0
References: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me> <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
 <20190217221523.GA9233@altlinux.org>
In-Reply-To: <20190217221523.GA9233@altlinux.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 25 Feb 2019 16:51:10 +0100
Message-ID: <CAKgNAkhNCE24+QEYpQjcAjN2ktQe_JdAd7sP9rHR90iA228-yw@mail.gmail.com>
Subject: Re: [PATCH] ptrace.2: Improve clarity for multi-threaded tracers
To:     =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        lkml <linux-kernel@vger.kernel.org>, cleverca22@gmail.com,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Do you plan to revise this patch in the light of Dmitry's comments?

Thanks,

Michael

On Sun, 17 Feb 2019 at 23:15, Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> Hi,
>
> On Sun, Feb 17, 2019 at 05:34:46PM +0100, Niklas Hamb=C3=BCchen wrote:
> > Until now, the man page said:
> >
> >     Attachment and subsequent commands are per thread:
> >     in a multi=E2=80=90 threaded process, every thread can be individua=
lly attached to a
> >     (potentially different) tracer, or left not attached and thus not d=
ebugged.
> >     Therefore, "tracee" always means "(one) thread", never "a (possibly
> >     multithreaded) process".
> >
> > While the first sentence "Attachment ... [is] per thread" might be inte=
rpreted
> > as holding for both tracer and tracee, the rest talks only about the
> > multi-threadedness of the *tracee*, leaving some uncertainty in the rea=
der on
> > whether the tracer may issue `ptrace()` from different threads.
> >
> > This patch adds more explicitness, removing any doubt.
>
> Thanks for making an attempt to remove any doubt.
>
> Yes, ptrace'ing is per task_struct on both sides.
>
> > Relevant resources:
> >
> > * LKML thread https://marc.info/?l=3Dlinux-kernel&m=3D155036848808748&w=
=3D2
> >   "ptrace() with multithreaded tracer"
> >   where I asked about this behaviour, in case anybody disagrees with my
> >   understanding
> > * https://stackoverflow.com/questions/18737866/can-a-thread-trace-a-pro=
cess/
> >   where the previous ambiguity of the man page confused some users, and=
 where
> >   and example program is given that confirms the behaviour I mention in=
 this
> >   patch
> > * A program of mine, in which I have independently confirmed that using
> >   `ptrace()` from a thread that's not the tracer thread (a sibling thre=
ad in
> >   the process is the tracer instead) results in `ESRCH`
> > * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/ptrace.c?id=3D96d4f267e40f9509e8a66e2b39e8b95655617693#n207
> >   where the comment on `ptrace_check_attach()` talks about `%current`, =
which
> >   is a thread
> >
> > Signed-off-by: Niklas Hamb=C3=BCchen <mail@nh2.me>
> > ---
> >  man2/ptrace.2 | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/man2/ptrace.2 b/man2/ptrace.2
> > index 3b6b6ea84..4058abe94 100644
> > --- a/man2/ptrace.2
> > +++ b/man2/ptrace.2
> > @@ -122,12 +122,18 @@ It is primarily used to implement breakpoint debu=
gging and system
> >  call tracing.
> >  .PP
> >  A tracee first needs to be attached to the tracer.
> > -Attachment and subsequent commands are per thread:
> > -in a multithreaded process,
> > +Attachment and subsequent commands are per thread,
> > +on both the tracer and tracee side.
> > +Issuing a tracing command from a thread that is not the tracer of the =
given
> > +.I pid
> > +will result in an
> > +.B ESRCH
> > +error.
>
> This is confusing.  What do you mean by a tracing command?
> Is PTRACE_TRACEME a tracing command?  PTRACE_ATTACH?  PTRACE_SEIZE?
>
> I suggest leaving the explanation of ptrace return code to "ERRORS"
> section.
>
> > +In a multithreaded process to be traced,
> >  every thread can be individually attached to a
> >  (potentially different) tracer,
> >  or left not attached and thus not debugged.
> > -Therefore, "tracee" always means "(one) thread",
> > +Therefore, "tracer" or "tracee" always mean "(one) thread",
> >  never "a (possibly multithreaded) process".
> >  Ptrace commands are always sent to
> >  a specific tracee using a call of the form
> > @@ -2259,7 +2265,7 @@ or (on kernels before 2.6.26) be
> >  .TP
> >  .B ESRCH
> >  The specified process does not exist, or is not currently being traced
> > -by the caller, or is not stopped
> > +by the calling thread, or is not stopped
> >  (for requests that require a stopped tracee).
> >  .SH CONFORMING TO
> >  SVr4, 4.3BSD.
>
> I agree the current text can be made more clear on the subject,
> but, unfortunately, proposed change makes the description more confusing.
>
>
> --
> ldv



--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
