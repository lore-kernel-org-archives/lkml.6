Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA39C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B1208E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0B1208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHWAip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:38:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35106 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeHWAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:38:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 93EB38342C; Wed, 22 Aug 2018 23:12:13 +0200 (CEST)
Date:   Wed, 22 Aug 2018 23:12:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     hans.verkuil@cisco.com, mchehab+samsung@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: v4.19-rc0: compile problem in ./include/media/cec.h:82:24:
Message-ID: <20180822211212.GA30897@amd>
References: <20180822204426.GA23832@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180822204426.GA23832@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm getting this in -rc0:
>=20
>   CC      drivers/gpu/drm/ttm/ttm_tt.o
>   In file included from ./include/media/cec-notifier.h:13:0,
>                    from drivers/gpu/drm/i915/intel_drv.h:42,
> 		                    from
>   drivers/gpu/drm/i915/i915_trace.h:11,
>                    from drivers/gpu/drm/i915/i915_drv.h:2667,
> 		                    from
>   drivers/gpu/drm/i915/i915_irq.c:36:
>   ./include/media/cec.h:82:24: error: =E2=80=98CEC_EVENT_PIN_5V_HIGH=E2=
=80=99
>   undeclared here (not in a function)
>    #define CEC_NUM_EVENTS CEC_EVENT_PIN_5V_HIGH
>                            ^
> 			   ./include/media/cec.h:94:26: note: in
>   expansion of macro =E2=80=98CEC_NUM_EVENTS=E2=80=99
>     struct list_head events[CEC_NUM_EVENTS]; /* queued events */
>                               ^
>  CC      drivers/input/serio/serport.o
>=20
> Reverting 4786b0d6f3ca6da8db02b0a58cd2b785cb0b80ab seems to help.

No, sorry, it does not. I was confused. Let me try

HDMI CEC support (MEDIA_CEC_SUPPORT) [N/y/?] (NEW) y

No change.

Let me add

#include <uapi/linux/cec.h>

into include/media/cec.h... no.

Any ideas?
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlt90asACgkQMOfwapXb+vJDmwCfce7i++jssnK0NxobxyuUr0sq
kKAAmwVRP3UuYFHLMOZD3+8EcXoI/6Em
=PEkI
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
