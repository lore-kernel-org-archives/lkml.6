Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A3FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637AD2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DyB0awdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637AD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeK1JS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:18:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38091 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:18:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so21564368lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFx87BZ6vGlQp3CLUSNVyMf+P9onHO0tpwE5bTrRCGI=;
        b=DyB0awdvQd2Z9Gg0namguZxnH5cEKk+HQAAbhcaDjI5oj1FtHmPO3YoitnNZ4Ls82/
         uTBuYObUNt941ro7QlwaLSk3qOLrrnK3NAHZowBN3MJJ4dv7Kbks144Rfw4w8GiJezdI
         Wzip24Xoeuh1TnQ6OtrXxs1/vARvjGzUVc/W8d5Zmpv8NKzYUxv2VVl8X+3e/OibavXJ
         FZAKmLU0dJ6G8L3dkrl5aE0dDPcOSCtP8c4NkWFsoC9gNREY5dTyKkWWqDoh8vswkpWD
         7BNwVIadNJaluzel1jCGxyqs6SipbxGzjJHO1BFP5g7ZHBNKyma2rgMkJb4BTzFfRG6p
         jEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFx87BZ6vGlQp3CLUSNVyMf+P9onHO0tpwE5bTrRCGI=;
        b=sIs+nb52fKu+aO66W3w2naSQwIoO/nLapaML1OCdJ44SBPo9QcIzahid63TWZZ80qJ
         D/w4xvy9COgqCi3JN5fLasIYMtMkM5CuKQbbO/o7oWJsEE7woRPVEnPIBg0kRNQON7t7
         IYWov71+baYaap7jaY52Th3oPXeOmCjRi0H4RgqYEYtkUytDV+MJ9NbTWGHu1o4v+cX9
         IezWz6XNw5CxkH+QraIcMrJILehsg/JJRysABuiUd/Od8vBQEwlWgRXDPvDLCl+1ZdDY
         TgoiVoNVwNwpv3ifu8Pnd+8gPccBNbkbtxf1aUBNpyCnyuNE8Trk+SsmVJlD+JUTXOiG
         lCew==
X-Gm-Message-State: AA+aEWbFJHIPDIV5x77XO+C+f+tm94PZOvXDIGFeE6WN8p/+dxJjjTMs
        mInWEEaNG/z2wgEMMgU/CkCpkMLcDFhTBFLHIS66
X-Google-Smtp-Source: AFSGD/VD508bSvnIAZYfJJ3O58NMMg7sRDzGdMLOYviZMk+D7SfbCgld+FBALdXSJzpNYrXRweyl+PGGxmV453Soy58=
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr22950253ljj.18.1543357174900;
 Tue, 27 Nov 2018 14:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20181126145107.31597-1-tiny.windzz@gmail.com> <CAHC9VhSjBTVXAXKiNsgPDJUCsxPnd3DJVA1pjSQqN0ct=RaxJg@mail.gmail.com>
 <CAEExFWtbJaCJba7+ttOVw0V6Y7wSJ=8zVzNHKQJHuGuTgqQPYg@mail.gmail.com>
In-Reply-To: <CAEExFWtbJaCJba7+ttOVw0V6Y7wSJ=8zVzNHKQJHuGuTgqQPYg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Nov 2018 17:19:23 -0500
Message-ID: <CAHC9VhQum61v-AKzOo-hNCny9s5-=cDqkFN++gq+hH3pYGMBeQ@mail.gmail.com>
Subject: Re: [PATCH] audit: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 8:03 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> On Tue, Nov 27, 2018 at 7:36 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 26, 2018 at 9:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > audit.h and skbuff.h are included twice.It's unnecessary.
> > > hence just remove them.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  kernel/audit.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> >
> > While there are two header files named audit.h, they are different
> > files as one lives in include/linux/audit.h, the other in
> > kernel/audit.h.  Granted, kernel/audit.h does include the
> > include/linux/audit.h file but it should be protected from multiple
> > inclusion by the _LINUX_AUDIT_H_ definition.
> >
> > I currently prefer to keep both <linux/audit.h> and "audit.h" in
> > audit.c to help make the dependencies explicit in audit.c itself.
> Hi Paul:
>
> How about fs.h and others?

In the case of linux/fs.h, I believe that you wanted to remove it
because we are already including linux/fsnotify_backend.h (or
similar), yes?  In that case I think it comes down to a similar idea:
keep linux/fs.h when we are directly referencing a function, variable,
etc. that is declared in linux/fs.h.  Needless to say, I would take
the same position with other header files.

If you can find a case where we are not making any direct references
to something in a header file, I'm happy to merge a patch which
removes that include.

-- 
paul moore
www.paul-moore.com
