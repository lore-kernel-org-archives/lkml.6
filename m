Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B8CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3D920883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZEftB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3D920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeIXQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:15:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38106 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIXQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:15:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8-v6so15328244wrw.5;
        Mon, 24 Sep 2018 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxRQI4PZriVubw7jON20L07ZiLSajZ4r6WX841ST0lI=;
        b=hAZEftB2y2zPEpHSyXzBMABaWPtq6tJR2XgiF32Bki/AAaTcdXjgppQJS0IQn6nUPr
         a59WQXBzD3224LfBmHSoFywEoKwwU7uMhtra/D7Gx5M9Kg69m8rhofrZMPpvkzrVgJeE
         BDJtv1O2bDrgHpQDnReplIMUgH5Ct2HrdgOVIS/v4SiKw9IijRko22fe9B5lPhv5weB4
         m8Pb3R0DGnOm9kxbLVxLXGamsbMjdC9n91P4nSmS2z7IbBNducZAu3f61snkcMjxzMqa
         h7uyhDQ4UouU0NfmTAsCf8fTdflUQ4sW7aLdQFOhKZWSUFiEHQa8MNl62HsPgK7luT5T
         PIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxRQI4PZriVubw7jON20L07ZiLSajZ4r6WX841ST0lI=;
        b=XwUbI2104BhrREWt7oWs2653Xt5AbMVX0K+W4UMOmr5RLaoQyEChvspTcmNy8Omloc
         FUTROLonvdNZBHf7FW+H8G21Z9LmjlUiP3caMCwZGXa2E/0ewxlaHjX9UNCqaty4B63W
         M8KegjKDzl5kKwbG+LncHsjXbEJIBBY9qfPF+Y60Q/z84VkOIPMp44NfA2Ia4hMPxsmY
         HONvFhiOlioClzi8xiDI2el1KrY6kDp4UKb1ib1MEYk8emB4D9N3OXUNEIMd3YESRXHu
         Ia49tQvjfU0COPG21yzDnShW9tTc8Cm4+tjppPbJAXXoM+gxzOk4qDcIdRTEpjwRaGiQ
         yrLg==
X-Gm-Message-State: ABuFfog9uWVVWim1b5OBR8KMrIwoY5PvmgUJyRytKaks2KbJUv8lj/Rp
        pfp9g71VFOfarst7PQ3m8cs=
X-Google-Smtp-Source: ACcGV61BPnazNXOMtcK4lLM7aGMzcCC6Rcb3JNDxxta8bXztDncrvROdbRksaC45ZCQgzgmTXqKReA==
X-Received: by 2002:adf:e0c4:: with SMTP id e4-v6mr4298757wri.199.1537784036341;
        Mon, 24 Sep 2018 03:13:56 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id g129-v6sm18684575wmf.42.2018.09.24.03.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:13:55 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:13:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Message-ID: <20180924101354.GH21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-12-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
> There is no need to match device with the DT node since it was already
> matched, use of_device_get_match_data() helper to get the match-data.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 5454ffe5b2e0..cdc33f93cf7c 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -11,8 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>

It's better not to remove these two because the code still uses
functions declared in them. If ever we were going to remove code using
linux/of_device.h and then remove the linux/of_device.h include, we'd
break the build and have to reintroduce the includes.

The same would happen if linux/of_device.h were ever to stop including
linux/platform_device.h or linux/of.h. That may sound unlikely, but it
has happened in the past with other includes. It can also happen that
some restructuring takes place in some headers that is not so obvious
and then things can still start falling apart miles away.

Thierry

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluouOIACgkQ3SOs138+
s6Gytg/+Ndah+5wwzzGFfwm+SNSWKxw4eueN/zWNhErt5qC9Q7Nli7pqMy4fYrBs
LTiZd4Xlr/g5UztazLUbbSM0Dl6QFCKZktGlhmf/P5qh/Kaq0dGZm0aHAeaeaoFO
PnHtGxBrwjf8SOR5XGXnfVrG+yqqh8EXtDWrrn0GoiNkd7Rmg7q9S/f4nc4XVjIZ
jHe7oiqRce0fmCOui0nGcfDDkQRDlbLCd6EC+jp3XmWIm2Uh9cYi+HljtlTBlM09
R+tSXfbev4WT1BbqYjGEojXM5MF8/4RkM5zheCKitoJ7laLx9G6cGQKHwNjtD5I9
byNR9lJDB+G/3WFdk0GgVEQaopN5lRVgSZdm0ESv2qJ8WTWt3Rr8wY/vRf3NA0Mu
+wYC1gIRT/H0Ipil6no6m3kveRc9Rvnw4t/APmM/hkzs4FC596z5s622eqwl7uaj
xJI7IQfHiOFGQ7zfYk+2l7JQcyD6j6htGQ1kGUkmXcRlZwHNzQ+XIiEBIoRh58RP
gQlNgBU+wM4ESeFRFmrSzQSh85RWT6PTSs05Ydaqq8LVdLVXc1exbk/+JsSbSVzb
DuXOifJSkFw2N62kZJ3t7vNqWrfdo5uZuOXOMQ31UAjx1uqSH1S/msQzpEESyR8l
UQn0zfTjcczs5uvqYUonUhVjESZ3RoqxAohWg+Ru+6DtV6HBEmg=
=quUM
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--
