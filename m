Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4/TtIsKw24zQ6p7LsvUx0mHsCdeDp/3e+7xD7Ol0MLjDGXznpw4f9F+FzHwvMlvD/60dLvf
ARC-Seal: i=1; a=rsa-sha256; t=1523447640; cv=none;
        d=google.com; s=arc-20160816;
        b=SmHMDsRrzhp635tKDJTqvSRbxWpVoAGuPGkG3cdHDrPXyW3+NMJx7c3+IfLlhNEgPv
         hkxk03SReOMqEyPJs9AY223U8yipqlH2w2NhC9gz92PT1n9Q2mk91g1z3H20vmJyOjmQ
         A5V97E/1Uw2ga20cKAjAv4EV3gEwmlrMDouDdtlpIBbm1kjBOrkcbMieUDI6sxypBeLM
         Rl3i3p/szGZ7/X3cwGPZPo9zbVfJ7+QGDk3ri//cPSWEr6Pcj/O0B119iSFdqGDJqwM6
         q8vtAymnqWc8F/el7sFk+rJsio1r3Ek8e7U8t2lqVcxtyh/0p4h2ZbpwihINw8EHfkxu
         CYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=/iJ7KNQxc/5QxNGzD282AK5g6vchVXxLdmLExkZfKMc=;
        b=WKLAP14v9KGo3MOdHqU1+Zw+VSQSkeZzgQisA2KTMSiltNUs44r1iNP36O85WOke++
         xjFL6wloHTH9ZnQXUWD2uTF1P8bB+/3aEtxKo0Zj1M5p6urrO1b2WE/0OwjhFnLMNK+f
         0tFDytn5QFNPzTAZ5Vt229lQUITgbFJXf0BdVGataqWrNDJJASI/FkSTr/qkJXfE3XzJ
         PXwsUoY2RtiBeIzvw7/l6uLqxlbrnDzRLq6/f32RU2bnddwpgAwWFvCobYx0y5lyoJFf
         Y1OM03GFyrlKOARhIXHY1cEJOl4xWVHZo2M+3ZWV44GCH5NayAy1pVcSbp2oryz1yzjM
         74wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=DFVUd5p9;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.41.54 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=DFVUd5p9;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.41.54 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
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
	<kstewart@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 7/7] iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support
Date: Wed, 11 Apr 2018 14:53:39 +0300
Message-ID: <1523447619-13712-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39840400004)(376002)(346002)(2980300002)(438002)(189003)(199004)(11346002)(6666003)(2616005)(476003)(6306002)(446003)(426003)(305945005)(7636002)(107886003)(126002)(4326008)(36756003)(486006)(26005)(186003)(8666007)(7416002)(77096007)(336012)(5660300001)(1720100001)(7696005)(51416003)(2201001)(76176011)(246002)(2906002)(966005)(72206003)(316002)(575784001)(50466002)(49486002)(356003)(48376002)(106466001)(47776003)(8936002)(110136005)(54906003)(106002)(50226002)(478600001)(16586007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1351;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD017;1:fFKCIRqHtawJ+T72fMLvWojPhiLYH3xvWSPlMlXnprXxxDFhOIggfBu/MD2HmZm3Jih/QF+CqakpWCbaWR5i8wuJR5tLQWAqYwUD4C6WVldhd6tHlMVSgzNsI8y+moTe
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN3PR03MB1351;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1351;3:qossuiVXNWRaOcV+On7sK0kgWvbH87pZCZkOZo2xcWkWFm6zmBoopkLDEPNYSQwzeiydYajSCs5+P8DLwQKWiLQpgGmmw8Ky8fZGdOWPAm3FrX2rQyA7ERXQdGVdPUBkEfHYBjnsdOKEtmv3WG9xmAULEzo7YhGCcBH9ntlcueJrJivEH+PUhIpLRQiVC2pOJZFAuZCAA6YMc1VAU5MUJKpk97ctLd1VcT5fvnt586ZvuTDBw/WftPvQjfcchRIPE8h6ljwtVuYYxiGKukxEKMHqXlbS476tean7OfvcQBS+q1NeQpb7WwCpv/+AepjT/69DJ/ojHJexaWari16Nyw==;25:aX87O7RgsKlK7NCZ2xFFf71J+gD2xdPstLPMe5iKvpP6FcJ9CniGKIC8hj7okky+u/Y/qaBvCtjK3VxPa8MApx/95GM7rp8XtR+jRp3QyKfwtESiS8q2fvcplxu+X53VTg4D2nIqByOSalyUWrYtgJG/IK5EG6QofQTyw++A4OpDSmQONyH133/noOaAVmeCTxT5Hxb2aMNaWTicpPXYmXKM5TdOJ8yUp4yIglk4HD2CM021wAqqP+JCpmFVa5YF4LSe5gb6etbZxZSELoLg8zGNkQrYokWchX4yyfS+ZS/IK0EDn7RUDf6/iz2j1o6eACHzE7EHJKw3bP7Nwmz73TJJDJCAoRzTBTf8YWlOQJo=
X-MS-TrafficTypeDiagnostic: BN3PR03MB1351:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1351;31:wzQyDx4W7OhO3SOy/aQMR29bXwK3pvyERbbKXkRCNPFxeUYzEdkbaJeCM9OfALFsI9n6nhQ8L0vMtrPZMhoJOPph8jgwfnYkhoizP45+vu5CpJahlJQCQ32ScX+ZhfL+FRgAcB/UourirJYgcnb5Bm9axKiUZ1BfoqJdBFTspqvStfNTJ38lJaCBexGyT8jxRAJg80JJK7mPMtJuBUOxx3MpIvKmkF/Aq2gdLGtmFG8=;20:LfUFFqPbm5N5drryB5JkWTrNgrCoQ8dqNwvJYCNKTISkAyO8QDTnWNXxSOfgxgPD156cosDY6I4TNXB5Ner5GwVzF0f6gHFSbfxty1K10BsYaUhaELmlkib0fa4XQxi4KO2lkbc6ZSETD3B1FSs2dCk5bXdrKgLhIXtpCNMJT4d6YSqTymcWjRv2j/5Th2lG3iKku7pUa1suo5sHvz70jPgwc3eebjDBv5w6Oiw4meytdBVPg89hRzTH+9QqQAUpc8Vet1qzeno0jRSZxz/NeChoysfa+BteTFOvPDtrqKU2gTGN/t4mLhLJThTRT0Ves/uaJcy+UTMUExtu2oIfBBBnDnNY2xEcoBWAr6M/nzakRwDRnGMGGxGDT1vRKeP6m/H0uo/zbC7Icu6LlLP1fdaaJ/PwpAkkBcLyTFo/mp1H+QbjBDcMWhZY+K8K8rC3V281cWovG5QS/4jz2ELyimmnVX0v5rYHGKd5rfz3yPLPIir3lwvOZbW7z8g7FkJx
X-Microsoft-Antispam-PRVS: <BN3PR03MB1351F27D675AE6C194FD41339DBD0@BN3PR03MB1351.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN3PR03MB1351;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB1351;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1351;4:/GsuMl8o0ArH7Ap0kf8U13Z7f1xjV/e9VReujDqNh1KB4PhqMLLuAh7FrMS1rS27U3vWiBoUY9PmJHPo58GH9PyMffy0tfRvZyw7BSGENPkioSWp+hPAgz/2M9XLiOjW7AX9CbJ3eqvN5JJIRJglrJnux7xfCXlf72C877G4aUl1Kv98BYWqbk5PG7OQSldXghRYWM5DjRUVCaiDodQmQvRvtG9XCIKIrsMhdD7h4Ax5NVIITGR5l6NfWaY5BEgjt/bw3JDE2iQl+PzYNY98rvJystsd0NHf7yqt1w9NEkuIzxH4Syx3dE2FVThG+oiy/n2QuEOhSnwLkI383BJRGRrXUQt/fqYRcub4MszP/TExAzizEiUXDTrJPvfrdZN1yb9/12HUwcek+V//AR0ZN7E/e/yQPC9QBgnDa18L8/3jkZraQlEi1fH160CkcJwzE/fp3b2Wsfm7trMD89zBkA==
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1351;23:cCgMqEyrt/X+ArU19ckjWy5LNegM51u3Bwl2FwBIX?=
 =?us-ascii?Q?I01tMrHcGgzfDe/okiOZnCfcCE7W0EoTHHyu7NX0M5oTt4h+CKxY0TUu/C0L?=
 =?us-ascii?Q?FlAeOm8F1X7A3e6qgdRIQ1GbAcI/DkQs5LajIkVDvq4NH4bubHGwijGPFhD1?=
 =?us-ascii?Q?HWaEKnI/GDW5Ex6HVXqNOKPBOMneZplfsgTXm//wW3ZQJ/9StK3eaWKITRDr?=
 =?us-ascii?Q?iTxXiHOY6PVubluWLs39z1zmukatqDcZQxKzYq5xC4CxQzbYXR/3bKEO56yp?=
 =?us-ascii?Q?bNzzsjUzPXUHQyJbAaps1tYW9hG8bmti/ul2Ym/3MEmdhvzhMJYyFN7elkvF?=
 =?us-ascii?Q?sHBT0CE0OsZepcQqoOnXFQ552ObnF5fLdkSCj7i8qIVwC2vld2F4ukk+nfSo?=
 =?us-ascii?Q?2i71PR54yW8qiZ2TZYvAl9ua0X/oShsvW5hhksQuF2cI7wRd/3NByv2NLGbn?=
 =?us-ascii?Q?Sq+/9TGQbnym/UqBw9o5agbCjZhBOCMI8mR0Disi/1AO1bVdUpPi8NlC4EqS?=
 =?us-ascii?Q?8Lz6/YOwDJX92TLKGSQk7ASxAEgSQYVXTxXXBA19EbJjMbSv6KmHOHg/BqNI?=
 =?us-ascii?Q?mMBvBTUZMByt5oDFVYhwOXQ3EIm0jIf/riXC3rkEU1XLQCC9bZGjyutgB4XO?=
 =?us-ascii?Q?CHvCHdGpJI5O8O7YtbZdRSCI2Cpkf9fyv2gndGsuHLUMWbpKz11KeXwMC5OT?=
 =?us-ascii?Q?NiCU3XQ8dkXDRvsqiqzYdPBm8k3/MJeJPsGNv0HIzRM0Zik0zswwMv55EXwp?=
 =?us-ascii?Q?X2F4GtCCRF/5eaZTSD1CCfHcvIXV6nNTIkPRxsxhQyI2S4iKHXJphk7ss4z7?=
 =?us-ascii?Q?LXEl3CuEqYE/s2fFJguHmw2H+5Kn0C40IwL/dvq1XWUtzEtVFdlSFRLhK42g?=
 =?us-ascii?Q?ZJWdshrIq6u5yiEZcgowI1vfXND9SxhcwR+O5UhWRbWlnQjH9inp+LtBGibw?=
 =?us-ascii?Q?Te2tRbJuXh4KgGUjkCzFEXEUIDrQpXviC8AXArOeLNufXbrQqY6yyYkKoUVx?=
 =?us-ascii?Q?z0kMFMLeTZMN6AL3y3rKkoQXRtan8Y5m8cJ2M7VFlq/SlZETCuplVWvwNsXA?=
 =?us-ascii?Q?KlStLHIX2/9ZxkAF6aFeujeFT7YghJ5Q92A3Tv/yF7M4ObXu0Rc3GismQ1Z0?=
 =?us-ascii?Q?h2JR0/5Tl8Ij/35X3xMU/Wj/A5QXWW8x52RWVaIliZb8v+KhOOBBVevl6XT+?=
 =?us-ascii?Q?I5cqki/mknks8kUoel38cMgLQk8pi+zDjOR?=
X-Microsoft-Antispam-Message-Info: wz6OUteHglTOgBjvsE5enf6LT+J5SgcmOlzhg3n9x6Vlf5Xh5Hqwb23JjV2Xf/pKCZhQg2A3AbIspvVx9PXK7s3QzxVk3XhNbGqPM2HzCNw4lcv3Fza78wovrs/pMFlTspZFoTQFc1R6Px54PM5VUESTYsN2e5p/VpGJaVTWScfaMkZtjFj8uUfwFvl1N8XS
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1351;6:KsfLgWiJCfbd4fkfzTIgp9VzLrcZrzYA0wGZcM3EbtOsE6nMAvkncvPATD1EgSw4AIEqpth87wbP44xZma4ahkC6rpGjV5XbpvhKrTIUUmsmGNlGF7EEWomWjck/uisJZpkIz4cby0VMhbwtONhwX3iWzbmw3pz/BCJMCF0vV44dvZ2DkfV8o298hGCjFNWPJ77XQz0Bc24+7BTWgGlua+QmwB5ArJUvFuYOPLIMiTiBrpUvEY9MHd8kBP8P/Bzul4SPS/qZY9fmmFiLOh5ybTb0TxIO5MwzQdrv0fCJtW/6uP3HC/mHVs80Tmb1EbmaXx30QBcqlGza9oVqvoPbi/n2TagyM0txee7CA7HLk9UDFltpLsn10+4ZNPVctZBuMMtEQqyV7AwdnNyGDL5fhSbwCNA/29ajdv4cGdcgL6pCc8axhgZMX4+njp1dLHJ4q1gSHqXtQjYSHTB/VLuIcw==;5:AjhROHWYpm3HaM56g/PI6aIoyvk/1dUoMJ8MqJoKOcIK4yJO0xthn2nvgmtSNgcDN+egNNWB0KmXos6o/2SshAc58TIBw5rIQMMdlsOUnh4qRwCajN4BypaWNQQay6pGxRfIW4lp/cIqwpjRgCV665P4/59d5ZoN3+N7omvuK/s=;24:NgLtzi9oAXL4MC3Ll2zJOtoCBrZXcSor4e59voukannIZmDLxO/b9RbI2SuBA8S/gP6P8w6iyELqIqF1hQC1BBSnm/tQRhVM2dqi6J+Atf0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1351;7:d98KpjZdzyic/IRqMgZPpjO82bUTwEyYmuQ0n75yZpWDJu0rj3eWNbXDryjiE1htfvEqap2sZUXdn4GqOEUm2pZHMRDaoVlwHLOxlvoj5EMhpEZuo2VIzT2QkoQgGRIGWW63ZKg0J5WFqINeEG6Vk00x510NHdZgQSxxMfO7ZE+CqROr7mTToPLN5eNVrd1JhJZvpzrDNv9Uw6NfnJ+udxAEUOD1rhm//EawCKy+mOSAgfdKFXve8tbjIrs0Y6Hh
X-MS-Office365-Filtering-Correlation-Id: fd00f660-73ab-4d74-f70b-08d59fa2e7fc
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:53:56.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd00f660-73ab-4d74-f70b-08d59fa2e7fc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1351
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1597450633299796120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DACs
with 12-bit, 14-bit and 16-bit precision respectively. The devices have
either no built-in reference, or built-in 2.5V reference.

The AD5671R/AD5675R are similar, except that they have 8 instead of 4
channels.

These devices are similar to AD5672R/AD5676/AD5676R and
AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
instead of spi.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch
Changes in v3:
	- Indented the the help text from the Konfig file with 2
	  additional spaces.
	- Changed the license description to use an SPDX tag.

 MAINTAINERS                  |  1 +
 drivers/iio/dac/Kconfig      | 10 +++++
 drivers/iio/dac/Makefile     |  1 +
 drivers/iio/dac/ad5686.c     | 28 +++++++++++++
 drivers/iio/dac/ad5686.h     |  7 ++++
 drivers/iio/dac/ad5696-i2c.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 144 insertions(+)
 create mode 100644 drivers/iio/dac/ad5696-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 637e62d..002cb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,7 @@ L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5686*
+F:	drivers/iio/dac/ad5696*
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7a81f1e..3ff8a32 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -145,6 +145,16 @@ config AD5686_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5686.
 
+config AD5696_I2C
+	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
+	depends on I2C
+	select AD5686
+	help
+	  Say yes here to build support for Analog Devices AD5671R, AD5675R,
+	  AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
+	  Analog Converter.
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad5696.
 
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 07db92e..4397e21 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
+obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 79abff5..89c5f08 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -202,11 +202,21 @@ DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
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
@@ -239,6 +249,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
 
 int ad5686_probe(struct device *dev,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index c8e1565..05f0ce9 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -39,7 +39,9 @@
  * ad5686_supported_device_ids:
  */
 enum ad5686_supported_device_ids {
+	ID_AD5671R,
 	ID_AD5672R,
+	ID_AD5675R,
 	ID_AD5676,
 	ID_AD5676R,
 	ID_AD5684,
@@ -47,6 +49,11 @@ enum ad5686_supported_device_ids {
 	ID_AD5685R,
 	ID_AD5686,
 	ID_AD5686R,
+	ID_AD5694,
+	ID_AD5694R,
+	ID_AD5695R,
+	ID_AD5696,
+	ID_AD5696R,
 };
 
 struct ad5686_state;
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
new file mode 100644
index 0000000..088cb36
--- /dev/null
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
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
