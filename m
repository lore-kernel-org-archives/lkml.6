Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EEC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8972086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiKIRhHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8972086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKHWMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:12:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeKHWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:12:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so21056613wrb.13;
        Thu, 08 Nov 2018 04:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QN9mb5W0kGXnz46CMKXE7yGBR+mp0iwMerMcujrZD6w=;
        b=CiKIRhHAqsHvKJvDcQF5l3CY+x7aHhO990IYba5fJ2NdSghTfOpO3goxAV/XP3D/tT
         mP0+/SETqbQcJmmLNrRiwUX4zzvqibrXt0l3dMGggP1I2Ox2KXABrmUklZeICLpksgkl
         yhPs2gVTb6/Q9MM88YnmQdIppP9q95bv0R0j2IHrulBLqPGnGuHitvHfbR2SrQvAcydF
         X5b4LWq4YMlZ2cZmtL3+pcWpXcAVBY5FS41XF7OQ+7H/foQtM4FsGrKfnCghlm6+B1P9
         nh2tsp7Tr2uR4oNYSGYruiddBYYucCdLQ6bgbHuknIIB9gaOwHsYZgDnOWg8lg+GCmKz
         9fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QN9mb5W0kGXnz46CMKXE7yGBR+mp0iwMerMcujrZD6w=;
        b=E2oiakhDXv+aUrA0wuOHqJixCdRLJgP5w2uKTOL8Fu8FvzyhMv6zwuUbQaSZQT0J2P
         m1VRavuj5CVKlVkkTTuz76T9eYgT50x5Aojftiu8HgYIhMXVMUegCn1M1ZV2NaZCfBuD
         nGfmWNeSQ6ka/wQ2UCa60jNpSA6GCE6PTG19bKBDOPstq0i30axWXqf45iYZNAIhLeJG
         jKZ4ulvg61zYX1BXJWEsyf4w91F4ybISecUwdrIIRsTO2hnHhsOo1EFMzv4sKPr1XeJJ
         Zl5Fd7xV1VF/DnbdMkzKj5+vKWop4BRGYkjznPu5qzbTkXEqQTaxOL6CZyO32wl0YQoq
         uLnQ==
X-Gm-Message-State: AGRZ1gIBiZ/dQng9VGBUFp6S9MlsyDdQIRVI6sPXLXHojurhm/9Hu9kv
        LyaleRrsVxS0OyqRIMW6LLA=
X-Google-Smtp-Source: AJdET5cnv/xZ0tWcrtmgvKQEkesIQtLAy1F6RZOfO9iIuxYD9/prvoWaMdZwlQpsrRhuu1uCJCR6Ug==
X-Received: by 2002:adf:bbc5:: with SMTP id z5-v6mr3917117wrg.183.1541680631861;
        Thu, 08 Nov 2018 04:37:11 -0800 (PST)
Received: from localhost (p200300E41F201D007494A3C25E2F6EAF.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:7494:a3c2:5e2f:6eaf])
        by smtp.gmail.com with ESMTPSA id h5-v6sm6802847wrs.51.2018.11.08.04.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:37:10 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:37:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] thermal: tegra: fix coverity defect
Message-ID: <20181108123709.GC1340@ulmo>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-5-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <1541410354-19090-5-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 05:32:34PM +0800, Wei Ni wrote:
> Fix dereference dev before null check.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index 3042837364e8..96527df91f2a 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -397,7 +397,7 @@ static int throttrip_program(struct device *dev,
>  			     struct soctherm_throt_cfg *stc,
>  			     int trip_temp)
>  {
> -	struct tegra_soctherm *ts =3D dev_get_drvdata(dev);
> +	struct tegra_soctherm *ts;
>  	int temp, cpu_throt, gpu_throt;
>  	unsigned int throt;
>  	u32 r, reg_off;
> @@ -405,6 +405,8 @@ static int throttrip_program(struct device *dev,
>  	if (!sg || !stc || !stc->init)
>  		return -EINVAL;
> =20
> +	ts =3D dev_get_drvdata(dev);

I think coverity is wrong. How is dev ever going to be NULL in this
case? We allocate all of these struct tegra_thermctl_zone structures in
tegra_soctherm_probe() and assign zone->dev =3D &pdev->dev, which can
never be NULL.

And even if it could, the code would've crashed earlier in
tegra_soctherm_probe() already.

Furthermore, I fail to see how your patch would fix the defect. None of
the checks in the conditional above actually check the dev value.

Thierry

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkLfIACgkQ3SOs138+
s6GV0hAAq3U+lnQjAdadsYm7y99aeMRdd2rrxMz4BCPwYJDjrBc9hLq5ixywaqQc
d/3qlnYUYb+09tM4pvz2yaRxDJBXtcWr40gkfQcHAzge8btVi1bQ2UEpA+bJdSLu
WoudNUrvmvDJ+NdBJMzPzzkbbi1P97+qALAxQiFUevwD+WfTx2kTWat8MKCY9IFL
vEnFtglnc/KThKxwdQDA2O6DP8b5SeXrsAELObmfQSUY4YawhMeCKZx4L4fnmuRI
zHIitWHM72wAxSoPFclc+/LoQrbHCHtbagQRnuFTpT/0bVa6PjJV9vHoIyJ9MYeN
x5q9Bu14NrC5VXaw8tyFuWAVDn7C1UAwVmYd/z0JRypXs+eM1CSoOzsUliMbPnp9
zSiaTfkEtfC8pFYRLQzuZsUfIbQOVItIwuFScEL15N2EGaAjGW+dD8/l96QF9cT+
a0CmMJFwGIgqL+D7u/IGck0Q6zNrBtxS4v+m1AFb7IveXQiWF8+6YUNbmDnIOsGz
6XitdfoHYqThoKF2/5dpOXgxjNAYc5OR4e9FeJORRTHrsGbSi5rQ0khjkmJ25MlO
PhDBESdFQ6dmnmhnaLDP95K5ZEdw/x6xMEwe+WkQGJm9FJMtIiE81ZSFL+SX5RI6
R4jdOAEzYNvx1afArolXIDfKLtixTPv7eBE43zosvh7gx5Jq0Lw=
=8bf/
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
