Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1343005-1524088966-2-1972737106972181016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524088965; b=Qo1CQG+nSFmghh/FZmg7CZ5O0fQ5A9N9kTtB+PZ2uQpMBFb3F8
    7PvRNJmztD/LiB1nCC/9mBdKceUsfq/DOZtzxPn5LJ2VTY58JJCfWPyyV5o6f+Lc
    BPTZzi7uynKOrc8NJH4fwdouSq6IDaCpdHc20GiB78cIfv5UhzHmP9iMEwZ8D2Zw
    L4yWSfT+WylYQwBqQENbw0Q7gp1Svo9bjCIU3ZSgg4lM1ksK/CAmXT9XDkGWWa1A
    lSZe9rY5+UxaDMDeH5VbZxz6NO/4SgMJhoQ13lOVHpsXFseGIiz58WgiXV24ld6p
    P4zv4wjf7TmdUpsrnMMViL1nS74OmGwjOXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524088965; bh=UvKLgNkLu594Xb89c4GLt/amkA/VTk
    oCL3u/RdFdz70=; b=BYZUgXbpKDo2CwgqLthDvStgyXbPH24bmblXE/urQmrctD
    1gH5bc7Q3QtLix4JAsZNwqZasZH1YoWRMftMJUrqqxK0QIwXiUCVRB/JuAC+3jDK
    If7aV0WcT7VjzQ0Bj4xxTUoDsjKdk/wx+Lnyb9YPBhCC6U+iOfzZeLiBpDMVyeRN
    c+BquwUz+qVq6DXM+e8xTeVGGcBdMrhBA3pJR1/2O1yQcRT/c/Rv2umA2olFBgDh
    YdCL8NbuzETL9iTT+/ehLv4w10BppKFNr6Vd4cyuSYIFew29dfE4DtJqvwUWZXR2
    e7EfyYN95d8qeSyFeBDFPLUy9Pj1reUkp135VDaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOVLnKfCVEa9/N9n7HaMO8iNViIhCFmRA818tAXuEjXPi5mrnzK6yqaEFGz03LS/3FEiNscBlkS4KKfd859ztjtkrooJV4x24SJwjpzK8uP34pcdh5Nk
    memYNcKD53oc/oCiUIwD325Rh81gKATqbFost7j3Z0yjoSzZkrihuyzkGcKBvlmrVt98BgwKoLOPYOJf73p4ZcvySMyZEiKDnonZfhB1yw7xQhlIjOgxzTAH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gPJu0pBYAAAA:8 a=MQI6Y0egzowl_ClwRrgA:9 a=QEXdDO2ut3YA:10
    a=nexa93dvyXfkjgvsf1wA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDRWCn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 18:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeDRWCm (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 18:02:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1549321781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 18 Apr 2018 23:02:37 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] MIPS: memset.S: Fix clobber of v1 in last_fixup
Message-ID: <20180418220237.GC16439@saruman>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 04:40:00PM +0100, Matt Redfearn wrote:
> The label .Llast_fixup\@ is jumped to on page fault within the final
> byte set loop of memset (on < MIPSR6 architectures). For some reason, in
> this fault handler, the v1 register is randomly set to a2 & STORMASK.
> This clobbers v1 for the calling function. This can be observed with the
> following test code:
>=20
> static int __init __attribute__((optimize("O0"))) test_clear_user(void)
> {
>   register int t asm("v1");
>   char *test;
>   int j, k;
>=20
>   pr_info("\n\n\nTesting clear_user\n");
>   test =3D vmalloc(PAGE_SIZE);
>=20
>   for (j =3D 256; j < 512; j++) {
>     t =3D 0xa5a5a5a5;
>     if ((k =3D clear_user(test + PAGE_SIZE - 256, j)) !=3D j - 256) {
>         pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 25=
6, j, k);
>     }
>     if (t !=3D 0xa5a5a5a5) {
>        pr_err("v1 was clobbered to 0x%x!\n", t);
>     }
>   }
>=20
>   return 0;
> }
> late_initcall(test_clear_user);
>=20
> Which demonstrates that v1 is indeed clobbered (MIPS64):
>=20
> Testing clear_user
> v1 was clobbered to 0x1!
> v1 was clobbered to 0x2!
> v1 was clobbered to 0x3!
> v1 was clobbered to 0x4!
> v1 was clobbered to 0x5!
> v1 was clobbered to 0x6!
> v1 was clobbered to 0x7!
>=20
> Since the number of bytes that could not be set is already contained in
> a2, the andi placing a value in v1 is not necessary and actively
> harmful in clobbering v1.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: James Hogan <jhogan@kernel.org>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks, Patches 1 & 2 applied to my fixes branch.

Cheers
James

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrXwHwACgkQbAtpk944
dnrHag/+IUrJMlxzFTrTonbr0bNVombMS6zD7ZSDJ/bBAJnm6Y4xE4iTFXOVISXS
F4LVlo3zwJNwzTIrjXCb1tMgZPNeqeYykVZ9xyotAtriPQAFcfGyISeyhkTxwb1o
B5yXVcpEHdrZIf0QYD5SyAFlUNXD7nDFq421UmdXtEnzNp/6Wgjrak5oGjyNRhu8
1ZiWmL8BlH/Qh0gVSj2RnAsX9VpNkJJ7jWqm52xI32uqU4njbz+iTLt8Y9ulypVO
kuArCI3CWgmi+2ABT1xnvil6Vdi/gRW2nH4NzMxJCtMd4NQju88+YnJwMjO5ki9A
fOOdzi5C5pm0+ArxnMvfjZR+7JOf7x/c9VAqJdMSiNGCY/FnLMdwMqcZ2B+FEG9q
HMMDDizsi4PdCXICHEAREMnDhrSTlUMi+u2ib/uMy3EKuxYIKLIt6Fe7ONe3T+Nh
mBMTWs2zzrG6VkhAB5MBD5ksoSw9/uoHFHysJkKzptNeE8sp/0EqLFl7erWk4Ivm
5YH120f8YidC75fNCR6dXdhV15ejPScrwdo1jkEGginVP/rK7WR8LZPjbl8RVRnl
HX8qIL76bR8ThEHVopBaY1JhurkmFxaOfrPpMsw4DEMkf3EQgNAW1dBT/lAI6djh
BxFZ4jpQA3k4V0+8xOAUi+1EUaGAVKUcuiafdOcO8+Dyg10jQPg=
=S1hV
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
