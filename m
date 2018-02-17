Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2837347-1518874327-2-10906381004054685902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518874326; b=H3A8NXk0fI8uu74Y/FKoU4L59NrO8ic+ghcniZlipcrXxuf
    WzsuPhuCkPQyVPo0GJmpTLqRDTQA4Vq4wAfK67AL32izodxFgpZFB2uF6wXGJYio
    7hOuK7a2zQlOdOopg1kVdldMUfdtViqksI7kNZX1ylj2j3NHimZq6IV/YciY1pkw
    DC0soYyDJPRjDDE+juGa/TiYH8kWZLlmQoEGYIq7+XZDkOpImi6hZq/TeRFNTtcL
    g4evzybYhvKma/WeC5IXtlW1lDXQA8doGPrsprYcNaf5mL/QTlh6P8tnuEhrrWDZ
    fYnd7FmYeHBcIhjwhZ0US3+Gyn0PYb3V3wseOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518874326; bh=aO2k/COeTw3StOSfTfggze7DyZ
    4OUD3Vn/mUDrTTqV8=; b=d0rm0GdHZ1KjgzOfL/0wrncL8bnhk5N+PgZa6E8mvr
    67MaK18nS7uCvlilqwWNjXifI17f1pv28n1kTYQReggheIJqjGJiYg1gnmXZh7/I
    w6t8Xnf1348o58xCPgd/CUP01hURltcoNpNlvKdQP9Na4T2qGcFtYr4+WULvHNiQ
    TcpvVwZ2GquBgHsup/gmFBbLOXBRoE1msS4q+k3XcTcx8t7CjYznwKJSkHCLdRHM
    OsiiMI9yYRww8O84P9F4QZrSomJnExrPWtYbc4Jt2aXjFgTQDdJQgIU+GdWQlMfK
    Fi3Q7zxwzbwK9IymrrQE0N5W60FJ2Db0Dx+AvaIxB6dw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeBQNcD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:32:03 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:48182
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbeBQNcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:32:01 -0500
Message-ID: <1518874313.9465.1.camel@debian.org>
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
From: Yves-Alexis Perez <corsac@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Date: Sat, 17 Feb 2018 14:31:53 +0100
In-Reply-To: <20180213152907.GA29190@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
         <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
         <20180213093651.GA29675@kroah.com>
         <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
         <20180213152907.GA29190@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0KqWLJlVAKpEBp3rXTfU"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-0KqWLJlVAKpEBp3rXTfU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-13 at 16:29 +0100, Greg Kroah-Hartman wrote:
> > arch/powerpc/kernel/entry_64.S: Assembler messages:
> > arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to=
_user'
> > arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to=
_kernel'
> > arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to=
_user'
> > arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to=
_kernel'
> >=20
> > Looks like 222f20f140623 ("powerpc/64s: Simple RFI macro conversions") =
is missing,
> > or at least part of it. Unfortunately it doesn't apply cleanly.
>=20
> Ugh.  Let's see if the ppc developers care about this or not :)

Hi,

in Debian we extracted the following hunk from 222f20f140623 to fix build o=
n
powerpc/ppc64el. Only compile tested against Debian builds though.

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.=
S
index 3320bcac7192..e68faa4d1b13 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -37,6 +37,11 @@
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
=20
 /*
  * System calls.

--=20
Yves-Alexis
--=-0KqWLJlVAKpEBp3rXTfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqILskACgkQ3rYcyPpX
RFvvjAf/VxMUQwjDQ73vuuniDP1a3g1jx5/ee0eqKhOHYV/hdyM2NYKqLxZL+QHg
3itjEEWrORgrapE7SH8h3DMD+SweIx6xt683QwTuHgFGNM12z9Y2K+OCoPPySQvS
3SbPEddn62NRpaMeNIT/ph3yO7NF4t3kWPIVuWnV1/fu3iJxkiSeCNEm0ixPUHG8
quzmBNG+rUzQubR4UmywDsTSRtmi5uUkU/e/U95LVFkhaSj5xjCif14vpUhdFj6J
BvHlbmzcXJZk/h+zKc+scdPjIkT/2avFNgbJqKlYzj5lhBLs1dBJKwrC0umj2DNX
ujtaWmxMJotR9Gc3gZ+Rhn26LFtuFQ==
=fYC5
-----END PGP SIGNATURE-----

--=-0KqWLJlVAKpEBp3rXTfU--
