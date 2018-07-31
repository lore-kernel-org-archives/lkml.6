Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB177208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jRxq3ddB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB177208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeGaOxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:53:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbeGaOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R3h1QxgJZjCD4XNYi4rK5Ff9barRj8V9KaHTytEBu9g=; b=jRxq3ddBhuAfEI6Sur7TLu8YQ
        Fhtoh6TIKLDfqhms3lPGHoUgv3vnF5BmoDx63jaLoRd0rVKf06kH9oaR0UPwJGaqK4HYtTzVXPD3+
        XDboVCJwdGMPmq83ZGcLjh3zXv7T8vFqc9Svt5IOMPk9XpVNToQcdF92mxbRSRoS4zixk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkUSF-00077b-It; Tue, 31 Jul 2018 13:12:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F334611242BD; Tue, 31 Jul 2018 14:12:46 +0100 (BST)
Date:   Tue, 31 Jul 2018 14:12:46 +0100
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
Message-ID: <20180731131246.GC5719@sirena.org.uk>
References: <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <s5heffjr8ys.wl-tiwai@suse.de>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 12:32:59PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > However since it's not supposed to be providing any DMA a CPU DAI really
> > shouldn't be doing this...

> Well, if so, the CPU dai also cannot get the exact base delay
> corresponding to the reported position, either, no?

It can know how much delay it's adding internally between its input and
output, which feeds into the overall delay experienced by the user.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgYE4ACgkQJNaLcl1U
h9DswQf9GWUANKQgU6UT1mqpQLQHXWUl9Jckdv0IvNpbNN68xcHif4AWvvHQ3gaI
127uYUDWgwBdQZ7vr8DS2N0D33IzdkhB2jlWfLyueG512IGrSSSjAAI6BnKrRng9
/TEb39JwG9ITu7wDj2fdP/qK2cJ0V6YnCZtH6HTQfs2w+sn9PD+0bjgwE2GdhCy+
jABd2IgOUyKTC/zNnunIivL/1oU4aVRUCdfyKil7B6HEAhVVVB3PIB7Ow42j68JY
7B39V99ZNv0N083I30w/fQ3wzQu6IHs3iy3s5VcDgfkFWuEMcTbHNhE+OY5owuG/
NI74av/DHJ2qeTYd/RtTxqvPeJs2Kw==
=Zrxu
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
