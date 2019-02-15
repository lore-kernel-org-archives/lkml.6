Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84302C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFF021B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlvbb8Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbfBOPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:32:50 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38236 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbfBOPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:32:50 -0500
Received: by mail-wr1-f44.google.com with SMTP id v13so10775736wrw.5;
        Fri, 15 Feb 2019 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yufIzo1JqqQTQTOk5YeAdnZj2ZjW9aPNBaYFDRTz89Y=;
        b=rlvbb8Tz28T/PGPA2yM+6tRRM3HMtX4I2JMdjfHEZTK2pE+SqRzTmy9UanDs4YNyqn
         JTIwMjuIU1Nr9Sb85lVDcCzCyLyEgbFyqbfYVBo8KyRVUSaXg8rg6/f5RpyZ8rthUcCv
         2C4HDb/s80w5pN5qbCqvORV5p0UZ+Q+Av8SUcLx3l9nYDZS2TRlbKEGsHB/1yKc4Kaip
         tqimTtoGqu+ujmqoFe81WnVR6vAOxgLq27C+dP1L5HIUR8kFwg76swy+jfW5dFRou84G
         GvbbJqA3nhoyLW29a2MlbhKCGEIFpKKg0J+TH/7xhVt2SAFhiIXPkv/HCcCFS94I9WWC
         mpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yufIzo1JqqQTQTOk5YeAdnZj2ZjW9aPNBaYFDRTz89Y=;
        b=IU6fVj+cp2TPdRKR1hf+b6hrJ8JUZlqmZP68dDcIrkrqS/8ZtrynkAfEavQIyFd3H3
         IRp0IFsCgHS1/f09iAeq9vhz7F/vtx9eZwnofKaFbDGAgvXVIsNSLWrVixW1oknhzx/s
         cnpFd14CqYIQefc7mc6KODE2Q/Pv5UCSf0n2ZKCK4aKRTsWG0NoomICktZ7XTNwNQ+ep
         b529KOMSpv54MJTv415s5byREdRaSg1D7ltc5FkiYHRcs9yiUja8RBqqF77A3O5wf1PF
         njGLX0CK/Rgs7iuEITLxWdEL7inGSFyQ7vhQq+U30pbai1rRsCei69uIuiN97efkNBOZ
         4Llg==
X-Gm-Message-State: AHQUAuYnCfNKefpjOQI8psbA4Dcg8K8mEPl3/lm6YpguNXlHTlKmHLZT
        T99cHv/0n4CQORmAjet/xETtJmlZ
X-Google-Smtp-Source: AHgI3IaqyEh2pfishvKXylpzG0v1EUwWoK812qLflLR2zYd/45E63mPSQWb+yxkjKPvqg80HkSSgew==
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr7043543wre.248.1550244767697;
        Fri, 15 Feb 2019 07:32:47 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id u134sm4315772wmf.21.2019.02.15.07.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 07:32:47 -0800 (PST)
Date:   Fri, 15 Feb 2019 16:32:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i2c: tegra: change phrasing, "fallbacking" to
 "falling back"
Message-ID: <20190215153245.GA7374@ulmo>
References: <20190215153126.18575-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20190215153126.18575-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 03:31:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The phrasing in two dev_err messages is using fallbacking which
> os less understandable than "falling back", so fix this up.

os -> is, otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxm25oACgkQ3SOs138+
s6GO7A/8C0HmG6XENjhczhq9kSHKo0dZ2OKPaUCcxYfzhwnKUzTgYszpwAMP8ghO
4l/CVYw6H9RP5js1tAzn5kq/+JQXs/RELSIlJO9/Q2keTObJ/UbUu9YbE7E98Gsi
xQJiRSM1IqbJfjIAzLrsiUrSHN0ULNNLOZ9mE+rAGQJRDQx9Pk1WaE7BK/Xn2r3t
GcSqwVyphEqkcxs8jVdJy53nALkWHZ5eGzlcoYrMeJNNNoDFvN+83wMxvAz76SI7
aqRSDxPVbeCThkEmJsgJ6mnEGODnleGmP+sBeWB3ELAWjeX2kJNtjeBzPQC8P6S5
K+PrFHqj+EnOIeH0SBq3G4U9TPVJtylJwlBOBxrUBQiZ+qswksWQSFfIHvqjTmBb
75Mr8iID5PqLtlgNlQIRKef6TWENQIS/WxjAe0Yqn/t/6Lul0NoLpYL8qWywMXen
3LFVYw5eekqrUPRmCOFi3t2keaPie7k65A/UzR+y4fK1SLYQCYHXvj/vBcG2UUHR
qWMtw8pIFkiQilVIJU6qLgRXRWyd0qhv3g9oUWzEuDT4HmA81EweRgy3Itd4j8Sb
H0QpT8kTMibqPG1WfkAg457zMYPqDlG4RKMCfQiqPGrBQzU478Sqo+zU8ulUzwEe
nu44EJz3KAO/NaF7CUpzJ4ddL1sRQCB0TG2LuHKnMsev39wjWFU=
=0IOU
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
