Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A8C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270E22064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPd6TYoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270E22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ3JX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:23:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41605 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJ3JX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:23:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so9456690otb.8;
        Mon, 29 Oct 2018 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2JkJKlN+UGaVyqKcPlrnc3ALtjUNlaFk4LeAqM69eqI=;
        b=NPd6TYoMCGHn/BhTT+mkFlkrqo+94FOxbcxXHQ2J3Z/Yyto3XND7dBC7FnFvV4j3Vd
         iP+ix5fMfSXwS9jAAnkYWMYiV3LYBW2vi3egXYPeXmmT4GKS+WosXs1FDa/i4OeFXbN0
         tYQF7uRYLTljBtKOOnUBr4KhSMV83DMFf8kB5HAv5WygJ+RC4sGxcUUAAuiB3cHMXBxC
         trC64HnXZIpiBEpRz+Bl5RYdITg6rr4YNla1wHcmscHZfgq6gG/aEK5tj42b+n+2udtA
         40Sla1CHf6y24iHHI5ts5KS1sheI4OohuwrN0jdZEwNRvTbQiDWuRNH29h4Sw6G8SOAw
         FAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2JkJKlN+UGaVyqKcPlrnc3ALtjUNlaFk4LeAqM69eqI=;
        b=kYGB1OvgNh/49JSRct+aPt7bUg9pZZbd/h0HB7M0oHwCzuLj9232oHdW6DMDkpcLm7
         zWEAfm2wTIOPl0Az/k26uY5TQ5pqkdSu8oF4RpTLXyV3jZtejgIyrjNU3oO8kvkEIQtO
         daDP4y51udRfwAtSRjS+tf1mHWgOVjFc6Kx/PeqWViunDo3zHjneCNYZyGQ4TpyusfO2
         AqKYHchd3nAdcfB6SS8sUSZDyz+2NmPWMM5ehPPgeU6aBLdqkE7aJis2wtKhuFpAp3Xj
         J+NX8mGRD9V4p9Snb0L5X533ekZ9KcKwATy3A4aq+NBB52CpBkvq1bHOORKPIlX/k++z
         NlTQ==
X-Gm-Message-State: AGRZ1gJwt4Ll2atBPi1bsq7dedLXBScf7j6sXsInUSwT53uxFgLgjjAf
        SUS7IdOIQNbu3aBnu5yNQJ6Mna1A97VZDS0sMW8=
X-Google-Smtp-Source: AJdET5cMV0kFZyg1nMIlYfOJiKbJdl0OjvVeGz8Qo3WKnw6IxnBsgmgHcZgWC37pksAWL+hca0cLwC1Fnnow304gQJ8=
X-Received: by 2002:a9d:2339:: with SMTP id j54mr3993239otb.263.1540859536786;
 Mon, 29 Oct 2018 17:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181023011042.GA6582@WindFlash> <CAK7LNAT4uJiR8Nm1agBQwjGFDY81_7O0o6fxuqh=55WizwvhYQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT4uJiR8Nm1agBQwjGFDY81_7O0o6fxuqh=55WizwvhYQ@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Mon, 29 Oct 2018 21:32:05 -0300
Message-ID: <CADvQ+rGyM3-K8ggHzJ7883wd8=04U3QkBD=R=HYg=gbcDgk_Ng@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Creates macro to avoid variable shadowing
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Helen Koike <helen@koikeco.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!
On Sun, Oct 28, 2018 at 1:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Oct 23, 2018 at 10:11 AM Leonardo Br=C3=A1s <leobras.c@gmail.com>=
 wrote:
> >
> > Creates DEF_FIELD_ADDR_VAR as a more generic version of the DEF_FIELD_A=
DD
> > macro, allowing usage of a variable name other than the struct element =
name.
> > Also, sets DEF_FIELD_ADDR as a specific usage of DEF_FILD_ADDR_VAR in w=
hich
> > the var name is the same as the struct element name.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
>
>
> Applied to linux-kbuild.
>
>
>
> >  scripts/mod/file2alias.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 7be43697ff84..3015c0bdecb2 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -95,12 +95,20 @@ extern struct devtable *__start___devtable[], *__st=
op___devtable[];
> >   */
> >  #define DEF_FIELD(m, devid, f) \
> >         typeof(((struct devid *)0)->f) f =3D TO_NATIVE(*(typeof(f) *)((=
m) + OFF_##devid##_##f))
> > +
> > +/* Define a variable v that holds the address of field f of struct dev=
id
> > + * based at address m.  Due to the way typeof works, for a field of ty=
pe
> > + * T[N] the variable has type T(*)[N], _not_ T*.
> > + */
> > +#define DEF_FIELD_ADDR_VAR(m, devid, f, v) \
> > +       typeof(((struct devid *)0)->f) *v =3D ((m) + OFF_##devid##_##f)
> > +
> >  /* Define a variable f that holds the address of field f of struct dev=
id
> >   * based at address m.  Due to the way typeof works, for a field of ty=
pe
> >   * T[N] the variable has type T(*)[N], _not_ T*.
> >   */
> >  #define DEF_FIELD_ADDR(m, devid, f) \
> > -       typeof(((struct devid *)0)->f) *f =3D ((m) + OFF_##devid##_##f)
> > +       DEF_FIELD_ADDR_VAR(m, devid, f, f)
> >
> >  /* Add a table entry.  We test function type matches while we're here.=
 */
> >  #define ADD_TO_DEVTABLE(device_id, type, function) \
> > @@ -641,25 +649,27 @@ static void do_pnp_card_entries(void *symval, uns=
igned long size,
> >         unsigned int i;
> >
> >         device_id_check(mod->name, "pnp", size, id_size, symval);
> > +       DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
> > +       typeof(devs) devs_last;
> >
> >         for (i =3D 0; i < count; i++) {
> >                 unsigned int j;
> > -               DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, =
devs);
> > +               devs_last =3D devs + i * id_size;
> >
> >                 for (j =3D 0; j < PNP_MAX_DEVICES; j++) {
> > -                       const char *id =3D (char *)(*devs)[j].id;
> > -                       int i2, j2;
> > +                       const char *id =3D (char *)(*devs_last)[j].id;
> > +                       int j2;
> >                         int dup =3D 0;
> >
> >                         if (!id[0])
> >                                 break;
> >
> >                         /* find duplicate, already added value */
> > -                       for (i2 =3D 0; i2 < i && !dup; i2++) {
> > -                               DEF_FIELD_ADDR(symval + i2*id_size, pnp=
_card_device_id, devs);
> > +                       while ((devs_last -=3D id_size) >=3D devs && !d=
up) {
> >
> >                                 for (j2 =3D 0; j2 < PNP_MAX_DEVICES; j2=
++) {
> > -                                       const char *id2 =3D (char *)(*d=
evs)[j2].id;
> > +                                       const char *id2 =3D
> > +                                               (char *)(*devs_last)[j2=
].id;
> >
> >                                         if (!id2[0])
> >                                                 break;
> > --
> > 2.19.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
