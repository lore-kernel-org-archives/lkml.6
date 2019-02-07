Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254F0218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV9fu6wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGLLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:11:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:11:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so11027196wrv.10;
        Thu, 07 Feb 2019 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f1LN2ycgTLPBZKF8ieDWna5Tb31ylqUFx9noLW92rno=;
        b=aV9fu6wkxtfPnAuGNnh6u4e9yAQtjgPjY6GFK64YQRxFZZE0ZqImUBkHE4geCXNT1V
         T5EpIDC6y7FsfnSqZ9hyx7eHTIKA4+iuP0dTxWFJ0i8xzM24g4e4XFQd1WkBx6Y6sVtP
         jlziEUc0oHVc6zgZ/BAtxGoE5/zmk4WeXyLhVqfL7izUia7//HwHog6gqMkcO2Mng/jT
         rQW6zyzuteCaRqwOUXD5mqL+w1MIq4Wa6VnC46fGAyOOCPGF17TP0v+1jP8Dk+EEBipZ
         uSOIT3uPQxAKF/WZHPwMEcwyhY/IWsfb5pJUGg+fjF7wRfQmWISgDwPwUE8A6+Jvfwvu
         prow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1LN2ycgTLPBZKF8ieDWna5Tb31ylqUFx9noLW92rno=;
        b=cS3vK0NhNd1Hjj+NjfkqZR3w5bl3EAnnkPd0IlFLGLcgNgDeHuQdeIAY5NCG0K27TY
         +jdrG9CtgKdJYow9oQF4M93TUPRVRhbzZJKwKYIGrYpc5WOPNrjpPfOps7p8TGa0Snv9
         0k9l6LTTuWUvSY/JazL7Tm/pOHCksdvHaNBVhiDKH/oKd7EKHsAp/WTGwxBiyIVyU0ZO
         qomIuFQ8i5V7L7+kffkB4KNsrQAf89wa2DPtMHZnMqxuIMHe2mWERxhxeV8xZhze+CGq
         KUX8edtKsv0b3/sJoMDtsTtLOS32rsAoGrJJ0X5MOjD6bS5HN+CMjLqiQmzy+4jsYZLl
         qEjQ==
X-Gm-Message-State: AHQUAuZiv9qDqkGDuTN2IC1TJ/3pedqR34jMxWN8TouhX0A9fwbw8GSc
        uZ9iBTGjlMqSR5Y1eMNh1cc=
X-Google-Smtp-Source: AHgI3Ib6AqS0WV4e50gW9DZ5V+xZ4n/0KI2seGhJGPu/SXEv0PsLYeges99w6fZ62MXW7j8bmKrQwA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr11625920wrs.268.1549537908564;
        Thu, 07 Feb 2019 03:11:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x3sm32591577wrd.19.2019.02.07.03.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:11:47 -0800 (PST)
Date:   Thu, 7 Feb 2019 12:11:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     jckuo <jckuo@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] phy: tegra: xusb: Add support for power supplies
Message-ID: <20190207111146.GB18518@ulmo>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-4-thierry.reding@gmail.com>
 <786247a4-81d1-9c2e-21b5-258dc818ccb9@nvidia.com>
 <20190128080054.GB18124@ulmo>
 <7838bb0d-af30-e2dc-8bfd-e1256590f9d3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <7838bb0d-af30-e2dc-8bfd-e1256590f9d3@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 06:25:04PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On 28/01/19 1:30 PM, Thierry Reding wrote:
> > On Mon, Jan 28, 2019 at 03:22:09PM +0800, jckuo wrote:
> >> Hi Thierry,
> >>
> >> I think any non-zero return value of
> >> regulator_bulk_enable()/devm_regulator_bulk_get() means error.
> >>
> >> Thanks,
> >>
> >> JC
> >=20
> > Theoretically I think only regulator_bulk_enable() could return a
> > positive value, but even so it never will in practice because all of the
> > regulator_enable() (see _regulator_enable()) calls will only ever return
> > negative error codes.
> >=20
> > I can change this and resend if you have strong concerns about this
> > possibly missing legitimate error cases.
>=20
> All error codes are negative, so this is fine IMO.

Hi Kishon,

did you have any other comments on this series? Anything keeping this
=66rom going into v5.1?

Thierry

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcEnIACgkQ3SOs138+
s6EyJhAArZk4CuAOOUs6klOoxw0edASHuAVz7BQ/DMTT+AsKypia6fpXesBkI7Sb
0KtfZooBsavCb0ao7kXinnjdwRwZMM7v3WprmTGgtY6ZXABtmLK1VNMKqls2Cfa9
w49HFVWC6IpaBU5YWgTsO9LI+STQW2OnLxYPP0CKIEU586V/34qvzjbBF0BzFhwN
MwwJdEvSMwd+Gqbl3izyPSQMPOpUp0HpTcQalGbGUjAr6/S8vTQdIeSRexqhCsfz
DuatsZcn1HvPfluetUMG4SS3OIWYS+Qf01wvSLWx0fBgZUvdYjO9OIlKXNonKYLH
9VIeEZ+ceohQDaI2SXYuVMTW0ehy+s84suxDFJO0Br8+QBfeGs++USqkms8KgBnG
MA5H2pz5G8P7Eh/FeTa47tSuvoL25Pd9lShwxQjNUjtZYPqV95oaS2d+RApMBpWM
kG7Q1EidtGu4fevvb80HX0g7I856h5znh3vRi7NKZ84qEgFgik4/ro4Ut7zq04pW
1aYq4aITZ3zThkPHBPafSQfcgLgruCLLLoJ3pEuot5VNWG/YEi5+AWlS6HxAX3sS
nayytgB9wKI08VvZFVKgxOsYTFwofFcE6ukHse7re0aVf5HuLb2i087PzhGVAvsI
ZdrSn5UIsCLssXmRuLCMAfwHhQVyW9uxxcEHEhD4Hu9GbyOC0Ts=
=zMgn
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
