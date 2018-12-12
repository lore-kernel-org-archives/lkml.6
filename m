Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE60C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C6B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAzWa7tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeLLKFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:05:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42143 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:05:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so15018265edp.9;
        Wed, 12 Dec 2018 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+CkkOYAad0zEd3tkgpxrtam3ZYmAw+5Or90f0wBvf0=;
        b=GAzWa7tA6HTJkGcTc/w/WcvqJ3nH5YVI6CLzJE+VpNrZC7w+vLc2OqPGp4m/eEk/DO
         yixMoWpwckuOiIA3sjapU0zU8EYNlmmkPkdFGue/qkp1Xwpdw1gmCHrWVoN3J78LZQyt
         8K9O39umAvBPsgpreR7kUvZGe3yhLNGpcRxOO/H9pFP6fkLISIalbMVLLc7GoZksXbYW
         AsToMfznj5BztLuFqf8NCVlMxDCXzJ+9ZgPNPlNNAzX04+PQWRd6C9RyGD18RDYxIo9c
         Hc2ePcMR0nqRo7irZIeH6+ho5Qu3IhxlhOD04bbn/q4ylk9b0HmqHwVXy6oq4VxvVcUi
         Y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+CkkOYAad0zEd3tkgpxrtam3ZYmAw+5Or90f0wBvf0=;
        b=Y0UO7nGJo+bq3dnT/adrXurODmAe8Paa9qqphEVz3o3xfTpTl0eqD4LYn8+i7CaOt8
         u8HsCKLbbPYkffpIEocIaYgIdmiFw7JM/ElM7dTflZ3Vj6yUiiWR8H75YONDMovLBlF/
         sSxQf36nlci945j5c0btPvWpzjCFDu8qyXo+v7EQfemfCxAMQ7nDI78NiA77cgdnlacq
         YnY11xLvy/+vsfTQBwHV/Mz/aA9+a2o+qfXbx7lw5nASkGPvN7AImMxHyjl1/ziMjbYh
         aiRNHLU0xvpYdAhuVfY4yKO6TKpSYefJNRJxUFkkX+drB171FOM3p6lh3VIpAkV+WNWr
         pNNw==
X-Gm-Message-State: AA+aEWaMIT7hH2R8xLjytXihBg9/j4j6JQunJPy8B7xu1W5aDpoy5gEx
        +l1NaFwbJB80yVt51MZE5n58Yytf
X-Google-Smtp-Source: AFSGD/UbrupkmuesMomugGRvtSus81q/bMC7kJwHJtpcExUb0KB4wMzLxb319fwPasa+s1qR/DtUUA==
X-Received: by 2002:a17:906:728b:: with SMTP id b11-v6mr14606419ejl.206.1544609110724;
        Wed, 12 Dec 2018 02:05:10 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j21-v6sm2609714ejz.51.2018.12.12.02.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:05:10 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:05:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/21] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
Message-ID: <20181212100509.GF15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-10-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:38PM +0300, Dmitry Osipenko wrote:
> The tegra20-mc device-tree binding has been changed, GART has been
> squashed into Memory Controller and now the clock property is mandatory
> for Tegra20, the DT compatible has been changed as well. Adapt driver to
> the DT changes.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 21 ++++++++-------------
>  drivers/memory/tegra/mc.h |  6 ------
>  include/soc/tegra/mc.h    |  2 +-
>  3 files changed, 9 insertions(+), 20 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3VUACgkQ3SOs138+
s6FhWA/+MEvfdkIB2BINTp/t9VcU2fno9yZ3NKsAdnSlQ9cqVzaMDopgDEFuHwwx
L2CLmgslF6g1XGzUHnAF5wdpjWeIuIlokvvti/SLzsd+k97/bS7yTONuXOFVZ7kL
yNrhbvCeGVqFBE0rhHr4plMa3vDabI5AZfFyJ2+feZ3Yg7dMMlb0YIAzNUKOngeM
4+PSdc7uHZCpiL8/cPjgyFiqZ/Y6VZuthtIjaiJIm9h7j5XoCcCqRUnI7AUY9wtY
q/BjYJRE8+HrvQe3sgAIOoP1onmZE0yNc5HsgepTkl7Sc6f2kfSAvFGVPAIC/k4n
n5BoTdfoxHCFjFEpclcAgaRQqFzQYg8FndRRtVbvmQ552cxeoXiV50D0mFGTrgvg
3j9NoN4V3hqNB05QN8GnZiKxAgBMwwsS3YhnnED4X7qtrXbvlRFSEmF84s39RCh7
iAACUo1VPlMIPUNmTdZ0foXwHRwdBOJ5Iv22stknzWZ2rodYzT6IoN8bg4NP9NVF
BPurKINP2AJgXOJgQpHa2+lI5I1sYnkUXhOsqPIKekHkZiTVhpd9M0y0dYhdc1m5
LQRRAtAviLSc/T8CWUK8XIWG4tMT2a0K788sUZhFzHcfKnBxHLgsWYKc5Csmxx/j
5vaqT8KQEgubrJtNmIho8SziQoT9ophUgBWwOI8hyPagjeL6fAY=
=skgE
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
