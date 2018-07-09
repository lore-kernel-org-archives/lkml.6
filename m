Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D765C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07B72084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7cUoh7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeGII6G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:58:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38948 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeGII6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:58:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so3965614wmb.4;
        Mon, 09 Jul 2018 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKWwlSrCJaBB4xw0npjL3HyFg3zH31wD9ghW3asGE08=;
        b=s7cUoh7V0rKSnzfELQ+tsQL8fj8CzqU7ch8H91byImYk71iXv+YxUAyuopDsgw0OsP
         9KdR1roITiZCkBAQVMRfORlwgjROKvO0yRukdkSsUeL8Lf3K0Y4dzIDTBVv/MCTwO4JW
         neUK2UT5Tjdif7BoFC09AevwtNyCTWWbBwG3vspRy9/xq+wivdopyd6jzZmRJpVJOhpI
         LSIGA5DSek8DXBKDJMhqQUISZyF5vqcNkgWWlB3bC4K6b885QKp/+u6hk/OJTlLWeb8d
         6aqWbCoTcwLcscqMpc5NIdDnJC2QgQnhbTg/A42MakA54ZQcKnxyKOIv+oYy//Ar3c8m
         FptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKWwlSrCJaBB4xw0npjL3HyFg3zH31wD9ghW3asGE08=;
        b=MESFNKMnbcQgUVfcjPM7+yJL7ugFmX9rhd1HIoRGBLuMNJZlx+yy8AyMPsaC7iKAWx
         QPd/yVSNyLHKM1eu4PypS/yT0/zHrVlw5YAmdgEbx0RN1Iut8pan78m1sZfpGccFK28X
         rvPPeVaTfxfe72Ak0lK/4VQO8Ek+Wzj/Oinap9sMMag+T0mOGKpcDlnnHqz+cpGzlwy8
         oTGcTNYtX9o//X3E4gCL0em0cuL1keBjZ07fjvhgzW4K53a25hqdERR2zhzuvutwtqsT
         yQok3Chqvgbgm+vEemjF7HLgjqL4N+dnpAbcBDdfyAekq1DcK0wVtbcOgTTw5q+dZKvD
         Vq6g==
X-Gm-Message-State: APt69E15DYRtNMxFI9T2j9w84ZiFVtCeYtSrw/5OO0UvdmH7r70Qr3kU
        4bRaLz8ymHWoIEzpSQ0HC7E=
X-Google-Smtp-Source: AAOMgpdnhcJO9kPWsXxwbVXrZYQotC4A9lRRW2fGMqQUhFSReYIzfGWRAUXevrSAVSJR6xzzq+aFZA==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr12500140wmg.102.1531126683252;
        Mon, 09 Jul 2018 01:58:03 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id a11-v6sm13230323wrp.39.2018.07.09.01.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 01:58:02 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:58:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: tegra30: Add Memory Client reset to VDE
Message-ID: <20180709085801.GC13963@ulmo>
References: <20180520134846.31046-1-digetx@gmail.com>
 <20180520134846.31046-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20180520134846.31046-3-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 04:48:46PM +0300, Dmitry Osipenko wrote:
> Hook up Memory Client reset of the Video Decoder to the decoders DT node.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDI5YACgkQ3SOs138+
s6G2JhAApdcg7IFWFMgqlbOLmpx2EiHprBIO5z2l0xJrC5l+f/h9apDygmRdO9h4
JK6REB7VXt62Ayjmm00n82XEwt9hwtnDxQngwDI9ILjdNYb/wU2IpvNEBEJVx2Zh
72+axVijaTvmZlhpx6V6BvRpHjd0RzsQhC1GiKJSBkszdaK4n6Es/bCtpZjPRFpo
Ptyay0KMjEf4yvuW1noxJHEZrIjdP4Zn5+TuLCEyVivpu/w8xAABAwqUMR3SMOts
JtEY5of4+ETl/ob/HsadvN3vjpxiKUUzkDjlysXcKhsQCBPqBtiEc48WHzngW8VX
TEOHotePbuEzmxmpEuy39btr+GzGNcX6eK2tJ23xm4hFaXU5pfP/ppUPM8ZY/gNj
H7BjGD3O/k0odkhigmL3p59tSafDbe/Ff3dOpqjx1FKOjzjIvEXBnfU/Osy0cbfp
SE0neBcWEv7RSoaptnz/Vd+VwM/e0JqKFTMlqFhTMW8yX4MPBo79Hi6A6EpgaCG1
uTDuIOTiKMGiTaitWziKJw7zQo8As915yJPadrKqpnW3Hgbka06bKa1aVmdKGMXn
VuTrhaEHhV4shLkbD4pV5PkWGlJwP65i9liubZ9RK27qv3q6NXxo3iFr7thxGiAs
koh+O+O9L1/3fzN4ccJbmp9Dngc+EqD+A40DY7tAAAXbfpmAsF0=
=h8rp
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
