Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1272426-1523546880-2-1662357957973376442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523546864; b=NKn6CGeRKvwRPvbepuTJT8zdbjLA3Zs2vRwBwrPjECdbP/5FCf
    Zef0xocLa1WMsWOcD2rVs1NUTXxQtGh6Kupf6T8dY5qLZwBwc0xF3/iSNmqgY52F
    ZZBFr/5JWlgPDRbrq3cs/47mvpJ7mWIgVpcw/FNyIqTxysQHkGtSohcnhKiwcId6
    So0vaMw2cuv/NAuFoFyBkDCLQ9e5uO1CkWKmh8KUcs/kcMljfoOWLnmAlyzxFm32
    xhLPXNRHsh7mI4SCQWUrk/TzlRNou87c1CX8me09uDeOHqLYwsdGWLL2oPFw/BDz
    PqopEh0am3tFrn1VV5E7GbGTI730H8/zgpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1523546864; bh=PTf9KrHDuiH3wRAmU612SVq7HG/MQ7D
    gvD5cUHINKYA=; b=STzDxg1SORKfk8GARyqJ0YpkwYDBh8rs7O5L1LixD/fnzFG
    WMAELKQRbHKuhO2pOQb5Oc7cSLrKcecfZ8p+MYbR97uFnlkAwM69hOoz17amuMLv
    OmfmKMwmHcwH8E6iw54ed3qgwQURHNzDL4rerFKrjlmMS9CTGymhlgQIwBixUhza
    y/D2+L/K3tg5KKUb8sBpsv3Fdv6t6GrZxWAZW9/aJmG2bXWOVMH5rGepSmwhKtmi
    tOup6N5zG2xFQYuUoDNxlsjsOaJg+IQyJghQKEXrwEp1PplWlb1mCj5aM5lEuifU
    KREb+RHpZ5PW0XB0yEXKLA70z7l2t5sVMn4dQTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=uzdhMMnN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=uzdhMMnN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUxKCWS5I/UghQLrL0TwuyQxVY+bdt8yuoywOt4+Hiys8vgQqrALyPVThZvTvaGpDKKi3c542S7TBNBPg/6NdRTTnr3F+2g0i+xl/m4oUj3L9oECq3b
    89fg73Bn/v1tfE7hgZ1T4KNjY6CrXaNRCpdgFpi0xIuqAX6bDYMghIDKzcm6bt5VbxktJ+n99gv7zQiP7l+mq2enYrbfdhcglFDIeBFisaML6z1G3X1bs3Yh
    54Qvq+TZ2/XUq8t/d8L9XA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=xqn3uPuMxkSN_LYa0X0A:9
    a=CjuIK1q_8ugA:10 a=rvfq9AIe_PUhNUYNhkQA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=pC-h2on8RWMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 12 Apr 2018 16:26:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 08/15] ASoC: pxa: remove the dmaengine compat need
Message-ID: <20180412152632.GG9929@sirena.org.uk>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-9-robert.jarzmik@free.fr>
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-9-robert.jarzmik@free.fr>
X-Cookie: The coast was clear.
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, linux-ide@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============2894887599076401071=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============2894887599076401071==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2018 at 04:26:49PM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.

Acked-by: Mark Brown <broonie@kernel.org>

If there's no dependency I'm happy to take this for 4.18.

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrPeqcACgkQJNaLcl1U
h9BSZAf/TjOZQziPXrBJ727QgQKnwF8+6GXuQPc3HlwShDoJ9qAWnzcOSwzJ8fkE
dcG2858Zo0M7NCqcoOokOhM4wKUOn3aCE78wDsjEPX/PohKdI3uHZXBLbSrFaSF8
y1TYjHDRCKqYTTfaG4bNfONcAb+ymbxjGD4ZOsrkV82pl8tCA+zCT5g6C8PrqshL
GwwmmJQHGK0CU477p0+QN/EsW/B9VNLNsqpeFS9WAlZcTuA004mW/3YYf8hwpk0i
pFqD2AXnmrDVsynBm78eKaAtqMRUkd0I/iWRWqFf7DtVVx6Foo8877fCdcVLYgYI
mArYZJIh+YC/f25ftES/xWmAqIokOQ==
=INfO
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

--===============2894887599076401071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============2894887599076401071==--
