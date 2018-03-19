Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELtdgjPbvZU6woxVZwDsrT7XLbfJFpX8wkYXJyDfL0dJoujXv8d43mM056GTeacPMPYzAanQ
ARC-Seal: i=1; a=rsa-sha256; t=1521478978; cv=none;
        d=google.com; s=arc-20160816;
        b=zO2l4ixi6QTouN/6w6SczRZ8wHq1xo2G3++wHVD6tSQFVr5WWvq1+sadZ61Czye27j
         uYR92ZRrpz/1EeHH4Sbrib5iCp7gGyQEt05fgmAlx0If1sQUm//zm0yQkyvj86JcmzYR
         CcBJQIV9oo54+L8YUq1XI0mEB0KU6Qm9uWtr+ryh2/CGiU9euANKYTc1Krbb8ViC9j2g
         a4RbL7QbiUoRvqwerXqDjWCxkq1kytxkTVcmm3sbLr4FKbrTpH5HPiPyOwVx4oQBd2SK
         PlC5UxNOiCy2ZGkAsBNbayRQ8huT3ZNIia1TBcF4hdKcQdsioVFlMRr/MoC56BRR154E
         fK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RLQxN0mBOtqL0n5JbEAfcpKKNbVh4hqF3KUn34bEW3k=;
        b=ZPz0AJkoGJZB4IYGAWi+CjxF7/Gut+YA+1sPAQJBgzcN6ElFp8gB4YykTJerdZjPtg
         JxZYaRQU7V1E3ffCTHRM1KT0A8MbA5rafNgxRnYxMh5aF2bzjUzZpRaIt00POY+FL5Re
         nrmsySXr9cEtdt6c7JOItsSELDdzb2c0G5lgZ+dd/BPs2G+D5nDM5MHsBJ6qxdVbSrNI
         hfSw0ybQIlnjToGqfYv3wRtAaXnzGDMcxOR5XtuoZIOkh6+BKZWXYsQ9iQU5nhwSiz6e
         XXvHLWTNP47gQrXfo2Z+thdx2kphexDKdi4cDGymYN5oO6xHmctW1tYtsxi5btjIL7lz
         f2Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=PwhmkKxs;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.133 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=PwhmkKxs;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.133 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH 0/3] iio: add unit converter
Date: Mon, 19 Mar 2018 18:02:43 +0100
Message-Id: <20180319170246.26830-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0048.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::37)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01d41dc-4fdb-4d43-3227-08d58dbb41e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:lhyp+1jXZ1lmbLPpvnKgNg/4F9SC7BrrzU1JyBjCLYvo9MQqKMTNZer6Sjwteqc6661Hab8Ir1zD4h01QQcH/FSd3wkwJHcmDHEB3ieHa6DtKAZjbbR94MjvzfSgFCsCRZJoCcMUBow6nVZ5k5be3evwUIsXWXk2NUa7vSfUBp31V90LqWhQuzvvNfa6ETopbVbBsn9rQsP9gvT+7BOsZTbbaSPrMlP9a7ugs66TQHv5qaUnd9SZmUJSlBLPqkY3;25:JhLk+15tBvvVHxHkOQCIEbTuu7mXhYK7xg4OtEq4Py0lUpT0OTZNOHrIg+5b0qkIcmJR9MhZs/GZdAiOWi/s/N3UrLM5dyfmBuqoFTMfxf15/gX/KdmC5Ze16igSL18ugRMOqS4wjNKv6r30zgiqNX8bJBSbS69IhbskF9mbXfiTscQeO0OlC9erovhIviLyroCmnir+VEMsYhBPMfNgOrYDhg8k8rHTnnCbBsI6fOTSqu1LoUBXpARrpQ2UdAZYYidOotw9cMBiGnzrxrt0Lk7z/M0cWFfuzu2dYD4djQAsGflsWHOZCBMs4YECYIjbgNuR8/oRb6Wc0TfvAarmBw==;31:Jxf5Ardg9ntdtT0v5JJs+o/9tik1ZWAo/8tDz9QVuuXwwyjVntehicHR2KWaikCvPalhBRICidARF4l+7dYLgakxejqAMwcUo3var8UBhxW1wKBr77j1EGEkwh8hqyN4k53LEzAOxxoZbKlhZngQGNmtFE23W7RjnezxBpoN4GjHyJUgw/TTAHMhKaCFlZnSZIoH8StOduajJ3mlBlalkZJZP+tMqbIPZaNfG1I8abI=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27691217F238569A962E1A6ABCD40@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:ZDyahLTvAaen4kSY7qepfgO+p50JQkZZAQA6zLHNV0oNbPG3K++sBZwmvFViuQwKK8DTPOKF7Kj/Drl8l2Gyg+7kzxRcJenVs6uvOroi/1a4OTR/IODNc9QQmFEUNAtOZTTyl3zeYXVlDAlLQ8kCkK+SaSIiZd32OdnsFeslX0Tvx01cYRTzqDC6CmM+5MShWvd8vh2t7xbmv/1KFjIKY0iwdOPnGDy+nNS2OqvBnd1GbQ47wN59g6Rf4DDbZWCWVjiUMiUKAN7vlm9mSFjvyA==
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39830400003)(39380400002)(346002)(199004)(189003)(36756003)(48376002)(68736007)(50466002)(50226002)(66066001)(8936002)(6486002)(53936002)(51416003)(8666007)(52116002)(6512007)(7736002)(305945005)(105586002)(478600001)(3846002)(6116002)(2351001)(1076002)(2361001)(97736004)(6666003)(6916009)(54906003)(16586007)(74482002)(26005)(2906002)(4326008)(7416002)(386003)(6506007)(86362001)(81166006)(59450400001)(81156014)(8676002)(47776003)(16526019)(25786009)(186003)(316002)(5660300001)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:nEPLfUtSWpal6jMblim3Ttxy+vqLxrUADFvnIUL?=
 =?us-ascii?Q?YbGUWwGgTi3+VlAV7dNmVE/FnoPgScYWm9HXiVf2rvbQriJQo92535ZnN0qN?=
 =?us-ascii?Q?YOO55v8epInW85ehzqyfbvQ5ZCuox5B38rMkl6Mdbhru9wcWwWf61EyKOOGr?=
 =?us-ascii?Q?HFh6IJSxhDeQ/VSCih5zZFywvjt1V7RY2MA9VZY1ZpRtTd7NOTpnB9hWnIwp?=
 =?us-ascii?Q?wUEEK+B734Lya54gHnWuWgeClK0U/zlIEc6xycAkBmNGGTVUYLWppy+XXYpl?=
 =?us-ascii?Q?qsOO9ftllaftFGEaIhOwf7eUtzOikuO8oGA5qjUf9dkUVmFAV7dx8WtQrbPy?=
 =?us-ascii?Q?nHA4H+XLeB3GXuJz88n2x8X5nLzP/UAh9jXbrXAGvOao/rRvvn4QAS0ytAcd?=
 =?us-ascii?Q?LLp4rl10mbdRJlUm9jY6V9C0i9aon3bjgZ2kCvY7wcLQM21mmEswrPldKxWG?=
 =?us-ascii?Q?AnkhrZIpaUR5dMdH9z87H42IP9eCdagesGTN+dqnMf2yCTxjVyXX1IqkGwTn?=
 =?us-ascii?Q?xqBpMcJEiOFortfGlPNY3JScfQ+kkymm83VFRxLX72ZDI22K0edrqCqxUvxo?=
 =?us-ascii?Q?h0vRqYQjoe+WOi1PUBW4ASAi+DSQ/3068H4kFWpSq2kbrqaBaqNjRwqmG6f6?=
 =?us-ascii?Q?AFZEAUr9wCtMScmkdx4QpGYdx0XDzTYY6Tstdgndp0RVOo0DpP8RnF5S7Cw2?=
 =?us-ascii?Q?3krf7Hn6uS/4MehDwCmra8ZbsRKExVRD+ZyosnyocXxdAR0YQ7ocoqGghCgM?=
 =?us-ascii?Q?4layLHf8emq4bGUjkKhwAEPGQWGkVHBbYDwxlKlLfJNUbG3m24KSQ1iDES0U?=
 =?us-ascii?Q?3I7s2Chcz9PEsg0a3k2kMbSSxfnRxiqGzYhF5wzbrZZ3ods6r/C8hjc14yVe?=
 =?us-ascii?Q?o3qOB8+8s0i2uqs2whGuNf5oa2zeni7DDpS+5oOcN0UqMzAeNpszeaLb4tkn?=
 =?us-ascii?Q?xNpDaDok37lEZ6lOm7dl4ZM4rjsyJEknEHbAgP2D8tMF0PDRWPQEYqfDGJj0?=
 =?us-ascii?Q?XYbC8QcFNEgNzaaJ7+ImO2LEVGaYVgushYJ1O69b0o3HzwC0mFg5KPE0sdl7?=
 =?us-ascii?Q?O6VNQ4lIURoPo931Z3+Pw+yxWxSzV+Etb1XZAR63ksRhR88+riJedeYGyNnC?=
 =?us-ascii?Q?8/TQ4A7iGaXuzVQGZMOH3A0wdiOIBkM/EiTB9rbDD8PqvMatZL/LoqMNtxcj?=
 =?us-ascii?Q?LOhFPE9dOE/60JVcBji4vq/4qibHkH/a0EZmKmf+nyRBU4q3PBv7AEN+Q/dg?=
 =?us-ascii?Q?+JsHohtaPQVHBNHLCmKw=3D?=
X-Microsoft-Antispam-Message-Info: D+ruJE/hYFbpF1JAnqhdpCfBQwV2Yhx1pbigkwiwfvo6b1NdDMb/mgxeJciShgZIqn8MYivLVDTtbE6VA7rgeTvE16TW9ovyaSujI7bLh1uRUn1lXXFc+V1RLj/ULZrPELheLWKW8qYtP/mVeSJ7AU+huEMWRjimfkclonS8Dg5GIurJBHB4HmrgUA1VEUzu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:oy1HjA+D+GrN1LNQJ3T0KIECZMUFVjE6xOCTVLqVCr4y2nQsI9abugISe0C96fLsUkTz0wcO0rKzhpJADV37n3FRddSF+jsbC6Vi6kOvutebhodHJJ0o9di9YyieXCrM0ig/y/c4UsnIiOi5pNfGFTcrfH5Dwc55h52cDAaWVO1VaWsE+VbHvLeierUYFzU+kfLQ8HDfQmGxluPj6lmeIbPdP2o/ntwedvxUvqum2i9CAhoyGj1GJVSthk+pSBgx3GAdrINiC0H/e15SPd6ab9EBstS4vFEOXD37zdA4jfqU4/EjOyqcoRrngSBshY4LD9Sj79Ve6GYXs0kwyYqwlMR6QHj2ayj4+h8lskDdeTA=;5:r4O1GejowUtMMb+s0aJKkr3ZQ6JTiczBk6rfm8Z3uw10/rOxcgkK5Xu9ozSCirYHd72ZPw1TMzYMdYdiTGXKHtC/Hd+SUPjs1vOBlIIywn3rEmX8xzkB9/oKWvH0OVWmT15sP5vV8l4/9a8nX3oOXLOpuTcSl+X44PzbIewun28=;24:nworSPSOYJEr3AZ4QGwkD1qkB/zzFvBvI/9lPa9q24a9k7Iyw6DDCSXpC+queSsz5oCPWQdq3w/09SEW/Q/XPCYrBLXWvsT6aNba2zWVKnM=;7:VxnqJaBPLsEGHiY6QxMipK1+4YI8Q7n10p5HZMih4TReOxX6+jqdTK2IQwfgOGtO7BtJAXKP8/KIeBitx5gffBzr+GKCTaAwHVq+DpHvdR210stnLp27comFNBsqjs2l9ti0coY7lBmQuJIDVffziZt49poTsNFv3ArUBtVODAfuafrxZrqEpaV88pFUDguLH/IAT48kN1KQCEBrElXK9mplky9mM1VC6bB7NboBEgjO5KzA0PNRdg+MBtWN9GSu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 17:02:53.7646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d41dc-4fdb-4d43-3227-08d58dbb41e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595386339632135527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

This moves the iio-mux driver to a new category, since I think
it will be the single driver in that category forever, and now
I'm adding a new driver that is somewhat similar in nature...

But that rename is not very interesting, it's just reshuffling.
It's the new driver that I need. Specifically, I need to allow
linear scaling and modification of the type of an io-channel.
I don't know exactly how that is accomplished in the best way,
but this is what I came up with.

The use cases are an ADC hooked up to measure a "big" voltage by
looking at the midpoint of a voltage divider, and an ADC used
to measure the current by looking at the voltage over a resistor.

Comments?

Cheers,
Peter

Peter Rosin (3):
  iio: rename the multiplexer category to wrapper
  dt-bindings: iio: wrapper: add io-channel-unit-converter
  iio: wrapper: unit-converter: new driver

 .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
 .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
 MAINTAINERS                                        |  11 +-
 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/Makefile                               |   2 +-
 drivers/iio/multiplexer/Makefile                   |   6 -
 drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
 drivers/iio/wrapper/Makefile                       |   7 +
 drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
 drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
 10 files changed, 381 insertions(+), 12 deletions(-)
 rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
 delete mode 100644 drivers/iio/multiplexer/Makefile
 rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
 create mode 100644 drivers/iio/wrapper/Makefile
 rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
 create mode 100644 drivers/iio/wrapper/iio-unit-converter.c

-- 
2.11.0
