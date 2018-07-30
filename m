Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE2160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC52E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nev79Gk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC52E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeG3R0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:26:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3R0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39UWZlaENiMVCVW7qWAmuCrsiRZX+MVMWcEajdLTXYU=; b=nev79Gk0A26wS8p5QhnaZhlj4
        4zpVxVnhZPF5bKNdTWEgG9UPBEoddRW+uf/rVtLaF8q/vXMTkqHeIFHcItYmuitV8OKr1R5VTKBFJ
        fRRBiMtZKxW1MmwtvBf8MRDwe6LJt8qIQbklOgxGO2h75JhRH/iTp7gw48cE54idUCT34=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkARL-0005Xo-5B; Mon, 30 Jul 2018 15:50:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A542B1124216; Mon, 30 Jul 2018 16:50:30 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:50:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Message-ID: <20180730155030.GP5789@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
In-Reply-To: <s5hy3dsviwq.wl-tiwai@suse.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 05:32:21PM +0200, Takashi Iwai wrote:

> That said, if delay callback of CPU dai provides the additional delay,
> the patch does correct thing.  OTOH, if CPU dai provides the base
> delay instead, we need to clarify that it's rather a must; the delay
> calculation in pointer callback becomes bogus in this scenario.

Part of the theory here is that every component might have a delay
independently of the rest and we need to add them all together to figure
out what the system as a whole will see.  Personally I'd rather just
have everything use a callack consistently to avoid confusion.

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfM8UACgkQJNaLcl1U
h9DFvgf8CsHe8dwNrqBV/SvhEF+GoCuFHKSytnDQS+PduypJLUCWCUm06M5vZPmP
BzUOccYZ79pB/dp6jEJuDIk2Ptyz90r0DffH3gWZHJAIofaf7ct15PK7M3ilrLKm
Nc0vCWubhuBpl1adUR7gCMR+TMNi7tv12uFJX9b6j2UFC1MOHECeYBpKMlyWmELd
LE3ubFx6Yz/pkP6jhDq5OMxVDH7xQwr+wHNmv/1t6Uh4P+E3fFpk2KL3ak+Q3Rjr
vaMISlB/JuS15ChTrMnE0eZQxez3LVgCbs3PGC/MFAFnzcvTdnTdI63csSeMUJZB
q6X5w7EQQhNjESTGh/vnxSwtXLvNSQ==
=3qh7
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--
