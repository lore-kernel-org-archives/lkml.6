Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+F6A2NSzhj9YWDTdscEbRKGu5p/IXuzdx3UVsjm7ZlJIpgVAqJ4rv6b067Sm5OX7WOhN72
ARC-Seal: i=1; a=rsa-sha256; t=1523456190; cv=none;
        d=google.com; s=arc-20160816;
        b=xsP63JpBD7HVgeRZJXth/FYVW4/VzCXOdTrwJSfaiT5zOHiT2ANwNR+2HuuC/Lgv2I
         sZ39FFc2+Aj03RkIOuMUDc3SV13h1GC2aZVF2RVLreCpdmgP1lIE3cHXfZK2mrSiKdaN
         OzqE6qIrAR5Lm7oe0zZXyFH8UMXsLR4gLZHhJ5vyf5riadIxJqR6Z5ljE5saVsFsd8kG
         te6RpZk8GcEpGjhzdefDL6bCYOmhHWLetGzJc9qT9PxkQ2amXavg1AosrK/zecrN9Ae4
         P/oOAFON1wqiJBCdCZnVYGTQ3549I/5ktDbtT/X4dhpz5JTWMaKWwnEdODPQmxqwGq26
         hccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XIAtaDOmqJ3yD0KpPCr8CST1R+rnvy+JSC1exJnNhYA=;
        b=bdjl9jegXe50ajQhQq4+WGq7Ysohbu3YIPhcpvapBDqg3s1W9Ch+8bvgv2DkTbMZK7
         B2fSE2G7ws43BDu/g5d0P2pEPxllsdvaEh0NVHdSspnNAV4hhIqgV0CujMRpIsQU3qzn
         9CkdkC9qFNXAoYe8yYMIgNXilqGazFDfQLwGZprPMwejN6M+tFVUoCKNj+razjvyO+N9
         ESeFDxoCWFvCkYCN+J1P+mX/729lO3F0jGUaxK8/F5mA2PUwMadnjyyrXAD2/EsMwKjE
         g4lQaFijHlYR9ke7Ko68jHtDo3KzTu5tEqJnehi89ScDugb2+6ROZrCiXxYfzhMGDblB
         Hy1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=gkrQBEG4;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.3.125 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=gkrQBEG4;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.3.125 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
Date: Wed, 11 Apr 2018 16:15:55 +0200
Message-Id: <20180411141555.15044-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::27) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:6VPr5lw5Q48xShudwVJ7dRz94GvVCcpT91FtXy+xxFP8IMwLd4z0Pd6QjU8zhFFcISuziKGBsc4T147zlnAJO57OXW4h6m0f5R8qQH6/igyZc3Mfe4e2CQccVBjzLfGri67KiauaxgXtzpiMtyzaB8Nlofq+EdSuS4/zYEzxnp1jPmIOpxus1XQ4g76HIxHgii1e2oqtLLwQCuAolLPHpiR6fHwUlHNKEMk8Lm8JAmIV0fxm8zcANIv4dbmW7UCI;25:mIuVMsmJLUGhdpzBny9bigBc7Z+N6CL6Lb65P0m1hBn/G+AOldjG+lnK5seS00r6Lwuqn+7kzj3iuzJzJRI2r0sJKG/qnBVYq9AcJYQ6lmUXrbDbeod+8zdg327YJ07Gif//eqa7i/rNmZiUlWipumzdt1rcU7UaGdhrHrVnimTUJg+5HM2AYf/Ola9tFXr/10BQxs1PcE2hCS4r2PoCoIE9fgzyCCo+kGJPC3OSZ4sIPWH3IGet3tlLeNyNedsVKWvW8wBRNyYt8B9oi50XcAf/AsaYGaE4NWe5+wR3/uO7Af97p8ufHffyeIxKVCQ+oICZWANuT4dKLBQMq4qC8w==;31:JSBcPR6jBirRfV2FHPvMowj+F7/Q32P0tbOmcBbQHwfIUvTlisXqFqc9dAHURZDm5irhEksod5XnXSlSDxEY2T28PD8yUiNTkDlSY7/SJXqsdb0DUMlSjo37Go4rcE9MEcomdQcRsKeko0eWyhhv7fCYeaJMn7yqJKdXMxrYojl9QJ0Vyqx4UiZQxwZH1MKI8Nor8YKPC02jDnTak9+d3ddh9hF8MQo4/9kzXx7UgHA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27834452BFDC7D504DF82D7ABCBD0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:YrtLTsfhVFHYRYUSEpbC/ntZm7PF/rcM8m6WEnsZ416avwfTkDakeKGtcmkFWjqvXVd94WENRX5yAUKdx8nElacM781fFWMmbjnANaxWt/HXLoHvi9J52yai1J7qRTgv4F7kK9hFNwNs68kA8L1JRccjBNDiHtcxv9Ge7EBsJ8eGSiLM3Ml0110WJSrmAAcR8ripA/7h56Eo3+9q9HsnWQpJZObDohwvZUZwsL0e0Y0dwYEhdiw293KEhfaFizHtZbtLIAeYDG3xoCEtJGEH0Q==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39840400004)(39380400002)(376002)(366004)(189003)(199004)(8666007)(6916009)(52116002)(54906003)(6666003)(7736002)(16586007)(6512007)(81166006)(68736007)(575784001)(81156014)(105586002)(1076002)(478600001)(39060400002)(66066001)(8676002)(47776003)(305945005)(59450400001)(86362001)(50226002)(486006)(53936002)(76176011)(316002)(446003)(51416003)(8936002)(26005)(7416002)(11346002)(2616005)(6116002)(186003)(3846002)(97736004)(16526019)(48376002)(25786009)(2351001)(956004)(476003)(4326008)(50466002)(2361001)(6506007)(36756003)(2906002)(106356001)(74482002)(386003)(6486002)(5660300001)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:zFo/lEQZHqPgK+iaA2zbgcoNdiz1R4MVD0PB5bq?=
 =?us-ascii?Q?weK8rtYa96FByGGfg1PckQ9PUf4bOWtyt3pEckWicEsjkS1pOO1+d8gawpvZ?=
 =?us-ascii?Q?DdD8hxVu0vTGxlnlMcneVHspjdkBdieOPLUCA/F++DjJby/6lGH4PHnsk3rv?=
 =?us-ascii?Q?QBJVWJEyxRDg8KjQAXFp1T0T806agIR/BJh+7UZxgAaCPlkN29wgVOZaH1I7?=
 =?us-ascii?Q?DRVNp76rQPwNDIoIX1uN3gYervHJZf1AXd6papn9eLos+6sy4YTVlzIueU5e?=
 =?us-ascii?Q?8jz5w+txKnWF000bGTDCZjsmgMRjR4Gs5D1gAOltzMj+YKfvqa9N4NPp1dOm?=
 =?us-ascii?Q?ULoc1gU0Vl5q00zjGzsg9T701tqJs+cxQSvWIM1rkoItkF/ynXU/583wPp8u?=
 =?us-ascii?Q?p6KQFiQ+RLaOg+m8cW8rhKL4QrP0bA7P4Do0NOedBIJ1ADL8OzwQ2R9eHNp8?=
 =?us-ascii?Q?WMFKoLJQOov0QTZbMc0N73KMbfQ/d9A75slV49xEdDFdoRjQsqkywCqbgSsO?=
 =?us-ascii?Q?bRqC8X+N4h3+GXhhHrWjp0S0OSomYCtg4a6FzLTr3HHU4JGEC0vox7/AlYJs?=
 =?us-ascii?Q?wNLcGCZ9+gbxon7X7CEJW/QGjMCeS/NtXx/s0Ig1Y5weWShzG71VJKCwxyuO?=
 =?us-ascii?Q?Ob+L6fP63vgNtORYI84jlaKiu5tZIpLKb+CoiRBvY4vFo7gYThx4cQnGgO7p?=
 =?us-ascii?Q?Rh4scj2MfEo3SQd36npOiI7GQ7ce5PBcaaBGHpWFLpcFvP2P4WjxF0bL0jPE?=
 =?us-ascii?Q?pNHnfEe6wG6PMuFPw4tI3g1dNNLGjZIoDFVgJoj1LG8DBaRo3AvxdxYJyUrx?=
 =?us-ascii?Q?3qJ4XOMzf9HPZ2uyPQFkOmrpLjUEPm2V2fkdNaFJfyUtoOflGYoaS8ANSmos?=
 =?us-ascii?Q?/AHRHcXyNSp61/BOd0yUFJJm0CIRmxPNydU9MvfKz33q2fJBD5dDUZOv+pSh?=
 =?us-ascii?Q?5eJZr30Q5uCVajEByrIvm7/J59pzHgK5/OQhRvsGW2/CoEp9bQwUiUASwFhF?=
 =?us-ascii?Q?0s+W9zz70S+7ZdqpSC1xSFRaxJpZWwCA1Oli436eQqiFalnHLrlc3p5d8k5t?=
 =?us-ascii?Q?j5Zf0RvUkyOiN4CAu4T4BmwNLu3saLhMqY0r7G7T3fynKc6D7+GURQ2Ik0SK?=
 =?us-ascii?Q?D3Yh/XI0DtgP5P2bZQvhOvKN6nltwPOph2+iENaJ3v+nhveQdTQT4OhMA3Gr?=
 =?us-ascii?Q?iWxGOl6/RJBfKEYH5efa//75jolSHmddIrxjHyvgHsu4V2hbVlIYmCMYj8yL?=
 =?us-ascii?Q?GXmAwTT0WCnmxWNbxQWk4FtxQEKur1WHeL85DWtZXxsTbg+GIXabVR3HgppV?=
 =?us-ascii?Q?KBFF2q7sWx52r8igdBSx/jQQ3FV80ypi+LFGISc8+JTRHUW51xj0AmDzzgm+?=
 =?us-ascii?Q?/owOnG4+KpEOCdxcG95ycUNql/HOBGr7zumFf5L+2gIPFKEuUNF/a7cz4+lu?=
 =?us-ascii?Q?EVZVkaLgFKhTw7WZIozZiG18Gtw6TP2A=3D?=
X-Microsoft-Antispam-Message-Info: ntvKC5TgusQzwEEJiKP5fHqhCy0VPiYNVnAY2f0OtXUn7Brc+bFlqjmZm8ySbR+xsLAqhpvS4oIK6Y225NTDUDEaBrRfWDPXX8P1yz9LmLCBNtewlOMDOYnRXzfeqJEKCqIlBd+OARK+KEWzO6sr1emJtM4Y5AEDhqk4ADouI0JSc2/z6XKhvIsPjC703NqV
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:APCPei3MTGIdkMuLIBuK3iE739iA49kczZ9UrMzvVZo51FehgZZoN/sJrYpTDItGTc3WDyWhFATR2AKw3cKaPGAMlbXEpAyJ9rr6zUnPJPZaHfyIX0q746EcCMm0BKDIUqQVuCG3tIzyLNX3ay9lNEmbVvTtbR/MKKhewU6z84M89Ll1ffvqjsTkE8WMUj/dksfLCDz0RVWRcbooghrAW4rbuhaY+aXilrPZR5TZ9/nNVa5aLHpxYx6616Q49nVav9KP5lEK88yt+GAGEQd26r+Q4wbit1rc634dmUEJNqxrpk4Eecq4iinFwQMPtgM8Tv9adVuUPFvAGlOK+mMdNWc1ufSVgWdQgy+ltK8r6KYvnJjGnQl8qTQFqrTNzyrsWJp3QEerBOoJNs3SfxuLCWtwHT7Gk6Y1ojx4OvsmXHKGcXtQXt/JtMYc9lf9xkBkkXBE4zB35HkVzuqyGczNPQ==;5:ughh7/zyOHqp5qCeiveBFTUl3R//qBv/444+j/higgiV3V8AfPFdAeXGPq40uha6QpvRDXVnEUcrTazXu7LfSvllogvqA+oWvo15I77lk6hLQxyb27F+zhR+BUm250n92coH/E3afNAz1AZvGFbKNvQE0GZnfWvVMFuOQxxxKy4=;24:rN+Gaxn9S1v+cI3zhwmHdPxn+MlJ0UCFmcsCjp62h1vRsIq6E8Rl2Tf6j2kIimoFHYz/EPz32ny8x5CGeuM6G7PhYFCEfj6MOhdv+SwAmGQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:aaCWonce6NplBubfYmdaORf8scA/g6Q7Zatuu+hL7wC9d6pbQ7ySUSDLBA/H8WWFSB+negevG4U2fkgv0g3MXwU7ySUtJZ+2RLuXVwjKFOCY5aBy6dKHCEgGhmtXcmTgbcwHBOU54sMxEjCZWqYNkpf3JJJokAiPyQCIYHOkXXYAmHN7VrCRbh09TQl3C8C4FGawtO9X4uUt0xeA4k8/IOZt3jgyNifvYacgsly7rAy1an+RRxxR1lw8D3v2YliB
X-MS-Office365-Filtering-Correlation-Id: 7dfd21d3-631a-45fb-f7b8-08d59fb6cf79
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:16:24.2784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfd21d3-631a-45fb-f7b8-08d59fb6cf79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597459598272065653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a current sense amplifier from Analog Devices.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/Kconfig              |  3 +-
 drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
index 642ce4eb12a6..0e10fe8f459a 100644
--- a/drivers/iio/afe/Kconfig
+++ b/drivers/iio/afe/Kconfig
@@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
 	depends on OF || COMPILE_TEST
 	help
 	  Say yes here to build support for the IIO unit converter
-	  that handles voltage dividers and current sense shunts.
+	  that handles voltage dividers, current sense shunts and
+	  the LT6106 Current Sense Amplifier from Analog Devices.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-unit-converter.
diff --git a/drivers/iio/afe/iio-unit-converter.c b/drivers/iio/afe/iio-unit-converter.c
index fc50290d7e5e..4b0ae5ab9c2d 100644
--- a/drivers/iio/afe/iio-unit-converter.c
+++ b/drivers/iio/afe/iio-unit-converter.c
@@ -144,6 +144,53 @@ static int unit_converter_configure_channel(struct device *dev,
 	return 0;
 }
 
+static int unit_converter_adi_lt6106_props(struct device *dev,
+					   struct unit_converter *uc)
+{
+	u32 sense;
+	u32 rin;
+	u32 rout;
+	u32 factor;
+	int ret;
+
+	ret = device_property_read_u32(dev, "sense-resistor-micro-ohms",
+				       &sense);
+	if (ret) {
+		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "input-resistor-ohms", &rin);
+	if (ret) {
+		dev_err(dev, "failed to read the input resistance: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "output-resistor-ohms", &rout);
+	if (ret) {
+		dev_err(dev, "failed to read the output resistance: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Calculate the scaling factor, rin / (rout * sense), while trying
+	 * to keep the fraction from overflowing.
+	 */
+	factor = gcd(sense, 1000000);
+	uc->numerator = 1000000 / factor;
+	uc->denominator = sense / factor;
+
+	factor = gcd(uc->numerator, rout);
+	uc->numerator /= factor;
+	uc->denominator *= rout / factor;
+
+	factor = gcd(uc->denominator, rin);
+	uc->numerator *= rin / factor;
+	uc->denominator /= factor;
+
+	return 0;
+}
+
 static int unit_converter_current_sense_shunt_props(struct device *dev,
 						    struct unit_converter *uc)
 {
@@ -175,11 +222,16 @@ static int unit_converter_voltage_divider_props(struct device *dev,
 }
 
 enum unit_converter_variant {
+	ADI_LT6106,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 };
 
 static const struct unit_converter_cfg unit_converter_cfg[] = {
+	[ADI_LT6106] = {
+		.type = IIO_CURRENT,
+		.props = unit_converter_adi_lt6106_props,
+	},
 	[CURRENT_SENSE_SHUNT] = {
 		.type = IIO_CURRENT,
 		.props = unit_converter_current_sense_shunt_props,
@@ -191,6 +243,8 @@ static const struct unit_converter_cfg unit_converter_cfg[] = {
 };
 
 static const struct of_device_id unit_converter_match[] = {
+	{ .compatible = "adi,lt6106",
+	  .data = &unit_converter_cfg[ADI_LT6106], },
 	{ .compatible = "current-sense-shunt",
 	  .data = &unit_converter_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
-- 
2.11.0
