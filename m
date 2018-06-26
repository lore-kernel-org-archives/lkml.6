Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD874C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7642641C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pLlOFOxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7642641C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965148AbeFZCBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:01:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36871 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964843AbeFZCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:01:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id o11-v6so1011412pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7bWEH+XZ1TAGDbOB3pS+qNO1MUYTuyv9m5DYMaFD9+s=;
        b=pLlOFOxGXsZd+ptNgL7o85NYaHypwOPfKDopC5SM0y8tJyiwXKCrizvr3ZNLhl8+BG
         Vau9eWYsE3wmuzURKvp1RIW1NiXoP3pxZ2SqZcgVdSUbbBFtCxibWWSHpiU0BQxa/b5q
         2Fu1SiShPUmWECL6F+dMmKXJH6KtcyEC47PuMuBuyIkCihYkhQNEJlT5TEb1c64tYh2D
         d3Y7nfrMVQXsrct5WASivTzePADcjuJ4dWZitq7zAQZNHqyn13CSUgAy2VxOVBzUq3yh
         fbaJLlbDiiHgittSPvP9sM0Ue3OkY5zWH4904qChOp92LheLXACJbMF5JBzn2eNCQoFF
         lGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7bWEH+XZ1TAGDbOB3pS+qNO1MUYTuyv9m5DYMaFD9+s=;
        b=CjT0XlB1KgpVUj5JEJ+nzus174bChqcxHC9lcSW92/ylt+zpboXmNm4MGLtSdIxlHq
         /ENGVJIoV6wnJjc05DK+W9QXSj/mGrC07YQ/Zfs/UkONlygy2MUOZhsnzx3fN3cFNgsv
         05EVZnGIVSwgpoFshO9bwVD8CNExvJ60oOrP/QkXA6yfGIInrDLp5zTTQQGbQNOxocZ3
         nCLEcexxYV/P75a5kWQzpavARKMwtoRLhbdl/i+8tYWaLv/7EnW327hMgM3uU65U3ngH
         tOhRRdA4kr5llQ3TUUVoH010UeoY6DqvwlXVXH9anYcay5Te8tx+34wNwVipo8M/0GeG
         AxOw==
X-Gm-Message-State: APt69E3vRii98crV88lIgIlEhzm5/nJJ8fLKjIjEwNvR7lqxpfeAKKvL
        5JbBnQkk163SjCFHzqyjVcttyNucElA=
X-Google-Smtp-Source: ADUXVKLAFqX7i92mhbWDF3Xd79i1thPl1TAASSsnyvuwUNUWScFG88HclbeVjEaNSCkr/K0vJRa8Bg==
X-Received: by 2002:a65:4382:: with SMTP id m2-v6mr12638137pgp.68.1529978460299;
        Mon, 25 Jun 2018 19:01:00 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01b:ac5e:f0d2:dd3c:5dff:6377? ([2600:1010:b01b:ac5e:f0d2:dd3c:5dff:6377])
        by smtp.gmail.com with ESMTPSA id s68-v6sm429746pfi.85.2018.06.25.19.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 19:00:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180626013204.GA7261@cisco.cisco.com>
Date:   Mon, 25 Jun 2018 19:00:56 -0700
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
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
Message-Id: <24C1FE9E-1BAB-49EC-B62C-942B945A7163@amacapital.net>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws> <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com> <20180622151514.GM3992@cisco> <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net> <CAGXu5jKWQCDzXPdTz=+bxT9+4enaBvgYfMseUiGti+t1KwZT8g@mail.gmail.com> <CAG48ez3gobTL5mUnZKjhLedotZx49nGrxYKKud5_7+512PaOFw@mail.gmail.com> <20180626013204.GA7261@cisco.cisco.com>
To:     Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2018, at 6:32 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>=20
>> On Sat, Jun 23, 2018 at 12:27:43AM +0200, Jann Horn wrote:
>>> On Fri, Jun 22, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote=
:
>>>=20
>>>> On Fri, Jun 22, 2018 at 11:09 AM, Andy Lutomirski <luto@amacapital.net>=
 wrote:
>>>> One possible extra issue: IIRC /proc/.../mem uses FOLL_FORCE, which is n=
ot what we want here.
>>=20
>> Uuugh, I forgot about that.
>>=20
>>>> How about just adding an explicit =E2=80=9Cread/write the seccomp-trapp=
ed task=E2=80=99s memory=E2=80=9D primitive?  That should be easier than a =E2=
=80=9Copen mem fd=E2=80=9D primitive.
>>>=20
>>> Uuugh. Can we avoid adding another "read/write remote process memory"
>>> interface? The point of this series was to provide a lightweight
>>> approach to what should normally be possible via the existing
>>> seccomp+ptrace interface. I do like Jann's context idea, but I agree
>>> with Andy: it can't be a handle to /proc/$pid/mem, since it's
>>> FOLL_FORCE. Is there any other kind of process context id we can use
>>> for this instead of pid? There was once an idea of pid-fd but it never
>>> landed... This would let us get rid of the "id" in the structure too.
>>> And if that existed, we could make process_vm_*v() safer too (taking a
>>> pid-fd instead of a pid).
>>=20
>> Or make a duplicate of /proc/$pid/mem that only differs in whether it
>> sets FOLL_FORCE? The code is basically already there... something like
>> this:
>=20
> But we want more than just memory access, I think. rootfs access, ns
> fds, etc. all seem like they might be useful, and racy to open.
>=20
> I guess I see two options: use the existing id and add something to
> seccomp() to ask if it's still valid or independent of this patchset
> add some kind of pid id :\
>=20

I think we use the existing id / cookie / whatever and ask seccomp, or new s=
yscalls, to do the requested operation. This is because we know the target t=
ask is in a very special stopping point. As a result, a seccomp-specific mec=
hanism can do RCU-less fd modifications against a single-threaded target, ca=
n muck with things like struct cred, etc, while a more general interface can=
=E2=80=99t.

It might be nice to add a syscall with flags such that it could be used on p=
trace-stopped targets later on. Something like:

access_remote_task(int fd, u64 id, u32 type, ...)

Where type is 16 bits of =E2=80=9Cid and fd is from seccomp=E2=80=9D and 16 b=
its of =E2=80=9Cwrite memory=E2=80=9D or such.=
