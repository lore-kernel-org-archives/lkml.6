Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BA2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AC42064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiwiZ1u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AC42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeJ3JXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:23:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39664 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJ3JXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:23:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id d5so9473527oti.6;
        Mon, 29 Oct 2018 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgMiwf97ZI4p5/NLhVq1Yrottw+NiO4NeQgUvBUcO+Q=;
        b=JiwiZ1u8XBn/WTKRhD0r2GwUcjazBOxtO929mcY6wZk9uQmBqNSarY/zAuH5U73Nqx
         BvlELZY5ATvw5VC0nbpVex3rtLmT3tdHXt5Hw2s76y3jFO0LPBg4/8DDWCU+dQZHuXGy
         DxOwyNf21mjTQIgfQrf77n4JzDxcS/04A1mK6FH6CBnrwsvXV1kn0xreipn+vPLcG16O
         OqgQucj7LCXp53/4OL1gVG3aqlAm0g4JmyOYAkd18xtkdqcvXQiyi2QSFFK8Jd3jJo6A
         uOoqoYDRFGpTBbe400ookjIVbjfOQrPcRES8iqbAlI21k/bNu6kli9laTcr2hltAtrhd
         3wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgMiwf97ZI4p5/NLhVq1Yrottw+NiO4NeQgUvBUcO+Q=;
        b=EBUsTuJTg0PoQkNaVaoO9wSd7aNnEtaJXATfWjDlGHWuq1LhxzZ1xmIfmqCpbXoQAR
         dYCwKFLTlXD04JeDUYhM24EbUfgghnURq2MgKuFPMb5XlL8AbOCtlN8Hyw/U4nxgAlNL
         MjMCu5nQ4Bqu6UogSImlJmMDCGv22KqXUqq3ys5d+xKg57vPyCs+hazUlyz7KJcdpx4a
         DkzXuTJtzqWebFqoeDDDZhRenZtdBb7jxEM6vu27ZE3rGw2ILZePbKYQud5XXmQrLBvR
         HYMnQxI15iKkrQCXUrYARddNU9auSCNkKHPlshbWDd8+4GYTuf/nOuDAhsXY3vZkH0Yy
         6xaA==
X-Gm-Message-State: AGRZ1gKrKJ+hqaLNpM6GENSovwzwgFTbtMTVLq3Y8+AyW8A3oWYEOvgh
        7PXzs35qpnkguHFGwtiBO81iIEcGhFY3wCHEZYY=
X-Google-Smtp-Source: AJdET5dIJVAxWnw7akSctzt7L1DcOn9AcpLfupYs3/WF8d12b5hMTvaTkAmTGg6JMvOSFsRajFCP8MZE4eRuJuIw7R8=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr10190389otf.178.1540859513045;
 Mon, 29 Oct 2018 17:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181024040354.24879-1-leobras.c@gmail.com> <20181024040354.24879-3-leobras.c@gmail.com>
 <CAK7LNASfo=hw6r6GtdcLdkKCGVFpXUASvSst6WO5tcFbaZ-X0Q@mail.gmail.com>
In-Reply-To: <CAK7LNASfo=hw6r6GtdcLdkKCGVFpXUASvSst6WO5tcFbaZ-X0Q@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Mon, 29 Oct 2018 21:31:41 -0300
Message-ID: <CADvQ+rHLKvjBCBfbeLHrX_2johcAYAef-pNwpgDndv9inmPWww@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kbuild: Removes unnecessary shadowed local variable.
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Helen Koike <helen@koikeco.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I will take care next time.

Thank you,

Leonardo Bras

On Sun, Oct 28, 2018 at 1:37 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Oct 24, 2018 at 1:04 PM Leonardo Bras <leobras.c@gmail.com> wrote:
> >
> > Removes an unnecessary shadowed local variable (start).
> > It was used only once, with the same value it was started before
> > the if block.
> >
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
>
>
>
> Applied to linux-kbuild
> with some fixups in the subject.
>
> Please do not add a period to the end of the subject.
>
>
>
>
>
>
> > ---
> >  scripts/asn1_compiler.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > index c146020fc783..1b28787028d3 100644
> > --- a/scripts/asn1_compiler.c
> > +++ b/scripts/asn1_compiler.c
> > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> >
> >                         /* Handle string tokens */
> >                         if (isalpha(*p)) {
> > -                               const char **dir, *start = p;
> > +                               const char **dir;
> >
> >                                 /* Can be a directive, type name or element
> >                                  * name.  Find the end of the name.
> > --
> > 2.19.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
