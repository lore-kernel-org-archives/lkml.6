Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE93C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEC1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RtCZhjoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEC1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeGSFms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:42:48 -0400
Received: from ozlabs.org ([203.11.71.1]:38875 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeGSFms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:42:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WMLM59KPz9s4r;
        Thu, 19 Jul 2018 15:01:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531976493;
        bh=FWk5xkkSrrwn8cYP7R9rjFLmhY2PN9sdk1ZjkQhBPpE=;
        h=Date:From:To:Cc:Subject:From;
        b=RtCZhjoimMtklwuZefN8x/EjpTJ0G0n12EhWp2ARmGuJV4tOOhEcXZk95NFmEae7m
         TjOjJeVnqx7SbaofItUlT/CwuhlZ9KvBjRrTzvXbn+dk0avjEV+mA9q1XqyWFW5akg
         TUy4gT9QWy02SbrzXqIslEw116tc6E+7rst/78uwShT1PtKxePPw3Y7kY4qghr5eK3
         7SlsPZl8pdeQkPV98nV1KrwoiQCIVZv/10ajjAg0hnRsXGWMlFfOVRLBumEBXBepJ9
         BBOg4M6Bo6sAb6UpItxAFEvKPYqJ+yPFxBeImfCuQF5E8dAiIDRnqbBA8S7e8BvDyM
         9iEalcc/vvljA==
Date:   Thu, 19 Jul 2018 15:01:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>
Subject: linux-next: manual merge of the mfd tree with the drm tree
Message-ID: <20180719150131.2abf45b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2rmEAujUj/4o0PLwFzYCzy="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2rmEAujUj/4o0PLwFzYCzy=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/gpu/drm/i915/intel_display.h

between commit:

  ac213c1b45f7 ("drm/i915/icl: introduce tc_port")

from the drm tree and commit:

  9c229127aee2 ("drm/i915: hdmi: add CEC notifier to intel_hdmi")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/intel_display.h
index 9292001cdd14,1f176a71e081..000000000000
--- a/drivers/gpu/drm/i915/intel_display.h
+++ b/drivers/gpu/drm/i915/intel_display.h
@@@ -126,17 -126,30 +126,41 @@@ enum port=20
 =20
  #define port_name(p) ((p) + 'A')
 =20
+ /*
+  * Ports identifier referenced from other drivers.
+  * Expected to remain stable over time
+  */
+ static inline const char *port_identifier(enum port port)
+ {
+ 	switch (port) {
+ 	case PORT_A:
+ 		return "Port A";
+ 	case PORT_B:
+ 		return "Port B";
+ 	case PORT_C:
+ 		return "Port C";
+ 	case PORT_D:
+ 		return "Port D";
+ 	case PORT_E:
+ 		return "Port E";
+ 	case PORT_F:
+ 		return "Port F";
+ 	default:
+ 		return "<invalid>";
+ 	}
+ }
+=20
 +enum tc_port {
 +	PORT_TC_NONE =3D -1,
 +
 +	PORT_TC1 =3D 0,
 +	PORT_TC2,
 +	PORT_TC3,
 +	PORT_TC4,
 +
 +	I915_MAX_TC_PORTS
 +};
 +
  enum dpio_channel {
  	DPIO_CH0,
  	DPIO_CH1

--Sig_/2rmEAujUj/4o0PLwFzYCzy=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltQGysACgkQAVBC80lX
0GyWtwgAkfx7SoBcEja4BV+CoqMNFWVjwNxITqyRgkDRKUg9z5XsHItLdjCMX77T
URrgiVuLRaUV8G+6gKAboCzzdHUBhAMbUo0Uz/Q1yNDGesL4U4HbHkZWHZXzqKUB
yA3OFJVwOKJTMqGJJ8uQUV8RAbobxYK52apX5KgptUV7KVn4ZNfJ+DY6fg5NZLjr
lvlZd8w1pP4skDllrkP+jV7r0a50CEUEyjPEDrzcF3K3RYYhy/w05u9eiHHpEK6X
/X9ryM1eqA0u+lJI6ONC3WTvxWRcXYRPsmg/7jWB9C6xvwAZJm1InB3IzIQqw2CA
q20VuP2jtXQhCXr+MRP0s7LAyrxw2A==
=cmp4
-----END PGP SIGNATURE-----

--Sig_/2rmEAujUj/4o0PLwFzYCzy=--
