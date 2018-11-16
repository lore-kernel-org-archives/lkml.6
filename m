Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7867DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373D22089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gLChO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373D22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbeKQA6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbeKQA6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:58:22 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99EB32086C;
        Fri, 16 Nov 2018 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542379541;
        bh=8VXPBbf77sCKyL1c3ORv7gOEHePZu+NU581cGocGYCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1gLChO029jIMCO/rfjXr3XBqkREiwr/aU05cAQagS584lZ8TUeWLXDUwMp8CpCmh
         X0EvV1iLSpKG2yotkXmP4bHi+J+efrhO1G52E8yGmr5ug1LyU9Wy22gOguPkabAmFV
         J82bQK8KibPnCxIZBbE+O03qD0xv6BcPJh1CicGU=
Date:   Fri, 16 Nov 2018 22:45:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Colin Didier <colin.didier@devialet.com>
Subject: Re: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
Message-ID: <20181116144520.GO5829@dragon>
References: <20181105135802.30486-1-peron.clem@gmail.com>
 <20181116025938.GH5829@dragon>
 <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:25:07AM +0100, Clément Péron wrote:
> Hi Shawn,
> 
> On Fri, 16 Nov 2018 at 03:59, Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Nov 05, 2018 at 02:58:02PM +0100, Clément Péron wrote:
> > > From: Colin Didier <colin.didier@devialet.com>
> > >
> > > The MX6 Audmux differs from MX51.
> > >
> > > This patch adds the audmux for i.MX6 family.
> > >
> > > Signed-off-by: Colin Didier <colin.didier@devialet.com>
> > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> >
> > I think you should send it to ASoC maintainer and list for applying.
> 
> It's still quite new for me to submit patch, but if this patch should
> be sent to ASoC maintainer maybe there is a line missing in the
> MAINTAINERS file no ?

@Mark, comment?

Shawn

> 
> SOUND
> M:      Jaroslav Kysela <perex@perex.cz>
> M:      Takashi Iwai <tiwai@suse.com>
> L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
> W:      http://www.alsa-project.org/
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> T:      git git://git.alsa-project.org/alsa-kernel.git
> Q:      http://patchwork.kernel.org/project/alsa-devel/list/
> S:      Maintained
> F:      Documentation/sound/
> + F:      include/dt-bindings/sound/
> F:      include/sound/
> F:      include/uapi/sound/
> F:      sound/
> 
> Regards,
> Clement
> 
> >
> > Shawn
> >
> > > ---
> > >  include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
> > > index 15f138bebe16..a1d0741d9ed1 100644
> > > --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> > > +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> > > @@ -25,6 +25,14 @@
> > >  #define MX51_AUDMUX_PORT6            5
> > >  #define MX51_AUDMUX_PORT7            6
> > >
> > > +#define MX6_AUDMUX_PORT1_SSI1                0
> > > +#define MX6_AUDMUX_PORT2_SSI2                1
> > > +#define MX6_AUDMUX_PORT3             2
> > > +#define MX6_AUDMUX_PORT4             3
> > > +#define MX6_AUDMUX_PORT5             4
> > > +#define MX6_AUDMUX_PORT6             5
> > > +#define MX6_AUDMUX_PORT7_SSI3                6
> > > +
> > >  /*
> > >   * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
> > >   * can be sourced from Rx/Tx.
> > > --
> > > 2.19.1
> > >
