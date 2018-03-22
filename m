Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841162-1521757289-2-10600966794892762228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521757289; b=riIKxzRzC49wRi/IkTRg68Of8kPznyRy3Ie2zxOWJgJ7dYi
    amnISxLQBuRdFZox9lmISn1OYWnPStAxzvQmmhdgEO+sqP42W8yCFoFKKrIlmMMM
    9V+gMv5CpaL7io8LKoNM32fr1DMhZmLTr9fThC+kliUg9L6YoZIE2W2BawLGuOzs
    ZSKMre7kdGuui6HiDXWGJyNbCYfUnd5+j1f5VZ8emdwoJ/VpzGGdDJxrAnmIfaxm
    tV5P5ImzbVGlIP4zXC1jLqLAJaD18aQfeb7kwjHahLk8JQXFqjiD4c8GqEAr/Q6j
    xJc3GBZeUptANpGNKI/zcTFqt5s8hJ1va6mCZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521757289; bh=oilQoWjz2zoSNG71uKFtBPp+If
    2CgjgKwfS3OeDeY5E=; b=NpVjGtPGjT67zCsgBYgzWZCIND2F1e6+HFcZkLtyxF
    SPwNvOVOCBzPzIuOC1fIdtbzJV99161uNjggh39XoYbAxrR8fYLV+H3AfRE4xkgD
    x3TrcDTbhKmTNZH8qfgicPD77VSbccZhi1RhmCCmaYljqepN9RZPXsmRtNEa4JrH
    S2tKW1qqjf2XW5Tu1nru4dOR8G9R6X80y4xXTRtzY8bN3janI0j0fcSg+Np5vA8s
    Mk7/KtMvDxmCVzrBRXBxfDh9VHteiJx2gtBXBKaHRkW6ysOVF4ryYfjcEXZx4Drc
    4acJ/CUz1Y3YH4jElwTUxZFNFHVqiYUn4wRCzO1o4omg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCVWVQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 18:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbeCVWVO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Mar 2018 18:21:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3F21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Mar 2018 22:21:08 +0000
From: James Hogan <jhogan@kernel.org>
To: Huacai Chen <chenhc@lemote.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180322222107.GJ13126@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 03:55:16PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/comp=
ressed/decompress.c
> index fdf99e9..5ba431c 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -78,11 +78,6 @@ void error(char *x)
> =20
>  unsigned long __stack_chk_guard;

=2E..

> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed=
/head.S
> index 409cb48..00d0ee0 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -32,6 +32,10 @@ start:
>  	bne	a2, a0, 1b
>  	 addiu	a0, a0, 4
> =20
> +	PTR_LA	a0, __stack_chk_guard
> +	PTR_LI	a1, 0x000a0dff
> +	sw	a1, 0(a0)

Should that not be LONG_S? Otherwise big endian MIPS64 would get a
word-swapped canary (which is probably mostly harmless, but still).

Also I think it worth mentioning in the commit message the MIPS
configuration you hit this with, presumably a Loongson one? For me
decompress_kernel() gets a stack guard on loongson3_defconfig, but not
malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive to
the compiler inlining stuff into decompress_kernel() or something such
that it suddenly qualifies for a stack guard.

Cheers
James

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq0LFMACgkQbAtpk944
dnrmTQ/+JqSPbejJsFyxpccmWIyLBtYPujNEeohQv5ZthOfaooKRy7NvUQqirXxG
HKpHT1EqQtZsXxir/BZxdpo0rN+M/7kMWU9XKLtFqkiz88k1i+k4o7dlrdQcZOqy
HFBPtJnkchJrgBxxzPNxmHnWCxOFoYbK2HBxsn0cBGDm9sgLgXPkMwkAk29fG3uT
ViYFSUhnlmNAo4GBgUkxSFK3rDZZQWq7DFHaMrTEKeJo0SdLtmCt7YD25grSOp0K
klBR1sdHe+oIXQAcowD3xdsLNSNeRoRgtan2Y6ByBLs00+dE7A6D8buruvohh/m4
B37/oeHOEg65kmOVVSnhseaW92YfUyBEkGosJHgV0a9/BoNeN8r1deLgKGb/VYCC
bzOiN0pTzDzPZXvIsWEKibOMrrcm/2Et6Gkh4VawwFEKXZ2ZQAkvwUXFvBjXFwuq
3/V3+bLsrS6mdkvDGe3HcqNEdRhGcjt9uISxGhQtPe30aK9EgtTYH/Ol9GNe/R2l
b/1eEo5RGf0FAko1+xeE81q+xAUPoR4IECl5wj9LQy/KEP7rBSSJj2Ixxl2YMZGg
osFHqfdRh1ihHViu8OMMsT0/qTCH/H953rgGZySpK4twyChK92FMfF2uO7z18NHC
uAylLlojOuGKA0t6HsAEuB64oWg3HV2bYGu1p1yQK5XolLuLrWk=
=1hrp
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
