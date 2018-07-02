Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A3F25370
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc4UCnSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A3F25370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeGBMwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:52:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38062 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeGBMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:51:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id j33-v6so2563091wrj.5;
        Mon, 02 Jul 2018 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKuLe1lMh90+vbs+f1kxaMmIoLn8emCTnjZWq5+IzY4=;
        b=vc4UCnSouLQnhBkv6h6roeUu5hezYP1ZeOph1jrZVTiTO1HxCzDWoR8vTbeKCODNn+
         +zyUyuZayqH1CqGKpvQabHmE6UlRJyllyWigE54AGkH5TdFK3JUnHhbvpP7jLtA9ypwz
         Ir9EDuEpWfVamu2FSVnaSeHv2HawCe2Yfo4C1jGnmpVcgCoVe7Xa+7Y0htnYJ2oiOzpx
         YIOCp/ueMEbWQiVBnfXI6FP/pNu+VPIhMvh1LksfJKqGNsOJR6V6HGQhzUoTUHVGQkBv
         bjTgP0+O42TJLXqkOGo39F7ghLo655sUPhpWKu5NaX1Sud73DrEBGDaJ5DJIyCXfpTRy
         5Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKuLe1lMh90+vbs+f1kxaMmIoLn8emCTnjZWq5+IzY4=;
        b=NbfgQnV4bMvCXYPmt+7oilNrmXqqTAy+C91GNJsus8MWd+qJs4Ezbp+pHNK7rzK9zi
         qjHFAGFSDBfm8Ha37Y4sJTR32d7Ubf53tRZ4aUtNXd69VaUiekEpLG6uU4X5ETS6TYHy
         Ms7Pyqu80pHFD5izr0uCDW+ziiziLqCHqA+AkXUanFJNg1bIBxX0EQaBO2hlJGRyCBq5
         5nBtUiSqwauhHwfzZGXeLHXsdDbhv8qLp4oPlM/wOnQM+ud+zUQeM7ar0z1nNvUfJ4UY
         nao5IdGJBmS7EYyzmMFnw3Fmzc2ZyZWsI9+jiAim5X7oldSMgzTmdbOYIGWyN+/rbOZz
         supg==
X-Gm-Message-State: APt69E0vZ+0eSyXu8LytD2mFP6RzI5E/d1bp+MdhZXyArqzJT2fvJ72F
        M5SnBpMB1ualhYcit5DmG1M=
X-Google-Smtp-Source: AAOMgpfxeXrTHiEQ6MUt9+roZfjbHmMRkGqgBVVDetNqj1FcWyzFPKkgZpTWzVZXu9J/p6XJYuBmsw==
X-Received: by 2002:adf:d4c5:: with SMTP id w5-v6mr18821325wrk.185.1530535915988;
        Mon, 02 Jul 2018 05:51:55 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id 127-v6sm10427630wmd.18.2018.07.02.05.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 05:51:55 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:51:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Message-ID: <20180702125154.GD13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-3-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:27PM +0300, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Added Rob's Reviewed-by.
>    =20
>     v3:
>     - Added Jon's Acked-by.
>=20
>  .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra=
194-tcu.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6H+cACgkQ3SOs138+
s6Ftgw/6Al7FwFrx9x0Bqz8/QSQwlP8RexRWeehUJgvEHfqeQvlUuDnGjbzykNwO
HaxhGzpGfckbwKqDAdbrkR1jLOdd/dckJBT1Qz7Co8orMhHcjxlHbmNV43t/t26w
r7qBzH5cM9FkC8vmMjNhRP3REOqDZ1HOuW2Zp4jgO9EeBKGfDWnBzAiyYLWVkH5n
Az1AEjSF5Rw54D7Mbt5EWGQ5oRp5waxyboz8D6qw5jVN6vHwudIM+3f2pNv7iIix
9aNJvJLOk+RAbce8vFOuATAc1N/7CSJhLVvBW97hXGt5cTECPMdb1jmqT8IkofrR
k+3PA+yacx0KLTf3vZXEWrqoAndJMd2XEJFJE1zm2BLZ/s4qvXAA6mZjVCKe8wIU
yKeE8aLcptG7WPgRfF7KI6UO11q9igpQ9FF2LMIUcn8snTFxbli4RqcjX2E6nShD
Mh1iApK4uu05AeKY4G9l4UFd7jFPBK2ajTeG/MprzF9Uyu+mjxCjlZvSZKo3jIAs
wsUkMNeuGap0yDxRdeco+lO1XBXtYWrnSk6twI59KV5IO0bj8nxZrKn2SBgVo5G+
QjvnocC7hno+Abx3xzB735rKnu+VNxH7HDIy3sj4smfwwtGrkwWy0wiSg8OUbtDB
XojFX8e0T14LttZnLKWshq8iAOuTl1lpwhOmMhKTaI+DrFdrRWY=
=1DhX
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
