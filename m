Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2645272-1520027839-3-13419392769046642006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520027838; b=T4w8G1bm/ZCDZUlG+eQSb1/w8l85UxbaBJ8/KYIVXCove/H
    nsGV8MZ0LVGaPSyVbY/gM1ujpC3Tl8RICzU44b0cy0vsEq2dlCX72wYDMy3Rc5Aq
    5baV5TWma89FbcekNhdEOLXXnzWU7lkCMtaIQ2Cde9XA1U8E7BK6NCmelQ4ObAnv
    TjBp22XweKT/iXmwA7XV7rsW6+GXqVcsneKs1bjwpceudUF5SmdcHMvivAg4UQ72
    xr/O4DoeM1xCM77yKtpL9RwhhPrSPac0iyJZCzH0X74YNwAjwE3otsF+9gBvo6WG
    vCix4ZAfAWoWNT5JetQF5iI1zfQmje+xVWOTvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1520027838; bh=CsVk+pTf6NoIpbq1yrGitKfpkrG
    UBLGMCQBEEaUY+VE=; b=o+nga1g9M/LO8MYmtBZAUNXgV7thGyoBIX/TH3B6hx4
    eHvQvklEtE72ltLjqIR9VJSTtB9TsXwGZspwj1JR4NOzihckFXREelmIw4oOm0y1
    JriL6i44RMGip7pr6bWi9COTtnVeyGoo3W/uqqI2AJmTlOWboZOsuNF8DvcQEAoX
    fVP3aGHVRmrlKjGNu/QgxbQtSOzlBxBaekKg8y5EvGaVkBQuwntrGucOtL03KSBG
    KsfJyGhFg5Gjre/XMt+lU4vC8VT8n/Xa16zTvnDrpbTOtE6NWYknreCZxRSZusQp
    yxaETsdTS/ydtHmK5PAsmqxWtQ0MdXoV8OUD6dFwAMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2558B21725
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 2 Mar 2018 21:57:02 +0000
From: James Hogan <jhogan@kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <20180302215702.GD4197@saruman>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: mark.rutland@arm.com, linux-mips@linux-mips.org, peterz@infradead.org,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, y2038@lists.linaro.org, mpe@ellerman.id.au,
 deller@gmx.de, x86@kernel.org, sebott@linux.vnet.ibm.com,
 jejb@parisc-linux.org, will.deacon@arm.com, borntraeger@de.ibm.com,
 mingo@redhat.com, oprofile-list@lists.sf.net, catalin.marinas@arm.com,
 rric@kernel.org, cmetcalf@mellanox.com, arnd@arndb.de,
 oberpar@linux.vnet.ibm.com, acme@kernel.org, jwi@linux.vnet.ibm.com,
 john.stultz@linaro.org, rostedt@goodmis.org, tglx@linutronix.de,
 ubraun@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com,
 linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, hoeppner@linux.vnet.ibm.com,
 sth@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Content-Type: multipart/mixed; boundary="===============9066815376597682018=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============9066815376597682018==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 06:18:10PM -0800, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
>=20
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

=2E..

>  arch/mips/include/asm/compat.h    | 11 -----------
>  arch/mips/kernel/signal32.c       |  2 +-

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZyK0ACgkQbAtpk944
dnriXA//fiy/M44auOl6H3L/Sttb1xadP44YPlJKIkOi6RRm+XDNJWeIyb2dB28g
vkHkEqeW5OX0Yz+YmbMULh8EAl6TV42LSMUcRcDNmI3GjkArQIEQ7T1E7BiwukFd
lclSwy3Fe9HwtZdLeKQuO+C8W4pZ0rUXZeQW+8A0TvNM1zAKInEKaAGXgxS7PcMs
7pZBbOcIGBg9sTWFPhU4N63bfMn095wDXupegwflrlB1JSTvFktFxc2E6c0JmIwm
ij9jNw3J/lUtGaMq2ynmbJQWr+/I1EFVe740bkdKYP2Q1ZdTybWR2FnnoP+cC6kF
hS49c68Enp1mSirYIqRidTc8YLALwUFpdheUUky1VUPSjBWee2BqZ83VrshoMvkx
DQTuUfxvlFdnCLF6xHl0Ock5g7QTzrne9rpvqGBge3sGp25RZ1RcJYAruNJ36u+C
9VP1Y284Sz40x76q77yLxC5rT3inAHQYO2c+ob/BnrKoSrMxfDrWYea1X1yh+x80
6qyZomlmDEu7OREVX2dnpkIG/0j2GvhQBtjYHAHjvTkmHho80Fe/GBZhObkQjnoW
xgm1BLteveq/IEGK1tY2MEqjNFgUjQn1/r72KrP1b7PMtmwHjkyaXljB/dEv5TI3
tEttVw3wzqGUWmbvyj7KZcpv/BQUx/Otrqh/zGMnC30U53Lzrzw=
=PkCk
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

--===============9066815376597682018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============9066815376597682018==--
