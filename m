Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520092158-2-14023664595028563001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: mips-cps-fix-mips_isa_level_raw-fallout.patch
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520092157; b=nY6ZIqt7+UfjOk//2Zhrj7FNGDeGofyt4e63PSTPZzOvBpf
    2hKGplG+KN16JOsfllzfyMbeDb3x9CwZXGEw4i6QOpk70FRAA6ryjIpbfZBN0kOZ
    TEnooj75WNYN/LXHAEUFr0ZJxMjQ5B9X2EcyV7Oq2f55YmZjMz4zgnzmwC17Secs
    RLjykhB2fcVQu1wyNVAehJ3wjYN3G8rDB51Brn3qPmETn5OxLYtC82hROtXGNkkV
    pFSjsHhAelpL7s/tKjoTSCN92RwzDjJ7aDHw34G5Hh2mnWFH9kSVdBs+NK0m7vhF
    A/iptyKpbZKU3flFatcq8Dbn0n8Dcp+15imxTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1520092157; bh=0bxTQeSFP6XZfLdTS79uyp7dWd
    NmraCBRYkO58YmQmk=; b=tpEwh4LV9mQwGDMAYilURrFbL6GHPKEDJ7GEuSIDXT
    wij/NR/hcTcyIWWf+fO9aALQYwYT/JUHJideqKtRZo9bo+N4Bx/1ioClNPOgsVc1
    3NDLN+o5CN1UBIS/sB1lRfzGuw8gn98+wWKR/QXXWwpg3A0B/pfK+xchddmAqBT3
    xJKKzK+Q38QbtUM1lH4VWksXatvrLXr2mgjXmO4FQNhrSbNgCTlrlmJPbM5IZsXy
    ep7Z6NDJ2gy1DQ0GD33shslbMfdfQEYZ459zao5sU3VNWpfEJvguV42AwI5kfCZH
    /KXyZxnSXgsmUbybfdOaMsXKU9QB6kuaSVS+FXz0MOxg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeCCPtO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 10:49:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58311 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751995AbeCCPtN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 10:49:13 -0500
Message-ID: <1520092138.2617.375.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 091/254] MIPS: CPS: Fix r1 .set mt assembler warning
From: Ben Hutchings <ben@decadent.org.uk>
To: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date: Sat, 03 Mar 2018 15:48:58 +0000
In-Reply-To: <20180301134401.GQ6245@saruman>
References: <lsq.1519831217.271785318@decadent.org.uk>
         <lsq.1519831218.652977295@decadent.org.uk> <20180301134401.GQ6245@saruman>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-oN37aj97kEWbdmr8wKYC"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-oN37aj97kEWbdmr8wKYC
Content-Type: multipart/mixed; boundary="=-E2d7vQlxz5xyPEOqJ8T1"


--=-E2d7vQlxz5xyPEOqJ8T1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-01 at 13:44 +0000, James Hogan wrote:
> On Wed, Feb 28, 2018 at 03:20:18PM +0000, Ben Hutchings wrote:
> > 3.16.55-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: James Hogan <jhogan@kernel.org>
> >=20
> > commit 17278a91e04f858155d54bee5528ba4fbcec6f87 upstream.
>=20
> You'll want this too:
>=20
> 8dbc1864b74f5dea5a3f7c30ca8fd358a675132f
> MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
>=20
> Its only tagged for stable 4.15 since the one it fixes wasn't tagged for
> stable.
>=20
> If you're going to select patches for backporting based on Fixes tags,
> maybe its worth looking for patches which are marked as fixing ones
> you've backported too.

I do that, but didn't look beyond v4.15 yet.  Here's the version of
that fix I've ended up with for 3.16.

Ben.

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. ... I realized that a large part of my life from then on was
going to be spent in finding mistakes in my own programs. - Maurice
Wilkes, 1949


--=-E2d7vQlxz5xyPEOqJ8T1
Content-Disposition: attachment; filename="mips-cps-fix-mips_isa_level_raw-fallout.patch"
Content-Type: text/x-patch; name="mips-cps-fix-mips_isa_level_raw-fallout.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJuZWwub3JnPgpEYXRlOiBGcmksIDIgRmViIDIw
MTggMTQ6MzY6NDAgKzAwMDAKU3ViamVjdDogTUlQUzogQ1BTOiBGaXggTUlQU19JU0FfTEVWRUxf
UkFXIGZhbGxvdXQKCmNvbW1pdCA4ZGJjMTg2NGI3NGY1ZGVhNWEzZjdjMzBjYThmZDM1OGE2NzUx
MzJmIHVwc3RyZWFtLgoKQ29tbWl0IDE3Mjc4YTkxZTA0ZiAoIk1JUFM6IENQUzogRml4IHIxIC5z
ZXQgbXQgYXNzZW1ibGVyIHdhcm5pbmciKQphZGRlZCAuc2V0IE1JUFNfSVNBX0xFVkVMX1JBVyB0
byBzaWxlbmNlIHdhcm5pbmdzIGFib3V0IC5zZXQgbXQgb24gcjEsCmhvd2V2ZXIgdGhpcyBjYW4g
cmVzdWx0IGluIGEgTU9WRSBiZWluZyBlbmNvZGVkIGFzIGEgNjQtYml0IERBRERVCmluc3RydWN0
aW9uIG9uIGNlcnRhaW4gdmVyc2lvbiBvZiBiaW51dGlscyAoZS5nLiAyLjIyKSwgYW5kIHJlc2Vy
dmVkCmluc3RydWN0aW9uIGV4Y2VwdGlvbnMgYXQgcnVudGltZSBvbiAzMi1iaXQgaGFyZHdhcmUu
CgpSZWR1Y2UgdGhlIHNpemVzIG9mIHRoZSBwdXNoL3BvcCBzZWN0aW9ucyB0byBpbmNsdWRlIG9u
bHkgaW5zdHJ1Y3Rpb25zCnRoYXQgYXJlIHBhcnQgb2YgdGhlIE1UIEFTRSBvciB3aGljaCB3b24n
dCBjb252ZXJ0IHRvIDY0LWJpdAppbnN0cnVjdGlvbnMgYWZ0ZXIgLnNldCBtaXBzNjRyMi9taXBz
NjRyNi4KClJlcG9ydGVkLWJ5OiBHcmVnIFVuZ2VyZXIgPGdlcmdAbGludXgtbTY4ay5vcmc+CkZp
eGVzOiAxNzI3OGE5MWUwNGYgKCJNSVBTOiBDUFM6IEZpeCByMSAuc2V0IG10IGFzc2VtYmxlciB3
YXJuaW5nIikKU2lnbmVkLW9mZi1ieTogSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJuZWwub3JnPgpD
YzogUmFsZiBCYWVjaGxlIDxyYWxmQGxpbnV4LW1pcHMub3JnPgpDYzogUGF1bCBCdXJ0b24gPHBh
dWwuYnVydG9uQG1pcHMuY29tPgpDYzogbGludXgtbWlwc0BsaW51eC1taXBzLm9yZwpUZXN0ZWQt
Ynk6IEdyZWcgVW5nZXJlciA8Z2VyZ0BsaW51eC1tNjhrLm9yZz4KUGF0Y2h3b3JrOiBodHRwczov
L3BhdGNod29yay5saW51eC1taXBzLm9yZy9wYXRjaC8xODU3OC8KW2J3aDogQmFja3BvcnRlZCB0
byAzLjE2OiBhZGp1c3QgY29udGV4dF0KU2lnbmVkLW9mZi1ieTogQmVuIEh1dGNoaW5ncyA8YmVu
QGRlY2FkZW50Lm9yZy51az4KLS0tCi0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvY3BzLXZlYy5TCisr
KyBiL2FyY2gvbWlwcy9rZXJuZWwvY3BzLXZlYy5TCkBAIC0zNDcsMTIgKzM0NywxMyBAQCBMRUFG
KG1pcHNfY3BzX2Jvb3RfdnBlcykKIAlqcglyYQogCSBub3AKIAorMToJLyogRW50ZXIgVlBFIGNv
bmZpZ3VyYXRpb24gc3RhdGUgKi8KIAkuc2V0CXB1c2gKIAkuc2V0CU1JUFNfSVNBX0xFVkVMX1JB
VwogCS5zZXQJbXQKLQotMToJLyogRW50ZXIgVlBFIGNvbmZpZ3VyYXRpb24gc3RhdGUgKi8KIAlk
dnBlCisJLnNldAlwb3AKKwogCWxhCXQxLCAxZgogCWpyLmhiCXQxCiAJIG5vcApAQCAtMzc5LDYg
KzM4MCwxMCBAQCBMRUFGKG1pcHNfY3BzX2Jvb3RfdnBlcykKIAltdGMwCXQwLCBDUDBfVlBFQ09O
VFJPTAogCWVoYgogCisJLnNldAlwdXNoCisJLnNldAlNSVBTX0lTQV9MRVZFTF9SQVcKKwkuc2V0
CW10CisKIAkvKiBTa2lwIHRoZSBWUEUgaWYgaXRzIFRDIGlzIG5vdCBoYWx0ZWQgKi8KIAltZnRj
MAl0MCwgQ1AwX1RDSEFMVAogCWJlcXoJdDAsIDJmCkBAIC00MzcsNiArNDQyLDggQEAgTEVBRiht
aXBzX2Nwc19ib290X3ZwZXMpCiAJZWhiCiAJZXZwZQogCisJLnNldAlwb3AKKwogCS8qIENoZWNr
IHdoZXRoZXIgdGhpcyBWUEUgaXMgbWVhbnQgdG8gYmUgcnVubmluZyAqLwogCWxpCXQwLCAxCiAJ
c2xsCXQwLCB0MCwgdDkKQEAgLTQ1MSw3ICs0NTgsNyBAQCBMRUFGKG1pcHNfY3BzX2Jvb3RfdnBl
cykKIDE6CWpyLmhiCXQwCiAJIG5vcAogCi0yOgkuc2V0CXBvcAorMjoKIAogI2VuZGlmIC8qIENP
TkZJR19NSVBTX01UX1NNUCAqLwogCg==


--=-E2d7vQlxz5xyPEOqJ8T1--

--=-oN37aj97kEWbdmr8wKYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqaw+oACgkQ57/I7JWG
EQnTTw//at5KPOxQTDdqwPUhet/lMJShK7iWh+879PcE+FREUIkQZ6/fMHpFoCko
PFuGJcEGEnm84adLjtKRyjiRmAzQ1NhBLs21ax/OgsSDdmpkTrGb/Ve+AAIGOF5g
n4YL+Kh3GQQ2nJ3G+x7c0oLtXtuMET5pKsMoGvlTtZz21tqxC4E8nYZp7JU6z89Y
Ii7m6D73sGk/bb4PEYAmgDB67pPD8+l35a9GZiIVqZUsGdRvLqMExBx1ftfmRDaA
nWJSZHvQpjO9R1CMDIfIAik5pXVu9vSOQmbTj97/BPr8zsra//F95xWo1X66ZJ1k
cu/99kYXiclW6K01zM8dgwqxw2CWU4qjj33p8W+YLT9vcDtZMSKdhmK6OC3gQEgm
AcOsbVWcchJOYI0pTAZkTEI5skXjD/SgyCYPhxYodG1ZewLkPQ6zPr59yTL3bgls
m16hyWM2soxWFj8XRwjtDo5NV4xG8ZFeXuyclAXaMLZok61xErnpdX/lQDsAHr/f
BK3rGmRjnrUh6XOV9ph4caYcYA/6OSPpw+hmE7FD7AdsbeTPdRt7pOYLAtbQTABm
gyIt+ZqYjuULCt3LOr6f9MNhqcC+2pQiKXPD0vYTpfiM0o/eo2Am8b4x8K4Y9r/T
Tf4Y8df9nu6P1XwVECGrrMCLWJpyqrFjwRI0uiPURma2t8KocvE=
=nBmL
-----END PGP SIGNATURE-----

--=-oN37aj97kEWbdmr8wKYC--
