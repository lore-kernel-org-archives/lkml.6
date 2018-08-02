Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0754C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F24214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX59mW8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F24214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeHBM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731895AbeHBM5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:57:42 -0400
Received: from mail.kernel.org (host-091-097-086-007.ewe-ip-backbone.de [91.97.86.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C04208D8;
        Thu,  2 Aug 2018 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533208023;
        bh=BCC0B1zy8fDzBd88DxD+8qepS1ZkalV4U3v82n3wPAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lX59mW8KvmTeNmK5gDslDCwzkniKWD88pu6sd0gu0NF8O8Aj4OxWjLXnBuZ7KjSoh
         c4VHGFNrWhEuliepeFL1UwrwehVTRacz8Mpne8nDa+sLN5QVB55NLFM8Aitsihzguy
         +Riq/+JE8DvSL8MalGveZ2GlP0CJI7zmJ6HRMSZY=
Date:   Thu, 2 Aug 2018 13:07:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com,
        narmstrong@baylibre.com, claudiu.beznea@microchip.com,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180802110701.3b4voigegy67h4p5@earth.universe>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801185823.GC26087@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xbljm4k4eov3zyn4"
Content-Disposition: inline
In-Reply-To: <20180801185823.GC26087@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xbljm4k4eov3zyn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 01, 2018 at 08:58:24PM +0200, Pavel Machek wrote:
> > > Yep, so I have two patches that make the device appear, but vibrations
> > > still do not work for me.
> > >=20
> > > a) any ideas how to debug that / get them to work?
> >=20
> > Hmm no new ideas except I wonder if there is also some other
> > regression with the timer pdata not being passed properly now.
>=20
> I checked vibrations work in original Motorola Android; my hardware is
> not broken.

You got it working, but this information might still be interesting
in case of future problems:

The Android "driver" is very different from the one I wrote from
scratch and upstreamed. The mainline driver is less lines of code
(iirc 25%), less complicated (Android vibration support is spread
over multiple drivers/arch code), more efficient (Android drivers
does GPIO bitbanging instead of PWM) and provides more features
(Android driver does not allow all strength settings). Also it uses
normal input device API instead of a custom one.

P.S.: Sorry, I don't have much time to work on D4 at the moment :(

-- Sebastian

--xbljm4k4eov3zyn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlti5dIACgkQ2O7X88g7
+pooEQ/+JRA1BRFyzNPpnTUA8BF8POAbacA7fDvomNAASvrd6MaULPagTcKmVMyk
dEPV4I7ptLyH6mphyGCtd3GKwfRPa4ufbRGTP3syHPxvp5hm+NkXo16oBM9M0gyK
skc/jQ72v0EKKIueSqHcRe1NQXbyDjzSWw46Cju+OJghDFc+pE/2DU+QfIaJSpjD
5KBoig4XQOztHwVT0J/WPxg8h70v4biLVq1pafo2/4SYlyF4pmJCcjzxE0ivULMe
F3XaHomwxdiTbNlhHRHow3Me/xoPQrY2UZdpc4I+xIX1yjCDn1+P/iVFiAcmCUlJ
yviku2W2/h9K6mVDow+PhxorgKviZw98O89jQnlKrdTcB2C3sySC65DOq2DJFiJi
N4MjeU8cIfPnurIQJ0mv6jq/0qiPlnOTBnAuzbXjGUvaGdAmntfFQ67P8/OvWlHc
m1XhWavKj55cJpbKIoDMmUQIxtOi3QtEE+GEZrIReY6qdGD26rPwW3kKM8F6HUR/
qwDR7VWFMdu6/TScRTj7y8Wyjr39zgtSdeL0PxqM3BYQ/POX+fBYBCLxqEQxgOxZ
4dXNJDlavOQx/YA6NfyUlL5ViLCuxwA0fO2NHqPE0psJZj2rS2UL5/9urPNMgZUm
oNu9uR9LOx/WdGS3VV5S3sIKT9cOOny/tRN/WGsyi4iGCC2Ufjo=
=X+hm
-----END PGP SIGNATURE-----

--xbljm4k4eov3zyn4--
