Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7865C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612FE20685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnWY/pXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612FE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeIXRmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36686 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeIXRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id y13-v6so4924134wmi.1;
        Mon, 24 Sep 2018 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQ/QzjzFzSMZNE6aJZyFsghprOLrg8tNEGyI25SZ2DI=;
        b=FnWY/pXEElMDlOkU2a6ngy/AQsRaoAxsm43vN7iUkmJtIrQ0AXROw/5QghebKkY3Lz
         wn/pFrsElDqWbOYoK6XG7Fg2YO49Qh+WGYcdF0wmzcubW58jMRu+TTo8kZO4UJcNB2+K
         P0UVKPWGu7i38+1kgcbgifCE7IUiMdujmzaSagD/SXCCseklpDiX7V3G6MaQ4/mC0oZZ
         lCnXwiUpH5sdNtvdt8E/2R9BELBGBwRJldpHfR455oK29XRZNswOBjE6jAI/ZsiEmdXu
         AAGM5bNAZVZBCkWdCpmKiL2lGK/A91wKP8o5K2VxHSgF4a8RgWwuehukKdXnFvsw1kfW
         23lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQ/QzjzFzSMZNE6aJZyFsghprOLrg8tNEGyI25SZ2DI=;
        b=OWj+URFmHz6Qhwm5ObVOlwH4cF4TYkBQ/nE16cPy1xadmzmOn6Ajtdmp3PGkmMdY7V
         gvrf+SyUmQlZe69hmbOPMqQ15sJlBNlGOtpN/a9fOh8QAHi4TizkOP8H1xYaoLLx/ane
         cXaZ+0yshQcMFeh9t+R0PTyeHNJYvKwKkcJElTQ8Y7x/pVzz2FmPtxjulyXsa1cEb9E/
         Whhuw1GX4tbH/73xI/+JudgNv/g6o/o8imhYUr2f2EGU8AT+KQ1BFtujXfqs2Ob/sK0B
         L+VWaH97QXnxGQ/isUO2RcdM1ceomJnxjfMiUN1iWW35xlQV3XXU8bVX3GvN2zz8B7EL
         CL2g==
X-Gm-Message-State: ABuFfohBJZ8Zys5f/NRF/WqcHx1sp3PC6Ivee9D+9A9piDRQ3zFqbWu4
        a1/i2tSlUQrhM0mvLAv+e/I=
X-Google-Smtp-Source: ACcGV60uFTYz9MCIixA8p/Atgoaztb1UpBI4J3DjUx/7uPtpXVooWJ3fgjAVim292ZEHOuZRyVGNIA==
X-Received: by 2002:a1c:4e16:: with SMTP id g22-v6mr6556741wmh.111.1537789239253;
        Mon, 24 Sep 2018 04:40:39 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id c8-v6sm9660887wrn.43.2018.09.24.04.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 04:40:38 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:40:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     ryang <decatf@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: Return the exact clock rate from
 clk_round_rate
Message-ID: <20180924114037.GT21032@ulmo>
References: <20180921220149.17136-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bn6XL8m8Y51x7rzV"
Content-Disposition: inline
In-Reply-To: <20180921220149.17136-1-decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bn6XL8m8Y51x7rzV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 06:01:49PM -0400, ryang wrote:
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
>=20
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

With Peter's comment addressed:

Acked-by: Thierry Reding <treding@nvidia.com>

--bn6XL8m8Y51x7rzV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluozTUACgkQ3SOs138+
s6FelhAAvGzqVXT5LttZWdkwXLxdR4HGb90RkeYQLaA8/CAl+SaBOCatNzcT3Lir
pdceI62Jl9PjVK5WiPCXcm3BuIWCNmXBDuiaHZ9qi4Zv7USl7Jc2/7Pq/Mtr/CJW
plmhdu65Elad217ExedOptrsO8rRTEuh+mJKY4kBmN7MxovhPSt8jQCXZeMhMa1U
2FJKM66nZIxR0Eq40BH16WOovqXkbT2+mQZNiZyssyCh5VrqKhru5Qw4tG6p6sUi
VCiFt9RbT/OCXFlBatu8i19J+EPvT3mgyjXjpz1O40kWO0oQFAL7QUmLUQhqoybS
XQ5lq7+UiOeLRq90+FldMZsAAylMwzg6dxFLDd+zGjcYJYMIYWBvUPUZxcG708mz
/RefvWtwk1r4GokkfwZfZqDzd/71Cxs3WJp/hMcbxzIYDw+9nK54YgNxvVU2CDdK
QONWALQwQBUutxH0R1lTH10u8yBUg1OAMyq9K8f/XQx2Z9Elcz69Dwml5s9Ot/wI
K1Cu2r3cn6kZD3rKiphNQxEdPX3jER8OoB8FnCj1D7/YOmdyOlxX/GI0YS4oS8UB
xhlxJhK6Q6dbGpiYyJk6o2KJ+r/BmHhUy6fgCHPg2pJ/nXYmwXy/Dd0UVmuGCrLo
8ZXxbSkAN8RbjTNOd7X+zeXINLP/osPv8+ev5teCgUZNslFh4cM=
=xTtX
-----END PGP SIGNATURE-----

--bn6XL8m8Y51x7rzV--
