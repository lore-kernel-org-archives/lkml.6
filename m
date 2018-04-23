Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/pF45ZIyW6OG+It7v9dXX1cvfvPCj7KGBGcvvckOthi0cZgyD+k2/qbeNresiOywYhJxmT
ARC-Seal: i=1; a=rsa-sha256; t=1524517703; cv=none;
        d=google.com; s=arc-20160816;
        b=gZZ8OqhfJTNlD1KGXVp3RZmKJS2LYU7PwYy+eco902TX6R2LCZ32H38MJCty4G6u4c
         qQXQ1qUgBS4CE41VFkiz7ANaAzqiiQEnrg5vtmaFfqiAUiWvJp5BfCoPaMxmuEwXyojt
         Gm9LSPCgThQzpWUeOPnegnbaqmP/a+cOlgIlFuWm75Dh9ujXVPdC4FVqaLlZd5Pblgrp
         a7e0pSCCVUtoLXteSWHQ6dpF8g/OVJja0UYc2LdODFS7UWbZfu+jrceoQCGW+wsgVWFp
         1wYe8pCEIr+U9Fq+HH/oEEhKNvHCImoMF8g4e7UWuY61j5e1e6Y08oW0LtuIUCYECPKs
         6CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1bwCuGGD1IZFDBX7uPOR8e9isCFZL5XDzXbX2TklDcs=;
        b=gv2mnlC4lQ1rD/M2Tl2+qj8NY09XR9jteG1ag7NlhfIgmvit1Vn7ogeAxCDPhjSGuW
         oFIve0FB/PoXCL85p4CGVlBzGHxsn0XC9T6IIex5SilH/Vwp7EZyDtW9l5wzZOUEyEmN
         m3RM9g2BGY7yQ0h3szFpzgPcoJsHfcDrggMAkzgNcRGflDqYuWETyjqaLBY3UdL9B4RR
         NbLE0Bj18VpxMQfX+Kh6wPjs2Kp68penXfQH+K+OsbNK9XnCXM+QYHxaCSUkTSBL8Nx1
         aSR2njeNOKIEIz9rTIfMY7ONyGH7sG2AKairJX3Du7UT6AKk7FGVgn+ckJ9Z4XB01XOA
         c+ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=bl3Cq2V6;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.111 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=bl3Cq2V6;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.111 as permitted sender) smtp.mailfrom=peda@axentia.se
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] iio: add unit-converter
Date: Mon, 23 Apr 2018 23:08:05 +0200
Message-Id: <20180423210809.29586-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::18) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:+m2xlZLgj7fCJhrqzum9x1rZ8tAMz5NNhL0/ga3TaM/UlbMcSxsLZi2PArn+sLAAd2j1gJW989MqIO7VUTqP85sxTbq5htyCPlICynCoGN+dnrmrmJRwIMzX3XaP5/x3QbLtcbykrN9pmmgFs9Nep4LyMoTo7rgPh7FDFUQVPnOclrbCyM+HTl9ZHILdr8MxMOfx+ZfK2uzDaUO4PUnsVxzSbhLATK0qY1+4xb6ZH36dYsEC0rMSaWjqUICFxtkY;25:Dv9cEiS7rAX5KxV9Ei+kCDfDb6zq4EMwerqfEKuvFie8EuIECcHXED9qDeIlpAj7d7bksyydVgxMTrT8T39/xnQcMhpgDjD7uTgIMMR2wtyS9pWpU/Ve2DBm/IQU/KaCVKuzRQ57oCxXoaVi+dWIb1iwWxW2KPjYEGZ9c7bf2vepMmXo9jP+vLyn1x8cv2u1IVJBdzk9QxFn488ASmp8joL9fMZ9A5qlvMS7k7FEMdXk61xghcnHkjieWWDlOq9JHWPJbGJNvMbwHcFXy76LkSBF05vECfBkq4LJoUMyPlVsrEvMphCUSVFaXyGcRzkFvZYOSru+/vFGB6Hvpfhwtg==;31:nQYJhuhtFJVd9BPD6wLkXK8+5etFX3A6SUMlWTl2PvIWvm2lg8kxeeI4BeUGL+z0HmMh+w7FVmM/HiAiDoLUEPujUugQMoHBB6uWYiWKPsWQbMNc1nF38eVyO+yeuzk+9nCyw4u7Q9Xs0U7/ZbRRNoKpzy3sn7GBw7QrWvkgeXnMLCtZvr4VJimcknayVinKLy2/a6buG5qRMNifDXQiXIj2WaWuYARWuKjebRQ2YaY=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779C5C415AFC53F3A8AEB83BC890@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:vp+7UBAJfKuTH0BlRwuuBlIXTrmPEXEZq+ovteDZU4bVsrEKrhoDaODuu+Il5+iWV44VEoB2S/VOJl7tHhktfuRa/osd90MdqQlYdpOCECf6Ph7odNkzSwX853xmnu66aT6yu9Psgy/3srSxax1HNCXbZmY4DMTFmmbH7tECru4pHlWTitcq38X9UHWD4QEJo+nVANuLQjKhytf3ZfKdt2l2k77VwT36GzFgsyn/sWCm5kBly+a3PTocwgM4Z6fudcT1QOpXG4OhET10tYspf+9NuRTu7LeI6uwZaHG0ADRf39Hl8wjJ/jPeksFvaD+6
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(39380400002)(346002)(7736002)(5660300001)(8676002)(81166006)(305945005)(53936002)(25786009)(4326008)(8666007)(6512007)(39060400002)(6306002)(956004)(51416003)(2616005)(386003)(52116002)(54906003)(6506007)(8936002)(50226002)(86362001)(476003)(316002)(36756003)(16586007)(966005)(26005)(2906002)(1076002)(59450400001)(6116002)(16526019)(3846002)(186003)(478600001)(7416002)(48376002)(6666003)(6916009)(66066001)(6486002)(47776003)(2361001)(2351001)(74482002)(50466002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:cYtK0+1E27n17UT6IIfUjlTtmDuWVkz9Z4vfw14?=
 =?us-ascii?Q?LdC7li5qWlNwKZV43VnriG8zCL/KQ2X70vAIckFMFgQWxlMnUvg7ef5j8Ltc?=
 =?us-ascii?Q?NSW0q6jQnyGbYRo6C3AWq4IPJ5Da5mj8tYO6SELc6AScQ2lBYdZnpycysF74?=
 =?us-ascii?Q?3kMKBvyDMQy4IHxCZArub4ptYcbP2UMiviaDi0k8Q6oGOBCdEUWsmmEW79h+?=
 =?us-ascii?Q?g7G6/7CUR4n20gXSSiCpolhOeV6RkEN8A7IhnmeeufhPiEcOIGZRgCbAtoUz?=
 =?us-ascii?Q?ly0L1rlXvu0+EX5YRs/EzIWTFsVJVaGwSavX0zTdAVCIeMz1ntN69pRAvgRt?=
 =?us-ascii?Q?u7Rh5DKWmvxbbt9m+CT0l0WoIdh9kAWWzQIV2+IFQheqlygRuYBjKCfEfz4s?=
 =?us-ascii?Q?/AC+q1bvu4c+0RpWRpZTYvgJUFzZ3BPjMr4ITyapFZ17igiWj0NboAyAiGG2?=
 =?us-ascii?Q?cPn/oRDTFQTbhvpwROzd61/zuoQX2rO/AckLrjrgSz6j5m6TnCpzBoi6fmwk?=
 =?us-ascii?Q?ewjtXch90If0bpYB+RMrDRcS+mtpLI18d/DXu9wn4w64MxAKiYCv1C4Nem4n?=
 =?us-ascii?Q?1WwjX1iV37VRApWgQoJzhP+qouRal+faZklQ8j5cpH+hxuz9hbikDu6CPnBA?=
 =?us-ascii?Q?aQaY5Uu3vCcNYJI20ICWHhFh0x8YtffYsveZs74Z1KdtoQ2dpcQmGiNQtlip?=
 =?us-ascii?Q?mTas0PnUmpe5wi+sILLM45sFf3d6KMh/rqmL/SIy20ipqXJ/O+CvvcwGslT/?=
 =?us-ascii?Q?gR/dPH3rNt84he35sOfTrVxf5fldj/QVK8GwFkE31r6pVEPxr3xZQU+XHdJ3?=
 =?us-ascii?Q?uGArd30WVVPE04doXLiWGoV9p9NQ+fc1zG0WPKQCryv9eQMe3AnRF/UwG0Ww?=
 =?us-ascii?Q?3QTSVGqPUfMSo0tAIYQWy1+ndrP6ner174u0U3uAX7v4bXwhkY/xIqiT4Hf7?=
 =?us-ascii?Q?td9QS6jrQoS4hOwk4+LHx/uyNSJCuqG6rAJKx9l14C8SV4VhsbYtlHcHgswk?=
 =?us-ascii?Q?M9MsXxZQOgnQLjTFw816AaK2IIDU23QghOeC3LYQfLnji0ROj585z93qhiv+?=
 =?us-ascii?Q?LRhTlPrUmRefeRxcQarf7rzy7Z4eyJ5ciF/sUmndsGp6oMHMMiDc8Hiq3I5O?=
 =?us-ascii?Q?bMoocZ21inEOBbKxwER1u/+tnzZ2CzbMH5xuXiIHHFuPQalVjBNbgggRE5P1?=
 =?us-ascii?Q?czv4/GneSwlOafpoR+FJQeTsM5lasHq/D/6Um?=
X-Microsoft-Antispam-Message-Info: piuN7eIzLL6/TaKdOIHuAf9gHfr6BsKMd882YXza+4Y7aU1YYOjk2SGQ7lHKgkYVCgviqeUZmsSUP/l0/ZMpEzUH/GyHTmE64ehT1jmuKoi1HazjkTgCUopWRASS/9di1DH0aQo5ZnWO3aPx4XpBD+3DIFK3aHoRzwJ7TuM2aGZhvN1Apvj6bXCe5UgRSZv7
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:Ru3zBOtFQf8xQSYQGiswp08HQDNYq0BMx8/MZ74LjO1ytmCFn/P9vPV5agT6DcH8nmJ9/BEJ8/b7tWq35E21FrxTaMV8gNNiU02MFP9XJokItDYqdszAMWqPbvGA2w97snXlPS45Gr+4HRTM2hyyJ1KfdV2XJvhurHlGgGvZj905UphhyhSY+jLWxOpGbAgz6zNpF71n5wibymAA6DR5N95RcsfPWc1tTVOKiXcxvhfYl4Ps9h/CnUUlUx7y2XFqOsi9vniKZQyaebRLs4UsApeFVwFg0zpMqLzjKZypo7CILrNpBBqicKif51RrY8lLYHgjStdaaybzUKaiXDcOs5Snr9T1ePrDXTPUPN/G2DLH2VacZFnqndLvw8KzPVXPcLJMA+ZTSMKpJeMwb7YDqxPXmbv2dGXAdSOPw8+HHs7BZOhyOJ2NifHlUg9D4GlNwPoV2LkN8ASOlKDrzB+eoA==;5:6NalQyQc33MinBe4kfz9P+6KKbn6RgkXXNPGQ2r46HpIdQlAdCo3+0pmellBtO4GPM58g7HnXUx7T3Q32GOQlNpWMok26uxuNYj/jr2VphARTUlb1lodWRlPMy2whgH/1BHZPX4uNIDLrU0u25lyP70BBi0pTB0uRwo3ZRJfK68=;24:cU7kvVYgvAgf3POqFwMC8GEyLmEFtDpHUYNpH8kPpYhrWalmf+NkF9tcfFNZaxUg471QFNHoATme6KaWsYNvqke72nWlQLBQnRo7Leo/o30=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:d/9dVIJfzjNCpRqGeKoXQkmLxelbTEsyvST3ISLjy3jBTaJrsILIuqZD77By/cXaFFBD0MFOteEUFphkE+VhIAtVBis9qoK/c7poSyQ1Yaye/01w/QGjhO+HQSwcyn6ay8sxVN1dZ9SA3gKtNMc44fCg4mCY59IezAawxUZgRR285Nnsn/ojoQf+VW4PfeVaEIKreyYfMbpSv5cCjk4Mt/42F55LEbaaYQJpSDuX3LscI96zJsA3mh5ffRj3STJn
X-MS-Office365-Filtering-Correlation-Id: 9b392979-8225-4042-c2da-08d5a95e56b0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 21:08:17.4706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b392979-8225-4042-c2da-08d5a95e56b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572675336216641?=
X-GMAIL-MSGID: =?utf-8?q?1598572675336216641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

This driver implements support for voltage dividers, current sense
shunts and current sense amplifiers. It's pretty generic and should
be easily adaptable to other linear scaling purposes.

Cheers,
Peter

Changes since v3:    https://lkml.org/lkml/2018/4/10/614
- Split the bindings patch for voltage-divider and current-sense-shunt
  in two, thus retaining the tag from Rob on the latter, when the
  former got a major update. The voltage-divider binding is now
  clear of its history from the generic io-channel-unit-converter
  binding roots (v1 of the series) and makes much more sense on its
  own (IMHO).
- Incorporate the confusing followup patches that added current sense
  amplification to the series.
- Drop the adi,lt6106 binding from that followup and replace it with
  a generic current-sense-amplifier binding.
- Adjust the driver to the above, and also rename it to iio-rescale
  as unit-converter was perhaps a little bit too generic even for the
  driver name.

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

Peter Rosin (4):
  dt-bindings: iio: afe: add binding for current-sense-shunt
  dt-bindings: iio: afe: add binding for voltage-divider
  dt-bindings: iio: afe: add binding for current-sense-amplifier
  iio: afe: rescale: new driver

 .../bindings/iio/afe/current-sense-amplifier.txt   |  26 ++
 .../bindings/iio/afe/current-sense-shunt.txt       |  41 +++
 .../bindings/iio/afe/voltage-divider.txt           |  53 +++
 MAINTAINERS                                        |   9 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  19 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-rescale.c                      | 359 +++++++++++++++++++++
 9 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-rescale.c

-- 
2.11.0
