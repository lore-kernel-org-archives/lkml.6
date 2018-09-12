Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF234C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1B921471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Sw1OC0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1B921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeIMBdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbeIMBdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:33:15 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE5021476;
        Wed, 12 Sep 2018 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536784022;
        bh=l4O9YmPSHpvJxSugf6M1jpX4ZGgheWee1DFEM3SVVWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1Sw1OC0d5c7REHwVGDk8ffLqVZShTzDWSOoqvBudMsnXmZAS77DTbnGApcgWJpIXB
         6yUmZweGE56aoCsdYYPzoKr2UzgvN/UhY6lKzstK/1RSSvJDFZpYHzrI503KhHoaOb
         3ax/vjYhXR8MRl7rdIpB7Zv4k90GcMtV7gIsxW1U=
Received: by mail-qk1-f180.google.com with SMTP id 130-v6so1943543qkd.10;
        Wed, 12 Sep 2018 13:27:02 -0700 (PDT)
X-Gm-Message-State: APzg51AMmc1++4rSaNEfwc7Fc/iokf+3VBO8R8dynUyg5AwSsjpfxiud
        hNA5WgodN9TeXAsOEUKvl6zDqrz6wkbDQil1nA==
X-Google-Smtp-Source: ANB0VdZe1AaINAs4O2EbB/Hx+BAYxZJc/MfX3JGnWr5eYBTpm81o/sxX6W8kKGAyf7D6KBPl2rxX7NNQcYkrGkhe9nE=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr2792160qkw.184.1536784021244;
 Wed, 12 Sep 2018 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154433.5693-1-robh@kernel.org> <20180828154433.5693-7-robh@kernel.org>
 <20180912121705.010a999d@coco.lan>
In-Reply-To: <20180912121705.010a999d@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Sep 2018 15:26:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
Message-ID: <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of device_node.name
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Joe Perches <joe@perches.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Joe P

On Wed, Sep 12, 2018 at 10:17 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 28 Aug 2018 10:44:33 -0500
> Rob Herring <robh@kernel.org> escreveu:
>
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Steve Longerbeam <slongerbeam@gmail.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: devel@driverdev.osuosl.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - fix conditional use of node name vs devname for imx
> >
> >  drivers/staging/media/imx/imx-media-dev.c | 15 ++++++++++-----
> >  drivers/staging/media/imx/imx-media-of.c  |  4 ++--
> >  drivers/staging/mt7621-eth/mdio.c         |  4 ++--
>
> It would be better if you had submitted the staging/media stuff
> on a separate patch, as they usually go via the media tree.

Sorry, I thought Greg took all of staging.

A problem with MAINTAINERS is there is no way to tell who applies
patches for a given path vs. anyone else listed. This frequently
happens when the maintainer organization doesn't match the directory
org. If we distinguished this, then it would be quite easy to see when
you've created a patch that needs to be split to different maintainers
(or an explanation why it isn't). Whatever happened with splitting up
MAINTAINERS? If there was a file for each maintainer tree, then it
would be easier to extract that information.

Or maybe we just need to be stricter with the 'M' vs. 'R' tag and 'M'
means that is the person who applies the patch. I don't think many
drivers have their own tree and maintainer except for a few big ones.

Rob

>
> As I don't foresee any conflicts on that part of the code,
> I'm Ok if Greg pick it and submit via his tree.
>
> So,
>
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>
> If you prefer instead that I would pick the media part, please
> split it into two patches.
>
> Regards,
> Mauro
>
> >  3 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> > index b0be80f05767..3f48f5ceb6ea 100644
> > --- a/drivers/staging/media/imx/imx-media-dev.c
> > +++ b/drivers/staging/media/imx/imx-media-dev.c
> > @@ -89,8 +89,12 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
> >
> >       /* return -EEXIST if this asd already added */
> >       if (find_async_subdev(imxmd, fwnode, devname)) {
> > -             dev_dbg(imxmd->md.dev, "%s: already added %s\n",
> > -                     __func__, np ? np->name : devname);
> > +             if (np)
> > +                     dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
> > +                     __func__, np);
> > +             else
> > +                     dev_dbg(imxmd->md.dev, "%s: already added %s\n",
> > +                     __func__, devname);
> >               ret = -EEXIST;
> >               goto out;
> >       }
> > @@ -105,19 +109,20 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
> >       if (fwnode) {
> >               asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
> >               asd->match.fwnode = fwnode;
> > +             dev_dbg(imxmd->md.dev, "%s: added %pOFn, match type FWNODE\n",
> > +                     __func__, np);
> >       } else {
> >               asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
> >               asd->match.device_name = devname;
> >               imxasd->pdev = pdev;
> > +             dev_dbg(imxmd->md.dev, "%s: added %s, match type DEVNAME\n",
> > +                     __func__, devname);
> >       }
> >
> >       list_add_tail(&imxasd->list, &imxmd->asd_list);
> >
> >       imxmd->subdev_notifier.num_subdevs++;
> >
> > -     dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
> > -             __func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
> > -
> >  out:
> >       mutex_unlock(&imxmd->mutex);
> >       return ret;
> > diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> > index acde372c6795..163437e421c5 100644
> > --- a/drivers/staging/media/imx/imx-media-of.c
> > +++ b/drivers/staging/media/imx/imx-media-of.c
> > @@ -79,8 +79,8 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
> >       int i, num_ports, ret;
> >
> >       if (!of_device_is_available(sd_np)) {
> > -             dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
> > -                     sd_np->name);
> > +             dev_dbg(imxmd->md.dev, "%s: %pOFn not enabled\n", __func__,
> > +                     sd_np);
> >               /* unavailable is not an error */
> >               return 0;
> >       }
> > diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
> > index 7ad0c4141205..9ffa8f771235 100644
> > --- a/drivers/staging/mt7621-eth/mdio.c
> > +++ b/drivers/staging/mt7621-eth/mdio.c
> > @@ -70,7 +70,7 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
> >       _port = of_get_property(phy_node, "reg", NULL);
> >
> >       if (!_port || (be32_to_cpu(*_port) >= 0x20)) {
> > -             pr_err("%s: invalid port id\n", phy_node->name);
> > +             pr_err("%pOFn: invalid port id\n", phy_node);
> >               return -EINVAL;
> >       }
> >       port = be32_to_cpu(*_port);
> > @@ -249,7 +249,7 @@ int mtk_mdio_init(struct mtk_eth *eth)
> >       eth->mii_bus->priv = eth;
> >       eth->mii_bus->parent = eth->dev;
> >
> > -     snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
> > +     snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
> >       err = of_mdiobus_register(eth->mii_bus, mii_np);
> >       if (err)
> >               goto err_free_bus;
> > --
> > 2.17.1
>
>
>
> Thanks,
> Mauro
