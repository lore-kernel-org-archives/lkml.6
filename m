Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03531C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A982168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWxnDq2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A982168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeHXMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:44:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38292 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeHXMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:44:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so6871518wrc.5;
        Fri, 24 Aug 2018 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FA1JbL3Juek2hpcPqsHLO5QMOGIPrblOptI7dIDnjgE=;
        b=WWxnDq2SKGtvrafxm/6bJpEM8265ASZPhDd6Ngaj1ddYxvOD1d0YTsB97ZRd2lp7Hf
         wlaxd9kdUYkiwbQn7YbdnQH5m56czR2CGbB8cbrb6wHPbh5T2KM3zL05mWWHUzfO5RF0
         GdLEosUzgmgoVyNvsOoEJO8BnnauuNCmynKlqAOYzLR0x/zg+tQ5yVkAgsjTX/zSkoAM
         1bshvtcp9quV8C1j2HC3mQfKwjzTXGLcz4XrS6UIb1XPsJZZUjoaZXXZkkOrEmjVkBZh
         diydtB1MifBHWvk0qg1Zq8y+JLKOCLYaloYSMTAXyc4D1ytzgMkyj30v3IfZZrjNRg4f
         ZwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FA1JbL3Juek2hpcPqsHLO5QMOGIPrblOptI7dIDnjgE=;
        b=BKQBdZd22k4kTI/5anifM4mnt4+LYI37+6OSVgntRamvJlCbmvqfmk/4Hy6XdxDlo7
         j29/HeBJNdTnSogmw7MhkeqsdwLufXbCaNPzV25pSGT726YafkUPLDcXSZyZizUpP7hX
         WjCLSt2Jjfo7c/aS9XCQnVt0hN/4y7J+MvL24KxOr2p75M6vzR+M45vqIOPulRwifJJv
         HKgLDqW98ijUZNW6SP+aYerUw47W0UFO50eJTYeNiAqf22nhiS5KboRGK24x+F+MZBvs
         fPlw4AQEuULE4bUO6NpBy9xEogpe7gwHxYQt54+KepK4ttA+PK5gVW6LCqZrrX585dSM
         lIJA==
X-Gm-Message-State: APzg51DkZ68jWv6svzEVZsaVwmxNTGp8mTBpXGl5/2rzYG6hu7vNAVXG
        1UgtaAMAZ4u9qNpv8qvUiok=
X-Google-Smtp-Source: ANB0VdbcupS8U8I95WYjyb6mk4X4k49OeVKeLF+0Qgkfv6Z2LwUTZXMjq5hzz43/govS8DyQE4dRAA==
X-Received: by 2002:adf:aa9c:: with SMTP id h28-v6mr624604wrc.149.1535101865584;
        Fri, 24 Aug 2018 02:11:05 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1002356wmf.28.2018.08.24.02.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:11:04 -0700 (PDT)
Date:   Fri, 24 Aug 2018 11:11:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Message-ID: <20180824091103.GA9100@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
> Hi all,
> This series implements support for HS400 signaling on Tegra210 and
> Tegra186. This includes programming the DQS trimmer values, implementing
> enhanced strobe and HS400 delay line calibration.
>=20
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>=20
> Changelog:
> v2:
> 	- Document in dt-bindings which controllers support HS400
> 	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
> 	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
> 	  value" commit message
> 	- Add spaces around << in tegra_sdhci_set_dqs_trim()
> 	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
> 	  message more detailed
> 	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
> 	- Add blank lines around if-else-block in
> 	  tegra_sdhci_hs400_enhanced_strobe()
> 	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
> 	- Make commit message of "mmc: tegra: Implement HS400 delay line
> 	  calibration" more detailed
>=20
> Aapo Vienamo (8):
>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>   mmc: tegra: Parse and program DQS trim value
>   mmc: tegra: Implement HS400 enhanced strobe
>   mmc: tegra: Implement HS400 delay line calibration
>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>   arm64: dts: tegra186: Enable HS400
>   arm64: dts: tegra210: Enable HS400
>=20
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>  drivers/mmc/host/sdhci-tegra.c                     | 84 ++++++++++++++++=
+++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)

Ulf, Adrian,

Aapo just reminded me of this small series that also has a dependency on
the UHS signalling series posted earlier. I think it's easiest if I just
stash this on top of the existing branch that I have and send this along
with the rest as part of a pull request early after v4.19-rc1.

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt/y6QACgkQ3SOs138+
s6Geow/8CNBjRVUWrjNn8USykHyGclhdyCpr/77F6uuL3MmDMAVZGt1U7o0RTDYb
T55DEJ+4e1uoaWjSbd+DnPQ+IHKON+sSykG0rrGJvQxnEWEYZjnzfKkmfpnQZPna
R13JQlTVtRCa4/QYBJUMu1Do9e4kCgrA5Kd8h1cRTrAerQkJXWX6mELxnYx8Bk6R
zYefZ7pPxjQCoRLD3sMiLLsd+hxdLKsuIda5ztEySErZWQYZzhHGgltvDPkfeZ//
N9ZmGHyLSpwsGj2WL13SzRCbgqUt8s6ZtgtEz4W3WqNq+Dw1Gid0WtdUeVvzQHH8
eK6F2keTobhlMEqQCgyWd3HGiugnZCFaEa2nAa8lcGXNhxKWLVxDfJ7QGtSeATVj
5zL+sm7obWV+juGM3U/IHW/u4wn8N+BgAT1sm0f91rDTMcOQyOIh8gBhX/vNm60h
OJaoZKVv0NnDK9E3VJ+Iw3a4b1DODnTl8AX5wpBYMk+QdG8OiLJjGPLGwBFN1vtg
xnzRej7hSSkQOaFB8GZGppXibn63qZ19gLM1j1GIJElQGVVUtBTmXKcdZ2WwwIAB
fmSAj0yItCi6UacuoVzTkdaYb60F86wDF9ohUlehD1fLJOFWpxZzfq6sZQpJyMie
x7OGxoHF6l84SSz6pUVXNn4LByqu4n6Nweh3FcrpWEvjJEiNbdc=
=gC/o
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
