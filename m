Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FEFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6DE21E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgTMguWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6DE21E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHIQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:12:57 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33332 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:12:57 -0400
Received: by mail-wm0-f46.google.com with SMTP id r24-v6so2403959wmh.0;
        Thu, 09 Aug 2018 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxg7bg+vo19iUMu7Ix6Z3a2GLgAnlB+VB7+utD84aZY=;
        b=hgTMguWFXngD18HGGAWyQSS4an18UulvNoVPWTsdMkxie3EEGk0I8kXIDZ+HkBAMWY
         XwRBDOZE9C2WduoQ3sZjFemDKkrn4spT9SxlXHGR3y9cVdanab7LQ7snRRrhz6u+76so
         HUyeBZP1D/kdjMvkB0GyF7dNv0hp8a7AG9EzTtToK+CkO9X01GMNEdG8A9uM+4XhrBmU
         liKCFc+ktgoxyD/woTpb3oPNd7SgILqcaE3LgTjrKZBSoo4P8UsVZPigHVu4JJvh/+95
         HxjtY/eR9TbRtlTjzZ5KuXvxp8QjeQxbJaw8tuqXCj3rD+E7p4WwD0QHkcCWtLMZYrfN
         OmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxg7bg+vo19iUMu7Ix6Z3a2GLgAnlB+VB7+utD84aZY=;
        b=FfPDrgHBS7sv5acOvpS1pIZ7VPD6QgHIPhJ5X8ASJucY8IB2TGqnmvVZst/UOflHo7
         xWfaUvde/LaolLWrZ17wBBbM9jMjB4b1jUbcLcm0fvilVuHt4tGZPhnWsPR6TkEv/Jp0
         7KhE8zDddkXqmoNv/jcNwIdKsgP6hZGH3LhCCoUuHUjsGL3Wmsg7NWEn8IJ2Ra/AwseL
         rWYTEzKiTmgLexv3nsumVDam7x19SLCq1Xgvz5n7jrHBmY4YPbGCEkLhCHmfNV64fh62
         YyNzCe9vOPeyry+5IzK3euV8vnosQD4KTbewxcDtfaUGNWy0rdXF1wg5Ido4u8qDPesp
         zyxw==
X-Gm-Message-State: AOUpUlEpOneQeQdVGEriXacAVd9Y5CKr4CMZQ08oKRCpQlXCsO+/1ofY
        bAssnWdRMiCcoLvG8yD89Xc=
X-Google-Smtp-Source: AA+uWPzynSvY2O1BRpFHd03P9GVdtR3PE02cXOGONt6JxIijmlOPxgpVyJt5ycxxLtO12utWa8Dgqg==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr1626995wmh.34.1533822476589;
        Thu, 09 Aug 2018 06:47:56 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id q188-v6sm14412242wmd.36.2018.08.09.06.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:47:55 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:47:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Message-ID: <20180809134754.GE21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
 <20180809114345.GL21639@ulmo>
 <20180809152254.03b97af0@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Content-Disposition: inline
In-Reply-To: <20180809152254.03b97af0@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:22:54PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:43:45 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> > > Implement HS400 enhanced strobe. =20
> >=20
> > Can you provide a little more information about what the impact is of
> > this? Does this increase throughput? How much?
>=20
> The eMMC enhanced strobe is a mechanism that can be used instead of the
> HS400 tuning procedure. Note that the delay line calibration implemented
> later on in this series is Tegra specific and has to be performed
> regardless of which type of HS400 tuning mechanism is used.

Sounds like a variation of that would be good material for the commit
message.

Thierry

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRgoACgkQ3SOs138+
s6Ek9g/8CIOFqwrTD09B0L2yVYz5rSYuD+fJvJACIETWJSNe4V/jUUsvRnGbCkhm
92ZLz6diFCrz5/uX/cJAdnbVcSyOjqidVkpJzPlZLeyx0V2q8Gobee0+AuSMHVub
5WZOms5ZPZhx38G+x7TTwA8p8gtVtoQtAHnDTZU0EhxXyD75YGrUk22bYvXRKSbC
UumCFuJDmghSAfbahN6bRO/6zbCU1iWCzah4GktlUC88jmtdpLBtue93rGNYthGp
Dl81TPu43QvOw7/GSGGNWY4cDdjoVon1RUH7dwgA8OY3OnLv33oOLNY9nr5E38PN
xvJiwMko3YWyIW3/sFmfG91Q0rKQj7b5rCe8kgVdD1wVu8ISMt/uxTos3cwu/j6y
1c58NWO19sVDPil0TovPqiSb5GBfRZAVSVAhAHYx2aqmEiKvx2/plkvO7fy/J/B3
OVyHepxiBUURyxNIjPUvUXlhDQ2/0FnoENyZ/SWW/bvWmXzScIq4DODwuF2kOvEO
lLTNPwVkm9oAhmgY4o396ZhomYI9xMUXb63ozdPdVzKXl3EcinQL0W9B1ysF6ixs
HvpZN/kp4tEx7/zQ153vPW+4/B4SfwnqvJX6fHP8KcdZAtDVD2/3FTW6aDdAi+vE
2DL+KGaenRGQ6WAmhFS9CQomXMvP2ELO/dF9ph/H+5sof76udWo=
=Q54M
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
