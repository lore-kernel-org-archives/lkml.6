Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7BC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733A72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSXjHuAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733A72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeJLASx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:18:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39092 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbeJLASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:18:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so10129736wmd.4;
        Thu, 11 Oct 2018 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGyLL0bNkt21xk40oP0nNM0OS99fiPfq92n6fl+iA8Q=;
        b=MSXjHuAjmKyP5jzD73BkseEDmTMF0eF04kEoiMhr5P6V59lw3nIBg/4/MR42RcNHk7
         v/vgSeym7GXY/zfqsrxsb+omUi9JOgTYlnSsCXAxoaJTiTcCsies7NZZulHAnwf3VqzP
         pdjXjAOgjJqcLXwO31c/UhrzgfehGIRGUqgK3OEp1l5h8sxtpZUZK4NaAEeYcpzhZafN
         lVNgmwc8zTLofZLrvDDykR1P5vln2dMUPMtNQKhnBRRovpQbc1oPXpWosCU7RPfMLVyp
         Gmv83QKuQG/rp2UcsTl4tYLhJf/9+IJ403Ed0awfyhPY0Ko/a2jUnPveTn0G52drpE92
         +Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGyLL0bNkt21xk40oP0nNM0OS99fiPfq92n6fl+iA8Q=;
        b=TG1hzGuTPugwzcZKixjqNVS7TU/I1lOLPyD+MsbyYs2FHXZjcxKcv+rFyf9oC0+mCK
         q1EJ9syAA+wdc4QBwk2YC1RXzeoaVGPy84espSMD73D30uSLIdfuPH7zwWH3RjKIATo4
         qcOEcVy7dkRLoX4RPwGznQFe58KyETo7PSbOvYlUsmHNJJgy8WcEj6q+r223nbGpcUwc
         iAKOiZDpwVEgepo8jmey52uznISEIngxjZE6vO/5HVITpkQtwF6+EJhHnc0nTxpvKx38
         0aaJ2QXhjoVEVofx91EWAfqRsTBnM81JZ78VWEz8ugmjFGMnkTxHdTpIVIgSOWa7lbH9
         RwrQ==
X-Gm-Message-State: ABuFfoiOYf0uVKLXKA3aV068lIbK2YTrJuYiqnSV2LuDholocieHy2Hj
        omrN9GkzL6pDWwNaIU1euq0=
X-Google-Smtp-Source: ACcGV60/lGC4egm20smsILprLxh2gnhS0yAjg+BK/gWAg4pCqEQqtRuIP1x/Vs59eNSoCZcABQ48rw==
X-Received: by 2002:a1c:9c84:: with SMTP id f126-v6mr2325404wme.8.1539276648937;
        Thu, 11 Oct 2018 09:50:48 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id t198-v6sm16154168wmd.9.2018.10.11.09.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:50:48 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:50:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 4/5] soc/tegra: pmc: Don't power-up XUSB power-domains
Message-ID: <20181011165047.GD7393@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-5-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <1538143910-24400-5-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:11:49PM +0100, Jon Hunter wrote:
> Now that the Tegra xHCI driver manages the XUSB power-domains itself,
> remove the code to power-up the power-domains used by the xHCI device
> from the PMC driver on boot.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 16 ----------------
>  1 file changed, 16 deletions(-)

In case somebody wants to pick this up along with the earlier patches:

Acked-by: Thierry Reding <treding@nvidia.com>

If not, I'll pick this up into the Tegra tree after patches 1-3 have
been merged.

Thierry

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/f2cACgkQ3SOs138+
s6Eh0BAAqM6Pa4vYLJq0XAt3XNAIbuE2qQ/S7MI8bkzjlmHeql5oGCVJo2TiDpdG
O8vOwggmJ3K0XxYP6LtQq9rLtigC8e1QEQiYLRYygTVElYl+VyE6c4qyu2ZwStdJ
dcgO5kCh3ouG8oJOdUNMWowSNUenw/cLdAGxAMqHEjnRRE2GbVh1Wnxc/ZrkfXDt
ZkEDjoHTMWpD+/Px0gd14F/viPjYbyQnBneAzm70fYCHAhwM/Q+UCQLU0wd0EPj4
aYs1Mp00Gx10yoI/x97BJQkuTPg+Q3xaUtWz/MlO/E3XYiA54fEiacPiM/IhL21a
w7UXSdkgucoifEXB8gfLh1IXdKmMDiHqESWpBxhYi9GuEZRs4QY15JynonaQDlG9
Lb1hqJnxJBQ+1wocWsSs0SuhMoxlCH3MkeTIYeqC08a9ayb8DPap6QyAM/9W8wZg
TT7m6PvDACz0O+ef52xnd29CLyKPtBF8YDSUR0c4Ymzfi9Uow/wpAkveprWoq/OB
HX8rnGw1ncXcp9WIwlkEZMUB/4TNksDu8tE4W0yx8y09tZVRFI4Qkfz7NtkaqS1w
Bgl3DLfoEoDcjB9qdnfNYQJ3JaHirqCMNhfnB7BT0KnMbLzNIqeVpSgM9LrW+thn
0Y9GiKC7wYLhTGPiCZ7sD1dFSguoYQzeqd97kMo66jPvjRw4N6g=
=woEy
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
