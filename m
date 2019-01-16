Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khRVGQJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbfAPIWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:22:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39844 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbfAPIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:22:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so4702090edt.6;
        Wed, 16 Jan 2019 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPWM1AqWAmZUC/KtGael9gqXqDnamd2rhQqXFyqQd3M=;
        b=khRVGQJS6dPOfa2vFbkTo7tuY9Me8XKCVkflHPDCbNrFC3N+nMY4wRg79Ee3LkEp2i
         +lScQRVIjdSaTy4uyjMXZ+fynsgkLk5aX0nz6hROR8CVFcPxzw6o/8P6UzGzc7a+lJ7+
         6kFaKBAFNla3gZTReW/I0O3DRz+cjFK+vO/kqcPGYsIOwls1HgXQmHkE4mRDOgn30/UE
         c99fifx6oPMI7a0jnay9G0C3rERTVY41OVabgv/7z2AApq7PZXvBXLHNbVgDX+Jx7oFW
         yUPKOMZ8+V1XiqDy3kfQJ81VmMiya7d8npCtxNzym2+6tqEWB15R+bYeWl3o4UtAgN6z
         L6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPWM1AqWAmZUC/KtGael9gqXqDnamd2rhQqXFyqQd3M=;
        b=FdSQy3HGf8AIPRHdehoSurPo+lVzIaShj1d14cqLfQXTQAbas/DppsoKtevC5KlWQH
         GRVJtGl8ypOY4zX0YeTsDv34XX254GXhLG1/UDeZoq4KYLF8oOI/xgHqLo0+uhZYOulX
         iqpdYmPrzZFbsCvssBVTl7Jhtg3VNrvLOD+T1pqgHDa9EZX0sC27aUQVycznhU2hL0lz
         RrFIPBGHwdgeMO87dgN46L8+fbeWQC7gFOZKeQvjYDJCEAVp9pE+3B18s+alAuRYo33I
         Yat7fy3b3BBxAe080+JpWxNvKXBazgOn2Oj1/GAIfBKqEq3KvIew0CqCkrveAJDN4S0R
         8rTg==
X-Gm-Message-State: AJcUukd/FA26i3WprA/2OFF20VYs9YvT69rkjuQGniynT9ViFV4mg+8+
        m3zdAN3JwmCiHi+xsI0JxLMlOMysV5r1ElU4Pw4=
X-Google-Smtp-Source: ALg8bN5G8+j3piIu1jyD1/QrlP+u8pPbCrvw1t8ary/awQnXCyTt2aEO1EXKQeuLvuc2Gb5cfxfuDUE0lNysbn/8p3A=
X-Received: by 2002:a50:a125:: with SMTP id 34mr6560393edj.175.1547626923895;
 Wed, 16 Jan 2019 00:22:03 -0800 (PST)
MIME-Version: 1.0
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com> <20190115205755.GA4022@bogus>
In-Reply-To: <20190115205755.GA4022@bogus>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 16 Jan 2019 10:21:52 +0200
Message-ID: <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for Audio Mixer
> > machine driver.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > new file mode 100644
> > index 0000000..6ac1230
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > @@ -0,0 +1,24 @@
> > +NXP Audio Mixer (AUDMIX) machine driver.
> > +
> > +Required properties:
> > +===================================
> > +  - compatible               : Compatible list, contains "fsl,imx-audmix"
> > +
> > +  - model            : Short audio card description.
> > +
> > +  - dais             : Must contain a list of phandles to AUDMIX connected
> > +                       DAIs. The current implementation requires two phandles
> > +                       to SAI interfaces to be provided, the first SAI in the
> > +                       list being used to route the AUDMIX output.
> > +
> > +  - audmix-controller        : Must contain the phandle to the AUDMIX device node.
>
> I don't think you need 2 nodes for this as this one is just a virtual
> device. Just add the dais property to the audmix node.

Hi Rob,

Thanks for the suggestion. We want to understand better the reasoning
behind this.

Is it because dais are physically connected to AUDMIX node?

In ALSA we usually add all the components inside the
associated machine driver virtual node.

thanks,
Daniel.
