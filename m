Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564A32084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="X+Ox1Ozq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564A32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeGSQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:34:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbeGSQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vLyw1SsoaeMDzmkyVq8pGY2miK9Femw9YTS2Xes9JeM=; b=X+Ox1OzqpgRUA02RaXShVuRSG
        bXMJYCFpHYLXg7S7eBaNHe0FyHg1lpoWvHx7wC6NZw4UzctGhahUc6r5R2j0L0y074aFgDTZT14b2
        AJlmaV8lo+yG0VN6yYv3VdiqBLk4uGTZQNbqEzyo+yi0MOoFItT0cn/XcGf8dn1ygORuk=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgBCF-0007Cq-H0; Thu, 19 Jul 2018 15:50:27 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgBCE-0003bv-NA; Thu, 19 Jul 2018 16:50:26 +0100
Date:   Thu, 19 Jul 2018 16:50:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
Message-ID: <20180719155026.GF27938@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
 <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
X-Cookie: I'm having an emotional outburst!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 11:08:52PM +0900, Ard Biesheuvel wrote:

> But this will only be the case if the accelerator is capable of doing
> the IV generation and en/decryption of multiple contiguous sectors in
> a single call. Otherwise, you are just shifting work from one layer to
> the next.

> So at this point, it would be useful to clarify what exactly these
> accelerators are doing and how.

Existing hardware can definitely do the IV generation and I believe that
it can chain multiple sectors together though I'd need to confirm this,
as mentioned elsewhere in the thread the ccree driver is for one of
the relevant devices.  I've poked some relevant people.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQs0EACgkQJNaLcl1U
h9B4vQf/YQkCshhwsHWovL39lwKZHpo1OAVwFfEhHS0hainP8pDsnrikXQKO++hn
XVhUHjaRxdb0Zx/lHAuTVU2dd1K00VoR7udX7u++YaCBJjviVSWvZzPoxIpo+vd4
1zfjLv3YeLD+Yy7fvLkJiVf114bBWfz/Y4sSiNUhVAxL3AgcRgs36ZA1HS+TghJX
bs98y1sGwT96emHDT55S7t2jP8fYdD6mJBKvxcS+MT046HDOSEv4+ZtylOI3Nl8w
Uz7udiikFKRtKwlaPX8YGEnUEqJyi8uoquNC/QVo8yYCxsVx+J/Go6z//EjtAlRD
+djfP5QXtifKs3spBqRcKZm4gPpyWg==
=ZoTL
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
