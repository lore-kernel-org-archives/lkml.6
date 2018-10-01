Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA1EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8C208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fprD5k4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF8C208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeJAVGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:06:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44529 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbeJAVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:06:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so9326914pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q/Qz+S4z+hYiexsvWbkToEyyKfGMGjXDyNHfm1zcIeA=;
        b=fprD5k4eOIjHlRwfb5490JWFPkszCVQgLl9USlgkD7szQKad/c6LpnpDZ5Ignj8XkL
         YzkqRODPCnPt8IyqtmQGjM80XaOx0ZVsXf9t1oDZR2fygdQersG8LVxOIdc0mSz7LR2q
         +oz6qDxk7Auux2DeuX0sijnqL6t95YgAxl5uHAXmo+eWCh8Js7CiVspXYUYigx1UQKss
         hEDbzxF6kb6v+G42XJHk7CSi2WfXjGZY30lNW+H5eL/1XYDAPL6lh9F9nG27/DBwraaI
         TCCPi2Rrlr382cNM3n/6fjQ/l9yDC0+Ear08Y0XbG1+1k8R/5ZnaMWadawxxNpOywGaT
         8C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q/Qz+S4z+hYiexsvWbkToEyyKfGMGjXDyNHfm1zcIeA=;
        b=FZfC5IiDjaeFu0nM3jT3Pc2VcxN8atL4yIQXfy6RbgiSbQke2KWEeR8KPCsEpiajEE
         C53QYhYqnjFEts+DzMHruT5tBXtf0qKkRyqgAZ25LFijECc6StCN9q/EbbSf1uLzxmCQ
         jbOtjZbbv/911B3tegAizbR7hGtYN7/qmfVTlm8pXHkoLZ0AhQD7rFtDPW4/mCj9YLoe
         sX8HTS61XOAx+pkwElp46Q/Rq5qvx0ZjON8l2/7CUykK/R1x3hQOG9Q0XlHeju+rGatV
         tlAxiNey+WkkPVJStJjpM1SUmTWx2NdZ7tmECbs1GpZ52t1tSZ1oUyIJsxBmjLMboUsk
         0Nmw==
X-Gm-Message-State: ABuFfogACm6oj8855cfDDdnMfHFwgu0F4C/iQit+TRWRUZ07jZa8a1jy
        qq87zvcoPniseOadNgpyxIw0xg==
X-Google-Smtp-Source: ACcGV60BfmA6PTxSEayuFl79+PBRicqb2E0AJAKM3M5+JHzOD/dvYXXRtxOqgBJ4R3z4SotGn16fQQ==
X-Received: by 2002:a17:902:101:: with SMTP id 1-v6mr11973544plb.15.1538404116880;
        Mon, 01 Oct 2018 07:28:36 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:11a8:656c:46d0:f835? ([2601:646:c200:7429:11a8:656c:46d0:f835])
        by smtp.gmail.com with ESMTPSA id g6-v6sm19661256pfb.11.2018.10.01.07.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:28:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181001054246.gfinmx3api7kjhmc@ryuk>
Date:   Mon, 1 Oct 2018 07:28:34 -0700
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com> <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com> <20181001054246.gfinmx3api7kjhmc@ryuk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Currently most container runtimes try to do this resolution in
>>> userspace[1], causing many potential race conditions. In addition, the
>>> "obvious" alternative (actually performing a {ch,pivot_}root(2))
>>> requires a fork+exec which is *very* costly if necessary for every
>>> filesystem operation involving a container.
>>=20
>> Wait. fork() I understand, but why exec? And actually, you don't need
>> a full fork() either, clone() lets you do this with some process parts
>> shared. And then you also shouldn't need to use SCM_RIGHTS, just keep
>> the file descriptor table shared. And why chroot()/pivot_root(),
>> wouldn't you want to use setns()?
>=20
> You're right about this -- for C runtimes. In Go we cannot do a raw
> clone() or fork() (if you do it manually with RawSyscall you'll end with
> broken runtime state). So you're forced to do fork+exec (which then
> means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same goes
> for CLONE_VFORK.

I must admit that I=E2=80=99m not very sympathetic to the argument that =E2=80=
=9CGo=E2=80=99s runtime model is incompatible with the simpler solution.=E2=80=
=9D

Anyway, it occurs to me that the real problem is that setns() and chroot() a=
re both overkill for this use case. What=E2=80=99s needed is to start your w=
alk from /proc/pid-in-container/root, with two twists:

1. Do the walk as though rooted at a directory. This is basically just your A=
T_THIS_ROOT, but the footgun is avoided because the dirfd you use is from a f=
oreign namespace, and, except for symlinks to absolute paths, no amount of .=
. racing is going to escape the *namespace*.

2. Avoid /proc. It=E2=80=99s not just the *links* =E2=80=94 you really don=E2=
=80=99t want to walk into /proc/self. *Maybe* procfs is already careful enou=
gh when mounted in a namespace?
