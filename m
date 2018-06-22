Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+cFGlK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF8D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbeFVQXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:23:32 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46834 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbeFVQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:23:31 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so8091357otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sjxr7u3UlYrFd+tViUUNivvN3H62Z5Pj0i9pej6qsF4=;
        b=p+cFGlK1M7jCN2Le91aqyr3n7HCysOpP3DN/6goQY/6wNaRB6zFBFcxq0IRfo35hrt
         XQME5b53aLeTZhMqjAvwmcczQW4Fr6gMvmHmeBERtfbk2nLM+E0Whv5AkM0Dps4jCLdK
         8Gmp/Kbo5PDNP/TasF0mH5x4vZE0Thbk1K0tgk6ZCkMot0Z6KuUG1s25vD6qQV0O0WL5
         jmWiqBOIRyfr1ck1r6PJtxDH6oqxS4Rjl8FWGaL7SnQB+7gVcCOUe29cZxv+TVEFReW7
         gPIZ+gQ6fd4d2jX7hrCd09cBpgPwS6XD4o0R6ANHa+VHdoOT63fHHsZlSRxCGY3falAB
         zFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sjxr7u3UlYrFd+tViUUNivvN3H62Z5Pj0i9pej6qsF4=;
        b=h90cOl+rf20pRl6wXySi9Os++Ql+LSCcYvPhaXj3lh7cefW4Vo0CI5rToP+fdkKDqu
         w38KnowyZEh3v3D3bBxyc/1HvRLJwY1zWa3KWo6Nh5Mrv0A4Er56fjAmWKiuj+q6p+6p
         X89bOtGXtxTyo7Y/cpYc0+mQStsx4pxNvHfowX9uq7j5zaF7A+j9iWULmgBhnKQA2s2B
         5W0sd/IsqSKXzLESXPXbrt/be9BGqDDSvroqClkVFIaBUdSYts/svJPLNqPNzTnjmIqz
         B1Ido0N9VIRsmpIMBegbW/VdbQId2e4Vg3pvfe3+MTXUM53XWxIJGoTC0sk/9Yg4TzXz
         r7sQ==
X-Gm-Message-State: APt69E2W8eI7m6OJl+K7oC0YT++mTlSwLVvY3vrA7X9nqMp1JpXnXycV
        UMTEeBkikVy2x+tAIIMynv9Dt25nnresDb53QuJPqQ==
X-Google-Smtp-Source: AAOMgpe7E9x1jDJX/eTZ/Oa+q4BEit0dHj6Wy11RyC9sBMn417RqGgC8N9NTFwoLTSAbmHIpBQSeoTcI2pPaI6u8zB8=
X-Received: by 2002:a9d:5206:: with SMTP id e6-v6mr530845oth.216.1529684610102;
 Fri, 22 Jun 2018 09:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-5-tycho@tycho.ws>
In-Reply-To: <20180621220416.5412-5-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 18:23:18 +0200
Message-ID: <CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> The idea here is that the userspace handler should be able to pass an fd
> back to the trapped task, for example so it can be returned from socket().
>
> I've proposed one API here, but I'm open to other options. In particular,
> this only lets you return an fd from a syscall, which may not be enough in
> all cases. For example, if an fd is written to an output parameter instead
> of returned, the current API can't handle this. Another case is that
> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> ever decides to install an fd and output it, we wouldn't be able to handle
> this either.
>
> Still, the vast majority of interesting cases are covered by this API, so
> perhaps it is Enough.
>
> I've left it as a separate commit for two reasons:
>   * It illustrates the way in which we would grow struct seccomp_notif and
>     struct seccomp_notif_resp without using netlink
>   * It shows just how little code is needed to accomplish this :)
>
[...]
> @@ -1669,10 +1706,20 @@ static ssize_t seccomp_notify_write(struct file *file, const char __user *buf,
>                 goto out;
>         }
>
> +       if (resp.return_fd) {
> +               knotif->flags = resp.fd_flags;
> +               knotif->file = fget(resp.fd);
> +               if (!knotif->file) {
> +                       ret = -EBADF;
> +                       goto out;
> +               }
> +       }
> +

I think this is a security bug. Imagine the following scenario:

 - attacker creates processes A and B
 - process A installs a seccomp filter and sends the notification fd
to process B
 - process A starts a syscall for which the filter returns
SECCOMP_RET_USER_NOTIF
 - process B reads the notification from the notification fd
 - process B uses dup2() to copy the notification fd to file
descriptor 1 (stdout)
 - process B executes a setuid root binary
 - the setuid root binary opens some privileged file descriptor
(something like open("/etc/shadow", O_RDWR))
 - the setuid root binary tries to write some attacker-controlled data to stdout
 - seccomp_notify_write() interprets the start of the written data as
a struct seccomp_notif_resp
 - seccomp_notify_write() grabs the privileged file descriptor and
installs a copy in process A
 - process A now has access to the privileged file (e.g. /etc/shadow)

It isn't clear whether it would actually be exploitable - you'd need a
setuid binary that performs the right actions - but it's still bad.

Unless I'm missing something, can you please turn the ->read and
->write handlers into an ->unlocked_ioctl handler? Something like
this:

struct seccomp_user_notif_args {
        u64 buf;
        u64 size;
};

static long unlocked_ioctl(struct file *file, unsigned int cmd,
unsigned long arg)
{
        struct seccomp_user_notif_args args;
        struct seccomp_user_notif_args __user *uargs;

        if (cmd != SECCOMP_USER_NOTIF_READ && cmd != SECCOMP_USER_NOTIF_WRITE)
                return -EINVAL;

        if (copy_from_user(&args, uargs, sizeof(args)))
                return -EFAULT;

        switch (cmd) {
        case SECCOMP_USER_NOTIF_READ:
                return seccomp_notify_read(file, (char __user
*)args.buf, (size_t)args.size);
        case SECCOMP_USER_NOTIF_WRITE:
                return seccomp_notify_write(file, (char __user
*)args.buf, (size_t)args.size);
        default:
                return -EINVAL;
        }
}
