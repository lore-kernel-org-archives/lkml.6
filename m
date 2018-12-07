Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A07C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544185214;
	bh=smLM+6qmCkCXOmfp5ZWTGkhkALdAtrlVBTNdiVJB7nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tHHgxPGhEVaaIPQUCqcE95mZy2ThHFysLEgOHbmxuX68kSKWLFikkIAgbEy0AKUY4
	 wqfmogsN3g0pCsgNEgbZMQ/3I9MqfdzBfxgUqPoRkVYaoIrIen8FxOjO/rD7s9RRGV
	 N7XmkSmZ/WkzyH6BuuZBvuy3H5FU3ua5nyjSBATA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A07C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:20:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+ljOUMt+jrk+AUGEv7cGwUjuKneZ3/jvy6CpOs3AX90=; b=E95Fdex+Mbvq+/qUdR27deRB6
        StUNvKWHbGuQi0oHbuYy8CG0ui2WRiFO5tZFvDKaixeVUV99yjh3ChTaXL7AgiVPQOJbAo0ebmtKI
        XYrOTnOTvjuPbvxNqtarJ1IGbyd0Y/mFVGI+w9pXb/cvKGjJwdEt8nL35xVokwsDFS3Nw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gVF6p-0003XV-EY; Fri, 07 Dec 2018 12:19:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0F09E11253E4; Fri,  7 Dec 2018 12:19:55 +0000 (GMT)
Date:   Fri, 7 Dec 2018 12:19:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pascal PAILLET-LME <p.paillet@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20181207121955.GA6510@sirena.org.uk>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell>
 <5C069C47.6080305@st.com>
 <20181205093604.GZ26661@dell>
 <5C07F08B.2010701@st.com>
 <20181207073132.GH26661@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20181207073132.GH26661@dell>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 07:31:32AM +0000, Lee Jones wrote:
> On Wed, 05 Dec 2018, Pascal PAILLET-LME wrote:

> > Hi Lee, I have received an email from Mark telliing that the regulator=
=20
> > patch is applied on

> >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git=
 =20

> > I can see it on the branch regul/for-next.

> Does your patch tracker only reply to the author?

> Any reason why I don't see it?

It gets sent to anyone in patchwork.  It is possible there was some
problem talking to patchwork, or that your mail system has filtered the
mail.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwKZWgACgkQJNaLcl1U
h9AqYQf/fPoVMFiBpJfNs61lytyuCMioJQadwRdtqBibh0un2085zKHfasON6BKV
kFClkPGK0IVumMf0oAFEgUKCnq7cdAYKw9lIUs9n1cceblbjGDbKaTJlarP7SVWT
EI6seMHKTYM3k6+CLwYY9EplerQ+1uDZ1wrMCB7THjElUPwFIgk2ITxOmqwQsbqa
4H8vGI9SKmcRFj/Rf23oFlb541cSI+/QXSvQTlzaidz2EZxs8tQoNP8p0JVMoieh
BSSnNwP7EBWxYYJoa0U6grg9yZ26Q5fz24/w0KY42DDEskdB8k36YYoTtPeYReLR
Ig0Y7rO4nP2vuK4U14OofITZiDspWg==
=+5Lu
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
