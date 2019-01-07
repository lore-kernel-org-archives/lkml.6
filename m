Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90202C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CB12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546883742;
	bh=3PdE8HkYnxO00KRDKzzo/0L/bCUPEMsfy/q79Q1Wzgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i761uszQsbZDvbx4sWNfQSsBPIaUdlIOTY0Nn9CkirIHMhIlB3jyqtTuSexabBUMa
	 Ja32+T4Wf9/JrrLkW4HxfPXrS1Yn5m6bKBxaHuTmh9F3g9mPPrH2+qL9Vh56ARiyRU
	 1QKiGRqScXOIvSG4xnBePiclYuDC2/+o8IjCRg6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfAGRzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:55:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfAGRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3PdE8HkYnxO00KRDKzzo/0L/bCUPEMsfy/q79Q1Wzgs=; b=hGbXywoElBQylHp7s+k2nz3tF
        PJJjLO/K4cYddlY9PvPPG8b0SWi/oigFH+YuwXne740xja1yL/ShjFr6u/r+V/2d7HVxWTMk8JUBK
        n7opt4tq5L63oe8YmexIEca56XberfVw2hwVTTiUpZico5Fnx9yNuA+YdDRBinjbi+cKw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggZ7b-0007ab-JE; Mon, 07 Jan 2019 17:55:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 14BAF1127491; Mon,  7 Jan 2019 17:55:31 +0000 (GMT)
Date:   Mon, 7 Jan 2019 17:55:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Message-ID: <20190107175531.GN9570@sirena.org.uk>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-4-anders.roxell@linaro.org>
 <20190107144356.GB46743@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7VkxxUl3xUvPtoxk"
Content-Disposition: inline
In-Reply-To: <20190107144356.GB46743@lakrids.cambridge.arm.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7VkxxUl3xUvPtoxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 02:43:57PM +0000, Mark Rutland wrote:

> Is it possible to use an allyesconfig rather than an allmodconfig? That
> would leave all relevant options built-in.

The allyesconfig would make it more difficult to apply this approach to
real hardware which is part of the goal here - the idea was to come up
with a way of making runnable configurations which are likely to be
usable with random userspace testsuites in order to avoid needing ever
expanding combinations of builds.

--7VkxxUl3xUvPtoxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzkpIACgkQJNaLcl1U
h9Bb0Qf/fdF9RcX9SaLp2k0IMZ1Lg9JMd5hlJ9YKA/TzRigA6SXtqWYGvoQOUT8o
3w4IJNFvrqmxhd1yPI45xH13Mb//TQU3nbUC2x611vlvym0AspERT7HNZy4gIZXM
HGe+G9kAWLW7kTeJDQi2kh/wf9axInPomnG9kGdM+vl/LW0Z+R0P1Ec0BDRtQCYM
W62NBh5dEEPNzOHq6uJi//yH3+ddUN5zTVRU2Wz0joEjBhMekgucU34IZmiNFGZ6
hF5epTqp2HKWYcLZJDPUpMgci5wj+xSL5d1Yq2loZNTjlwHtivaoaVvgiiwT0/Qg
n0Q4o4Am6J+tIuXFDgE1AJic8uYohQ==
=Q+A3
-----END PGP SIGNATURE-----

--7VkxxUl3xUvPtoxk--
