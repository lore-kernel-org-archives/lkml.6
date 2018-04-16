Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-59205-1523916830-2-8198363932814428499
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
    1523916829; b=ex/9BMr4g3BhKcT6Tp8LaK+Ln5qqn6gBw9MDtdLq4/zbMZQCkv
    VYWGXUCkjwLvFmthks4CoSL/coIldtZM/wUvWhgfFbQnDgy/ddKaF+AD9Yzvoqzr
    q72BwoVUjvXH6ekamLEb2vYWISpg+V/hmwtMVG3dKDvtOt9zdHq8zFQ5krOnbguh
    UKO9zzPSgPlXRKz56fx2fjLtjDRTDndBcxqzHdSFgvRKAulolFUND7LBHCCZfGrY
    0A9jprwcKYKSCWQOJ79rBAvMPZPVGXGtWPD8f+m0tOeC8L9ZDYWgcXNpAKxgKGnh
    3We/+bV62IUGJCDOJHsC7ODUKP0gkGZ/kDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523916829; bh=/Knlm0w68UDNp2zGLh09tC/DXsI+16
    9jlmtMcU7G1bo=; b=tjixbKrHUh35L5IHUlbOoki5uUqgnHd4DIgMP2eURn/+RB
    5X6MoX6KCnVb58voxTo9rrN4LL/sMA7vhwJYOp/gPCantZ4PFP0qJx5/rOI24tdE
    1LtpuSx63Ac66KT+KUZHmcmNJbZyLfW9Q5Rt9QbLXwWJg4zsJe78qzUvj949jpza
    3E8+Vi0xptwHY7hLh6iN9AkdpAv8pf0StzBvFN7Ly/bX6yI03QsjH/r65HIDiGDA
    Y7QsBqEYneJo81CN9F2zAz/uj6WnH/f445UtJ0je751lZ/EWytPgSQYwBOH/9IDy
    tIccRdBoqTLl6XsEH1KJ8jY4yuzl4P8GyG8zgArQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKRnEUq/h4i3puln+4wj6ClHIpWSV4u458JizWhSIEUZb096g580aRs9JmD3mgYihOWEoQ82in3gCZXjUZCAIxdb00IjcShYUtAudGGvWO+KycRSdD5P
    qv3+9PvUDyUNEVqqATKGQu33tB64rJY2/osdZwSufRO6el50IU0Og1JR04hmiEUJ1u6BjOvvE/wQTwG6vx/bFcar1fr+51usIbbKRESbyqfB6JbQOlVew4e1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gPJu0pBYAAAA:8 a=iJ_x4Zt9K4rsyGMr5yUA:9 a=pcSnq7Xa7S2jeXSN:21
    a=ZoyHpiFLfRl_KD00:21 a=QEXdDO2ut3YA:10 a=e_Phi0nzZFp2ly9XcTEA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeDPWNr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 18:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeDPWNq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 18:13:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 16 Apr 2018 23:13:41 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: memset.S: Fix return of __clear_user from
 Lpartial_fixup
Message-ID: <20180416221340.GB23881@saruman>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 10:28:24AM +0100, Matt Redfearn wrote:
> The __clear_user function is defined to return the number of bytes that
> could not be cleared. From the underlying memset / bzero implementation
> this means setting register a2 to that number on return. Currently if a
> page fault is triggered within the memset_partial block, the value
> loaded into a2 on return is meaningless.
>=20
> The label .Lpartial_fixup\@ is jumped to on page fault. Currently it
> masks the remaining count of bytes (a2) with STORMASK, meaning that the
> least significant 2 (32bit) or 3 (64bit) bits of the remaining count are
> always clear.

Are you sure about that. It seems to do that *to ensure those bits are
set correctly*...

> Secondly, .Lpartial_fixup\@ expects t1 to contain the end address of the
> copy. This is set up by the initial block:
> 	PTR_ADDU	t1, a0			/* end address */
> However, the .Lmemset_partial\@ block then reuses register t1 to
> calculate a jump through a block of word copies. This leaves it no
> longer containing the end address of the copy operation if a page fault
> occurs, and the remaining bytes calculation is incorrect.
>=20
> Fix these issues by removing the and of a2 with STORMASK, and replace t1
> with register t2 in the .Lmemset_partial\@ block.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>=20
>  arch/mips/lib/memset.S | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 90bcdf1224ee..3257dca58cad 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -161,19 +161,19 @@
> =20
>  .Lmemset_partial\@:
>  	R10KCBARRIER(0(ra))
> -	PTR_LA		t1, 2f			/* where to start */
> +	PTR_LA		t2, 2f			/* where to start */
>  #ifdef CONFIG_CPU_MICROMIPS
>  	LONG_SRL	t7, t0, 1

Hmm, on microMIPS t7 isn't on the clobber list for __bzero, and nor is
t8...

>  #endif
>  #if LONGSIZE =3D=3D 4
> -	PTR_SUBU	t1, FILLPTRG
> +	PTR_SUBU	t2, FILLPTRG
>  #else
>  	.set		noat
>  	LONG_SRL	AT, FILLPTRG, 1
> -	PTR_SUBU	t1, AT
> +	PTR_SUBU	t2, AT
>  	.set		at
>  #endif
> -	jr		t1
> +	jr		t2
>  	PTR_ADDU	a0, t0			/* dest ptr */

^^^ note this...

> =20
>  	.set		push
> @@ -250,7 +250,6 @@
> =20
>  .Lpartial_fixup\@:
>  	PTR_L		t0, TI_TASK($28)
> -	andi		a2, STORMASK

=2E.. this isn't right.

If I read correctly, t1 (after the above change stops clobbering it) is
the end of the full 64-byte blocks, i.e. the start address of the final
partial block.


The .Lfwd_fixup calculation (for full blocks) appears to be:

  a2 =3D ((len & 0x3f) + start_of_partial) - badvaddr

which is spot on. (len & 0x3f) is the partial block and remaining bytes
that haven't been set yet, add start_of_partial to get end of the full
range, subtract bad address to find how much didn't copy.


The calculation for .Lpartial_fixup however appears to (currently) do:

  a2 =3D ((len & STORMASK) + start_of_partial) - badvaddr

Which might make sense if start_of_partial (t1) was replaced with
end_of_partial, which does seem to be calculated as noted above, and put
in a0 ready for the final few bytes to be set.

>  	LONG_L		t0, THREAD_BUADDR(t0)
>  	LONG_ADDU	a2, t1

^^ So I think either it needs to just s/t1/a0/ here and not bother
preserving t1 above (smaller change and probably the original intent),
or preserve t1 and mask 0x3f instead of STORMASK like .Lfwd_fixup does
(which would work but seems needlessly complicated to me).

Does that make any sense or have I misunderstood some subtlety?

Cheers
James

>  	jr		ra
> --=20
> 2.7.4
>=20

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrVIA4ACgkQbAtpk944
dnoWXBAArNfISUljj95eR82szfld+rgWP02B0CaLUr5ejxZxOUMvnfejNuBgSzy3
laUh6DnqSGzctNW3thqWf8h2gza59gkQQiRwQqsLiKCoAhSBW61diHULCOz/iFu7
DiLvZyZLVgsqai/ViX+r47OqdKiOXtNHC34oTKl7oUCGVQ0XASJ/320X/hDKiHFO
sewfLn0ml781THlksW5bTMpAQFwCcZS4qda8T7dAlfpm1uZu1Tev/fwQZrxTwpUf
E8pRyuagFkyZMe9a3OXWzahk8kakqhucYcmvAWPWtgz/Q0ue/hBtH8JKm07W7Fql
dBFEkNM8NE0RSQsEqBhCs7rhxw85owtDjpZz4XQB80Al1zpRUgDlVgSJxPypDvia
gGmqKT5gOPo7v2+KWkdizF0bF0nfRrgz+Y2LVYdEdCFDGpWFe6qt8Tny5NdxlNFQ
pHNVGSJSnHCKxXHzoSM0IqpChuVL2LgqdILwlE837vjTxRwnn5UuwPsmN+TmoA7O
7T+Xs870vZW/B/u+/wMjtjeezkEHU+BCnB4HgOqhpnFM3qPAMW12/1TsUGWt1l5y
TADIRkp92dOL424FM22JLis0Y8ll8Iacys/5mwYy/XC+BKsJSl4XYOXdT44tgIJi
62rQ4IoBp8c3g4UKObxxjP57y7Qh161cOUNVulk2CCnQkxdtZkw=
=w2/e
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
