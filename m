Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E55C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E52147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc80HFaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41E52147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeKVCGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:06:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33947 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbeKVCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:06:40 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so13040479itd.1;
        Wed, 21 Nov 2018 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdL9CblntGYPilhvnj2H0b8+KmfuLOtRCGzWif1pmEE=;
        b=Dc80HFaX6yecoQsYGhs55nmg1qmW0MiRuIqqGvCFpTQjrdq1QgdulsfUkZtHpG4Xsv
         3tQO58CWG/EFRtCE2K1XVOxMYK330EcEAc72sDjxI1650n5JgTXdlfI7rce8iysEg2ED
         2Qwaer5hI4b7DfnY+nzA44tkaKHV/VwrWh47ofPxG8IDZyFdlLZOkKiF+mYYz6DlLEIk
         sKoPrji74BNgiv37aLj1ngbNZ84lx+3z7DZBpBVQIBVApx+v0GIiP3pGiWTfEH6lQTmf
         hr4ujSYOSN5nd7qKYMwc/SmzR/fgpL9xIZdHOmoe6jC4ts5AE9h5urWAb+fYuE5Mn8iJ
         DX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdL9CblntGYPilhvnj2H0b8+KmfuLOtRCGzWif1pmEE=;
        b=nzBtrU3nKYJo4AWutJBTsnYvDWv72iM/CbdKJ0N4MprEXBVTpPjigd+JDfseJjt+nU
         6CFeyiyF9b1HeCoygzqvgt3AciTkl/iKzyJ0HHi7GGIhqtZJaAeIeXvN8pP88mZP/X0f
         yiQDryz0rz5/QZ9rhOLwBOjSwJfW2Iii2RgdeY9tYeDdOw3lb4OiyasVDaTc6Tzjs6re
         IDy48sUVT6kTS1XtljXhdBI6qIrLA8aqnOp0/KG44iC7pTfuca3X5nW3hYOiAZHsgpwB
         IBwzCyyzIkHREm1ZC2i0K3OSM7Nxek+xKLqrk0IVIlWs/IC/Zq64J5/UKHcHNx7ignsb
         8zOQ==
X-Gm-Message-State: AA+aEWYXPYEuFitaZpidcKLznekRdSICe1pV6axneFjtsme4fMillR4+
        kTLMtP8jmfic/exWQ/c4jSS3sVu14Aq39jmXWID6YNeVilQ=
X-Google-Smtp-Source: AFSGD/Vd3oSgXn6sbJgCIgsOfvFnizfoneGq3ChgOfVUcwPMbTKQkv7mIV0LSm7j7AIxE4gW71geooXVz9qwUkLXJlU=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr5959402ity.78.1542814306226;
 Wed, 21 Nov 2018 07:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20181121130439.22255-1-tiny.windzz@gmail.com> <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
In-Reply-To: <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 21 Nov 2018 23:31:24 +0800
Message-ID: <CAEExFWvw1tw-AWbp1beajZNCRLYQXdiC6ifMvGc5_po64i_GtQ@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     sergei.shtylyov@cogentembedded.com
Cc:     b.zolnierkie@samsung.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:24 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 11/21/2018 04:04 PM, Yangtao Li wrote:
>
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
>
>    I thought we're inside pata_macio_cable_detect()?
Hi Sergei=EF=BC=9A

What do you mean?
Why not release the refcount of root?

Yours,
    Yangtao
>
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/ata/pata_macio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> > index 9588e685d994..8cc9c429ad95 100644
> > --- a/drivers/ata/pata_macio.c
> > +++ b/drivers/ata/pata_macio.c
> > @@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port =
*ap)
> >               struct device_node *root =3D of_find_node_by_path("/");
> >               const char *model =3D of_get_property(root, "model", NULL=
);
> >
> > +             of_node_put(root);
> > +
> >               if (cable && !strncmp(cable, "80-", 3)) {
> >                       /* Some drives fail to detect 80c cable in PowerB=
ook
> >                        * These machine use proprietary short IDE cable
>
> MBR, Sergei
