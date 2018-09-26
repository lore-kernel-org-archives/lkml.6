Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4995C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E76A2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK/hMQcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E76A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeIZUxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIZUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:53:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so13988015wrx.2;
        Wed, 26 Sep 2018 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UAaOH1sq+7QhuVbhZ5P+V+T1JRfLhe6VXLcwOUM/V48=;
        b=SK/hMQcDw7wIpj88CF3/sr56/sRycGJHyLovlypGVoFeEBTY9J7jXy5BzCwMNGFiW2
         qW/Mk0kFXiMqxpSRzH7xClveaEY5pQZ8Gzs0/PPV+5gLZ732y7kcDPQHEYzlXDMghxHT
         9paYm5fuyHu916wfbO9BZicqu27nZ9EhfRAOpvsIvWWkkktBCYuH4nLkYyPJ6yBnxDdQ
         YfX8wU5i1phgvwQ0J/OGzu1KiUcjtoN3QT3y+feOCohg1uZkbdU7lHiQMDHxXvllhgBb
         kCSbpwtwAnBtIaza9IhKAtnj1AqvlzQMEHjRa6J+BhIUdAgp46ezwnjjHkHURUHrctMA
         z91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UAaOH1sq+7QhuVbhZ5P+V+T1JRfLhe6VXLcwOUM/V48=;
        b=G38HAm6jBTkvAhBMuQmVZzyf2UZ2l9gF8cKmVaYK/xkIb6eUn/uy3Womh1hw5/zgGj
         QhQ8+i0AtA3c7AAGaYstSKmxWXSdexYV531ni5bvcpknm9P1XXdrdhxeyTJz15vck+rs
         m8MTrvV7AZBBi09Prfg6eSgxsklw8a+1szzKgvof9avrZY8Vqr0jbNallMpUSUZPMdtM
         X8SSGNoxgkjyOXHDAGFObmeOhU09epZwFbYS8x+jARn09dSi3Co3CJZsgaeVSWY5MWNg
         8VplsTXQd+FS6GSKBn5at8E2wdrEOr1mBqIoYEHfJeqQWSrQ3mEeEKzFtLffDYuCPf8W
         mIUA==
X-Gm-Message-State: ABuFfoi2H1G4/SNmqMr1GeSGvgYdgz0RFanmhAyw7TCzM8FfnahOPiMI
        3GgnwXhQZq22Opuj73Bs1HPmi3mS
X-Google-Smtp-Source: ACcGV63rHfdHGzHENnBDK0MZabF5+wXI68vAbqW1riPPGqnXAM4IB21N05Dj5h24GJaOR5SzEJiuoQ==
X-Received: by 2002:adf:8288:: with SMTP id 8-v6mr4916986wrc.252.1537972826531;
        Wed, 26 Sep 2018 07:40:26 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id x204-v6sm5620975wmg.27.2018.09.26.07.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 07:40:25 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:40:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: tegra30: fix xcvr-setup-use-fuses
Message-ID: <20180926144024.GC12980@ulmo>
References: <20180831124233.27156-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20180831124233.27156-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 02:42:33PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> There was a dot instead of a comma. Fix this.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks.

Thierry

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurmlYACgkQ3SOs138+
s6FPMw/7BwZGUQLlyKAZYjOdAHiR00ci8BsZ4d1yyRvEJzXbiIHjp5cZqWB7iYy+
uetPBW58fG+ph8s8CMTg4i9Wa4FCOgabxsrpCuUd++wCSkW7Cs7Z/4THOydjQyFK
t9BzGmYb3gu/6SJmat/uO38Ig3JkdHpvSu5ZYRylGuC65e+z7bOs0ODrcPPNzdit
v0f7URkY2voeTgnF0HGUlmS/LEaaCpwQ/uOUnLqJYNSFbp9sWijgyXN6Kv3RNJph
SWnO35+Fs9lUNNZLKkR9ksOV+uM+mVOmQn08BeW9VtrReMzfz9ivAPmohCH+XaDn
KQtQr4bfllUCSNBmky5pUGmkUjQyZkHBAL5swBJAymePbagnbk3Hn7bau8u2rI8J
WEYYBoYa/PaSU6a0BXNy2v95JE2yvf+pM6g98ajeLNoGWEBuSX3e5jPbWsAKKJ/P
RlmeJwwIUDg0/080cIw78ompVRjHORCgloIESInZz6nnwxw3KPShBgjJsfvFMrOJ
lhYPVA1+AtpU595vQckclqyqLoiS6pvz051SSMdDXeuZmsca+hISjqfty7R07r6/
GoL172eIJ5VtTJOy2zNQD0pKCx72WBU8CiYV/B2m04Izd2ICA9eb6ZR1273ggVJJ
RWCvMHriGA4sf4P152hHjJqbs0DipYYRehdcdlqzHR6KLXooXwM=
=lfH6
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
