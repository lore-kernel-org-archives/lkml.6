Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2852210-1523214367-2-6028839898739546029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523214366; b=YsAsA5VdNmbvHQ50pHuCV8JmkD+YIbQ2oZX7Pi1zi5mm6wI6Mi
    hmC04B1z0kkUzWd7CgHgyOdPFr33T8m9MEIND3DjBvpHp/FWOn2Fb6VBhBoQDBOf
    rMj9/2cD4NtjwluibS6Y10pHcvRocOTr+Gd9BtK4J1hww0Zip/lXTOUJsynNpGUc
    QTV2omT9GYyKGrKbPLVPCnAY4DA3tvKc13s62TtzmJ0Q28oozATrm5VmxjAZihkH
    tSIbPv7IJPH3vrFDcce/dwvHbvwlORogLZELVPOWb0i6KgvbDBxnmWNx8tngbKAj
    4wlZVwJjokI3jU6swyPxoR1kgm3xa+IOKX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523214366; bh=oVUclCaPA10xg0q7hWKlRRviwEZ0y8
    ffZMpXKRjl+kY=; b=KjkGyr/UbRS9v4PcJv/rTRgfI34UVQ5TeY5qX1il56f9RR
    Kng+b9FpmV4iGBbtezjXIGsJUfhw8QHR8JBrnP23fVg9bO5s1ist2azZfnd5yvEf
    2OvG1L5D8rLoJB92BYrr4+a7DbonBifQMPU7hHZdqa8OFu8Qj4AYDBt2RXKW+VCp
    Mre1Gp6M8bXqTl0KATPbuAMpntuFtGqwEnkM2/WdM3CMjLjSVFgHfLRnTSxjzqFK
    IE7dCwFouQ7dVbCxSeO3Kzrs0xwL/tCavJPIJX4xx2uv30bBPEkMXU5AwP2hQyia
    9u372wWZnFMADYMkSqpjh0E9xiIIOrPwmm+tMHTQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgzaia/4jn2lsrM/Mq46KCnnQQMmv75D3P8hBGz7PJKL39p+sHYR9Y91QYrNYhakEeRMlqdsLJQPgH0S27VcqzH86NpYLccus/d9wN3Ro1bH4R3Pyht
    I0+On0CjUwqjSkOoh6f/EZ4gKpUF6Vm5Ygeow4GxhB9Qtvdrr8eri3IWImybgxNPnxGtQ4g1yShRlhZC2YCeMTBGu3FaPHfsjP4wlW+gnfjE54xeOJ9GB+eh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=ZJ7NAyZiIqU10jNjnsYA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=8zWhSwbPFjWkdSfkBYQA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDHTGD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 15:06:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47046 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeDHTGC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Apr 2018 15:06:02 -0400
Date: Sun, 8 Apr 2018 21:06:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>,
        Dan Williams <dcbw@redhat.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Message-ID: <20180408190600.GA24342@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20180408165038.GM5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do you have a tool to use and a script?
>=20
> Yes I used the shell script I posted earlier, but forgot it also
> needs the ldattach done.
>=20
> Anyways, last night and today I wrote a quick test utility called
> droid4-ngsm that initializes things and I can use to do some
> experiments to get the ts27010 channel proxying to W3GLTE also
> going:
>=20
> http://github.com/tmlind/droid4-ngsm/

Ok, now i'm confused. It wants to bind to ttyS0, but modem is on
ttyUSB4 AFAICT? Or is the modem connected to serial port, too? (Do I
need to enable some more drivers for that?)

I do have ttyS0, but I don't think there's anything attached there. Or
is ttyS0 for the LTE modem?


> Sorry could not resist adding a test call feature too :)

:-)

> Hmm it might be best to add the ts27010 support and proxying
> eventually to ModemManager? I think ofono and others could still
> use the /dev/gsmtty* ports for the modem as needed too?

I'm not sure how the userland should be designed...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrKaBgACgkQMOfwapXb+vL4VgCghxzBtCv60qtIOpB2kWurf3wT
nJUAnj+30MbsjKxVN63Cn8RowXsgUfRc
=CtNY
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
