Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B86C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Mp8JFo3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfAPB1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:27:14 -0500
Received: from ozlabs.org ([203.11.71.1]:33011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfAPB1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:27:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fV1V0tYdz9sBZ;
        Wed, 16 Jan 2019 12:27:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547602030;
        bh=Vk5VJY5qkeVYA/nEuEPvNyJQXgHVxM2D1nh/ftG9Ams=;
        h=Date:From:To:Cc:Subject:From;
        b=Mp8JFo3BC29VHVJmM5SjuyXmPdjL0A5M3fg7hhs1ZHJb1KQ9qNH9Q2f8CZyce8MYF
         bup2mNbq1gYAKm3WF3rINePhN2THRR3Ay72m6FffgJrptWgMvmklBRbJPNykIdVwsh
         1Cq/c1o07a80b2GQWgd+a2ndI3LmXjNrC8iHrqMQMnZvtk0TfUGfjW92zPPaOLvGI5
         e1zzWF7CBe/XHrWYVYGksvGxDSmKtj+/iGjkgL+DAhLZzoVvyRlom38g3qXVHfCxHG
         3aWxHBxnTXBqcfXe8Rr+a5krPsH6kS+v18v5keW9demNGww024uNjxrjwjfdmvbxkE
         n1zln/y8ljE3Q==
Date:   Wed, 16 Jan 2019 12:27:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Imre Deak <imre.deak@intel.com>, Lyude Paul <lyude@redhat.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm-intel
 tree
Message-ID: <20190116122707.066059a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j0dvh.y9SAu7o7kTGCAl45A"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j0dvh.y9SAu7o7kTGCAl45A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got conflicts in:

  drivers/gpu/drm/i915/intel_dp.c
  drivers/gpu/drm/i915/intel_drv.h

between commits:

  e845f099f1c6 ("drm/i915/dsc: Add Per connector debugfs node for DSC suppo=
rt/enable")
  f6bff60e927b ("drm/i915/icl: Fix HPD handling for TypeC legacy ports")

from the drm-intel tree and commit:

  96550555a78c ("drm/i915: Pass down rc in intel_encoder->compute_config()")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/intel_dp.c
index 0a3ac98a779e,d18b72b5f0b8..000000000000
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@@ -2062,11 -2055,11 +2066,12 @@@ intel_dp_compute_link_config(struct int
  							&limits);
 =20
  	/* enable compression if the mode doesn't fit available BW */
 -	if (ret) {
 +	DRM_DEBUG_KMS("Force DSC en =3D %d\n", intel_dp->force_dsc_en);
- 	if (!ret || intel_dp->force_dsc_en) {
- 		if (!intel_dp_dsc_compute_config(intel_dp, pipe_config,
- 						 conn_state, &limits))
- 			return false;
++	if (ret || intel_dp->force_dsc_en) {
+ 		ret =3D intel_dp_dsc_compute_config(intel_dp, pipe_config,
+ 						  conn_state, &limits);
+ 		if (ret < 0)
+ 			return ret;
  	}
 =20
  	if (pipe_config->dsc_params.compression_enable) {
diff --cc drivers/gpu/drm/i915/intel_drv.h
index 5e5ceec7c004,19d9abd2666e..000000000000
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@@ -1816,10 -1805,10 +1815,10 @@@ void intel_dp_sink_set_decompression_st
  					   bool enable);
  void intel_dp_encoder_reset(struct drm_encoder *encoder);
  void intel_dp_encoder_suspend(struct intel_encoder *intel_encoder);
 -void intel_dp_encoder_destroy(struct drm_encoder *encoder);
 +void intel_dp_encoder_flush_work(struct drm_encoder *encoder);
- bool intel_dp_compute_config(struct intel_encoder *encoder,
- 			     struct intel_crtc_state *pipe_config,
- 			     struct drm_connector_state *conn_state);
+ int intel_dp_compute_config(struct intel_encoder *encoder,
+ 			    struct intel_crtc_state *pipe_config,
+ 			    struct drm_connector_state *conn_state);
  bool intel_dp_is_edp(struct intel_dp *intel_dp);
  bool intel_dp_is_port_edp(struct drm_i915_private *dev_priv, enum port po=
rt);
  enum irqreturn intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_po=
rt,

--Sig_/j0dvh.y9SAu7o7kTGCAl45A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+iGsACgkQAVBC80lX
0Gyv+wf/SDNIeUwXGpNlHeuiZP/adinJrh6a2mSjuJxPu/pFtafC2/wnhQMz6RWB
IYXn/8KHf4lHIHbNdVJWCYeNNSLeYdlBvQzgPqV49PhYeZJADLJL1vD3irnUPLPe
kLac4r2p6xSR6Apk/TNBUD9au882nWD/ch07yHvA1nhtSo41yk4yH1J9miuD7RKU
C1gwhA1T5dUencscQn074m88XHWqeJlGXym5vhRBT3Dd4zDaMTVuK2M/I1U1nm5u
rsR7dY89wPhG7mr3JjGO70xl+jGk8sR69jjIse5LM2VOxgLhFWStTMBjqM9aUh1/
KYsQ3evsqbNU5NWR8fxwPseM8KTifA==
=iw9M
-----END PGP SIGNATURE-----

--Sig_/j0dvh.y9SAu7o7kTGCAl45A--
