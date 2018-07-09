Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91447C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF66208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF66208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeGIWlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:41:19 -0400
Received: from sauhun.de ([88.99.104.3]:37308 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754018AbeGIWlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:41:17 -0400
Received: from localhost (p54B337BD.dip0.t-ipconnect.de [84.179.55.189])
        by pokefinder.org (Postfix) with ESMTPSA id 524D456A485;
        Tue, 10 Jul 2018 00:41:15 +0200 (CEST)
Date:   Tue, 10 Jul 2018 00:41:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Message-ID: <20180709224114.4h47enyt4tucqcou@ninjato>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ypmot53gvpiu2yo"
Content-Disposition: inline
In-Reply-To: <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ypmot53gvpiu2yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);

I just noticed this and wonder: Don't you need the LSB of the address?
It is not the RW flag, this is encoded in msg->flags.

Also, no seperate handling for 10 bit addresses? Technically, 7-bit 0x50
is different on the wire from 10-bit 0x050. This is minor, though. There
are no 10-bit devices out there. Still, did you test 10-bit support?

Rest looks good.


--4ypmot53gvpiu2yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltD5IoACgkQFA3kzBSg
KbZJ6RAAoLCJ9apVqLEc7GDPJY2mLHft6olFHgNIy0dPlaZ/cNNEcbDRZusWNeU9
x2HKAqPCEkfiCIEhvOU+BVAje54YhZyldfvbtK6pkWah4qNeTgRMeHnGLEyQU/EJ
8ig76atDgt/NewStqm/+Rrof6W7jDY20ZWNBdN4DyIr6RFfjb9idbtjj9HgNJ+a8
Wwptu/LwTKsYYyiHuNKl6l4UvXJcsjTqH/NO1vHaFR6nq/1yEly0CwZPzb7fse1Y
6jNHQc9LlI+teCbZqkGYB638WUioeFkDlwgdnAyO369P/zDQfCa3RmAQ8aEOmPFu
TTODXkF+a+28EA9fvxlxlDIYUwrY8f7LY2aIHruosXYGjBwi15tLOnS7SnXkY2MD
SygxZGkPMabvYTLLS3xPsx5OZOC4yvFWURiIDvA34xCHvFqeoQuvIk96EoH3nC2o
TY5TPbrZZfS65ahcZzZTRRwf1LkWpybzsy8p+8kbcR1xOCPWm/ak955BLeHSNomC
NrZMYMSRjZ8heAFetjRoUb2pKTm8XW+DeaYkAMlYZg4yhkX+pXhazsBnaFDC5QGW
X5nqk8/D3QjalTgHTUqDjoezvt1qi1g5QFUWHcbtKSn/RsbkL3E0d7DLvEqQagzY
CA8Nnsj2IG1WgfRpYwbx5WQHMFCEYT6t6yz2j6LZgsAox/fa1pI=
=/cd/
-----END PGP SIGNATURE-----

--4ypmot53gvpiu2yo--
