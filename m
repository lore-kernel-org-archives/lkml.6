Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39695C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70AF2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRMRJGzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70AF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJJIWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:22:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37424 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJJIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:22:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so3685614oth.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 18:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTAyr4ZX0Mj/6XHpQeHPexF4USINVAuQBvI/Xeu1gPw=;
        b=pRMRJGzFW9q8nRPgWUicZHBMIcahdqJbEIh2bH2op9olN8glKPM6X5sGhEnUcbNPET
         YzL2YDWFGEkH3SsIzUlJ8/J6Otnf6yvxRK62Usxv2uw3dgK8ojl7BJ6sJIgSIiEC4A2l
         WdozftgeQcI3WOCE0S9OsGAGPLpJ4G6wGc6fgG0QG86xDCU+irSAWpbzOjs/pB18+Nf/
         ZB/NQcsXdKX4x7UZnXTnPHrFs8DXpkJGOFfEFDSnUsdmxS5QaUecdgM9U9Zbf1W/blww
         YpRQJIXR5gJm/MKVtlsqE/LHYQ3fKdNadM8kOiaW6jKzV9gdJTXlGamTiUUvAwQqKIV5
         Dojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTAyr4ZX0Mj/6XHpQeHPexF4USINVAuQBvI/Xeu1gPw=;
        b=joOU4me5yI6G2kbGUkwuc2Ld1gLF2bZhym1J9utR7XI1/b3p+h50cuT1O3bfisHoOO
         JmHB3lIveJhJGE+eO1RBAi3Qr/sGLRpA/vdX0W6wbz1InbrxaDoCUMEiJjCw0hq4wkKw
         yIERCIEvys++F6bT3lSYI2OI+rLMrNBOFyupwJPHF0cHiMWddWZ9TbA5XGzTkHTrIYS8
         CTPwRm1oejPmZVJ5aRDR1DhK2hRm+kYxrcYpIX7cHI13w7No+I2mlLkYL7nwzNrj/UrP
         PQWmWWBY1iUc8o2hsxhEwYunUVdxRYeQFtCuOiOdTPDI9iFU0itYZbD9vrdJLcdBEaNB
         VHbw==
X-Gm-Message-State: ABuFfohUj24U/xxNHRahbWSxdTovGbA/NTURFanSDaNJ9Nszb6m7KlDT
        +IhQwEaU4BOLOyIvPY9DmyAwNU+NCzEZ6Zfwpxk=
X-Google-Smtp-Source: ACcGV62quqi3VTVLt7vPrGqotedAeXkmziLj0AqPCeUxuOVRY5JuGUmAptGAVZ8iXzl22jU2KEEpOk8PUBmgRHLELGg=
X-Received: by 2002:a9d:728a:: with SMTP id t10mr8069770otj.172.1539133382201;
 Tue, 09 Oct 2018 18:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230002.GA7572@WindFlash> <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
 <CADvQ+rEagd1PSm-ejA7dSBQgf2MoJ3TMCm+kz-YpsmkVrdGFWg@mail.gmail.com> <CAK7LNAT1Q3fqE-sJSuFUkYDVFpJx2+DKksCcCgN6QU0zHnmcaQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT1Q3fqE-sJSuFUkYDVFpJx2+DKksCcCgN6QU0zHnmcaQ@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Tue, 9 Oct 2018 22:02:50 -0300
Message-ID: <CADvQ+rE3_zOEs9pqhnykbp67+VxXnGfT-XJtJ-Oq0VYXaV4HCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Optimize tests and remove shadowed local variable.
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

Please let me know if it needs any rework!


Leonardo Bras

On Sat, Oct 6, 2018 at 4:50 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Leonardo, David,
>
>
>
> On Fri, Oct 5, 2018 at 11:32 AM Leonardo Bras <leobras.c@gmail.com> wrote=
:
> >
> > Hello David,
> >
> > My name is Leonardo and I am new to kernel development.
> >
> > Is this patch acceptable? Do it need some rework? The change makes sens=
e?
> > Is there a way to better follow the workflow for this patch?
> >
> > Please let me know if it needs anything.
>
>
> I thought David would pick this up,
> but he is not responding.
>
> Now, applied to my kbuild tree.
>
>
> Thanks.
>
> >
> > Best regards,
> >
> > Leonardo Bras
> >
> > On Wed, Sep 19, 2018 at 4:11 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > FW: David Howells
> > >
> > >
> > > 2018-09-19 8:00 GMT+09:00 Leonardo Br=C3=A1s <leobras.c@gmail.com>:
> > > > Removes an unnecessary shadowed local variable (start).
> > > > Optimize test of isdigit:
> > > > - If isalpha returns true, isdigit will return false, so no need to=
 test.
> > > >
> > > > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > >
> > >
> > > This patch was sent to me, but maybe belong to David's field.
> > >
> > > David, will you take care of this patch?
> > >
> > > https://lore.kernel.org/patchwork/patch/988171/
> > >
> > > I think the commit subject should be changed kbuild: -> ASN.1:
> > >
> > >
> > > Anyway, this patch looks trivial,
> > > FWIW
> > >
> > > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  scripts/asn1_compiler.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > > > index c146020fc783..a0056df4e358 100644
> > > > --- a/scripts/asn1_compiler.c
> > > > +++ b/scripts/asn1_compiler.c
> > > > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> > > >
> > > >                         /* Handle string tokens */
> > > >                         if (isalpha(*p)) {
> > > > -                               const char **dir, *start =3D p;
> > > > +                               const char **dir;
> > > >
> > > >                                 /* Can be a directive, type name or=
 element
> > > >                                  * name.  Find the end of the name.
> > > > @@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
> > > >
> > > >                                 tokens[tix++].token_type =3D TOKEN_=
TYPE_NAME;
> > > >                                 continue;
> > > > -                       }
> > > >
> > > > -                       /* Handle numbers */
> > > > -                       if (isdigit(*p)) {
> > > > +                       } else if (isdigit(*p)) {
> > > > +                               /* Handle numbers */
> > > > +
> > > >                                 /* Find the end of the number */
> > > >                                 q =3D p + 1;
> > > >                                 while (q < nl && (isdigit(*q)))
> > > > --
> > > > 2.19.0
> > > >
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada
