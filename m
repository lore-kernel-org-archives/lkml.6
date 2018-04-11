Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx49bzPiE+AhvqOBHCAgYGdEHutu9B3XUqmReSEFTLoC6iUugjbsh4ph9/fkVUYU6Uu+Z3Baa
ARC-Seal: i=1; a=rsa-sha256; t=1523447618; cv=none;
        d=google.com; s=arc-20160816;
        b=LOyQkenP4D0AUEdRFji34AwTxtyoky2+suONkGmZoux6g/Fylm+0Y7/BTaY5TgNdTn
         sVsgsU5Qs3d5WkPYMknxG3vWJoYPZlmZF0lZ4CajMo5L32qq+GoYcvA8cqHBMvSxR+u/
         Gr3g2Yvsd/jhsGMMQOxbRq1rxiJxTd2FExuP9P/lyUR1E88SRODd6BKayIHnQRU3yURj
         lBJhTVVgqptghwx3lvv2S5tQTw958dnPWDbU50VUcsG8cNLypu/5xrUL1p1uskOyUgQ3
         aWJPvGAfAwkGtx6jAPVxzz/0IyjAJ171eL1cDmYxFrwSPjGBC8bonemJP7eCWa+Bdx6M
         3GMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=8M1UkAC79IqRMnj1/UlsghcKNz5YCk7QRpbFCsOnJeY=;
        b=pV9t6jsJRmKqwVVdTJT/TvlvHwwCdfO/z3j05DWl2Qe7WPoLw8tCpI/uAhcqcn/RZp
         H8iYJSkbQFjUzF1hUBpuAViIXMpl6PzIMTNd1RFWxivQwGdsZozcLLZzYOt5DK4ERKA7
         oobzQzAsH5oukxHgBPSE32nJPjVGcyIB07BD8sAjy4iSxbhTgwzGI7LqTIOCNQ+eH8dJ
         Jo2ezScyeMJ0IfSvAZVrTDnDuLZBMUz1SJI7WtEX6ysJGFTEsdGjcdAgIGSyelxI0Nc6
         iP5nU0sre+MlxMXqGTnRMNPbo8Tpjix39VDzete8TJCgeipHpbdVtcTyIogwJ/Hg99Mf
         1Eqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=i0iorl0U;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.58 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=i0iorl0U;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.58 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <davem@davemloft.net>,
	<mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <Ismail.Kose@maximintegrated.com>,
	<lukas@wunner.de>, <fabrice.gasnier@st.com>, <mike.looijmans@topic.nl>,
	<pombredanne@nexb.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 6/7] iio:dac:ad5686: Refactor the driver
Date: Wed, 11 Apr 2018 14:53:17 +0300
Message-ID: <1523447597-13604-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(2980300002)(438002)(199004)(189003)(59450400001)(26005)(51416003)(2201001)(126002)(7696005)(110136005)(11346002)(106466001)(446003)(246002)(36756003)(47776003)(7416002)(50466002)(426003)(5660300001)(4326008)(107886003)(2616005)(54906003)(8676002)(76176011)(49486002)(476003)(478600001)(7636002)(966005)(8666007)(486006)(48376002)(6306002)(305945005)(72206003)(2906002)(336012)(316002)(8936002)(1720100001)(6666003)(356003)(106002)(50226002)(16586007)(186003)(77096007)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3046;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD016;1:3AyzcSvAeUY/vu+9RjjgPCSG7RDntSJSW47P/iljXIT/E0s6dexjDe06jIIUsLwm7Pa1+JwwDdGZaKVieb0CCGE1qyvfePMPF8VP80SN9uay0D7YaFM71EaiaFFMEQEt
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR03MB3046;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3046;3:kSIH29jmkpwTCGTRVi5a4QwTtC/fr/OBgizhzMXsZRDbN9ltTskq5ZzNYtFKtRQJIL79e9YzzD+vPmJACzMNngOdkbssdxB4QCEf++YKpwmNCVRLekNDKqDwPIvFw3looFOdm0HpMg+vWe267PjxtAlVhM2sq3bNgCkEVgmZbSNEtcKmVYw/Lm+HWiYBqi4oIIao4p7yc/GqysQ1Ugc0YvAFOEErbL60Mzl2f0zVS/NhRjBK1d2Qi2/Rsw2vtBaDhqKsTeuIEwOdvxpKa4Emzmxi0IzVyLBBPbTT2th4gN0MrpChMKasaJD2qRdaBTlNUXjpetjS+3CumjgqtnDXGQ==;25:GSUqtMz0HOM3PgN7NY+BH57UBwzka57Tt1abM7amJSm5x4LeBQ7MgPBQUtespBenLNmBXu0oc04Suz8ha7GuZ8DROur06p87VE1I0Zkb6OPARBsFPM7padQzTcTDVfLGN6h6+HVlCOHIhO/4t9ORx1joS4BnUMc9kQmfyaEYCVtm3OvkMNRN3Y/geJYLPKIw+VT1qqofpz/xTUIdEPAPba4WmtvDvPMZBeGlNxB8/aOi6pKbR4BYpmtksVIg8C5zur+fV5cqGvFNeQx6mMRRbaub2zvn/PKsbmpy/5u5r8XHOuP9k/G3OGV6sYBccdYycuRkgV8FAZf7AuR790KTqw==;31:Iz5rzPC87jDfsFLGRq8Fdu2BeEf78lGZ7vp1eRVuXMHXw/bdbdOqSOfC0Su1ITSmoP1MnWcOOpN/wuqCzoJyRDvvIkO0gdy/q56I6HtbTAx6clIOQx53iroBOyzix/9SSw6DVao6I1vWe7NpGfWdNlfbOrnkySD34Gsn8kmKNibIs55IA2Jbfi/GsHhpaxTJwqjMPvIPbpIN7ow8LdEi3Zt1jqdptWthD520VpfOMy0=
X-MS-TrafficTypeDiagnostic: CY4PR03MB3046:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3046;20:MN7z2gAE36kRiU4tP24D7sEOFd3Je0/mNDAWuX8Y9vnKxpqM0wPCQeQeI6nlfMa8k72YN5W4cogDq7+zGqSF05wosJePRIF+5T4uGV6egUz4KpnQ1tg5UhHKwLNLQVE1SFtUvJegE+ieXdSiUDUYTTLiC5ERsQpmMWKbauOsbhwnPxQeFy8+w4ZKFLnsHhIv4UfVUzEg2XD4BhqpQwIQ1ND69kt/l4ZPIEnd5yT9lynu0IryP6JrPhxwLBaz7q3HWNSE66YMELwuVc2KletQhMTI2BTQ8vVRgtWH7n/BW+jEJ7V1B3b3Njw0PcJtcerKb03+wRqZ8jvOwSA4N6QKTgaP9E4bHCXXGLLP4PfUNjz1LGlZtee9dr/8SbK12dah+5DLmL77Wi1i9+3W7jsKctDG/2Y+DKH0XwXpwdPhBK1m710pNTPqrk5PpNxCU/SiGUxc4bcp5VjsoJKIS2fa+8nuevx65EaNT2bV57WVgiFlQPIpw5DwaWFGahMXyMOo;4:QvQXMyHwFGWN8mU2ZFUUdqIbSuZ4M9qw2iGeATludYhf8TCuTMzYKiZtRjzQZZu6K4TOmT8HIAbYSciCCexzm5mYyIv8MpCYyjPVhZmK675KAY1bHseETe8/r2I21L5uLwoKaJYi00PzgpfrU7zyTdNXoVJBV1gqtwFBoaxMxCbEav75FFt9H0hhVwM4vaS+fb1iqOX5MBSqxSQdRR/Tdn2QIUSPmk5+SfyEl/9quK5WMkS26MhzePx6jNMMuM8uCizsL63ZdeYxypIgQvBIpzjnHLqp7+Vu9Ohi5dSN1l2lsD7Y43eb9OWJtURw0VaE4K0TjvMpCNWtVBePr9EDRstUXN6vx7cIsd+O9KSZfjUlj4LcMfqbOK3dAT7v0KLx2NFNPQOFBtowkWW3u4pjwKjESwKvXNn5tU046ZPibhI=
X-Microsoft-Antispam-PRVS: <CY4PR03MB304693E65D5B9F14BCCC0DEA9DBD0@CY4PR03MB3046.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR03MB3046;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3046;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3046;23:1L5LPQwISUbPfPC09J4SjVhZA0sog02FoLJIQk30V?=
 =?us-ascii?Q?vkJ2TpJypeuhvaB4IO94kToVBxdMxX5/4aggipjBB5HBk0+gVHMv/WUpfFsx?=
 =?us-ascii?Q?wayf1Ux9wi4Ge80d0JzWlB+XA6SnGIsbiVquVe0AK8F6d4BbZrVrZvCJNfRi?=
 =?us-ascii?Q?nkrmSdPzQ71ftDgsKYCJy3rUwccJ6p+91jVwptbPbpyRyq7X2cVOpAKMDodo?=
 =?us-ascii?Q?cBtVOkFTe3EgDiZSfS8EbhyDlDISRWHtuyMGx8+PswEoG5FHc8Wos3hZydAC?=
 =?us-ascii?Q?JuV2dip+wPMwrfa0fOgsRIhR3gbs4KPS8qCWW+NGoRwkRzHXMN0dGovYlwrT?=
 =?us-ascii?Q?6e+YCVNrga0L95RgokXHFOg4V/f9yAhJh1YOpMIi5U5wK1ip3nsLlR3z5MxO?=
 =?us-ascii?Q?N5BU7AH9KSP7yeFJyG8Tk5qYfA3DWsYCbeZGw39RSdEpMOD1WYo/Ck/UWKFR?=
 =?us-ascii?Q?TX/3GHiEkYgSeWk6/3fJPAYqNHDwaYoSSJ3x3J2dTHYZf1H2lrALmIPVFKXo?=
 =?us-ascii?Q?jE6p5LObnZphB9LQLGzkEEjP4Iun3ggAi9E9CG6g8zLcPGwU+79Y5Ci4lMIV?=
 =?us-ascii?Q?myOCPAJUAnj/MtPOdGEQEAMzsUc35ymHws4+/OIUWwR3elInIU7pyYulUkoQ?=
 =?us-ascii?Q?y0ivR2UA0w5pN+Y7Ja2hI+M6eXMaQKOI1cj0HBqER+Ly/RlmWO8c2fAzP2h3?=
 =?us-ascii?Q?SDyrGLGz/8QXr5l2kKT/gPCpl1ubYwfjbCJLHIRMu1teiTY6DOJGU5563emm?=
 =?us-ascii?Q?yNersugNI5+loV+s5WvvSzQbDOlnU9AN8alWqjbMCEbELPpBO+M+0IsS3OXa?=
 =?us-ascii?Q?tbVDHR7lnUDJAteSmYayRbIyn8XG6rpya7TtmQzRTvwqYCGmpqwU9BosUkOg?=
 =?us-ascii?Q?IXUpPq/vYFPF1Yz/gKlWF4qnD3MdRIJYUyxHu1lItbfZeiWuOfHKy5sdJZXw?=
 =?us-ascii?Q?Ct+ebxfQd99FzvRCLBqNZllngAn8/u9nL+Ik8ZAKjkANHNaI+hIZp0FclTzY?=
 =?us-ascii?Q?wJNskXiz8nCYQZFUprVOnb5soEZBiiW8EjAkAHalY9Zqi8Ouma/yUrXdPC75?=
 =?us-ascii?Q?M+dTExOemutxngZi7xPYuJMUvbQ6BaUcsGOwmMo7Ke6tZhFHrFWOHEWpbhLk?=
 =?us-ascii?Q?CRiVpwJVR8Ja1uNnxXQFwvJR4twDjzl4DL+WWxE8tr0D20V5/cNZjG5JvJiK?=
 =?us-ascii?Q?CczPKBOTrBAz/6iMk2EJAzVdE/lKPS1apQ+ifTpIR+bFK6K6fcKXjOorA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +tSki2iAs4fzT3XS61aw8UJVlTNoqpq8tJIxgVOPTq/YzqS1YIsYFMpb30arNVzTzZJI9cVBaJ1HDUgMtYwRDk1Ay9u1N1juzlm+l65I4SdNn7r8ssVLNaGe8G/AM8OkffTLV0/l44PdIxENmahjbd/RYrdZvozTVQsOuZMunQxtRHC5KHLw3yTpm5hU5dMh
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3046;6:PjkYDXChfvi4Hc2HIOpYqypCUYl9HyaJT6qkkG46ZxY5QCDgH/bHpclMZQJyi7obIJKGsS6VJtvEE595HPJcgLZva3lw5/+Y++Lq8+sEMKVcZkUVtVGkndTTSgf+Um6fHKGf26knjRL4xmloLS0fBUj4EeqLi2WfimIOwSxte+3ULU5EN28fhHpfwy0VyEDhNOU0VQusdFb1eKlO6RbJkh6sixZ9IpIMxPzlHoRs4QAHey5fo+Cx2Z/5AcBQpEXP0PZqTNJhYYY09xi6RE4gnu5zFuFAK20pFp03ZKfF3L/osU9POx5yDzk3r14Eg5NGDjaJRinWY7PAtcCE9D9QRX8NCU18Zx0RAv/EHgak34rDPwUqCkBBlgB8vpaUeVCirZA2BWMyQPccCKBJUZr6t5z51ooMvDsQEPWlkDgkRVGXvkrJ0cDTWuTmHMdMiW51bnmN3tbAbZKurOrQr3cT/w==;5:HKP6lZC+YOq2eGzW83Oa56+W5YlvvuFBtiZ/HD8NiuGFql8LxJgWqnM2EIxp72EsVL1qKI8j/AyK5/aW3en4Yw2eAvjT5GIONuOUmqCiC3MWKwv0JvfhUEoMEtJk0rySMx8ChzZRpv4fCfkkLcRzwq9I60eFTuQ1RrQjF5hskIU=;24:77X7fxTUgSK1W0xiE780Ue/d7q6p1DzNRmGAaOiTknSSB6wQyuBgQoZly2z7Iv4za2IMtaU95o6WK1s6U1JJC4V39nS6ADMe0qUv32KK5Mg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3046;7:pXJ2NTEFImvR+ezk/upXnkYei6hEz88MMR14eVI9npabxi30MaBpkGmA/uhzd+FQaE6mt4Sf+DCLnu5WEwtlwuAcPIQSvOybiIVddYpmpAf0R0NzYvzYjmW1ZhvTAXd2rA+rzcVifw2a28LXlkkhrEWVe75f42Ie9i5wrYBryIG6hM6PCJF7IG9k0Jmxaf1siM4sRkNJZA4MfF9Arj1IvNgzanWiZ6wcHuZE4DDq2khHJJCM504e0UYkCBlkNq9p
X-MS-Office365-Filtering-Correlation-Id: 1864ff96-03a1-43df-b580-08d59fa2d8e9
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:53:31.3322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1864ff96-03a1-43df-b580-08d59fa2d8e9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3046
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597450610505827135?=
X-GMAIL-MSGID: =?utf-8?q?1597450610505827135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In this patch restructures the existing ad5686 driver by adding a module
for SPI and a header file, while the baseline module deals with the
chip-logic.

This is a necessary step, as this driver should support in the future
similar devices which differ only in the type of interface used (I2C
instead of SPI).

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch
	- Use st->write directly instead of the ad5686_write() wrapper
	- Use st->read directly instead of the ad5686_read() wrapper
Changes in v3:
	- Indented the the help text from the Konfig file with 2
	  additional spaces.
	- Changed the license description to use an SPDX tag.

 MAINTAINERS                  |   7 ++
 drivers/iio/dac/Kconfig      |  13 ++-
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ad5686-spi.c |  92 +++++++++++++++++++++
 drivers/iio/dac/ad5686.c     | 190 +++++++------------------------------------
 drivers/iio/dac/ad5686.h     | 114 ++++++++++++++++++++++++++
 6 files changed, 252 insertions(+), 165 deletions(-)
 create mode 100644 drivers/iio/dac/ad5686-spi.c
 create mode 100644 drivers/iio/dac/ad5686.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 473ac00..637e62d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,6 +791,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 S:	Supported
 F:	drivers/macintosh/ams/
 
+ANALOG DEVICES INC AD5686 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5686*
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 965d5c0..7a81f1e 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,16 +131,21 @@ config LTC2632
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
+	  Say yes here to build support for Analog Devices AD5672R, AD5676,
+	  AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
+	  Voltage Output Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5686.
 
+
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 81e710e..07db92e 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
+obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
new file mode 100644
index 0000000..1cc807b
--- /dev/null
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
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
index 54f67d5..79abff5 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -10,7 +10,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
@@ -18,121 +17,7 @@
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
-
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
-};
-
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
-{
-	val <<= shift;
-
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-			      AD5686_ADDR(addr) |
-			      val);
-
-	return spi_write(st->spi, &st->data[0].d8[1], 3);
-}
-
-static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
-{
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
-
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
-			      AD5686_ADDR(addr));
-	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
-
-	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
-	if (ret < 0)
-		return ret;
-
-	return be32_to_cpu(st->data[2].d32);
-}
+#include "ad5686.h"
 
 static const char * const ad5686_powerdown_modes[] = {
 	"1kohm_to_gnd",
@@ -195,8 +80,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	else
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
-	ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
-			       st->pwr_down_mask & st->pwr_down_mode, 0);
+	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0,
+			st->pwr_down_mask & st->pwr_down_mode);
+
 
 	return ret ? ret : len;
 }
@@ -213,7 +99,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_read(st, chan->address);
+		ret = st->read(st, chan->address);
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
@@ -242,11 +128,10 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_write(st,
-				 AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				 chan->address,
-				 val,
-				 chan->scan_type.shift);
+		ret = st->write(st,
+				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				chan->address,
+				val << chan->scan_type.shift);
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	default:
@@ -356,20 +241,27 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	},
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
@@ -382,28 +274,25 @@ static int ad5686_probe(struct spi_device *spi)
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
+	ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
+			0, !!voltage_uv);
 	if (ret)
 		goto error_disable_reg;
 
@@ -418,10 +307,11 @@ static int ad5686_probe(struct spi_device *spi)
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
@@ -430,29 +320,7 @@ static int ad5686_remove(struct spi_device *spi)
 
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
index 0000000..c8e1565
--- /dev/null
+++ b/drivers/iio/dac/ad5686.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * This file is part of AD5686 DAC driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
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
+	ID_AD5672R,
+	ID_AD5676,
+	ID_AD5676R,
+	ID_AD5684,
+	ID_AD5684R,
+	ID_AD5685R,
+	ID_AD5686,
+	ID_AD5686R,
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
-- 
2.7.4
