Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB45120645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyXyLfPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeJLR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:59:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeJLR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:59:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so12450561wmc.5;
        Fri, 12 Oct 2018 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttTlV6ltzqp/ItwZaEd/kNiaCQitg4bA9wLc4+NMWUU=;
        b=RyXyLfPiny2eLUgk+s8lJ8nCBd6SO0GYBORoFBeQX9ZdMvT33nCUemX6oKMUdG7Y99
         7VTGxDrMI92d6QrgigULaRbo8i9Wz9BGPYUehmWD+8lIRgswiGJIUa30aEzHZ0LwasfE
         4RZKZ7HxF+T2GO9iKOOn5O1oZpM9/5BVeKUuRFHdoJCjjV3HHAB2BdPs/CH6P4vI9KZi
         nedyqXej4gYRVvrDbftof4Ssn8O0O+Eb9YUCoUXyITVvItxp3OvsfWTQ7Ut+LG/HBqnx
         mH9gAWZEO6AHj2eKmcxpcNgorH8f0erCeSTMj1pIQvUJFnEkm59rG+f6B6t/6FEFF0Vo
         7aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttTlV6ltzqp/ItwZaEd/kNiaCQitg4bA9wLc4+NMWUU=;
        b=I8Iu1L1Dz+QaJJ5nNuusKcWXmpnfIu/r9LmN1rfBaTW7laPj5TmOBJeq6lAzM7LnrN
         Tt+RiiC0avz+g1zFWLxY13aExeg4reXaNucDe8hPeVh2Z5LIIFIEQ4+6ePbZbHns5I02
         GrW3j+9tZITmr9YwSkewSwTuHonohqbb/Y83JW85+gvLxbgYCrmPL8JofJkeL0M2hZWW
         VCnPyPaquSKdXmpcIOR/Dwi68jA5yd8cO6JkpyDa6oZNXxCBPpSwc7xgOM7ynNVVXUBb
         x3757sQivFafHBJFVMCquKL3uv9P+AQJ42UlHY1sRO0dUu74tmHYWcunlIQqNew6VbWR
         nm2g==
X-Gm-Message-State: ABuFfohOBHsmmbC0zHRHulfhMYxv2ppNA/2bdR4H+IyRsSUoGtFsbImn
        rdJRgXG3xpH+Dd3Vlj9XZg4=
X-Google-Smtp-Source: ACcGV62Uli5TiN8NWfxTIKcj86Q7W6KYuiuNqSPjymkqoNofnmMyWxoG0/YpKC9ebpk+SrNuD0gzLQ==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr4625642wms.21.1539340054366;
        Fri, 12 Oct 2018 03:27:34 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id b81-v6sm898783wmh.47.2018.10.12.03.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:27:33 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:27:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/5] usb: xhci: tegra: Add genpd support
Message-ID: <20181012102732.GD9162@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
 <20181011164753.GA7393@ulmo>
 <248afd79-1a7d-7342-5939-6fa998d04d5b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <248afd79-1a7d-7342-5939-6fa998d04d5b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 09:41:35AM +0100, Jon Hunter wrote:
>=20
> On 11/10/18 17:47, Thierry Reding wrote:
> > On Fri, Sep 28, 2018 at 03:11:48PM +0100, Jon Hunter wrote:
> >> The generic power-domain framework has been updated to allow devices
> >> that require more than one power-domain to create a new device for
> >> each power-domain required and then link these new power-domain
> >> devices to the consumer device.
> >>
> >> Update the Tegra xHCI driver to use the new APIs provided by the
> >> generic power-domain framework so we can use the generic power-domain
> >> framework for managing the xHCI controllers power-domains. Please
> >> note that to maintain backward compatibility with older device-tree
> >> blobs these new generic power-domain APIs are only used if the
> >> 'power-domains' property is present and otherwise we fall back to
> >> using the legacy Tegra APIs for managing the power-domains.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >>  drivers/usb/host/xhci-tegra.c | 89 ++++++++++++++++++++++++++++++++++=
+++------
> >>  1 file changed, 77 insertions(+), 12 deletions(-)
> >=20
> > It'd be nice if we could eventually get rid of the legacy Tegra APIs,
> > but that's a separate issue, and this patch looks fine as-is:
>=20
> Unfortunately, I don't think it is possible as it will break DT backward
> compatibility. However, one way to do it would be to force on all power
> domains on boot if PM is not supported.

Yeah, that sounds like a good option. If we don't support PM the I
imagine there's little use in keeping some of the partitions disabled.
But let's investigate that at a later time.

Thierry

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAdxEACgkQ3SOs138+
s6HEeQ/8DVIf2eg1G5hJC72lJiV/i9fJdcLKgaiS8Q9mFu44m1Ut0QETHgeNfyV9
yg1sfy5+FB+4PTNoaHZb3X2sWVvXXxjsgi+56tu4P1Hji4S1yeuJ9KAc3Bgn9bth
4RDwwBGdKiI6gZmkJnI4AM+m7Scb3rmb64TH6uwaET/hl/V1cKT7hnzYSk86Ku+X
syjjSFMAlTNkZrcLFVgobrIV67HGre8CKaP4AtAITM+OzcWSggBpragg09gRVfSm
D/sLVkoCVtlFTgpE0LUYKltYAn+hEig8Rk82i/IUiEuG3L5tpM7+nsYOmtIKhAR8
ApSFvk2PIIsGpOwCom4s/lIK/ONR/j8lauaMLQrWF96jQ4WCzRpZwxV+U80L/8YN
JMG3y3800jpORx/IAp0lfDIznT1KcClfGMQu1zA//DoBnxo4ek8m0He3H0E4Jr6l
WwjJXYpvbswHEosxWUp3NYJEedVoqzU+IXLyOA7O9OVFXFgcIX/RQbItZ+RcEr/S
WW56sNVzbWuO54M3F35hAVP0Ue56hFxEfvPT/MBvT0x/YrdJOt7tTmD9ndYksg79
5I3Cy7SwDeoX+incSMXifhJqUmalsxF/gB5Rb91bXfcB7igZzjS8imvKyeH3tT44
XTS+Erd2PeU8QDWL9h9iLVv+RDXwXXQeSActlHKzbKiAGubeSWw=
=hVM5
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
