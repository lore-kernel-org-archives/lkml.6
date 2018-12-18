Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F853C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14F221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVyYNvYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLRWxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:53:07 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:40080 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLRWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:53:07 -0500
Received: by mail-pl1-f176.google.com with SMTP id u18so8494193plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95UFh51dOarBCVSprS1HjbeMrf84jNZ9XmlpVgV2LxY=;
        b=tVyYNvYIrH1dYWfD7NSr/AkwKrAJSdrYwacxww4pHUYTG7gxjg/Ci/h56FZXSltqbW
         tudWv4Go/4Tj8NmRRTEidvMwE7fSRdri8uX/5wCwsymlK10O7lsIpsiYngChDfvWjnaW
         4a65IqMs1lZD648AcfBa3Wj5dVvwTnwA3nhqq/UkML3rQGp18mqT9NBgHF7GpQCpEGpr
         F0JptXrjju14iPYGOHWpWYKeO77nbm0AxVvjKa28oaMNa6E4czWQHbBmxeVm/kmsnYrK
         W/xheO1piZV/2syz0V+c06X/10lOd5RmsQQPswkurJgWyrYqIdZ9sfuoS5PjYyWizbI7
         ZzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=95UFh51dOarBCVSprS1HjbeMrf84jNZ9XmlpVgV2LxY=;
        b=MEq8qPm9VJmimuRPXjC/P6waOB44XqYhQ6K5L+6qLApbYwh0V+5m9bzIEgHNFq53hV
         SWZ238+2Vy2nEtPHLrZvxY3oQp5AJh0iprVtB8z35lf5q3a64Adu6ie+qorBxKjKvDro
         FbStGISp3Ol8S1NLsR9rYBCE2MwM7GL+c0kKN49byfCMIY2rYN7HbNHVqhaqMvp/8nN+
         MjYOLmCw8tbAfcCKEy5K55NVSL1RGSIPwK5x0KXeOV4UKPwF4bLZqGgQyvA0aPdp/P3m
         09/BfTkuRfAVSFX6JPDl9rf1XvNBUhzGpkPZmIIRevwppIImIMIpb1Rljb3RYxhLFbfu
         IAaQ==
X-Gm-Message-State: AA+aEWa5+4Jjpu7ivyjva2ZSuent+hxzHwe2PJ/ZYcv2w/4VlvMLxTQ5
        Ln13mbSXsVzjVN61J5z1LK6N6lzH
X-Google-Smtp-Source: AFSGD/WkA8lZwP/7giPNSS3WdfhNnH9fmkJMk7zqLcBIZ0OVNq1WN4J/e1aWvMPYM9pm9Iwbaiv03Q==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr18449303plk.291.1545173586086;
        Tue, 18 Dec 2018 14:53:06 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id s37sm21375055pgm.19.2018.12.18.14.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 14:53:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:53:03 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Jasper Spaans <j@jasper.es>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181218225303.jxgwf76wm4uls4fi@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Jasper Spaans <j@jasper.es>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
 <20181216192135.hc7gykmwkfgil2j5@gmail.com>
 <20181218202627.j6d2jgxercylclpc@jasper.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mopxlzhr3jjalvzf"
Content-Disposition: inline
In-Reply-To: <20181218202627.j6d2jgxercylclpc@jasper.es>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mopxlzhr3jjalvzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 09:26:27PM +0100, Jasper Spaans wrote:
> Now you've caught my attention; first of all, there are more than 3M
> messages stored in the lkml.org datase, so I guess you've missed some
> messages or something is really broken.
>=20
> Besides, unless you figured out how to get to the raw data, you've just
> scraped a rendering which discards stuff like pgp signatures etc and has
> very incomplete headers. Unless you don't care for those of course :)
>=20
> Note that I've also been toying with the lore dataset, and wrote a tiny t=
ool
> to get Maildir-like data out of it; this code is a bit of a single-use-jig
> so you'll need to do some coding if you really want to use it.  Attached
> anyway.

Yeah, after looking closer at it last week, something here is very
weird. This is definitely far from complete.

When I have some free time I'm just going to give it another go with
the public-inbox conversion.

--=20
Cheers,
Joey Pabalinas

--mopxlzhr3jjalvzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwZek4ACgkQ2rGdfm9D
tVIrFw/+OnMAOWfJodnabA2ECMj5pFjFGAgltlvj+FiUjKVlj6SkD6B6Mz4LH/nx
9sZZx/U+Nesb0ftCekmqPlMMQI1mJTC+gnNSmktqyOUtNNzCgFC9/wlhLK2zGKSC
O6HkVvar/UwmkGHWgFWXmbvnvds2HcsyATND5r08ZiTrXHVitYk22nezhm5UufQU
v6tWcFxWMDne+JR/JTI8qraSH5f+5lZ6TnUuLhAjxOJzj4tv4zhhxzEbThqy8Zw2
LxYOm9j+8D/t/9Q5zhIf4h3AltcJVKnLTIVlHEoX1OHH5Vah4Vfwf5fopCym0nhs
QvBPN3VbCojjQl++oUNUxNdYtskUq3thWgYHwf4N+7yxI1htATMaa/rDDuPq8JkO
HLyLd5NUaMp6gjp2lmjkgBRjLOICVHRWcTTSB3ds+w/Atg3FrGwj/yY1y9OiHO/e
bvohIgQp+sVUClOO/qNuBksJmbRR786tTeH7xoe6aG9uOQfVwY0QqMU7VZxZHG6Q
r32rPpU4nyT60dcsdcv6al3nTDJBEMaGTb93UTt3tBuzfUbGkyk5NufvcA6IPaib
CTk5kJwlSOTX1HoOWs04bzO4sPAMLMr7Irkqbtk7CGG8BwUJISgNov+IAxdYV/Bn
aGFr0smRDfPRsKiEYhSoUADq+FTqD79GcvaShDw+I2I/y3sUQss=
=NlF+
-----END PGP SIGNATURE-----

--mopxlzhr3jjalvzf--
