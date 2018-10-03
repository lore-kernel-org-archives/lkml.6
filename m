Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F010FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E1221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0mGAtVtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJDE7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:59:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJDE7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:59:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so7147484wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xxvgLSCVy3AIIobM99xNjO1M2tpj3kz+ZJxwF+A8X9M=;
        b=0mGAtVtWHvAzMi9mTFhvrwTZ/UN7U0Dbc5kGNKFsq0qi+13t3HgF3VWbaLqcGFzjBl
         74fFoQ89Q06RC4adg7gnsy61ufXJSlLnMdkJHSfx11+Xk4j+YKOQO45Nt3B9KROk73U+
         +K3Vcl5FybugCt3qbmuklU+0NnnSkmuv/k3ZVapU+QYemUP6s4V5RjZSWycNID2KdxsA
         0AV9O29eBuvYXlxY9VOEijtdSann/ILm6YNUKajhg3iQcUbekN3TaLzocuRyGKOkdzCS
         jRH/El3AsJN7HY7RS66ALFXdvMYY6ai5G6+j3PXHY0UL6I/h60MuwdQS0pzfgdOFgQqc
         wymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxvgLSCVy3AIIobM99xNjO1M2tpj3kz+ZJxwF+A8X9M=;
        b=FEXJu4pEBpC8HeYVEkjPus8dSWLIRri3A1Il83HfDAWbe9U+pMHNUkNI0DyUq5JAcL
         lUr/m7v0MZ8YttMcJaq9obKu4nLGa3dv4RmRcJuk2aq+YJVBViUoXrArIcc3pMej+qan
         Wqxv4/soFGY1TM5N/DAuOOszeafAPLEFGMgMVyltDL6vzTGvru87X59FzkU4bKKaNgBD
         nv7dH2riSfDVibYdlimayFUD5seV9TMUKcIt3qJeeXpkQy2v8KEOZI70ieQK8Ktpx9vh
         g8ybPW/qHQZXjlkCyZdI1i+fm+OU8qF+JdpZIiz8LkWWYZ1VIOxnLb5IFXfyutyvTwg7
         dVJQ==
X-Gm-Message-State: ABuFfohL6v7DZLFoVSqtrnR/AeNMWdeTMIQ9H+nCQnGRsMQ4UY8ohEUO
        IelbSeMdf1bfcwihSO17VGs89YPKLdHJsYwx6N/Tkw==
X-Google-Smtp-Source: ACcGV62yYlBI41UpXWjNTCRZfpvCbrxzXVYwyc6EtDO6pxfUnALHJJZTNICTVjuHznq/RHcIC23nbvUmLsOwrTYvwrk=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr2748804wmf.19.1538604569860;
 Wed, 03 Oct 2018 15:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181001054246.gfinmx3api7kjhmc@ryuk> <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
 <20181002073220.7mzndna4tdnxdvdt@ryuk>
In-Reply-To: <20181002073220.7mzndna4tdnxdvdt@ryuk>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 3 Oct 2018 15:09:18 -0700
Message-ID: <CALCETrXZ_Kg25gToCzzM=4g1Z3mQgou8RmF6OWoh3+vuPk3vUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 12:32 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2018-10-01, Andy Lutomirski <luto@amacapital.net> wrote:
> > >>> Currently most container runtimes try to do this resolution in
> > >>> userspace[1], causing many potential race conditions. In addition, =
the
> > >>> "obvious" alternative (actually performing a {ch,pivot_}root(2))
> > >>> requires a fork+exec which is *very* costly if necessary for every
> > >>> filesystem operation involving a container.
> > >>
> > >> Wait. fork() I understand, but why exec? And actually, you don't nee=
d
> > >> a full fork() either, clone() lets you do this with some process par=
ts
> > >> shared. And then you also shouldn't need to use SCM_RIGHTS, just kee=
p
> > >> the file descriptor table shared. And why chroot()/pivot_root(),
> > >> wouldn't you want to use setns()?
> > >
> > > You're right about this -- for C runtimes. In Go we cannot do a raw
> > > clone() or fork() (if you do it manually with RawSyscall you'll end w=
ith
> > > broken runtime state). So you're forced to do fork+exec (which then
> > > means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same g=
oes
> > > for CLONE_VFORK.
> >
> > I must admit that I=E2=80=99m not very sympathetic to the argument that=
 =E2=80=9CGo=E2=80=99s
> > runtime model is incompatible with the simpler solution.=E2=80=9D
>
> Multi-threaded programs have a similar issue (though with Go it's much
> worse). If you fork a multi-threaded C program then you can only safely
> use AS-Safe glibc functions (those that are safe within a signal
> handler). But if you're just doing three syscalls this shouldn't be as
> big of a problem as Go where you can't even do said syscalls.
>
> > Anyway, it occurs to me that the real problem is that setns() and
> > chroot() are both overkill for this use case.
>
> I agree. My diversion to Go was to explain why it was particularly bad
> for cri-o/rkt/runc/Docker/etc.
>
> > What=E2=80=99s needed is to start your walk from /proc/pid-in-container=
/root,
> > with two twists:
> >
> > 1. Do the walk as though rooted at a directory. This is basically just
> > your AT_THIS_ROOT, but the footgun is avoided because the dirfd you
> > use is from a foreign namespace, and, except for symlinks to absolute
> > paths, no amount of .. racing is going to escape the *namespace*.
>
> This is quite clever and I'll admit I hadn't thought of this. This
> definitely fixes the ".." issue, but as you've said it won't handle
> absolute symlinks (which means userspace has the same races that we
> currently have even if you assume that you have a container process
> already running -- CVE-2018-15664 is one of many examples of this).
>
> (AT_THIS_ROOT using /proc/$container/root would in principle fix all of
> the mentioned issues -- but as I said before I'd like to see whether
> hardening ".." would be enough to solve the escape problem.)

Hmm.  Good point.
