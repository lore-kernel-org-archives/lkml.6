Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELvSFRJ9/l3gQoNeZh5wX8NA5g90yFKln5UlF9AlW9gcToF8c/dQIL7xwknf+swTnHhuULwD
ARC-Seal: i=1; a=rsa-sha256; t=1521478984; cv=none;
        d=google.com; s=arc-20160816;
        b=n+/k2QSmqg8qmtkHA2Of+c1q9PgNGyvMCtn0npP/GxybE0IXvE/qXuNi9MIcGyIREm
         unmx6jhpBJH/Xx8M8K5ULqphKiKaUkjX4pqYRWszU8RfR6weJhUyPSDFNVcjQaSB8Hpp
         vJsYWfVxcM2Sh1/9VASZiZOZxYzgS4g5nzgkTvYXrsUikKBmiGnKFWpRJr6PHse75OyZ
         IUZfpe4/uSNPmt7i0/VLx3KDmoVar+JtvC7Me057QGPUzB6ojzuauPMwQYR6axHJLMZy
         w4f7M/IbD2Fe9BvbFkFzZ/6nlVY+rHSaoKEyxEu5v/6NAuAGdp0QNFb81+w1440S525I
         klfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kDGeTvBCaNZupUX5C0+SGGlS8AM8zOuC5Ulva45FQN4=;
        b=lMkXtOTNfZso/uHlA8K8MBrJcN/VTA8c8yFvAaI0d1WP2Qh+1vHyHbIMK5hLdRiKyX
         A2P58oeLMldSFfiXqIrbCNErFJcnzlAfqr1wf0xqzhEIH1tQBnoyFoxMN6TpV2BU5d12
         ++B4cUJ58TgFiIBeW+Usj4DBdSwHTY5GcPwPlwuzs2Z5StuMAd9BKxbxcheU0Vd80g37
         W67yPwINd2+54wxGPv9CyB79XUPrGF703Z+W/gemtNnt/HrdDlNzU5KeJLWqHfutaMDr
         NYYoHFc48Sbhd0BA1djNzz1mwTCAyvpPW7ErjWfAbt6aZDrTq9yKyXXkVQq+wuf5oi9R
         Hf0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=W3yV+RkA;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.132 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=W3yV+RkA;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.132 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] iio: rename the multiplexer category to wrapper
Date: Mon, 19 Mar 2018 18:02:44 +0100
Message-Id: <20180319170246.26830-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0048.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::37)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3070f32-237f-4887-1ea5-08d58dbb4627
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:EBhYjpYerHjUjIi7gUWe5AjJ7kE1yd4LuVdP9UPQMUprFejqMnGMLg46tkgjELATOBFCq2NejAg9J2wIe+P8Mya804lYG0g0tJOnBG/f5eXkc07k7M6+ouHxuCx4bd6d+dQ8yYqelBzpsfe7jA+9yqjqrBTE8sGxZHiiEbJxoPMaKgmL7viWx+TpWIKrZg/dZzzwaWmLUzbeappAw3yFXo446eGqqPedSuKOBbgbF+socRk+hnaZHfN+m0owIVl+;25:8FqIZOEXrdKKwMugGc8/d6VxS/LORrWJ1icl7cKbok70Ap08/ygLRtyG8eB5mHg1PXLSjbzKhxz9xG12alVlDJkBbZhSWAUpWahDXcq51JxBSqWKPVWtdVMeeAz4ft/Hf5i1JasGr5L9WtDG1Uu8ANECrlCzwZqsCG4I0ULSV7Sc48uz7lF0eXJ6adP4mvkq/qoBSTHmldGyYdffGP0Aqd76yWyX1aWtdm0Vrx4XBEzQ7GOyMkxsVdbKcbmrA4tvyEubeVLEWGZ4KY6GMPByfAfN4D8csCCnJ0nKz8xR/yIU5VPoG4ryAiHCwQKttTTuKlHhyhJGRudmjfRAS8nM0Q==;31:VExh3a6QJO9vaMeK/BxiHBD5Sose4edYZ9E8DTj8HKMPX/m9WJ/OlSz4SY9hsaoeqQvKIE/c7ZslBxptrQ2XuFJfB5wqlgVUP0jcjr5G+ZuV8Ah3vsjbBCem580uqYEGc1H9ViQOTlgfnT+5i9xSanf4f0E3ccH9+yQJPjIVN/Vy6qUdqVZ77Z5CYT+IgoMwqm35AhgGPQqNTy6m3+gv3wZyP7G+U/CmPcmdcSZMnwk=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769B254B9EFF6F5FDE6A30DBCD40@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:3mfC1RkCc3ceSxPfi6AWE6inkqHI756sKT0Z+GdXjpD/+Xyheap+FeuDYEpfuUtD9AlTHSKubUTm7GxszPtzc++342B5DR1EA+Dbb+I7ZUslWWC4XkHLjd67ytOLUmGiNpExMIny+dBiwBs+bLXOcLnQd+WR7y3WRUASc8nSHMEu2yWJ7C6VLd1jEOeV0lXWq/g6ea/OkMvV3sQHNbPvNi7iT6I4RKGBrL0TEDmfXcxRNLQeTN5kLqT3u10iZLlTV03BkLTi6itFMdzPCQPrFqkYe/8exs/sdLdA46WUpSkHGXDl7/evv8L7EPYeklWH
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39830400003)(39380400002)(346002)(199004)(189003)(76176011)(36756003)(48376002)(68736007)(50466002)(50226002)(66066001)(8936002)(6486002)(53936002)(51416003)(8666007)(52116002)(6512007)(7736002)(305945005)(105586002)(478600001)(3846002)(6116002)(2351001)(1076002)(2361001)(97736004)(6666003)(6916009)(54906003)(2950100002)(16586007)(74482002)(26005)(2906002)(4326008)(7416002)(386003)(6506007)(575784001)(86362001)(81166006)(59450400001)(81156014)(8676002)(47776003)(16526019)(25786009)(186003)(316002)(5660300001)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:OMfW1nY9H6LxuFEVW1EDbqbAWek6vssSXshaiFC?=
 =?us-ascii?Q?T5XNRbYSkePeZ9Yz/p0X1+i+/2+dtFveqYJxIU8BX7jv1iKN7dfa4ZnpnjHS?=
 =?us-ascii?Q?wQ1MC7JIVAIkxx7n9IKSZxUu35rnwsAdi+u8LzONR2QAh3KkIlB1V3htOINd?=
 =?us-ascii?Q?mqrYO49keosQgPLRtlpPY2wKXVXRe5CbZUIkqnGewNBWMmN6dzjDBYUW4a8Z?=
 =?us-ascii?Q?2fTILIx//lKuV8NEDI4VyrWk5PPImjwT64tH9gPQE6Mw/vQLBioxSpd3bQv2?=
 =?us-ascii?Q?Bag17I6p8ihAevUUNZ3+RB2+bu+F1CxOd43SvDDJlqfeCJJNPgLe8XwuonH9?=
 =?us-ascii?Q?sKbiU5cZRYcy3Jh3GmUZ5NkiukHXCri6a75s1zwKEmOFqbMS2M5gye52Z33r?=
 =?us-ascii?Q?SNzURDULPhBiU4kuyYjCEJOkHEibxtaBRdracj1QZ9MU7UHklNQE8qfYwxY2?=
 =?us-ascii?Q?dnRap3qmZLYl/oNBUJ5A1smGtoOnDt3xTQPee/5FMFHPqK7U9TO3QHA2Wea6?=
 =?us-ascii?Q?x7pv9x8oNY2a90grUAxHFQNwZ/jScVKWaDizyFxxOTRjFyoKFdl5PSOGcLjC?=
 =?us-ascii?Q?9HXPv4YV2RPJJBMfxeurkt5cTuTcCif2rQvHAvN1bQ4kcjX7qhfPkmswDri3?=
 =?us-ascii?Q?DoQ8AUmmE/7h/KnnBq19OWEO75nyo27w5q7ktHNBcvaz7YpYW6v84jcXcjLP?=
 =?us-ascii?Q?2OuXQ1jR8pyKmtMqnD+WCijoNiQpBouZd0IzN1LNjBtqL2nqcm6tdt1bT5pZ?=
 =?us-ascii?Q?slojXE8iz2IQdBR3sRvjJnHFAvdopmEQsR27tNasTbt4OhWloK7AJZWAeugL?=
 =?us-ascii?Q?M2pmIVBJA+M/1DYowukEk1WOy3LJsHXQC9RidxMUZi9Yg3y/bLDGOueYbbYa?=
 =?us-ascii?Q?r9J+/hcGThRSwXZ4tI+xD7vrqIMvCMRWnWN7KSW4mA0LMVLeF9V3D65EDQjr?=
 =?us-ascii?Q?WhVTe7sAfzlAJh2VkI8eykZpeYZy8w5XPmOAPX0JhGciNhqdnB5SKk/SYUoD?=
 =?us-ascii?Q?D8d3LrKsq1K4RINP42Pour5wEsAN+ClL/WEGMoxbK1SP86PHArDDPBp17uDH?=
 =?us-ascii?Q?PdYrT6rJjSm+3kr5EccJQaaawbhvPzZZRiCaUXf4ljcf0IkWype1wpKJwfAS?=
 =?us-ascii?Q?SY9T/nrQKi8Z6VZC/B4ghsjhOmgEvNHY4m1BRgP1kGSt6xWr5PvCT5d59tDu?=
 =?us-ascii?Q?rL5z+DCV/egPsJ3knVr9pPZd0YDLaWRfzsXCVHryHtAB8UlAQFTX/03S5sAW?=
 =?us-ascii?Q?oUvV0JuArWHbxBbsyQyemqWt9kPal/NllBFSsLfoQkwQrh2STMhV/ueF/hBc?=
 =?us-ascii?Q?8VMkdLw6MWjJYjK8eqVbzL8Y=3D?=
X-Microsoft-Antispam-Message-Info: 241FaHjFEXWwKMMkYLv1N08wuIM/9YOycnyN0PYVjyu4F7sx9flkUTNNgULsStfXQ/RorAFfxzqY2pCgFzSWkg+N/TAXQSH3oF+dr1hPWnNqr6POU3rkv5o/bk7KRO/4LkSbUpc9nfCRNtn6QYfZrv5q0cy2oZj7NM3s2V2Kk9gcLI3POKWPtsNGXMyDtRLN
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:bYLc61ZXi0ZRbdSF9MvyB5xy1Z2FsULp3y170tjgnsDO7nkKkdhc438/erOr9/wDPc1Khlhfmztwz0LUQPastKxADTSQ9+ZDTSyXhF9fALIkbFKPt9ok+d7kjLkKQVzXcBaXKuSmIfQ85fK0+GjO4H0brwkAZmwh7LGaUI8PF0VnNb59LxiHen2KTlIl6qV6UwjkxPw56j+ZEHpZynIuz78bWAwjR6mqD9YKQsRemPAzHCOqEjZcG2Hp+G2i+6GtA7YEpHxkE2tzF7XTU3KAvF0L8md8IG3WeKqaJpZjo0MUfYrLK13WkRj74v+xxngP64r0Gdeu0PWQ7F3+vEL8l8EAqArBna/ydJFhjJoqP+g=;5:Ga41fOg12CsGjOJaCoAXtA3hgBXlmQ28GQ/Pumyc3Tn5aSh4+ZusooAxeA2M5r4158nTOD7i300j1N9JqaF3uy3x0PfA0FLF7fo2N2veLSnheYJg4zCtcIuLa6e8wqOiHSKxnttwpZoWY/nGbRVrsCUq4HDHbG2t7K6xQ89Q7iQ=;24:d6M254EpRL6p0nlTZhH3ebqdDZn6MGccDr3nbLNEjtfq/dMW0xBbmWJh/rCTAhJUFadCQjKqQipka5s9J/5ozN2j+PI2o53HSEt2aZjuQOY=;7:XDRmcxbRZFWkwCseTiM7NkfBNtZY3o6Ub+m62osQn74Q2J8mOy9+PWSlMpNkTz2HVRIY4hr/01j9UN2e4HK6jKCmazwh2i1vePl+jgrlPGQRMnAqMnt6//q/ppYLIxC0zXgcIkivIrraMDFNqIKiL2gaeh8ZUL3+BnZ/kTipLrZWT9+7xAofJDdvDoBc6AHnLU8H4KURdCW2MT4kBvSFH+y5APrdVIq0MwJt/12tWrlfH9ZiWESU4n/cfSrQnqEw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 17:03:00.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3070f32-237f-4887-1ea5-08d58dbb4627
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386347268786589?=
X-GMAIL-MSGID: =?utf-8?q?1595386347268786589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paves the way for other wrappers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt          | 0
 MAINTAINERS                                                           | 4 ++--
 drivers/iio/Kconfig                                                   | 2 +-
 drivers/iio/Makefile                                                  | 2 +-
 drivers/iio/{multiplexer => wrapper}/Kconfig                          | 4 ++--
 drivers/iio/{multiplexer => wrapper}/Makefile                         | 2 +-
 drivers/iio/{multiplexer => wrapper}/iio-mux.c                        | 0
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
 rename drivers/iio/{multiplexer => wrapper}/Kconfig (88%)
 rename drivers/iio/{multiplexer => wrapper}/Makefile (67%)
 rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
rename to Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..96e5503bfb60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6865,8 +6865,8 @@ IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
-F:	drivers/iio/multiplexer/iio-mux.c
+F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
+F:	drivers/iio/wrapper/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6ef0dff..c4d25746c585 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -83,7 +83,6 @@ source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
-source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
@@ -93,5 +92,6 @@ source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
 source "drivers/iio/proximity/Kconfig"
 source "drivers/iio/temperature/Kconfig"
+source "drivers/iio/wrapper/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index b16b2e9ddc40..dc5486f6c148 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -29,7 +29,6 @@ obj-y += humidity/
 obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
-obj-y += multiplexer/
 obj-y += orientation/
 obj-y += potentiometer/
 obj-y += potentiostat/
@@ -37,3 +36,4 @@ obj-y += pressure/
 obj-y += proximity/
 obj-y += temperature/
 obj-y += trigger/
+obj-y += wrapper/
diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/wrapper/Kconfig
similarity index 88%
rename from drivers/iio/multiplexer/Kconfig
rename to drivers/iio/wrapper/Kconfig
index 735a7b0e6fd8..f27de347c9b3 100644
--- a/drivers/iio/multiplexer/Kconfig
+++ b/drivers/iio/wrapper/Kconfig
@@ -1,9 +1,9 @@
 #
-# Multiplexer drivers
+# Wrapper drivers
 #
 # When adding new entries keep the list in alphabetical order
 
-menu "Multiplexers"
+menu "Wrapers"
 
 config IIO_MUX
 	tristate "IIO multiplexer driver"
diff --git a/drivers/iio/multiplexer/Makefile b/drivers/iio/wrapper/Makefile
similarity index 67%
rename from drivers/iio/multiplexer/Makefile
rename to drivers/iio/wrapper/Makefile
index 68be3c4abd07..53a7b78734e3 100644
--- a/drivers/iio/multiplexer/Makefile
+++ b/drivers/iio/wrapper/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for industrial I/O multiplexer drivers
+# Makefile for industrial I/O wrapper drivers
 #
 
 # When adding new entries keep the list in alphabetical order
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/wrapper/iio-mux.c
similarity index 100%
rename from drivers/iio/multiplexer/iio-mux.c
rename to drivers/iio/wrapper/iio-mux.c
-- 
2.11.0
