Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD61521B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="v4nxXq2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfBKPzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:55:13 -0500
Received: from mail-eopbgr710046.outbound.protection.outlook.com ([40.107.71.46]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731346AbfBKPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf4p27Z8t3AB+lCt8eNYF6YU+nmE3zpNkF9WoBlbNFQ=;
 b=v4nxXq2W98wpPnkQYUS0/fZXcOkytga1Ac7vSifOPwa7dNhDpw8iwPPZKjJL1IxOn8JlWv+k1snfBfCAUOyq6uiM1B+UfCrD5p4ypzpeF8MPbouqTbMbH6LYTVP+fSS57wGmc2y5mxcGbMSDjNAeuuWaQiG1BL6RxH7PL+uwurY=
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) by
 BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 15:54:58 +0000
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::d0a8:9544:4532:8fee]) by BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::d0a8:9544:4532:8fee%5]) with mapi id 15.20.1601.016; Mon, 11 Feb 2019
 15:54:57 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: RE: [PATCH] staging: iio: ad5933: move out of staging
Thread-Topic: [PATCH] staging: iio: ad5933: move out of staging
Thread-Index: AQHUwiCLyJqPPuwNL0qnzbmH6ayT56Xav+Vw
Date:   Mon, 11 Feb 2019 15:54:57 +0000
Message-ID: <BY1PR0301MB09018DFCAD1AA87B905236958E640@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <20190211154311.mtbfdepmfanm2nsb@smtp.gmail.com>
In-Reply-To: <20190211154311.mtbfdepmfanm2nsb@smtp.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR0301MB0901;6:c+GzdgwGJGTKH2o+HMm640Sb9y3Oc82YIYdLwlGhm2lfm9Ay1e+2sTn5OEmSXFh8+ogi46ehO/SWjGg3kif21W0rogQA6z6fCo9ySN8qX4UCn1ePKK2XWy80JXbeqipoXAZ6Ma3r2vq4C94OuUPmOP/FsSsOuI2UBpI1vRj4Vy7TmyMoBaLXz5n14uu/Hk8yBK5Rl5KzY1PruRhHpq1GnTfUvwOJwd69a6EnC4tCb5d9CADCCOh2QAyJbyLwer4HV1cydJWdV9aYbtye9tEnrTjh7BHQCr40rvDTzm0IHjA8AwjryC8lt8EVOd2gjNdy1+GqMLvL1WnkOTTmzackH4BiECq4ZTRTkFhj9AAQz0ymsxOKN4skjirv8lukxBGk4eRK4JfCnctw+lUARsf95316ubt5oUo8sdKnjERtz0P60DABVgq9CDaWqT5sQ1Gw/hN7OTnB/NRZ86PSBcFL5g==;5:YQUUjViHFhF7qeva8l6+Stihs5IfmLNBJIXscvIt2KOqMK9MmGbxRBShigFTTyl2JBXWFOFrKk2gRUb2Wc7HsLYpRPH7SmKu72uYva8yIPHc6twlgx7kjJCHFwyEikLMb4xsEVMULunqFG3jHI6Pp6D+ft6UKnlm0kcE80Z/3SU4gGAcyJ/ibVp8OGk1Vpga2BxJM6J4yjlmdVw/UQ/slQ==;7:SLvrVjlZRjYNnoD6TcB2xZbB46Wjcf6xMocplP8T6dwlcVf4TYdW1mi33cxXmyiOcICmNYwaGABSSpvw/ryDA7+DjK2Go+7aJ4xwBEU4aZ1a1Zvayp3eF2IwQtu9Cdd1gbC2BQ0dnA7aKPv/JANDaQ==
x-ms-office365-filtering-correlation-id: 4f58077a-c545-4a81-4e60-08d6903945e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY1PR0301MB0901;
x-ms-traffictypediagnostic: BY1PR0301MB0901:
x-microsoft-antispam-prvs: <BY1PR0301MB090135F843A49A73856992338E640@BY1PR0301MB0901.namprd03.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(13464003)(199004)(189003)(7696005)(14454004)(54906003)(76176011)(3846002)(305945005)(74316002)(99286004)(486006)(33656002)(6116002)(72206003)(7736002)(229853002)(478600001)(6246003)(2501003)(26005)(316002)(6436002)(106356001)(4326008)(105586002)(25786009)(110136005)(97736004)(81156014)(81166006)(476003)(11346002)(2906002)(8936002)(446003)(8676002)(55016002)(9686003)(186003)(53936002)(30864003)(53546011)(6506007)(66066001)(71200400001)(2201001)(71190400001)(14444005)(102836004)(256004)(5024004)(86362001)(68736007)(53946003)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB0901;H:BY1PR0301MB0901.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zy5UWFKvj0otaCnOI1CrvyqnEDfWnCMKLvwg1zFw0kd0K8bXDMe56n/ysorgbAz5iXBfe379cr1RYcpmHYfv6Rf5ESqbjpe5GoV8rJd2c5Syta0j4SC0+FksUZgS8INzwH/xSQLuFSrS1wez2Ulw34xZWgfm2qw7q5RnevUe381I+Yne8kjl0W0OdoP4LGbGn4rv4LByrh/vx2mdgq3JWoBY5caet0kV9w4ogGBbASMN7GUS0D2LoQozBMV6cLi4aFYfmvNVXWYKcPJWFpU1OPpjxAUdt38501ESJMbrvN3xdGt8Q6yOivhTcGc1O+hVZC5Kiqmq662/CJwF/xzJ2qZGCc4NIPtbprM0au6ycXVPAzNQ1bPLBM0/ph5otWSN9CBuKWugX1vc7ewQR1HNw2YVaEQO8oX7vMIRNT6R628=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f58077a-c545-4a81-4e60-08d6903945e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 15:54:57.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB0901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marcelo Schmitt [mailto:marcelo.schmitt1@gmail.com]
> Sent: Montag, 11. Februar 2019 16:43
> To: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>; j=
ic23@kernel.org; knaack.h@gmx.de;
> pmeerw@pmeerw.net
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-usp@g=
ooglegroups.com
> Subject: [PATCH] staging: iio: ad5933: move out of staging
>=20
> Move ad5933 impedance-analyzer driver from staging to mainline.
>=20
> The ad5933 is a high precision impedance converter system
> solution that combines an on-board frequency generator with an
> analog-to-digital converter (ADC). This driver was designed to be
> compatible with both ad5933 and ad5934 chips.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/iio/impedance-analyzer/Kconfig        |  18 +
>  drivers/iio/impedance-analyzer/Makefile       |   5 +
>  drivers/iio/impedance-analyzer/ad5933.c       | 810 ++++++++++++++++++
>  .../staging/iio/impedance-analyzer/Kconfig    |  18 -
>  .../staging/iio/impedance-analyzer/Makefile   |   5 -
>  .../staging/iio/impedance-analyzer/ad5933.c   | 809 -----------------
>  6 files changed, 833 insertions(+), 832 deletions(-)
>  create mode 100644 drivers/iio/impedance-analyzer/Kconfig
>  create mode 100644 drivers/iio/impedance-analyzer/Makefile
>  create mode 100644 drivers/iio/impedance-analyzer/ad5933.c
>  delete mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
>  delete mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
>  delete mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c
>=20
> diff --git a/drivers/iio/impedance-analyzer/Kconfig b/drivers/iio/impedan=
ce-analyzer/Kconfig
> new file mode 100644
> index 000000000000..dd97b6bb3fd0
> --- /dev/null
> +++ b/drivers/iio/impedance-analyzer/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Impedance Converter, Network Analyzer drivers
> +#
> +menu "Network Analyzer, Impedance Converters"
> +
> +config AD5933
> +       tristate "Analog Devices AD5933, AD5934 driver"
> +       depends on I2C
> +       select IIO_BUFFER
> +       select IIO_KFIFO_BUF
> +       help
> +         Say yes here to build support for Analog Devices Impedance Conv=
erter,
> +         Network Analyzer, AD5933/4, provides direct access via sysfs.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called ad5933.
> +
> +endmenu
> diff --git a/drivers/iio/impedance-analyzer/Makefile b/drivers/iio/impeda=
nce-analyzer/Makefile
> new file mode 100644
> index 000000000000..7604d786583e
> --- /dev/null
> +++ b/drivers/iio/impedance-analyzer/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for Impedance Converter, Network Analyzer drivers
> +#
> +
> +obj-$(CONFIG_AD5933) +=3D ad5933.o
> diff --git a/drivers/iio/impedance-analyzer/ad5933.c b/drivers/iio/impeda=
nce-analyzer/ad5933.c
> new file mode 100644
> index 000000000000..839bc30682e4
> --- /dev/null
> +++ b/drivers/iio/impedance-analyzer/ad5933.c
> @@ -0,0 +1,810 @@
> +/*
> + * AD5933 AD5934 Impedance Converter, Network Analyzer
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <linux/regulator/consumer.h>
> +
> +/* AD5933/AD5934 Registers */
> +#define AD5933_REG_CONTROL_HB          0x80    /* R/W, 1 byte */
> +#define AD5933_REG_CONTROL_LB          0x81    /* R/W, 1 byte */
> +#define AD5933_REG_FREQ_START          0x82    /* R/W, 3 bytes */
> +#define AD5933_REG_FREQ_INC            0x85    /* R/W, 3 bytes */
> +#define AD5933_REG_INC_NUM             0x88    /* R/W, 2 bytes, 9 bit */
> +#define AD5933_REG_SETTLING_CYCLES     0x8A    /* R/W, 2 bytes */
> +#define AD5933_REG_STATUS              0x8F    /* R, 1 byte */
> +#define AD5933_REG_TEMP_DATA           0x92    /* R, 2 bytes*/
> +#define AD5933_REG_REAL_DATA           0x94    /* R, 2 bytes*/
> +#define AD5933_REG_IMAG_DATA           0x96    /* R, 2 bytes*/
> +
> +/* AD5933_REG_CONTROL_HB Bits */
> +#define AD5933_CTRL_INIT_START_FREQ    (0x1 << 4)
> +#define AD5933_CTRL_START_SWEEP                (0x2 << 4)
> +#define AD5933_CTRL_INC_FREQ           (0x3 << 4)
> +#define AD5933_CTRL_REPEAT_FREQ                (0x4 << 4)
> +#define AD5933_CTRL_MEASURE_TEMP       (0x9 << 4)
> +#define AD5933_CTRL_POWER_DOWN         (0xA << 4)
> +#define AD5933_CTRL_STANDBY            (0xB << 4)
> +
> +#define AD5933_CTRL_RANGE_2000mVpp     (0x0 << 1)
> +#define AD5933_CTRL_RANGE_200mVpp      (0x1 << 1)
> +#define AD5933_CTRL_RANGE_400mVpp      (0x2 << 1)
> +#define AD5933_CTRL_RANGE_1000mVpp     (0x3 << 1)
> +#define AD5933_CTRL_RANGE(x)           ((x) << 1)
> +
> +#define AD5933_CTRL_PGA_GAIN_1         (0x1 << 0)
> +#define AD5933_CTRL_PGA_GAIN_5         (0x0 << 0)
> +
> +/* AD5933_REG_CONTROL_LB Bits */
> +#define AD5933_CTRL_RESET              (0x1 << 4)
> +#define AD5933_CTRL_INT_SYSCLK         (0x0 << 3)
> +#define AD5933_CTRL_EXT_SYSCLK         (0x1 << 3)
> +
> +/* AD5933_REG_STATUS Bits */
> +#define AD5933_STAT_TEMP_VALID         (0x1 << 0)
> +#define AD5933_STAT_DATA_VALID         (0x1 << 1)
> +#define AD5933_STAT_SWEEP_DONE         (0x1 << 2)
> +
> +/* I2C Block Commands */
> +#define AD5933_I2C_BLOCK_WRITE         0xA0
> +#define AD5933_I2C_BLOCK_READ          0xA1
> +#define AD5933_I2C_ADDR_POINTER                0xB0
> +
> +/* Device Specs */
> +#define AD5933_INT_OSC_FREQ_Hz         16776000
> +#define AD5933_MAX_OUTPUT_FREQ_Hz      100000
> +#define AD5933_MAX_RETRIES             100
> +
> +#define AD5933_OUT_RANGE               1
> +#define AD5933_OUT_RANGE_AVAIL         2
> +#define AD5933_OUT_SETTLING_CYCLES     3
> +#define AD5933_IN_PGA_GAIN             4
> +#define AD5933_IN_PGA_GAIN_AVAIL       5
> +#define AD5933_FREQ_POINTS             6
> +
> +#define AD5933_POLL_TIME_ms            10
> +#define AD5933_INIT_EXCITATION_TIME_ms 100
> +
> +struct ad5933_state {
> +       struct i2c_client               *client;
> +       struct regulator                *reg;
> +       struct clk                      *mclk;
> +       struct delayed_work             work;
> +       struct mutex                    lock; /* Protect sensor state */
> +       unsigned long                   mclk_hz;
> +       unsigned char                   ctrl_hb;
> +       unsigned char                   ctrl_lb;
> +       unsigned int                    range_avail[4];
> +       unsigned short                  vref_mv;
> +       unsigned short                  settling_cycles;
> +       unsigned short                  freq_points;
> +       unsigned int                    freq_start;
> +       unsigned int                    freq_inc;
> +       unsigned int                    state;
> +       unsigned int                    poll_time_jiffies;
> +};
> +
> +#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _addres=
s, \
> +               _scan_index, _realbits) { \
> +       .type =3D (_type), \
> +       .extend_name =3D (_extend_name), \
> +       .info_mask_separate =3D (_info_mask_separate), \
> +       .address =3D (_address), \
> +       .scan_index =3D (_scan_index), \
> +       .scan_type =3D { \
> +               .sign =3D 's', \
> +               .realbits =3D (_realbits), \
> +               .storagebits =3D 16, \
> +       }, \
> +}
> +
> +static const struct iio_chan_spec ad5933_channels[] =3D {
> +       AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
> +               BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
> +       /* Ring Channels */
> +       AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 1=
6),
> +       AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 1=
6),
> +};
> +
> +static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u=
8 *data)
> +{
> +       int ret;
> +
> +       while (len--) {
> +               ret =3D i2c_smbus_write_byte_data(client, reg++, *data++)=
;
> +               if (ret < 0) {
> +                       dev_err(&client->dev, "I2C write error\n");
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int ad5933_i2c_read(struct i2c_client *client, u8 reg, u8 len, u8=
 *data)
> +{
> +       int ret;
> +
> +       while (len--) {
> +               ret =3D i2c_smbus_read_byte_data(client, reg++);
> +               if (ret < 0) {
> +                       dev_err(&client->dev, "I2C read error\n");
> +                       return ret;
> +               }
> +               *data++ =3D ret;
> +       }
> +       return 0;
> +}
> +
> +static int ad5933_cmd(struct ad5933_state *st, unsigned char cmd)
> +{
> +       unsigned char dat =3D st->ctrl_hb | cmd;
> +
> +       return ad5933_i2c_write(st->client,
> +                       AD5933_REG_CONTROL_HB, 1, &dat);
> +}
> +
> +static int ad5933_reset(struct ad5933_state *st)
> +{
> +       unsigned char dat =3D st->ctrl_lb | AD5933_CTRL_RESET;
> +
> +       return ad5933_i2c_write(st->client,
> +                       AD5933_REG_CONTROL_LB, 1, &dat);
> +}
> +
> +static int ad5933_wait_busy(struct ad5933_state *st, unsigned char event=
)
> +{
> +       unsigned char val, timeout =3D AD5933_MAX_RETRIES;
> +       int ret;
> +
> +       while (timeout--) {
> +               ret =3D  ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1=
, &val);
> +               if (ret < 0)
> +                       return ret;
> +               if (val & event)
> +                       return val;
> +               cpu_relax();
> +               mdelay(1);
> +       }
> +
> +       return -EAGAIN;
> +}
> +
> +static int ad5933_set_freq(struct ad5933_state *st,
> +                          unsigned int reg, unsigned long freq)
> +{
> +       unsigned long long freqreg;
> +       union {
> +               __be32 d32;
> +               u8 d8[4];
> +       } dat;
> +
> +       freqreg =3D (u64)freq * (u64)(1 << 27);
> +       do_div(freqreg, st->mclk_hz / 4);
> +
> +       switch (reg) {
> +       case AD5933_REG_FREQ_START:
> +               st->freq_start =3D freq;
> +               break;
> +       case AD5933_REG_FREQ_INC:
> +               st->freq_inc =3D freq;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       dat.d32 =3D cpu_to_be32(freqreg);
> +       return ad5933_i2c_write(st->client, reg, 3, &dat.d8[1]);
> +}
> +
> +static int ad5933_setup(struct ad5933_state *st)
> +{
> +       __be16 dat;
> +       int ret;
> +
> +       ret =3D ad5933_reset(st);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D ad5933_set_freq(st, AD5933_REG_FREQ_START, 10000);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D ad5933_set_freq(st, AD5933_REG_FREQ_INC, 200);
> +       if (ret < 0)
> +               return ret;
> +
> +       st->settling_cycles =3D 10;
> +       dat =3D cpu_to_be16(st->settling_cycles);
> +
> +       ret =3D ad5933_i2c_write(st->client,
> +                              AD5933_REG_SETTLING_CYCLES,
> +                              2, (u8 *)&dat);
> +       if (ret < 0)
> +               return ret;
> +
> +       st->freq_points =3D 100;
> +       dat =3D cpu_to_be16(st->freq_points);
> +
> +       return ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, 2, (u8 *)=
&dat);
> +}
> +
> +static void ad5933_calc_out_ranges(struct ad5933_state *st)
> +{
> +       int i;
> +       unsigned int normalized_3v3[4] =3D {1980, 198, 383, 970};
> +
> +       for (i =3D 0; i < 4; i++)
> +               st->range_avail[i] =3D normalized_3v3[i] * st->vref_mv / =
3300;
> +}
> +
> +/*
> + * handles: AD5933_REG_FREQ_START and AD5933_REG_FREQ_INC
> + */
> +
> +static ssize_t ad5933_show_frequency(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       int ret;
> +       unsigned long long freqreg;
> +       union {
> +               __be32 d32;
> +               u8 d8[4];
> +       } dat;
> +
> +       ret =3D iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
> +       ret =3D ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d=
8[1]);
> +       iio_device_release_direct_mode(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       freqreg =3D be32_to_cpu(dat.d32) & 0xFFFFFF;
> +
> +       freqreg =3D (u64)freqreg * (u64)(st->mclk_hz / 4);
> +       do_div(freqreg, 1 << 27);
> +
> +       return sprintf(buf, "%d\n", (int)freqreg);
> +}
> +
> +static ssize_t ad5933_store_frequency(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf,
> +                                     size_t len)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       unsigned long val;
> +       int ret;
> +
> +       ret =3D kstrtoul(buf, 10, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
> +               return -EINVAL;
> +
> +       ret =3D iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
> +       ret =3D ad5933_set_freq(st, this_attr->address, val);
> +       iio_device_release_direct_mode(indio_dev);
> +
> +       return ret ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
> +                       ad5933_show_frequency,
> +                       ad5933_store_frequency,
> +                       AD5933_REG_FREQ_START);
> +
> +static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
> +                       ad5933_show_frequency,
> +                       ad5933_store_frequency,
> +                       AD5933_REG_FREQ_INC);
> +
> +static ssize_t ad5933_show(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       int ret =3D 0, len =3D 0;
> +
> +       mutex_lock(&st->lock);
> +       switch ((u32)this_attr->address) {
> +       case AD5933_OUT_RANGE:
> +               len =3D sprintf(buf, "%u\n",
> +                             st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
> +               break;
> +       case AD5933_OUT_RANGE_AVAIL:
> +               len =3D sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
> +                             st->range_avail[3], st->range_avail[2],
> +                             st->range_avail[1]);
> +               break;
> +       case AD5933_OUT_SETTLING_CYCLES:
> +               len =3D sprintf(buf, "%d\n", st->settling_cycles);
> +               break;
> +       case AD5933_IN_PGA_GAIN:
> +               len =3D sprintf(buf, "%s\n",
> +                             (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> +                             "1" : "0.2");
> +               break;
> +       case AD5933_IN_PGA_GAIN_AVAIL:
> +               len =3D sprintf(buf, "1 0.2\n");
> +               break;
> +       case AD5933_FREQ_POINTS:
> +               len =3D sprintf(buf, "%d\n", st->freq_points);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +
> +       mutex_unlock(&st->lock);
> +       return ret ? ret : len;
> +}
> +
> +static ssize_t ad5933_store(struct device *dev,
> +                           struct device_attribute *attr,
> +                           const char *buf,
> +                           size_t len)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       u16 val;
> +       int i, ret =3D 0;
> +       __be16 dat;
> +
> +       if (this_attr->address !=3D AD5933_IN_PGA_GAIN) {
> +               ret =3D kstrtou16(buf, 10, &val);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
> +       mutex_lock(&st->lock);
> +       switch ((u32)this_attr->address) {
> +       case AD5933_OUT_RANGE:
> +               ret =3D -EINVAL;
> +               for (i =3D 0; i < 4; i++)
> +                       if (val =3D=3D st->range_avail[i]) {
> +                               st->ctrl_hb &=3D ~AD5933_CTRL_RANGE(0x3);
> +                               st->ctrl_hb |=3D AD5933_CTRL_RANGE(i);
> +                               ret =3D ad5933_cmd(st, 0);
> +                               break;
> +                       }
> +               break;
> +       case AD5933_IN_PGA_GAIN:
> +               if (sysfs_streq(buf, "1")) {
> +                       st->ctrl_hb |=3D AD5933_CTRL_PGA_GAIN_1;
> +               } else if (sysfs_streq(buf, "0.2")) {
> +                       st->ctrl_hb &=3D ~AD5933_CTRL_PGA_GAIN_1;
> +               } else {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +               ret =3D ad5933_cmd(st, 0);
> +               break;
> +       case AD5933_OUT_SETTLING_CYCLES:
> +               val =3D clamp(val, (u16)0, (u16)0x7FF);
> +               st->settling_cycles =3D val;
> +
> +               /* 2x, 4x handling, see datasheet */
> +               if (val > 1022)
> +                       val =3D (val >> 2) | (3 << 9);
> +               else if (val > 511)
> +                       val =3D (val >> 1) | (1 << 9);
> +
> +               dat =3D cpu_to_be16(val);
> +               ret =3D ad5933_i2c_write(st->client,
> +                                      AD5933_REG_SETTLING_CYCLES,
> +                                      2, (u8 *)&dat);
> +               break;
> +       case AD5933_FREQ_POINTS:
> +               val =3D clamp(val, (u16)0, (u16)511);
> +               st->freq_points =3D val;
> +
> +               dat =3D cpu_to_be16(val);
> +               ret =3D ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, =
2,
> +                                      (u8 *)&dat);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +
> +       mutex_unlock(&st->lock);
> +       iio_device_release_direct_mode(indio_dev);
> +       return ret ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
> +                       ad5933_show,
> +                       ad5933_store,
> +                       AD5933_OUT_RANGE);
> +
> +static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
> +                       ad5933_show,
> +                       NULL,
> +                       AD5933_OUT_RANGE_AVAIL);
> +
> +static IIO_DEVICE_ATTR(in_voltage0_scale, 0644,
> +                       ad5933_show,
> +                       ad5933_store,
> +                       AD5933_IN_PGA_GAIN);
> +
> +static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
> +                       ad5933_show,
> +                       NULL,
> +                       AD5933_IN_PGA_GAIN_AVAIL);
> +
> +static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
> +                       ad5933_show,
> +                       ad5933_store,
> +                       AD5933_FREQ_POINTS);
> +
> +static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
> +                       ad5933_show,
> +                       ad5933_store,
> +                       AD5933_OUT_SETTLING_CYCLES);
> +
> +/* note:
> + * ideally we would handle the scale attributes via the iio_info
> + * (read|write)_raw methods, however this part is a untypical since we
> + * don't create dedicated sysfs channel attributes for out0 and in0.
> + */
> +static struct attribute *ad5933_attributes[] =3D {
> +       &iio_dev_attr_out_voltage0_scale.dev_attr.attr,
> +       &iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
> +       &iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
> +       &iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
> +       &iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
> +       &iio_dev_attr_out_voltage0_settling_cycles.dev_attr.attr,
> +       &iio_dev_attr_in_voltage0_scale.dev_attr.attr,
> +       &iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ad5933_attribute_group =3D {
> +       .attrs =3D ad5933_attributes,
> +};
> +
> +static int ad5933_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan,
> +                          int *val,
> +                          int *val2,
> +                          long m)
> +{
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       __be16 dat;
> +       int ret;
> +
> +       switch (m) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret =3D ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
> +               if (ret < 0)
> +                       goto out;
> +               ret =3D ad5933_wait_busy(st, AD5933_STAT_TEMP_VALID);
> +               if (ret < 0)
> +                       goto out;
> +
> +               ret =3D ad5933_i2c_read(st->client,
> +                                     AD5933_REG_TEMP_DATA,
> +                                     2, (u8 *)&dat);
> +               if (ret < 0)
> +                       goto out;
> +               iio_device_release_direct_mode(indio_dev);
> +               *val =3D sign_extend32(be16_to_cpu(dat), 13);
> +
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D 1000;
> +               *val2 =3D 5;
> +               return IIO_VAL_FRACTIONAL_LOG2;
> +       }
> +
> +       return -EINVAL;
> +out:
> +       iio_device_release_direct_mode(indio_dev);
> +       return ret;
> +}
> +
> +static const struct iio_info ad5933_info =3D {
> +       .read_raw =3D ad5933_read_raw,
> +       .attrs =3D &ad5933_attribute_group,
> +};
> +
> +static int ad5933_ring_preenable(struct iio_dev *indio_dev)
> +{
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->maskleng=
th))
> +               return -EINVAL;
> +
> +       ret =3D ad5933_reset(st);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D ad5933_cmd(st, AD5933_CTRL_STANDBY);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D ad5933_cmd(st, AD5933_CTRL_INIT_START_FREQ);
> +       if (ret < 0)
> +               return ret;
> +
> +       st->state =3D AD5933_CTRL_INIT_START_FREQ;
> +
> +       return 0;
> +}
> +
> +static int ad5933_ring_postenable(struct iio_dev *indio_dev)
> +{
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +
> +       /* AD5933_CTRL_INIT_START_FREQ:
> +        * High Q complex circuits require a long time to reach steady st=
ate.
> +        * To facilitate the measurement of such impedances, this mode al=
lows
> +        * the user full control of the settling time requirement before
> +        * entering start frequency sweep mode where the impedance measur=
ement
> +        * takes place. In this mode the impedance is excited with the
> +        * programmed start frequency (ad5933_ring_preenable),
> +        * but no measurement takes place.
> +        */
> +
> +       schedule_delayed_work(&st->work,
> +                             msecs_to_jiffies(AD5933_INIT_EXCITATION_TIM=
E_ms));
> +       return 0;
> +}
> +
> +static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
> +{
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +
> +       cancel_delayed_work_sync(&st->work);
> +       return ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
> +}
> +
> +static const struct iio_buffer_setup_ops ad5933_ring_setup_ops =3D {
> +       .preenable =3D ad5933_ring_preenable,
> +       .postenable =3D ad5933_ring_postenable,
> +       .postdisable =3D ad5933_ring_postdisable,
> +};
> +
> +static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev=
)
> +{
> +       struct iio_buffer *buffer;
> +
> +       buffer =3D iio_kfifo_allocate();
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       iio_device_attach_buffer(indio_dev, buffer);
> +
> +       /* Ring buffer functions - here trigger setup related */
> +       indio_dev->setup_ops =3D &ad5933_ring_setup_ops;
> +
> +       return 0;
> +}
> +
> +static void ad5933_work(struct work_struct *work)
> +{
> +       struct ad5933_state *st =3D container_of(work,
> +               struct ad5933_state, work.work);
> +       struct iio_dev *indio_dev =3D i2c_get_clientdata(st->client);
> +       __be16 buf[2];
> +       int val[2];
> +       unsigned char status;
> +       int ret;
> +
> +       if (st->state =3D=3D AD5933_CTRL_INIT_START_FREQ) {
> +               /* start sweep */
> +               ad5933_cmd(st, AD5933_CTRL_START_SWEEP);
> +               st->state =3D AD5933_CTRL_START_SWEEP;
> +               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> +               return;
> +       }
> +
> +       ret =3D ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status=
);
> +       if (ret)
> +               return;
> +
> +       if (status & AD5933_STAT_DATA_VALID) {
> +               int scan_count =3D bitmap_weight(indio_dev->active_scan_m=
ask,
> +                                              indio_dev->masklength);
> +               ret =3D ad5933_i2c_read(st->client,
> +                               test_bit(1, indio_dev->active_scan_mask) =
?
> +                               AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DA=
TA,
> +                               scan_count * 2, (u8 *)buf);
> +               if (ret)
> +                       return;
> +
> +               if (scan_count =3D=3D 2) {
> +                       val[0] =3D be16_to_cpu(buf[0]);
> +                       val[1] =3D be16_to_cpu(buf[1]);
> +               } else {
> +                       val[0] =3D be16_to_cpu(buf[0]);
> +               }
> +               iio_push_to_buffers(indio_dev, val);
> +       } else {
> +               /* no data available - try again later */
> +               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> +               return;
> +       }
> +
> +       if (status & AD5933_STAT_SWEEP_DONE) {
> +               /* last sample received - power down do
> +                * nothing until the ring enable is toggled
> +                */
> +               ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
> +       } else {
> +               /* we just received a valid datum, move on to the next */
> +               ad5933_cmd(st, AD5933_CTRL_INC_FREQ);
> +               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> +       }
> +}
> +
> +static int ad5933_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       int ret;
> +       struct ad5933_state *st;
> +       struct iio_dev *indio_dev;
> +       unsigned long ext_clk_hz =3D 0;
> +
> +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       st->client =3D client;
> +
> +       mutex_init(&st->lock);
> +
> +       st->reg =3D devm_regulator_get(&client->dev, "vdd");
> +       if (IS_ERR(st->reg))
> +               return PTR_ERR(st->reg);
> +
> +       ret =3D regulator_enable(st->reg);
> +       if (ret) {
> +               dev_err(&client->dev, "Failed to enable specified VDD sup=
ply\n");
> +               return ret;
> +       }
> +       ret =3D regulator_get_voltage(st->reg);
> +
> +       if (ret < 0)
> +               goto error_disable_reg;
> +
> +       st->vref_mv =3D ret / 1000;
> +
> +       st->mclk =3D devm_clk_get(&client->dev, "mclk");
> +       if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) !=3D -ENOENT) {
> +               ret =3D PTR_ERR(st->mclk);
> +               goto error_disable_reg;
> +       }
> +
> +       if (!IS_ERR(st->mclk)) {
> +               ret =3D clk_prepare_enable(st->mclk);
> +               if (ret < 0)
> +                       goto error_disable_reg;
> +               ext_clk_hz =3D clk_get_rate(st->mclk);
> +       }
> +
> +       if (ext_clk_hz) {
> +               st->mclk_hz =3D ext_clk_hz;
> +               st->ctrl_lb =3D AD5933_CTRL_EXT_SYSCLK;
> +       } else {
> +               st->mclk_hz =3D AD5933_INT_OSC_FREQ_Hz;
> +               st->ctrl_lb =3D AD5933_CTRL_INT_SYSCLK;
> +       }
> +
> +       ad5933_calc_out_ranges(st);
> +       INIT_DELAYED_WORK(&st->work, ad5933_work);
> +       st->poll_time_jiffies =3D msecs_to_jiffies(AD5933_POLL_TIME_ms);
> +
> +       indio_dev->dev.parent =3D &client->dev;
> +       indio_dev->info =3D &ad5933_info;
> +       indio_dev->name =3D id->name;
> +       indio_dev->modes =3D (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
> +       indio_dev->channels =3D ad5933_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(ad5933_channels);
> +
> +       ret =3D ad5933_register_ring_funcs_and_init(indio_dev);
> +       if (ret)
> +               goto error_disable_mclk;
> +
> +       ret =3D ad5933_setup(st);
> +       if (ret)
> +               goto error_unreg_ring;
> +
> +       ret =3D iio_device_register(indio_dev);
> +       if (ret)
> +               goto error_unreg_ring;
> +
> +       return 0;
> +
> +error_unreg_ring:
> +       iio_kfifo_free(indio_dev->buffer);
> +error_disable_mclk:
> +       clk_disable_unprepare(st->mclk);
> +error_disable_reg:
> +       regulator_disable(st->reg);
> +
> +       return ret;
> +}
> +
> +static int ad5933_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +       struct ad5933_state *st =3D iio_priv(indio_dev);
> +
> +       iio_device_unregister(indio_dev);
> +       iio_kfifo_free(indio_dev->buffer);
> +       regulator_disable(st->reg);
> +       clk_disable_unprepare(st->mclk);
> +
> +       return 0;
> +}
> +
> +static const struct i2c_device_id ad5933_id[] =3D {
> +       { "ad5933", 0 },
> +       { "ad5934", 0 },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ad5933_id);
> +
> +static const struct of_device_id ad5933_of_match[] =3D {
> +       { .compatible =3D "adi,ad5933" },
> +       { .compatible =3D "adi,ad5934" },
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
> +static struct i2c_driver ad5933_driver =3D {
> +       .driver =3D {
> +               .name =3D "ad5933",
> +               .of_match_table =3D ad5933_of_match,
> +       },
> +       .probe =3D ad5933_probe,
> +       .remove =3D ad5933_remove,
> +       .id_table =3D ad5933_id,
> +};
> +module_i2c_driver(ad5933_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5933 Impedance Conv. Network Analyz=
er");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/sta=
ging/iio/impedance-analyzer/Kconfig
> deleted file mode 100644
> index dd97b6bb3fd0..000000000000
> --- a/drivers/staging/iio/impedance-analyzer/Kconfig
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -#
> -# Impedance Converter, Network Analyzer drivers
> -#
> -menu "Network Analyzer, Impedance Converters"
> -
> -config AD5933
> -       tristate "Analog Devices AD5933, AD5934 driver"
> -       depends on I2C
> -       select IIO_BUFFER
> -       select IIO_KFIFO_BUF
> -       help
> -         Say yes here to build support for Analog Devices Impedance Conv=
erter,
> -         Network Analyzer, AD5933/4, provides direct access via sysfs.
> -
> -         To compile this driver as a module, choose M here: the
> -         module will be called ad5933.
> -
> -endmenu
> diff --git a/drivers/staging/iio/impedance-analyzer/Makefile b/drivers/st=
aging/iio/impedance-analyzer/Makefile
> deleted file mode 100644
> index 7604d786583e..000000000000
> --- a/drivers/staging/iio/impedance-analyzer/Makefile
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -#
> -# Makefile for Impedance Converter, Network Analyzer drivers
> -#
> -
> -obj-$(CONFIG_AD5933) +=3D ad5933.o
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> deleted file mode 100644
> index 3134295f014f..000000000000
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ /dev/null
> @@ -1,809 +0,0 @@
> -/*
> - * AD5933 AD5934 Impedance Converter, Network Analyzer
> - *
> - * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/sysfs.h>
> -#include <linux/i2c.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/types.h>
> -#include <linux/err.h>
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/clk.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/kfifo_buf.h>
> -
> -/* AD5933/AD5934 Registers */
> -#define AD5933_REG_CONTROL_HB          0x80    /* R/W, 1 byte */
> -#define AD5933_REG_CONTROL_LB          0x81    /* R/W, 1 byte */
> -#define AD5933_REG_FREQ_START          0x82    /* R/W, 3 bytes */
> -#define AD5933_REG_FREQ_INC            0x85    /* R/W, 3 bytes */
> -#define AD5933_REG_INC_NUM             0x88    /* R/W, 2 bytes, 9 bit */
> -#define AD5933_REG_SETTLING_CYCLES     0x8A    /* R/W, 2 bytes */
> -#define AD5933_REG_STATUS              0x8F    /* R, 1 byte */
> -#define AD5933_REG_TEMP_DATA           0x92    /* R, 2 bytes*/
> -#define AD5933_REG_REAL_DATA           0x94    /* R, 2 bytes*/
> -#define AD5933_REG_IMAG_DATA           0x96    /* R, 2 bytes*/
> -
> -/* AD5933_REG_CONTROL_HB Bits */
> -#define AD5933_CTRL_INIT_START_FREQ    (0x1 << 4)
> -#define AD5933_CTRL_START_SWEEP                (0x2 << 4)
> -#define AD5933_CTRL_INC_FREQ           (0x3 << 4)
> -#define AD5933_CTRL_REPEAT_FREQ                (0x4 << 4)
> -#define AD5933_CTRL_MEASURE_TEMP       (0x9 << 4)
> -#define AD5933_CTRL_POWER_DOWN         (0xA << 4)
> -#define AD5933_CTRL_STANDBY            (0xB << 4)
> -
> -#define AD5933_CTRL_RANGE_2000mVpp     (0x0 << 1)
> -#define AD5933_CTRL_RANGE_200mVpp      (0x1 << 1)
> -#define AD5933_CTRL_RANGE_400mVpp      (0x2 << 1)
> -#define AD5933_CTRL_RANGE_1000mVpp     (0x3 << 1)
> -#define AD5933_CTRL_RANGE(x)           ((x) << 1)
> -
> -#define AD5933_CTRL_PGA_GAIN_1         (0x1 << 0)
> -#define AD5933_CTRL_PGA_GAIN_5         (0x0 << 0)
> -
> -/* AD5933_REG_CONTROL_LB Bits */
> -#define AD5933_CTRL_RESET              (0x1 << 4)
> -#define AD5933_CTRL_INT_SYSCLK         (0x0 << 3)
> -#define AD5933_CTRL_EXT_SYSCLK         (0x1 << 3)
> -
> -/* AD5933_REG_STATUS Bits */
> -#define AD5933_STAT_TEMP_VALID         (0x1 << 0)
> -#define AD5933_STAT_DATA_VALID         (0x1 << 1)
> -#define AD5933_STAT_SWEEP_DONE         (0x1 << 2)
> -
> -/* I2C Block Commands */
> -#define AD5933_I2C_BLOCK_WRITE         0xA0
> -#define AD5933_I2C_BLOCK_READ          0xA1
> -#define AD5933_I2C_ADDR_POINTER                0xB0
> -
> -/* Device Specs */
> -#define AD5933_INT_OSC_FREQ_Hz         16776000
> -#define AD5933_MAX_OUTPUT_FREQ_Hz      100000
> -#define AD5933_MAX_RETRIES             100
> -
> -#define AD5933_OUT_RANGE               1
> -#define AD5933_OUT_RANGE_AVAIL         2
> -#define AD5933_OUT_SETTLING_CYCLES     3
> -#define AD5933_IN_PGA_GAIN             4
> -#define AD5933_IN_PGA_GAIN_AVAIL       5
> -#define AD5933_FREQ_POINTS             6
> -
> -#define AD5933_POLL_TIME_ms            10
> -#define AD5933_INIT_EXCITATION_TIME_ms 100
> -
> -struct ad5933_state {
> -       struct i2c_client               *client;
> -       struct regulator                *reg;
> -       struct clk                      *mclk;
> -       struct delayed_work             work;
> -       struct mutex                    lock; /* Protect sensor state */
> -       unsigned long                   mclk_hz;
> -       unsigned char                   ctrl_hb;
> -       unsigned char                   ctrl_lb;
> -       unsigned int                    range_avail[4];
> -       unsigned short                  vref_mv;
> -       unsigned short                  settling_cycles;
> -       unsigned short                  freq_points;
> -       unsigned int                    freq_start;
> -       unsigned int                    freq_inc;
> -       unsigned int                    state;
> -       unsigned int                    poll_time_jiffies;
> -};
> -
> -#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _addres=
s, \
> -               _scan_index, _realbits) { \
> -       .type =3D (_type), \
> -       .extend_name =3D (_extend_name), \
> -       .info_mask_separate =3D (_info_mask_separate), \
> -       .address =3D (_address), \
> -       .scan_index =3D (_scan_index), \
> -       .scan_type =3D { \
> -               .sign =3D 's', \
> -               .realbits =3D (_realbits), \
> -               .storagebits =3D 16, \
> -       }, \
> -}
> -
> -static const struct iio_chan_spec ad5933_channels[] =3D {
> -       AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
> -               BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
> -       /* Ring Channels */
> -       AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 1=
6),
> -       AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 1=
6),
> -};
> -
> -static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u=
8 *data)
> -{
> -       int ret;
> -
> -       while (len--) {
> -               ret =3D i2c_smbus_write_byte_data(client, reg++, *data++)=
;
> -               if (ret < 0) {
> -                       dev_err(&client->dev, "I2C write error\n");
> -                       return ret;
> -               }
> -       }
> -       return 0;
> -}
> -
> -static int ad5933_i2c_read(struct i2c_client *client, u8 reg, u8 len, u8=
 *data)
> -{
> -       int ret;
> -
> -       while (len--) {
> -               ret =3D i2c_smbus_read_byte_data(client, reg++);
> -               if (ret < 0) {
> -                       dev_err(&client->dev, "I2C read error\n");
> -                       return ret;
> -               }
> -               *data++ =3D ret;
> -       }
> -       return 0;
> -}
> -
> -static int ad5933_cmd(struct ad5933_state *st, unsigned char cmd)
> -{
> -       unsigned char dat =3D st->ctrl_hb | cmd;
> -
> -       return ad5933_i2c_write(st->client,
> -                       AD5933_REG_CONTROL_HB, 1, &dat);
> -}
> -
> -static int ad5933_reset(struct ad5933_state *st)
> -{
> -       unsigned char dat =3D st->ctrl_lb | AD5933_CTRL_RESET;
> -
> -       return ad5933_i2c_write(st->client,
> -                       AD5933_REG_CONTROL_LB, 1, &dat);
> -}
> -
> -static int ad5933_wait_busy(struct ad5933_state *st, unsigned char event=
)
> -{
> -       unsigned char val, timeout =3D AD5933_MAX_RETRIES;
> -       int ret;
> -
> -       while (timeout--) {
> -               ret =3D  ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1=
, &val);
> -               if (ret < 0)
> -                       return ret;
> -               if (val & event)
> -                       return val;
> -               cpu_relax();
> -               mdelay(1);
> -       }
> -
> -       return -EAGAIN;
> -}
> -
> -static int ad5933_set_freq(struct ad5933_state *st,
> -                          unsigned int reg, unsigned long freq)
> -{
> -       unsigned long long freqreg;
> -       union {
> -               __be32 d32;
> -               u8 d8[4];
> -       } dat;
> -
> -       freqreg =3D (u64)freq * (u64)(1 << 27);
> -       do_div(freqreg, st->mclk_hz / 4);
> -
> -       switch (reg) {
> -       case AD5933_REG_FREQ_START:
> -               st->freq_start =3D freq;
> -               break;
> -       case AD5933_REG_FREQ_INC:
> -               st->freq_inc =3D freq;
> -               break;
> -       default:
> -               return -EINVAL;
> -       }
> -
> -       dat.d32 =3D cpu_to_be32(freqreg);
> -       return ad5933_i2c_write(st->client, reg, 3, &dat.d8[1]);
> -}
> -
> -static int ad5933_setup(struct ad5933_state *st)
> -{
> -       __be16 dat;
> -       int ret;
> -
> -       ret =3D ad5933_reset(st);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D ad5933_set_freq(st, AD5933_REG_FREQ_START, 10000);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D ad5933_set_freq(st, AD5933_REG_FREQ_INC, 200);
> -       if (ret < 0)
> -               return ret;
> -
> -       st->settling_cycles =3D 10;
> -       dat =3D cpu_to_be16(st->settling_cycles);
> -
> -       ret =3D ad5933_i2c_write(st->client,
> -                              AD5933_REG_SETTLING_CYCLES,
> -                              2, (u8 *)&dat);
> -       if (ret < 0)
> -               return ret;
> -
> -       st->freq_points =3D 100;
> -       dat =3D cpu_to_be16(st->freq_points);
> -
> -       return ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, 2, (u8 *)=
&dat);
> -}
> -
> -static void ad5933_calc_out_ranges(struct ad5933_state *st)
> -{
> -       int i;
> -       unsigned int normalized_3v3[4] =3D {1980, 198, 383, 970};
> -
> -       for (i =3D 0; i < 4; i++)
> -               st->range_avail[i] =3D normalized_3v3[i] * st->vref_mv / =
3300;
> -}
> -
> -/*
> - * handles: AD5933_REG_FREQ_START and AD5933_REG_FREQ_INC
> - */
> -
> -static ssize_t ad5933_show_frequency(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    char *buf)
> -{
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> -       int ret;
> -       unsigned long long freqreg;
> -       union {
> -               __be32 d32;
> -               u8 d8[4];
> -       } dat;
> -
> -       ret =3D iio_device_claim_direct_mode(indio_dev);
> -       if (ret)
> -               return ret;
> -       ret =3D ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d=
8[1]);
> -       iio_device_release_direct_mode(indio_dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       freqreg =3D be32_to_cpu(dat.d32) & 0xFFFFFF;
> -
> -       freqreg =3D (u64)freqreg * (u64)(st->mclk_hz / 4);
> -       do_div(freqreg, 1 << 27);
> -
> -       return sprintf(buf, "%d\n", (int)freqreg);
> -}
> -
> -static ssize_t ad5933_store_frequency(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     const char *buf,
> -                                     size_t len)
> -{
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> -       unsigned long val;
> -       int ret;
> -
> -       ret =3D kstrtoul(buf, 10, &val);
> -       if (ret)
> -               return ret;
> -
> -       if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
> -               return -EINVAL;
> -
> -       ret =3D iio_device_claim_direct_mode(indio_dev);
> -       if (ret)
> -               return ret;
> -       ret =3D ad5933_set_freq(st, this_attr->address, val);
> -       iio_device_release_direct_mode(indio_dev);
> -
> -       return ret ? ret : len;
> -}
> -
> -static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
> -                       ad5933_show_frequency,
> -                       ad5933_store_frequency,
> -                       AD5933_REG_FREQ_START);
> -
> -static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
> -                       ad5933_show_frequency,
> -                       ad5933_store_frequency,
> -                       AD5933_REG_FREQ_INC);
> -
> -static ssize_t ad5933_show(struct device *dev,
> -                          struct device_attribute *attr,
> -                          char *buf)
> -{
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> -       int ret =3D 0, len =3D 0;
> -
> -       mutex_lock(&st->lock);
> -       switch ((u32)this_attr->address) {
> -       case AD5933_OUT_RANGE:
> -               len =3D sprintf(buf, "%u\n",
> -                             st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
> -               break;
> -       case AD5933_OUT_RANGE_AVAIL:
> -               len =3D sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
> -                             st->range_avail[3], st->range_avail[2],
> -                             st->range_avail[1]);
> -               break;
> -       case AD5933_OUT_SETTLING_CYCLES:
> -               len =3D sprintf(buf, "%d\n", st->settling_cycles);
> -               break;
> -       case AD5933_IN_PGA_GAIN:
> -               len =3D sprintf(buf, "%s\n",
> -                             (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> -                             "1" : "0.2");
> -               break;
> -       case AD5933_IN_PGA_GAIN_AVAIL:
> -               len =3D sprintf(buf, "1 0.2\n");
> -               break;
> -       case AD5933_FREQ_POINTS:
> -               len =3D sprintf(buf, "%d\n", st->freq_points);
> -               break;
> -       default:
> -               ret =3D -EINVAL;
> -       }
> -
> -       mutex_unlock(&st->lock);
> -       return ret ? ret : len;
> -}
> -
> -static ssize_t ad5933_store(struct device *dev,
> -                           struct device_attribute *attr,
> -                           const char *buf,
> -                           size_t len)
> -{
> -       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> -       u16 val;
> -       int i, ret =3D 0;
> -       __be16 dat;
> -
> -       if (this_attr->address !=3D AD5933_IN_PGA_GAIN) {
> -               ret =3D kstrtou16(buf, 10, &val);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       ret =3D iio_device_claim_direct_mode(indio_dev);
> -       if (ret)
> -               return ret;
> -       mutex_lock(&st->lock);
> -       switch ((u32)this_attr->address) {
> -       case AD5933_OUT_RANGE:
> -               ret =3D -EINVAL;
> -               for (i =3D 0; i < 4; i++)
> -                       if (val =3D=3D st->range_avail[i]) {
> -                               st->ctrl_hb &=3D ~AD5933_CTRL_RANGE(0x3);
> -                               st->ctrl_hb |=3D AD5933_CTRL_RANGE(i);
> -                               ret =3D ad5933_cmd(st, 0);
> -                               break;
> -                       }
> -               break;
> -       case AD5933_IN_PGA_GAIN:
> -               if (sysfs_streq(buf, "1")) {
> -                       st->ctrl_hb |=3D AD5933_CTRL_PGA_GAIN_1;
> -               } else if (sysfs_streq(buf, "0.2")) {
> -                       st->ctrl_hb &=3D ~AD5933_CTRL_PGA_GAIN_1;
> -               } else {
> -                       ret =3D -EINVAL;
> -                       break;
> -               }
> -               ret =3D ad5933_cmd(st, 0);
> -               break;
> -       case AD5933_OUT_SETTLING_CYCLES:
> -               val =3D clamp(val, (u16)0, (u16)0x7FF);
> -               st->settling_cycles =3D val;
> -
> -               /* 2x, 4x handling, see datasheet */
> -               if (val > 1022)
> -                       val =3D (val >> 2) | (3 << 9);
> -               else if (val > 511)
> -                       val =3D (val >> 1) | (1 << 9);
> -
> -               dat =3D cpu_to_be16(val);
> -               ret =3D ad5933_i2c_write(st->client,
> -                                      AD5933_REG_SETTLING_CYCLES,
> -                                      2, (u8 *)&dat);
> -               break;
> -       case AD5933_FREQ_POINTS:
> -               val =3D clamp(val, (u16)0, (u16)511);
> -               st->freq_points =3D val;
> -
> -               dat =3D cpu_to_be16(val);
> -               ret =3D ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, =
2,
> -                                      (u8 *)&dat);
> -               break;
> -       default:
> -               ret =3D -EINVAL;
> -       }
> -
> -       mutex_unlock(&st->lock);
> -       iio_device_release_direct_mode(indio_dev);
> -       return ret ? ret : len;
> -}
> -
> -static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
> -                       ad5933_show,
> -                       ad5933_store,
> -                       AD5933_OUT_RANGE);
> -
> -static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
> -                       ad5933_show,
> -                       NULL,
> -                       AD5933_OUT_RANGE_AVAIL);
> -
> -static IIO_DEVICE_ATTR(in_voltage0_scale, 0644,
> -                       ad5933_show,
> -                       ad5933_store,
> -                       AD5933_IN_PGA_GAIN);
> -
> -static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
> -                       ad5933_show,
> -                       NULL,
> -                       AD5933_IN_PGA_GAIN_AVAIL);
> -
> -static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
> -                       ad5933_show,
> -                       ad5933_store,
> -                       AD5933_FREQ_POINTS);
> -
> -static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
> -                       ad5933_show,
> -                       ad5933_store,
> -                       AD5933_OUT_SETTLING_CYCLES);
> -
> -/* note:
> - * ideally we would handle the scale attributes via the iio_info
> - * (read|write)_raw methods, however this part is a untypical since we
> - * don't create dedicated sysfs channel attributes for out0 and in0.
> - */
> -static struct attribute *ad5933_attributes[] =3D {
> -       &iio_dev_attr_out_voltage0_scale.dev_attr.attr,
> -       &iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
> -       &iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
> -       &iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
> -       &iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
> -       &iio_dev_attr_out_voltage0_settling_cycles.dev_attr.attr,
> -       &iio_dev_attr_in_voltage0_scale.dev_attr.attr,
> -       &iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
> -       NULL
> -};
> -
> -static const struct attribute_group ad5933_attribute_group =3D {
> -       .attrs =3D ad5933_attributes,
> -};
> -
> -static int ad5933_read_raw(struct iio_dev *indio_dev,
> -                          struct iio_chan_spec const *chan,
> -                          int *val,
> -                          int *val2,
> -                          long m)
> -{
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       __be16 dat;
> -       int ret;
> -
> -       switch (m) {
> -       case IIO_CHAN_INFO_RAW:
> -               ret =3D iio_device_claim_direct_mode(indio_dev);
> -               if (ret)
> -                       return ret;
> -               ret =3D ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
> -               if (ret < 0)
> -                       goto out;
> -               ret =3D ad5933_wait_busy(st, AD5933_STAT_TEMP_VALID);
> -               if (ret < 0)
> -                       goto out;
> -
> -               ret =3D ad5933_i2c_read(st->client,
> -                                     AD5933_REG_TEMP_DATA,
> -                                     2, (u8 *)&dat);
> -               if (ret < 0)
> -                       goto out;
> -               iio_device_release_direct_mode(indio_dev);
> -               *val =3D sign_extend32(be16_to_cpu(dat), 13);
> -
> -               return IIO_VAL_INT;
> -       case IIO_CHAN_INFO_SCALE:
> -               *val =3D 1000;
> -               *val2 =3D 5;
> -               return IIO_VAL_FRACTIONAL_LOG2;
> -       }
> -
> -       return -EINVAL;
> -out:
> -       iio_device_release_direct_mode(indio_dev);
> -       return ret;
> -}
> -
> -static const struct iio_info ad5933_info =3D {
> -       .read_raw =3D ad5933_read_raw,
> -       .attrs =3D &ad5933_attribute_group,
> -};
> -
> -static int ad5933_ring_preenable(struct iio_dev *indio_dev)
> -{
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -       int ret;
> -
> -       if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->maskleng=
th))
> -               return -EINVAL;
> -
> -       ret =3D ad5933_reset(st);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D ad5933_cmd(st, AD5933_CTRL_STANDBY);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D ad5933_cmd(st, AD5933_CTRL_INIT_START_FREQ);
> -       if (ret < 0)
> -               return ret;
> -
> -       st->state =3D AD5933_CTRL_INIT_START_FREQ;
> -
> -       return 0;
> -}
> -
> -static int ad5933_ring_postenable(struct iio_dev *indio_dev)
> -{
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -
> -       /* AD5933_CTRL_INIT_START_FREQ:
> -        * High Q complex circuits require a long time to reach steady st=
ate.
> -        * To facilitate the measurement of such impedances, this mode al=
lows
> -        * the user full control of the settling time requirement before
> -        * entering start frequency sweep mode where the impedance measur=
ement
> -        * takes place. In this mode the impedance is excited with the
> -        * programmed start frequency (ad5933_ring_preenable),
> -        * but no measurement takes place.
> -        */
> -
> -       schedule_delayed_work(&st->work,
> -                             msecs_to_jiffies(AD5933_INIT_EXCITATION_TIM=
E_ms));
> -       return 0;
> -}
> -
> -static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
> -{
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -
> -       cancel_delayed_work_sync(&st->work);
> -       return ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
> -}
> -
> -static const struct iio_buffer_setup_ops ad5933_ring_setup_ops =3D {
> -       .preenable =3D ad5933_ring_preenable,
> -       .postenable =3D ad5933_ring_postenable,
> -       .postdisable =3D ad5933_ring_postdisable,
> -};
> -
> -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev=
)
> -{
> -       struct iio_buffer *buffer;
> -
> -       buffer =3D iio_kfifo_allocate();
> -       if (!buffer)
> -               return -ENOMEM;
> -
> -       iio_device_attach_buffer(indio_dev, buffer);
> -
> -       /* Ring buffer functions - here trigger setup related */
> -       indio_dev->setup_ops =3D &ad5933_ring_setup_ops;
> -
> -       return 0;
> -}
> -
> -static void ad5933_work(struct work_struct *work)
> -{
> -       struct ad5933_state *st =3D container_of(work,
> -               struct ad5933_state, work.work);
> -       struct iio_dev *indio_dev =3D i2c_get_clientdata(st->client);
> -       __be16 buf[2];
> -       int val[2];
> -       unsigned char status;
> -       int ret;
> -
> -       if (st->state =3D=3D AD5933_CTRL_INIT_START_FREQ) {
> -               /* start sweep */
> -               ad5933_cmd(st, AD5933_CTRL_START_SWEEP);
> -               st->state =3D AD5933_CTRL_START_SWEEP;
> -               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> -               return;
> -       }
> -
> -       ret =3D ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status=
);
> -       if (ret)
> -               return;
> -
> -       if (status & AD5933_STAT_DATA_VALID) {
> -               int scan_count =3D bitmap_weight(indio_dev->active_scan_m=
ask,
> -                                              indio_dev->masklength);
> -               ret =3D ad5933_i2c_read(st->client,
> -                               test_bit(1, indio_dev->active_scan_mask) =
?
> -                               AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DA=
TA,
> -                               scan_count * 2, (u8 *)buf);
> -               if (ret)
> -                       return;
> -
> -               if (scan_count =3D=3D 2) {
> -                       val[0] =3D be16_to_cpu(buf[0]);
> -                       val[1] =3D be16_to_cpu(buf[1]);
> -               } else {
> -                       val[0] =3D be16_to_cpu(buf[0]);
> -               }
> -               iio_push_to_buffers(indio_dev, val);
> -       } else {
> -               /* no data available - try again later */
> -               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> -               return;
> -       }
> -
> -       if (status & AD5933_STAT_SWEEP_DONE) {
> -               /* last sample received - power down do
> -                * nothing until the ring enable is toggled
> -                */
> -               ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
> -       } else {
> -               /* we just received a valid datum, move on to the next */
> -               ad5933_cmd(st, AD5933_CTRL_INC_FREQ);
> -               schedule_delayed_work(&st->work, st->poll_time_jiffies);
> -       }
> -}
> -
> -static int ad5933_probe(struct i2c_client *client,
> -                       const struct i2c_device_id *id)
> -{
> -       int ret;
> -       struct ad5933_state *st;
> -       struct iio_dev *indio_dev;
> -       unsigned long ext_clk_hz =3D 0;
> -
> -       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> -       if (!indio_dev)
> -               return -ENOMEM;
> -
> -       st =3D iio_priv(indio_dev);
> -       i2c_set_clientdata(client, indio_dev);
> -       st->client =3D client;
> -
> -       mutex_init(&st->lock);
> -
> -       st->reg =3D devm_regulator_get(&client->dev, "vdd");
> -       if (IS_ERR(st->reg))
> -               return PTR_ERR(st->reg);
> -
> -       ret =3D regulator_enable(st->reg);
> -       if (ret) {
> -               dev_err(&client->dev, "Failed to enable specified VDD sup=
ply\n");
> -               return ret;
> -       }
> -       ret =3D regulator_get_voltage(st->reg);
> -
> -       if (ret < 0)
> -               goto error_disable_reg;
> -
> -       st->vref_mv =3D ret / 1000;
> -
> -       st->mclk =3D devm_clk_get(&client->dev, "mclk");
> -       if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) !=3D -ENOENT) {
> -               ret =3D PTR_ERR(st->mclk);
> -               goto error_disable_reg;
> -       }
> -
> -       if (!IS_ERR(st->mclk)) {
> -               ret =3D clk_prepare_enable(st->mclk);
> -               if (ret < 0)
> -                       goto error_disable_reg;
> -               ext_clk_hz =3D clk_get_rate(st->mclk);
> -       }
> -
> -       if (ext_clk_hz) {
> -               st->mclk_hz =3D ext_clk_hz;
> -               st->ctrl_lb =3D AD5933_CTRL_EXT_SYSCLK;
> -       } else {
> -               st->mclk_hz =3D AD5933_INT_OSC_FREQ_Hz;
> -               st->ctrl_lb =3D AD5933_CTRL_INT_SYSCLK;
> -       }
> -
> -       ad5933_calc_out_ranges(st);
> -       INIT_DELAYED_WORK(&st->work, ad5933_work);
> -       st->poll_time_jiffies =3D msecs_to_jiffies(AD5933_POLL_TIME_ms);
> -
> -       indio_dev->dev.parent =3D &client->dev;
> -       indio_dev->info =3D &ad5933_info;
> -       indio_dev->name =3D id->name;
> -       indio_dev->modes =3D (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
> -       indio_dev->channels =3D ad5933_channels;
> -       indio_dev->num_channels =3D ARRAY_SIZE(ad5933_channels);
> -
> -       ret =3D ad5933_register_ring_funcs_and_init(indio_dev);
> -       if (ret)
> -               goto error_disable_mclk;
> -
> -       ret =3D ad5933_setup(st);
> -       if (ret)
> -               goto error_unreg_ring;
> -
> -       ret =3D iio_device_register(indio_dev);
> -       if (ret)
> -               goto error_unreg_ring;
> -
> -       return 0;
> -
> -error_unreg_ring:
> -       iio_kfifo_free(indio_dev->buffer);
> -error_disable_mclk:
> -       clk_disable_unprepare(st->mclk);
> -error_disable_reg:
> -       regulator_disable(st->reg);
> -
> -       return ret;
> -}
> -
> -static int ad5933_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -       struct ad5933_state *st =3D iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       iio_kfifo_free(indio_dev->buffer);
> -       regulator_disable(st->reg);
> -       clk_disable_unprepare(st->mclk);
> -
> -       return 0;
> -}
> -
> -static const struct i2c_device_id ad5933_id[] =3D {
> -       { "ad5933", 0 },
> -       { "ad5934", 0 },
> -       {}
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, ad5933_id);
> -
> -static const struct of_device_id ad5933_of_match[] =3D {
> -       { .compatible =3D "adi,ad5933" },
> -       { .compatible =3D "adi,ad5934" },
> -       { },
> -};
> -
> -MODULE_DEVICE_TABLE(of, ad5933_of_match);
> -
> -static struct i2c_driver ad5933_driver =3D {
> -       .driver =3D {
> -               .name =3D "ad5933",
> -               .of_match_table =3D ad5933_of_match,
> -       },
> -       .probe =3D ad5933_probe,
> -       .remove =3D ad5933_remove,
> -       .id_table =3D ad5933_id,
> -};
> -module_i2c_driver(ad5933_driver);
> -
> -MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD5933 Impedance Conv. Network Analyz=
er");
> -MODULE_LICENSE("GPL v2");
> --
> 2.20.1

