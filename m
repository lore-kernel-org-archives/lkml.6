Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6720CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3317C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVsiGJpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfAWJPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:15:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:15:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so1460742wrs.10;
        Wed, 23 Jan 2019 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V001b6OBjBCjuddvceJR/6UFdTow9JswknBvmYgzsH8=;
        b=FVsiGJpKyPWmvI6wMtli9v3OM9BlG5Gb46AYx0M/zusxgOa2mJYDq+jpWc40o+iWpE
         kVoMU9IfugyYgFJeM7SQCWwrq5QMF07eQQd+IE1aPEIxGrsZSjaY0HS6MMYmc/8r2UJU
         SsTeNpQ73g/z7q2ZQ+sQzU90fKypNbU6WtvlAylubNKklmfB5oUHBgBxJdaKvpxo91ab
         W1an7XswjP+60j6qra7jVw8DhiNOmI658QsV9xCFMiV132zMdY8kfI0UiPl9YrYOESsK
         VSUneEs26LfoJNjF0qzx+lE1aKwvwHd1lHp/f5tnWVnNMWw8wMJ6j+j/jifgo8S8HSgY
         hpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V001b6OBjBCjuddvceJR/6UFdTow9JswknBvmYgzsH8=;
        b=pokP7snaG05g26DfdRDh69IDzKl1ZTNvHQwgYylVzAvx8Uzwl5faSu1N5Y7ZnlV+QR
         /YsLG9Sx7ChWcQ0jEvWGxZcSHMhv9QdLFBoErUTWUpx2Gza4Ld4aoCUg+phxSsR1DsUN
         3mkUYDjUFlk/gc+dRDlOMi7gRxPvYNmL8tM+jKnCoZ74SvJRaN+2b/j29B33WsCGWrli
         iuLanFecdGGnCGbyeKTLD1/Wz+xNpfwCnZpJtzdf50H4B51kErzS0qACdu19zm4HVpk7
         Y5N/Em4T9AlpgrkAwfbQp+5G8HUWGCMOygLgWDUbQLrf0WK5LVrnuMUwbTZzTyFnL3kg
         F05Q==
X-Gm-Message-State: AJcUukeESUunEvGIK6oSrFjitCOYx+rclGne7PjSl0dw8jtGfkZXmwMj
        r3t/qu86+qAWtLL/ZN7UNtA=
X-Google-Smtp-Source: ALg8bN4ZNef6cwVg6GdXMeKETULO7cZOXYQOMPTDFO/n7Ih5t+1qn0mbWfXRWKFgnYmPSg8NtvL9yw==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr1666077wrv.4.1548234934478;
        Wed, 23 Jan 2019 01:15:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p139sm113362746wmd.31.2019.01.23.01.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 01:15:33 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:15:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V10 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled
 host
Message-ID: <20190123091532.GB24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
 <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:32AM -0800, Sowjanya Komatineni wrote:
> Below are the supported DMA types in Host Control1 Register
> with Version 4 enable
> b'00 - SDMA
> b'01 - Not Used
> b'10 - ADMA2
> b'11 - ADMA2 or ADMA3
>=20
> ADMA3 uses Command Descriptor to issue an SD command.
> A multi-block data transfer is performed by using a pair of CMD
> descriptor and ADMA2 descriptor.
>=20
> ADMA3 performs multiple of multi-block data transfer by using
> Integrated Descriptor which is more suitable for Command Queuing
> to fetch both Command and Transfer descriptors.
>=20
> Host Capabilities register indiactes the supports of ADMA3 DMA.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
> 	into seperate patch=20
>=20
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMLQACgkQ3SOs138+
s6EavhAAudFsfnYNJZTEr8sMOY/ebBedQ38LJY9rBEVW8M4STWhN6P3wpbFT/nF0
6K42ZkR0sogXsKpvmX+OrLE6nEK3rm/4jQnAa1VWgDXyPFb7up0oevMQ2vQ7Z6aM
D1wJ/swiIfptDmI8jOAZg79giOHsSLCJ7LA4kq91nD/PZI7RCHUNpd6DIOd4nB3a
pKE7XEOT8h9/voL9kt5KZuEPSo4rTnRssQvxn/e+63ovzeU9TljYpJ4vCRxC+EPT
ClUDSbHzK/0FeAIG0mTR32v3OHlssrOFUDD1To6b48hVP7o5/WHwG+olkYTR2RhS
GYDooX41OFuBFF7g491fYcJpXdoiCO0XdTqrLhPW0Oooe64DpFX/BHqA6yrotvBW
nQ0L7mzhfTFXSlfXo4NcnnTPDvCw7dbKmv6SaS75p5MiJ6t4vGdSj+ZGJv3LntVw
cGpPJ4y6MDZ6LCrEpZm5eV514tHezPMklY2DVKRJKPOqZF03mS06RQlSuNNbtpN2
mJFdaL68fP41jY1+jUIdSLzbCIeX1uieHgLo9/VxbYHoqmWaWa0edTIhyvsUarHC
cypLR6z649URlZLGgGf4lO9C14N6l5foFpPU5ucxvoxfpHpKiKXmYYvgsBy0buuW
v9HLYwxiIcMzBmWbEh2cRfcsUGmATAGy0riLVcae2FL90L745q4=
=FPU6
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
