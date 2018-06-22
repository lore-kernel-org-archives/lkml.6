Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03862C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDAC2466B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDAC2466B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeFVRId (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:08:33 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60202 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeFVRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:08:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWPXw-000193-1Y; Fri, 22 Jun 2018 13:08:28 -0400
Message-ID: <1529687307.7898.197.camel@surriel.com>
Subject: Re: [PATCH 3/7] x86,tlb: change tlbstate.is_lazy to tlbstate.state
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, efault@gmx.de, songliubraving@fb.com,
        kernel-team@fb.com
Date:   Fri, 22 Jun 2018 13:08:27 -0400
In-Reply-To: <57de88af-b7a7-2214-95c3-26917e00a175@linux.intel.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-4-riel@surriel.com>
         <57de88af-b7a7-2214-95c3-26917e00a175@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zoz0pQ6uziZOSLFr/MpV"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zoz0pQ6uziZOSLFr/MpV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:01 -0700, Dave Hansen wrote:
> On 06/20/2018 12:56 PM, Rik van Riel wrote:
> > +#define TLBSTATE_OK	0
> > +#define TLBSTATE_LAZY	1
>=20
> Could we spell out a bit more about what "OK" means in comments?  It
> obviously means "not lazy", but anything else?

After discussion with Andy, I plan to simply drop
this patch, and use memory ordering between updating
tlbstate.is_lazy and *.tlb_gen to take care of getting
the TLB reloaded at context switch time if needed.

We should not need the extra TLBSTATE_FLUSH state,
so a boolean is fine and this patch is unnecessary.

--=20
All Rights Reversed.
--=-zoz0pQ6uziZOSLFr/MpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstLQsACgkQznnekoTE
3oP9tAf/W7js3sfWNOl73LNL9j7YjSvr/4Z1mtBXAjuyrLzqZiyTCZ7r+uRl99vG
eQOAGDkROoGJG6xmp6vurCRZPLNMKMi1s88+w2clJvpdDt15AHI2F52BPWIM7Tnl
19BEPhzJooWX09FuYBdKam1hz3MXYrMYSkQJbkoRrvsmbZfg+zrLO4fB2bjHlr3b
05aBjJ2uERAY1dSi0QUmH5uCbV1hcABcNxo7vCJdhogXwTEqiVm0wUt/W2hU+vjv
ZkTDoa/yYoON/Ez/eicC6anV0j0s7gK7Db3uz0td8YWivKUy51916ttwNePoLzof
jx/sIVuDtT6PtfeJsEIJGsxSBg9ixg==
=bqvY
-----END PGP SIGNATURE-----

--=-zoz0pQ6uziZOSLFr/MpV--

