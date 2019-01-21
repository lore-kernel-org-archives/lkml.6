Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E352C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB732089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098248;
	bh=jq3hBUGkGtQvKoWLA4keT3q907kSVU4jSnqnQ1/HOI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3ohZHdcHtu4xSWhjns0O+KZBJN6p7by403Nf89WrAOQtrLthCP/BnliO+TrmNumo
	 ctNzcZBFalYBxfFeHCQFmqiaLoH/1zaFLuMm9Yh43U+TFqdoqAbegNZBMrf1nvwzrE
	 rJLofONzGzrL91lQEZMudbJq9b1hdLk81TZ8DADk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:17:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfAUTR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ABra2Yo/iHC4fPDYfvaIx5OgvEUCJZykRNiJqAZkwIg=; b=X34LuR4wVujh08d+GlOjUNrHF
        lO2iG5lUuedCqqleGk4fxaqKxLoyoQwBO7YCz+oFBMgQ/YKHjDl/3sYcU+Df4mBAQz346YNLo3LTk
        PnManeC5X/iI9H6ZSAEDBY/IQOtizNXufpDkmPFhJ3YWFA+E1eK5WN/IhJDIq1lUX2DBY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glf4N-0004zG-9u; Mon, 21 Jan 2019 19:17:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BB67C1127D00; Mon, 21 Jan 2019 19:17:14 +0000 (GMT)
Date:   Mon, 21 Jan 2019 19:17:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Matthias Reichl <hias@horus.com>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190121191714.GG12679@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 05:02:08PM -0600, Pierre-Louis Bossart wrote:

> This PROBE_DEFER support actually breaks the topology override that we've
> been relying on for SOF (and which has been in Mark's branch for some time
> now). This override helps us reuse machine drivers between legacy and
> SOF-based solutions.

> With the current code, the tests in soc_register_card() complain that the
> platform_name can't be tied to a component and stop the card registration,
> but that's mainly because the tests are done before the topology overrides
> are done in soc_check_tplg_fes(). Moving soc_check_tplg_fes() from
> soc_instantiate_card() to an earlier time in soc_register_card()
> works-around the problem but looks quite invasive (mutex lock, etc).

Right, I see.  I don't think there's going to be any non-invasive
solution here, either we need to stop overriding bits of the machine
driver relevant to binding in the topology files like this or we need to
look at the topology files in the probe deferral stuff so it's either
going to be very invasive for the machine driver or the core.  I'm
tempted to say that the machine driver is a better option here.

> This last assignment guarantees that memory will be allocated every time
> this function is called, and whatever overrides are done later will
> themselves be overridden by the new allocation. I am not sure what the
> intent was here, Curtis can you please double-check?

The intent is to avoid modifying statically allocated data so we can
tell the difference between pointers set up statically as init data and
those that are filled in at runtime.

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGGrkACgkQJNaLcl1U
h9BbKQf+J6unfU3lGiLZVjb2hKojpp7QoEMpMTY0qRP0NuUfiBlBrRpkIq3i9hR7
wBcqNI2lRBh3sb03R5kdkD2wDzw208wVDscH7ijeKp+k0UbZwkhNthr0U3+EJFt0
5j/yLk2fcNhMRnMvyucc0ChXQjsUsYLaCZIswO3FfSuFp3jOSHGx15Dc6E8yY8xQ
ziU8h02vga+M9RHBtGFcDDXlxmaPw50gWlDeMmkI9HsCYeB6N8xdmYNtj3t5XKS4
PiJTkvlFVKptngEK+5fzRJuluQijWGrkz3nDEOqMh/7m61GrIHm3lDpAsiFOq1Um
9/7KmsmyOJOgziIOwa7iIIFQJf1fEg==
=J68C
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
