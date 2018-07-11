Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5B208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srcZ17tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C5B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeGKBQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:16:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39331 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeGKBQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:16:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so46233147oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UXLbQRPf1xMNXiUnB+N/Yq9SN0t779PNOEWQkJqyQTs=;
        b=srcZ17tfjIVRYQbHNpJK/02lwvg07G0H2HQkjsz6jM6NSL/MObovPXJLAGVT6o4ELf
         QUohpZznnobrLB5pml432lLsv5xK428niXd0w1dUpTWMcXMMMtKhkyW2R3rMy/epabJh
         jBhfAzivzYOTXSOYoj80hH7D9fJ6uqhp9Z4db2AstCbuTeOZc4KP/f3vTkwkyJ0euQY0
         Ul300WMGN2Y5VwiCFM7ZdIeBDUPNqK17vj9BfZip3uqS9l46AS332/PmtEmTzDPGUV48
         eW1xl64Wl2czb3T3SPuz+4wCztArWRgmfkReHQ6bgHT32/8WgSTUUZzKsXt5K+ZAB11B
         v8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UXLbQRPf1xMNXiUnB+N/Yq9SN0t779PNOEWQkJqyQTs=;
        b=Ktrev1Y796Ts4tsZA+he/FmxFfZPM5x1ZE7uMXcvMi50KvnfjyUGknwFnfJNzyOboU
         8p76PjCw/VQA/px6cxpv0+uOdP2pxhue9x9PbIMfj0hL8vMaikcLbno2aaQiPsrtXCvf
         FZPkCBnhaEqXmfj2zd7/ERcYRCA2sVNFPBxny3o2IqyyEVUkSljJJT9QOjRm64yL7Qcm
         im/lqto2dxe8sYmlAWFDOxPutwik0Ai80aZam9M2DrQUynbe9WrVEHYFfvuBb+olhAvi
         ojymy1TGZHuHy78ZjAWRLgIAWelxLQNmSvwItjIAN480ZGLrX/Uiitm+0o0Tj66bLJp7
         nlHA==
X-Gm-Message-State: APt69E02b0Wt87YIg/+cSNH3D1qBhSvN0Q7Sm37biiNPl/toQbOkhodp
        mnWOMgCRk7nLO9AA6yBeKcFE4xQ2iOzLbzK9QEKF2w==
X-Google-Smtp-Source: AAOMgpeR2LL0DBdMMPOruawQtqPVCSMrcEJRcgw8FAhkP1ig/5Yaca1ZQQ3i0diI4jN5JV1kTPDEvWLDq3Ju0wTUD80=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr32117190oib.91.1531271676749;
 Tue, 10 Jul 2018 18:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
In-Reply-To: <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Jul 2018 18:14:10 -0700
Message-ID: <CAG48ez2-p=jGZwmb3soh87RM6qHGEi6ctbLOVZ99LG6aHXUX_g@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:59 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> [cc Jann - you love this stuff]
>
> > On Jul 10, 2018, at 3:44 PM, David Howells <dhowells@redhat.com> wrote:
> >
> > Provide an fsopen() system call that starts the process of preparing to
> > create a superblock that will then be mountable, using an fd as a conte=
xt
> > handle.  fsopen() is given the name of the filesystem that will be used=
:
> >
> >    int mfd =3D fsopen(const char *fsname, unsigned int flags);
>
> This is great in principle, but I think you=E2=80=99re seriously playing =
with fire with the API.
>
> >
> > where flags can be 0 or FSOPEN_CLOEXEC.
> >
> > For example:
> >
> >    sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> >    write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
>
> Imagine some malicious program passes sfd as stdout to a setuid program. =
That program gets persuaded to write =E2=80=9Cs /etc/shadow=E2=80=9D.  What=
 happens?  You=E2=80=99re okay as long as *every single fs* gets it right, =
but that=E2=80=99s asking a lot.
>
> >    write(sfd, "o noatime");
> >    write(sfd, "o acl");
> >    write(sfd, "o user_attr");
> >    write(sfd, "o iversion");
> >    write(sfd, "o ");
> >    write(sfd, "r /my/container"); // root inside the fs
> >    write(sfd, "x create"); // create the superblock
>
> From cursory inspection of a bunch of the code, I think the expectation i=
s that the actual device access happens in the =E2=80=9Cx=E2=80=9D action. =
This is not okay. You can=E2=80=99t do this kind of thing in a write() hand=
ler, unless you somehow make every single access using f_cred, which is a r=
eal pain.
>
> I think the right solution is one of:
>
> (a) Pass a netlink-formatted blob to fsopen() and do the whole thing in o=
ne syscall. I don=E2=80=99t mean using netlink sockets =E2=80=94 just the n=
lattr format.  Or you could use a different format. The part that matters i=
s using just one syscall to do the whole thing.
>
> (b) Keep the current structure but use a new syscall instead of write().
>
> (c) Keep using write() but literally just buffer the data. Then have a ne=
w syscall to commit it.  In other words, replace =E2=80=9Cx=E2=80=9D with a=
 syscall and call all the fs_context_operations helpers in that context ins=
tead of from write().

I also love ioctls, so I think you could also use an ioctl to do the
commit? You can do anything (well, almost anything) that you can do in
syscall context in ioctl context, too; and when you already have a
file descriptor of a specific type that you want to perform an
operation on, an ioctl works just fine.
