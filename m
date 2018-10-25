Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8868EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBED2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d19rv/HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBED2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeJYXAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:00:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45643 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJYXAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:00:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so5773375wrw.12;
        Thu, 25 Oct 2018 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5HBugmwc73CBas65ljXrvDIMm0j3Lh0EvZ5z7zybPE=;
        b=d19rv/HQJugMgmhq3z5IxRAENrzH9gqmRJpvHpuLnt22TzZxdoSg7RI3Dgof95i5Td
         vOTp4fqStgQoClbxu8xwsomx92Q0oUKasMWALSuv7vZSG83aljO1CZfQixW5zOrlGhLt
         ma7wxHfRhMcRpZSneB2tQaRUcsF36qzXkeX73IgBigbEn7awslpNJRWLrYsOjzFo8g1a
         e5rkyGXKv/p6PWYy+8KHITCYLtVrfNIkboI5StatJMOZGPCATAejCj1zPFTCN1GvYcb7
         7fWWKaPZGwv+0wj5rubis92Twbvp2MvuYpoadMefFzT16SEA43+JxjjwjvSEGo+mCPiV
         Ihqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5HBugmwc73CBas65ljXrvDIMm0j3Lh0EvZ5z7zybPE=;
        b=TWY4JD8oj6IDGB/cBPpd/V4UaoI/JsTrdZtgCUUEtqvg52FwKpq4cHRFmB8kXkE93O
         1SemLr3lm1m9mOMDw0fcfTcMt9Xu9Wv64tuhSpJdcCy7FOvWfhOuKo3ktqnxfu3oJl9G
         wbe616qIBE5Ot9h4ehbhFBwYKQ1HRjSSa7ypeduDo2G5kWIigOY97Jsu5x8zbN7OCeqW
         SNnpYwwvyfj50P9GUMQReXg18Z85B9zYbxbzLenXAJOS8Fysn+u2CzGig4drKTifXNtu
         Hzzmp7hOHGDHzfW47GiiEzOReL/lm3YrtG/oH1EAUrvEABPO3jVrrBwJhwm/0zuEqjC1
         n3TA==
X-Gm-Message-State: AGRZ1gJoFtBmzE+CMa1hBgxVuVMvOY78nkEfLvXvW82Pw7rJoJsYmQmP
        HHSS0FmZviDyGe+GUvL3P7M=
X-Google-Smtp-Source: AJdET5dfBJlVk7rv9f9s62RwpwUcfaBwkulxA4tWqVQ5ZrR/quVbmsDLIZs5lxkzpDEU31APsfFHvA==
X-Received: by 2002:adf:fb12:: with SMTP id c18-v6mr2222995wrr.200.1540477631914;
        Thu, 25 Oct 2018 07:27:11 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id f1-v6sm2528361wme.23.2018.10.25.07.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:27:11 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:27:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] dt: bindings: Move tegra20-emc binding to
 memory-controllers directory
Message-ID: <20181025142710.GF21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:47PM +0300, Dmitry Osipenko wrote:
> Move tegra20-emc binding to the memory-controllers directory for
> consistency with the other Tegra memory bindings.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../{arm/tegra =3D> memory-controllers}/nvidia,tegra20-emc.txt      | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/tegra =3D> memory-controll=
ers}/nvidia,tegra20-emc.txt (100%)

Applied to for-4.21/dt-bindings, thanks.

Thierry

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0r4ACgkQ3SOs138+
s6HOQw//Rjp6kXA9/91adpOJlPQf6ZwFMIUiCvtFHMZHKh8HlkGBv5Ts5vm57/Bs
LZN3rJHkDRt6/dlGU5Vy1F9jsytOGI1H7tYF1nFWwMssvHLFw7jQFQVDh8CHBtge
TLXQY3a3VjIzoXD6LChDapBVVZDLl27xitMx84K3KTCjvAnv2HbNwLVBOwWuTcQD
tL9geOa1IOygm/04SD0Rj0Lv7Gsk1KfJz5W9PU+ubDD6C+IIvDd0oeo7iMc1xTFl
YgEImPJD+cjYS9i7Qkuq4pRbd1g2bC7pQ3XaUFFtMp4kB/8mYSH5PGSOvVkPjQRH
K+XY5TphuykXpNXd/PwQQtjPfLCdqrEIIcDr/A3OSkdW3hr8/M1sKikuKdN3+0JM
aQCw6P/8M/3uhbd4bwmbs6cB/2tK7IIh0780dZQK/LJ+PtdLlSitU+QxwW7E5NiO
P8hjEffgJIOTe1WtStTtyd6Sfdelgdy9JbNHcPiNdT3H/Lc3ulAtr0lgqu6BR4bi
zaImCb7r1KC2nIU44jahL/t8hemL6hVsHcrwSRgDtbG6+ERYpTdUBdu8vd3u7DUb
fL7pFeF7q1wyBgfQ3n7oayuZ3GxvIejZS1vSsCm9BuwoYK/g056BImQYbXP8wM31
fpugoHbY3ufglZJQVyE3RtjHRab0JN9PETFXA6NeHyG6HqBHjeg=
=XhpH
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
