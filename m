Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2529ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789AE2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUyuzXT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789AE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeJYW7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:59:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53562 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbeJYW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:59:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id l26-v6so1763636wmh.3;
        Thu, 25 Oct 2018 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzfhMie4plhxVoVCmcQjRI8NCp3o3NdNbSuCglnRv8U=;
        b=EUyuzXT1Agks//nQxcuPh/qcyoLbnhWCcQ+lckrEm/QC0xlhLYb/pScxoxZZuJRWzc
         9MGTIyYD9Dw2jCNRT2CV8zjjt8XWomailiuc7tiKtuaLcd+aYWTP4JF580vB0p+cnpPh
         p0ePomeL180p/EjnrGhW8KOXsue8cL2YV8u1uaqiQqrYoo4jbQbJhsjU5JBO/YUdgPW/
         7Og8+YgSQTdyoAslQMbZc8HTyLGL8432qDIJTFGfpcIXvzt2dwlKwnzE2D3B0WGfgUMy
         5aBHpWO9c7KxkjUEU4dofkn0DywIQuhUU9ADNPA1xyUxILpB4TnF1kbrJ/00xikSPeLm
         EHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzfhMie4plhxVoVCmcQjRI8NCp3o3NdNbSuCglnRv8U=;
        b=Pr46Dgbwn/PyESNc0P4e5u1RLR60GvQTii595C7cb9sb2QfgFslYJhzlInyybmo/al
         YALIohE1Ldd4n1bVvxInyBrxHJlrad0hLijkVIb3qGcle1ejqEAPCgSbCwx1fcDh/y/U
         Lw1IFiOsvvTIIPMjhdjYqddPdWKiT0jt+PwvD9RU6gNTL5+FiHCl5QElD+4fn0qZIy+S
         1R072qeluew4KMyF6e1amxc7SN2njbcfIYZWYWkdpyOHSvKGg1rhbWX2aWks0hCVip0W
         zMt32jvg+j0Gn9h8HW8BbN29Vfo3YqXTV97JbShk8QCFfSBzmGYdA+AfAJSLOPLl+v+f
         sYxA==
X-Gm-Message-State: AGRZ1gIUKvc9rKF3zQhIMS8DCoGdGEwX91aZQ4z2UXMLWEc95k9X4NSj
        97g2uFBvfUneg4g0eJVKN0g=
X-Google-Smtp-Source: AJdET5dCYsCWHEKq2Q0rur0jQOeuo4+L09tutlZgPnVnXM7alqL4IF8PyhZzWEVGoky1a3+neBghgQ==
X-Received: by 2002:a1c:39c1:: with SMTP id g184-v6mr1715768wma.93.1540477561007;
        Thu, 25 Oct 2018 07:26:01 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id d16-v6sm5847539wrv.16.2018.10.25.07.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:26:00 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:25:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt: bindings: tegra20-emc: Document interrupt
 property
Message-ID: <20181025142559.GD21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:45PM +0300, Dmitry Osipenko wrote:
> EMC has a dedicated interrupt that is used to notify about completion of
> HW operations. Document the interrupt property.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-4.21/dt-bindings, thanks.

Thierry

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0ncACgkQ3SOs138+
s6GNKg//Z6X1BmQbDbtD5HPPAZ8oy/HUQd4ncma03Dig/W0/Z/uNubmsjnuc8THd
pO2rzpwgLTGIdLU8imY2d8vOUE7Hd5tgAbV03xW+x+mDZkwD6YRxqggO0PVYFmFw
36zwvI+apL0oSNc4HwM2uh3S5JbiyjlB+R6VGuHI1J7y6xq+9rAZV+u5NftZUOYi
SixGyeX+EiB49I9MBTkdKI6FVGW+a8a90nFgrRalQCsSvUAn/SwlEX7ePyXuOCTX
T0pEgcQJgprPaF1c1TpCvStTXajipiclkGTGwiG/iSdzMTlsC+EJd0OrxStSiFxA
6tPhz7cR+3bZY5OdWsh8tEsBvq8DiylrFo0nmAwaY4bmaDSMxPyNLolfk0EKgODk
2PqTNe+yp9ajUf2mRp6u/o3FHIGB9Md79wTkSUh1eZ9USJ2972j2oxUJcYej+4Mx
qd0+gDl9AKMuiZ5dFB5qf5erG2IyGZY1o3pzFAi04eLXlitmd830OtER5dR+6E84
jLl8Z+wXlQBykc9/3xEFWGUd+mj1LPQJ9XiVEe5gWCWdpI7q5YUkrjTbuag5Q9Wf
1P2dDQXpHk7251I+Oi1Z36xpXrx2jVbxgSdkNPXwT61cF+2X0DIDpo3iMKY/izfV
o6qxT36n0joi69wHtoo+baK1irGeJYTyuozYLsM03kGhhZt9jOA=
=7q05
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
