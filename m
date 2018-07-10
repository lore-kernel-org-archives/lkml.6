Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E29C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BF2208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phZ+ZbyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BF2208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbeGJPaU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:30:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37690 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934108AbeGJPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:30:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so24832168wmh.2;
        Tue, 10 Jul 2018 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dg7ApQJLo/VkFt7LVm/12Ug0ZLaRO7+KaOKy1UOcDVQ=;
        b=phZ+ZbyT5DgtdnGaXGWBV+Gc/rkWNSqcl9TfkwEDoJRNdwXLi7rgTKFIDdWOpIAd29
         mGiap2cbJeK7v8hs/5+VzEhUu0+yF7L/DwDVUGEw0sDp2d2que+ExvMFbUS0wXvC1J8Y
         d6qPUYJLUttLQMRuxcCHAr1ABrrms7C3keR9tmCwkNU8fxkbmC2CvdOaP1skPCbnX+mG
         Oxgy6Tdu5BxO58GG7XOX3X14JnCVIS02JeXCAljq8sirKYpdVen4vxnCcWzGu7KmnuZZ
         VDovUe0L2w+uESv1qoHnrCAP4iFywty2pkUrlbuw1/9A3K+iIiWWCFLVh/fvjcycUlQU
         4Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dg7ApQJLo/VkFt7LVm/12Ug0ZLaRO7+KaOKy1UOcDVQ=;
        b=SAIjMjQr0A3IxMv0Wk+VoNQeN4B9ovPH2yMNeEjFu7EcHVxLYU06q1qZPDRTkZpQg7
         HV8mNL5ZmccyhZ9/6nwTJbQxocQlQ4g9vUfBGEW/cOyZEA+kD7zENgN1+mboLBRPxb+p
         1UuXxcBFBhkbHzJXiUgsX72ELuaSO61AYmX3M8BXYbGK/4ZQ982Gd49+hv+u+FzuGXR4
         SRL1OjDC77TJaOAbVGbV/xcyi9B7jdVeI1+1fcf0PxLFri6BOSB05/QwYunHkNzY0W81
         14+1pFKK0uWHgQzFBQKHF5Tj4ZURfFTuH/oYY+7wPUdBdszPjSCDJHw0RpLEsuZCHQOP
         xaOA==
X-Gm-Message-State: APt69E1FwyVCMm8naSCkvHOvjCfiNC/3L46fPZh08qh5sSoVdV/7BIa9
        sB0Sz04gTrVKpuI77FGCDPO5Ig==
X-Google-Smtp-Source: AAOMgpfgD6CZbkET8a0Q3sqdhrTew8krHr06FW1pahO385hYBXA5mkFkUFu9anqD0/fFoluGEekrZA==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr11741749wma.85.1531236614173;
        Tue, 10 Jul 2018 08:30:14 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id f138-v6sm20146263wmd.13.2018.07.10.08.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:30:12 -0700 (PDT)
Date:   Tue, 10 Jul 2018 17:30:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Correct driver probe order
Message-ID: <20180710153011.GA8492@ulmo>
References: <20180526142035.21741-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20180526142035.21741-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2018 at 05:20:35PM +0300, Dmitry Osipenko wrote:
> The Reset Controller should be registered in the end of probe, otherwise
> Memory Controller device goes away if IRQ requesting fails and the Reset
> Controller stays registered. To avoid having to unwind the MC probing in
> a case of SMMU probe failure, let's simply print the error message without
> failing the MC probe. This allows us to just move the Reset Controller
> registering before the SMMU registration, reducing code churning. Also
> let's not fail MC probe in a case of Reset Controller registration failure
> as it doesn't prevent the MC driver to work.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltE0QAACgkQ3SOs138+
s6EXNQ//TmjEdaaaK+ErK3EnaTZ9oPy2xDpGGCQ1x/CW0uMT9WsRsN/r79fBcDdO
CD5dTxZCn/n9tB1EkhdftIRZH44KA5UKnHEqZsjFRP4+gCXjuj1lSjY/eNPSRC+k
4aJWsCEB/YT0YLsk74BT7Md56vSobQmH6575RYDbur8EE9AhHtkfX72HToZX8oRs
3V9LEdyeCcB9wJlqTBCWvBqmqHTwqSclcNpSt38NpJ802TgQznydhGyaGmvXNdAV
+ZnXf91y0S/kOnQLM4/axy37X7j06W+bAmgmnjADkbm5nKzTzog0eBbeo3qytyUo
r1ge3Lnh6V/2Klmj233Gzx7jRSiEFi1EQfEOIARCGkQQGQY6pNynVzQXPLlxfk6J
8blpAw00vlzkUMSN0tgvy8T7XhYEfKs7V90Ab3/a37IWSLObGMETA04BgEWFcwVw
mn9BYDVYMtkLKeIbZawEaIBa3O7WrGB0tR3xWlHP+Uro4aWePnnBsGsRAhRqQxYu
GQYnZiaL1mAWDDiAVccBcFw3rKVexu3WDbBQzvsX9BBkwqhgYsac1TMo/5OC1m15
ITRBr2YT8y5ctW8pgrSkKu3qbQmjAYDNYDM6eV+L2fdezfrFpmWyb6phPl8opm2a
TEywKPjQ/k5dc6zGXxvzdfjsqtT4uBZ19Z33NxeQBPkH9u2152o=
=Sgid
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
