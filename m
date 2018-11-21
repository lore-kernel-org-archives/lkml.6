Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3725C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F812146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL6jo+Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F812146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeKVBWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:22:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55939 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeKVBWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:22:48 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so9133039itg.5;
        Wed, 21 Nov 2018 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jOLPfuDHHk1eKDm7ckP55CmtgPqN4J9JQcL1km5Owic=;
        b=KL6jo+BjlBH/MPyM9b7azICE+YwAk5jJWaM2urnSRJ/rAhVABF5kzz8fkMToyYoZFu
         YN47QZuaggW7QfbocvMR8dtvU7rrBMC7nWZZx6fnJQZ+XK/pcMrsDt1QEI3m2kOfNx1L
         SHB8PUyM7llJChuwATo4J8tHHwf18bZAWrINnkUTnCQvnCOC18ZaE21qpuZiYxADVGs5
         UScgC1do60gyYf5O0Fx8Dg5lcofVW3O1YD8SDpWLYpkYG3V0Sne+8pqSWtmf+eHB8poB
         trgy76u8m5tByB7o/se04dDcQb2NAJgtp89iKHT50qq0rMJe2kMSbCU41DSiNEU4xZq1
         vm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jOLPfuDHHk1eKDm7ckP55CmtgPqN4J9JQcL1km5Owic=;
        b=PgF0FoK7JNK+xdy76B3oEVJXM+RzOyIsh78ldGi/YiMLVcWkE5z8SJype50z6FhDfO
         FprQrVxRniz6zP3rd2hNo+cBab7NN/ReYnctty9LEbUZF0Ih44sZDHmtbhOC3UMG++t1
         wfxUJKmwbGaUgEmSsnWbafrP6HGEus+9PTNYjMDUCibuUwV1fNOcKFh5OT0DWuZjH+u5
         p8tJcFDtDupDBlnVuZdZBoj4J12YNg2DEvTV5BaMKbOffS2V3zmhM2I2STK29NH+xEoG
         43vH5frtp4odPN48/9N9PRlGFx/2kFL4HAjgYwIQIden6qm3Nro5sZ9gZOJNwYymULfL
         bfVA==
X-Gm-Message-State: AA+aEWaUCNnKOV6Vkq+AKVgBLtG+y6Dh7MoJFsywz3UWGvF+G/YnQbIH
        +BK2dMbwNGI/H6vcaMjMmcMwiSlX8Qj+2cJFUSA=
X-Google-Smtp-Source: AFSGD/UXTpfymMwBKXJl1UWvXA5eOLGrk8pqAdgBk3TfIqALYW95M7MiFz0/sZwSpTq4srT70dCia+wv4z6y/o2iUls=
X-Received: by 2002:a02:5184:: with SMTP id s126mr1455132jaa.12.1542811685064;
 Wed, 21 Nov 2018 06:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20181121141204.22819-1-tiny.windzz@gmail.com> <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
 <20181121144320.GA6446@ulmo>
In-Reply-To: <20181121144320.GA6446@ulmo>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 21 Nov 2018 22:47:42 +0800
Message-ID: <CAEExFWswqoObtnjezRf-3u1ssJ04cwDaggg_HLXju72mannZ6w@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:43 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Wed, Nov 21, 2018 at 02:34:57PM +0000, Jon Hunter wrote:
> >
> > On 21/11/2018 14:12, Yangtao Li wrote:
> > > of_find_node_by_path() acquires a reference to the node returned by
> > > it and that reference needs to be dropped by its caller.soc_is_tegra(=
)
> > > doesn't do that, so fix it.Call of_machine_is_compatible() to refacto=
r
> > > soc_is_tegra() whcih automatically manages the reference count.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/soc/tegra/common.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > > index cd8f41351add..0b40700b672a 100644
> > > --- a/drivers/soc/tegra/common.c
> > > +++ b/drivers/soc/tegra/common.c
> > > @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_ma=
tch[] =3D {
> > >
> > >  bool soc_is_tegra(void)
> > >  {
> > > -   struct device_node *root;
> > > +   struct of_device_id *match =3D tegra_machine_match;
> > >
> > > -   root =3D of_find_node_by_path("/");
> > > -   if (!root)
> > > -           return false;
> > > +   while(match->compatible){
> > > +           if(of_machine_is_compatible(match->compatible))
> > > +                   return true;
> > > +           match++;
> > > +   }
> > >
> > > -   return of_match_node(tegra_machine_match, root) !=3D NULL;
> > > +   return false;
> > >  }
> >
> > Ugh ... sorry, I thought that of_machine_is_compatible() looped through
> > the matches. OK, let's stick with your initial fix.
>
> Actually I prefer this one. Even if it is slightly more verbose, I think
> it's much clearer what's actually going on. Also this hides all of the
> OF node reference counting in a core function, so it's worth the extra
> line, in my opinion.
>
> Thierry
Hi Jon=EF=BC=9A

I like both, how aboout you?

Yours=EF=BC=8C
    Yangtao
