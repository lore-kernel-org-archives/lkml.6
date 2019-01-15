Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0387820656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvFQ8+eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfAOOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:14:25 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42044 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAOOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:14:24 -0500
Received: by mail-yb1-f196.google.com with SMTP id q145so1076711ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 06:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=35HXzyC9j8ZZD7Tm7WHi1c3B9DNSfqLxaJ+m6kscK/M=;
        b=FvFQ8+eMSlZ08reOpbU7BXoiCGh+FXKcn2QSjwphZadhatLjPjU8MMzwr2yqQWlw9H
         C56whQ46ITeRPxXMPGkHal+ENj0WWxd7ryJ17L+ZDJ5UyAcFWp49gKJh4JOUv/ozSFjL
         V+wfpZmwpII3aVTvFNRAGsr1IG2gPbw+K4nR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=35HXzyC9j8ZZD7Tm7WHi1c3B9DNSfqLxaJ+m6kscK/M=;
        b=pZSculDcPk08Jek7BIfoduM1rpuPeyM6xeyuqpCl5CzEnWB17PXZyodhUJJFtYKIZp
         6ndfpfFaBei5Rw96DyEvSKkcGwkmpEHXGjsVpdSFFKYbVp409gVq99YMns2ULdFY46TS
         4HaPogL7P8w+QYKS3uD1ZCmtxXStfTHh09+vmaYfQdseG6CmhcLHO4oh7kYZfCKBkv6g
         Iwdr38a8jGUiypUKELLHRUOz9MzG8/xBSoegM2+bXHWXBv6pZ1lnl2/lT8CUeYOFaQmg
         XXCfG6ySd8tSOQi8WM9nkn/8IeumUTKShDx+WbFQkmsG8j7WwhGkRb/nBoDoqtFgomXd
         dMcQ==
X-Gm-Message-State: AJcUukdoHRrZ7ZurEYBXbRhbspf06POp2kU35WbRiJYkAvR2o/JEXc03
        Xc/Gf9vLFu5lWvYaz8Z7M67BCzzGzjPCsMT1epXhKw==
X-Google-Smtp-Source: ALg8bN5nrUlUY1oRtjsPzErg1hdzf5OJc9KbZS2dhz/HPlx9IIm5BVzWfusd50Oy5+yV3tZj+IAJS7SJ3+3LNLJhpHM=
X-Received: by 2002:a25:4bc6:: with SMTP id y189mr3059776yba.195.1547561663384;
 Tue, 15 Jan 2019 06:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20190110111535.11235-1-anders.roxell@linaro.org> <CAOMZO5DGxXBCFbLgqeophv_Jw2nO5wiPXJXuth6CPEfSr9f9=w@mail.gmail.com>
In-Reply-To: <CAOMZO5DGxXBCFbLgqeophv_Jw2nO5wiPXJXuth6CPEfSr9f9=w@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 15 Jan 2019 15:14:12 +0100
Message-ID: <CADYN=9KOqZXiFYvxWED-f_sJS6G-CqY2pPUYohGuP9Pa6VGUZQ@mail.gmail.com>
Subject: Re: [PATCH] dma: ixm-dma: fix warning comparison of distinct pointer types
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 at 22:24, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Anders,
>
> On Thu, Jan 10, 2019 at 9:15 AM Anders Roxell <anders.roxell@linaro.org> =
wrote:
> >
> > The warning got introduced by commit 930507c18304 ("arm64: add basic
> > Kconfig symbols for i.MX8"). Since it got enabled for arm64. The warnin=
g
> > haven't been seen before since size_t was 'unsigned int' when built on
> > arm32.
> >
> > ../drivers/dma/imx-dma.c: In function =E2=80=98imxdma_sg_next=E2=80=99:
> > ../include/linux/kernel.h:846:29: warning: comparison of distinct point=
er types lacks a cast
> >    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
> >                              ^~
> > ../include/linux/kernel.h:860:4: note: in expansion of macro =E2=80=98_=
_typecheck=E2=80=99
> >    (__typecheck(x, y) && __no_side_effects(x, y))
> >     ^~~~~~~~~~~
> > ../include/linux/kernel.h:870:24: note: in expansion of macro =E2=80=98=
__safe_cmp=E2=80=99
> >   __builtin_choose_expr(__safe_cmp(x, y), \
> >                         ^~~~~~~~~~
> > ../include/linux/kernel.h:879:19: note: in expansion of macro =E2=80=98=
__careful_cmp=E2=80=99
> >  #define min(x, y) __careful_cmp(x, y, <)
> >                    ^~~~~~~~~~~~~
> > ../drivers/dma/imx-dma.c:288:8: note: in expansion of macro =E2=80=98mi=
n=E2=80=99
> >   now =3D min(d->len, sg_dma_len(sg));
> >         ^~~
> >
> > Rework so that we use min_t and pass in the size_t that returns the
> > minimum of two values, using the specified type.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> There is a typo in the Subject: s/ixm/imx/ and the prefix should be
> dmaengine instead:
>
> dmaengine: imx-dma: fix warning comparison of distinct pointer types
>
> With that fixed:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

OK, thanks Fabio.

Dan, do you want me to resend the patch with an updated shortlog or will
you do that when you apply the patch?

Cheers,
Anders
