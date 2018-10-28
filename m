Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDEC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC48720880
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2d6msCAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC48720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJ1U1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeJ1U1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:27:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AEA2075D;
        Sun, 28 Oct 2018 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540726985;
        bh=vIPHfKTPmKyO8auv80rgNzKO9fFqA+P4HuH6/g3Zznc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2d6msCAvfM7p4piPCcSYZLz7or5KMNpZ6C0a4vYoWLbaEg2/Mc1UldVrewp/t9/ni
         WRjpWoMkzgo31yuyY/4sBDQ71wiONcM3ZIJd2XCs8LZVopgVf4JO9kPbT9BgWh17Lh
         tEdjI/pxZKoX9g+A/rEESyQce7rpmQR/jUhTHfKE=
Date:   Sun, 28 Oct 2018 11:42:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181028114259.6d5158f8@archlinux>
In-Reply-To: <20181027171428.GA2503@himanshu-Vostro-3559>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-3-git-send-email-dan@emutex.com>
        <20181027171428.GA2503@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018 22:44:28 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Hi Dan,
>=20
> On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:
> > From: Nicola Lunghi <nicola.lunghi@emutex.com>
> >=20
> > ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> > Squared board.
> >=20
> > Add it to the driver.
> >=20
> > Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> > [javier@emutex.com: fix up commit message and one checkpatch warning]
> > Signed-off-by: Javier Arteaga <javier@emutex.com>
> > Signed-off-by: Dan O'Donovan <dan@emutex.com>
> > ---
> >  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-) =20
>=20
> []
>=20
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id adc128_acpi_match[] =3D {
> > +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> > +#endif =20
>=20
> I'm curious about the naming conventions used for selecting=20
> an ACPI ID.
>=20
> AFAIK, ACPI or PNP ID consists of *Vendor* ID + Product ID.
>=20
> PNP ID: PNP Vendor IDs consist of 3 characters, each character being
> an uppercase letter (A-Z).
>=20
> ACPI ID: ACPI Vendor IDs consist of 4 characters, each character being
> either an uppercase letter (A-Z) or a numeral (0-9).
>=20
> In your case,
>=20
> Vendor ID -> AANT (AAEON TECHNOLOGY INC. registered ACPI ID prefix)
> http://www.uefi.org/ACPI_ID_List?search=3DAANT
>=20
> Product ID -> 1280
>=20
> How did you come up with 1280 ? And why AANT ? why not TXNW which is
> registered ACPI prefix for TEXAS INSTRUMENTS ?
> http://www.uefi.org/ACPI_ID_List?search=3DTexas+
Simple answer to that:

TI don't (as far as I know) publish defined ID spaces so no one can
use their ID without risking stepping on an ID in use by someone else.
I would assume there is an AAEON module on this board (pretty common
for embedded boards) so they have assigned an ID from their namespace
as they can know it doesn't clash with anyone else.

>=20
> Latest ACPI manuals says:
>=20
> 6.1.5 _HID (Hardware ID)
> ------------------------
>=20
> This object is used to supply OSPM with the device=E2=80=99s Plug and Play
> hardware ID.[1]
>=20
> [1] "A Plug and Play ID or ACPI ID can be obtained by sending e-mail to
> pnpid@microsoft.com."
>=20
> A _HID object evaluates to either a numeric 32-bit compressed EISA type I=
D or a string. If a
> string, the format must be an alphanumeric PNP or ACPI ID with no asteris=
k or other leading
> characters.
>=20
> A valid PNP ID must be of the form "AAA####" where A is an uppercase lett=
er and # is a hex
> digit. A valid ACPI ID must be of the form "NNNN####" where N is an upper=
case letter or a
> digit ('0'-'9') and # is a hex digit. This specification reserves the str=
ing "ACPI" for use only
> with devices defined herein. It further reserves all strings representing=
 4 HEX digits for
> exclusive use with PCI-assigned Vendor IDs.
>=20
>=20
> Next question:
>=20
> There are a lot drivers in iio/ using ACPI for device enumeration using
> these IDs. For now, let's take an example of Bosch Sensors:
>=20
> drivers/iio/accel/bmc150-accel-i2c.c:static const struct acpi_device_id b=
mc150_accel_acpi_match[] =3D {
> drivers/iio/accel/bmc150-accel-i2c.c-   {"BSBA0150",    bmc150},
> drivers/iio/accel/bmc150-accel-i2c.c-   {"BMC150A",     bmc150},
> drivers/iio/accel/bmc150-accel-i2c.c-   {"BMI055A",     bmi055},
> drivers/iio/accel/bmc150-accel-i2c.c-   {"BMA0255",     bma255},
>=20
> drivers/iio/gyro/bmg160_i2c.c:static const struct acpi_device_id bmg160_a=
cpi_match[] =3D {
> drivers/iio/gyro/bmg160_i2c.c-  {"BMG0160", 0},
> drivers/iio/gyro/bmg160_i2c.c-  {"BMI055B", 0},
> drivers/iio/gyro/bmg160_i2c.c-  {},
> drivers/iio/gyro/bmg160_i2c.c-};
>=20
> drivers/iio/imu/bmi160/bmi160_i2c.c:static const struct acpi_device_id bm=
i160_acpi_match[] =3D {
> drivers/iio/imu/bmi160/bmi160_i2c.c-    {"BMI0160", 0},
> drivers/iio/imu/bmi160/bmi160_i2c.c-    { },
> drivers/iio/imu/bmi160/bmi160_i2c.c-};
> drivers/iio/imu/bmi160/bmi160_i2c.c-MODULE_DEVICE_TABLE(acpi, bmi160_acpi=
_match);
>=20
> Bosch registered ACPI ID: BOSC
> http://www.uefi.org/ACPI_ID_List?search=3DBosch
>=20
> Bosch registered PNP ID: BSG
> http://www.uefi.org/PNP_ID_List?search=3DBosch
>=20
> So, how could we use PNP ID "BMI" which is registered prefix for
> BENSON MEDICAL INSTRUMENTS COMPANY ?
> http://www.uefi.org/PNP_ID_List?search=3DBMI
>=20
> Product ID -> "160" is fine for bmi160 which uniquely identifies the
> sensor device.
>=20
> But shouldn't the prefix be "BSG0160" instead of "BMI0160" ?
>=20
> When I wrote the driver for Bosch BME680, I followed the same guideline
> as done everywhere else in the Bosch family:
>=20
> drivers/iio/pressure/bmp280-i2c.c-      {"BMP0280", BMP280_CHIP_ID },
> drivers/iio/pressure/bmp280-i2c.c-      {"BMP0180", BMP180_CHIP_ID },
> drivers/iio/pressure/bmp280-i2c.c-      {"BMP0085", BMP180_CHIP_ID },
> drivers/iio/pressure/bmp280-i2c.c-      {"BME0280", BME280_CHIP_ID },
>=20
> Therefore, I used BME0680 for bosch bme680 sensor!
>=20
> In OF matching, we use vendor prefixes and that looks more legimate:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
Documentation/devicetree/bindings/vendor-prefixes.txt
>=20
> Dan,
>=20
> These questions are not just for you but to rest of the community
> members as well.
>=20
> If there is something I misunderstood, then please let me know :)
The sad truth is that for ACPI things aren't really governed by the
spec, but rather by what people put in bios tables.

Now, I know is some cases the ID has been assigned pretty much to provide
an easy way to test the device as there are no known IDs in use for
the part.  In those cases we should be a little careful and it would be
nice to keep to the spec.  If companies actually published a
canonical list of their ID usage it would certainly make this nicer.
I have access to the Hisilicon list for example, but it's not (as far
as I know) public.

Some of the more random IDs are real ones found in the wild (such as
the one in this case).  Reality of a lot of these parts is that we will
never get them to fix the Bios.

I can rock up at an ACPI WG meeting and rant about it (mostly I don't as
they are in the middle of the night UK time) but in reality the smaller
companies don't have anyone attending so it wouldn't help much.

One thing we could do perhaps is start recording as comments, boards
on which a particular ID is found, or when we know it is the suggested
value from the manufacturer of a device.

Jonathan

P.S Technically I'm a member of the ASWG part of UEFI who is responsible
for that standard (on behalf of Huawei, though I never actually attend as
the call are in the middle of the night), but there are only so many things
one can try to solve + to be honest inconsistent namespaces don't
really hurt anyone other than requiring additional IDs to be added when
a new one shows up in the wild.

>=20
>=20
> Thanks

