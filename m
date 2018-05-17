Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387529-1526575617-2-4488173968443191937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526575616; b=Wo/NOS7KWZVrqDsGffTcFjcjmRTPoaAHX2T15WIfhuIWjN3xS0
    VKz1CpVKicU4xXKOEBFR23tbQGZVvPSyLuYe5YALWYThBpDQzBg1lgJqQyvv0bUT
    kC2n7M0SwdStFAuK5e3ac44NJyCpCQUQNTXfVoMI0/lwdEwnUiblPFenWEi7s2/Y
    dAm/BYI+bv/iQB0ZrLGkf6HKZpdI36RRCRk1FGH98QODHV4uS0iP90O2Ql+QeRnq
    1QQTh4u7S7bcYmBw5n6ds0glOlowv9P6aGRFUpqb2uRuJWK7V9FSuQfKxyghYCgs
    16ur6ZIcT484rPOnxHO5Zqj6sykS1P3Smc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526575616; bh=b77vHbAYv0B6Q4HfHV/uRWSmPnoZEZ
    0EZBeq9w0cZ2Q=; b=iPoA4si9G1y//OauOG0EGizD0AmzbB50tWZ9w5Z/o2NOkb
    ZnDo+vX0hj5/DoBlNDuG2Pbm/85rOBPK+aE1LZii/UbiYZ9xTjQGapUaRXdUMYvR
    JF+A/e/vGVqrBhYQbtm738hfUVcbRJJ8gkrjJF9cn9tAtmNtMIbFWvas2DJA+N2z
    Y1xpSoUcAIODj8SST4IJ1FFRjuxLznyfBNEl7Fi+MfZXVOHniPbMF5anSdnChsF3
    R80/bjMSdjS9N2BsJJ8t/DOiMMppU28wdB1D+VhOQqMIJmdljyQa5hNuW40R5jOw
    CPKnBU/QRbKkz3w9Ahq1argiqaCmUa3ofHyENlxA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vIwWDAVq
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=vIwWDAVq
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNcLfYzugEXPyUl9eklmiO62NywCg1TG/roEaq19kJ2MNFuMlHKxcVcE9l7R1amb4e8zuOENGuJ8EjZLiPk1Bu6GTUmWC5yramTbZQqtOHGX10avBxcy
    1E4k/azUvEySmxiRN4/Xtsx1vpq77TXsW5KELZ3WiflXpj79f/aWhd+NUuj7fgFXh9GndJzMw7VjWduYyeLR32auGLCWPF8imWOxvFW8d/dWEXZ20/JZnrwr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=phnSYySXRiQcUpM8DY0A:9
    a=CjuIK1q_8ugA:10 a=e5POxkZ6Z_cEu5GZGyUA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEQQqd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 12:46:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59236 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752867AbeEQQpE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 12:45:04 -0400
Date: Thu, 17 May 2018 13:54:37 +0900
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        alexandre.belloni@bootlin.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180517045437.GE20254@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2018 at 12:22:24PM +0300, Radu Pirea wrote:
> On Mon, 2018-05-14 at 20:38 +0300, Andy Shevchenko wrote:

> > So, what is not going as expected in "SPI core takes care of CSs"
> > case?
> > Did you use oscilloscope for that?

> Yes, I used and CSs was not asserted. Anyway, I will will try again.

If the core chip select handling is not working properly for some reason
then the core chip select handling should be fixed rather than just open
coding in your driver - probably it's also broken for other users.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9CwwACgkQJNaLcl1U
h9AHmAf+MeZvNU8HPwcP+sQCno97dw8H+yoy3YJU9I0Dj3O2T7Oo92s9mWkZRvVo
sOKTcum4hVqmJFePu3boGmH63hfeD0QUOSm6kJr4xkSy1Sxz0ouOhlvI7LRe8XFK
e7cHXKAznizC8uLRLSmtfWJ1Yxs/Xp6f4ZHidVlXxlstZBp3pPNrf1Fp5l9fuHyn
SztnBBwxWDd+T0BolFLQttRrPK+QH8kbI4QGd+m7Nf+89x+FAWwsNKbFZE/J7A0A
J1ZHjrJ4Tby2CIG4dhx0EsBn57AyB+DxZJcCVYt66KyOcggs8kom3k+RxY8kXQNr
EDDh2ppYFrYMdZt1KnbLilNYeZ14Hw==
=UhMg
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
