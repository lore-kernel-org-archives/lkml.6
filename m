Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A033C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F22206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNDbKDLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F22206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeKTX6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:58:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:58:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so1964529wrs.10;
        Tue, 20 Nov 2018 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMfR12mnw0ARb1TOaxgCG0c4blOb222r1LepeWHvXvQ=;
        b=aNDbKDLUkT1X78aXcKyc3jLUwMKPk1tXbn+D/xPZS6TiK91h1ygHpwHwK1TGV9ONz9
         RJ1WPNXH+Nd6f3XfAoJcmgEbPshB9Kk0CC41Xht8/2I0N6j0JZcqJAEEfTTSDhhbgXDK
         3u7yaj8au1wrfs9Txyf+E5Tbo93w9YIn5Yr0gdCBF3MfDvH5U4wv+cJGvm/mubjyLwd7
         bl0+I4/ag5k+UpV7WzW0ZxhDX8zeOE2SO6H45P516M0hgL4sFvs9yKLsklhBnCjlCWi3
         muGhINlrzfzNifPlFHZVWzOAhYO0mNuAe7EpNfp6msXimRuDbw+lu1l7lB1HcE6OfCY5
         l43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMfR12mnw0ARb1TOaxgCG0c4blOb222r1LepeWHvXvQ=;
        b=hR8U63NvxYVdYRZpDhjhPORen72vZ5JjNNF+Z8dhtIDEXqVRxb5vTpkoZ/50aZ/G2O
         eZiuEP9kOncZDf5ZA9VcZ9qAWB/lK0ArqjUWFFZ8dj9Y5QHFbkGzMFNYzhTVEd7pU6/1
         fJiQmE9kZJILYRALnaXLt/2i7nY9n3zr1pLhh6ARrui2Lnt+Ia/9lsEazEJrBV4ZZLeL
         HEJAzjZPe2QSbXPks9ZDTI4P1SRdnj2C7Ujvl+HoN4uwyo3URAJqi7VUnVueKComtcUL
         0f5NXsjh6o0LoWTZpDFukRsp2U068Wu8iXHAVKB2JOocvf77ha4YwbzHos2AHBb9pqzE
         EDYA==
X-Gm-Message-State: AA+aEWb+7JDQCHyyX1c1Q0PHoXq+bAeoalVb5j1GGocsN04SHayb5qI5
        hxkILGe+vY4FOPSf99pBEFNjrJQa
X-Google-Smtp-Source: AFSGD/VBDjbtDEit2+/rc5iLarUM1Yy/Ya4ShxDt/0s3ewjZ3TA8ZO/2ZSp+ZmsNPqlLJMZ0WR808g==
X-Received: by 2002:adf:806b:: with SMTP id 98-v6mr1919400wrk.23.1542720575710;
        Tue, 20 Nov 2018 05:29:35 -0800 (PST)
Received: from [10.0.20.201] (mail.jambit.com. [95.157.63.22])
        by smtp.gmail.com with ESMTPSA id k124sm14677469wmd.33.2018.11.20.05.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:29:34 -0800 (PST)
Cc:     mtk.manpages@gmail.com, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org
Subject: Re: [PATCH] procfd_signal.2: document procfd_signal syscall
To:     Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-4-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <adf719cc-856e-e3cb-8435-f1d9dac7c40f@gmail.com>
Date:   Tue, 20 Nov 2018 14:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119103241.5229-4-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On 11/19/18 11:32 AM, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> Changelog:
> v1:
> - patch introduced
> ---
>  man2/procfd_signal.2 | 147 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 man2/procfd_signal.2
> 
> diff --git a/man2/procfd_signal.2 b/man2/procfd_signal.2
> new file mode 100644
> index 000000000..6af0b74f4
> --- /dev/null
> +++ b/man2/procfd_signal.2
> @@ -0,0 +1,147 @@
> +.\" Copyright (C) 2018 Christian Brauner <christian@brauner.io>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH PROCFD_SIGNAL 2 2017-09-15 "Linux" "Linux Programmer's Manual"

Bad timestamp :-)

> +.SH NAME
> +procfd_signal \- send signal to a process through a process descriptor

s/through/via/

> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <signal.h>
> +.PP
> +.BI "int procfd_signal(int " fd ", int " sig ", siginfo_t *" info ", int " flags );
> +.fi
> +.SH DESCRIPTION
> +.BR procfd_signal ()
> +sends the signal specified in
> +.I sig
> +to the process identified by the file descriptor
> +.IR fd .

Here, I think we need some words about how one obtains that 
file descriptor.

> +The permissions required to send a signal are the same as for
> +.BR kill (2).
> +As with
> +.BR kill (2),
> +the null signal (0) can be used to check if a process with a given
> +PID exists.

But there is no PID mentioned on this page?

I suppose:

As with
.BR kill (2),
the null signal (0) can be used to check if the process referred to by
.I fd
exists.

?

> +.PP
> +The optional
> +.I info
> +argument specifies the data to accompany the signal.
> +This argument is a pointer to a structure of type
> +.IR siginfo_t ,
> +described in
> +.BR sigaction (2)
> +(and defined by including
> +.IR <sigaction.h> ).
> +The caller should set the following fields in this structure:
> +.TP
> +.I si_code
> +This must be one of the
> +.B SI_*
> +codes in the Linux kernel source file
> +.IR include/asm-generic/siginfo.h ,
> +with the restriction that the code must be negative
> +(i.e., cannot be
> +.BR SI_USER ,
> +which is used by the kernel to indicate a signal sent by
> +.BR kill (2))
> +and cannot (since Linux 2.6.39) be
> +.BR SI_TKILL
> +(which is used by the kernel to indicate a signal sent using
> +.\" tkill(2) or
> +.BR tgkill (2)).
> +.TP
> +.I si_pid
> +This should be set to a process ID,
> +typically the process ID of the sender.
> +.TP
> +.I si_uid
> +This should be set to a user ID,
> +typically the real user ID of the sender.
> +.TP
> +.I si_value
> +This field contains the user data to accompany the signal.
> +For more information, see the description of the last
> +.RI ( "union sigval" )
> +argument of
> +.BR sigqueue (3).

With sigqueue(3), one sends only a signal plus accompanying
data. It is of course based on the lower level rt_sigqueueinfo(2).
The man page for that system call says:

    These system calls are not intended for  direct  application  use;
    they  are  provided to allow the implementation of sigqueue(3) and
    pthread_sigqueue(3).

Is procfd_signal() intended to be the API directly used from
user space? If it is, then I think there should be some
explanation of why there is a 'siginfo_t' argument (vis-à-vis
sigqueue(3), which makes do with just union sigval).
If procfd_signal() is not intended to be the API used directly
from user space, then I think there needs to be a paragraph
similar to the one in the rt_sigqueueinfo(2) page queoted above.

> +.PP
> +Internally, the kernel sets the
> +.I si_signo
> +field to the value specified in
> +.IR sig ,
> +so that the receiver of the signal can also obtain
> +the signal number via that field.
> +.PP
> +The
> +.I flags
> +argument is reserved for future extension and must be set to 0.
> +.PP
> +.SH RETURN VALUE
> +On success, this system call returns 0.
> +On error, it returns \-1 and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EBADF
> +.I fd
> +is not a valid file descriptor.
> +.TP
> +.B EINVAL
> +An invalid signal was specified.
> +.TP
> +.B EINVAL
> +.I fd
> +does not refer to a process.
> +.TP
> +.B EINVAL
> +The flags argument was not 0.
> +.TP
> +.B EPERM
> +The caller does not have permission to send the signal to the target.
> +For the required permissions, see
> +.BR kill (2).
> +Or:
> +.I uinfo->si_code
> +is invalid.
> +.TP
> +.B ESRCH
> +The process or process group does not exist.

"or process group"? I suspect a cut and paste error here :-)

The connection between the preceding sentence and the one
that follows it is not quite clear:

> +Note that an existing process might be a zombie,
> +a process that has terminated execution, but
> +has not yet been
> +.BR wait (2)ed
> +for.

Is it the case that using procfd_signal() with a file
descriptor that refers to a zombie will yield EINVAL?
If yes, this could be made clearer with the following:

.B ESRCH
The specified process no longer exists or is a process in the
zombie state (a process that has terminated execution, but
has not yet been
BR wait (2)ed
for).

> +.SH CONFORMING TO
> +This system call is Linux-specific.
> +.SH SEE ALSO
> +.BR kill (2),
> +.BR sigaction (2),
> +.BR sigprocmask (2),
> +.BR tgkill (2),
> +.BR pthread_sigqueue (3),
> +.BR rt_sigqueueinfo (2),
> +.BR sigqueue (3),
> +.BR signal (7)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
