Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8852C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1712173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546884633;
	bh=hSWicu7qShBovi0rWWwy9Nln1mor1kBXG+LpRR6I0fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WsC4l9Vc6t3qGLgrMB9Ge+Lk7P6Fr9KUcXR6RLHAVUPEGiXtbg+dAl2vOa5LF7cV5
	 /mDoMgVpvl0z2GXbj/PtIC5A5U7COlWhBIONsWMiwR0iYR5gwO1B+XbmbJfaJpW0nE
	 1VAoNSutDXJEwpVkHTfR9WduIVZlX+TVrCLTki3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfAGSKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:10:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45114 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfAGSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gnu1hmlGA/vVBDC0dsXpy9QyXBtYA3GNQ/azF52kC1I=; b=TVLFYf7G0ygCD6/Zp0wtz4+t7
        qwPuvCQtAIbSBD4GltQFWrO20D2LMryJZqr9IptTk0dtNqZS87jmR76SpVmoH+iZQ51rdpjdoImV3
        1fl8aSZSJJASUQ6BOKLX0wgCsRBsM7/0mzEs9eeI3YBjB+qRCJ0NRhuQyioc3D47yEKxk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggZLv-0007bW-Ba; Mon, 07 Jan 2019 18:10:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EA7B01127491; Mon,  7 Jan 2019 18:10:18 +0000 (GMT)
Date:   Mon, 7 Jan 2019 18:10:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: atom: fix a missing check  of
 snd_pcm_lib_malloc_pages
Message-ID: <20190107181018.GQ9570@sirena.org.uk>
References: <20181226022950.71824-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="de1H0RjRxOSdb4we"
Content-Disposition: inline
In-Reply-To: <20181226022950.71824-1-kjlu@umn.edu>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--de1H0RjRxOSdb4we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 25, 2018 at 08:29:48PM -0600, Kangjie Lu wrote:
> snd_pcm_lib_malloc_pages() may fail, so let's check its status and
> return its error code upstream.


Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--de1H0RjRxOSdb4we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzlgoACgkQJNaLcl1U
h9ANhQgAhHbiwBS6b8x9Tn9JFl0iCcDZB3svIqny+Ef/LSlGRHidf/5/e+bAKf2/
3REHixLpaTnnNpPlAyq+oJZkclpY7lz/WgTfAoW+JPtCkb5CA/XokaPa1pu8zBYR
WYLGU5MjckgX08S7Hx1gR+Kmy6TXSHm4CWhbjfL6SaVvaCLB7Sfnnk6KGygUC2FD
7tEPxKd0bpLwQGU+G3WSA+gHeNrTNjgnf8Fq1EfRYvOUWiz3DRw4n4X19T18Cfp4
+nuaEKZVSlEhtq6K1BUvab334bJbyWG85f0kxNjVOy301rmKKc43gwvcMyxKa1Ke
cRSTNPd2J870DwhQMfKVUGwMDuofRA==
=UU+m
-----END PGP SIGNATURE-----

--de1H0RjRxOSdb4we--
