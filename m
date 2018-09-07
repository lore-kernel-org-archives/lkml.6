Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F052077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQG+ILcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F052077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeIGWFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:05:04 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:32812 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeIGWFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:05:03 -0400
Received: by mail-pl1-f170.google.com with SMTP id b30-v6so4599802pla.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DN3m2MP7rDI91Tlof3J+3B82j9mSSJrQY/U2pgTSkGU=;
        b=KQG+ILcSPJMH/J78uUWNQ5ZDaiuHMlUg9+UCAGL4dte0Z97f6vyMqZt1aIPexUc1o8
         imeY9WKd0s+MzoQdP2PwIHIq8vKBuuC2gVnPrtVRwvX4vej2mXNuDvxaMTNcDS9VRZzJ
         Iavds5mJ0CWeKCjqV8pHDI7ov8eFtM+OfYoGRdDZ2rm7aRaXzv6dHMLxEV7pMYtmeoDy
         N6FN3qogMqQgS40BXS2HoQhh97vYyj8ReOkq37tRckW5NwZhrjm6uxsqaQ4UBDKrC2Ji
         E6V9tM5AXd+GTn2fPa7myzfTo8bapG5lrcOZSYhGxiG9leuB5VEaKfZKqEX1ck+iavvf
         JATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DN3m2MP7rDI91Tlof3J+3B82j9mSSJrQY/U2pgTSkGU=;
        b=JgKrYvpX6LcurW6R8gwy2ZhrCzwJ/NKmcTCLl6K9mP7Rv338bpdOazj4k40c6PtZic
         8HzC0JNNtznIZEV92Q3yLaKG1IVzS9P1ZSmJdgA6ErAF5NTUgXQd6a3VZmbsrwfK72TY
         vUHs8G2eLSVe5pKDVeeBXwtGvJMY0QIMkqXczIhm6gbw75JkFbWJmQzaxLUgMb090/xU
         ouyMpaMvNwwftv0ic1MpyvUwHqkX2pM2CL4Ye8hGejpRtKY2mwkeXuQRlnO84T7oGKjK
         D34sVfB9YZogSGhty2lltdHHfh2c3q/qm5zJoxNcZ/IbDrgiey6juE7taNMMShkv6X32
         tT2A==
X-Gm-Message-State: APzg51D6G2ASJdALYITAeWH82Zqsj9taVXplCK6d55Ap5MCdQm9Eix66
        RonRtHG3NxK7i0gSNhR6d6gqWIR43H47+EVZNIII8w==
X-Google-Smtp-Source: ANB0VdbA2lwE4bqF+3sJ3mwfbZtShcXVBrAMyM+B2tjbU1+nqF233AcbANNB6jrTMB7wMY83g0cS9K5n5bMAOgHCDOI=
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr9023918pll.217.1536340987614;
 Fri, 07 Sep 2018 10:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr> <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
In-Reply-To: <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Sep 2018 10:22:56 -0700
Message-ID: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
To:     christophe.leroy@c-s.fr
Cc:     joe@perches.com, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.fr> w=
rote:
>
> Cc linux-sparse@vger.kernel.org
>
> Le 07/09/2018 =C3=A0 14:22, Christophe Leroy a =C3=A9crit :
> > Since commit cafa0010cd51f ("Raise the minimum required gcc version to
> > 4.6"), sparse check fails as follows:
> >
> > [root@pc16082vm linux-powerpc]# make C=3D2 arch/powerpc/kernel/process.=
o
> >    CALL    scripts/checksyscalls.sh
> >    CHECK   scripts/mod/empty.c
> > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > old - please upgrade it.
> >    CHECK   arch/powerpc/kernel/process.c
> > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > old - please upgrade it.
> >
> >
> > I have sparse version 0.5.2
> >
> > What can be done to fix that ?
> >
> > Christophe

Oof, sorry Christophe.  Looks like that's the latest version of sparse:
https://sparse.wiki.kernel.org/index.php/Main_Page#News

I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
__GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
expanding them to something, otherwise you'd have seen the error then,
too.  The previous check was GCC < 3.3, now it's GCC < 4.6.

We could change the check to:

-#if GCC_VERSION < 40600
+#if GCC_VERSION < 40600 && !defined(__CHECKER__)

But it would be good to know what those sub macros that compose
GCC_VERSION evaluate to in sparse; maybe they can be upgraded in
Sparse unless they're matching __builtin_*() compatability?
--=20
Thanks,
~Nick Desaulniers
