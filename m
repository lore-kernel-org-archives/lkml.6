Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537AFECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F4420BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIb54QcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F4420BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbeGLXp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:45:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42783 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbeGLXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:45:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so58987990oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBQSpQTvdl+u4m4TKpfI4N/JrOAqhBXz0NfkmZ5Wu6M=;
        b=VIb54QcGqNJVFNFqZ9KYwFohL37Vh+/4OQF8ufQJwAli7M+5GFBT9uO7FsoYkuE5Ba
         cO6k+RvOg+4zRQkxan1IWHEBtMXJpLpMwNPwvGnEKQmM1NbgCyPxiSWpgOnf322V2fSE
         SDDAhZQALg0Ny4WQ1NQYhMDDrCT0lVtf6QedTMbi8fNWgRkeA0aiPPjWvDQ/EzMwW7Eh
         jCRDoE8MiG+X27NUjniPX4lEb61RNbBUI3L4wHia4CBUATffGlJGTiw+3GQcbOx9J0Ia
         fbcMgcMcG+8NuOIW7PR3D/hhECXkj4/J+y/lWjM+B90RY3c/le3q0wReff11qYwGNFIc
         tyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBQSpQTvdl+u4m4TKpfI4N/JrOAqhBXz0NfkmZ5Wu6M=;
        b=n5A0IHinDYauxtyH1gZ/RxCSMHjMmzoeB2TEtpD1yT+CT8aC6zetmOE/GGFhH3XX5h
         i56Kp3YYXRNZKbX4NFymSlXKVMEjkgFkmQ3fqyxK3nKUwjq8mvElE1333vA+4CPWc5XN
         3DXzQugu6iANQYhueem8dADYNNQ2UB1c02jW4h1XOIuZ2P9TyRIssFfcy1jhLxXJu1YR
         bXWY+bqHevKn9fKKJciothE1OpW/BnAWeuzosFfyV6pqsXnhlKY5ecfwv3O5xJUMBaq/
         j1JoR0ZwmHBrkg3jYxa8aLM2ZseRN08b9EBWymkHINubYb6oAAIlvb5ghjFFKFyC/sm8
         m3Jw==
X-Gm-Message-State: AOUpUlGLKYpZtMO5X9jEFRtCqM4NyAnuYj4N8ETfgyyMyZeTr3ZVRVCh
        Rj9rVgo+OQtT6a3NZsHNj3ZNVGDhynW0GTVdXIzICw==
X-Google-Smtp-Source: AAOMgpdf/gIn2Fj4McfW2g2rKKEAaB0BQFC968muB0mTZ4Rq+hoWm4heppl/7JDA8B1SOWnz6hzK7yx+tlJf8aE3Btg=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr4823763oib.91.1531438445310;
 Thu, 12 Jul 2018 16:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk>
 <20180712223223.GA28610@thunk.org> <22105.1531436081@warthog.procyon.org.uk> <CAG48ez1OF0OfdmnRsV5Ne2mOt-j3Pgf7QRsn3q3Hzjpus9LHGA@mail.gmail.com>
In-Reply-To: <CAG48ez1OF0OfdmnRsV5Ne2mOt-j3Pgf7QRsn3q3Hzjpus9LHGA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Jul 2018 16:33:38 -0700
Message-ID: <CAG48ez1S6Gxtsf8OzH_dhLiPVeH=unsghjGJGL0oOoff+T0iRw@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 4:23 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jul 12, 2018 at 3:54 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > > So maybe the answer is that you open /dev/sda1 and /dev/sda2 and then
> > > pass the file descriptors to the fsopen object?  We can require that
> > > the fd's be opened with O_RDWR and O_EXCL, which has the benefit where
> > > if you have multiple block devices, you know *which* block device had
> > > a problem with being grabbed for an exclusive open.
> >
> > Would that mean then that doing:
> >
> >         mount /dev/sda3 /a
> >         mount /dev/sda3 /b
> >
> > would then fail on the second command because /dev/sda3 is already open
> > exclusively?
>
> Not exactly. mount_bdev() uses FMODE_EXCL, which locks out parallel
> usage *with a different filesystem type*. This is the effect:
>
> # strace -e trace=mount mount -t vfat /dev/loop0 mount
> mount("/dev/loop0", "/home/jannh/tmp/x/mount", "vfat", MS_MGC_VAL, NULL) = 0
> +++ exited with 0 +++
> # strace -e trace=mount mount -t ext4 /dev/loop0 mount
> mount("/dev/loop0", "/home/jannh/tmp/x/mount", "ext4", MS_MGC_VAL,
> NULL) = -1 EBUSY (Device or resource busy)
> mount: /home/jannh/tmp/x/mount: /dev/loop0 already mounted on
> /home/jannh/tmp/x/mount.
> +++ exited with 32 +++
>
> I don't really understand why it's not more strict though...

Er, sorry, of course that's the current behavior, not the behavior of
the suggested API.
