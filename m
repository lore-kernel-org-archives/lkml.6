Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22479C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xcmSEWSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeGaPbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:31:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbeGaPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tc8bnuCp2VlhJ2A1pqvCxDo9L3yX7cq0oruy0L9vN0s=; b=xcmSEWShvnpOrMEAyqRZlBCLf
        qgQsc/HdTGlHZ4rKBJhb0boOg1nr7yIsLtB3zichXglgsJJw7VxVB3XUgAfUXnrIggx0Qf7Fkz2Jo
        LbEDqSqzIZZvglPbCs6Ib8J45M7FrDHzw00DuzE3XBC/WCzk8sJTQIdIECVzDz6yFMaN4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkV3T-0007BJ-LV; Tue, 31 Jul 2018 13:51:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2D19011242BD; Tue, 31 Jul 2018 14:51:15 +0100 (BST)
Date:   Tue, 31 Jul 2018 14:51:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Message-ID: <20180731135115.GD5719@sirena.org.uk>
References: <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
 <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <s5hin4vpm80.wl-tiwai@suse.de>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:29:35PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > > However since it's not supposed to be providing any DMA a CPU DAI really
> > > > shouldn't be doing this...

> > > Well, if so, the CPU dai also cannot get the exact base delay
> > > corresponding to the reported position, either, no?

> > It can know how much delay it's adding internally between its input and
> > output, which feeds into the overall delay experienced by the user.

> But isn't it merely the additional delay that should be applied on top
> of the existing runtime->delay?

Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
delay something is confused.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgaVIACgkQJNaLcl1U
h9Dc/gf8DM00LYsmfSfREWDEZOQ1LLvo4bi8nuYkoSUTGC/fkCvSgUj732kSvkAY
aPaZqrlhMZf+aedlU2+8TCRu/MMUszefetX6N8/gYBAmHWS2Bo2mEnljNZD+zrP/
oisktLeeIK0W5HX7Rafoij3KM79QqD2VZusExUGH+GIVKuj6bWmIx2kBjULSsuft
XCJWmWiYx9KlM2WQR0djpW+5NPKbymLVmcYgPRcR21reY8umeG2z9noMrtIcaNYy
mdH7ioFzJ5aqdgK90AMoFgj+apDhcdhC8D8gkxQhV6EmiwxrelanrTSnQ7N6EtMh
LcM8hvc1692eypMzlAYeCRBrEbF+OQ==
=baWl
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
