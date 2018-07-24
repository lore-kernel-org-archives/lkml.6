Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB18C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F8720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Gj2LFK91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F8720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeGXSHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:07:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44724 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbeGXSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=efFD0BCaHgyw+T/SwrjWZfz0LtStk2g2WGlxU4KlV5E=; b=Gj2LFK91q4zucaLcSmk6i2dnk
        yPk6fiL9YvF9wFlhm9NGkGI5yPQzGM9nSy0CIva8qMwxlOB9VMsyXcMjLDPfp3njgMopA6Z340Wlx
        AsyPtIB0NXjWGcaosrB5F41J5jSmwFTBCDtmFAy3RpgQK82zvNnpwM/Fd2A209CnLN9sk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fi0f0-0005gC-UQ; Tue, 24 Jul 2018 16:59:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A7F131123A86; Tue, 24 Jul 2018 17:59:42 +0100 (BST)
Date:   Tue, 24 Jul 2018 17:59:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180724165942.GP13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YolNsh7G+K7zsfIR"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YolNsh7G+K7zsfIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2018 at 08:43:46AM -0700, Doug Anderson wrote:
> On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:

> > There was also some other thing called command DB as well which was a
> > separate series.  Ideally there'd be a branch I could pull as there's a
> > build dependency on rpmh so I can't apply until the code has landed in
> > my tree, don't know what command DB is exactly.

> Yup.  That one landed in May and is already in mainline Linux.  Refer
> to commit 312416d9171a ("drivers: qcom: add command DB driver").

That's good at least - the cover letter said it was still under review,
guess it just hadn't been updated.

> Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
> can provide you with the branch.

Andy?

--YolNsh7G+K7zsfIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXWv0ACgkQJNaLcl1U
h9BuHgf9GRH5tb+1FbNT9oKVHDnQgIn4bP+9Wfh0QYbjjzaRVriOVKEOsImplY9A
L6DDe4zYGa8cyKNFMwf+Zy8nd2IT4pv2Ko1DsK4/iSkrfvT2GEi7u0S3g2ipv7Wc
xVZHtDJf3SYdsjefueAPydmUlndUASHoz7Cvs9RZmqJKo/5H2S9rRdjp/zZQM7bI
qO6h1RVB5sk/bfUB7AM9CfyWPCUNBdR6okiopiJywjLdrOcnPlfXbsIj2JPDzu4e
KdH7tEoejUOtYtrbflKplNt+NnNv7kGOF0v+6OO1MzlsHk3MH3BYtNNYwHZTBewX
XwHvI3U08/h54RUL2z0EViHU9PLk3g==
=hLlJ
-----END PGP SIGNATURE-----

--YolNsh7G+K7zsfIR--
