Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C0EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9612098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoBIvWh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9612098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeIXRCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:02:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38906 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeIXRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:02:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so3126996wmi.3;
        Mon, 24 Sep 2018 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OWDZJIUZueH36eT+tT2vV6f84T9nyAjOaIBLIugiZeE=;
        b=CoBIvWh+kF9k0orGVYuRM8p0FVp79OxweaGtOkujMQF32yTl0w5OdkXlMiCJkr3Km9
         eLHX36/uxUN9nVtGj6TMupDJQa+Ksp/J/b4GyHBmyrgS98P7s5iYv//Y+FwAigFfBLZY
         j47qAsiJM1Y/39a7FoBRWp6ZwwGh23gUgqaIPCVEqzxrlEAJhRBgo+1cUmaQf231UKDg
         +nyeSxQSBpL5mJoW10Q5wfcZX2VE8iP7jzJIuuV33aObY64WNpwdseEQxUZGvHOg785Q
         85lGwejsVyf4mlnoXEufRfflH0rWkcK3shjjJBUxiokU4y1Y0cchnXA9m6uXXrKvML6z
         nZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OWDZJIUZueH36eT+tT2vV6f84T9nyAjOaIBLIugiZeE=;
        b=assGJef9+1iyH0ySzFVil48/STTHUqjL4GMXhmA8+hRfuupuv9yMHG6Lwl90TMbagj
         BQAoB5kf30LC73NUKrNpW5152JU6Z1DqddiTcAaPcklm3JcwAA1NgBvA0hqJEAxoWaVx
         HfXO10pIrNNZpGGSyDegzR0LfkvHzZ1dOF7hpjRSCfleyKSLIWOW2Yu+uNX9YI7sgvQX
         +ACxb4T1MAUwmHMHtKV+FgQumIblT31HKeW0/73MCU1Mx35WrCy8fdS2VKdG0yJfzLek
         /z5mdJn61f7wYgTyWbM3PeSVCC3vY9CTyTNpbAYbgKg6adjqAlPIo49rcpOMdiZP7Nk1
         4xZA==
X-Gm-Message-State: APzg51C1PwE2FsQdvBeR1RAj3g7+dwFLw4arfFEqn6Mzt8mDrlGdiWsH
        fgGNEfGBraqkwPCEgZ8J0Bg=
X-Google-Smtp-Source: ANB0VdY9C+m3oUKAo0w00TUwnL2czY7C4JikeT9vmmjzKEgnxcOJMgvHkG6rxDXv3vbSb5uOinY0nQ==
X-Received: by 2002:a1c:b441:: with SMTP id d62-v6mr6859888wmf.17.1537786848862;
        Mon, 24 Sep 2018 04:00:48 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z69-v6sm13873497wmz.18.2018.09.24.04.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 04:00:48 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:00:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
 inactive domains
Message-ID: <20180924110047.GO21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-19-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-19-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
> There could be unlimited number of allocated domains, but only one domain
> can be active at a time. Hence devices must be detached only from the
> active domain.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Do we have a mechanism of switching out different domains? I don't think
we do, so I'm wondering if perhaps a better solution to this would be to
just refuse to create more than one domain in the first place. That
would also allow us to get rid of the global variable gart_handle.

Thierry

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluow98ACgkQ3SOs138+
s6Fc1A//eebkcR6HVQf/WnOgbAuStAlJEk9PA600bzFQKyZOBrLVfshJnQRCGwNR
9ct+gem0WVMH623JFPWLxGjfkFOYRqugqA+FgbJ5qFV6fBsTNCDTPDd9ZBpFrMyX
QO+PhkFySYR6kDTheg2jamSOVutMWuioM+YE878kwiKw+qwo9HkUCTmKPHOoQ/QA
skckpJzteoYgqi3GGFevE9TgIYrcIfrPLFV1Gd4iZd091RPNQvBOYLwJCeFvo1M1
S1du/I5jTDd47KAhG2algLrHWq38NlbFekr9zK+bMWX2BA2jPU0cpYJKeUUCC9LM
UcKWkdAd3iyoSGxvN6JGdmIfb5noY8kGPMG+WO7+PZb9irgVYm2Dx34XuWA14pwz
YbZhh+XjRdgCx/r0ZhlUdpYZv87KuvM7iXBqXOwAEBl8Z8Ge34ZZgua2KBSClL0A
4YHJeOt+zE9o2Id+0y7G4v2JwLKjlCw+1bQtesCrCHLz40NUrcb0j1bggrvPkEWz
jwn44fN1688vLxcxVswewXYBmmiE0WnJn1zZwU4xeukj0EkKMMXLPFt+RcXAnsJc
toxTZeUYDQyogLV8fK2XFPgafumnhISHt8ZK4nnzRoss6UZIMEtVPkmY/lr5TESY
RwiiiSFOioiLkD4eTAGAnBltVHypova3LO6ukV8e/W1RfEPINbE=
=BT9I
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--
