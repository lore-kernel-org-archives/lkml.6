Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2ADC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A519620673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHQwOgcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A519620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeGII7I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:59:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36471 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGII7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:59:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so10098741wro.3;
        Mon, 09 Jul 2018 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfA+lZKCyyh6Sq2t/94ZnLRzPtIUaiwFVp35hc2fM0s=;
        b=mHQwOgclldcwWzJZn2yT2lKwlYi5DqrUJRCtbthsQv/VdhJ62Gm6ZLRL7RwEu0GVM3
         kyQItlw4GNiZkk1G83T48CgH+4aKwdhpsmmwELv6HaHdt3+JuOBUEP6rAKoh+naDG4ee
         Sov+m0NxptFayJiw/2yb7Rub+p+ojuDJR5owysYzbJpHOIpboYVWGwd5mVl60IujtDWa
         ikDyIWPMwhr4crZnCmISGOz2BlobYEH483N4wkCsCQ+8Xhh3Bul+5zxhBynARKhVbiri
         Fs4dws4gV41KvbPEJl0WPwR/xxMGRY64QcjT6PWKg2LTp38+2dJCPWJTBrxMm2XcOago
         A+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfA+lZKCyyh6Sq2t/94ZnLRzPtIUaiwFVp35hc2fM0s=;
        b=G5FmxCMMxlen3RifPG6VfCMJVO0/HfNKej2mqjXQEWi3jwLxpS3K8YurReWpmmHTuL
         AxJPHPGvsBdEVrVceA3bftFg6gQurYTc6GTc2K68uGM5NLNhZIxV+8jqWOhZQSSR8AmI
         6ErudkVUVk3XnZCoyz+kNCyQOr3uk8WOBaqh82yy9wnTHBlht4rcSuF8eKjMtuiS+RfV
         BgXCkHUOUtxWKQg/JKMP8UDi/c+SGiYR0ywrJvNb9SKmAwTRkMkcm0Qvntb3uZ2QPKVz
         0OykfX1wj2FpfYPbRYgcks9n7RfXVgHlsQHjIdkW/RukEjnSIlKetQ5cDqHRAE5ho3vm
         JCDg==
X-Gm-Message-State: APt69E2aYrMUzr69cVLcKQ6ZSKJdv8xQ6apZHcd54PX86T826ns5NwYa
        j4ESkTtJwcCq0ktlfgZuLvE=
X-Google-Smtp-Source: AAOMgpfZUbP3XrAHYlohSLpeeAnGk1euV6eLGTLC/3TTvU1L+Ry4H9nsJvxMdLIGFjgucxNVRizdSw==
X-Received: by 2002:adf:ea0a:: with SMTP id q10-v6mr14239967wrm.224.1531126745237;
        Mon, 09 Jul 2018 01:59:05 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id b11-v6sm1960427wrv.82.2018.07.09.01.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 01:59:03 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:59:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ARM: dts: tegra20: Add Memory Client reset to VDE
Message-ID: <20180709085902.GD13963@ulmo>
References: <20180520134846.31046-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <20180520134846.31046-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 04:48:44PM +0300, Dmitry Osipenko wrote:
> Hook up Memory Client reset of the Video Decoder to the decoders DT node.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDI9YACgkQ3SOs138+
s6HNlg//WWXO7YBRWnaR2AaXE6q2QxdZKw7Fy69Flx4luA1rQYO7jlMkh6CQkxra
gbzAsStpe3WZSKFjgC+ysUta7zRFmBG2uANyUPp9UJp28hVkJSwV5JzY8McNlLZ2
n8CV7Kj2JHRi/cm7VeaYaWVkOdZF8sKkKuowqrTlFCbFxx1QqGxS5n/lyB46KB8S
2MWXWoCCUAq+bbHPUGpMlWgjI+6eoofVAB65wQdsX1bTNMv7U5/LkokbU6xWG7uA
qutgMouPOhqtTztX7Qspe30aVn+bvdjsQwd2/KwYJHXCVtrKWYyIey8fEcUzWeFU
LnQP+rnYEB9WA9Vpx4h7Gehs2YlQ2d68BWZX0mijvFMlj2gK92ZMGg4qyscuAMjd
1jh5nYzRU8JKlNPXo9HTC3rifQRJFlzm00Ch9zXRYH4KGREqg06ojqm22OHGNOvZ
UU0wyg+BTFGmwnPIDKbebFm1XtUpfR0UfI8/Ok3m5DF2n5QOSz2B6+vboGAO6I/2
kczw2NUgQdjnwaqJqro7rzD05wFeNbjAwErQTLijTG1ozqssZoEpIupkmKIv3t3z
bWQZkQ+m/sqJGgI+dtujIO8QmFT09qCAiUSWdqxFKZUv2XgHrNNMhsQRNXm5GDfd
0JSNOhZkMA4fijTrwHCmpEvhkJ5VXOXc4VJE7CbBziwEO1RZnPo=
=s+P9
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
