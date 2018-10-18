Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89305ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DC72083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8wlDWgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DC72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJRKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:02:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39105 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeJRKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:02:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id l58so28256217otd.6;
        Wed, 17 Oct 2018 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bt/X4wsqITjm6ohSB27MNgPC9TagVEYi42wOl852drw=;
        b=s8wlDWggG7AWd9H2GCj06G/U9Ui6XFn6/zIqS8TLwgzW7lxLQjtSIHDRQ6dQcORU0A
         yBfjWDllIHCuxbUCa0tlQUBfpRknOkqL+J7+RIfqmIhds4bqarqpEmItV0xEuvoqbxxU
         YXYroJOHqp0ZpUZ2bjdMishqHdWr7o50dItu8YI8SbKZqHbBDLYBeiQKaEuxyVdH0tiS
         GWoEaxzCa8Db9g95Xak+t2L3PuvBhLrafE2rsp7h47z+e5JWZVyp/sciZ7p5VjzbqQIH
         LK+hVLmx8jmd5FOFeRdb14YkDfhdDRI0lzwQcaXG9i9pNh/iPCtdwEzXbuivfk3DQEFj
         OOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bt/X4wsqITjm6ohSB27MNgPC9TagVEYi42wOl852drw=;
        b=nVlwKmLjvxoKsY+I+mZEWkbpFitYIc9aoYw2m6HHHUyzNZdCTkzBL9a8jA6DmClOlW
         hpBkyAGN97oXIKdL/sX+15QBG867+uHZ7nvyMIeimt2Rx9uWqFCEU3+exHRy2j5qncKX
         s4ERzD6/svR0+YeNEYbfmpb8G1qOgt8/6FZri7kzX0IqD6tPE0VEHBgNY80YUzQ5yUSn
         Fh50iOO6pD070iINcmZbkZVZ56Cajp5JJzKigdMTELvZuZN49vcoyEkrDL7P6PmTD8QR
         ghZlBj8e8RMopb13gxJMigTs12llmu4M20YUXeWLx12uRPAXlcpFwXIc+UNSBVAtyuyp
         zkAg==
X-Gm-Message-State: ABuFfoih0aS29zGAAM5yo6YrJHDOwZ0f2oYqxrC6elpvtp6KpPHl8o0M
        o6y9nHQC9RHXcfsvq6z5ZE5PxElkEaovOphO5xM=
X-Google-Smtp-Source: ACcGV63mEA7IUxkI5lj/F6VUUkNxyLtt1zuqIaHtQPZ/0BEi1q9EEZhPKmXodtKXCb7kxt7PX+iGUBIAvQYoSPdPy4k=
X-Received: by 2002:a9d:948:: with SMTP id 66mr18657431otp.178.1539828237609;
 Wed, 17 Oct 2018 19:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000912.GA21339@WindFlash> <d3185020-b1aa-3eeb-b8e7-ecaefd624236@koikeco.de>
In-Reply-To: <d3185020-b1aa-3eeb-b8e7-ecaefd624236@koikeco.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 23:03:46 -0300
Message-ID: <CADvQ+rGwns4nFjA8wMRC-mY69_Rr8wwdM8dezx0vpdjUymKqSQ@mail.gmail.com>
Subject: Re: [Lkcamp] [PATCH 3/4] kbuild: Removes unnecessary shadowed local
 variable and optimize testing.
To:     helen@koikeco.de
Cc:     lkcamp@lists.libreplanetbr.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen,

On Wed, Oct 17, 2018 at 12:06 AM Helen Koike <helen@koikeco.de> wrote:
>
> Hi Leonardo,
>
> On 10/16/18 9:09 PM, Leonardo Br=C3=A1s wrote:
> >     Removes an unnecessary shadowed local variable (start).
> >     Optimize test of isdigit:
> >     - If isalpha returns true, isdigit will return false, so no need to=
 test.
>
> This patch does two different things, it should be in two separated patch=
es.
Sure, no problem.

>
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  scripts/asn1_compiler.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > index c146020fc783..08bb6e5fd6ad 100644
> > --- a/scripts/asn1_compiler.c
> > +++ b/scripts/asn1_compiler.c
> > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> >
> >                       /* Handle string tokens */
> >                       if (isalpha(*p)) {
> > -                             const char **dir, *start =3D p;
> > +                             const char **dir;
> >
> >                               /* Can be a directive, type name or eleme=
nt
> >                                * name.  Find the end of the name.
> > @@ -454,10 +454,9 @@ static void tokenise(char *buffer, char *end)
> >
> >                               tokens[tix++].token_type =3D TOKEN_TYPE_N=
AME;
> >                               continue;
> > -                     }
> > +                     } else if (isdigit(*p)) {
> > +                             /* Handle numbers */
>
> Actually you can't do that, p is being altered in the first if statement.

Yeah, you are right. I will remove this logic for v2.

>
> >
> > -                     /* Handle numbers */
> > -                     if (isdigit(*p)) {
> >                               /* Find the end of the number */
> >                               q =3D p + 1;
> >                               while (q < nl && (isdigit(*q)))
> >
>
> Regards
> Helen

Thanks!

Leonardo Br=C3=A1s
