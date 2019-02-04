Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD2C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027D214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8WUlQ7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfBDITB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:19:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34048 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfBDITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:19:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so13443981wrp.1;
        Mon, 04 Feb 2019 00:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7apd/E5ngH6XbRW7qSNgrjfXnUjxaybgqMCDkoklDo=;
        b=K8WUlQ7dd3BTOORQZyl9MaAQG18VjDOEVoj0GWGvbtDZc2Wo7GP3/Dt6qvSAoeku4t
         MIKomou85oj+dGI7/J7OTe9Wyilzqq/B08xsVhPobNg2aAY/Ggp+Rit1Icux6euCONQN
         DwIwKB3UVkLKZtn0ApW9jw/vpDhLMOetQgwJ2xjxTdoMAQTJW1biG4NpIBiyvIJ7z9tN
         6VwisDv/dsUuuRr+jgiFJuh62WjY80NkQRUOJcDUDWt9FmU4zlyxfKnzFjCI33KUXH0i
         KRR20cROJtBjxA94oVpURcmw5yXF4NAEpM+T+FkHyPZ2+GMEoUiinMmgIWQ49JlCJPO8
         qcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7apd/E5ngH6XbRW7qSNgrjfXnUjxaybgqMCDkoklDo=;
        b=LI1vriDUQ1txvg4iEpHqSOyj2SHAAFTrMuBOdW1MTZKkxwtnPSEHb/VR7ZQW0bXwWT
         C8xMaZdZ61cIC8zyBL9TigOVOU3rK/Vjq5zkSjO+fysURSBGWL0Aweez9G0TpUaq8Iq4
         RKe7Xk519as36sninGGwOBBHKcx5j3+IsmcDhHcbZivsF4AR9QI44c4sRcJyIlYKaZlk
         tD1xCNdcwEeLNcPJHit7tF1k7egXo3f0TXKAeBkD2sTuxY/cEs5p93gR1H5wRrDjnJbL
         qVk7/YCGEToslTSS2bRXvDbiAKnBjGLfnQQWro+TK+gbT95tJjTdmwRC7axip0zJrt9Y
         sgTw==
X-Gm-Message-State: AHQUAuZFjCdMIrQiSCwrcPyWBgvwud4CTVRX296OYlAZoycXGFK8FBz0
        JvS+gpFCwBIGQrewGWFqGDU=
X-Google-Smtp-Source: AHgI3IanFdgXlaTonQVFosLv3aERIyFas3woOMk5tvEHQrsLBPiHQkqJG9eu5MEJZPHQk82JwB82uA==
X-Received: by 2002:adf:e68c:: with SMTP id r12mr2766123wrm.163.1549268338320;
        Mon, 04 Feb 2019 00:18:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q21sm2184251wmc.14.2019.02.04.00.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 00:18:57 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:18:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Message-ID: <20190204081856.GD19087@ulmo>
References: <20190204074854.1538-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20190204074854.1538-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 02:48:54AM -0500, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
>=20
> Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> Cc: <stable@vger.kernel.org> # 4.4+
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> v2:
> - move of_node_put() to the very end
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX9XAACgkQ3SOs138+
s6G4jBAAlgA2xdi+6rc/lInEg58zKJ0Zho9KQJtCw50zyKh29ehRJk0FiH3JHasX
yKm87ps5b29isZOQx4vOcCgKI6qSl3zhHCQwSFbcJAtabcIDU68yBJtA45Of12WQ
2X043Rc8Q41+Qzh4c0zK9kOfExkIZhMCdiOEbwyZ8qkKPw6JzagKfRQzkyDFUTkE
6S34wMlA9euHF59PcIY1GYuZy3x9bLL7qfef42wJgU+tvR4e2mkxE5MGlPDlkeli
ptVC8Fm+vEROwynHleP0SYPPjmWEcPSkdBUEfADQeTeQS38CoCapTJb7xolN48k4
j+k17gy2v0Ewf5SDCYGJTrKRjtXvW1VRMzrXhMnOajJ7u3yeIV2iUORIj7MhSFhG
Oaexc16CokJsMaeEZD43PT5kz8teb9UvdC4f+7KGeYt5jMY7oMkec7BpDmm3ZPDt
gJkk9vDEaQTj7AwoNSqJzI1Spt+oTeNzRo54ZWxRJydld7ZhqmU2CuGTAIP/ZFs1
WCeZtH6qH0eZo8Tj0HwNEZmu93A9+ub6bwPlKWsUIR099lgqQ6RSvBaytvBiNXDX
bYTih+Wm6BsrvlbNdVcEGVBnsVFfzNEnnyY486nDEes7lHhedIIRDpx8lYDLUO8R
jKZbTsQx+4xtCkQcJHcUDYBSUtOU4ZGowGV6o7wG1BRoP8A2gcY=
=1pfn
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
