Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75903C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D23B24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Xp6l/Eg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D23B24053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGEQx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:53:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36850 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbeGEQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4i6CP8qvzOc8aK5oILkdskJPKDvOjK7N7JN58M6XB04=; b=Xp6l/Eg0SJ8oHkzsyjvqOI4vQ
        RA0xpkwgMgRU768AHir/6al5PipbzEgc+knZkAR3y4ZE2g2nLzZwm0cPaKspCygIRHNeLHrVthSNJ
        UzbNJvvfVVd/yOhX7/v5R7po1c29ompLsUS1ffsktYXo1PtP678hhCeKE894/cMncU3vI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7Vw-00010I-Fu; Thu, 05 Jul 2018 16:53:52 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7Vv-00080c-Mq; Thu, 05 Jul 2018 17:53:51 +0100
Date:   Thu, 5 Jul 2018 17:53:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 2/3] regulator: core: Link consumer with regulator driver
Message-ID: <20180705165351.GD6227@sirena.org.uk>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
 <1530800748-7300-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <1530800748-7300-3-git-send-email-p.paillet@st.com>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 02:25:56PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
>=20
> Add a device link between the consumer and the driver so that
> the consumer is not suspended before the driver. The goal is to avoid
> implementing suspend_late ops in regulator drivers.

This looks good but I'll wait for Greg's review of the link
functionality - Greg, is it OK to apply this via the regulator tree or
do you want a shared branch?

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+TR4ACgkQJNaLcl1U
h9DMlgf+LT+2at1qHH7u4f0xHBt7V7/+EuJLHM545rS2Mzpl0tXhsHNnUR6AZggn
My0Grysu2WRWBBy3qKSnyyMOaa0xKFywi6wBq6YxXIUM+DU0AMb6WCflqjNd292R
BiipxX3flpdXKFqskQ46jWl40LEM+5Pkj4VP/Pztrqh7Liz7eg7NftcIBzgdvoev
TnRMq2ubIfeicOZiWZuc5j+dIgYgVsuL3oQ32do5o3IVk1+T87F7eW5I6v4Gemjq
AWfYJeTNEHOE8avEflX3f+oKP8OVlYI6znRrmy4g5F29P0mi5XGg2TVLoL7Fh/1Q
Vczu/1ZCLavAG5/tzy41ZDE5pOB0hw==
=aCvA
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
