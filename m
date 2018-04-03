Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/yQYCtKfu2RBiE5QPGqNe+dckXVUczAbcDhwBF8/sZbwB5P88uJhkX90scMHaDd60FL3zo
ARC-Seal: i=1; a=rsa-sha256; t=1522769808; cv=none;
        d=google.com; s=arc-20160816;
        b=v0+GYujWU8mYO0MwTwOY8p7LO3uD+kGyEpgH0V9StUYEocrfOdr/6/4Esv1oB6C77X
         pa+XrReIMrW5cB2z+xZGyQ5Y103QExiHuS2qe5sV/tSxaDo/NE2KBBCd8XP1RUOAFg3K
         xVrQ7lOjUHvVfMzTEe60Rs3mftuCUPZAA3K/GQO+kUT5BOzaGUtbFozwzQRuJGy6/2Ek
         TGdbsKO6eD+Alt9fol8/BTgfyBrLdMu2/iMU0vnvgP1uqvDQxFYFQ3mExZtTQu8oBfxZ
         tZ7SWN819jFhAQqjumL5S8jUHPwPoAL1Ws/BYjoBtpJrqdVqtrMNmsriUgwILw+a2FBd
         nGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FSC4umCOUkd5pvxhU0cKLjqWNOV8KLdNSkdTr/F6f1U=;
        b=NE3KhAMg2suKOICUA0fkLBJ3WTn3UfOx1g+q4hH9hnmS+FBINO4xhc74PDdVlkhUC6
         QdDK5b2yIb18468/ACpZb1ORn+W0TjkZAaPhcyngli9lhKw/9RPses70xIgIJW96Dt3H
         3ovhqDxZDwi7XrINPRBTUHCjd6kVKEJ4OVkM8JBSLiUGLtZMe+nQVYtlw7co9WiyAZai
         KMzhfMCuE/hOiObNM5FjaY9kc5BQOs9IzV9pczuS3zGsz4NqzHJ7Dqub5jgIJacqEZpH
         tyJyP1Gn1i2qp0uDufpNyG+2/haMS91RukXIH2NBVyzzwzz8Pz0gQ1bwMUhmeQ7m0aa6
         9LiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TTM9INL6;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.120 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TTM9INL6;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.120 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Michael Hennerich <michael.hennerich@analog.com>,
	Phil Reid <preid@electromag.com.au>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] iio: add unit converter
Date: Tue,  3 Apr 2018 17:36:33 +0200
Message-Id: <20180403153635.8228-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::14) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e1662a-c135-43a1-41bb-08d59978b4fd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:1CkaGmIHpH13CwNNuLafYUPBtQ5zZuIf9R4rPTqDbEFBMjbTX1OaUA3OcGBq5hNt8YVLVly5sCzodtP18b7AST4UBwsefhPgBTg45M9UUT6ly0s7LKGhQaFjlKJFr3ouIehXcYzNfKKlfM0oorBYWXTslAf0hn4K5HuK7X0i2pk8tgxVGZj7MjxXi1S8gDKmb+0LuL1ZTYc5IaA+5jm3csGiNj0lHckm9udeUrANM53pSRh18cR3K5ia9KiNPTGX;25:Brf/bzpagYMSBN4Q4CPlk1sR7qHbl796o88cCV/uHWf8fcGl3XyLlxc6OrlEBNlPUtC+OO8YwnY2psTzjAc5kETC99P53wvv9rNRoi6eL0poUvlJQ6kworRB79T8bACzR3SqyVaDVdxNC6fmEkrUPZWyvcthILG6/+BWRlAIR/F4G96MpjCMfRTkj3lAWAvBzRiFvGzVKnwWQ2ClJXsUgyv2NRiBx6e1WFvQnlrAL7HrHkeNZDc1sQjnk7RK3qYKDqBIVzfLw/vpAqdGMphswV38buogYmobUk0IvLMlWYHNycKdFpP5yiLa6lP1PrSwbuneDOsYqX6lJva7mrXUEg==;31:LIXAnUggfzHhI9gIoU155du+p84/kLIaGNtrC9GFmxhrh+c+rSCt+9FP3bJmg8pKOTYzXQ/7Z7ywmR7AZ5sy3yVzIia8mCGwyNfs0kgrH6lg/ZdZh1xEZfMyTcWt8BQfpWs15pSEUeMNXfN5D0dF8GEN6lyCx+uYVdROF0P2Xt4/jk7/w3C5DwtwrVOuWOZ8krLjUd1ax6UF5Ai+jO6zPUfjimgPx92vP2Cb630p8a0=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772623CB1D67DD1FAE1B422BCA50@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:hfk1fmo/A26XwmYaqd81V+zkhgD9Jb1VRU+4OdfQVdQExy0UYqssiyfpTA8tlx4mAAwhnfxZnKdAjciYn2BLq4GD288pT1OBa9CxnNj9sxDGm3y5v1D9bxXeFlNUbi3BVy7JqQWGTnvbTbfb3fCQ+IOF+7DplJYyResNMfkbiq7A4cjQyRmQPuuRtc4OZA3j5LusE6A28w9zzuP73oNfGdj1VrHA6noE19CFgtZjaJggfaYiKX/7hWJq+/PN+P+MjqqECMlLEkyGRGOqpKtDpA==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(366004)(396003)(376002)(39380400002)(189003)(199004)(47776003)(6512007)(6306002)(476003)(105586002)(53936002)(16526019)(186003)(66066001)(97736004)(52116002)(4326008)(106356001)(51416003)(6486002)(8666007)(36756003)(6916009)(25786009)(6506007)(486005)(54906003)(386003)(26005)(956004)(486005)(2616005)(81166006)(81156014)(6116002)(50466002)(2351001)(316002)(74482002)(2361001)(1076002)(16586007)(8936002)(5660300001)(50226002)(68736007)(48376002)(3846002)(2906002)(7736002)(305945005)(6666003)(966005)(7416002)(478600001)(8676002)(86362001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:QeKE3ZW4lG8xoTI3Yx8yVl01cUJ/q9JZurhkHtL?=
 =?us-ascii?Q?b8ThsLqW7ERMiIR7XyUl8riU9NdoS2mXewHn0wzLA4rgkavFMc77ZnxzUe+7?=
 =?us-ascii?Q?XahhGyco7VXL9PGu76u10ekkcGoDKnPXXUmtnK89tC0xKdGtcOoOExrl1S4V?=
 =?us-ascii?Q?PMUHGMXW/BZKhQcjnzjOHk/UYY13psMWd6g7yTlY3iJWHCuKM3xj/vptsGyo?=
 =?us-ascii?Q?g6Yp0muRcDM6U95G/S0F74FGbzWbjwUgUEnuNTM+eAXHuOl/wOTSnNMG6vOE?=
 =?us-ascii?Q?FfL/YLEoVExifjL7eEJM1i6o0r0hnxFjMeYM87Ykvua/cJV+8Lex+K999Yh5?=
 =?us-ascii?Q?Qc1T/EX+6gpM5OxaouB720/SX2sD88rrQOHNfd6eKiv9mPSKdkEyazXVoDHY?=
 =?us-ascii?Q?1HfY8rdYWaALXeWJ6rsFsUcD8gG/8uSmd8OsX92/2Legt99CUYULvWB4+wmm?=
 =?us-ascii?Q?K6jJIBX5G8Bv63g5kHSo7cU/wL9e1aPLEwh7PT46OH2z4aUqtkQ35e4wLN6b?=
 =?us-ascii?Q?l7wX1YqFltlxiXRDaOC5WimrVrnZ0mVmK1yyzlOkc9rNAP05v3PaAN87qFrM?=
 =?us-ascii?Q?pdIPernuNbZvUayheZtshEDfys57w/adn9zSWW0FczKGYPcA1tre/hT+ujsN?=
 =?us-ascii?Q?DvK0SWOpugTvqyIJ77adBViE0F+7l0e+yy9dok39dTqvLOsqmOH/NkjrbOg0?=
 =?us-ascii?Q?jA0L7yNdojXdI6h6wH1c18JhSidg9aAhsvsw/lIQOocSqYYY5QmD2QFSs6V9?=
 =?us-ascii?Q?R5sO1excE0I0UG6uVXSJBIhlPVB7U8xj+AYIhMfM+0fE9kMQk57gZpWvEEKz?=
 =?us-ascii?Q?t/YCZUbGxdxZgQK0YNl1AsP3Oxcc7jU/3GTYq3s1WX6EsQ7OtRTsRvNImyWz?=
 =?us-ascii?Q?wumQANMXAlh16uwsSYgSsUpc4b6fFcxkxoYJ1+eIPlQVpDxZf5iJQulNL77x?=
 =?us-ascii?Q?PqU9GdT/DGlZwFbhrpJCGfN5qv7FIlG5PrFbsXCUH3smfdPI+bythO3TCruR?=
 =?us-ascii?Q?GlW7CCg4raSjrBAyD8YQumftfyjAN5/8WZZtxmNkPyr073kfWIAHqzIatOKh?=
 =?us-ascii?Q?tZNRYpTp1ci6TS+mAz30NIaAxB38zL5CLy4Mx883iUYe5xbbVw0Uf/QAvk80?=
 =?us-ascii?Q?jqE94KItI+I2+vTLnHlrbTSDQNR3QuVXiOX0fUsqZAcGNNzPOF1lfGguAnrc?=
 =?us-ascii?Q?0g0A0w16hQErb04BaluwfjioOnhriqaq3qxeR4PflLl68Ixzdg0rW+Mm3KGU?=
 =?us-ascii?Q?/Ec2uQRphINy8FscuIK5HIJ04LTlTleAot4nNAci3xx9iJTxurZGivNU2JNb?=
 =?us-ascii?Q?eekyX4zRQVXnMit/uSUFMy1d+z62iv2ubqFwf2ivUt7/b?=
X-Microsoft-Antispam-Message-Info: nL6ON3ZZ/0N7Zc1O9tio6Oc5Dv2xa8Ygp5YEsxrW5/TrRjsFnk5nk8mAaXVeimCxK0vBudss7xzGh9R1uGDt5fUT/xvIrxWukBqBldG8tc1GlvM4JWUf1sHPqJGWMzY5W3/3V3WA3/GebqPRUYRLMTy2NKktacTgeKK9rDdao5LznV10W66qaR2S1nAuQ7St
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:CoDlF3p4Dc1WOHr57gBWFzTBsMXm12IGEQOm9N7ad8+MTI3gu3/KI/eKfBGBhHqvT4idxREVUtHb8E6wuSneo6ZUb0oNW3iwLyFkuOItgJX74iSPvAf0ZM1axTbFXAvBWBH3cDr0KFRVz6Ok12QiNZzFXcpf0tO0SptJcQ1W0cSl3nmnqMcROMNJs3ZBLAbWRjs+0BBUndoqb+2utw3P0uzYbVhDERbrgiytNpL/K/SRpBEmW0Gm0Vyr8bOkQV32ATzL34ir9y7Seu2VEwFi7fgfhU+du/atPBBVYHBLgSaRuRGdqposBlIhsIbFPraS8mTMaGnw/kNN+m1JXoOhmfbTRPUDvk1nX+2D/u+ka7pu7n2w/S6tADdkj/xU9xWwVqg53ZZDppYyrtl88GTOu2aZz74p8XTzhEc4eh3hUELbLeO5DlaJnx09MqZ5OM5jGppodmyw9oCpou8ack5Ljg==;5:93+88a8iBXCCMIRav8y/mTtpm3GGTh+pb6jgkA9/cHxHM4XkOREKl5awwznIGiLL4awVGW//rf6y67rvbRoidTKkIwG3nnmrWtGjFXAtw3WHc3XtL+TX9lFFYC1Go3pXk29n55QK+bdz1ChBaonQ/y0O6Yir5xgt4z9vUJdWJa8=;24:Smb5u1AM514p12WBNXZRQ4KfVvxGcLZGoyCy7LRF+9htCKqJ6sHkpra6tCFUK2ZG9Wk8hPAnfrBMxkft5mf1PHJQ5MDvMVqOxMhoO4xaubo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:iiosaQPuqwuiTWMEJy+7KH5gsHv0jg0eeW2ZcS85YdQ2NdWapGNQI6UuyVPt9T23GSmy2VEsdkHBXPgrFOitHMn/ORnQU48WFut/XymX3FW4qaMM+Ibw6ImC58LCBkoM5JQc70dAy7CDP3SvZFIi/iUwZKRDEfnmY/Y9sSnnUNmE5RmLvbZPj9H07HCa0E4fRIXBhyGBr2eVP9DOl/Y1/bMWNAbHwOnptqP5YJqpasSQPUk6lON7L4q0+wMEZwAH
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 15:36:44.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e1662a-c135-43a1-41bb-08d59978b4fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739875121160497?=
X-GMAIL-MSGID: =?utf-8?q?1596739875121160497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

This driver implements support for voltage dividers and current
sense circuits. It's pretty generic and should be easily adaptable
to other linear scaling purposes...

The driver is still named "unit converter", because it was not
clear to me that there was a real problem with the driver being
named that. I got the impression that the naming discussion in
v1 was mainly about the category, and that it kind of looked odd
and non-specific with unit-converter in the DT bindings, but
what do I know?

Cheers,
Peter

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
  dt-bindings: iio: afe: add current-sense-cuicuit and voltage-divider
  iio: afe: unit-converter: new driver

 .../bindings/iio/afe/current-sense-circuit.txt     |  45 ++++
 .../bindings/iio/afe/voltage-divider.txt           |  45 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  18 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-unit-converter.c               | 257 +++++++++++++++++++++
 8 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

-- 
2.11.0
