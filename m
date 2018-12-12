Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKiADyxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4A62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLLKVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:21:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33253 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeLLKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:21:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so15110015eds.0;
        Wed, 12 Dec 2018 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=idkYqevhfJf8tSEovtaPYx/iMzyoFO/qaqk6IG8i/kU=;
        b=PKiADyxqnbW82w93hAmRKCiu+l7r1kZOZ30jhn1JqCTgUpVLYe2y/75h4P0LATXAeu
         9sDN2eWtan/UVgdukxmCaPNoqjA0mz24JlZgrX624P8a/kbQ77IDbLGScmAGezK/s4Mc
         vYNekhfd01u6vZ9xVNgjT62wAF9R9cWvo3OAdssp3Wd5e57GBpxwLeXupjcdVDRXPawv
         t3OkUPg/VD4foOI3o649pFA0deYprMlCXGPXW/ffGBTTrrpqgFAt4um3O/v5ppNrFdzW
         tPGM9f88AmjHGKueNXVZCC0g8gS9v0Sm1t02nFOeCs6pIa5fAWCKUdMC8t+THmTKOubn
         eAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=idkYqevhfJf8tSEovtaPYx/iMzyoFO/qaqk6IG8i/kU=;
        b=nLaqwbZve7qDA0OTOsWvd1/f0QKBE0JHtWwcMI0sryVw+m3Xer1vxtgatmf7eUohnj
         OEcsgYWiavPJ2ns6NOGp1xmnX6rFAkTgI/53i5MkmaNskIWSiSrnFQFYy3cOPkK/evQ8
         Zdo5eCBm41mZxisYZox4rT6yfyeLsj9xeP8ubrajWT7mPUC2Bhcaxsz8nC4P2J6dwg85
         Z+8Y4G5eyRc1bq8PzhQejP+VcOj7wC64jUfWEU20uC4B/Tk0zaO1K47s1Hpyt/zKHEyU
         90r4DCpYJmH3My747hRGcJgKPxCn4GRr9GDGJj2uwtrvFRO0wUaUAmQdUSTFozzZySgI
         SZJQ==
X-Gm-Message-State: AA+aEWZtD72gZ5k9e1tgdNu7V/G5xYo9fOPvFHFVQofjbKE2vaQba4+m
        /9ILCU4sz9qPaYKJ6bkuV55hWBbu
X-Google-Smtp-Source: AFSGD/VmDHTWtbplqeboAArYynjg0xU2yyaoZ0EKd7Nm+LAhMmmzVTEDNgHc1bnQRPGet4b5N2D1ag==
X-Received: by 2002:a50:8163:: with SMTP id 90mr18391185edc.174.1544610060472;
        Wed, 12 Dec 2018 02:21:00 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id l18sm4588878edq.87.2018.12.12.02.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:20:59 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:20:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/21] iommu/tegra: gart: Prepend error/debug messages
 with "gart:"
Message-ID: <20181212102058.GL15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-19-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-19-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:47PM +0300, Dmitry Osipenko wrote:
> GART became a part of Memory Controller, hence now the drivers device
> is Memory Controller and not GART. As a result all printed messages are
> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
> prepend GART's messages with "gart:" in order to differentiate them
> from the MC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4QoACgkQ3SOs138+
s6FaAA//W+T5CGeUZoovs6Ol4TC4GKo1Ig1hAN32fYi6MLJecFSOJJQhh1klmk8b
8pCoOOEkbr5tOTKgReveh8RRIXL4V68aNpQ0iuGgrutH9kNJSHiEdWS0/cq8yyei
kobNf8pgjUiu8ZL/HKyN3PjQSXFeAeCmK+tYsJTMPxT+XxYZvNEntMqSKobH+Aa9
9q1LeyJz6y7ALgHBluAAuds0eSNRY10oUcG+feIe9TOM89Znt+KbQirChbRerst0
4cScjW0zr8RIYV1oYY9y784UAtRFp97264AMevYtzAffhMqDC9ycsg6DafAUC2ed
8quEH8VTH+7VdoVSy0m2AikAMZZ0hVoLb3Ub7B2Q8TC+XFAcoQjgW4J376DIZDW8
jL6HQoriN/9URyQo8fNjs0Toa9/pCnJtS4SXwMFL5CgGJs2+ToyNGYlduLjVcKT/
fdLdydRmNpImRvNUuYcKwDrtIPCL52AswBwu0WNzZpZmAl2cEmvmzOc5sJ+3sEwW
nHtotQHjmd69BqxkdLd4K4cVxptT/XPhW+FSlMf9BoKra/mMWvfNbxddDJxdB3VX
a1oYtCI11P8LvaVn7K2yDtCSf5BWaCk2Gs9R28QBjdSVcLPFaHVDW3oobat/dwRx
3EXh0r4DeQdtSs23JQDfXCJi1LAmyvTbi6USoxm18hcx9oscMnI=
=ZNdi
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--
