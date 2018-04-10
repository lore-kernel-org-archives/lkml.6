Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3633902-1523358588-2-10256050395343695066
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523358587; b=JnCcFlDvT4N9d7yquuyih3R88gkllFtO2gd+qjeRsqI+OKCqpf
    FgshzG9GRWGGE3lh9KStaGFyCXeHNxsOyxI34orWx/hUBI9ffwKC/0sUJhuPFjUG
    iYxEqoMiVSsPAsDkaIHWz2A3wZ/ikhP2Wd2QNss3wGEI4emGxzTAbQMua/+Mg25K
    QbOm87ueuyJPlGrXyu/TuzQOMQ1HOAz+uiLrjCedvviKZYchKAy4hQDeWO1rHcfz
    wEYFiPb2Pf1QUz5vDVJd/AIf+BPeE1yikmNCVzMF5XwihcP6pLFSBx5OBSEYKwm4
    xTbLr9YnoUUjw/SyC5hts8tNWe4jlTaUrEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523358587; bh=G1ZdH8SGmK9c/KgrWmK6gbZH5PXJW7
    oZ6AKs15+VOPw=; b=RZfLUP05uyghNPZnSmuPQLUpCe9s/9FJwZtICJwk3+sEq3
    jmE90e2QSo09QITFDAwrjXxTNEt95yTywWhv/5pal8TTOunoL602QOc7t1R6Lu/q
    NtGiyooQcPzxDc0eaKZ13TV5ILIEuh42wfWEU2mZdVvloYrgmgeaGH7tnz/TvNbw
    8IpXLjYepyBCdMBfJ7qNkGanfsM8tbrQmLVu2kD450ymNH4l6zeLB6jdYuSx0Bsu
    k1ekny55UYldd2KYtV+DNA3qUqlcb8Eka5YVA5LW2p9rI6wHXVw/EWItA1cLw8l+
    VxdIqnSGqJWzJxo0XY3bkHVS/6OU4b6jTaf644Gw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPuP0PDT+PpAIGn7qi1srBVZJyYvkR9oR2GEJm7XkKfsF8LB2MQr+EyBACvpqOmmaQdrZcuYG8P8w0PHwSKyKZ/ulgaM8oTWDWK7H8kuGEZj78jIpMGA
    o8onQu0WEMTg6Fw8hb5iEJwS9LZ+D2vvGrPnE9KL5Hv/umyx7JH+cD05MVtl/QYbJRi1eNErYvU1CH4QsdS1LkZDwW5LKfjOpHlqhPIe5mqzPwP1dvt3GdG0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=TubohKkhC9aYUjzwg2gA:9 a=Q6dQCobDX4bRfQrA:21
    a=X9eHM6MyngD3fOTD:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=ojzDWEkQdyhzpS7GcwQA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDJLJq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 07:09:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47206 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeDJLJq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Apr 2018 07:09:46 -0400
Date: Tue, 10 Apr 2018 13:09:44 +0200
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
Message-ID: <20180410110944.GB13697@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20180409134259.GO5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-09 06:42:59, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180409 10:56]:
> > Ok, I should have all that enabled. But droid4-ngsm still fails:
> >=20
> > user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> > Starting ngsm..
> > Testing ngsm..
> > Could not open /dev/gsmtty1: Level 2 halted
> > Trying to start ngsm again: Level 2 halted
> > Starting ngsm..
>=20
> I guess you must have phy-mapphone-mdm6600 enabled as you a have
> working modem over USB. What do you see in dmesg if you enable n_gsm
> debug with modprobe n_gsm debug=3D0xff or on kernel cmdline?

Ok, I guess I can do that, but first:

Should the modem respond to AT commands on ttyS0? I launched minicom
(115200 8N1) and I'm not getting any responses.

> > commit 984c7706ff180e33096c57183435d925cb644576 says:
> >=20
> >     ARM: dts: omap4-droid4: Configure uart1 pins
> >=20
> >     These are needed to use the n_gsm driver for TS 27.010 UART
> >         multiplexing. Note that support for the OOB wake gpio is still
> > 	    missing so the UART is not yet usable for n_gsm.
> >=20
> > ...am I still missing the OOB wake gpio support?
>=20
> We can get away without OOB wake gpio for a while as mdm6600 is not
> yet suspended over USB. But if you have manually suspended mdm6600
> USB interface via /sys, then it won't respond properly on n_gsm
> either.

Ahha, ok.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrMm3gACgkQMOfwapXb+vIw6gCgnDnIP/cYLwxrnivEeynZwaDh
iMIAn2BaGyGv24+nr5SbOWpWXBHsnUFs
=99rx
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
