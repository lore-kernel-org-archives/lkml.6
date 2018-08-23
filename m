Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C937C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FFE20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHdrt8mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FFE20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbeHWMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38198 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeHWMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so4902671wmi.3;
        Thu, 23 Aug 2018 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k0Ygkzlzu2Gp/DdmskcVb/m+AEoxRoRrJsL4GvOx+VQ=;
        b=KHdrt8mfbyJFZbsIA1OItrR4EUpKSEiVO8/BbGONV9Z+i1OZ1i5AT3xRD5WOtR/T9r
         qvS98kz8oAvbRXUME0oSjXj3C97EzRflQrFWwfB6II0D7tGTILiWtC+HpXBNanLpjtDO
         qL1sziHUNR6Hd+bUpfgOmdBBRME0s9vlNfbhBKXbbY+SRECAx0WR5pozl5gdypDe8Gu/
         dg44MJb18nIoOZwCuiK0Rz6P5ztxX50jgcuQiOgAEXBeZoC2aj6Pz80rFZv4lq6G0knH
         bSo7QTxm6am2iSNBVxBtCUr5EBuLmFCAni7L6MJ6iLLvClnJSb/ca9V6dACFNoNKKAc8
         tUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0Ygkzlzu2Gp/DdmskcVb/m+AEoxRoRrJsL4GvOx+VQ=;
        b=AA142WNQf92aHXB3N9xzHT1/EOkig/lou9y+yziddQn69/4M6YukZ9PvPBU1UznPkU
         aZe3O0O3jYhkbQFjx2sBBC6AA7z6dPT1QDJYTDZfh54b7o1lhJSajehFB2WSPgJBnDXR
         UkzPcg4wRGvGUID0P2SB/+sT07NBWYgotOGJVLTYyzoScyzFwqunfxeZPzSjcyLhKH3y
         fcvN56XTf4kWTSXvVejkqqLJF75vW0Ax8q0atKuZhv2Bn9tkXozFBduyNEVi1QNE3OVo
         GvQQ7vP7xLs/jeGNdvvu18cbAu1xwize1tF0Mm3/srzJF8iRSj4VS0O3Zqa3NZX9sJ2j
         Tp5w==
X-Gm-Message-State: APzg51DcdmxiHCqKIHnJYwPRtUI0eY3/RN4o1W55LqOEU1NGp+66Rum5
        L9m4hKvA3wheNTp/MngQQus=
X-Google-Smtp-Source: ANB0VdbaLRX+1bLsJRdcL1OqhiDL+B8lq3IJuUVv75mfSRlNUIfFtr92HswoSwC70BP8KrDhT3kavg==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr4444445wmy.81.1535014216598;
        Thu, 23 Aug 2018 01:50:16 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id e137-v6sm5723990wma.20.2018.08.23.01.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:50:15 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:50:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Tegra SDHCI rerun pad calibration periodically
Message-ID: <20180823085014.GB28696@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 12:23:31PM +0300, Aapo Vienamo wrote:
> Hi all,
>=20
> This series implements pad drive strength recalibration. The calibration
> is rerun to compensate possible changes in temperature. The calibration
> procedure is rerun as part of mmc_host_ops.request before
> sdhci_request() is run. The calibration is executed only if the 100 ms
> recalibration interval has passed.
>=20
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>=20
> Aapo Vienamo (2):
>   mmc: sdhci: Export sdhci_request()
>   mmc: tegra: Implement periodic pad calibration
>=20
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c       |  3 ++-
>  drivers/mmc/host/sdhci.h       |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)

Adrian, Ulf,

Since this depends on the earlier, fairly large series, I could throw
these on top of the branch I already have. That way you don't have to
worry about the dependency yourself. Of course it's also fine if you
want to apply this yourselves, in which case the series is:

Acked-by: Thierry Reding <treding@nvidia.com>

Thanks,
Thierry

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt+dUYACgkQ3SOs138+
s6FUeQ/8DBmee+PNuEJrukSN9i3dR+SQm2XnEmAZee0pF8AXqaxAh6JRRA/KDnUB
zXnBedB+hTAPdYP276VlKtojS8dugoPSc7qDvX1ASBucmxD/4HGGRT1ZufDK1CRH
/HLjXT9Pz5MyK4oRHoYDHNF+lqF1B12WjSy5IgXTYc33Fdqgr7Zxt6RMNcOhZOmD
Lt4ufJ6IfztxAoQuhNWwHgshqiCns1Kgt2tGV0DZImBm81fNmkM+2vqD1gJ0XNC8
Eh5FZZxAR66U9tGXskBLln1k8+bP9kkA2+IJXueMce+/R/j2Xb0J0no7Ncz8QkQe
lQl4KP1qc6E3cyz/0g6QVQSvHekGSA1wonwr+MtfuUQf8/nh8gQ54fYV3xqdBbHC
dtI/F50tVNAIeR92LQYiJF8otVmRu8Vge80HnhW3vM6fUxqAPwZTdtdXLE9fhWl1
w7TeptCNOF+bgThNqEjsJs4AkXj2XkU8ekNOF1jHj6OqQnHyjqVt1WUE5k4txW7H
d88ncgQ28+GZj/d/0hBFBZl+aoY4bUBIWVJcxEK6Xops8hBEvWHPFCDBL2ORL02F
+mJymd4vbLgULQ+nVo+1U4xHe66gYFf+SDHrpa//Oc/O0DxulUU90xHcu7FSHPGO
jsxj6iCdG5IwU/yD9Sl+lGMhOlanB7RWabe++SNms+3ckIHrRS4=
=Ae4E
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
