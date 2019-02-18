Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C871C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU2w6ULS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfBROuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:50:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36560 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfBROuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:50:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so17425798wmj.1;
        Mon, 18 Feb 2019 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQsslOnvPYuYtKnaJFksNS6ZQC086JUnhBdKLqQWJWE=;
        b=aU2w6ULSSph7t6RqxALh8xD2jPh+OP+Cak6LtndpFy/jXh6ntqzRfZnlebjCKZhu85
         GzgYfU4gQvD1uGZlo8LwwzoCE5ME9ySkoXjTgzTX4zp6Mh9OoOvmmjep8+hnEn6A5Nyj
         F/betRT1DgGhMY7KdtgCpjUuREnpHjNtjuHyNYXrAXE4MOUqOY4ioR9fNzQFpk0lkWiV
         +8jIqJMhtzlAAykoU9OwqPLu2xVfOUkoyETLWiLQ8113omL2pL7k9DnrJeuXc6r8m4kb
         EfxQ6WMrIVNfUDXRDPvnANGl91XYkypQcF2bgXxDGZwicwXQfIkbVx3F0AgwDPKlS2cF
         85IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQsslOnvPYuYtKnaJFksNS6ZQC086JUnhBdKLqQWJWE=;
        b=tlBHQ2CyiLbHPuyeoxfrcAjxaWqFqFO1bSmwLTmAK8mk71QTLBsjEkfpTr/ZDyGNLT
         Uc9IvRnvovbfW4cUMx6PxU0n4H/h18Rs0YNZCTGmZciYiuK65OFPmmQKB7LSpg6PqOWu
         f0lVTLte1CI5XsNRvgFpN7JwgyZ0JyQRA1d5trL720cDgdlQHuV7rAgToKUuZyhrqJ7s
         ClqDGQmrSCuo1eUTypVMUagZMMw7wAuFxoxvxov8luqeBZ+QWfwIEAF2ro1l7MX5uWYm
         PRQ9sNT4oum/zUM3ztMfQNEg2o9PYIpHD1n3K5bfdIZn1P/ha0F9GaYTXCj6uqm0rLX2
         NVkA==
X-Gm-Message-State: AHQUAua+1tQWfrEyHy8QeGAt0FYVJkWPo2ngJul4LnO1bRDLB3r+IMME
        FtkjkRcxMHR8QL4zhA8lDWY=
X-Google-Smtp-Source: AHgI3IZvHfCmNqHCjo+HO9GoPbRBLa6BW+b0IJ4DsVF38ypfKcnWuP2a+8Sxo1GBGPD/VjiU3umOeA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr17028841wmh.87.1550501404085;
        Mon, 18 Feb 2019 06:50:04 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id v4sm5615033wmg.1.2019.02.18.06.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 06:50:03 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:50:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, talho@nvidia.com,
        wsa@the-dreams.de, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Message-ID: <20190218145002.GC19190@ulmo>
References: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
 <20190218084227.GB19363@ulmo>
 <42aa92c1-309e-88c1-1cd6-07592990730b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <42aa92c1-309e-88c1-1cd6-07592990730b@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 09:34:38AM +0000, Jon Hunter wrote:
>=20
> On 18/02/2019 08:42, Thierry Reding wrote:
> > On Sat, Feb 16, 2019 at 08:33:07AM -0800, Sowjanya Komatineni wrote:
> >> Tegra186 does not support multi-master mode and also there is no
> >> master fifo control register.
> >>
> >> This patch fixes supported features of Tegra186 and prevents
> >> crashing during boot as master fifo control register are not
> >> present on Tegra186 and prior.
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > We really should've caught this earlier. Jon, let's think about ways to
> > make it easier to catch these things in the future on our test system.
>=20
> Indeed. This has fixed the boot regression I was seeing over the weekend
> on -next for Tegra186. However, I am bit confused here, because when I
> look at the Tegra186 TRM it states that the I2C supports multi-master
> mode which disagrees with this patch. Furthermore, it seems odd that
> Tegra210 and Tegra194 would support multi-master mode but Tegra186 does
> not. So is this really correct?

I would expect at least the missing master FIFO registers to cause a
crash on Tegra186. The internal architecture specification also says
that multi-master is supported.

Sowjanya: do you have other documents that suggest we don't support
multi-master on Tegra186 specifically? Or is this to work around an
issue specific to Tegra186?

As it is this contradicts documentation, so we need to either fix the
commit to remove only master FIFO support or we need to fix the docs
to reflect reality.

Thierry

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqxhoACgkQ3SOs138+
s6GgIBAAmL08dlZUzeNGEZh/8lLWo+k9vYokFLfALfaeRu+SU35zzCpLBCO54w95
mLOBVtInTEC5dQ3ouIXuY+Aj0MfEp/n20KON6nGhrlLXnIq4Pp1Is3a2VMSlPiBp
VpaZOzC9LTbt6VNiMq8Rw7JS9zJdsp5xwGAh6RALMfJzpAAF5d7s3MGGa0y6NFiV
BL/QZ1stiDQJl+MmhyPKVIycdLUMJAEV7YtWpVN1Cp/qOVYK0JHGjuTDnenu7cSY
wwNdahj7vfLA/+HpjxhYXlthetroi7e/JXEX9jJvGU5CqwLIzlb2pZFVVb3pnFgu
BhTvP97ThiSpt1bwGD+caZwubYZBMHR8r4oLSHuR/kTNoElY3kG0ibzUCg0Etqxq
2elPtIKUhFs77i9MVfn0R7SxnUn+fndAzHn9gbcJJCBqg1eee17Xq/EQ0eDYCnh2
gfcFSnbcCRtWsIjcUMGiynRwZM2Ay8V4V+wocq9lxG166TmjVOdk0YOJn9MPHfw+
kkDCsLWga7uQy1EfWGUgo8yprWQ07NwY40vXIji+r9gs8Y91i5lQwcrZOpiKfC0I
uds648e74TsQgzSfIqSuFr7HmNnPj8GMLzdxXRnoVn/Mw0Zm0c0ewrIcJefTAfCw
eoRqyd9tq821Aphub7/hick+lbFHAX5xb5gYOoC4mgSG3buk1RY=
=zXzK
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
