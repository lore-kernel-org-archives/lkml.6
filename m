Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3016C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592382075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5gHjLow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592382075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIGXCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:02:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43917 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeIGXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:02:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so7391230pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ah/IXBtsPqyXc/A/5h4gYXA4k7N1ClLAggpfhEb5ZAA=;
        b=c5gHjLow8NYz2uUqKC0XT26sGc7Guh4ZTmn1v9nQgYtMTierK0gArOsIDXxWUpYFCu
         2duRaZcPWwKdZnLac1uDUagfTw/k5Q/GFKUXNi9YhLG/RQl8Nl0947IJ2y8nm7/+uaFc
         SNo9X6SrV66C/zlRohaqDLokQ0o4xFuxTqwnFtsMZFiZNlAkdcEWVFz3ck0v22AqSQzU
         JApZP/vnMqhDfSeLMW5RMAXiX/RqzvMWTZUhOvJOTsC/0Hzv68HaxRV1K8PcCWm1opmM
         Y0yM61IJ1IJhDFqcAhUZLbg+6MfclF/v/M4RUX7GpLEx+td7HULCcb9JwHYCRO2b1Fxv
         RciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ah/IXBtsPqyXc/A/5h4gYXA4k7N1ClLAggpfhEb5ZAA=;
        b=ALUe6f4UKkjlaMdugYfyXfP0rcbrAizQtrAxyVo7PcsQ4kMF3SR4Ze2U0xbpNlNaME
         TfnByV7uiCVM/huAAX5DyRnkpXqsNrmVK1K9xKfTHu4buAdhXHLGK46SqvuRP61nnVdw
         9gaf2cLw5CQy2AwdmRmJAWTzU30IXymMCuZra3LaA1sXcJanaKTAOYtHfL8n60AsdG4N
         akKmPvkBIOiRW5tcL1EBBUCRLcEK6T6VEFIOpxfR1T/Z7FZaPaCaXlyN5sAR65+yq+R4
         ehuXfH08tF1vfqB1shwjIL/1uIe8txtxSNzBLSwoe9uc0z1UfSgZExkK6srS1rfOpldb
         FgoA==
X-Gm-Message-State: APzg51Cgzskn/xTZHIXuwfobWCIY3fpELfREN9tyI5vt16HcqQ/zW8WA
        lB8vTC5c4s3bNqVhHzUAAEttqzydgYrtUHXYfUDQSQ==
X-Google-Smtp-Source: ANB0VdY5gH8rhMREvU7TpzSwC7/kgWUMAUoXIDTYBsMvro+Z1MRpZf5jSgVIPOwuPbQWyzNE/dLGWdtyczsZu4uOLVw=
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr9816586pfy.227.1536344394424;
 Fri, 07 Sep 2018 11:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr> <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com> <20180907181337.peyfq7yvhahduvmq@ltop.local>
In-Reply-To: <20180907181337.peyfq7yvhahduvmq@ltop.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Sep 2018 11:19:43 -0700
Message-ID: <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     christophe.leroy@c-s.fr, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Sep 07, 2018 at 10:22:56AM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.f=
r> wrote:
> > >
> > > Cc linux-sparse@vger.kernel.org
> > >
> > > Le 07/09/2018 =C3=A0 14:22, Christophe Leroy a =C3=A9crit :
> > > > Since commit cafa0010cd51f ("Raise the minimum required gcc version=
 to
> > > > 4.6"), sparse check fails as follows:
> > > >
> > > > [root@pc16082vm linux-powerpc]# make C=3D2 arch/powerpc/kernel/proc=
ess.o
> > > >    CALL    scripts/checksyscalls.sh
> > > >    CHECK   scripts/mod/empty.c
> > > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is=
 too
> > > > old - please upgrade it.
> > > >    CHECK   arch/powerpc/kernel/process.c
> > > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is=
 too
> > > > old - please upgrade it.
> > > >
> > > >
> > > > I have sparse version 0.5.2
> > > >
> > > > What can be done to fix that ?
> > > >
> > > > Christophe
> >
> > Oof, sorry Christophe.  Looks like that's the latest version of sparse:
> > https://sparse.wiki.kernel.org/index.php/Main_Page#News
> >
> > I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
> > __GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
> > expanding them to something, otherwise you'd have seen the error then,
> > too.  The previous check was GCC < 3.3, now it's GCC < 4.6.
>
> Sparse expand these macros to the same version than the compiler used
> to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> using an old compiler.

So Christophe must have a version of gcc < 4.6 installed somewhere?
Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
point to an old version of gcc maybe?

>
> Also, it's worth to look at what is said in this email:
>   https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNa=
yWiaZuqoA@mail.gmail.com/
>
>
> -- Luc



--=20
Thanks,
~Nick Desaulniers
