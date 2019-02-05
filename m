Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23643C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD732087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfBEBNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:13:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbfBEBNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:13:42 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqpIj-0004KP-OM; Tue, 05 Feb 2019 01:13:25 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqpIj-0007sn-Ia; Tue, 05 Feb 2019 01:13:25 +0000
Message-ID: <b6c5883015ae25b2e87576b6295c328f5903ce5a.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 045/305] x86/speculation: Apply IBPB more strictly
 to avoid cross-process data leak
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        SchauflerCasey <casey.schaufler@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 05 Feb 2019 01:13:25 +0000
In-Reply-To: <20190203213706.GA31598@tassilo.jf.intel.com>
References: <lsq.1549201508.524404500@decadent.org.uk>
         <nycvar.YFH.7.76.1902032005040.11598@cbobk.fhfr.pm>
         <20190203213706.GA31598@tassilo.jf.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WMooIOmOPocK8pn2Kg1f"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WMooIOmOPocK8pn2Kg1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-02-03 at 13:37 -0800, Andi Kleen wrote:
> On Sun, Feb 03, 2019 at 08:05:53PM +0100, Jiri Kosina wrote:
> > On Sun, 3 Feb 2019, Ben Hutchings wrote:
> >=20
> > > 3.16.63-rc1 review patch.  If anyone has any objections, please let m=
e know.
> > >=20
> > > ------------------
> > >=20
> > > From: Jiri Kosina <jkosina@suse.cz>
> > >=20
> > > commit dbfe2953f63c640463c630746cd5d9de8b2f63ae upstream.
> >=20
> > You really want the whole IBPB+STIBP revamp from upstream, otherwise=
=20
> > you're going to get noticeable performance penalties on some workloads=
=20
> > with some microcodes.
>=20
> Yes, we would need the opt-in/opt-out support too.
>=20
> Please don't merge it just as is.

Thanks, I've now dropped this.

Ben.

--=20
Ben Hutchings
It is impossible to make anything foolproof
because fools are so ingenious.



--=-WMooIOmOPocK8pn2Kg1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxY4zUACgkQ57/I7JWG
EQmhvg/9Gfwymq92ZBeqXTWrOOWyP/eGboeVWDAKE7bd2ZMPrtG4W2zVCXKhsweN
5fe9S+B3K8mixPOaSqC7Hl7JH1KLXzYuNatlbkr7pQTLjs07UTncoTMdrtNUe9m+
cMi8WPle0wogIqZq55qVCOArL9zoXgGObbgOwSKdRPP/QdwV2xm2NrM1YFiX+oCN
2k/cF32FN95pYWCQ7Zo+SOj9NcEAfjTu7UvFhlXLVVgKTZz3irsihzzMdEDnxqKt
VYlUmj+mUBGZCJ7BuF2KEOhFdKRBO88zLwSMNLhob/HtcQ1zdKekfYUXMc9CJtUd
8iWap96dWozPT70rQF05EnXw6wGNOl2UE4YMskJxd25iCFDBaf1w49SHa/BERC9g
fLiqvBDmEgV2p6ocB3RR7EyvtnU3XuCVIApJgn6YPnAsPu6DjgkVu4pXU9iWF2VM
l36pdGw4Fcdkxdr1MxwYVDlLVej3GFpW3ZFosPVCB+52lhR7JyDYYLsxUM0FQiwP
XA+w0q5xfqAJ+PYFHdOMI060DDhN+lNeUy0hdnmy8V9H2qiRlWHv1kNlrsu7+eSV
QorhNcNGilgD6f49NoKMXN7PfZjyIXN+fFX1WOb/Qd0hKj3h3sKFZIl8iRtaDjVA
9YCRasw8+s4qjniGstgjPOF73rchMhSqY+9PGz4/sZ8aMKeOrws=
=pKqg
-----END PGP SIGNATURE-----

--=-WMooIOmOPocK8pn2Kg1f--
