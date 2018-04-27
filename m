Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2841-1524823988-2-3358596642548053387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524823987; b=htEc8ZlLa8XNJ2Z4hlEmwq25fYfyw69NJCk6ju2Zu0Xcc7amS8
    lXSDFS574h0oeP0H23+tTzo7yAI4OupPg7ux/rXX3Zq3fzGvXrTmEKgJjwB0MiYt
    yC0VKrpGQjMSB/pItKk8rQNxYACCiq5xzbnvUt5hWwJH7KHR64Pa6Ks1Yb6x8Nxl
    zmV3wnVrgQSDbrjMEBoLzLA873lVPyZC08OILlTRok+tkT84b491EC3Qdhu8Mx7G
    dBX7NFuG3LtJhmkn5k9tPaLOt0id/jZ/SJmBsmtT4RwFZoXP1tpgrzj4iPmwryki
    MKVhjetR1n906cRDil6/S8oaEB8gOcg3mCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524823987; bh=UL8W+uRhAT4P+CJgwX5kVXJk3PxxGd
    txNe6QJ/gFouE=; b=VEH+ripgDUuXjt2uHXT8sZIVJ6KZdtm0suXq/No/8xeZae
    nfeqi01Vm00D1eOyyUYDHgAGu7IWfAt/i9idEBo1H+kNE+f0PJ3PSIWCO6bq/ri5
    7dFN5HoT5jbyzSIgMJXUq+1hHST1ijCVjH7A2jtMS0ERxjp16ofzIn01fv8eP5BH
    eOBYfGYadC4lhrXm+jxgSzOUA7OMY0A5Bo8IiKWBsqWX58Mc6AjF/axsav5816rC
    G+xxmnWkPCy9J6PFy+HsNhdV28y9aQc5emZfD1e/1hcvcsaXIDF+MNr3PbGOyoIs
    2LTKAgQGWaf3uv4EKSrpmKULlP/d1aP97vlVhnRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UcAS1Gsw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UmLXbv3v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UcAS1Gsw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UmLXbv3v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFFD/Ds/h7gtbGXcx5/1Fmm7LZc/eJHaz8ytKEmc1CiEgzDcRPSEMJ4ahz1FsxIQrVBgHDFmlCAPcjxz5Iq8pGRjSAof+d20xZ2q/3QmZL2wsQ6uiVCm
    5OrdFVWmixvIX4aNfD+oO7y9O7HwMqrDWhYE5qhtuEFoXMDfefOE1ouIXeu/aHvYCG2R4Piqnuca2X/aroHXa9Xr7OiLlX6CW30w7eDX58jDqqtm2D8njXAZ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=I5jJpb0z_YgA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8 a=O3zUBSFPrhfFXGdUEpQA:9
    a=CjuIK1q_8ugA:10 a=kj7UzZg6WLXOMwqwFQgA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeD0KNE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 06:13:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34160 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757645AbeD0KND (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 06:13:03 -0400
X-Google-Smtp-Source: AB8JxZowjHm/ZrDSBFMeN1zXVC6N2x0GNY0xbmM5Pt8SzZ538pWkixWvJ6bkiMuyq3jdVG9G6kj1UA==
Date: Fri, 27 Apr 2018 12:13:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] usb: xhci: tegra: Add support for managing
 powergates
Message-ID: <20180427101300.GR30388@ulmo>
References: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
 <1524754750-3633-3-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kuk/n493crKO4rgR"
Content-Disposition: inline
In-Reply-To: <1524754750-3633-3-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Kuk/n493crKO4rgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:59:10PM +0100, Jon Hunter wrote:
> The Tegra XHCI controller requires that the XUSBA (for superspeed) and
> XUSBC (for host) power-domains are enabled. Commit 8df127456f29
> ("soc/tegra: pmc: Enable XUSB partitions on boot") was added to force
> on these power-domains if the XHCI driver is enabled while proper
> power-domain support is added, to ensure the device did not hang on
> boot. However, rather than forcing on these power-domains in the PMC
> driver we can use the legacy Tegra powergate APIs to turn on these
> power-domains during the probe of the Tegra XHCI driver.
>=20
> In the near future we plan to move the Tegra XHCI driver to use the
> generic PM domain framework for power-domains and so to prepare for
> this only use the legacy Tegra powergate API if there is not PM
> domain associated with device (ie. dev.pm_domain is NULL). Please
> note that in the future the superspeed and host resets will be handled
> by the generic PM domain provider and so these are only these are only
> needed in the case where there is no generic PM domain.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Changes since V1:
> - None
>=20
>  drivers/usb/host/xhci-tegra.c | 68 +++++++++++++++++++++++++++++++------=
------
>  1 file changed, 49 insertions(+), 19 deletions(-)

Seems fine to me:

Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--Kuk/n493crKO4rgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri96sACgkQ3SOs138+
s6HZhw//egJEzwCSLViIX7vjQ8k/H9ZEACSjHStMmwnvl6iemM0c6UwIX9Zwpbc+
d3yKlTj1CLBgNus9hVGH2OoXCK1ve+XMisUKvQUAXxOCONqWXQ5RI20aWleQJx6g
rpwX3R/GFfRuNvSEUoQmWHUMZw6HcJGMMU5JvwqimWqlDStEn8APzxpBx/5x51Rt
XgmDgArgb248qotsu4sYz0dEeoQkKdvId4TL/SR9JV4c4XrxPmaglDh+eJo+sFFm
CG34Ro9rcHdzLu1rhYnnZuKxN9cR4A1vxWnrB/ETCBlIZpQ/zSQeqN/1lutm1B1r
np/zUcpZtxNyU1BU01/XUdnrgm5tonFQoO/UpFk4JAJ0eqmwhS6gL6e2vtJ0j2+/
GEoA+mllur7IBnsTsY16PGu5cfm+JQe+XCsU4pcqemF1594KlDiRxLXeqH3W/U+6
6Av+VXp0xQhF6Gqmzxfygkj8R7RD1ng+rpwZAResezH4GJZk3MZCMGdfxzw13PeL
UnCEdqukPqcTSZI+QcQJ3+yFnDzl65t7MnPSJT4LrVCzMiPxND7YUzx2oX230GIv
ZUvj9CIrc4r1IUSKK0hz43Rsie6O3gVvSPYPsexpy9v4pHdKu/RCh/QhIaERbx2F
5tn5qh+3s/DiHn+LnOxDJUbHCsZhrC70oh6XbKT0EfGOzivueNg=
=B7hL
-----END PGP SIGNATURE-----

--Kuk/n493crKO4rgR--
