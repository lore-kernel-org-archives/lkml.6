Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3161C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A07B240B0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIEdd5FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A07B240B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeGFDFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:05:35 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38727 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbeGFDFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:05:32 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so3699902ywc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XX4KKy3Ve7bCN/yUFHtsYfMuTLdbKUv+QoByC9P+MLU=;
        b=iIEdd5FCg3Vb8NdbEbqJZGpm/trStzJ1GX1o0vWTNpZIZWGGVVHcaA4mRZnUAZi0kZ
         RQy4QueEX9cSEjiwbadnETLIH2ABu5uURGb5iNYvSM5OnlOZbfScKbyg+ZtUaG4Y1Nfc
         mXl3IWSgo7zRMKK6Ec4XHDAcHmkKErOBYlysg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XX4KKy3Ve7bCN/yUFHtsYfMuTLdbKUv+QoByC9P+MLU=;
        b=R7tmUcJn/5ofVYLPF9r5NZjkIp4HAyo+22GTSnyM3Xk0UnCcHq8+sLs8p+V2Xd5KVV
         NrRBd0FUZXjkMqB8RpaGkzQBe7eptr5IrDawtsEL3/8d6R85GxTvLWYKRRo/ORy9cxp0
         qxg3osnej6RtbpXso2qsS46zIJPug8/TBXq6PhNDzCc8qby8/72GD/vNJ15KoyARTgRi
         LvvkMUyCsOZPF+birVmPVW2gTBk/K71gUiG7YXuoaWEEghVwIW2e8erwre9qCUlTxaai
         m0/8cFiUackQbgnoaT0jBe842zpeteA8c5qyMTYxjTA4E5JBDr/Okx8WoRKkNI4V1yFb
         l3HA==
X-Gm-Message-State: APt69E0Yd8G045qA+/go4FJ2xHCPYjJskdNzPOyFUlfqlgfv0Hf5GekH
        /Pn5jSGSBXYKITE4DngtFAyS/wZhevBTsByfN7Y3Sw==
X-Google-Smtp-Source: AAOMgpeVU+mPgb12W1OrMVv77zQvGtXjDmdd8dMQhrWm/CMBFR6Lf7oGEApSheww4RGEO/8hr2MMBQbYuY8UUMlR6mY=
X-Received: by 2002:a81:5b8b:: with SMTP id p133-v6mr3929712ywb.365.1530846332004;
 Thu, 05 Jul 2018 20:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180622032416.20133-1-guodong.xu@linaro.org> <20180622032416.20133-3-guodong.xu@linaro.org>
 <20180628060239.GO22377@vkoul-mobl>
In-Reply-To: <20180628060239.GO22377@vkoul-mobl>
From:   Guodong Xu <guodong.xu@linaro.org>
Date:   Fri, 6 Jul 2018 11:05:21 +0800
Message-ID: <CAFGCpxwkdJQAf9bwHTLp+Zc5ASbnFQn9UDsA+zFCH7UZJy9aBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3dma: add support to reserved minimum channels
To:     vkoul@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dan.j.williams@intel.com,
        liyu65@hisilicon.com, Suzhuangluan <suzhuangluan@hisilicon.com>,
        "xuhongtao (A)" <xuhongtao8@hisilicon.com>,
        zhongkaihua <zhongkaihua@huawei.com>,
        Xuezhiliang <xuezhiliang@hisilicon.com>,
        "xupeng (Q)" <xupeng7@huawei.com>, sunliang10@huawei.com,
        "Fengbaopeng (kevin, Kirin Solution Dept)" 
        <fengbaopeng@hisilicon.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:02 PM Vinod <vkoul@kernel.org> wrote:
>
> On 22-06-18, 11:24, Guodong Xu wrote:
> > From: Li Yu <liyu65@hisilicon.com>
> >
> > On k3 series of SoC, DMA controller reserves some channels for
> > other on-chip coprocessors. By adding support to dma_min_chan, kernel
> > will not be able to use these reserved channels.
> >
> > One example is on Hi3660 platform, channel 0 is reserved to lpm3.
> >
> > Please also refer to Documentation/devicetree/bindings/dma/k3dma.txt
>
> and if some other platform has channel X marked for co-processor, maybe
> a last channel or something in middle, how will this work then?
>
Hi=EF=BC=8C Vinod

Sorry for delayed response. We checked with Kirin hardware design
team, so far their design strategy is all Kirin SoC series reserve
only from minimum side, saying channel 0, then 1, then 2. That impacts
the current SoC in upstreaming, Kirin960 (Hi3660), and next versions
in Kirin SoC, Kirin970 and 980, which may hit upstream later.

> I am thinking this should be a mask, rather than min.
>

So, since this driver k3dma.c is only used by Kirin SoC DMA
controllers, I would prefer to keep the current design dma_min_chan
unchanged.

What do you think?

-Guodong


> >
> > Signed-off-by: Li Yu <liyu65@hisilicon.com>
> > Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> > ---
> >  drivers/dma/k3dma.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> > index fa31cccbe04f..13cec12742e3 100644
> > --- a/drivers/dma/k3dma.c
> > +++ b/drivers/dma/k3dma.c
> > @@ -113,6 +113,7 @@ struct k3_dma_dev {
> >       struct dma_pool         *pool;
> >       u32                     dma_channels;
> >       u32                     dma_requests;
> > +     u32                     dma_min_chan;
> >       unsigned int            irq;
> >  };
> >
> > @@ -309,7 +310,7 @@ static void k3_dma_tasklet(unsigned long arg)
> >
> >       /* check new channel request in d->chan_pending */
> >       spin_lock_irq(&d->lock);
> > -     for (pch =3D 0; pch < d->dma_channels; pch++) {
> > +     for (pch =3D d->dma_min_chan; pch < d->dma_channels; pch++) {
> >               p =3D &d->phy[pch];
> >
> >               if (p->vchan =3D=3D NULL && !list_empty(&d->chan_pending)=
) {
> > @@ -326,7 +327,7 @@ static void k3_dma_tasklet(unsigned long arg)
> >       }
> >       spin_unlock_irq(&d->lock);
> >
> > -     for (pch =3D 0; pch < d->dma_channels; pch++) {
> > +     for (pch =3D d->dma_min_chan; pch < d->dma_channels; pch++) {
> >               if (pch_alloc & (1 << pch)) {
> >                       p =3D &d->phy[pch];
> >                       c =3D p->vchan;
> > @@ -825,6 +826,8 @@ static int k3_dma_probe(struct platform_device *op)
> >                               "dma-channels", &d->dma_channels);
> >               of_property_read_u32((&op->dev)->of_node,
> >                               "dma-requests", &d->dma_requests);
> > +             of_property_read_u32((&op->dev)->of_node,
> > +                             "dma-min-chan", &d->dma_min_chan);
> >       }
> >
> >       d->clk =3D devm_clk_get(&op->dev, NULL);
> > @@ -848,12 +851,12 @@ static int k3_dma_probe(struct platform_device *o=
p)
> >               return -ENOMEM;
> >
> >       /* init phy channel */
> > -     d->phy =3D devm_kcalloc(&op->dev,
> > -             d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL);
> > +     d->phy =3D devm_kcalloc(&op->dev, (d->dma_channels - d->dma_min_c=
han),
> > +                     sizeof(struct k3_dma_phy), GFP_KERNEL);
> >       if (d->phy =3D=3D NULL)
> >               return -ENOMEM;
> >
> > -     for (i =3D 0; i < d->dma_channels; i++) {
> > +     for (i =3D d->dma_min_chan; i < d->dma_channels; i++) {
> >               struct k3_dma_phy *p =3D &d->phy[i];
> >
> >               p->idx =3D i;
> > --
> > 2.17.1
>
> --
> ~Vinod
