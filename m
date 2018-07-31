Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE1208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ASpEQeEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCE1208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeGaL73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:59:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CvSty1wZlLwS4OxglbVMARfzfOT8CQv2RNwH5bg4YyQ=; b=ASpEQeEaGgi5Fo1R4P5kauW42
        Hoz7u48n5U9FZ5muEBxBeEEPGYSOxexLdNOYhpiL/u+cqHZsZnwLdVyuqQqnMBkkBKKvqcUlecWSN
        tqPMk7r3prkSmeygPUil32CztnXj2RR+cCqbMMJs/XQvdiPNlfG6N3q2lcHLfUWjTSzt8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkRkl-0006uU-W3; Tue, 31 Jul 2018 10:19:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A74DA11242BD; Tue, 31 Jul 2018 11:19:43 +0100 (BST)
Date:   Tue, 31 Jul 2018 11:19:43 +0100
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
Message-ID: <20180731101943.GB5719@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <s5ha7q721vs.wl-tiwai@suse.de>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 11:25:11AM +0200, Takashi Iwai wrote:

> It's not necessary that all CPU dais provide the pointer callback.
> My suggestion is that, if CPU dai *wants* to provide the base delay,
> it must be tied with the position value, hence it should provide the
> pointer callback.  If CPU dai has a pointer callback,
> snd_soc_pcm_pointer() skips the component pointer callback but uses
> CPU dai pointer callback instead.

However since it's not supposed to be providing any DMA a CPU DAI really
shouldn't be doing this...

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgN74ACgkQJNaLcl1U
h9CQ4gf/RXoOOGmwEbj68LmfJRHuo044hHK6wY62bwec5FoeGWMy9Pk3rvq7tvHc
f/7DFEYQRTB/d4cyEDUQiqm1eHIFhI8sohOWaRWJr28k8eQYkM1uA8KxJ5b11OF3
LQKCNqhLjVYpi+MgVJAe4OqE4t3B5tCwVzXfBZsI2zFeFBJztMYw9gcly/dpIhVt
3PVTpXzPcQckxgu/e9Edc5lOmEEL9uid+xEH0jpgq8I1OI1gBu/pJqME3+N/iGwF
SetGm1Z53pPTbn1+Kxy5PLnrSuxbKEB3pPxnIJOHCIlGnwaTzbzg0iTPg545fh35
fK6d90zXpQBsJr6i4clAskVJAoZEOA==
=S/fZ
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
