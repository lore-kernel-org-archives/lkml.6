Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DEB217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Z2qOohkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfBLEja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 23:39:30 -0500
Received: from tomli.me ([153.92.126.73]:58900 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfBLEja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 23:39:30 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 39bb23af;
        Tue, 12 Feb 2019 04:39:26 +0000 (UTC)
X-HELO: x220
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli; iprev=pass
Received: from politkovskaja.torservers.net (HELO x220) (77.247.181.165)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 12 Feb 2019 04:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=LV7aL/UP+6Apa6bK0vEi6hBPHk8KLKlfKCvupMGNNG8=; b=Z2qOohkmjoZLJIAfkO8eqfyUJjK1IQYHHf+4PQdmLBsq3M2mhxE1TTpJ5OCCULTqoOWvKI1zUeEzXVEqYwokFrW6Jd2vBsqoFHMqgkW62iJnlNHqG1hYx5iSEbgW2De1s4RUq0XxvoaAUggrfUYBQ+B5IRR0BUeLAYCMCY+wpy1YPy6QfVsRKx7ICGba1Ui45iTcBrMjTWWZMkQmspgXGmFqLfSF+6kbs+7XxurSybgCVymQzzqcEuK/mmVYO5wvB6v9P4Pq1mStomZzrWT62ucNd5ivYp7WxnN+uqk2oaYnDaKPjPIPrIQS1h4l4Ahxw84wOcsaCIGeIyKuw5J4uA==
Date:   Tue, 12 Feb 2019 12:39:00 +0800
From:   tomli@tomli.me
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Alexandre Oliva <lxoliva@fsfla.org>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190212043900.GA111884@x220>
References: <20190208083038.GA1433@localhost.localdomain>
 <orbm3i5xrn.fsf@lxoliva.fsfla.org>
 <20190211125506.GA21280@localhost.localdomain>
 <orimxq3q9j.fsf@lxoliva.fsfla.org>
 <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >=20
> > That doesn't seem to explain even a quiet boot up taking several times
> > longer than 4.19, and package installation over an ethernet connection
> > (thus not using the console) also taking several times longer.
>=20
> Maybe it's a slow disk?
>=20
> ATA (libata) CS5536 driver is having issues with spurious IRQs and often
> disables IRQs completely during the boot. You should see a warning
> in dmesg. This was the reason for slowness on my FuLoong mini-PC. A
> workaround is to switch to old IDE driver.
>=20
> Discussion: https://lore.kernel.org/linux-mips/20190106124607.GK27785@dar=
kstar.musicnaut.iki.fi/
>=20
> A.

I find that this problem is odd. I've been using libata personally since 20=
14 and
never had any IRQ problem at all. How can the problem even occur at all? Pe=
rhaps
related to a rarely used kernel option that trigger it, or a bug in the PMO=
N boot
firmware? I don't know...

But I think some versions of the PMON boot firmware have odd bugs. I'm curr=
ently
using the PMON firmware built by an OpenBSD developer, but I cannot find th=
e link
anymore.

Tom Li

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIzBAEBCgAdFiEEJVIRsjlaWj4OSKDx+tPrBeiOjW0FAlxiTd0ACgkQ+tPrBeiO
jW1CRxAArP/TItesPkeQzDXnVHn9AczQYQX715wyuSvsFoLg8yY0RxmVAuyXF8/l
0Ow/Wqd7nVGH3l8ejThVr4ifA8TlMLH6Az5TIRQEQK9UuHstYPrUHr+4GQcmU8mZ
GmiTiNtB9oTfniQXdashN97WN+FYjmLVApSMVBqoyB+wbl8BPCfj2QOUD6W3BFYk
emDWIaVp50MEiy5QlEq/vTmGWK597UZo2P0mo1bC+7E2sKSLT9OCkXc2rep6LCPH
gp8XQvfYEl5cN7IO86Qsg5H1kNA7EatnSMl3CrFbW5V0MXrMM7DCs6OYgCnexy8u
dImjQaW9JVj/M6JnICDv6CHiwxYXYLRNXUt97dTnPzD05SwQidp7gWL4goNVXgP9
MfsDN/NJESuFxEFOqJ4tuvnPsvZqo8KNFKTeth2+kRiyykXPCcxh64eM+G+ZQ+kT
FhyiB6QmJmZWlAXrdM7BsiiRA5PCHCk3dkU1g9EwiGlJwlLugXS2fyV7fK3ctWGf
j9JmrIlglYnw5y0b5fTKREJGponz8NST7z8GBJ5GoQsNvu0HT5Ux3CLKLDfKdtuy
kpnEcwceT97KrrSmZCIyXxH7sENjYrG1R1+oGEvWqrpeV2YmQTdbMMG/YUXISajY
wYrcNJ5Yw0c3x0rVtoA4KVtB6OVeoYf/WgPxDwIIV7zVX26UP/c=
=Rect
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
