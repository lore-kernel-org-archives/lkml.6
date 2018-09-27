Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7288B2156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIOIX+y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7288B2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeI0M5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeI0M5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:57:33 -0400
Received: from earth.universe (tmo-111-71.customers.d1-online.com [80.187.111.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED902156D;
        Thu, 27 Sep 2018 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538030453;
        bh=J6sOyhgMVPt/PpOFGAP0Lmov/lyL0JZPsCIcZEYfykY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIOIX+y3Umm3mA62XZSBIfKCSYRtvKuekmptqCQ46VUpE+U0v+sFUY/h0JzoFs/iL
         KYBvh725uKphEwUHc3JeiK5DoLjp0pJwBHBPj9WduAacSitcXgt3MARem1SaiPXCvC
         f00c2vLR4UUbJh6QGNsIxWTFgxCsrGORQq0sJGXw=
Received: by earth.universe (Postfix, from userid 1000)
        id B2CD53C0892; Thu, 27 Sep 2018 08:40:47 +0200 (CEST)
Date:   Thu, 27 Sep 2018 08:40:47 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] power: supply: core: Introduce properties to
 present the battery OCV table
Message-ID: <20180927064047.gjxg5ikbrdgbc54u@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
 <20180926135150.fla2r4ilfco3atws@earth.universe>
 <CAMz4kuK0PGonikK=pH50p=7NFXZHRuMZ+Aq9ZYT+8q8giKZCAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7hcsql7m2t5ho6w"
Content-Disposition: inline
In-Reply-To: <CAMz4kuK0PGonikK=pH50p=7NFXZHRuMZ+Aq9ZYT+8q8giKZCAQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7hcsql7m2t5ho6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 27, 2018 at 09:10:05AM +0800, Baolin Wang wrote:
> On 26 September 2018 at 21:51, Sebastian Reichel <sre@kernel.org> wrote:
> > Looks good to me. Technically this can result in existing users of
> > power_supply_get_battery_info leaking memory, if they have an OCV
> > table in DT.
>=20
> Fortunately existing users did not have an OCV table.

Right. I was just talking about potential memory leak, if the DT
file of these boards has the OCV table defined. I don't think
that this will be a problem in real life.

> Moreover once this patch merged, I will send patches to add
> power_supply_put_battery_info() for existing users of battery
> info.

Thanks.

-- Sebastian

--k7hcsql7m2t5ho6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluse2wACgkQ2O7X88g7
+pqfZxAAoPl9aL6sdDCBfxKazPiI9s5153oyEycYk5X1bgX1suAVKe9RLGPCzb0/
upA/K5pX5tSaDEF8APJA6fI7KCsnRnXKMWbE9Hzuvh970Z0LHzxUi832xfrVNeWy
YBekJcdfhAhSpMpRviB4dqle9Ng+72UYE3+vVF5B6slN6dcJVX9vQGX1TzWVNJAL
lIw0E8YuBl0IYFMufi6b79dCWu0RVWjTP3Czn9sHcqVrI6iPczqLYDic5cPx9p/8
3RjxIIX5f1QttBNDmbaVr5RjnOn/VM1epiDUQRVWhZV+lFZaeUOxjXbn0iV9Dr9/
kMHlTfmMLXr9DRNplgXpGYBjQyk1BlLfWw5vtlxZEBwhCjQeole6hLQ5CkvUaeH7
CiXRqGob6EkZ/6SHCd0u2Azkb7s8hhUpdGdwJ4/RwQ5mVIlaIlvul80QgtKvntxM
3cIS1nJtYElWCiuCsldh9OCyYBUnAm+NJhB7ug2cO0CguvpkNDKY/FhqzJo1awcY
mH5WDqkdjqmVvMNLUXbTDXhhXdDQjpFn/nXc/UdbLFPhrpEZqEHvIOP+IaEK7F14
TYBxiwHtFysgLXEd8cluaDwtNgh8ihIP9luRwzy11Ru8sg2DBGQRnoyYVbY9dVfO
8KNDcuT4nxkpP9s9WgyDgUekYOvJhPaQ7J6BEgvWm6CPI36Q6/A=
=rqSa
-----END PGP SIGNATURE-----

--k7hcsql7m2t5ho6w--
