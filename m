Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE93208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNQL2FJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfACUDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:03:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34406 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACUDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:03:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so17170055pfg.1;
        Thu, 03 Jan 2019 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=olj6AXhV3ckEyDgorbspb3FsaV2Sn7quCe97kH4w3xc=;
        b=kNQL2FJIy8UTZcFNGxYGFtPJ/5DWWZ16x+WqmHgwMWu+xyJ1w89sTnzqKdQ9yMST2X
         DjZ6s04yT7Ezeid/rfsDCtm7p4FS1tpEftsx3S1WmWLXte05SnkklmFUssNZFEPCA/7W
         RFZ8SRiMCNiDi6bQkf8g6OXesJMwgwgZ49t5B24AsWWRQFMnjyTI4qLwJc964m7JWrn5
         PtdWS7ewW62gWN8ftmbkfbunoPCQySQh9zM3tSC6Xppyn+7ZRGH5SD9Gn8d70kCw0QOD
         nNGfbx+bU+FHyC2qcLN792IGinT6kubzsKYu3mk22vdYOAXIEUSVgxW9ivnJ2LTOmEDs
         Jq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=olj6AXhV3ckEyDgorbspb3FsaV2Sn7quCe97kH4w3xc=;
        b=n+VBLBTApkE1cwAbUPRZD2ad+rPHH7YKyLGrxERGlKIcSHQq/SDRlkAxSsa5FJwi64
         mclvTnq29UPfuAsemeE9d/BCdP73N3j9JAAFHCBVpcouyIzX6yeQ4x298ZJCs4sY17mX
         287/pYagvPQDW1vfUHezScwzXJkd9MemZIzqpKj7m+jBY0GKqmMooI5XFNA1T1pqfAS4
         3/2zi3RF73yIKxuqUh7GtRXIxsBqxzkghd3aNjcclDhO9y9vsGOUCAX4+3QuhICF85Tm
         Nu7Px4zqLwcjNt1L3atRBaZA1Qa0c443jcm8lQ8eWM2MA6NTbSzGxOP1Rsrg3orBk8uc
         vurw==
X-Gm-Message-State: AJcUukcfcgIB96+KCqsdwNqc7mSZVh1a1FliS3tWQny4M+7VBj2TOfj9
        GrOPQDQOwREHXmT2MW5oFvw=
X-Google-Smtp-Source: ALg8bN4yzvYb8d+TjzizzUJM2jVGbVhTDj424/lHfD6Nk1s5Cii23DQnCQki+jIixq4TC4wJQ3B16Q==
X-Received: by 2002:a63:da45:: with SMTP id l5mr18325287pgj.111.1546545804093;
        Thu, 03 Jan 2019 12:03:24 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r4sm111994797pgn.54.2019.01.03.12.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:03:23 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:03:19 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Message-ID: <20190103200319.GA2586@Asurada-Nvidia.nvidia.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 03, 2019 at 03:56:46PM +0000, Viorel Suman wrote:
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> > 
> > Would it be better to align with that? It's your decision though.
> 
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to 
> rename it.

We had AUDMUX, so "AUDMIX" doesn't sound bad to me at all. The only
reason that we are discussing this is because RM uses more "AUDMIX"s
over "amix"s. I'd have chosen AUDMIX if I were you, yet not strongly
as I said. And it looks like Rob is asking you to use AUDMIX in DT
binding doc.

> > > +Device driver configuration example:
> > > +======================================
> > > +  amix: amix@59840000 {
> > > +    compatible = "fsl,imx8qm-amix";
> > > +    reg = <0x0 0x59840000 0x0 0x10000>;
> > > +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> > > +    clock-names = "ipg";
> > > +    power-domains = <&pd_amix>;
> > > +  };
> > From the description of DT and RM, I don't see how it connects to
> > SAIs.
> > 
> > Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be
> > better to have such information in the doc.
> 
> Please check chapter "16.1.2.2 Audio Mixer" in RM: it has two dedicated
> SAI interfaces, SAI4 and SAI5. Audio Mixer operates on bit clock of one
> of these interfaces.

OK. I am actually more wondering how you connect it with SAI on
the software level: for imx8qm, SAI4/5 are used, but later SoCs
might use other SAI blocks. So it might be necessary to indicate
the connections in DT.

> > > +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned
> > > int fmt)
> > > +{
> > > +       /* For playback the AMIX is slave, and for record is master
> > > */
> > > +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > > +       case SND_SOC_DAIFMT_CBM_CFM:
> > > +       case SND_SOC_DAIFMT_CBS_CFS:
> > So it's used either for playback or capture only, not both at same
> > time?
> 
> From IP functional perspective AMIX capture is the result of AMIX
> playback - AMIX output represents the resulting mixed audio stream
> routed to SAI4 RX signals (bit & frame clocks and data). So once we
> have playback on either SAI4 or SAI5 (or both) - we can capture the
> AMIX output on SAI4.

Ah, it sounds like a looping block then, receiving bclk from SAI4
-- slave, and routing the bclk back to SAI4 -- master; SAI4 works
at ASYNC mode?

> I guess it would be nice to send the machine driver as part of this
> patchset also - it defines two input SAI interfaces as frontends and
> AMIX - as backend. Userspace sees only two SAI interfaces exposed, both
> of them having playback enabled, and only SAI4 having capture enabled.

DPCM? So you are having the links in the sound DT nodes, i.e. the
machine driver?

Thanks
Nicolin
