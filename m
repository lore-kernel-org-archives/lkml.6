Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DB12064E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB12064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeHXV5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:57:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbeHXV5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:57:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 11:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,283,1531810800"; 
   d="asc'?scan'208";a="67640272"
Received: from gcantufe-mobl.amr.corp.intel.com ([10.254.68.192])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2018 11:21:53 -0700
Message-ID: <9f9cff98f1f7f0b9c9250a3a14f1ba0ea7268ed8.camel@intel.com>
Subject: Re: [PATCH] ixgb: replace dma_alloc_coherent + memset with
 dma_zalloc_coherent
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Aug 2018 11:21:53 -0700
In-Reply-To: <20180824165232.21585-1-colin.king@canonical.com>
References: <20180824165232.21585-1-colin.king@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uT4qeAtkdph1xQY1SHL7"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uT4qeAtkdph1xQY1SHL7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-24 at 17:52 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Use dma_zalloc_coherent rather than dam_alloc_coherent and memset.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks Colin, I already have this change queued up from another community
member and I am just about to send a pull request to Dave for this change,
as well as several other fixes.

--=-uT4qeAtkdph1xQY1SHL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAluATMEACgkQ5W/vlVpL
7c5rEQ/5AczVpaGY6KZ9MKBk+tU3G9ELyUmEFM+t27tQvTfHlPMbixO27NgvEXKC
wHEgHMR1t6WcW0N6N66oMcMLgyRo/holxn2qbSGwhLB7Pwb6iUSe/lnXjfqKuFzv
q/EtLuJH3y/VWyRQAziS4aqhScOD37th0LYEtSRKv/tph5a4aJsMw5RImwPbLIZs
H4+YS9Xm0LjnlIjyLC4/5LYOCjlO03eZF0fq0jZSYXG5AM+AZtR0/1AZjSwlQ2YW
8lyvVJ7XO+F1Q/RoCNFK9cYVB3FrlRRO4jkae0UoLp7Ld5nNTLG+Czp94es53Mz+
ch293uHs59/nQzhMcr6S8dpZxF9MBgkiDJlU7HTKa5BDw6U+9lvrQ4/w2ak5ytxb
I4Qv3FIOULP5GwzVbq5zfowSpzZTKxOb9wDl1fyDzTIeGhZG6A3ir+1jVqavbaKP
pFjmR7UqgE1hroAuJseyu6WjNUNPhzw9XMGmCAAnT42EeC4CNJoltze/l9ckUu7y
ZNycXUqQMKHT2KDrRJarQoK3xBzC1gsJ4ryJzW3Suqzo9OoGE5ZrhIkB5oPh2zIV
5+WQUgog5HNCJnvGoAM1HNpMoPX72PJIk4DAuHeui6+O6x0T+wdiXR3DabwyCBVj
XoUvGkdQNkKqpPIJ81B+K5CKHRFvgZniHlh5p6OCuDOkKPkwtvE=
=IGf/
-----END PGP SIGNATURE-----

--=-uT4qeAtkdph1xQY1SHL7--

