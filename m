Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15EFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4EF21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da5gVgIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfAWJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:15:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:15:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so1190324wml.3;
        Wed, 23 Jan 2019 01:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZljoAt5hVQYe4zZIHbbL7YaPy1SNOr6wdTRMrlsgMI=;
        b=da5gVgIsnX5cYhZN+UH08vqr5LTlg46+PBMsb6ghh3Abui31N4ZrJayyQdxcImpV7d
         7a1E7kHoqaVcFuPliQwICBwOKekE1ODspznmd8yAGvbU+fGVc3wUsYBoA3CnIqRlo5Xb
         0EcOYoaXpyA83S3M5Yow0jgIjudd8HkDrin3wXzUFVGfq+0rOwE5tLsjOqq+nYgdVm6U
         Bli7fIs4trwyVEhO7eQe7ptruBxFgkq67L5FKb+6IUNvCBkzVpcedn0uJmvCe9n+jLeE
         VdPBFNOT1vNscdTs0J5lFxoNEQQz1CP08/CRiOa55tP8MuphDTm/dgybHHJgBs1RLgUU
         qB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZljoAt5hVQYe4zZIHbbL7YaPy1SNOr6wdTRMrlsgMI=;
        b=CKxbxbsM89FafycB+CV3NraGW0v2juhYtDkEXBe+tZEEdX0YDtg+jUdY2ja+xFGlyc
         gnyPqD0xiG9x23EUzzp9Adfk/tYQVVIS+FBQByEdcxyVUsz1XNnoQLKx2geRlRepUgjh
         9A+7JGfqvn9VbzOLgQgmUnCPJDKUhHv03Q2yUupvE5Yd0S1a7z6rmFle0Xg0kbyStOE+
         9P39LT4uBLEbFiBKm1IYsD9lOtIdScMKRcOttPk7tZyOH5pz/ooE0tnTCqxFmFgQFdt0
         mPhpc+PaCuSMQ/ikmcO6rU9YMKsE8fbw5VB7zf/OS9VZWy6TmdypkPXxU1RN6eBYnANe
         c7Fg==
X-Gm-Message-State: AJcUukeyXbWvN/iLuFp/URtP7x2cr96nmAWyHfoCHUtEkhNRWovFPT1B
        g8412xZ8nHNVe9B4FvMuD2Y=
X-Google-Smtp-Source: ALg8bN5xiBpAHj0f/w4R3pbm87VmEMSegwIoDpn5pnBrXc0fu31GtB4UiARGBB9ufnq2Hswq5wNvZA==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr1977766wmg.13.1548234909184;
        Wed, 23 Jan 2019 01:15:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o8sm97356937wrx.15.2019.01.23.01.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 01:15:08 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:15:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V10 1/4] dt-bindings: mmc: Add supports-cqe property
Message-ID: <20190123091507.GA24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:30AM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for MMC hosts.
>=20
> This property is used to identify the specific host controller
> supporting command queue.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: This patch version moves supports-cqe property from vendor
> 	specific MMC property to common MMC property.
>=20
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMJgACgkQ3SOs138+
s6HG3w//cxrFZWZQwgA1NKCvuES8D+RpOE/c1K8+foWs8q/kyfEOJ4ormoKWaM72
o6aHTxNbIaoJY8PXgd8Dx3IsBy9DJ6mGbLTz6LZD1+TMegRFxjy4gOAFCe2UljXY
H4tAXZEeeKQ++dsz0UPOddcmlnCQeROSFILth5Em2RQV81NTGSZEYh4xTL9207pw
w2t6dpyt302cM7A1RO7bYWtIk+jW/VHM9UGzs8h5p4oXknzj50KlqL+2YuQ16vAO
3iBQbzNofRyM7yMn9pzIQR2Lr/VAHqGEgbuf5ceVIwo5il/gnj27oyN8luZyXELC
LZcjYnob4L87LdiQL/vnymcr03UrzIdEFXov7kGmLrhRD3WKrrpj8oqvnDJISFEH
QToBuPGp9RIaKWtgimpI81XR0AcztuuMkOPZsDvzwItKr6v4iLvt9/1h3h+bSxWv
I6fWcyfJYSjI8xlXmoWPRGyCcxi+U6y4l1X7c5EPD/uW9C3KYf4IPIsM8JuIb1YK
yLepArovnU/hzIrkPNZimVk5l24lmgsXB6elorbauumiUUsTvxnV7VTxNcE4+IC9
Ty/moEjN8CsWIqHxpJLO1I972RA+LH2an86mBHMO0OAEg4d5+a+n+E+/u+vKwa6a
AOp7fU1HSoih5mf/vRJCZNErDP3AAmcXXx/HNZbiEtoAdMnAyXE=
=doj9
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
