Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FEC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360722098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnbVXr/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360722098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeJLAQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:16:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39808 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeJLAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:16:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so10470280wrb.6;
        Thu, 11 Oct 2018 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIM4LNgjQwAi/AfPu6yUH44DIRIXPBeyKwY35wXhYiw=;
        b=EnbVXr/jYjnN59dRgFX6y3jIBXXr0F4hAfzUtVi9Y4aPiiZpOMw5BLWWyn5SuKhkB4
         cBiPdBaYXUwXYl3IosoZuEiERU9mhdP4McfaY1+V1yHcMhHSAZodfHDEOOd4ZB0fwZdk
         NK86blVo0HZQxe3kvff6snpdNEf0lIlCbZjl1265I9SfWEo0Q2Nwt7areapXTANAXnZY
         0HOsCYl4q7MwXk/spLDtBzesj3GKwJ+NIJrvhwGNEZFS9JxYxVZUMN7Q0UB/sIvS8r5k
         4kbzoyICdWxPiQP8razlg06nhmZWuNiH+QZqUOFebDbg2yss21i98CyPjzsIlyZ1PU7q
         Si9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIM4LNgjQwAi/AfPu6yUH44DIRIXPBeyKwY35wXhYiw=;
        b=tYTDTKYm4OymBKPlXIN9TE6cHNXYXiVevJJcyQq5Ss4vilCp1WrRq9rfYqTWOgMobC
         kemn4pMlz9TYeWBoruU+gJVPy15aX/qAQjChcCmGSXBsbbCx80oiD/xJvzSF2tFczAl3
         GWbHXq4SHLz6FcMYyVhcXuxRSgMpXeS/D363q0k+OxnnUVNNnvTGOYnZX0l8dmrLtIQ8
         ZgIFnAggcYsGnxw+ePkcYU1rbwWYqWveqAwx1p0t3Uplqp1jRLSfvB8y1viK8rX/la5h
         ukFV9cnnTCjclo2Mcs17NE5EBX5edsCfkhZtpX01m+3ItZyr9ZwYKFxj6vwVd8p0tmRl
         94zg==
X-Gm-Message-State: ABuFfogkuTyat3DgohXg3IDd18p6MEdoUoPCQAj7U5N5E2a4OqHOK00E
        8wcqBvTORhKg/aNzxrkeFaw=
X-Google-Smtp-Source: ACcGV63FjPObCHnpgInatPHO9kPW0gEIxYZo1AusfLKZdQSMSz0aEJrIYjKQ9vhHOCyjtqAxgbXpMw==
X-Received: by 2002:adf:c650:: with SMTP id u16-v6mr2512108wrg.177.1539276495475;
        Thu, 11 Oct 2018 09:48:15 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id 195-v6sm26852412wmx.21.2018.10.11.09.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:48:14 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:48:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/5] usb: xhci: tegra: Power-off power-domains on
 removal
Message-ID: <20181011164813.GB7393@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-3-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <1538143910-24400-3-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:11:47PM +0100, Jon Hunter wrote:
> Currently the XUSB power domains used by the Tegra xHCI controller are
> never powered off on the removal of the driver, however, they will be
> powered off on probe failure. Update the removal code to be consistent
> with the probe failure path to power off the XUSB power domains.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/fs0ACgkQ3SOs138+
s6GZUQ/+KDGn/hFdXNf9aYDgzhZo1boSLCGofzxZG03yjmBFkob3fdymrz6eHX2F
4zSkGa8+3hBKD+TlTiLFuDXI5zFxeZL/IoHX4maTl8ULdqWB+uiFUiQClbjIZCTp
UqiS5qHUUzchDHppCJB05cW7PNRZwUY0vQgTroa52KPCmJhhrdVgYXYPL2SpY+PR
PBs8agBSyTrR4JlUhvognAzPOXr99YkiaOUvpV9h114ayjwlMBZE9oGmoIIaWZ/T
v8udw8RCd3m0tkRyEvj7ZnfSmVlXU+ncl2X+J645sV8pKyb7dmc//fE913FKB7V9
NxrEJmR1DkUxkZBfwuOi+q3QqFez+8/hB/R4O2cCB5a1+4WEW5nANgdVN+iQcrWs
UBAnRPOp/ET+OsKAXIDdzoMYyoJBU07LV8HoIcIA4l5hkeaaeGk2dwMz/2/nkQM2
LP3Z3uk5eGfqFYjJ8rtF2S8q0LT7qC4noZD75lia8UHNnW6X2CJng1Z3Mw2PtP5a
OQIDmuY62qNa9BwiOR0s7ruP7lvkzbB8aSNfP5v553stk4F38b0of5Vu3iAdUbbi
E3UOd6hwPtZ0SKCFRbMGhypQb5bYZYOQFhHHdzpfcoAGXkZjb0Sx0MNOB5qWg9Wq
JZ1mxlAl/60fbHliyGF1ShoWRy1fq6IDyk/kD59chlLN7IvWZ7c=
=9Irg
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
