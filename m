Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2532849-1522250501-2-5993091691601611032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522250500; b=sVANuu9nE9hvyBKKIsFfF6cWeKjWXoUMbCSnt60e9BxVKg/
    ZrLRIFT8zlK8G0WBg7K72ZGDuDM65xTtP1J8GDhwSKTsVLr0v5C08wogXDi4VR2Q
    8UjhLnAilZREC0+WBoNQCohDCogo54U/nGPCRPMgzx+qcI9F7zKLyL5JZkW5d+HH
    lH/Mt4gnnSfQCkLo/5S1C6VtoKZatLWc/fJg7oyQ5ifS3mGmQ/0SRVavCVGH1eMW
    POq1ILgilVXGrS0y0fuAMfkfeEIvCCjPpJqz1vVeq1rcaYKnMsWkQqXej4HGYLE+
    hCQdALZlZeDhpd/cRxBKgQHVnz18WXAck6WRGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522250500; bh=QZ3e8WnuQry4oOvXj3lo2vBZjp
    u74P4AhDs1NIBl1mY=; b=Qw4ZukCngY+GvadQ/oSogplHuuV8y6Pp2NIlat6EBP
    ecBqFj9gaL4UnP3jE1AFCKJ0J1MJT10XpP8Z0fa3LL2qE6pL5FQ43aNW7qnnulda
    eIwMWri9dRM2RXrLn/CSGvUqDDbRmawe31NLTHYj4UewMS6tvrRhWtWOQagiIvKf
    2JxKKdowOZ4KBaFdbGmcV2SSQMtD2BHK16s0LVz2xnoCWXOd/GtweTC/tPy/cRSf
    XLZMwaO854ViTKgE0cZdOVvLKtP9kMEuws2+ovTqUvpUgvylx2gBWGah7VYSJPaa
    w9VEWOVImyuZOtL7burxPKJlDQfioGsH0xPdvE8TcCEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfI1TeTeJd3uVOvTH6dk63aTGvPeAkZQsD/6laJiSDyV+Zq8N+dfpaqudNBO4n9ESuM16q+wOhPex7WOPw5OJC7jPPbH3A5d6lD2VBb2qdZvUiaZMH/0M
    QBxVqfNjj9rggPfaYIx8dgtCmvnZLhcKadeVDbBC9/9GoZsqQDSPmN78rqx4ivJjGik1mpXk0YLOs7C3Mzx9kBJDlrV+VsLPNNBZAsAyToJmwnlypLD4E8Pa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=uaGTUJ2ghOM5Ok53uLAA:9 a=QEXdDO2ut3YA:10 a=4sODfgrOfYAHI7MaJNcA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeC1PVW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753611AbeC1PVV (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 11:21:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7752178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 28 Mar 2018 16:21:15 +0100
From: James Hogan <jhogan@kernel.org>
To: Huacai Chen <chenhc@lemote.com>, Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot
 phase
Message-ID: <20180328152115.GB1991@saruman>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/comp=
ressed/decompress.c
> index fdf99e9..81df904 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -76,12 +76,7 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
> =20
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard =3D 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard =3D 0x000a0dff;
> =20
>  void __stack_chk_fail(void)
>  {
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>  	unsigned long zimage_start, zimage_size;
> =20
> -	__stack_chk_guard_setup();
> -
>  	zimage_start =3D (unsigned long)(&__image_begin);
>  	zimage_size =3D (unsigned long)(&__image_end) -
>  	    (unsigned long)(&__image_begin);

This looks good to me, though I've Cc'd Kees as apparently the original
author from commit 8779657d29c0 ("stackprotector: Introduce
CONFIG_CC_STACKPROTECTOR_STRONG") in case there was a particular reason
this wasn't done in the first place.

Acked-by: James Hogan <jhogan@kernel.org>

(Happy to apply with acks from Kees and ARM, SH maintainers if nobody
else does).

Cheers
James

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq7suoACgkQbAtpk944
dnrxJxAAlrAgDS3oDkev9n/dI09IAb5AGksi/hRV8rvWiOecvAyIYE7RG0rthOmS
0loNyQOkdrydZy5n4BUO+OxjV8UJQnGazAeDPM5/gOqHZiuouSPg8JvfspH9dbCP
MJ09R/ig3biJiSNRYlW8L+cD6Zo4Iy/aEfusc0i+cRAC2kHJDJe6D0XoXHYSk2mj
Vx9jj9GoLTROXwtMhYRjsFb1qTfKL5NBY+66zMPV2pVnsQoV8PSMftdYz1RCU/VC
iNVFI5/pus+YVNL2nTqhUXRQUNDvOGqMt08yk4P1gyMLPHzEUf3uKHn12pMYslI2
H+LGmfe8MdwVG+Mb554Y1di245/kGybclsAdqMUK1RtbzrfuDOYv6u8GAop/d6cg
gjgnHstbImtbIyTGcT4aY4ntY/HftPJ/s7kTbIdFZGV0Pkzi4aCOiJSVqO/lLX0h
FzM5sFf/YcGyDMw8zCDlL9OfRWImuzIn89xvwdsEtorZvtgI9syxPZSLU8fNNwAy
jmPMm6PC1l5i+BwfO0UJO2M0HtIO/L9P3a67xdjrWZbMAFfp3X6PEGs1fu5c3QV1
MJ6SF316yu1pOnIbqLImqsY4/DYnHkhT3/evZAA5n4/Rxz3ICp+8OKYEbGmmbXV+
Bv7VIDn2vv+MlmIVDYELo1v+LWmX833VssiwXcHPlSS7s4XjT4w=
=au7i
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
