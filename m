Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD720880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="aehiF0AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBTQPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:15:13 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:20929 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679310;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fm4pTOS+6jwP7vMs7jRwC5K77w9qk/R9WezD4WM0nic=;
        b=aehiF0ACu5v5dpjNXDH+amQQPW7RYmYTGl4NP4mqkbjKkrpobUfGyzjLsBs91HIm6I
        rWxw42J3wE4y8DFt7pWTPy9LZMtuTo9ymnjuUSFJAQujTMSWDOHOiW3NWbWhFnXYKLf6
        4mdpZ4Iqkxhop3979QoMJChrby45DeZWP/3r6+w6S+qMScIgSapmbT0xVTmc3rXr21ET
        /OMFa8g9JQOpsgU8B3x8sOMZfsTZfHIuBoDn3sdBfWMzifwh6fIIccK7sfi+OEh71NSV
        9wnEnzP89mGWM6P5LUvYjRh/Kzu9frsFR9c/Cok3Q7C6/fn/l5hmrY2rDq20nglHYaZR
        tKmQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGFAFas
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:15:10 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 5/9] iio: accel: bma180: convert to devm
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220160951.GX9224@smile.fi.intel.com>
Date:   Wed, 20 Feb 2019 17:15:09 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <175C24D1-2C0D-455F-B091-E16ED67C4049@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <900f59b94ef2e1b5559b363c0d1af4fefccd0366.1550671256.git.hns@goldelico.com> <20190220160951.GX9224@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.02.2019 um 17:09 schrieb Andy Shevchenko =
<andriy.shevchenko@linux.intel.com>:
>=20
> On Wed, Feb 20, 2019 at 03:00:52PM +0100, H. Nikolaus Schaller wrote:
>> This simplifies the code a little.
>=20
>> -err_buffer_cleanup:
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -err_trigger_unregister:
>> -	if (data->trig)
>> -		iio_trigger_unregister(data->trig);
>> -err_trigger_free:
>> -	iio_trigger_free(data->trig);
>=20
>> -err_chip_disable:
>> +err:
>=20
> Please, leave the original label name as it's more self-explanatory.

Ok.

>=20
>> 	data->part_info->chip_disable(data);
>>=20
>> 	return ret;
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

