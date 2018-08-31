Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58CE20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULaLlgsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58CE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeHaSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:08:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55589 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:07:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so5360090wmc.5;
        Fri, 31 Aug 2018 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPqjN6cSljgkmPrVeYJWfI0YjbyTpulb5xOVHYKs3wQ=;
        b=ULaLlgsnp7aLY1QFJLXg8dq2C03BuuXSCFWBHeh6OlvHyed0nwYrIT1qL1PuvvRHs3
         q1V8b2RhJkBxqdMDSGXdG4D3oblUKORICfmegJKw7orPn7dCmVudrbVRrAuPsJ4J6is2
         t6myI+rGxMNWUH/4LKD2R0mFOiSxAsBr2EM0m+XED9+Ngx5ic7bIvoOHx+kg2/K7PS/I
         zWXSOrhDdNAP8BFsS01KHihSrzsNvmPpgRHYhtGFKsvZZunkHuP65XxOywxQ0lNHkALZ
         n8rlgZB4Rg0xdeYWf0xZropXChW4eL+inqW3F/yhD+Ka9Kcjgkq1e35jerMXel7og6iu
         WF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPqjN6cSljgkmPrVeYJWfI0YjbyTpulb5xOVHYKs3wQ=;
        b=hAXdbZmQdNFtQ+Z7sk+CJMUsudAPUQgrOa+C+e3Q6OWMMkhuAfxcoywLiXOMkRsLss
         MG50bGApn8fqDGUwBRSjcfeOo2AzU6zvBbb+Jtf9q/elqzJBIayAXka/a+apTnlV5cyt
         5tj/8WBAsVZvGIJJ4HzlNFBRsPbWKtVar4mUPtSAuLNQGue6z+vPBE/utYyMEcPhRTL3
         ft2G3dpWWvAtc41VU85EcFNl3D4CU5r9BRCcb6wwb3ht6+Sn3wuvGYFjDD3YG3D+u3v/
         dre1oqVOIfuEgZquFUmMwWnsfgkt8S0xQRW6w90mFAL8ZwRUo16yupy/4mCRXSPDaYgq
         tUNg==
X-Gm-Message-State: APzg51B+Lww7zIa3qIFTTms5omwXTIVPrcYqOYCi2l/CxHztcrI7zXYa
        w/9byLC9CP3R4xXbJhuHZBo=
X-Google-Smtp-Source: ANB0VdZefsXJb0jeku2TXeG4KnliDY5CDjTamVW4s4ELGCffDvbVBteNtJbJXrr3SmnEmqQtw+w/WQ==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr4572321wma.5.1535724020026;
        Fri, 31 Aug 2018 07:00:20 -0700 (PDT)
Received: from localhost (pD9E51F49.dip0.t-ipconnect.de. [217.229.31.73])
        by smtp.gmail.com with ESMTPSA id h17-v6sm9996372wrq.73.2018.08.31.07.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 07:00:19 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:00:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
Message-ID: <20180831140017.GB7926@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 12:23:33PM +0300, Aapo Vienamo wrote:
> Rerun the pad calibration procedure before sdhci_request() if
> the 100 ms recalibration interval has been exceeded.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSfEACgkQ3SOs138+
s6HAYBAAuHulah5onbx62mnNjNsUcRcCcb40PdwDXoX1ePa1D5y/wCg2y6oFGYK8
fArz8gAteh2LI6BN+po8zN7DRRkflZh8l7bsEr1ITXQ7UaeqbisXiA02RCnxiv/v
8JSmuS2T51Pvy8z4vEYCvHzUSvsP05VJ+I4sGFfY19y2QPyO5R934dlFZhA+SYck
3U4L9IRZg8/WIi2M+uBhwM0c9ZafcgIM1gHTyLAgr72+DmaXxsye/KNTgAn8h/Y0
qWqC3+4xCHN/IhXj5/bJcqTwW2X6OeZOziBZLW6HUzU3ezCPxd8vRD9W1OcmBc5W
m0RBg7Z5wxXfPpvag7tCwmexJUAlDl7AoH9xThfM8gY3svtvW5D4uFIvvDepvcD4
18iEP6RmHSYrW4e2bf1PXReBxQ1N+qfPjT9tNoM+sAGxr+B8b5mUdZCGMuGrCdxo
gLR40YMB/dqIEQe38c3kcefdzhkffb/0MEK6e/xnb7MJhTKhB9jUTRks1jykJhVB
WFaOrVnC8EWm7IZZutV3wDsdzrsvcNAMNCrwh/az2dy0+WKDfeITIzk8t+TMCgJh
fb0UC0N8knjzbnWfojjbJtzoS9CyVFh9BVlaM5sOauJ95Sd6V0iQyd8yao6U67le
MAPlGP5K9fKkSkWeVULqvnxXdemF1HkLLnNqoGw7/OYr5CCc2E8=
=j8Gh
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
