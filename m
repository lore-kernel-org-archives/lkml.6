Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6132AC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E5E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pobvoXCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKTXbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:31:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTXbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=By1XcD31rX/VPT7M9w25J7fJhEmJOCMqmsU+wmh5StE=; b=pobvoXCkoQsaKWHNQcYq8EB07
        COJk50c0E9pM55Uolsd977jAvP2dH1Z3Vt29UzZWHSMzb/md6otT9awKTPcmMoAlESaF/MOtXwx9E
        9jQqQ+qK4qs0weqxHqEsEjTi8dms8X2AsP/Kr2EW6DN1FY3pK+KCf4teds4Z5hQ5a3rXg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP5fP-0001ch-HG; Tue, 20 Nov 2018 13:02:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EC2EF1124DC1; Tue, 20 Nov 2018 13:02:10 +0000 (GMT)
Date:   Tue, 20 Nov 2018 13:02:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     olof@lixom.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-spi@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: npcm: fix uninitialized 'val' warning in
 receive function
Message-ID: <20181120130210.GA3894@sirena.org.uk>
References: <20181118123504.83082-1-tmaimon77@gmail.com>
 <20181118123504.83082-2-tmaimon77@gmail.com>
 <CAOesGMjUJ1+qmbPWcVFm1F_F0fcdg-54YY6o4iK=PYWoAuEczA@mail.gmail.com>
 <CAP6Zq1j46ch8UUxJkO7SnrHWyP3Y7g58Fodejr98WN-TW8jhEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1j46ch8UUxJkO7SnrHWyP3Y7g58Fodejr98WN-TW8jhEw@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 12:51:19PM +0200, Tomer Maimon wrote:

> We just tried to reduce the number of lines to minimum, so we have debug it
> quite a lot (with all the numbers that can
> get from priv->tx_bytes) and the only numbers that minimum function return
> are 0, 1 or 2.

> But in the end of the day,  we don't have an issue with your solution as
> long it will be done also in the transfer function.

In general it's better to have the code be obviously correct than to try
to push down the line count - it saves people the effort of figuring out
if things are safe every time they look at it.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0BdAACgkQJNaLcl1U
h9ASIQf/cI3kpprBTkLEFxruAQbRVP4iqcAlySu6P7KxALXVKRtjn5bSW6zo68KR
pdQQSaIy69W6iehi7+9YacuKmtJcDiqfRItJLuj5FK4PM0Wfv5SjLEs5oS5SahGi
+CZsjlLWD7IKm/eiBfgpujOh1SuuAhJd0VuuEFkWE9ICbZWqaXYNTa4+5UVjwKPJ
FQqUz1BO7UYUZ9rsECcO0IpJBThxcdSrSl3UV5CAivmve0HEo3FTD6Os9wO8wAx1
e5+3m35TBPjUatI3kdyB9PrQNSroqgGe5Ou3atz7GXwXPR5eA0Zt391/0I53kPsx
vc11Ia8qPkKFJBlJQKYJRNzdRMdBXw==
=b+mA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
