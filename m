Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F45D21E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6j5PEKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F45D21E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHIQJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:09:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:09:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so5182140wrs.9;
        Thu, 09 Aug 2018 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HjzvjAuS/pGCmgF3o0OE7PYudJKiCj67SIBoOCzOLH8=;
        b=q6j5PEKTXcuujHccAgcJsl+VOJhlXiX/TH8f/Ch3Z8o4ZQMUbpIcpLBSoL3XilcTfv
         Eohc8zgRegELcqjFY9fcNjcH/Ujrk1RvaBmgOrucvbiaP+Gh03pfdhEhz13+/nDe8RSW
         3pLiCB6Awt/8vXicZXmONXRkv8F/AEWRYwduLsKABA5ZTrviaN4yNEskMGebx496xt7W
         +8kKQy3NI5lUzofsSsLni/9H9m3/ecRMIqyr+I4r/jjGRtWDS9MNJlO6lq5WP5pYVvBW
         8TEMnbi8xL8VpONZYLEBzh+n4fpxtUiX7zTqq26nCagioWq3YXkVYeTCORxt/4oZDbcX
         Q5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjzvjAuS/pGCmgF3o0OE7PYudJKiCj67SIBoOCzOLH8=;
        b=duJgTydE65qUK9ssiHJ44VAXSEnU08T+x90KwchiGoOp9C8dQVRZmah/Tu+9lyU1Gi
         jJspFFywdR0dwi7NgKDm2gTLOOOjA9u0EQd1eGm4ml3KN5vFdGKU/60Y6OxMIiet0jx6
         UkXiunPuE/TiRhw99aCSKJssGLGlomtZ2csr+YlxFO4HT+sf4TXnmAMKwtZExCavOb0w
         CN8VSpwTeXHapZuGsCUBYPY6TueH72jT8FV6ZGt1cf8QpdnWk7ovvg+j1uDf2u3sfBzV
         YwN5iTeHLq6aoYYQ4+P/nc2ijWFZmS/4Gk61bxAeZERbgG20AG3UksRJymuFzowKz8+E
         ynvQ==
X-Gm-Message-State: AOUpUlHX/SktsH7BxaoNIJVXBweejLjZef0GIfFiTZh8mLVVDaSbnpdB
        aWw5NZE9wiFPMIof+jGFlDg=
X-Google-Smtp-Source: AA+uWPzpkVqoduRxux3DyqNaqJxLlni5a/rLdl5zV5XZhO0WKhSGuEP3/uMnvExb7jOuofrlTvqvxA==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr1443304wrj.3.1533822297584;
        Thu, 09 Aug 2018 06:44:57 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 185-v6sm13295480wmy.38.2018.08.09.06.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:44:56 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:44:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Message-ID: <20180809134455.GC21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
 <20180809124616.GV21639@ulmo>
 <20180809155638.23f96e61@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="56p9wBiXEyg+KhLM"
Content-Disposition: inline
In-Reply-To: <20180809155638.23f96e61@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--56p9wBiXEyg+KhLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:56:38PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:46:16 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> > > Implement polling with 10 ms timeout for automatic pad drive strength
> > > calibration.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> > > index 7d98455..c8ff267 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > > +#include <linux/iopoll.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > > @@ -50,6 +51,9 @@
> > >  #define SDHCI_AUTO_CAL_START			BIT(31)
> > >  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> > > =20
> > > +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> > > +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> > > +
> > >  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
> > >  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
> > >  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> > > @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host=
 *host, u8 mask)
> > > =20
> > >  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
> > >  {
> > > -	u32 val;
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > > +	reg |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> > > +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > >   =20
> >=20
> > I know this is preexisting, but I want to make sure we cover this so we
> > don't run into this down the road: do these bits automatically clear on
> > calibration completion? Can we run these multiple times and get
> > everything properly calibrated?
>=20
> The TRM states in the pad auto-calibration procedure description that
> this bit should not be cleared.

It says that SDHCI_AUTO_CAL_ENABLE shouldn't be cleared after
calibration completes, but I'm wondering how recalibration is going to
happen on a second run.

I guess if we never turn off calibration, then it will continue to run
forever, but does that also work if we go back to a mode that doesn't
require calibration?

So perhaps what we need is to clear SDHCI_AUTO_CAL_ENABLE when going to
such a mode. And perhaps we need to clear SDHCI_AUTO_CAL_START after the
calibration is complete.

Anyway, lots of unanswered questions and if the above works, I'm fine
with merging it as-is. If we find out that something else is needed at a
later point we can always fix it up later.

Thierry

--56p9wBiXEyg+KhLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRVUACgkQ3SOs138+
s6ESZxAAs2NFQ3cNsgDNlKQrmj0UQBmZWM/K7uGfW4pQUPu0E6o7+mKXsVDZh+7V
omu10iibbzbhlWGvOGEjN294m5kHXH5rEuxi54lOFLtXLQAEhdkyG/svRORxGUMp
y3vrcz0XxhQnMPbMKI5FjzQcTRekv1aDko8/ba8FqaTkFA1zb9yqKvRPj/9LBp8I
CWzcPEVuRuCAot4Va4uUHVrF926NU49q9FJ1CEWHceYYMopTX/Zeu14B6AfPYAKG
ur7Zv87kvl4o9bO2/KEsqfKrfaTu3su9sU/YZGoglhwNavAwW6j8jJY8Yveldw8/
FmuB++5KqBftzgrmM08dHhMD4qOXntxPcx9QhSdbGHcZtQ/pgnLQX3TiAVRn3NPh
M2sOG2KnkBmfs9QPA/WruyqbDNsjj/7CHl+4fcm4G+Bp9xxIawH2h9R2D7QIWsMK
DcSUa0X3Z49DExcB7cfbl4eOjoglzDKI+Za2tIu2zDnW3XIxiLh1aOzeO4DuZMVy
8RE8Gbl7FFeQb1xGkzwkWMXbY/IAA1Ycoyl19APFT4LhmSKtleGS96egezlFFX75
9RNF/0ihn+ccVSdIoRbU/AgVy/11Cz3QX84OvRsbdwR+oLO2wUOqBKEvVcvquOzs
vKv2nC/vGKsb28YV9MoNV0lAzd+I89IzrDbun3z5h55Oz0t24kU=
=pnxY
-----END PGP SIGNATURE-----

--56p9wBiXEyg+KhLM--
