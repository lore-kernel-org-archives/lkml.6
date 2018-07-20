Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6957220856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="j4XvifKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6957220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeGTNUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:20:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59746 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbeGTNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+gQPDrjW/TUwMwO0HBjXIwtI7UJZ0CDxU/Zmxr9VQHQ=; b=j4XvifKk0k32BAHiCEjC5O3WT
        tKDd4iDZb5PjWINc8NWDvEfVnmuAqdkMsKV17UketWkRiBpeFfMCzYgm2x04dE+KA5AI57208ooIO
        7HO7qNrzTSeeyFQecxLyhNssB2AQrGSRIQ1crAQ8H4FnR1QFPntF7scNvbmkxCEZU9QUE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUaV-0008Nv-GN; Fri, 20 Jul 2018 12:32:47 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUaU-0006f9-NH; Fri, 20 Jul 2018 13:32:46 +0100
Date:   Fri, 20 Jul 2018 13:32:46 +0100
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
Message-ID: <20180720123246.GE10784@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
 <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk>
 <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
 <20180720114509.GA10784@sirena.org.uk>
 <CAKv+Gu8=M-EE11dZwcAzy1ZrnEoz=nF++v9bneY2SUq+e217Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8=M-EE11dZwcAzy1ZrnEoz=nF++v9bneY2SUq+e217Rg@mail.gmail.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 09:23:15PM +0900, Ard Biesheuvel wrote:
> On 20 July 2018 at 20:45, Mark Brown <broonie@kernel.org> wrote:

> > I have to confess I didn't look at their in tree driver, looking briefly
> > now it looks awfully like the hardware should be able to chain IV
> > generation together with encryption without bothering the CPU which
> > would be good enough.

> Indeed interesting. But afaict, that would still mean that the IV
> generation transform and the payload transform would be expressed as a
> single crypto algorithm, e.g., 'dm(essiv-foo(aes),gcm(aes)), or the DM
> layer would still need to be involved in sequencing one operation
> after the other, and I don't think any of that support is in the
> current series. But I'm just a drive by reviewer here, so please
> correct me if I am wrong.

Yeah, I'm also a bit of a drive by here and not seeing how the two are
joined up at present, but it may be a case of needing to get this and/or
other drivers fixed rather than the hardware lacking the capability.

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR1m0ACgkQJNaLcl1U
h9Ddagf+L3Ie/NQmFGA4skJRx+gcZZmaz+pVxtlZZIW0wKDG6zBvZb5KOBH7ew6k
eWoAkhOVbYLQMthitWB94veldP3pAd35BcriA5yM/LEN/qFNtms/Gdqte6DWPt1m
5qnXpK8vekpQz3nI4Y2C7X/sx0XHls6FCrR5vAZ/fb5/Rth4TVCt7EAnsXYWW/Lm
oBqhugqTDFe9c3RusH/g1U006/VKFCdQ8tn/aKS/sdoEgQtaav2si8pSiM1IvOf1
pfWAFqdNs9pMX3rXVxcP7Nl5Bn9dCR5kD8+vmA9bJ9dzThKrxOY+RKiYQx/3aRhq
AGkgAnMOIWf2mDkITYWkRRv0XiWAwg==
=FeZe
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
