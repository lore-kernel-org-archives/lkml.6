Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B7020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549313978;
	bh=G6rx6Uox3aB/VE4hHKNJhzBK07fDVi1ALoT+Izhs1mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FUm2JA3MCMiT2YLFkdisr7zc7pAYOX0rhS0gBrpn/bJ0vXX5YWmKrAKfiiWTRTVXU
	 BeP7J7+g7lSdZuj9tBymRQSqd4MSTBr+jGN7H840pqb8LI0Ru9YjrQT5huUDKvXyyU
	 D84iasxcNVIR0F2Gju9Wbh6VGiG6FtZiH8gz/vgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBDU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:59:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBDU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Cypi6Nm7kLGCX7Mv9+7bjDSldyEsPRepQ/bGOPmy+c=; b=uxP/fvBgkGE7RaleOq3Ij+hCT
        zwOhp2ceRcSWonY8PQZdrskzqHi3OAcihF3LBKeZcrK4nFlZ7jEqLX98XhGWbnPYfWOJP7IirEIFV
        9VeOBxm59GnoJGGqyfyMizUFq9hmT0ftrPFAYT6C+ZoKETvRpVEmvF/VNe/NtXR+/vgDY=;
Received: from [109.236.136.146] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqlL1-0006Wj-4r; Mon, 04 Feb 2019 20:59:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9C224440082; Mon,  4 Feb 2019 20:59:30 +0000 (GMT)
Date:   Mon, 4 Feb 2019 21:59:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190204205930.GK23441@sirena.org.uk>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
 <20190129224652.GB11349@centauri.lan>
 <20190204104347.GD23441@sirena.org.uk>
 <20190204160337.GG2387@tuxbook-pro>
 <20190204182321.GH23441@sirena.org.uk>
 <20190204192510.GZ31919@minitux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <20190204192510.GZ31919@minitux>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 11:25:10AM -0800, Bjorn Andersson wrote:
> On Mon 04 Feb 10:23 PST 2019, Mark Brown wrote:
> > On Mon, Feb 04, 2019 at 08:03:37AM -0800, Bjorn Andersson wrote:

> Okay, I don't see a big problem with expecting the DT to only contain
> values that the hardware can actually do. I do however see that
> machine_constraints_voltage() has been changes to expect the driver to
> return -ENOTRECOVERABLE when we don't have a way to query the voltage
> during probe.

> So there's a risk of this breaking compatibility with older dtb files on
> other boards. We will have to do some more verification on this.

That's basically only going to affect Qualcomm hardware FWIW, I had
thought that such devices didn't manage to probe with upstream before
that change either but I could be misremembering.

> > > regulator framework be made to round down to the previous valid step
> > > instead of up?

> > We definitely don't want to round voltages down, it is vastly more
> > common for devices to experience problems like brownouts if they go
> > under voltage so it'd be more likely to cause harm than good.

> We're 2mV off in this case, but it could have been way off. So I'm good
> with this position.

Never mind that that's 2mV assuming the regulator has perfect accuracy
and there's headroom.  For something like this it's likely not a problem
but some high current things (especially CPUs or anything like that) are
operating on thin margins.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYp68ACgkQJNaLcl1U
h9DL1Qf9ED2ORN4Cuibho/qUCZ5Vmyq+ZZRNIMfcx+diIXcc2K8kfEGbQRNOcaOC
XYV9xfdv0kf6wJmw/KSn78iOhBac6VpZDTV2HDytsNd97JKExcBB3w9KficyBWNz
3CxQIBsyrzrwXsAaXQwbqqSabaUL4GMdQaK2LutuzIti4mjT8bUNSzSvP55kK+PK
vp9IwHvDjIJppc0YyupME4lRsWHUAuK+TmJuTWfsuQOMwGPe9SUbwoBV/FU3QzJ9
p+1iRIDWN/G9TkRgo4MqhzAL1L1mTpOB0S9xk392sG4J8L4N7xk1Z6ZCBsT8sVXP
CglfiH5s9zVjbXlKyehlSRbgPqSskg==
=eM4M
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
