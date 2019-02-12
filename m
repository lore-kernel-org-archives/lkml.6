Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87657C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D47217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549989643;
	bh=ORI4y+C9xoY26bBvPfFOC3weWW877jST43vuF3J/keg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbZTOGgfxJQ9v5gjYwQ8Mgzj1cYmcoyhdoszLXZvJhlVjVtq49BCBGJREIDkKzO1a
	 v/gs0fPFBe/aHlf6SskSwjH+LUBvlOMiyL++lcVolwOa5WSsj0qtgsMKLoSab66K2q
	 AGaPUIYN/24/TsuHXOh8EpeZ8vJxnWPrjtyln7WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfBLQkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:40:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jWhiT/J6Y/6zu5pgPDYApmcNMauy1eWiVz3Up27hU6s=; b=QF/DH6nUlA4BoY0Yp+7wcWjxj
        W2iPfJZFVauk4viQbIDaQquFJp5GbRWcMgjXyM2wqOGEzEQS4OszyBkQnMmPVDj8lTv+1UwZ8WUq0
        nHBAnUCh2uWHjMuddLyf77f9Mdd392dD3tZTdkYwJ3XtNMBBdnZgJDUnqgV9FF7VfIX20=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtb6n-0005aY-Eu; Tue, 12 Feb 2019 16:40:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C9C9E1128113; Tue, 12 Feb 2019 16:40:32 +0000 (GMT)
Date:   Tue, 12 Feb 2019 16:40:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 00/22] ASoC: dmaengine updates, secondary CPU DAI for
 Odroid boards
Message-ID: <20190212164032.GH20635@sirena.org.uk>
References: <CGME20190207170044epcas2p3d00762663b971845bc86db84af7d3b23@epcas2p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20190207170028.720-1-s.nawrocki@samsung.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 06:00:08PM +0100, Sylwester Nawrocki wrote:

> I am not entirely sure we should be removing the
> SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag like this, it might all
> be a bit more explicit with the flag.

I'm fairly happy with what you're doing here and the Samsung driver is
the only user so the view of people working on that is pretty important
here.  I've gone ahead and applied the first few patches so they don't
need rereviewing, the rest looked fine modulo the comments from
Krzysztof.

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi9wAACgkQJNaLcl1U
h9BbpAf/S411sGXBqmjs6Jtx2jz3XpgIIjk+NWpojHOspH+IxcPXg80qre60i4+l
LSgxhHK0Z6gHVKYr/xDJVF8+BMwZhbb1s/3G4Sv82JeQan4cCrFcXsy2jf3ePJjm
PSGzEi0eEBFqsIbFrsD7rC7UANZ3mKlLWkwfDhdH9V9m4Xq5WCfRvy531WJP+73I
rl4LKj0lnYnBd9AeVSAmqaAXwLvOFoeHBxAi1OCDufakDNbjA0r153fFLQ3aCSG9
otz6eVRta8xiV9/sEtKLC136fuKhy/FKjkGPkprFAAGOOCrbYjaXP33qMFzH3i/1
7L5eVQCACbaIl+LnzVOiqUn+Vd+ofA==
=i+P6
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
