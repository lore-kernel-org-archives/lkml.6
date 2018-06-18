Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B720874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEMLFLc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030474AbeFRInQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:43:16 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45884 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966072AbeFRInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:43:11 -0400
Received: by mail-qk0-f196.google.com with SMTP id c198-v6so8897925qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xg4NeEpLOwxFuD6U12W9lZ/t1i37wL1dFYPKqAv6mcw=;
        b=HEMLFLc9sp6YmDkODXMSpO4W8tQKzVnp8uNxw6JLMsT/TCeqUFdEqdTg+jBea3Qlt3
         kYv2nN86o0RYQgGMo3mvPg0JCWlD529X3Nz2IbKNRhEmx1G8THucZfakr1tFbRN+K370
         BmUBZGyzmWUGhs6z4KVG9lrZ93EyFk1NhRb3j0Hy4x+z0pnnZaiyZFqZsE9fk9+SRCZO
         NOdvjfc2OLrF6T4e759tV6r5i2aS28Csyd4bhs//razZRTriXG42QQKvqYCjpbvqyKL7
         ZnujIj3LIWwOeHgMosYm6A0iLwbPNs3Hby7RflTRwDQ2TSMPJd57svOI3wBi2i8KUz0O
         EDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xg4NeEpLOwxFuD6U12W9lZ/t1i37wL1dFYPKqAv6mcw=;
        b=nG/jSUoK9uuflX6hQkoawGoHtIhPM/SoXQqeOngjbD7ZVH/dUsDQ1atzFIcNFsRkOl
         mQSWCdfkgVRMNoDCbIc5tUiFZkxp4n9MJ4Mx+SGG4NLNvVLtSdpsxZIhuEFufj1LHR7d
         YE7u9A3OdFy1H6iBKxp2AFo8pWZGGOQyi90xclJk16Taj3IUMKMypGYD75H+5KqudcMH
         kw46mTi8Hui2DhOkNOm4aKw3lvAsQ9r+ZMIoKB61Iomfnyiyql/KhNbRvou5ggrj88S2
         SLy3mWQC9oFUTsFRuNiWYhpM/xJejqhj/UNGAwpSel2d3FV1xlB8q9E+4PRz5YkpGv5J
         YUTg==
X-Gm-Message-State: APt69E2ERl8cWoNtgnYFkTOs3RBDqoVtwLUYRPA9mm1meeDjCtBGk7VU
        hYFZfTsHcfBDRKvmSuaOaoheMrTLEVBfFldnXB4=
X-Google-Smtp-Source: ADUXVKJWQxpwJenZJF5oFwucpw7IphM+WD2T3eJESIcjll7Pm2cKw95uTr0xxJTOcjt9XWDIcxzrNhk4nIJHwaMvZv8=
X-Received: by 2002:a37:9f0b:: with SMTP id i11-v6mr9188462qke.171.1529311390824;
 Mon, 18 Jun 2018 01:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-4-enric.balletbo@collabora.com> <20180618071801.GI31141@dell>
 <20180618072021.GJ31141@dell> <CAFqH_51Fsyr-zE4zzKLxqPZeep9gj7X_1HOnBeEbg9jXju8S4A@mail.gmail.com>
 <20180618081323.GM31141@dell>
In-Reply-To: <20180618081323.GM31141@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 Jun 2018 10:42:59 +0200
Message-ID: <CAFqH_50yB6718K4mJNxZZ=gxKjzbmj69o01rP5RSdskb8dxoiA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] mfd: cros_ec: Make license text and module
 license match.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 18 de juny
2018 a les 10:13:
>
> On Mon, 18 Jun 2018, Enric Balletbo Serra wrote:
>
> > Hi Lee,
> > Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 18 de juny
> > 2018 a les 9:21:
> > >
> > > On Mon, 18 Jun 2018, Lee Jones wrote:
> > >
> > > > On Wed, 06 Jun 2018, Enric Balletbo i Serra wrote:
> > > >
> > > > > The license text is specifying "GPLv2" but the MODULE_LICENSE is =
set to
> > > > > GPL which means GNU Public License v2 or later. When MODULE_LICEN=
SE and
> > > > > boiler plate does not match, go for boiler plate license.
> > > > >
> > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.c=
om>
> > > > > ---
> > > > >
> > > > > Changes in v3: None
> > > > > Changes in v2: None
> > > > >
> > > > >  drivers/mfd/cros_ec.c     | 2 +-
> > > > >  drivers/mfd/cros_ec_i2c.c | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > Applied, thanks.
> > >
> > > I've just seen Joe's comment.
> > >
> >
> > Did you read my answer [1] to the Joe's email?
> >
> > According to the doc if MODULE_LICENSE is GPL that means  GPL-2.0 or
> > later which to be strict is wrong if your file is GPL-2.0 only. It's
> > right that there are modules in the kernel that have this mismatch but
> > IMHO is wrong, there are also some examples where people fix this, i.e
> > [2]
>
> I did.  Did you read his comment about making these changes wider?
>

Ah ok, that's the reason, so you prefer I do a script to fix this in a
more general way instead of only fix this for cros-ec devices. I'll
do.

Thanks,
 Enric

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
