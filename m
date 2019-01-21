Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64313C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0DB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfAUIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:17:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:50046 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfAUIRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:17:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 00:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="asc'?scan'208";a="136381071"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2019 00:16:59 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC endpoint
In-Reply-To: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com>
References: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com>
Date:   Mon, 21 Jan 2019 10:16:55 +0200
Message-ID: <87tvi2juh4.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Zeng Tao <prime.zeng@hisilicon.com> writes:
> For ISOC transfers, if there is no available data for a period, we need
> to stop the transfer by issue a stop command, otherwise, all the
> upcoming transfers will started by update transfer command, and will be
> dropped with MISS ISOC errors.

We, actually, have code to handle missed isoc errors now. Have you
tested with that applied? Which kernel are you using? Can you share
tracepoints captured with v5.0-rc3?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxFf/cACgkQzL64meEa
mQa2hBAAphFywsJGnebWmq1XqIKz8Cmbxk9lnquQ/uBzmwVXq/HbbTNoJiXiyrBr
GW3LANr977pxHNumdT6dGdeUIbsCEIVx6BnfuhDcUUtJZdTB9kSLReKzisPIQnLR
3BfeI52zw9cK3rhD7cSTCejWHsfCoUbjBw1YW6zFulJqu+kSfAomFS6aTpzfrzrS
Fms0xBiwpdAyNkflVPr6gJnnkS2eFoDxoM0vG9zDD6rM1q7gyFkYEuNOTy7ibK9l
R+L38ckvdUm+yltzVHGVPlD/kB14JLauIt3YICWQTJhPLarMocDY7QX7oeQmcA1v
jSmNAIFwMRP4LCfoUR+bHZCTBIB1SCj7yc4HfzvbE8G2E1aRgrEaAJ7VfhMP677b
NJtNYPuwB7WG+JXsf2+BN8jc9Rxn2nQ0KC9ayfAnDRfjv+IcZlLZ6E5FHpC6z3Tk
s21ieSzV+GzizMlMwuBBkY1yshjIlEl9MAgpI+a6vLG/qRrfQqhb2DzyFBBGlA4s
ritwoIBoh1z142mv9Xdd/lySHaxeouys8PbYr5pDwvDkqSL5n9lFRgNbV6XyF/fp
Ew4LSejy/tjA9Je0nuPPgtEOIFJ2TbAct77/Z67zv0a7Q1CTFrhzU5lC6ACB9J7M
A87uJmszm2uJfodfGwpnMoynrAI8SGWRmGMArsyxPH/UPaQ0x3g=
=PCA5
-----END PGP SIGNATURE-----
--=-=-=--
