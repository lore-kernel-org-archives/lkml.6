Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52805C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D2B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D2B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030673AbeFSUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:04:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53572 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030259AbeFSUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:04:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 21DF98051E; Tue, 19 Jun 2018 22:04:16 +0200 (CEST)
Date:   Tue, 19 Jun 2018 22:04:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>, Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v11 00/13] Intel SGX1 support
Message-ID: <20180619200414.GA3143@amd>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180612105011.GA26931@amd>
 <20180619145943.GC8034@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20180619145943.GC8034@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-06-19 17:59:43, Jarkko Sakkinen wrote:
> On Tue, Jun 12, 2018 at 12:50:12PM +0200, Pavel Machek wrote:
> > On Fri 2018-06-08 19:09:35, Jarkko Sakkinen wrote:
> > > Intel(R) SGX is a set of CPU instructions that can be used by applica=
tions
> > > to set aside private regions of code and data. The code outside the e=
nclave
> > > is disallowed to access the memory inside the enclave by the CPU acce=
ss
> > > control.  In a way you can think that SGX provides inverted sandbox. =
It
> > > protects the application from a malicious host.
> >=20
> > Do you intend to allow non-root applications to use SGX?
> >=20
> > What are non-evil uses for SGX?
> >=20
> > ...because it is quite useful for some kinds of evil:
>=20
> The default permissions for the device are 600.

Good. This does not belong to non-root. But question still remains:

What are some non-evil uses for SGX?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlspYb4ACgkQMOfwapXb+vJoHgCfQETW41371wt6g9JNvkkPCbRX
L7kAn1QrI68f6vHPl4zK49NAGUx7naPO
=WZ8V
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
