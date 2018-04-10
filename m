Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx48wUmieXTgzzLjJjZVDyDHT7eHVyu1mcsYefszOWgQnzSqWVxtA4Bjp5QERSVrbutB/NgfW
ARC-Seal: i=1; a=rsa-sha256; t=1523374105; cv=none;
        d=google.com; s=arc-20160816;
        b=HcnNNx2VHN3/8weX008KJVtckTbdZlsWZ9f2T0ZM0tJX5ctJPaSUdH54w6tFwOUr1o
         CD98nI+Eq9mIonTR0nJECrWTW1y6EJsnfmXVhZVgD7zq/+Gm3ScEaV4LcZnA7/5TsZd5
         CL24Df/pIR9wgRV9Ia/dL4bG99s5JIPXbcYxrjpCczstFOxoiS3zmxcaMdB7Hn+oBA/K
         btO7Vg3ZqijyRm+oqGUjcxXaKuG9P7nPaden3vhOHYD2x3pbsVsP7PKMlHWYWHrcjuoM
         vWBFcNvvBrB9dHyJdkAvyE5IKqqgEfd/d9jgWwvB6OPPlqCOQcEMMe/+vNXObO0OhoZe
         pgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dYT8b2iHgSwOQouLyjEo2Ekc5BUpeXdbkHeLqOxlwx8=;
        b=J+P73IUwAU5Wt/KOYyJZGxZE51YQzo0CTQ5gMSrLroU1YRVNhcdII/E24YVCa1s3in
         EcZSX3e/sM6Z1d/Bk3cpp724bL5/LXjimmOeMKVy6qwJGruXf4dcMigy2Q0EKzz67nz5
         e5wjjfFvjki6ls07Hsw4PR8Zr240y4OuJRXa6rBupGnFnTV7iDmqOzzFxWtHSprVy6pF
         YeJgGbbA/J5Li8u+P8gd+4uzj348TTZRKuntCyAfed3ZeivqSXAiZnNgWIkbfSePBUGv
         30NdvOEoCmIGvFc8KuTrPBgLQU8D4jc7dbNkCpK+KFiNUTZwzyTyhWhn4hosakBjv1sB
         JHLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=P6BoWFcr;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.100 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=P6BoWFcr;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.100 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] iio: add unit converter
Date: Tue, 10 Apr 2018 17:28:00 +0200
Message-Id: <20180410152802.30958-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 381c687d-0b5b-4529-c8fb-08d59ef7b0f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:Qzw8cv5rdPiHu0xK2tsSjbUFkA/EodDo8885nInu8Ginr+qkNMuzzYOe6wscVotOc3bImsAYmNvjvASKTivqc2yjRlCJSMV4ABtoPKMeNrkbbDOwbk/1NFFeUznq5w9+O+ccOTZbSUvXxzTIQxb3gRCMJ7pW4CDJm8Fc/mMWZIN31XKGKN5hRnYLHPYx4pB/A+yCOdws8cQndQAn4MI3lWT5BdrkTt7EJxU5dHNFY8ixuvktKB5MvqAPGKYipTL+;25:G6bpiUqPUfOggWxpO6s/G+y05I9VW/JrRVK2rh3BnHPXobET39nQeUFXy7EF8VW24EhRvaJ+88SyKAN9DjSwRBfNlEfCaISTJ0XtmBR11GxRomJEURe0qfJY+hQVuaYy0Cgbq/pK5g2oGOpwQhRF6SwPjzivltmXjzUtb0PLPdTlzevCqU8q991aNH7glpA+UFA3W6LsrZC1Xict2dI+vntqpCFAA5ztqxW2G+QjA4hrrSdIOHIrK8QlVyg1PHQfcVqsKl1et/x8dLA5YaK9HToc0yCj//FtD6fd7Hr6KXCM/s1tkyJvNrx1vT+0FsGqhllEiOyGiGSX+OZuOjG6Aw==;31:sL3UB+g9jMGs5evnP+r6nwkRmaLCvZpvuLDQRW63VQo9Zo/Zc7dM6bFuZ/rULue/ikkO8M24or7/R2iIisK9aROzppbj6ldz4SsHRXA36ZjvEKVAvZtjpuo5Sbk6+nUIROGh1YOfiXNFoFhG57HfXgt4Kl6upaqJ0vjA1KIC3pIm9yGXnX8W9K3h3hekJ7+UZIYf2jN2Bu4GNO+PBaKFN4015dgqn5iN0fwxVoLssZc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784B8954179D919A0FA0665BCBE0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:X7X57/29NqyC2ICTQ+2CXAg5zUWKMEkZbS75Q6wn4pAnSs6Lh8eCYDJb3G/rYtgpkaf6edvYxsNVyvjK7Pz6qGAYtO+piUtOydi2G9VDDu24Xu9ocxJ2F/MHcU1Q1iLcu2p0NBRE1YURT5Lsw/8+qSFAKjLjYPj4GlzzH+QoouU9ekqLZqCCKYp2uvMY1FQ19TtRx5gSWFB8wxkAu3uW/v2+X9NaVFvR0xb32Cq/C6UI3GPmNdlTP43Q/7eGrrrA9vGdRzahGlhw7Lws0a5Rc94TNOHe7Y7ztCwSVmHamhX/WBgkojDF6ORSaAEG7I93
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(346002)(39830400003)(189003)(199004)(50466002)(8676002)(81156014)(2351001)(16526019)(186003)(81166006)(6116002)(3846002)(1076002)(16586007)(47776003)(51416003)(52116002)(6506007)(386003)(25786009)(2361001)(48376002)(486006)(956004)(97736004)(2616005)(74482002)(26005)(86362001)(476003)(6666003)(2906002)(6916009)(8936002)(106356001)(105586002)(50226002)(6486002)(7736002)(6512007)(305945005)(8666007)(6306002)(54906003)(36756003)(59450400001)(53936002)(478600001)(966005)(68736007)(39060400002)(316002)(66066001)(7416002)(4326008)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:hsfC0bS+0wSSuEW2R9lKE3x6z3964LRuQNjbouV?=
 =?us-ascii?Q?kgxkB+RbpTlfT/dt3+GBS9/9rqzKZcI3aBm9F7k/h3T+MmfW6CunkzHdpO9s?=
 =?us-ascii?Q?ZmXQOIYs9jcnz6oqt+OHCv8mqHrzZz4w9TMgYHhuvTqGtj77K0DXjB8JSpNB?=
 =?us-ascii?Q?Prm2Q+5evMwUSg2/F0nWif1SB5gOnpiyG4Z8UDVxs/iI82GtxHw1Vs2KAkUb?=
 =?us-ascii?Q?8+pFo9/f4hMEllnUOC1lI5kzxo5XfTsz7FIiJB4s2x7yd9pXQbiA6/GzA25z?=
 =?us-ascii?Q?QlaE76LhdMudm8TQtSe6e3A7g2jM9BfP2OcTn71N3fjTPOvtyyf0uU/H469D?=
 =?us-ascii?Q?nHgJiwD9hzA/Hs1EwseCOgQHuRe1ZbqR5nHoPM5d4YNaYYpETxVI5bzbkHAe?=
 =?us-ascii?Q?N5hKx5X3QcOkPUQUPvJteEAax0cxF2lRSWFUcWuH9zUFEvjIyzRyeHzWb8bO?=
 =?us-ascii?Q?KH891Vj8HJQGZ9B72MnkDgYWrTsiDBA3cukW2CN5gW4dhQf1cBL71wgrATG8?=
 =?us-ascii?Q?iknzJuFZbcobT0Fz3kiGakSerpD31dbER3O9It46BCyo8rQU3YkOOlkBgu8U?=
 =?us-ascii?Q?aB9aURLPUQAFpEbZjuJnR1CActA1WQB6MVIgIqXj4QOyUDRQVfvfoDE18PeA?=
 =?us-ascii?Q?CgeBS4pNaNE3orA0ZMFFMh4mjYaNZGHAwiSekqV2eJYu3Gy4XqhD4cxsUmJd?=
 =?us-ascii?Q?Zwh/1lKkCKibgLbsOFxL1/XhC7CkUcC1rx6t8Age8enlT5soWxQiIHzekR1z?=
 =?us-ascii?Q?kGVi1NH1fDDAfXvfBQ+Rvyroacu4skEpSMgJ1mDbZJgel7ZtsnWGtEElDvIR?=
 =?us-ascii?Q?1v8umjCUS8tiHmipvk7P1qSyjVbQ16hWmFegwgofeRhZAEw+ky6NAdvRJK+6?=
 =?us-ascii?Q?EOr4nh2n8hEdbVzQuJZpKQS1ykFQPOpxI7ZnuHk3d15yuHAqEQerDAirWP77?=
 =?us-ascii?Q?jmTK/vxK1HqefyACkbiohfxfILjOlX1TYHWOxnUTGG/oKwrKyqDm3YHXV40c?=
 =?us-ascii?Q?B9IgWBewANwLKDGJPNuptwtiiC9F/l1tB0S5IFH65DXL3SxPI3CqgzoUBlSG?=
 =?us-ascii?Q?yyvMJRwf1cyhpDz4M5d9rkQvTPAhyjqT8SI29c7xaCYSF5ScZDgFMl0SrR9t?=
 =?us-ascii?Q?VUaxlbltFwZbhl3PfccokC0j/mcL4ooJMbXbQmBWPkwpiFLxrjGls6fgFS9g?=
 =?us-ascii?Q?AKbahFgFRaACm82G5MuNYPkEyxadHkkdQoBSVj2yg60PpGN7fWnHRCz2VXdK?=
 =?us-ascii?Q?k5zGcIb9fURUXqHTJ1kM8bGsSNGq+Se3xDGhyK2/YHWhSIeDMZB0bGWsL2vS?=
 =?us-ascii?Q?gbe54CGmBXbyJBuZHPmA6hvTgZINoKFuNiMurtpLR8K54nOiKH7IawD4IJb9?=
 =?us-ascii?Q?vtad5No5/hksnRC96mgZZVvoYiTw=3D?=
X-Microsoft-Antispam-Message-Info: ySWy271zh6LdjYi6JtTbiip0KE3+xtB5ntiGHM95KqC+wudDXRVtf+iHdhiJRo+GeEwp+x6Hg7FR+aKbFkMDIggw0rpeLYx6aD5SWBCIREv4X7pQmy/hV18RO82491p0qx8kuqbmf4hYCMcF7CUl6A/b82nwy3UWx7GKPc9xu3iumUwr0TjWwdTrUWamgS5A
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:mDN9zDCZrbBCOr+4vSdj/lkj1c6LfWcNuVQnM0ARQMjQjs8nbRBOsrRnySgKF7MP/eVyxRe5nvADlL1h92cSPTDqerNPgZ4ONrQVDsxn+tCAo0/Sbqhz2AXqV0K80gODzUhPc8qzvciN/4EQ5HrC46XbvTuk5U0m8NmxXwcbhcmwOPrThA3AqFdEc86FDcqtEgqNg5CMer5JX/QIaa2fQ6LuV41PxFCb0lrRW+f52NJ3BoUSmPPY7nAV4wTiF8AZK+DhPOCVNsyovkCqPuAZwJvNsYI9klhiyN9Az3AFL0GXd34lrG0vzbzC7DI64I5idyYS9ZPJgKsgdivAcnasnga7846LUvG0Q6Td4dcCHZWHNDVmrl5p5288auYb/wxYs4SrYg4qE7evtNPwNfUKe5YK2yPTFITt3+ZWFCmADBGX5zlzs58ZO0GDauBzyGXlnfXkqQcaNSdm0XZIrnumbw==;5:OL3knmUQYl9eaGbFqicPny/vgXqakS2fgfqJIR5CJ+s0vg93bWuGket8tkC2BxtowmnyhXUehsiJpekG4wpGMvJFQsoue9PyIndx5rFMdJy2s5VN2ZGX3rmbJvsC/wRSLQjP8K3WzuDZc/I2s7IfG8bHPY7rakAZus2vXnu1Wrs=;24:4mGIQGPCyuPfV+4ajIH2/VaGYPCvVoGriM4Ha7xJRAvcL5nYmFnmmJbY9eBp4G/v8OrJdJ6SFTMUq64Z9yIU72gqVJZnFRKpV68cSlYEqxM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:aOpAB6QMPanzjtRwfjYiv/qn8X0eb9qwVAZCnMqRKi4VT/RW43cGMSK28z4y+uzWZsrp+moIEoXFH1f+itOhzp263563J/xPYCs5c9eMtI1XWnkf0tsDbqEPRtVjjZLC65lJNTPqWiJv5X7YPgzKJJi/uSVBIHJws5A5BSeGNTrfJg++7MwjWX70PdjPfklwO8Aef8oXLBt9EIJqZwDcgZrzDvepyXq4EkOcri8VwdTVc53OQ5rgW2jDI3qhNT+t
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:28:19.3654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381c687d-0b5b-4529-c8fb-08d59ef7b0f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373525263580007?=
X-GMAIL-MSGID: =?utf-8?q?1597373525263580007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

This driver implements support for voltage dividers and current
sense shunts. It's pretty generic and should be easily adaptable
to other linear scaling purposes.

Cheers,
Peter

Changes since v2:    https://lkml.org/lkml/2018/4/3/461
- Rename from current-sence-circuit to current-sense-shunt (this
  should also fix all the typing problems I had with curciut).
- Describe the shunt resistance directly (instead of indirectly
  in the form of a quotient).
- Add a ->props() op to struct unit_converter_cfg to enable simple
  separation of properties for different converters.
- Shuffle the code around to minimize forward declarations.
- Drop the unused indio member from struct unit_converter.
- Drop error report on iio driver registration failure.

Changes since v1:    https://lkml.org/lkml/2018/3/19/801
- Put the driver in the new afe category (Analog Front Ends) and do not
  move the iio-mux driver.
- Do not refer to the source channel as "parent", use "source" instead.
- Have the DT compatible drive the target unit, instead of relying on a
  "type" DT-property for that.
- In the DT bindings, use an unnamed source channel.
- Do not set up writes to _RAW (sorry Phil) as I don't need it and have
  not tested it. It's easy to add back if needed.
- Fail if the source channel does not support _RAW or _SCALE.
- Fix various spelling issues.
- Fix various code style issues.

Peter Rosin (2):
  dt-bindings: iio: afe: add current-sense-shunt and voltage-divider
  iio: afe: unit-converter: new driver

 .../bindings/iio/afe/current-sense-shunt.txt       |  41 +++
 .../bindings/iio/afe/voltage-divider.txt           |  45 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  18 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-unit-converter.c               | 291 +++++++++++++++++++++
 8 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

-- 
2.11.0
