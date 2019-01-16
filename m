Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD2320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547650689;
	bh=nt0t9pYYsdnSuuPbQv9J52WaQ4atxiCDmVt76SSqRfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NkC4VDVldVNRZOlGccbf4iRzg+4tQEoPeMkFDqPLIhDNSByxrDbPHBYO1ct8awgKs
	 nJSl7llPsAhGKB2Qpa0nALodxw8tmi2RYvh1qdAM8wx0oVKlD+zDXFZ4DfNw2wEmAu
	 JRm3KvKRHiPTQkoUheC6Nn36hsQnKRRqKX93s/A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404770AbfAPO6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfAPO6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:58:07 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A91820657;
        Wed, 16 Jan 2019 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547650686;
        bh=nt0t9pYYsdnSuuPbQv9J52WaQ4atxiCDmVt76SSqRfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w4Gj/294M9xsXIyGGPb6u6u2bJKtX8cZPwwEEKmrd17Es66QdsgWd7/g1emDN1Q8q
         qNKCzwpIZTdMtSB+LPadUh4eTayc4MB2G59TmneGms+gTa2H2Nca3JcFrVnP1EjmgE
         sHFEVb9aMYpfYEitbi/co8OYfV6PJPKIrG5Vnvic=
Received: by mail-qt1-f181.google.com with SMTP id t33so7425249qtt.4;
        Wed, 16 Jan 2019 06:58:06 -0800 (PST)
X-Gm-Message-State: AJcUukcz3eiGHuBgKFCXO6U9ehl8qBxHUrL7Kot8ou0w5mbTPIzFRdT5
        fvJNCknlx5rnQTj9RqVPiXctFK7Esu/FL8YTpQ==
X-Google-Smtp-Source: ALg8bN5/JPYhJySu8yj+5+78GK5ulWxogQKP9CP+KUx7IZPKBDkRJqkdxOSoKlnmasroQ3tGSb2ajhyDrHSVYk2220o=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr7196569qve.246.1547650685554;
 Wed, 16 Jan 2019 06:58:05 -0800 (PST)
MIME-Version: 1.0
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com> <20190115205755.GA4022@bogus>
 <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
In-Reply-To: <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Jan 2019 08:57:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzmqubd8BVPdju2hLwZNMsen-1+uuHT+S-yirXaSNyHw@mail.gmail.com>
Message-ID: <CAL_JsqKzmqubd8BVPdju2hLwZNMsen-1+uuHT+S-yirXaSNyHw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
To:     Daniel Baluta <daniel.baluta@gmail.com>
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

On Wed, Jan 16, 2019 at 2:22 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Tue, Jan 15, 2019 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> > > Add the DT binding documentation for Audio Mixer
> > > machine driver.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > > new file mode 100644
> > > index 0000000..6ac1230
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > > @@ -0,0 +1,24 @@
> > > +NXP Audio Mixer (AUDMIX) machine driver.
> > > +
> > > +Required properties:
> > > +===================================
> > > +  - compatible               : Compatible list, contains "fsl,imx-audmix"
> > > +
> > > +  - model            : Short audio card description.
> > > +
> > > +  - dais             : Must contain a list of phandles to AUDMIX connected
> > > +                       DAIs. The current implementation requires two phandles
> > > +                       to SAI interfaces to be provided, the first SAI in the
> > > +                       list being used to route the AUDMIX output.
> > > +
> > > +  - audmix-controller        : Must contain the phandle to the AUDMIX device node.
> >
> > I don't think you need 2 nodes for this as this one is just a virtual
> > device. Just add the dais property to the audmix node.
>
> Hi Rob,
>
> Thanks for the suggestion. We want to understand better the reasoning
> behind this.
>
> Is it because dais are physically connected to AUDMIX node?
>
> In ALSA we usually add all the components inside the
> associated machine driver virtual node.

Yes, but in those cases, there's a bunch of components (DAIs, DMA,
DSP, amp, codecs, etc.) with no main device. That doesn't really
appear to be the case here (or your example was incomplete).

It's simply that we try to avoid such virtual devices unless
absolutely necessary.

Rob
