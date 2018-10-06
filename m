Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BEECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F334208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dP63m7c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F334208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJGCzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:55:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26297 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJGCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:55:25 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w96JoOZ2011649
        for <linux-kernel@vger.kernel.org>; Sun, 7 Oct 2018 04:50:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w96JoOZ2011649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538855424;
        bh=Prl2vx9T9vHpiNlVuotNMkHoYOpEY+5NWBodqmnJ5cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dP63m7c1oN0P+92HXB/5oVPWKJY3vMXHPgId6wc5SGCrKOsCEtTavv3qu7PL9Boy/
         421Dc1sGCBrJr0GWN7Geb/CmZjBWhf6iYumuiy6KA/lhGEqeJDjgO1TUWmwfC/1mVj
         21ptWGlETu3ybiRaBB0R4F+EMyT48SRFbIVQ5VP9lLWCJ5z6XGnWCmJlHTHzGqMXKn
         FG2C30MMbKlGURH787wjK5ENg5+Bu697E2pQYDcpZeAA/wIOlPlIGyx3XheXGGsuk/
         eVtYD32vXFrDGS03qZNh1GiUwaDhu7Qu4vBeeJAShmXH7RnJIDofx7ZKiPRMYmX3YG
         0xytzgaO0Cofw==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id r15-v6so5890596uao.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 12:50:24 -0700 (PDT)
X-Gm-Message-State: ABuFfog1HdQGNlsntcyllKb9DRrw0IkHdsLFHpPGtd2jlU+TyvPjIuiV
        h6eehKRBX8S44a7P+TuuFg7PfCyZgHOcPp5NNZo=
X-Google-Smtp-Source: ACcGV60VxwDIkd7HRIOf3YrVxZHKRSKNmCxJQTBj/Bw1H6MQwUmj7QD0bQJwije3HQMEGqw3FHtfWRFgfiNZznWN2Tw=
X-Received: by 2002:a9f:3826:: with SMTP id p35-v6mr6352866uad.42.1538855423472;
 Sat, 06 Oct 2018 12:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230002.GA7572@WindFlash> <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
 <CADvQ+rEagd1PSm-ejA7dSBQgf2MoJ3TMCm+kz-YpsmkVrdGFWg@mail.gmail.com>
In-Reply-To: <CADvQ+rEagd1PSm-ejA7dSBQgf2MoJ3TMCm+kz-YpsmkVrdGFWg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Oct 2018 04:49:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1Q3fqE-sJSuFUkYDVFpJx2+DKksCcCgN6QU0zHnmcaQ@mail.gmail.com>
Message-ID: <CAK7LNAT1Q3fqE-sJSuFUkYDVFpJx2+DKksCcCgN6QU0zHnmcaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Optimize tests and remove shadowed local variable.
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo, David,



On Fri, Oct 5, 2018 at 11:32 AM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Hello David,
>
> My name is Leonardo and I am new to kernel development.
>
> Is this patch acceptable? Do it need some rework? The change makes sense?
> Is there a way to better follow the workflow for this patch?
>
> Please let me know if it needs anything.


I thought David would pick this up,
but he is not responding.

Now, applied to my kbuild tree.


Thanks.

>
> Best regards,
>
> Leonardo Bras
>
> On Wed, Sep 19, 2018 at 4:11 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > FW: David Howells
> >
> >
> > 2018-09-19 8:00 GMT+09:00 Leonardo Br=C3=A1s <leobras.c@gmail.com>:
> > > Removes an unnecessary shadowed local variable (start).
> > > Optimize test of isdigit:
> > > - If isalpha returns true, isdigit will return false, so no need to t=
est.
> > >
> > > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> >
> >
> > This patch was sent to me, but maybe belong to David's field.
> >
> > David, will you take care of this patch?
> >
> > https://lore.kernel.org/patchwork/patch/988171/
> >
> > I think the commit subject should be changed kbuild: -> ASN.1:
> >
> >
> > Anyway, this patch looks trivial,
> > FWIW
> >
> > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> >
> >
> >
> >
> > > ---
> > >  scripts/asn1_compiler.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > > index c146020fc783..a0056df4e358 100644
> > > --- a/scripts/asn1_compiler.c
> > > +++ b/scripts/asn1_compiler.c
> > > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> > >
> > >                         /* Handle string tokens */
> > >                         if (isalpha(*p)) {
> > > -                               const char **dir, *start =3D p;
> > > +                               const char **dir;
> > >
> > >                                 /* Can be a directive, type name or e=
lement
> > >                                  * name.  Find the end of the name.
> > > @@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
> > >
> > >                                 tokens[tix++].token_type =3D TOKEN_TY=
PE_NAME;
> > >                                 continue;
> > > -                       }
> > >
> > > -                       /* Handle numbers */
> > > -                       if (isdigit(*p)) {
> > > +                       } else if (isdigit(*p)) {
> > > +                               /* Handle numbers */
> > > +
> > >                                 /* Find the end of the number */
> > >                                 q =3D p + 1;
> > >                                 while (q < nl && (isdigit(*q)))
> > > --
> > > 2.19.0
> > >
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
