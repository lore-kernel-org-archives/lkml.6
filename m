Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-342177-1523650949-2-13091876674503418248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523650948; b=R2n8ASZUMlpPRo4befEqCWizpfcrk6fZkrj1MuRdfzLCndXlL7
    y40mJmU24EzGewUUc1q+6dd1/hw8YAeOnc+SXxDyG+B08MVNzZxSI5Y818NMLvq9
    OkggUtPXNTq3rKZ9hp9vaykDUoW/dnodgGM92cnbYdQ6O53BzorTCXmGsxb3efUZ
    ePZGOFeYCw/sCYdMTyzWQycpgMKeqTU2lJyVMns5ulNV4vxJPrURef+L0K9Q96e9
    G4iTMy6cJJUZaWJAnDb8ljno8wuyKNsT8mNYsujRHUksMcN2fPm2bsjmbs+hZt2L
    +8n1vn6onTy8lYNVgSjThlCA5uBuRqNjnoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523650948; bh=sSJEzX+ja7u8zZ3pgH1CbXy0l3IOGQ
    B3BUOLcLIsNnw=; b=Mk2dLPUCRVZDftsX6TlrgUy8wmVw8QAdnAobAgwzCOS7Vb
    wQM+JEhD2DxP/5yE6IIqgAAb0FpZlCMXNpMgHAIEQd9FsE9vmeIQWQG6R65sDP0Y
    u5sdr2WE3yKHieh805YX5vaIKd3gnt3bx61ePdIY5Egk+oKPgkM/nItbvpPvZnHI
    y79M/jRENZnehY5Jrmur+zI9ZqzdDfVXUih0XwWdOdZuchKQG6/G81QrsJblG6/l
    lEdHv7oRrz67xKHBq6bU6InwJIpNj/rVNXp/wK6kx2te2Bg3E5pblzyzr5WCavF6
    w164xX0iH4innpD78h89PrpcKA2ig/PYnAvFP9Jg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAjs9QUwAVONmc399QQkQGsbwxvcun0wycCsQiF7rGPdbbM5KyjMZLE7IeiMA9JcqOTxorNlEPc95OOMgpn7z+K7BC6z80PEtrK2+Hx/SixBVZ/SDU4v
    rFtFrKq9VZO5fyHqApu9KyUZrCYLjpdISN3DZoUUkYe59ybJ3dTNNQUAx2e5eXxQ5R7MSPlL0IYEmrXHHU1rUzQmXND/KWxSNxzsn1jDQhELLAHbrepDQTT7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=CweY-4Qh09ot-4zdV5cA:9
    a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
    a=A0KAaL7CNxBlOqJRGXUA:9 a=ONNS8QRKHyMA:10 a=fUSZZkATYxXnQMecnGkA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeDMUW1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 16:22:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56715 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeDMUW0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 16:22:26 -0400
Date: Fri, 13 Apr 2018 22:22:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/24] Add a SysRq option to lift kernel lockdown
Message-ID: <20180413202222.GA4396@amd>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346389240.4030.11187964053014260180.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <152346389240.4030.11187964053014260180.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-11 17:24:52, David Howells wrote:
> From: Kyle McMartin <kyle@redhat.com>
>=20
> Make an option to provide a sysrq key that will lift the kernel lockdown,
> thereby allowing the running kernel image to be accessed and modified.
>=20
> On x86 this is triggered with SysRq+x, but this key may not be available =
on
> all arches, so it is set by setting LOCKDOWN_LIFT_KEY in asm/setup.h.
> Since this macro must be defined in an arch to be able to use this facili=
ty
> for that arch, the Kconfig option is restricted to arches that support it.
>=20
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: x86@kernel.org

Is that good idea? Magic sysrq was meant for debugging, not for
toggling options like that. Distros are expected to turn it off.

It also works over serial consoles etc, being able to toggle security
options from serial is surprising...

> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -487,6 +487,7 @@ static struct sysrq_key_op *sysrq_key_table[36] =3D {
>  	/* x: May be registered on mips for TLB dump */
>  	/* x: May be registered on ppc/powerpc for xmon */
>  	/* x: May be registered on sparc64 for global PMU dump */
> +	/* x: May be registered on x86_64 for disabling secure boot */
>  	NULL,				/* x */

What about x86-32?

> +static struct sysrq_key_op lockdown_lift_sysrq_op =3D {
> +	.handler	=3D sysrq_handle_lockdown_lift,
> +	.help_msg	=3D "unSB(x)",
> +	.action_msg	=3D "Disabling Secure Boot restrictions",
> +	.enable_mask	=3D SYSRQ_DISABLE_USERSPACE,
> +};

I'd remove secure boot mentions here.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrREX4ACgkQMOfwapXb+vLYtgCfRYyFGIL5TIvishDq7IHED0qR
epcAnR6WOidNb9YAVPgOJSkYW2tiiKVf
=oF26
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
