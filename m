Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934ADC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B8820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtfenKap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfAUKlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:41:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAUKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:41:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so10285917wml.3;
        Mon, 21 Jan 2019 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=einjsXR4NN9dDhGWqF8Vj2NFD/NsgZA9iegrJJ7eJkU=;
        b=BtfenKapB6XpHaDYs6+FkI8PS9oo2KAp1pwfDAAnOuQUmsaVP60BuOLvroSRCHwmXP
         UA+robLlsZn0WwfnxAdx7KxanSjb5WyXDW2eTJGF9EbXJztNbLPT+p7Epe3Ctpszs6bX
         uP8sITf0Se7c9godOK0Hl17ShNrRO1/jxs37aXSQ2A93aJ88fvaIiTqpumChnpclzX79
         gr4XlUkSndytN7d8dHDj8djJjLs9KVfANW22ufkE+PiGquc/Ii4NfkdlUQHRLf0Aa1Mt
         4OBbb1tMWJpzgyJI3FfnPmC1uUsd7jgDlp/2uAQTjOi2UZrW3tK1LjqtQ5SnMHrGco0+
         7Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=einjsXR4NN9dDhGWqF8Vj2NFD/NsgZA9iegrJJ7eJkU=;
        b=jr6PFVTF0X4QSlc/Tu/7sw6CwyT40RaqFnreJOje6DCtvMOwLjdjFczBVDJSmwWBt5
         looomRpT3luOELrixkTc5fW3iHiHL7qipfb8v6YVQssqB7u+nNQBkRmXMhsEYA/Vgje7
         d1dDt+Id+bhbD6gX2N2l3/awu1AkCxlxJn+TGI3avoSEqQzIUHYTjp4cU1faqB2YNX65
         fFOZY95Kt1FrdCujEWsS9jzJKaNDjvXQVdJsZrtEIP3lik/0+ZPjKG2F08dny9SdtuNK
         iVOSkrdDDLKV73vVLO/zAYp3eDt9FHXKlgzCrasQhrmLsp6mifmJWN7Ogm66tPXtWOY2
         kz8w==
X-Gm-Message-State: AJcUukeanrR3h3wabmHdGviRiVK1dJjndAG3hO5W8VrZMcuzmO53ezl9
        aVV5eQ/hkP0S64YjMu6NHCw=
X-Google-Smtp-Source: ALg8bN7SxTrdlTjywXRW/yp3dL+/RLWe5vDE4Gm4mAGl6Dx+5q8GfXtx5RZkizvBjs99kiovj6KdWg==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr25457203wmg.22.1548067301603;
        Mon, 21 Jan 2019 02:41:41 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y1sm63182145wme.1.2019.01.21.02.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:41:40 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:41:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Message-ID: <20190121104140.GC16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:03:50AM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for Tegra SDMMC.
>=20
> Tegra186 and Tegra194 supports HW Command queue only
> on SDMMC4 controller. This property is used to identify
> command queue support controller in the tegra sdhci driver.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFoeMACgkQ3SOs138+
s6Elsw//XH8GBfof8WNRotmlAsBr8UGEy1Qj03d3EXODZ9sNEA31lfvQIi7tLIOZ
E1qg1C9OMoTF6JjQkUZVEzH+9MwRq8qQIYUASfV/K8VDVNQn4MMTJJiPVd261PC2
8UUV+urpys34zL63rKTlZKi7M6TJuZdxDLK+cfyrLcooj3OhkyJZQzPt/xRUgTIc
tt7pusDKcPQtZLis4fIPxklZu4wCO5xp82FlZ3RBKNhqagiZl5qLFrKvPfRN+8JL
t87kP/BhCjQgCkNbZF2ntct9rYS219BcxBNzqt9yq+bZGBZ2jLQeaJdc1kcwhwD4
WXK1dNeYVa70ijKC60TTS+76dQn8Pl7Rqn+1DbVuqVaMZ3IZMPof21lXqB2d8ELf
/ZpWjVLwxSGfyqSD24tWGNF6mxaxfCY84wJKkr8yT6hviQl1Yo8GbuoMqX64iTo1
nfPgywzf2Xhr/WtzBsVN4glVyfssOS96uQRMEim2H9yWviY5WsjsUp+nP9GwQirL
9cLvjwFsmpMXBUzX8yUSFhpn4tEvx++dVN722SBLcwSj9jZomtNwK6A9FB4lK2+1
zd/GuMckfSdUzkRzktzmNBdQuMgS+PO1PioZVkbMOJ+yDOgPUPVuNx0MXTMDWxxO
vSBZP7MiTd7mFG0Y5gVMDvOAlroN1EYSYlYxzYsgOm03hc8BcIc=
=HyMt
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
