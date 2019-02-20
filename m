Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45980C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190F32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Wekbfpxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBTQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:26:38 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:25222 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBTQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679995;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=38npVTSk79CYr/muKAs9IwN6DMdJ6DzoI417b2xdfK0=;
        b=Wekbfpxxhl1B7PeOoeNlZM5yC841m61bnyKOdYgSkqf8Op4ej9BgP7bytDlvQ5NXrJ
        XUkMzq6IHIfoUOwXiC5eye2TIFIgYVzgIM0tdr7KOENt8b5yKecRfPfM/b2FXD7e/RgE
        8iGJEq1gbCbKgEzBDS3bovbCwMJpTdPbz4AoCFCH0zOGw9Hv/tZ3NNumSsrlDSHW9tzD
        F1SpuNFJHpob0M490wMvNMLxCX5PPdInFXxKfxKV0cmdvHwcTp4CqFcaghnRSs0LOMrj
        quH0K5BBM6Zo0JQLFM8RnVXaxuu4GX+ZRFCN3F6u4RbY0vQZJTQHIM6MaoRTeYMvHiHQ
        QJYw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGQYFdn
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:26:34 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/9] iio mount matrix - revitalize missing bindings documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220161303.GY9224@smile.fi.intel.com>
Date:   Wed, 20 Feb 2019 17:26:33 +0100
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
Message-Id: <3A9E6DFC-1A81-4503-9A92-547944BBDFC1@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <20190220161303.GY9224@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Am 20.02.2019 um 17:13 schrieb Andy Shevchenko =
<andriy.shevchenko@linux.intel.com>:
>=20
> On Wed, Feb 20, 2019 at 03:00:47PM +0100, H. Nikolaus Schaller wrote:
>> This patch series adds the mount-matrix to several iio sensor drivers
>> used in handheld devices.
>>=20
>> The mount-matrix translates the quite arbitrary orientation of the =
sensor
>> on some printed circuit board to user-tangible orientation in =
handheld
>> devices that relates to typical screen orientation.
>>=20
>> There was a bindings documentation by Linus Walleij but the patch
>> did not make it into mainline. Therefore I resend it here.
>>=20
>> Next I have added some clarifications (at least I hope it clarifies)
>> in a second patch.
>>=20
>> Finally, the patch set implements the hooks for the mount matrix
>> in several iio drivers: bmc150, bma180, bmg160, itg3200, hmc5843.
>> This includes also one patch for the bma180 to convert it to devm =
API.
>>=20
>> We use them in different variants of the omap3-gta04 so a separate
>> patch set will provide device tree additions for them.
>=20
> Thanks for the patch, overall good stuff there.
> Couple of things, though:
> - address my comments (consider them against entire series)
> - check my patch I sent today to support this from ACPI
>=20
> I wouldn't like to spread more drivers use specific of_foo_bar stuff =
where it's
> easily to support everything (note: device_property_* calls supports =
software
> fw nodes as well).
>=20
> Perhaps, you may incorporate my patch into your nice series.

Ok, that looks like a good proposal which avoids compile issues right
from beginning of v2.

BR and thanks,
Nikolaus

>=20
>>=20
>>=20
>> H. Nikolaus Schaller (8):
>>  iio: bindings: clarifications for mount-matrix bindings
>>  iio: accel: bmc150: add mount matrix support
>>  iio: accel: bma180: add mount matrix support
>>  iio: accel: bma180: convert to devm
>>  iio: gyro: bmg160: add mount matrix support
>>  iio: gyro: itg3200: add mount matrix support
>>  iio: magnetometer: bmc150: add mount matrix support
>>  iio: magnetometer: hmc5843: add mount matrix support
>>=20
>> Linus Walleij (1):
>>  iio: document bindings for mounting matrices
>>=20
>> .../devicetree/bindings/iio/mount-matrix.txt  | 162 =
++++++++++++++++++
>> drivers/iio/accel/bma180.c                    |  70 ++++----
>> drivers/iio/accel/bmc150-accel-core.c         |  19 ++
>> drivers/iio/gyro/bmg160_core.c                |  19 ++
>> drivers/iio/gyro/itg3200_core.c               |  18 ++
>> drivers/iio/magnetometer/bmc150_magn.c        |  19 ++
>> drivers/iio/magnetometer/hmc5843.h            |   1 +
>> drivers/iio/magnetometer/hmc5843_core.c       |  14 ++
>> include/linux/iio/gyro/itg3200.h              |   1 +
>> 9 files changed, 288 insertions(+), 35 deletions(-)
>> create mode 100644 =
Documentation/devicetree/bindings/iio/mount-matrix.txt
>>=20
>> --=20
>> 2.19.1
>>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

