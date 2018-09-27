Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECD9214FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejvH+K9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECD9214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeI0SXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:23:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35478 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0SXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:23:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so5725769wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZPTXli445mUPNm3UdaNATqmiA/QbbDo0dTRZDIk38Y=;
        b=ejvH+K9NkBpLoWOv40vJ+Pjz3byNO2uMgk4JTl5l54lcg0JSqDOpC5Xr5tW4Orkwo1
         ANkMN82q0ujgOA5RtinecY2j9UZGqWAHPfQktb145uoLOyGY3MoOr8ZgvklpoOMW3d/f
         k1rLHRsKok5tWyIOf+uwcErKlCdU5OTV2/FI0Ame6lrdESRmOlcFS/kOkOjgOlQmqvK7
         3cQEcrHJtowiKJ8Cl4I6YHNJT7hCeJOcKz/8gJCO3rfB3ir8BgD9aFDNB8uCts9+d5hT
         gE9BuOCLaXwNymTBQxrdbMphnJxWaROeTZsET/uoQrblOmoxzC3sYfoiM3UKcS9s4IXx
         mOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZPTXli445mUPNm3UdaNATqmiA/QbbDo0dTRZDIk38Y=;
        b=TrhIRBjSmwqVi1BDSI+xhJ0KRvqKxghQVxB0f3Bxv0zktqwoX0dofkkG8ol4xp7KMP
         xhzWK8xVuQlESmBbQpL5HLaIBbT/k3nzkhUPWYWbpJPzPbXNFUSE+DPEJMH8mo9i+ebu
         yp/JtfiblC0SvIHnii57YkqCHjLCIqr3MXf43KVKTrHVMApSyJBOjLnFKMcTE29aQAxL
         TcQFbL9EGmUiBaMv3j4AEwP25x2EHiDQy/TGK/nARvqTmlp1wqRRzzTqD54KYyxiadGz
         /CcYNQES+Sgom/bQCrzL5+8jXFu5Qk2Px3qFLX11063KKseCoK4JdGYm1QapDFb8Dzx/
         ND2g==
X-Gm-Message-State: ABuFfojOUOLC4QHIeTi16lTXNcB0SLOUCU49ndZuXvSGh29IkmZfBC6O
        ZlNQyp00PYObSRwY0S+WwPByKVKy
X-Google-Smtp-Source: ACcGV60R4/ldFPgl9p63T5QEVrxlZQeul/1QByO4ji1dQRJoQD9uNDJHGTLwfkwJ8ke8FxT+zRquAg==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr8053942wma.101.1538049910628;
        Thu, 27 Sep 2018 05:05:10 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id a105-v6sm5059909wrc.23.2018.09.27.05.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 05:05:09 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:05:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH] drm/panel: p079zca: unconditionally remove the panel on
 removal
Message-ID: <20180927120508.GE29102@ulmo>
References: <20180816140920.5009-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20180816140920.5009-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 04:09:20PM +0200, Heiko Stuebner wrote:
> There is no need to check innolux->base.dev when trying to remove
> the panel, as that variable is always set directly before the panel
> gets added and will still be available on panel_remove.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlusx3QACgkQ3SOs138+
s6F5PhAAwoel97tiVnr9N/5iUKjz2p0WAM7koaLokqfCcJQDDjl+l9LSZIWhv5FD
zdgSq4Dw0Jw5/bp+LR/pxrb0sDoPJymXe5KSDUIkOPoiAsvS53twT8BD4Qi6Cc13
5F6hBHJPDSHcRvin5CtxR9u+SUZN/sI8NBYkO91921bjdxTV7EYzt5vyyd4vCSpJ
qh0QCoORm8UJv0WossZeBsR69H1Hi/vug/GXqMSBBrCRATrHJM+CxanoErWwgR/3
OjvEzhnpveCXD84SaJ1+sL95dw4d5IdmmxfZLqOsT1l3dSuM1k2GKI4yEziRH2JV
bBt/rKqzTvKjNj961rdeESsyW1SyiSXxxUgwX+agCVaVwCujIF8yE2migxc2wVTa
9h4YOpoSpzv58/wA6zTUaIcZaCRqS2YB6RmHXM+54YHm7scXOsjR5jTLdschSs/X
uyIYeWqGvctBQ+AJ62GLBf42G493zWZqPoZWDwkUR+aWzONzMiKycOm3POGuAsnr
X0gNxGVapczvGleQX7ZrHFQnV3968hzwyA1UcdFbex1KHDRO5AiuR4CQWcF0e9w3
IJqPeHmoFSnW60usiJ5N5OUSzkegQoi/fY+q/din8ZiQ3Hmyb164cwrCRpJSIXLk
o/+YSVx45/YBi1uns84kkVQVDGUpAS8yIUjiGBOcyjFiqsrCS/Q=
=IaZF
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
