Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702D6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E2120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxmDRIt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E2120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeKAS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:59:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40995 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeKAS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:59:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id c25-v6so1756226edt.8;
        Thu, 01 Nov 2018 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8FIyBrqelp3dHXmVVzi99+2pbML3yiNdURFwx/8zxc=;
        b=uxmDRIt8XSGlPdUnFbuXZMemu+mSQQAVhZMT5OYFVMfA7hjvSPkg6lLZL6CsApkzSd
         Nr9pAOyxF6FPGyChsNTNrehcaIx0azDcr7KzAVlvcn+qYFM+6FWpYSfb8RuD60iY2GUn
         Xdshsavyla8HJUMxTzj5kkgkozGmzpwtI5ilg1W2ujYQQrHRr+TsKd6k7dfVOf8IrhBI
         lue1Nv2Ugqr9mi7gi68B+6AMWFH5Kg6B984ZVz78KlsSTLg3R3GCtTLQLxkmC2RG8dDX
         Ng/UqERs8IqoCQnmNPKYWbM+p0sebaJ5RqmdyH+6Gogj1EbbQpzzwBQGm1MwCOCC+Qqj
         7ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8FIyBrqelp3dHXmVVzi99+2pbML3yiNdURFwx/8zxc=;
        b=T8uT5tFLT0vgqmphAJfbr2xjMzN3pAS0fwk/JfReaOm4tmXHe12Sy02/J2Q1s9FThV
         M4KulFIoTn2L+I713DaQSePBHIqXSE2bZYxOVVsamA6Q2ZT4kSB7sZ0zi4ywvKosiXUk
         GRcSQj1A/jLNt17SG3Fw0Hf2i+RucGLyu/u2EWyPpI++tyc4fj8vCTk1gFymopOLqdLJ
         d4TWPRsvmtiUXymMs9nLQUU4GaYqjcKjFcvDaJFzO2CM0LMCX3WDC28VWjvoqrJAN9b/
         sKpI+YbyLm1JX7eDpvoEXGJo5uEg3PQgpl9DycfQWevj+YIiBUMtrCoBwXPWsx41Sa4O
         NgXg==
X-Gm-Message-State: AGRZ1gK/LxVPHDZeoN4WL8oHdY0b8KSNpgybbc9eGpbnW0Ac20aBHRbP
        /gwrUSAuEbQkhHJJhtGnPD0=
X-Google-Smtp-Source: AJdET5dpgRgjYmHc+MDNo+zRl2jCAhHGhz03JiBF6KSYZgX5aucDfWFsa6y+IUACL2K7OXrilst0JA==
X-Received: by 2002:a17:906:9154:: with SMTP id y20-v6mr3626550ejw.8.1541066201898;
        Thu, 01 Nov 2018 02:56:41 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id q12-v6sm9352315edd.35.2018.11.01.02.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 02:56:41 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:56:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Message-ID: <20181101095640.GA23707@ulmo>
References: <20181016060402.18756-1-vigneshr@ti.com>
 <20181016111541.GE8852@ulmo>
 <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 07:02:23PM +0530, Vignesh R wrote:
> Hi Thierry,
>=20
> On 16/10/18 4:45 PM, Thierry Reding wrote:
> > On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> >> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> >> AM654 platforms.
> >>
> >> Vignesh R (2):
> >>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
> >>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
> >>
> >>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
> >>  drivers/pwm/Kconfig                                  | 5 ++---
> >>  2 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > Applied, thanks.
> >=20
>=20
> I could not see this patch series in pwm tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.=
git
> Is this queued for v4.20?

I forgot to push out those patches to for-next. Done that now. It's
quite late for those to go in, but since these don't touch any code
it looks okay.

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvazdUACgkQ3SOs138+
s6FFaA/8DhaXRA4Rhay0Y/7xnxiNrhzZwNegQ75Pi73yJHimZbJbYQ//a53aiB7J
/yaTC7Gvqd/QiVZ0CuzOBXVx1Lzo06mVDghQ/sscrG2KnrnozyNDbEFhAaZ6Y3yt
J8hLcwQ2oyBdQT9LBbAIljQsnhM1kQ9iieDDVHCfNzEvCjCw+Xplv4Nkn+aNw87f
Y9pxiqf5NWtxp0bRF2Awb/gBVhqSLGZ7fm3VrxOV9qm3cG/b04G7ZtA8NkXcihnh
Fp+pEqukEU2wE2X1i/Y2RjWr1xdHnx309YEvEqNF6xDVQ1LWpIBFIweDuKgkdd6L
D5z+u5WfxU2SgbLy+ukHGvrWPt7pwbLIUHfNu0nfGZxFGej8w6gZTp9F9FyiDVbv
fdusFth/BFW5BkpUGgCkJA052LD2bvrHNcR7xERTsfBybrt1AqRf+MnvoMnYwsUj
C5yduQ04he1w5yTHcrcfIBE6YdkL6Zrezb5zrF5x+06SvdBVvUa+WRprhWZAD24j
Q3tCSn02aRmYf9cF3WvYXMPBOKmvIuJ8EuYKMev3Y9zIuxuh9N3JbMHAJvLvOCF1
BdL/13CUonx/qQ6BamLRp0uOVOsQ9XPkf9lzUQa52dvIHLdqO9U/FXy+FuOAq6kA
60eepjPS93XO1J1z5345NnrmhwfMKOYH/V5Qii6zA5dDc8y2QzQ=
=PO6m
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
