Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B70CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFAD21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8nGXcPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAJK7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:59:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37521 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfAJK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:59:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so10872402wrt.4;
        Thu, 10 Jan 2019 02:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkFHrDB7ko6GNMm6+n5eL0iXcWN/TvB/pYX1B4tt6nw=;
        b=T8nGXcPYhFEc0hO+BYEZCLpE0OJuMFYZ++/N6OIBhKPxU6RvTIWayPJnW4qrmmPArK
         fBIXoakCNDBdEWv328a7EY1aW/5huJV8Rkinx9QNS7pS11QoT64Xln2BwcFDHH9LqAgA
         D2+a4mJDfdnoF11TJfKg0DdNU9zEM2mXbZmvSi47rj7NB1OGcbkPftqVXqXfIXD3txNS
         yYeQTrRF7sw6RHycNzDaJcQwTN6tuC+ca96MqVcZ2TPxfAbuKugFmZvjWKu1ibccqyNT
         f4D+wocLBKJQSpyOvkTDpnlb50sZ6qRV0mPUy8Lyp2Od6B3V9mUkNZH2rhUsS5tcUpEG
         okrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkFHrDB7ko6GNMm6+n5eL0iXcWN/TvB/pYX1B4tt6nw=;
        b=O8CJUkpQXhsTAsEq5n0D7qChiS4Z4qIEUhmlJ192Ab/jPXB2EqgiUZWhoDNRyYBBCz
         1tYKg0Oxdv/THvs5hDk3my978GldE20UgYE8V9RlBKRXk88gqeYUEpFMv8pjHmecn8qa
         JtlxeVGI2ZJ3trEbt6dPGfolXXZh11t9BCisahuzKgoMzOpNh6yhOH+BAMC4xssvvBep
         ppa9hI44C1QnnYsehVaKaxiPalnWqMTYURva8E223k+HuDTVfZD8Ed3r9QDLenfbwyNV
         BJxfbfpfr9uMHLqy8N7PwGoqwdgkUnlpA5hl+o0VpAAW6K5nWsUwU/xr4nlrOJ7PVvzX
         I4oQ==
X-Gm-Message-State: AJcUukcuP+4UhhQb43tDy/MenB/FSyGlOwudvZ/caQwb2gHcIgNZE2Vm
        TBmzcwTYYDj1F4NnrcNz/TQ=
X-Google-Smtp-Source: ALg8bN74FtWiCblq3U7Y6Xx77Du7xcRGv6sRZw9HWRHyEGofLmfdEoqUsER/rk4WgAFAAyxjwcbY6g==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr9015671wrn.171.1547117953587;
        Thu, 10 Jan 2019 02:59:13 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c12sm60983697wrs.82.2019.01.10.02.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 02:59:12 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:59:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Message-ID: <20190110105911.GA32301@ulmo>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <20190104174354.GA18110@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20190104174354.GA18110@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 09:43:54AM -0800, Christoph Hellwig wrote:
> > +	u64 dma_mask =3D dma_get_mask(dev);
>=20
> This is not a driver API.  I think what you want is
> dma_get_required_mask to query the mask.  But in that case
> you still need to always actually set a mask in the driver as well.

That's slightly different from what I want to do here. The purpose of
this part of the patch is that when the SDHCI hardware supports only 32
bits of address space, then we want to prevent 64-bit addressing mode
=66rom being used because it isn't useful.

So what we do want to check here is the DMA mask configured by the
driver (or the default set by the bus, or wherever it came from).
dma_get_required_mask() returns the DMA mask required to address all of
system memory. That would perhaps be a useful additional check, but it's
orthogonal to what I'm trying to do here.

Is there something else appropriate that I could use to query the DMA
mask set for a device?

Thierry

> Something like this patch:
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a22e11a65658..36c61778d8f3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3500,6 +3500,13 @@ static int sdhci_set_dma_mask(struct sdhci_host *h=
ost)
>  	struct device *dev =3D mmc_dev(mmc);
>  	int ret =3D -EINVAL;
> =20
> +	/*
> +	 * Systems that can't address more than 32-bits do not need to use
> +	 * 64-bit addressing mode, even if the device supports it.
> +	 */
> +	if (dma_get_required_mask(dev) <=3D DMA_BIT_MASK(32))
> +		host->flags &=3D ~SDHCI_USE_64_BIT_DMA;
> +
>  	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
>  		host->flags &=3D ~SDHCI_USE_64_BIT_DMA;
> =20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3JXwACgkQ3SOs138+
s6EFTw/7BZu4QJfWJPApvi5Sv44HQ9OKjmlUaxHefd33MQZnD9x9lUwC3GCxO35t
gY9IwrqQvX1EPZRwoOHJoW/ZA45t+l+j/JyUuHcYZ+wksJLpWoBCZH72otrX/Krb
p6GEHVCO91AqM171Wjr9YOjPDvNyv6QQ3ouFX6Rob0vrv76eOC/dHSjwC88LXn0y
qqwMptpBePH/LZtzwdMXGB9CcmPIydnXv5HP4TsKA+SpJJzDYgPRmKY5hQSZjkz0
Jci2Ts6Ujvw6EeKes7Zu/UIDeM9xJnyg8H6tYZeTxyWfMesqQr+fbIBhy1T/MvG7
MCp05Nae6erPqm4NDYTauQd34fchCMjKHHNxzh/Jj4m6MZwuNkTR5xWCkGql3ZzI
wBFNO6/HM73fpkZWfFTsIhZ5JGgsQL5zs/vE/B6KKg+U1PAaa7p9xAhADhfWNCSi
RuBj08ikw2lWji5GSBJPy7xMWDk7/5/Ygfy8gutuU6m8PvONFWMb91CNZB3f6SeQ
B4wxSrHQm5y5EbXhnoixZgZsL2NC9BVEYsXuXcJB1BAF5KXDBJ62B2a4AfYZwoZ8
qnKUDHCmq34SUcXYJuqmUrgAtBrAX8ZAw/y2RSxel5z/rfUOdStJkIuXIuv3dD8I
Lc+k5BHCxceozRPyDIJnXS3dbbTrkrMTODeuwdcGfXyQaySh04k=
=4WZZ
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
