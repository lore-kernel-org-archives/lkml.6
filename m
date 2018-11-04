Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEAEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA7D2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 08:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXezUA+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeKDSC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:02:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46643 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKDSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:02:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id x3-v6so5263125lji.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wJBOe9ykzN10ub1Q6jZM79/XZKcvl2LzuFawZIfjP0E=;
        b=FXezUA+stcy4+yzkxYnoNLRITtLauZktxatITpZwcY+1+FUTihXnb1tupGrAbxOlCs
         32qoxzMzk2nj1s3eGu4EPCbRzPgmrkjvltJjmbZJL8py1OQx6SfUkCkndqWI5iwnUJLf
         z3pkXZjmOLJH6VA7SH37tS7SQXcHcc/KW1L5SjOUSX1nAcEBhNbiA1GuGalWTOcmwUJc
         OSP9rUrPxtFGO4hIuaiZkTdmIZLp4+n90Nm/+GQggTJrnt5Rkoi3NjfaJ8pxFoTW4/je
         5F8OBtPgbqTSMRUI/U43/Ap+SaL2SKWFVENbaGzgoDlxAQglDuHgBxPcdyBuz02eZt/p
         PECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJBOe9ykzN10ub1Q6jZM79/XZKcvl2LzuFawZIfjP0E=;
        b=BkBdkkPBTHtVjK8YCoOuWE7Z+CDZ41mM/ZZwsxq0D4QO7PFf+qCWy9TYmS2V2nMzbA
         KMGrwuKBWVrMuVUbFV5bqxpNeQdEv2U7b+qeDXGlr1jZCNsP9432ywW0XImL6WI+QJ2A
         SYIPhLoDc39Vdr8v9sP+onsU3mqW0n22BEKwVd2+yO21ai45kcI/G15Cq5b6hQ6KIqKu
         EQGePiuczU/SXNt7yfbz1ptgxzoYV1U7iamdK/daowOeW959Q52NSz371JGvjm/6gTwI
         wpZP66KHA2puHnCx3rDsVy8Ghl/0c694s7JBsB5H3fz0V+qtW1+hueTGBmhJMPY4qpmg
         W9/Q==
X-Gm-Message-State: AGRZ1gL0e2AyRN3ec4h0AnYiLZWBCwjYCX0Jskx8Q2D3i4OC88yHGcgB
        ClYmqpEevVtyMYASEGF8GHoH7auK7kbAZu88Wnk=
X-Google-Smtp-Source: AJdET5f5OYCKdKO4cIxocK0mFN3R3qMWx0EUMXvxVaafNRbhYiMl4EZrm52GeCn2VLDbdQ1Tkqjo9xYrXFib4/Yn40w=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr9926090ljb.104.1541321324439;
 Sun, 04 Nov 2018 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCeFs0_NS9AZwfw+U60jKU5RRPD56THEhCq_jLJkiFy0=A@mail.gmail.com>
 <20181104075204.GD32577@ZenIV.linux.org.uk>
In-Reply-To: <20181104075204.GD32577@ZenIV.linux.org.uk>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sun, 4 Nov 2018 11:48:33 +0300
Message-ID: <CAE5jQCd4SegNT6fEJGO3i4L4rMEYXuvHBSc36GY7vq5T61MdmA@mail.gmail.com>
Subject: Re: OCFS2: [ocfs2_rename:1688 ERROR: status = -39] with four syscalls
 on fresh FS image
To:     viro@zeniv.linux.org.uk
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, excuse me, looks like it really logs every error to dmesg. And
what about NULL dereferences on corrupted images: should they be
reported at all and if yes, publicly or privately? On one hand, OCFS2
by design operates remote images, on the other hand, these images are
most probably served from some trusted source.

Best regards
Anatoly

=D0=B2=D1=81, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 10:53, Al Vir=
o <viro@zeniv.linux.org.uk>:
>
> On Sun, Nov 04, 2018 at 10:37:34AM +0300, Anatoly Trosinenko wrote:
> > Hello,
> >
> > When fuzzing OCFS2, I got an ERROR message in dmesg output with
> > several syscalls on completely fresh, uncrafted FS image. From this
> > https://oss.oracle.com/pipermail/ocfs2-devel/2012-August/008683.html
> > it looks like ERROR messages are indicating some unexpected conditions
> > in the driver code, is it right? If so, here it how to reproduce it
> > with kvm-xfstests:
> >
> > 1) Checkout latest torvalds/master (tested with commit 71e56028), copy
> > x86_64-config-4.14 from fstests to .config, `make olddefconfig`,
> > enable CONFIG_FS then OCFS2 and compile
> > 2) Create fresh OCFS2 image:
> > $ fallocate -l 256M ocfs2
> > $ mkfs.ocfs2 -L test --fs-features=3Dlocal ./ocfs2
> > $ mv ocfs2 /tmp/kvm-xfstests-$USER/ # mkfs.ocfs2 seems to not operate
> > on tmpfs that can be mounted on /tmp
> > 3) gcc --static ocfs2.c -o /tmp/kvm-xfstests-$USER/repro
> > 4) Inside the ./kvm-xfstests shell
> > root@kvm-xfstests:~# mount /vtmp
> > root@kvm-xfstests:~# mount /vtmp/ocfs2 /mnt
> > [   17.168634] JBD2: Ignoring recovery information on journal
> > [   17.173903] ocfs2: Mounting device (7,0) on (node local, slot 0)
> > with ordered data mode.
> > root@kvm-xfstests:~# /vtmp/repro
> > [   20.597145] (repro,368,1):ocfs2_rename:1688 ERROR: status =3D -39
>
> That would be -ENOTEMPTY...
>
> > root@kvm-xfstests:~#
> >
> > Best regards
> > Anatoly
>
> > #include <sys/stat.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > #include <stdio.h>
> >
> > int main()
> > {
> >   mkdir("/mnt/xyz", 0x700);
> >   mkdir("/mnt/abc", 0x700);
> >   symlink("/mnt", "/mnt/xyz/1");
> >   rename("/mnt/abc", "/mnt/xyz");
>
> ... and this would certainly warrant that - the victim is not empty, inde=
ed.
> AFAICS, ocfs2_rename() yells on _any_ error it's about to return.  Includ=
ing
> -EMLINK, etc.
