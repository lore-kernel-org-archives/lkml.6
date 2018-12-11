Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49514C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AEC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIoyo/lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AEC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLKKIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:08:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35470 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeLKKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:08:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so12032186edx.2;
        Tue, 11 Dec 2018 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/lPT8PaFurXAjyHVr34gJC59b0hP9R1KpUmpqWNP30=;
        b=SIoyo/lNrRSFm6Euc2fMO89PpKxGQu3x70wRXEDIhlQW3BhDmwXrYMlQRAbOpzbKyZ
         AkcUvP4KF5kpsosDvtpj7pXjYRjmIIRMXslqgB4Hse0RF1u2aWEKGWRwnlUPsFch7apE
         RExQaIKQBQQwvVg009og18OsMcxioC7ji/LRyw/3PHrjiPNwSjxScoIIHgqEDTmjLykn
         0g3UyTRz3nMyZGA921Hp7xPJ5J0Rwhn6KZGTktF6MECeO0HilVMF8WgyTti35rXl3193
         +DR5I+iay2tutrlFiEYmMfgHIdAIUNfXGjitAIWASlmdYTQSltH1ZfeOBzL8yQfTMRWd
         +O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/lPT8PaFurXAjyHVr34gJC59b0hP9R1KpUmpqWNP30=;
        b=E02KkHB9guMngQDTlh77offCaLS3+xlVAmlEisXswAGbNaJN6ol5+mq0k+hkR8vLa9
         Z1UIdeorffPgZTO++NABsAJP6+w2xWkGSGkLEkwg48TocudTFpGgMey+Hg7784eqSApr
         wVWP9/GhbkTmfvt2iiq3Bp2/Zxp3Msjiolf/6CaJv+KKN/2GsAhiwVuysn9x3d3KcXec
         sAld0RCcYus40yFLfk2hezWlORTnxMA9JdTJIqtv0e1LkpnaMYVqm82AYH1gpaCwOHFA
         fhkko7JVWxYTVAb96Q/hRxDQj1BoFd4v2Pft//niWkCfbN5AU0wpAq701d6yhD0xhi9q
         2Eew==
X-Gm-Message-State: AA+aEWYwErTaRlV9Zk/b/073apHIvaft0xizkbaPx0KLaiJLGFOQMJ53
        CUKuwRj+KDrLXHEECsfSs9w=
X-Google-Smtp-Source: AFSGD/U05q0wG9Jai33f48xk3AgDfm/xa1bY6kw0SoJS1Rhz5zbUjJyY3R2dMxYSQWeLp//dM/Pl+A==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr13695312edi.246.1544522914428;
        Tue, 11 Dec 2018 02:08:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z9sm4060180edr.61.2018.12.11.02.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:08:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:08:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Dmitry Osipenko <digetx@gmail.com>,
        Emil Goode <emil.fsw@goode.io>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] host1x: cdma: use completion instead of semaphore
Message-ID: <20181211100832.GE14426@ulmo>
References: <20181210215119.1903413-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20181210215119.1903413-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:51:04PM +0100, Arnd Bergmann wrote:
> In this usage, the two are completely equivalent, but the
> completion documents better what is going on, and we generally
> try to avoid semaphores these days.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/host1x/cdma.c | 6 +++---
>  drivers/gpu/host1x/cdma.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

My understanding is that potentially many userspace processes could be
blocking on this, which I think is the reason for it being a semaphore.
Is the completion going to work for those cases as well?

Thierry

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPjKAACgkQ3SOs138+
s6F4YA//cuiEcBrx+Cqz4xqncvpwk/VeJ6Ag2er4y2er5lZL5OWJbSdKQuhw8ns7
l1OQ3VLF0Js9hLaDLEfdgxR3zzu0Ok5cyKeUH0bC1VZ8ces8ER1xHK24W7YeINAn
ST8okJEV97mSHiiWe/p8nrYq5iIH7giUb9iZT57AX+6nxGAcg+XJ2gietauU2RUB
RFSOcO2AQboWC9CWCcY0sW04IIP2+z4CMLeRDbe1TIGZzgyuG1p/WEuMqQ0AN+qv
njAP8w9OyW1cltuoLqthFmdScsqc30H22RI/dISgFlLdYgu5PeGeYUeO5P+RB0Js
iHk8T/wsr7+HTfnfpxZXYJnA1YtvIGEVe7RkTscAYjm9/UU//bke5OqjQJ4AOasn
83rXE9hhvNk+Vx7tzr0hQP20vm/3a5shTWWtOf/l8pJFhOqvMpJzZ1UBj4nz92XL
6ObY5XB8apbuFtqEVmUenOyZbRuJdpXOexerOJ82vBsu/WANpdOQP+9bo2Tdgtwv
mNGWauAS3DJExL42UN2t6PnK7a9O/s7Wr0j7K9vhYNjZrgTsXOQcLMPLVhuJ3w8X
gJvl3qJ8ZaGZcIh8MtQG3mG/qiALn3VwctxsIFkgX/a5IqTudIHsplq9/srLW0SX
7p1scDD9ON05LCWGW8J7DFgbS3vd2vL++IUwoYjudZTC2hG0GSI=
=IYkF
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
