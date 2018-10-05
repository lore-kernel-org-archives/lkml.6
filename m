Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7529FC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E842084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLlbeDaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E842084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJEJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:26:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34917 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeJEJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:26:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so11281492otl.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MwZ32FHDFb06cX14HqCqMdNcuvZpEfir/97e6FdgbKE=;
        b=eLlbeDaPuCmlUcH4kDAkwifQ6ozCMyYvWdb7j9MjwPhIMY59hUWfaA4adnoUEu1Wig
         IeXeWgoKGZ8sCdr1PNXSN6Lmhmg0LLgmIN5ET2J461sy5+7XWJTV2OVPvNlH49RT2yus
         TE373TajzYrg5Yr/bL17R1O3ramNAzNbL16IYftbm6S6ws5OTU0APqVLPEDYsCsARLuB
         To7Bt2Stxat69lDlpVNN9DYvhEq8DrNKkY0E/FDPBU0ynru2Yth8LdOyDNE1fKyz9qay
         hEYcSY3xo/N3a6echNWjCwytn9e1+2LSS/jyuuxVo06hhiCkN0WdjqMLwpaiQDGLllhf
         7y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwZ32FHDFb06cX14HqCqMdNcuvZpEfir/97e6FdgbKE=;
        b=ICyf3H+ozb4SKIrtjTOKkwYkQMlWGZurjBEkK1x3mrJABkk7D0hCaF4Yj3cHB+Mfug
         h5yPvPeLGWgiHy+C6uiePAeOYP8zXFNMbO3A4GLiJmvRiu/O7Fu5p7bewCHroBv/C3BO
         MnsIqgutwRTAR3Txvyl9peYHhlNthGivIKPV0VGa9gWXz4pu5J8fARJ2DHXn3A2UqwPL
         D2iKNARJOe2AZ7JYqL765n1BHJTCjlfWZh7HTU1qlE/+uZjIUORPYZbD4R3dT8Vz33Vk
         M/YpFjS/lEpRTM0lftHkp88tPsxteoiJCu8V+avAqldvPTSV+DSiFT0B93reAGxs8n4f
         t9fA==
X-Gm-Message-State: ABuFfohXbnS6Xo1zsM1oYWxA77t2QfDnWw4vQfDj7ScFuHPEt4C20p7s
        4HkqxQnvEtTc9JsuYhclfBl/A85nOLrmQr+ocOE=
X-Google-Smtp-Source: ACcGV61mS3b0xdeBDXKkeepwQFEL+LIT1odjzTh8jRTsIOr6PQVIudqD/iqspdWl/k3zfUtyOTqTOdspxpK+cvdUqQc=
X-Received: by 2002:a9d:63d6:: with SMTP id e22-v6mr5538190otl.233.1538706605551;
 Thu, 04 Oct 2018 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230002.GA7572@WindFlash> <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
In-Reply-To: <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Thu, 4 Oct 2018 23:29:54 -0300
Message-ID: <CADvQ+rEagd1PSm-ejA7dSBQgf2MoJ3TMCm+kz-YpsmkVrdGFWg@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Optimize tests and remove shadowed local variable.
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

My name is Leonardo and I am new to kernel development.

Is this patch acceptable? Do it need some rework? The change makes sense?
Is there a way to better follow the workflow for this patch?

Please let me know if it needs anything.

Best regards,

Leonardo Bras

On Wed, Sep 19, 2018 at 4:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> FW: David Howells
>
>
> 2018-09-19 8:00 GMT+09:00 Leonardo Br=C3=A1s <leobras.c@gmail.com>:
> > Removes an unnecessary shadowed local variable (start).
> > Optimize test of isdigit:
> > - If isalpha returns true, isdigit will return false, so no need to tes=
t.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
>
>
> This patch was sent to me, but maybe belong to David's field.
>
> David, will you take care of this patch?
>
> https://lore.kernel.org/patchwork/patch/988171/
>
> I think the commit subject should be changed kbuild: -> ASN.1:
>
>
> Anyway, this patch looks trivial,
> FWIW
>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
>
>
>
> > ---
> >  scripts/asn1_compiler.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > index c146020fc783..a0056df4e358 100644
> > --- a/scripts/asn1_compiler.c
> > +++ b/scripts/asn1_compiler.c
> > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> >
> >                         /* Handle string tokens */
> >                         if (isalpha(*p)) {
> > -                               const char **dir, *start =3D p;
> > +                               const char **dir;
> >
> >                                 /* Can be a directive, type name or ele=
ment
> >                                  * name.  Find the end of the name.
> > @@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
> >
> >                                 tokens[tix++].token_type =3D TOKEN_TYPE=
_NAME;
> >                                 continue;
> > -                       }
> >
> > -                       /* Handle numbers */
> > -                       if (isdigit(*p)) {
> > +                       } else if (isdigit(*p)) {
> > +                               /* Handle numbers */
> > +
> >                                 /* Find the end of the number */
> >                                 q =3D p + 1;
> >                                 while (q < nl && (isdigit(*q)))
> > --
> > 2.19.0
> >
>
>
>
> --
> Best Regards
> Masahiro Yamada
