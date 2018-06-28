Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82323C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4D277F6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4D277F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030574AbeF1Swy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:52:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47739 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932549AbeF1Swx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:52:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3235C805BB; Thu, 28 Jun 2018 20:52:52 +0200 (CEST)
Date:   Thu, 28 Jun 2018 20:52:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 00/17] MKTME enabling
Message-ID: <20180628185251.GB5316@amd>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> MKTME is built on top of TME. TME allows encryption of the entirety of
> system memory using a single key. MKTME allows to have multiple encryption
> domains, each having own key -- different memory pages can be encrypted
> with different keys.
>=20
> Key design points of Intel MKTME:
>=20
>  - Initial HW implementation would support upto 63 keys (plus one
> default

"up to"

>    TME key). But the number of keys may be as low as 3, depending to SKU
>    and BIOS settings
>=20
>  - To access encrypted memory you need to use mapping with proper KeyID
>    int the page table entry. KeyID is encoded in upper bits of PFN in page

"in the"

>    table entry.
>=20
>  - CPU does not enforce coherency between mappings of the same physical
>    page with different KeyIDs or encryption keys. We wound need to take

"would need"

>    care about flushing cache on allocation of encrypted page and on
>    returning it back to free pool.
>=20
>  - For managing keys, there's MKTME_KEY_PROGRAM leaf of the new PCONFIG
>    (platform configuration) instruction. It allows load and clear keys
>    associated with a KeyID. You can also ask CPU to generate a key for
>    you or disable memory encryption when a KeyID is used.

Should this go to Documentation somewhere?

And next question is -- what is it good for? Prevents attack where
DRAM is frozen by liquid nitrogen and moved to another system to
extract encryption keys? Does it prevent any attacks that don't
involve manipulating hardware?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls1LoMACgkQMOfwapXb+vJ5mACglt4/cRyb/gt/KHOTiwID1t8V
NhoAoKR8mceQbY+kMGFkXIOM0SabWH1J
=JaRN
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
