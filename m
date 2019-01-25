Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F19BC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C526218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oNGOMvSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAYC1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:27:37 -0500
Received: from ozlabs.org ([203.11.71.1]:46865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfAYC1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:27:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43m2x11zdmz9s7T;
        Fri, 25 Jan 2019 13:27:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548383254;
        bh=tb+PQI/5M69R4A/vcdNNiCJpUHjcFKlxL0U9JIhfXvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNGOMvSiLs/E+GHCic+0kuaBKPXBBW/PO0xo3EYcJWMe9ZvEw4quWAm9HEvn8IGYt
         oZuj0b2CdsJZQMi7NpZXaYK2jf+JcV2BTEv81Svqv9OWR1NOjRXDvGUwY4SIZGzwqe
         bRnns8qdHNaphL78jv3Irmx1Thw7L3i3ud2NZZ+DYJZA1b+BxBenL6XYNKnYKFW77R
         Gkw0Fymyi5zvlYUu5ukbAe9sGRQst6QR4+7f4lPXYev2W2fuYhJAyhuHpxtKXszbuz
         7ON4c7M6UrqLwy1QSneW7rrOqOS48e6tsNjhNGwy5eDypFypGMJ+H8CLgHCf4i8oDo
         Gwvg7K7/Ei0Ow==
Date:   Fri, 25 Jan 2019 13:27:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Li, Weinan Z" <weinan.z.li@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-intel-fixes
 tree
Message-ID: <20190125132731.1c076665@canb.auug.org.au>
In-Reply-To: <9BD218709B5F2A4F96F08B4A3B98A8977335C38E@SHSMSX101.ccr.corp.intel.com>
References: <20190124221949.4c89542a@canb.auug.org.au>
        <87munq1e9u.fsf@intel.com>
        <9BD218709B5F2A4F96F08B4A3B98A8977335C38E@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iStUS2HT5_QZfgzo/uCY0g0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iStUS2HT5_QZfgzo/uCY0g0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 25 Jan 2019 01:21:26 +0000 "Li, Weinan Z" <weinan.z.li@intel.com> w=
rote:
>
> I am not sure about the problem. The commit id "0cce2823ed37" is just
> for the patch of "drm/i915/gvt: Refine error handling for
> prepare_execlist_workload". Is there any other problems I missed?

Its just that the subject line of that commit has a space after the
':', but the copy of that subject line in the Fixes tag omitted that
space.  This is not a big issue, my script just pointed it out.

Its not worth doing anything about it, just take a bit more care in the
future.
--=20
Cheers,
Stephen Rothwell

--Sig_/iStUS2HT5_QZfgzo/uCY0g0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxKdBMACgkQAVBC80lX
0Gxv9gf/eU93yZ6hSWNoTVWCttXwJR4Iosd/fonswdprpHXOXAbiSn5F/HqhLP4o
O0oXsFqiUV0erlGG18U79aaNCuObfHnbKvWnKtpb1+qvedxhIeO2euWB4vGvOthS
7AJ4k6xbR/r9xRXXjHovFFfgcV04Fh0iwQ5yUp4CbRbYnReVKSmkrZhZ9Pn05uSO
+3fyi4Yyyo7Trl4F0cgF3iFmm/qe6AWNYiCbkdHBg2PwGNAvudqnF7RCEM7fU7dZ
ge9S+uQjr1fNq1mzXAWhbhsnsaMODVNNoQpmsd20QIX75wTe3qPVgg/l7ZI7SlVR
dO+18tocJ0ziJRnRwgQQ6IHGXF4Hnw==
=O2DL
-----END PGP SIGNATURE-----

--Sig_/iStUS2HT5_QZfgzo/uCY0g0--
