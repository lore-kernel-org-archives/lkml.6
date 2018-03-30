Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4/LJzryR+qyeQvdTtXjnO9PvjS6KTEjGrlpxXjaJWT48zqaJE56VPE+9S0mUfAl57zvaNca
ARC-Seal: i=1; a=rsa-sha256; t=1522418276; cv=none;
        d=google.com; s=arc-20160816;
        b=wqoSHUhv/+SonOUKCh6M48sVncbQ1pLmuC7GHw/D9TnRdrf3Z4PkyJ5VHxNO/+33YY
         Y3lK+kn0UveaW6FDc/H88WK0qCZJuZlFU/pAXiYr2sOmp+p3ExqCPghBdnViNtsHFDmA
         CR4g5CF9AWYkFt/Al44pi9dXH/GLzqd+9DXFHRibIM53mItrn2/wMMFC4OC5q/9mfV6d
         F2J97jpfoqzbVSoqknZmGvkgZDKT3j2AGUGstAc/W83U0aW3flO/A7ztY8q90LbUOo17
         zQYFHUh+kQk4yGeF+PdDbgFxEFnR2/LVUejIiwXg7QJFuMIiV8IoG6HfvSIirCoDQx15
         KC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CsIhWOLfJR5PlZRqDXl3ppaDG34FBs7JUKrVtM+efTY=;
        b=CZxsjJXuMgWbZRM0XjMYar8X5Lcm2bsQp2qrbJz7uq71G0lBTGHR3teuv2UpJjtlvo
         Q4LKEdBBZQTQkIPl6Q7wnEK5zrgFt+1bWp28PHFhC1bja9KNxdQguiDaSifmItNhX99Y
         REdqxQvmnUL6UQAkWFAHv89/wu6FVM3f2Ri69H+d44yYMFv3gEaC+VNZpquHc4TSh2Qr
         KCDKy0KA2fL0v9Q6DWzET4AZGc/bYlISNIrE+81b7TjSeJv+22J52Un0h77vkOrGy8y+
         DAzGNbeLZnVXumy5ddYrRTQsAM+h0sqKXwBikFIJ2+sF10+AnrDtq75o+abDG3W7RJ9P
         BzdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=KfBEOoCG;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.36.63 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=KfBEOoCG;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.36.63 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <davem@davemloft.net>,
	<gregkh@linuxfoundation.org>, <mchehab@kernel.org>,
	<linus.walleij@linaro.org>, <rdunlap@infradead.org>,
	<Ismail.Kose@maximintegrated.com>, <lukas@wunner.de>,
	<mike.looijmans@topic.nl>, <fabrice.gasnier@st.com>,
	<linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 3/3] iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support
Date: Fri, 30 Mar 2018 16:56:49 +0300
Message-ID: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(16586007)(26005)(316002)(246002)(49486002)(54906003)(72206003)(126002)(110136005)(426003)(2616005)(77096007)(186003)(966005)(476003)(486005)(478600001)(106466001)(486005)(59450400001)(305945005)(7636002)(356003)(4326008)(5660300001)(575784001)(7416002)(107886003)(2201001)(50466002)(1720100001)(6306002)(47776003)(8666007)(51416003)(336012)(2906002)(36756003)(106002)(48376002)(50226002)(8676002)(8936002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2192;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD024;1:Zj0IX80/KMpefY2UHrRZkRr1WcgLcle7C1IpwUD8lFRRovBVAXgc/bspQX8YIZi5e2fIjj/fGoMXaybjcP/hI+ypSm1UVL+8cU3y9j8URdDlDuN9kZXq49q55PlZZ8vj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0edc126-ba85-47de-a3fd-08d596463a88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN2PR03MB2192;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2192;3:BDY7YrdvKtEcWrTatBwTwmf/h0vGXwunbrQW+UdTGMQgbyY4lnN7tfWRiGfFhrR4O9pWsz5khe81AsgjCCBGYFIUq4CCMkdfaN2k+fuRZUeTJzAnNdrcjVmC2Nc9YtXqXwpXyPo+no2LFlW+xdQKRBhvqQMSZIDSYt06k7Q1s8qirZa3FTI1zy9N5tTJbhVSsqZsBAvh/5/GSx+jyaPCshaDmr8Ufz72mMqj/Qm6gocR9dQq/jJ5iDx46Idhzmz2P22IIuuo6pD64Sz2bGswoIfPGD20cCS1lVKxGv1EyNOaU9AUrHcSV3AOPWm2XTgw0WTIWkHhLZGP20SEIa+elGAUd0xB7a6pO2y+x1AwdYs=;25:KXIv3e0S2pmhkcGtS+Qq37mfXtAp8CD6XuKSHwA358DaIrvRZYaG6lZgwUBAE2qQU+PIXQtf3DzEmDjFsyLDsI67tfqn+aDo0jyXEBLEa2h+9M/AyY9SLNyMSxqyoZ2aiSgV1tldGzUqJ9ghelTWmWFtaJxnmGrkeCFCl17KBUMcwwlQP8zjKPuDeh+wXjDCNxEilIvIAwoquoMjn5GjIiwnIAZlestW5jWFFpmXyK0FaLZa4lKSF2VKaQDdcRk17pxvxPMYppgByZc6XMJ49dOkwyYba03Srrt8h4qAzni7vZxMpdjnlQXh9x5cEPRB/rmCneF49OqEto5VKI0A/Q==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2192:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2192;31:+65IeFz8d/PH/kcbllngo/IMMTKcdQP6KAwZxczHKTOBFnFMZ8Uzn+TZzYe3Yu92mU4envP9LrVz7n6X84Qi8GtY1/72CD0PuFECIAGjplqfadXKwddlUp39W+3FdEotOVL8mmXs8JlpqJegjvue9D873rOwee+BJuxSlP2kkkBz1ohtXKqJnNTDSobjsnnmYm8n1SKI+/KA9kqp7Z9gPthoknotm5iBMaGz+izZ4GA=;20:Btue1efBkVJFc/gl9PPzla5CrthqZwJFjNPCwBw2IPlI0+JP0o5o1hK2XTsyBVnhLsrt7xApguvaTCt2Pxj9KcWWBCyQNoMlKTnEqKE2URlxrVamaTXzBFuysAct1540Phnwjnc5uYOTizYg58CiSv1dgnnjJF+ECQ8MCrSF0P7DFRZ0uKtVfUsU0DxtWhW4JVPO4BZT8MH4zPkbYN5Trk0TtwurtDWwNh0I81v7DCWvJYp+phexloEfd8V9RKXlHE8RoDdUb7fZyo3xuPf9BeVPjvVJj63J1pAibFhpLBEPyRbtViQJqHkBOAMp7K51o/it8UG9/JvsgolIPafkJKh327LVpkacHIANZ6zoTIeVx+5oonRXZmi3Pqjk2z1H6dAERXEwxhd4Rje+eZ711b/r6UDnMTwecHoS0Lhgkw4ozMrVJWiMA0ay/ukoAk6BXA1km2UAITbioHazpdaqis9cF/ThKDhsWsXvJAHGvDYicmnzVRonY7q81dlrruww
X-Microsoft-Antispam-PRVS: <SN2PR03MB21921960E3F210113E6398A39DA10@SN2PR03MB2192.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR03MB2192;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2192;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2192;4:wArJhXC5541CzGvTAt+CM290fzy3UskkYBSvM5gz8SSv7yGo1ISfSArAa8QR61BcXNXFGi0HV81SLrn5BYuDMwu/o/FQ+/Z5QPMQrb+U6QAQdzgr46ZbuLngVs8dF5dqAaAbBh650xcwNMso/6ModPFw/s29liINVHzrlpoOh6cNy5Jb+d9vaIszRz0SwRSJ+uxrM526+OQcrf0GUQE/fosLyF1tQ01XK/pEkGE4FCbuxfAgZqx3v959LQp2OXn1PJZ1cvCJITRSX/FsiQE4ieVNieVBLbsNWRdLVBFCFw1LGu8Yrg1SuauDTVnijijrOU0nwYhTcs7vM05NoNYGkaA20xRtWENeQEDZIYOFjn/uVKEbAEKe+68o0WePTAG7Q6Qpjf4xZgv23SV3OHuHrQzngi+Hij1vxXIFn2RDOVao1a1GC+pvg3F/NdarLys5
X-Forefront-PRVS: 06274D1C43
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2192;23:h6rLVwY22fOKfnB0R7mjaMuZ3GuecV6k0CTw3IXty?=
 =?us-ascii?Q?BdoExsdbwkA0306T/q4pOJoeSOiGAG+a9eirEFaOW2UnSlOFR29yMHuROSOe?=
 =?us-ascii?Q?tRxL+xu+gJGhg+i9DnunAJfnmEPeOefaKxt/ji6FYAmRla5LU+NC+ciLzPzm?=
 =?us-ascii?Q?ifFN29NJHuZPP45GrwBR+fHDsXfdc12T31CV5ggb+WGiO6WItDOqmx2RLKee?=
 =?us-ascii?Q?eNQfZBVndYEKXsGKMPoFxe9UJPw4XdW1DK/aXpaiS7mTaHFOIXW2Vt3U8em3?=
 =?us-ascii?Q?pIn58fXlli7OTcGwmByfJxO+uAdNwaN7Gb0Z8iMLLtPFXp+O5KI8aClYQ2sz?=
 =?us-ascii?Q?/SJvxH1uwAxqQXnpyvdgGyEt7gkUtVTi3SnCWfM4/KWZuZFgCg82il5SgAin?=
 =?us-ascii?Q?fVwoYBmOZgzlihYDuj4usoYKkQljF66GzrA9FHxwGfd8ZinMmkstqhBPFOFA?=
 =?us-ascii?Q?ySx0EpRMHvvWEDtF+vVSckKzMwJI5td2cGqHUcHpu6Q+Lpruqr6EDLw2IcDb?=
 =?us-ascii?Q?TRD1slLfUw0zawTscwVg50kE5WeeJzoiXtSa2IZKUH2nd47dY6s0vQ4iRpgX?=
 =?us-ascii?Q?0Zv20SArnIsy5x7WEZKxJ34VGXGTEJKF3R0ihWDo4cP8m5QrITbCuxoOge+n?=
 =?us-ascii?Q?BSHyRkTfdEV19NoxcCG+XUlnwRivWmwxUKZhdyqbjgjOu7cgQdbsks8+YCCD?=
 =?us-ascii?Q?x1P9gsfSKijwRiHOIMSzHAqTDZg6KI2GWTHfyBs0O1BCreyDiuRWeKWalGEo?=
 =?us-ascii?Q?keO5xChRpv2rlXorRQA+SaErOULlHbvULiyDfEsLAGPSIe/+VNXZ6HYLkqby?=
 =?us-ascii?Q?9VyvoTd2if4zovfd0eMS0dqAcpBs/EvxMjbWZU5PCpLp5/PW6awZEet1Bx+d?=
 =?us-ascii?Q?cZ4Opx9PBP9XYJ5AArf1zefJCHUY4x8BIQ/yvXOsryRrGfj8KnAbq/3JH4z6?=
 =?us-ascii?Q?8mUrD4yFU+g/0MFoNbDt+XxdNeY0fScatbgZ0kvcn0TDA8LQc334OscMYeRb?=
 =?us-ascii?Q?Eq/cnhZ09ZfXWtdeNEeUxL9Q3+mXIT38efh9UDhLkih64KNiaQ/3rCUpCPhg?=
 =?us-ascii?Q?/CH5iqxEJoUtshHGk046qF1aLnJNEwMXX6/Cv9NHv/IAZQMmtJjq7AscmMaf?=
 =?us-ascii?Q?S9KsqeLR4p2HKKc6YtdCQcTTx4LFIvH5N/6i92pkED5cQ2oQK+nyejjI27TF?=
 =?us-ascii?Q?jxbqOBRA8AebO0=3D?=
X-Microsoft-Antispam-Message-Info: fQbdii6Y5VB006lPh4rSJy1bPsokgwV5UPFEdIKqbYtzUxoIXK+6VLbSwfHuEHISdsAZO3uhTo6fDVVzw2/5PtjOjMKSj1BZc7n0lyR8Q7gXTaOWJfGPHoqoN9McHahJfgYS9SZm4my34SXL+Osz6/h+8dsHRqX2Zn1GVxo3qHk7kMUWey2LcO6ldso3mnF5
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2192;6:ZNtLN/TrYGzEwsLdH7s30qR3X1EBrj/eEf0OkSyo1RA94JHFYYYCEPaHaBC98OoLTcCrU3M1CNcBhB6oPdEUI4v3P8BfyvP5a4g+TXV/SSQmbsy1eyozRBESik8w/U98J6a/aaStN2MGr2z3BXrAcEEfDMFRdIoB38e3TIZENNVh24EWzeRNKhPmfX+6qufgWY4ionMHP9kUnC4wFdKcoFvfaVgLd39mIhkXCU8zSqGBeOLq3PRPp11pXZ4lGALhS29Et8BRFNgYV3hKMI1jlXxNjJFt3wN8P+ZT0JhSb5cHZlDEHhwoX7RU7KzLcmyTalB9bDuN/GfELVrNQC2z5pOJURyGUd8nLBhyIT8/1G0gAYvaWZxBmO1Cxcq90y/HL1AslXGS9aC8ctejAP2kWaZlhxm0eAy20Ik9fuT/OW38LlhzxFRE1GcvqGGvpvEC9Rlo+EaLNPzch0jrHgZtHw==;5:UTZEAs1LdkrS1XPim790NYe+ak7fRocGLTA49nCsr/FLIvuHFlvmfvBk8cTq0lIGMKBxk7B7JPuwKRS2UulEEXpl7498+KC3Ic8nFTz80Gi7VM4ww8HJRNMbiWHW3vjQVjSIUg71ihrCxM6K3FcYlOi/rgIbi53YAq0bgQxD9X4=;24:euemAjv/GdNSzMJ62iQqLnZX493BaulCGfVe6usNSLBKnmzaeFbeFEXNQ84SrYOywKrz3C5CYAysUYCHpyh/d4mZIdkzQ7VSD+F4K2xGJA4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2192;7:Lb+Hch0CSzO9Lsf6nSFYMQ4j+QdnJjv8TBglUh25HoDYnlIdkw1J2HyUeYQMeQqEZFl9YzaeauCSqfu8ukYBz+A/j8SMGlWxtzAru4HepTh1L/uzOrrx+Veq7npE+07Ri6hsG3XyJI8rg4N0aLaWkGkqPPldUGSQ5FY7uX79rFTj/laE0XitBSmeRuYQBt9RHDItVW5dTkB+GCBdN49iBfjaI+2gOKeotmJZ/I80jIeOhAo4dAdzhkPsPHwLSquL
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 13:57:51.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0edc126-ba85-47de-a3fd-08d596463a88
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2192
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1596371266008141789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DAC
s with 12-bit, 14-bit and 16-bit precision respectively. The devices have
either no built-in reference, or built-in 2.5V reference.

The AD5671R/AD5675R are similar, except that they have 8 instead of 4
channels.

These devices are similar to AD5672R/AD5676/AD5676R and
AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
instead of spi. In order to add support in the previously existing driver,
three modules were created. One baseline module that has all the
chip-logic and then one module for SPI and one for I2C.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                  |   8 ++
 drivers/iio/dac/Kconfig      |  27 ++++--
 drivers/iio/dac/ad5686-spi.c |  93 ++++++++++++++++++
 drivers/iio/dac/ad5686.c     | 222 +++++++++++++------------------------------
 drivers/iio/dac/ad5686.h     | 114 ++++++++++++++++++++++
 drivers/iio/dac/ad5696-i2c.c |  98 +++++++++++++++++++
 6 files changed, 400 insertions(+), 162 deletions(-)
 create mode 100644 drivers/iio/dac/ad5686-spi.c
 create mode 100644 drivers/iio/dac/ad5686.h
 create mode 100644 drivers/iio/dac/ad5696-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 473ac00..002cb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,6 +791,14 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 S:	Supported
 F:	drivers/macintosh/ams/
 
+ANALOG DEVICES INC AD5686 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5686*
+F:	drivers/iio/dac/ad5696*
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 965d5c0..dab0b8a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,15 +131,30 @@ config LTC2632
 	  module will be called ltc2632.
 
 config AD5686
-	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
+	tristate
+
+config AD5686_SPI
+	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
 	depends on SPI
+	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5686R, AD5685R,
-	  AD5684R, AD5791 Voltage Output Digital to
-	  Analog Converter.
+	Say yes here to build support for Analog Devices AD5672R, AD5676,
+	AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
+	Voltage Output Digital to Analog Converter.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad5686.
+	To compile this driver as a module, choose M here: the
+	module will be called ad5686.
+
+config AD5696_I2C
+	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
+	depends on I2C
+	select AD5686
+	help
+	Say yes here to build support for Analog Devices AD5671R, AD5675R,
+	AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
+	Analog Converter.
+	To compile this driver as a module, choose M here: the module will be
+	called ad5696.
 
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
new file mode 100644
index 0000000..d68579b
--- /dev/null
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -0,0 +1,93 @@
+/*
+ * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5686.h"
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+static int ad5686_spi_write(struct ad5686_state *st,
+			    u8 cmd, u8 addr, u16 val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
+				      AD5686_ADDR(addr) |
+				      val);
+
+	return spi_write(spi, &st->data[0].d8[1], 3);
+}
+
+static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data[0].d8[1],
+			.len = 3,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d8[1],
+			.rx_buf = &st->data[2].d8[1],
+			.len = 3,
+		},
+	};
+	struct spi_device *spi = to_spi_device(st->dev);
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
+				      AD5686_ADDR(addr));
+	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return be32_to_cpu(st->data[2].d32);
+}
+
+static int ad5686_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return ad5686_probe(&spi->dev, id->driver_data, id->name,
+			    ad5686_spi_write, ad5686_spi_read);
+}
+
+static int ad5686_spi_remove(struct spi_device *spi)
+{
+	return ad5686_remove(&spi->dev);
+}
+
+static const struct spi_device_id ad5686_spi_id[] = {
+	{"ad5672r", ID_AD5672R},
+	{"ad5676", ID_AD5676},
+	{"ad5676r", ID_AD5676R},
+	{"ad5684", ID_AD5684},
+	{"ad5684r", ID_AD5684R},
+	{"ad5685r", ID_AD5685R},
+	{"ad5686", ID_AD5686},
+	{"ad5686r", ID_AD5686R},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
+
+static struct spi_driver ad5686_spi_driver = {
+	.driver = {
+		.name = "ad5686",
+	},
+	.probe = ad5686_spi_probe,
+	.remove = ad5686_spi_remove,
+	.id_table = ad5686_spi_id,
+};
+
+module_spi_driver(ad5686_spi_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 5fb0179..e4ea0dc 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
@@ -19,128 +18,28 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_ADDR(x)				((x) << 16)
-#define AD5686_CMD(x)				((x) << 20)
-
-#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
-#define AD5686_ADDR_ALL_DAC			0xF
-
-#define AD5686_CMD_NOOP				0x0
-#define AD5686_CMD_WRITE_INPUT_N		0x1
-#define AD5686_CMD_UPDATE_DAC_N			0x2
-#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
-#define AD5686_CMD_POWERDOWN_DAC		0x4
-#define AD5686_CMD_LDAC_MASK			0x5
-#define AD5686_CMD_RESET			0x6
-#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
-#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
-#define AD5686_CMD_READBACK_ENABLE		0x9
-
-#define AD5686_LDAC_PWRDN_NONE			0x0
-#define AD5686_LDAC_PWRDN_1K			0x1
-#define AD5686_LDAC_PWRDN_100K			0x2
-#define AD5686_LDAC_PWRDN_3STATE		0x3
-
-/**
- * struct ad5686_chip_info - chip specific information
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
- * @num_channels:	number of channels
- * @channel:		channel specification
-*/
-
-struct ad5686_chip_info {
-	u16				int_vref_mv;
-	unsigned int			num_channels;
-	struct iio_chan_spec		*channels;
-};
-
-/**
- * struct ad5446_state - driver instance specific data
- * @spi:		spi_device
- * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
- * @vref_mv:		actual reference voltage used
- * @pwr_down_mask:	power down mask
- * @pwr_down_mode:	current power down mode
- * @data:		spi transfer buffers
- */
+#include "ad5686.h"
 
-struct ad5686_state {
-	struct spi_device		*spi;
-	const struct ad5686_chip_info	*chip_info;
-	struct regulator		*reg;
-	unsigned short			vref_mv;
-	unsigned			pwr_down_mask;
-	unsigned			pwr_down_mode;
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 */
-
-	union {
-		__be32 d32;
-		u8 d8[4];
-	} data[3] ____cacheline_aligned;
+static const char * const ad5686_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"three_state"
 };
 
-/**
- * ad5686_supported_device_ids:
- */
-
-enum ad5686_supported_device_ids {
-	ID_AD5672R,
-	ID_AD5676,
-	ID_AD5676R,
-	ID_AD5684,
-	ID_AD5684R,
-	ID_AD5685R,
-	ID_AD5686,
-	ID_AD5686R
-};
-static int ad5686_spi_write(struct ad5686_state *st,
-			     u8 cmd, u8 addr, u16 val, u8 shift)
+static int ad5686_write(struct ad5686_state *st,
+			u8 cmd, u8 addr, u16 val, u8 shift)
 {
 	val <<= shift;
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-			      AD5686_ADDR(addr) |
-			      val);
-
-	return spi_write(st->spi, &st->data[0].d8[1], 3);
+	return st->write(st, cmd, addr, val);
 }
 
-static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
+static int ad5686_read(struct ad5686_state *st, u8 addr)
 {
-	struct spi_transfer t[] = {
-		{
-			.tx_buf = &st->data[0].d8[1],
-			.len = 3,
-			.cs_change = 1,
-		}, {
-			.tx_buf = &st->data[1].d8[1],
-			.rx_buf = &st->data[2].d8[1],
-			.len = 3,
-		},
-	};
-	int ret;
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
-			      AD5686_ADDR(addr));
-	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
-
-	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
-	if (ret < 0)
-		return ret;
-
-	return be32_to_cpu(st->data[2].d32);
+	return st->read(st, addr);
 }
 
-static const char * const ad5686_powerdown_modes[] = {
-	"1kohm_to_gnd",
-	"100kohm_to_gnd",
-	"three_state"
-};
-
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
@@ -196,8 +95,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	else
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
-	ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
-			       st->pwr_down_mask & st->pwr_down_mode, 0);
+	ret = ad5686_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
+			   st->pwr_down_mask & st->pwr_down_mode, 0);
 
 	return ret ? ret : len;
 }
@@ -214,7 +113,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_read(st, chan->address);
+		ret = ad5686_read(st, chan->address);
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
@@ -243,11 +142,11 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_write(st,
-				 AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				 chan->address,
-				 val,
-				 chan->scan_type.shift);
+		ret = ad5686_write(st,
+				   AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				   chan->address,
+				   val,
+				   chan->scan_type.shift);
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	default:
@@ -318,11 +217,21 @@ DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5671R] = {
+		.channels = ad5672_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5672R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
 	},
+	[ID_AD5675R] = {
+		.channels = ad5676_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5676] = {
 		.channels = ad5676_channels,
 		.num_channels = 8,
@@ -355,22 +264,47 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.int_vref_mv = 2500,
 		.num_channels = 4,
 	},
+	[ID_AD5694] = {
+		.channels = ad5684_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5694R] = {
+		.channels = ad5684_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 4,
+	},
+	[ID_AD5696] = {
+		.channels = ad5686_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5696R] = {
+		.channels = ad5686_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 4,
+	},
 };
 
-static int ad5686_probe(struct spi_device *spi)
+int ad5686_probe(struct device *dev,
+		 enum ad5686_supported_device_ids chip_type,
+		 const char *name, ad5686_write_func write,
+		 ad5686_read_func read)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+
+	st->dev = dev;
+	st->write = write;
+	st->read = read;
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vcc");
+	st->reg = devm_regulator_get_optional(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
@@ -383,28 +317,25 @@ static int ad5686_probe(struct spi_device *spi)
 		voltage_uv = ret;
 	}
 
-	st->chip_info =
-		&ad5686_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+	st->chip_info = &ad5686_chip_info_tbl[chip_type];
 
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
 	else
 		st->vref_mv = st->chip_info->int_vref_mv;
 
-	st->spi = spi;
-
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = 0x55;
 
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
-				!!voltage_uv, 0);
+	ret = ad5686_write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
+			   0, !!voltage_uv, 0);
 	if (ret)
 		goto error_disable_reg;
 
@@ -419,10 +350,11 @@ static int ad5686_probe(struct spi_device *spi)
 		regulator_disable(st->reg);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ad5686_probe);
 
-static int ad5686_remove(struct spi_device *spi)
+int ad5686_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
@@ -431,29 +363,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 	return 0;
 }
-
-static const struct spi_device_id ad5686_id[] = {
-	{"ad5672r", ID_AD5672R},
-	{"ad5676", ID_AD5676},
-	{"ad5676r", ID_AD5676R},
-	{"ad5684", ID_AD5684},
-	{"ad5684r", ID_AD5684R},
-	{"ad5685r", ID_AD5685R},
-	{"ad5686", ID_AD5686},
-	{"ad5686r", ID_AD5686R},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad5686_id);
-
-static struct spi_driver ad5686_driver = {
-	.driver = {
-		   .name = "ad5686",
-		   },
-	.probe = ad5686_probe,
-	.remove = ad5686_remove,
-	.id_table = ad5686_id,
-};
-module_spi_driver(ad5686_driver);
+EXPORT_SYMBOL_GPL(ad5686_remove);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
new file mode 100644
index 0000000..b2b0110
--- /dev/null
+++ b/drivers/iio/dac/ad5686.h
@@ -0,0 +1,114 @@
+#ifndef __DRIVERS_IIO_DAC_AD5686_H__
+#define __DRIVERS_IIO_DAC_AD5686_H__
+
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+
+#define AD5686_ADDR(x)				((x) << 16)
+#define AD5686_CMD(x)				((x) << 20)
+
+#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
+#define AD5686_ADDR_ALL_DAC			0xF
+
+#define AD5686_CMD_NOOP				0x0
+#define AD5686_CMD_WRITE_INPUT_N		0x1
+#define AD5686_CMD_UPDATE_DAC_N			0x2
+#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
+#define AD5686_CMD_POWERDOWN_DAC		0x4
+#define AD5686_CMD_LDAC_MASK			0x5
+#define AD5686_CMD_RESET			0x6
+#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
+#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
+#define AD5686_CMD_READBACK_ENABLE		0x9
+
+#define AD5686_LDAC_PWRDN_NONE			0x0
+#define AD5686_LDAC_PWRDN_1K			0x1
+#define AD5686_LDAC_PWRDN_100K			0x2
+#define AD5686_LDAC_PWRDN_3STATE		0x3
+
+/**
+ * ad5686_supported_device_ids:
+ */
+enum ad5686_supported_device_ids {
+	ID_AD5671R,
+	ID_AD5672R,
+	ID_AD5675R,
+	ID_AD5676,
+	ID_AD5676R,
+	ID_AD5684,
+	ID_AD5684R,
+	ID_AD5685R,
+	ID_AD5686,
+	ID_AD5686R,
+	ID_AD5694,
+	ID_AD5694R,
+	ID_AD5695R,
+	ID_AD5696,
+	ID_AD5696R,
+};
+
+struct ad5686_state;
+
+typedef int (*ad5686_write_func)(struct ad5686_state *st,
+				 u8 cmd, u8 addr, u16 val);
+
+typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
+
+/**
+ * struct ad5686_chip_info - chip specific information
+ * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @num_channels:	number of channels
+ * @channel:		channel specification
+ */
+
+struct ad5686_chip_info {
+	u16				int_vref_mv;
+	unsigned int			num_channels;
+	struct iio_chan_spec		*channels;
+};
+
+/**
+ * struct ad5446_state - driver instance specific data
+ * @spi:		spi_device
+ * @chip_info:		chip model specific constants, available modes etc
+ * @reg:		supply regulator
+ * @vref_mv:		actual reference voltage used
+ * @pwr_down_mask:	power down mask
+ * @pwr_down_mode:	current power down mode
+ * @data:		spi transfer buffers
+ */
+
+struct ad5686_state {
+	struct device			*dev;
+	const struct ad5686_chip_info	*chip_info;
+	struct regulator		*reg;
+	unsigned short			vref_mv;
+	unsigned int			pwr_down_mask;
+	unsigned int			pwr_down_mode;
+	ad5686_write_func		write;
+	ad5686_read_func		read;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+
+	union {
+		__be32 d32;
+		__be16 d16;
+		u8 d8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+
+int ad5686_probe(struct device *dev,
+		 enum ad5686_supported_device_ids chip_type,
+		 const char *name, ad5686_write_func write,
+		 ad5686_read_func read);
+
+int ad5686_remove(struct device *dev);
+
+
+#endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
new file mode 100644
index 0000000..c9187de
--- /dev/null
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -0,0 +1,98 @@
+/*
+ * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5686.h"
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
+{
+	struct i2c_client *i2c = to_i2c_client(st->dev);
+	struct i2c_msg msg[2] = {
+		{
+			.addr = i2c->addr,
+			.flags = i2c->flags,
+			.len = 3,
+			.buf = &st->data[0].d8[1],
+		},
+		{
+			.addr = i2c->addr,
+			.flags = i2c->flags | I2C_M_RD,
+			.len = 2,
+			.buf = (char *)&st->data[0].d16,
+		},
+	};
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP) |
+				      AD5686_ADDR(addr) |
+				      0x00);
+
+	ret = i2c_transfer(i2c->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(st->data[0].d16);
+}
+
+static int ad5686_i2c_write(struct ad5686_state *st,
+			    u8 cmd, u8 addr, u16 val)
+{
+	struct i2c_client *i2c = to_i2c_client(st->dev);
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr)
+				      | val);
+
+	ret = i2c_master_send(i2c, &st->data[0].d8[1], 3);
+	if (ret < 0)
+		return ret;
+
+	return (ret != 3) ? -EIO : 0;
+}
+
+static int ad5686_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	return ad5686_probe(&i2c->dev, id->driver_data, id->name,
+			    ad5686_i2c_write, ad5686_i2c_read);
+}
+
+static int ad5686_i2c_remove(struct i2c_client *i2c)
+{
+	return ad5686_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id ad5686_i2c_id[] = {
+	{"ad5671r", ID_AD5671R},
+	{"ad5675r", ID_AD5675R},
+	{"ad5694", ID_AD5694},
+	{"ad5694r", ID_AD5694R},
+	{"ad5695r", ID_AD5695R},
+	{"ad5696", ID_AD5696},
+	{"ad5696r", ID_AD5696R},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, i2c_device_id);
+
+static struct i2c_driver ad5686_i2c_driver = {
+	.driver = {
+		.name = "ad5696",
+	},
+	.probe = ad5686_i2c_probe,
+	.remove = ad5686_i2c_remove,
+	.id_table = ad5686_i2c_id,
+};
+
+module_i2c_driver(ad5686_i2c_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
