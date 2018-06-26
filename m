Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC37C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA526CBF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aYzFcSXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFA526CBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeFZPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:02:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeFZPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mq17/JEtJwdyhKCWzjgkU/O+F8p2TwY8sv1zAVytxF8=; b=aYzFcSXtG4xUVOvmqATpv3eek
        0NNQR7xru0V3gLzKh9h4N/D7EyjYxPIXDC3cF2T0gIWT0yxO5P0rK1SmUrieQr9bm0t0nHE2C3yKr
        gzLARW6/u0pVCKuFdND6ti7RnpCnotSJdAm1Tr0HeW3qbH6dK38/CcWrqKRhNxZU8Y84I=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpTo-0001If-JM; Tue, 26 Jun 2018 15:02:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 07A5D440070; Tue, 26 Jun 2018 16:02:03 +0100 (BST)
Date:   Tue, 26 Jun 2018 16:02:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180626150203.GG1779@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
X-Cookie: PARDON me, am I speaking ENGLISH?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 08:00:29AM -0700, Doug Anderson wrote:
> On Tue, Jun 26, 2018 at 5:07 AM, Mark Brown <broonie@kernel.org> wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing
> > commits creates problems for other users building on top of those
> > commits so it's best practice to only change pubished git commits if
> > absolutely essential.

> Sorry, wasn't suggesting making any changes to those two patches, just
> was noting the dependency.  ...but, as you said, the two dependent
> patches have already landed and I just didn't notice.  :(  Sorry for
> the noise.

Ah, so there's no revisions that need merging?  That's great.

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsyVWsACgkQJNaLcl1U
h9CDEAf+Pbvqs48x4tcqT7Atu+4CmeFPJV6gwT13W9WALxT5iQogIEqnt1z3xW6v
sT99T2zLaOGvWGePgRArCIetPeJi8UA3bN45ebyVk8zNtnpEXuqyGlftdf3B+z52
fCppk5Uv3XuT2VQlftI0qaEihoMyPsfG93JUOp08GRDl8idaLIW2W1CVR8+SNv1k
35HUXZKpBqxmJ0v6ZN5InUAAnMV49xg/Y8QqVElsoceCrIWZ95W8ZXoKzH3SMHh3
uCPkji+mxXOUVkoNTgB66NxBdkb/osPHj6KfFTmOwFfHGRXar046i7IC+1E8V3tm
7AOaBwyL0hfj3y27XU6dANvPNhiNgw==
=yAFQ
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
