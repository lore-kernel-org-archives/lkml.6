Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2030069-1525951355-2-6669866239050273468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525951355; b=XnAdRbwaKhIAaM+GXBjxfxxgU5ti/hVetfUUjIUwtkCrPKo/8p
    uTKZDgZU3hztD9uyZVm2/bNVvpy0aHeriAGiyBnMcUh1mR+u1aSdghoKxauafUHu
    /hUkLss/yN5UwQ0jRUKVV8kifyZBQsh+u8r7lP7Y7w4T3tlKDvZ+pkgGFJMJqWXY
    8nmRsnkCrgAaoyZ9xA3gkdduybJCn1TXfGw+YvuH5ivFHGiSXyPecTBpeSa4+mWE
    V/7vrvPJMOhKGLNd0byczirPUFDDvZFV4ybghSalVDR/nKKKIDwez6GV/VE3tGtw
    tUj3qsWsgyhdtBasyKBLrBbCQZoQfJBfXB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525951355; bh=Sis4pTb2mh0s6xvb3RYAtOqCmUJib8
    b2LYAUM325in0=; b=ReN2sxeJGYO2C+nzdjhrIKQlsD2Q1Ob+v+Cik6qAuyVDKj
    dJXHs5XIf/mbUAzPvj7N3e4Ody7ZUHdzytlnDaLXl74SZNkkbUhwBC3EFWz6Sngq
    q2XETe78ses760IibtPQenDXmmhqr6RV8SJBNmGqp3Txct7nPlJpikDg9hbCHaLb
    yXYwRKhLmquue64LZpKHQUqYdcPYRO/b6i1WZG8pRszL6dLtdjy/1tevz5m6haxl
    AjRjKwM9DuQsAI14AsjR8rQaSHx4i3/bmX+JkSsl4QAXrYYfQi1ZXY4jaPaK3iui
    rtTC5abTZcil3MCy/2QEF56S/n8Yksx08p3sRmTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfITfaPZReXFNuKYTNpympjdlBZJwiueW9AukJfrRVr6YNp3Ykk60fPqbgOfmKiHd8I7V5JFHtkQnHiT406ZiS2cS/1ER5/DiCa/NVjkd6FQOzOXBAFQ+
    KSLaUjazAfr30ieOOr3PYlOtbWHdzg+KvmLHJILMM/HOwIC9PyJfQYYS7OwSFTgNakxVsLJM6d5Qsq1l6chqmQ6fjVNCRk1ZaOwK6uPrUSdhsEbXs5BjpRuB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=yCFPtRpfMKv4IoeKoRcA:9 a=VQi6rxqRF_lsUoe7:21
    a=mYEVRSakw_Zb7BfE:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=miDW-avt9GYM3J8kd3sA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbeEJLWc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 07:22:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58028 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934497AbeEJLWb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 May 2018 07:22:31 -0400
Date: Thu, 10 May 2018 13:22:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
Message-ID: <20180510112229.GE6977@amd>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <20180510112101.GD6977@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20180510112101.GD6977@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-10 13:21:01, Pavel Machek wrote:
> Hi!
>=20
> > This allows one to simplify drivers that provide a trigger with a
> > non-constant name (e.g. one trigger per device with the trigger name
> > depending on the device's name).
> >=20
> > Internally the memory the name member of struct led_trigger points to
> > now always allocated dynamically instead of just taken from the caller.
> >=20
> > The function led_trigger_rename_static() must be changed accordingly and
> > was renamed to led_trigger_rename() for consistency, with the only user
> > adapted.
>=20
> Well, I'm not sure if we want to have _that_ many trigger. Trigger
> interface is going to become.. "interesting".
>=20
> We have 4K limit on total number of triggers. We use rather strange
> interface to select trigger.
>=20
> > @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block=
 *nb, unsigned long msg,
> > =20
> >  	if (msg =3D=3D NETDEV_CHANGENAME) {
> >  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> > -		led_trigger_rename_static(name, priv->tx_led_trig);
> > +		led_trigger_rename(priv->tx_led_trig, name);
> > =20
> >  		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> > -		led_trigger_rename_static(name, priv->rx_led_trig);
> > +		led_trigger_rename(priv->rx_led_trig, name);
> > =20
> >  		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> > -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> > +		led_trigger_rename(priv->rxtx_led_trig, name);
> >  	}
> > =20
>=20
> I know this is not your fault, but if you have a space or "[]" in
> netdev names, confusing things will happen.

Hmm. If we are doing this we really should check trigger names for
forbidden characters. At least "[] " should be forbidden.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0K3UACgkQMOfwapXb+vKCHQCeIzCRd6sZWya59FEb/WCapyef
ChwAoLknzNtCk/JAfalkPnkseQxKoshk
=BEdK
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
