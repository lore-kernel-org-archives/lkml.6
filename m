Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBEECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B77621470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/xntCYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B77621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJRIfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:35:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32827 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:35:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id q50so28135009otd.0;
        Wed, 17 Oct 2018 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2PL4hFv0GE0rxeKh7sQXxDq7sromb5wbNNXMy5vuzHs=;
        b=S/xntCYlsnBxx9ryB/NsyXw8/oeDFgHzNVK+lJ++0/5MDJX78G6W/Z3wZRYuLqUggR
         aDHKL7i4ISJx7cVLZETciX4DjXAljjDwESPHkbY1guZe2lErTqPvvYDeO++P3xz0gsgI
         bFrAIyLEMpuwnybAuGFr5s/CIeFCFKPL1eT9eFuNC3PGYu92S5BHDpxT/vLd+N+tzgPS
         ZEfQhV2ZeSOdiXaRcr3QOL/7TlI7gS2nE9cXfMW6h0PkaOPk46QaPY3ZhLUUjgeQ6FFU
         emO45VWYHEpN4gV1pmf12hLTIuwTA0c6HrZtO6gH9I5HD2geF6nXsymX3+o/0XbxluHx
         k9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2PL4hFv0GE0rxeKh7sQXxDq7sromb5wbNNXMy5vuzHs=;
        b=HQwRmoVTkxE84IXN7sQgyyxG9P6q4/6jvbg2OqskLyc8DYYmyP/mRSytlWYj28Q039
         LL7C6YQFGJSnBD0EMRpUU1N1lb1ZyTdgo/5igMk2pzzGuSRYO6z1c8Ow2HQnlsScThT2
         iUQX3+GOHI46qCrT2ymnJxdJsvT3vYnFV6BBP4S6WZZgLOITlYAE0xnrUIUsy35PuVvZ
         yDw7L4ygd2g4y54JDQr9EaT5fy9Jox+S4IRHn0yyWLv2Q1i3+7dFpTNtPijTu/NlisOm
         b9AN7kO+4sGozED2UB9ZcYeH2RuI4696fgpkR7ZWonnsasATXFalCd0xXA5bMEv5NPXT
         7IJw==
X-Gm-Message-State: ABuFfojh0hGnKNHSYfSfQ+Bm3B2PEWFT2pKdmR8BdvgZfbSutw8A5C0Y
        0M4I29ZwhPGN9ErbN2CYizWg9gHrVqK0Y0JbIm0=
X-Google-Smtp-Source: ACcGV60wK2GlJAtKjrrhDq/F4nTMgUrY2dHq23I+QsS2sJjl8gjSc+d2iweWHHphjHR+rqktxVUwMQzeIXNVqBlMK/A=
X-Received: by 2002:a9d:2568:: with SMTP id j37mr19054980otd.263.1539823010099;
 Wed, 17 Oct 2018 17:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
In-Reply-To: <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 21:36:38 -0300
Message-ID: <CADvQ+rGVLG85p82O-joY6yU4maMdP0RsyJr-JGPNCrfjy4-WbA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Borislav Petkov <bp@alien8.de>, lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Oct 17, 2018 at 5:11 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Oct 16, 2018 at 09:08:09PM -0300, Leonardo Br=C3=A1s wrote:
> > > Adds -Wshadow=3Dlocal on KBUILD_HOSTCFLAGS to show shadow warnings
> > > on tools built for HOST.
> > >
> > > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > > ---
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index e8b599b4dcde..fb0a9ac195e7 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -360,7 +360,7 @@ HOST_LFS_LIBS :=3D $(shell getconf LFS_LIBS 2>/de=
v/null)
> > >
> > >  HOSTCC       =3D gcc
> > >  HOSTCXX      =3D g++
> > > -KBUILD_HOSTCFLAGS   :=3D -Wall -Wmissing-prototypes -Wstrict-prototy=
pes -O2 \
> > > +KBUILD_HOSTCFLAGS   :=3D -Wall -Wshadow=3Dlocal -Wmissing-prototypes=
 -Wstrict-prototypes -O2 \
> > >               -fomit-frame-pointer -std=3Dgnu89 $(HOST_LFS_CFLAGS) \
> > >               $(HOSTCFLAGS)
> > >  KBUILD_HOSTCXXFLAGS :=3D -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> > > --
> >
> > You might wanna take a look at scripts/Makefile.extrawarn which already
> > has -Wshadow.
>
>
> scripts/Makefile.extrawarn provides options for the target compiler (CC),
> whereas this patch adds -Wshadow=3Dlocal for the host compiler (HOSTCC).
>
>


Thanks for helping, :)

Leonardo Bras

>
> --
> Best Regards
> Masahiro Yamada
