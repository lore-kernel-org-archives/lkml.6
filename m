Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A3ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8433C208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8433C208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIPPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:22:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36561 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeIPPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:22:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 781F580749; Sun, 16 Sep 2018 11:59:36 +0200 (CEST)
Date:   Sun, 16 Sep 2018 11:59:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
Subject: [PATCH] fix iwlwifi on old cards in v4.19 was Re: 4.19-rc[23]
 iwlwifi: BUG in swiotlb
Message-ID: <20180916095935.GA4388@amd>
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
 <1536651177.3224.106.camel@sipsolutions.net>
 <20180916093414.GA4299@amd>
 <20180916094142.GB4299@amd>
 <20180916095535.GA4245@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20180916095535.GA4245@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


=2Emax_tfd_queue_size was ommited for old cards, leading to oops in
swiotlb.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- linux/drivers/net/wireless/intel/iwlwifi/cfg/1000.c	2018-09-05 13:12:40=
=2E453164067 +0200
+++ linux-64/drivers/net/wireless/intel/iwlwifi/cfg/1000.c	2018-09-16 11:54=
:04.010970756 +0200
@@ -51,6 +51,7 @@
=20
 static const struct iwl_base_params iwl1000_base_params =3D {
 	.num_of_queues =3D IWLAGN_NUM_QUEUES,
+	.max_tfd_queue_size =3D 256,
 	.eeprom_size =3D OTP_LOW_IMAGE_SIZE,
 	.pll_cfg =3D true,
 	.max_ll_items =3D OTP_MAX_LL_ITEMS_1000,


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlueKYcACgkQMOfwapXb+vLZ5QCgjbBnATFi5lFY8Fq4EA7weVue
QnAAn3xqHVBVB6njWkAYMbm8EaMogmXF
=Fr1Q
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
