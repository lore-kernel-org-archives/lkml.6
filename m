Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C97CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0D6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4VbEsZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0D6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeK0L7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:59:30 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34038 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeK0L73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:59:29 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so543020itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99qsmslrCZHFziv0Q8mZFoLamTN89o/3EFXsZdgoblY=;
        b=H4VbEsZf6piHB3UA9ZCrZn/XSE1dMDWYRfEseEFTu2exikG8jw/BcnnZ6BNYduikuy
         tqVfmFVaHAH9hpd80UvX9YpYAk87NBNnq2gpAUqCwMR/VzIKFJWYqefVWWRX8485dhy+
         s8DPB1l1WORi1yF3vsR1cPlN/6LICYMdGW+rbJBvETmqyEHf0MY/Vr4ZN9OB+d+EtOnP
         RPCSB2uQiwMVHhiqzpQG777dfJz2h6PHvUqmDivkIr1pDBen6eMPWqDlg82vh6EnTBdR
         RHdE8wZQmXNNaJLpZyoL+AeZA3JH3U3RYY3DPBjSmgb7JH7g+mwGdNnpIwbLc6TZCV11
         EaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99qsmslrCZHFziv0Q8mZFoLamTN89o/3EFXsZdgoblY=;
        b=XzLJ/1MdHDpHV6eVzc/J+RJEISKx9BFkzWY0aOT49CGhcPwM/yFQ7OZz8FI8Htf8Gn
         SpJo6KIpIluqJt3GL7BYLY57iTrMnwfTlLwyJ04q9ol3WR5lGnLapFviEEmhJBBtBBhY
         RAIRhpluhKYW2gr6pwtiFgbtK1fMwm9uytyzOk3stYwC1JcU1mWJRMmOy+aCC3Bb9cFm
         2BBL6CLNv756V++dgXsKbzGpLdtGR5z6mankritHYjnhCbE7tSygQ6uuwmEX28xrYZnN
         GD6TcKTvo8ZHnNDqRWFciXn1rV5fYRZVXOsG0sVsTTspW1Hxn6X4jUjMRZ60wOkvrShf
         3vwQ==
X-Gm-Message-State: AA+aEWaslD2FiwxHwCl/Qpp+dMOJO8zXfwxVrEIB76qfuBHP3RwQqNN3
        Q9zHglmYwkd1SGWtM4TzlkiLmL/aIveQHHNEZQ8=
X-Google-Smtp-Source: AFSGD/XclNfSVPaz66EPf3ynwoxEhZ5AZZtDaXliliwlY255IUtmhnNEKsflzt9qE2eiOvG1q0CBotYrvyOobffA7fo=
X-Received: by 2002:a02:5184:: with SMTP id s126mr21216354jaa.12.1543280606391;
 Mon, 26 Nov 2018 17:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20181126145107.31597-1-tiny.windzz@gmail.com> <CAHC9VhSjBTVXAXKiNsgPDJUCsxPnd3DJVA1pjSQqN0ct=RaxJg@mail.gmail.com>
In-Reply-To: <CAHC9VhSjBTVXAXKiNsgPDJUCsxPnd3DJVA1pjSQqN0ct=RaxJg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 27 Nov 2018 09:03:39 +0800
Message-ID: <CAEExFWtbJaCJba7+ttOVw0V6Y7wSJ=8zVzNHKQJHuGuTgqQPYg@mail.gmail.com>
Subject: Re: [PATCH] audit: remove some duplicated includes
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 7:36 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Nov 26, 2018 at 9:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > audit.h and skbuff.h are included twice.It's unnecessary.
> > hence just remove them.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  kernel/audit.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> While there are two header files named audit.h, they are different
> files as one lives in include/linux/audit.h, the other in
> kernel/audit.h.  Granted, kernel/audit.h does include the
> include/linux/audit.h file but it should be protected from multiple
> inclusion by the _LINUX_AUDIT_H_ definition.
>
> I currently prefer to keep both <linux/audit.h> and "audit.h" in
> audit.c to help make the dependencies explicit in audit.c itself.
Hi Paul:

How about fs.h and others?

MBR,
Yangtao
>
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 2a8058764aa6..a677715891d0 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -62,11 +62,8 @@
> >  #include <linux/pid.h>
> >  #include <linux/slab.h>
> >
> > -#include <linux/audit.h>
> > -
> >  #include <net/sock.h>
> >  #include <net/netlink.h>
> > -#include <linux/skbuff.h>
> >  #ifdef CONFIG_SECURITY
> >  #include <linux/security.h>
> >  #endif
> > --
> > 2.17.0
>
> --
> paul moore
> www.paul-moore.com
