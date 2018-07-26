Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092CD20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nh9ei/U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092CD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeGZGZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:25:16 -0400
Received: from ozlabs.org ([203.11.71.1]:33237 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeGZGZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:25:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bgC23bQPz9ryl;
        Thu, 26 Jul 2018 15:10:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532581810;
        bh=6gPe1/N9iFsGbmUfCwWgV5GZwruhVNdv1IhN9mOGNfk=;
        h=Date:From:To:Cc:Subject:From;
        b=Nh9ei/U3FfqehxepdZeL5yUx/apF0g2z+9Fd+CUnl5XUVjzjlTAoprmatmkiP4sJj
         KcKWAfqxlMQkVJNJFcYqDoeMlV0/z/5OLWP9U+AxaLRR487teE2rAryox8Usm5Vs1c
         vKxcu+G4b0FbI/oEgSP68LyPRsTkH0DLhT5M4fU8GbnFpQCVADGuw4Pf5wWcMKB1Bm
         5UqBCOGjwj+/8RuFqM6Ts2F6F2IIocD4SQ1Vo3gCQDfCSzCBygJICfC6lVTuaeTFVd
         guSpKNhZXWtrs+85Br2AHdpPSQXJywOG75RNVIE9t0cv1dHNJfGZD+OhJHNQvKJ0PD
         St9sB4VRSwpkw==
Date:   Thu, 26 Jul 2018 15:10:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>
Subject: linux-next: manual merge of the mfd tree with the drm-intel tree
Message-ID: <20180726151006.345e8397@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OqOb2rGIAWkW6AeTXQUgwo2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OqOb2rGIAWkW6AeTXQUgwo2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/gpu/drm/i915/intel_display.h

between commit:

  6075546f57f8 ("drm/i915/icl: store the port type for TC ports")

from the drm-intel tree and commit:

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
index 0a79a46d5805,1f176a71e081..000000000000
--- a/drivers/gpu/drm/i915/intel_display.h
+++ b/drivers/gpu/drm/i915/intel_display.h
@@@ -126,24 -126,30 +126,48 @@@ enum port=20
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
 +enum tc_port_type {
 +	TC_PORT_UNKNOWN =3D 0,
 +	TC_PORT_TYPEC,
 +	TC_PORT_TBT,
 +	TC_PORT_LEGACY,
 +};
 +
  enum dpio_channel {
  	DPIO_CH0,
  	DPIO_CH1

--Sig_/OqOb2rGIAWkW6AeTXQUgwo2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZV64ACgkQAVBC80lX
0GwIrQf9FKuAHEh5iVG/5WG74N9MyvB8r1NKU+QGUnStmOteX2RJqb5tbGHft0V6
YAN7W2L3PYzUZn922txaQw0Ri9MTVJp1KV2eXNTaTgWbNlhNYDRJ0SFTFgdZ6qWW
8zsKC8VTLLFDz7E64ybjqtQP47QIGI1JsaL2HlJ1uLmYwRAPtflcCryxApUXSwfp
8yTLCMIFpW/hDjNfEa+h7qzrDTffeF7bWUjH4F4di9gf/uaa7yk+X97mG64kFpJh
M8P+hmSN5laIVYRKH+GOH3zHgoQocA8ldd661mXT34ca/clFFYUqIvhbUS8Rnr3e
HsahuQFSd2Q8zcaUce+Im6+czrYBUg==
=R/4Z
-----END PGP SIGNATURE-----

--Sig_/OqOb2rGIAWkW6AeTXQUgwo2--
