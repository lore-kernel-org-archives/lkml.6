Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsjXlwlPLvePZLR+gz6Aw7Fd7rl3PUOTYZzMX1zzfyp5837CB1y60FKlo2vGMqgw/b5BD7x
ARC-Seal: i=1; a=rsa-sha256; t=1521421188; cv=none;
        d=google.com; s=arc-20160816;
        b=pn1Zeg5civ3AzqS+FOsJCR1WLkiaQ4YrT/RFzxAWPGLOCVl6GlHtBRhqIVE+4f9B9/
         32l1BsVAyP/3g9XVPRWePkc15Vjjbefpvik7z96KeTWdXonUyd3WcUF3XvdnOO1TaNbT
         Cgv2h7s5VEfSmH9yP+Zu0LeKtfUDRyTcxpc2JdSFqp0b6yPK79XJvtEXyQn8HZiJkrOk
         OYFzuLv6De+xIEAEpG8qqmAT/dQHIFHoS9Y4lwGGf0LfjYdUrK4XL+XSphkhA8fnBNt1
         YCLKg8Bp74GTkbi6NCYAesj7RXoUoXzISMw3wSIbmBAwKCoLvt9N42aqQh2E0BYZITsj
         xHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=24aDPTsgoES9E1xS6ItnW6pNMoeUzvuLkjOPbBn4Vns=;
        b=dc9Dn5MAWGgqKyHvl055PzTDTR5Poto19muWtmzK6iI/J8HCt2HBkScrI/F4giMspB
         mUGndmsfd/NZReuqFkgSZdOdvCNi3hgieBc591UhQt7WGxalS/JmXKC90XRk5wavynUe
         tO07oYrNkNZCEuncyOkY4GCEYIhEvDIEsQu0w/o8BPubQ25Y7PvqVuihJZ/0UcShl4v2
         FpRjhXefdFdqekE5etihcNymlhp04I4QQ2a1wnzxIlU3N7oDkXwfc0LYKC3EWWwpUAVl
         M2EzZHXFHiBAW1vQ6z0hMyeXGhEyHEAVPMoIpg3OO6mypKCepnNxgauvAwRKZltZ+10v
         uUIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Message-ID: <1521421160.2495.188.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 56/76] x86/syscall: Sanitize syscall table
 de-references under speculation
From: Ben Hutchings <ben@decadent.org.uk>
To: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Jinpu Wang <jinpu.wang@profitbricks.com>,
 kernel-hardening@lists.openwall.com, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich
 <JBeulich@suse.com>, alan@linux.intel.com,  Thomas Gleixner
 <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>,
 gregkh@linuxfoundation.org,  linux-arch@vger.kernel.org
Date: Mon, 19 Mar 2018 00:59:20 +0000
In-Reply-To: <2a1d3a0f-6227-39c6-0ed9-a07c22424d67@suse.cz>
References: <lsq.1520823972.93871245@decadent.org.uk>
	 <2a1d3a0f-6227-39c6-0ed9-a07c22424d67@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mI2R8bO8LtGKrB4ZLhsb"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699616206088143?=
X-GMAIL-MSGID: =?utf-8?q?1595325744690589710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-mI2R8bO8LtGKrB4ZLhsb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-12 at 08:32 +0100, Jiri Slaby wrote:
> On 03/12/2018, 04:06 AM, Ben Hutchings wrote:
> > In 3.16 the x86_32 syscall table lookup is also written in assembly.
> > So I've taken Jiri's version and added similar masking in entry_32.S,
> > using edx as the temporary.  edx is clobbered by SAVE_REGS and seems
> > to be free at this point.
>=20
> I don't know the state in 3.16, but in 3.12, I had to fix the 32bit
> entry on 64bit in arch/x86/ia32/ia32entry.S (ia32_sysenter_target &
> others) too.

Thank you, yes I need to fix them in 3.16 too.  I also failed to use
retpolines there.

Ben.

--=20
Ben Hutchings
The first rule of tautology club is the first rule of tautology club.


--=-mI2R8bO8LtGKrB4ZLhsb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqvC2gACgkQ57/I7JWG
EQmXpRAAwMMnb5IZ7NDeYxMrSAYDFY4c7Bf/qHchP6Sj4WB8pR58u6Ptt0pQR5nJ
d3gt2EKjANaXJQfp6JKX9SOFyY1HEL0hz1tf/E99Qib4hHPJ4PnD8srug4MQW3q2
1Rcl2LE+pqHRP6N3ge4/QEV+xRcs2+k+RMHVOrMco+9s1RfPfQJKTE7Bh1VkYX1R
iTkcc+r+eA53pkorBOovZ48Ih74SWuV3CdJ2jypZBcVbep4dPrw/dzrsLTKa9DL1
d64KEiZLCWOcZs1exeDAzvFFk0QKiB61znapD3MHlkor6lFp2DgNIU7rizYdW2G5
Ig/XNpKZnhFaPLB56xAZ/dZU5RgFwo0wpOvDH97OOdf6cYu9dM0f5m5eK7W/Ozaz
JrJEEbWPcL5WEgEtTIY7B890sgacwlJdxBqeVmeurBU7nE2DcGCgqTisF7DbJIMv
BPBrQct92RpS9xM3HQxMbOsqP91w1GHL+TrDr65ehSZzG7pE9E03rzE2k/LBn8yn
9cE55uVVU84u13+jR9A63us7c3j+pJkMiUoLZVHZasFoZjlrysuxyiR/NAo4gNJA
Ue6X7VW/nAdIQkgzA3Nrgnx5HOHkjJK3DdweQkzR4+5zuWXq98TTOetVuC/Pcrhk
DrLIPKiUdkuIC4z6n9tk1RpKWITpeIVq+hScPnnZ6NuG0fQJOOw=
=nHXF
-----END PGP SIGNATURE-----

--=-mI2R8bO8LtGKrB4ZLhsb--
