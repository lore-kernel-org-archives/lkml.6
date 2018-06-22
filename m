Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDB7246E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pMEvdvVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDB7246E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeFVSVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:21:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39976 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933646AbeFVSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:21:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so3583888pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z5U7xO27ugme0b2zNqmiAUgMkQRPxwGUVTB+32vXUO0=;
        b=pMEvdvVNVSF3G3R3jP7wracOjMQGvwqJx3k6Xfnhs0AxDAL1mALub2pSSSAZKl6iHJ
         DIcjJ+dT2TvV/2pn9CAtntXvEXP9vtPlGHj7thQfHl1FaZNhV+dd9K2ky40QLdxryUhk
         yEZgi9gKQTWYCiwayUdan3VokOKRdJW+s4M9/ueoaXHci1TJhFYx9GWCdJxikiTdD4wW
         gaWW25fCKcbX03hwrU6lGvYDlyuTDcv54VisuJw1MgV+b0viZzgCH+TZulOxP4AI7xcq
         TsSwpAB17Un4WkicKmY6VsCMS9K+EVkm553oLqN+CYc9cw+PcTGIEpEx2qgYfoWlCdXp
         jsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z5U7xO27ugme0b2zNqmiAUgMkQRPxwGUVTB+32vXUO0=;
        b=I4Syp6WWwaKVtxmm663WbP12t9/C21fUG9PiJJrTf16cakyfkffZh6cczgqAhNNrhJ
         o3cFyUBVrE+izs6EsIaEEhTp3Qkwnki4Nt7nBNm5oFHGrVzLVRo3P5+CCRJ7rL+0GHZ3
         ySyVS5UZxdZrcqYvsHeqXSCHF5lhFMdwfhJo/LnOvG5B/feVzeUaSGyY7eBvSCkDuEtP
         AsPFNP1BlJjabI7pRYv/XFlwm9SMJz4ETslIwdsbrsREIHmi1SlgDbp1JU2iun/iPYwz
         tdZ+PZnVuheQvkIvePxH9OwCOO1vFUVS8kz0oPemdU9PZ/OExdCOwHoIYqbNFkILiLlL
         MF4A==
X-Gm-Message-State: APt69E1/et6uPAAnSz9crV9euPIQSLv8+q58tLlAJemOlyRhoVjp2Bz+
        jJQUWk72xKRqtfrFMiN+oVr8oCQ9ATA=
X-Google-Smtp-Source: ADUXVKIU3XY4yRRbi9JX9Pty+WcQxXo4bfrgF1d3gMF+t8AhrFNM3VLiEiEHGA143iNfUQJzndD8xg==
X-Received: by 2002:a62:c61d:: with SMTP id m29-v6mr2902605pfg.26.1529691673113;
        Fri, 22 Jun 2018 11:21:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:2cd9:e530:8535:a508:f820? ([2600:1010:b065:2cd9:e530:8535:a508:f820])
        by smtp.gmail.com with ESMTPSA id d6-v6sm10955156pgc.38.2018.06.22.11.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:21:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 4/4] seccomp: add support for passing fds via USER_NOTIF
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com>
Date:   Fri, 22 Jun 2018 11:21:08 -0700
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C2AA818-2F53-4F40-842F-288B4C709414@amacapital.net>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-5-tycho@tycho.ws> <CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2018, at 9:23 AM, Jann Horn <jannh@google.com> wrote:
>=20
>> On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
>>=20
>> The idea here is that the userspace handler should be able to pass an fd
>> back to the trapped task, for example so it can be returned from socket()=
.
>>=20
>> I've proposed one API here, but I'm open to other options. In particular,=

>> this only lets you return an fd from a syscall, which may not be enough i=
n
>> all cases. For example, if an fd is written to an output parameter instea=
d
>> of returned, the current API can't handle this. Another case is that
>> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
>> ever decides to install an fd and output it, we wouldn't be able to handl=
e
>> this either.
>>=20
>> Still, the vast majority of interesting cases are covered by this API, so=

>> perhaps it is Enough.
>>=20
>> I've left it as a separate commit for two reasons:
>>  * It illustrates the way in which we would grow struct seccomp_notif and=

>>    struct seccomp_notif_resp without using netlink
>>  * It shows just how little code is needed to accomplish this :)
>>=20
> [...]
>> @@ -1669,10 +1706,20 @@ static ssize_t seccomp_notify_write(struct file *=
file, const char __user *buf,
>>                goto out;
>>        }
>>=20
>> +       if (resp.return_fd) {
>> +               knotif->flags =3D resp.fd_flags;
>> +               knotif->file =3D fget(resp.fd);
>> +               if (!knotif->file) {
>> +                       ret =3D -EBADF;
>> +                       goto out;
>> +               }
>> +       }
>> +
>=20
> I think this is a security bug. Imagine the following scenario:
>=20
> - attacker creates processes A and B
> - process A installs a seccomp filter and sends the notification fd
> to process B
> - process A starts a syscall for which the filter returns
> SECCOMP_RET_USER_NOTIF
> - process B reads the notification from the notification fd
> - process B uses dup2() to copy the notification fd to file
> descriptor 1 (stdout)
> - process B executes a setuid root binary
> - the setuid root binary opens some privileged file descriptor
> (something like open("/etc/shadow", O_RDWR))
> - the setuid root binary tries to write some attacker-controlled data to s=
tdout
> - seccomp_notify_write() interprets the start of the written data as
> a struct seccomp_notif_resp
> - seccomp_notify_write() grabs the privileged file descriptor and
> installs a copy in process A
> - process A now has access to the privileged file (e.g. /etc/shadow)
>=20
> It isn't clear whether it would actually be exploitable - you'd need a
> setuid binary that performs the right actions - but it's still bad.

Jann is right. ->read and ->write must not reference any of the calling task=
=E2=80=99s state except the literal memory passed in.

>=20
> Unless I'm missing something, can you please turn the ->read and
> ->write handlers into an ->unlocked_ioctl handler? Something like
> this:
>=20
> struct seccomp_user_notif_args {
>        u64 buf;
>        u64 size;
> };
>=20
> static long unlocked_ioctl(struct file *file, unsigned int cmd,
> unsigned long arg)
> {
>        struct seccomp_user_notif_args args;
>        struct seccomp_user_notif_args __user *uargs;
>=20
>        if (cmd !=3D SECCOMP_USER_NOTIF_READ && cmd !=3D SECCOMP_USER_NOTIF_=
WRITE)
>                return -EINVAL;
>=20
>        if (copy_from_user(&args, uargs, sizeof(args)))
>                return -EFAULT;
>=20
>        switch (cmd) {
>        case SECCOMP_USER_NOTIF_READ:
>                return seccomp_notify_read(file, (char __user
> *)args.buf, (size_t)args.size);
>        case SECCOMP_USER_NOTIF_WRITE:
>                return seccomp_notify_write(file, (char __user
> *)args.buf, (size_t)args.size);
>        default:
>                return -EINVAL;
>        }
> }
