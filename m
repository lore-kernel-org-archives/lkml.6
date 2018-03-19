Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELuXww1C+2fu/sNMNEWeBFwbLidusZbN/qvha6yJ3ImCu6nVRNKHVQ1vZfzh8/0+EqMVQ/ps
ARC-Seal: i=1; a=rsa-sha256; t=1521478990; cv=none;
        d=google.com; s=arc-20160816;
        b=snMLvnd0irZUTbvrHv4Qd3B5o7UGqxyXi7Ds7iuti64fdjb+7SHVGfFJPjD5DTyiSJ
         uYp7nVoCYm011AbR4rPdOmamhPqILPR4lxMn6tiEtWAY4vgZulIlGcIImN8skYuB9vMD
         orCcAQoOBUIsVlG4j/BtoXER+MlH2VfVOtgNwKXCyCq6Eh37BoD4EV4bPrpAxJXwes53
         U6BIREHfRzfR4uimrO2kUAYn830oCxtcgpZcS4SUp3TnPuUOg5JsuoABas5qmpCR33xC
         6mEjb4+Gg3jmSxqV70XDLAfeQSUEE5H/SOwiKYIc5Iwlfnx6iUz89d3AOjs8Wvnr4vMC
         dFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=i5/NejLF4XGn2i0rVul3vjTViH1ZChEn33tyyhmybcA=;
        b=pPORb5Q8scurjKK38aL7zEFC5Xc4EBV4hD0wPMqomHiZr+0WG64TLpfW2GLFYH1qUX
         TUdL5tESAiFk7RZ9pniWkPKw0DiN577sFguv/lGK8Y7ki3YHhO2S4RopTxww3Tqps4nR
         iurGiPVBeTuRdub42E0wMUyaN3Q15g2TafLd6wdfWavrF9NrOy/i1bXdpQEY/zFVD+9O
         GW3BC3Hu7/YfUOqnlJF8GYZ352CjJWKfCE7gViswSikLAZbLvVWmS0GRVeMqK8/cBZ7t
         b6R2mFTDIDacTqNZrAnaWG0wP6uQJfYFoFkqVECO9vUnAWT5YeAJFFvcdK1gxzzXfInv
         Z7lg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=i8BiOWlt;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.118 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=i8BiOWlt;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.118 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH 2/3] dt-bindings: iio: wrapper: add io-channel-unit-converter
Date: Mon, 19 Mar 2018 18:02:45 +0100
Message-Id: <20180319170246.26830-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0048.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::37)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d876a0-a86f-4987-8965-08d58dbb4941
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Vla372PF7EwSq17jUkM71TRzBwvfRQxMWeHOmeZTq/5YoqfwzQEuqWVYf6YBxxN8YhvjopwemieA4GAfUJHYDxDS2TwN0bn3HFavG+CYRgAbgSZ0J3e+3tIJ19PDrNUmxQ6MIU/uoRLeE/QvxGGQTqrI94YoTMrH6p5kIf6zqt3ZC0o6lZf03FoP3GqfdH6syt+wPIdgoh8+Zwora5QuZ9YCRK+SUEZEYjbZTYaFcXkkiLHxlE+20OabT+ozKmEG;25:f5CG3vS6XBmFvpb1DzABOq+m56EqHnCl7Q6iNfjhHH/0a3h4+gh1iZy1Hnhxxpt7ksCCiB0eGiS8idZ0a3OKfiaODfL1oBAZLc2QQt7klPAEIT7LoPtd7xJcwrvEHgk5qpb41YLMla4remA38ie8HBy5xsF2XSZdMMT4Yow2G/59ykAhvoU6DoX0/G8pKKhppL7bIpISHhU3vf1TSUFzz/nC+qZnHiMMc1+eObopvPze4XPLe+dYR08YvWG246KyaB1RRacEKtF0GEu6pVUrtvwDNukPKed172ne/aDm2ppdcAm+PKYm5pSuu6dBXpIHLTnWqqV1glx4LKX7pLnBXA==;31:ilh0NNNuSiNRWz4GD2NfiIxibPYThGJiEfqh4+XtP2Taf/NpAtInCzW7sAAd5GeXhzabmz9dUk8bfG0iPQ32AyPJA5mo9qDKoF5qPZYRwkLGME2ZBYzb+ymrVuHofTvLi6L1/CP+EOEVj051etRrnhTb1S+bKK8Dz0iYuGWSqDhOIi7xUIBHQFviJMUvXJ4WHTDCYQyBl+32X/7/LnVbdIFZQiyceHs+WuGDdqgXc7M=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769114CEF573BB4CEF2E8B1BCD40@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:YJoJT8wy8KhXidfnTetIvB/QSZNTTRc+8maNC+zB+qast4keEwp7mH6hfh1qSoGBREcIjz3YEJ5ZEZX+os+efvwH5FxxNx3sU+me1+GR/+TTAAPlno/YTHuPYDPXzyI0TxbhEwPjv9rOVsnfDlfLVnp77+IKtSDoALDcZvkbvklr8s82XEBJDbBJKLcOw79DWDEFABizkKCYWNo25MgXjC/g16DIy0myrbeCZblkSxckJJ4mouwJ451qT4kDp94C1w3B/P3zO9IiRo6DapKY8vaNPzvn/0N5KlzyhcInuRcWcSeBpu56gSFZFqnXNLk6fXK9zu7k0T8F/1zZxipYq8P29qK6nH2QXeCuikeMYh8=
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39830400003)(39380400002)(346002)(199004)(189003)(76176011)(36756003)(48376002)(68736007)(50466002)(50226002)(66066001)(8936002)(6486002)(53936002)(51416003)(8666007)(52116002)(6512007)(7736002)(305945005)(105586002)(478600001)(3846002)(6116002)(2351001)(1076002)(2361001)(97736004)(6666003)(6916009)(54906003)(2950100002)(16586007)(74482002)(26005)(2906002)(4326008)(7416002)(386003)(6506007)(86362001)(81166006)(81156014)(8676002)(47776003)(16526019)(25786009)(186003)(316002)(5660300001)(106356001)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:E1TISt3YqhoZwdc0juGOXFo3BfEPRw8FuKrHKSV?=
 =?us-ascii?Q?bHwaEqp9DZ5wXJ5PU743tAJO4NhLrRaovIM1V8nFXtZ7YfPmGU4oeANPsYiB?=
 =?us-ascii?Q?4o3dpicPAGXM5LdsUvti7dvIFSEdDZYBBOmsWsmQX7CRmrw4cqltLMrWs9E7?=
 =?us-ascii?Q?QVFumQb8vK/HbsGY74gtTxR6W6oeNZ/qzYdckjfzSF1go/cRqIhA89PoozST?=
 =?us-ascii?Q?N8siR8fIFf7aZSWX0cXKhIP8ON6bxbrYUDIm+jBBFLeRoBnBHsIoWWo1o3zd?=
 =?us-ascii?Q?pdntvtgDtYN2X0eETsO2r8vwdL5sE72Rlde9BUN8GjKeKD9HZtDV+zE4oSKF?=
 =?us-ascii?Q?CJGWJwltAOHB1sESC+WfT1zRojjFcLlL5634adkz2pPjfeQKPMvpe8Moeys3?=
 =?us-ascii?Q?BdLkDYRj9/Kg4QQlIrgkVzVkiAIDyQu/IOw7ybhWrRtB0nUYeqhmUE2seWrC?=
 =?us-ascii?Q?R1+LmxhBGFGmPy2KoQ/X/vdSYf6UEwo0C4H91+T3rQ/UcebzI3aIZimnQK6F?=
 =?us-ascii?Q?NPoW/sqKHwSV/IO7MQjExJscQtjB2tbUSCdFPjlx3TZInoEwuHzf/XYjh29X?=
 =?us-ascii?Q?zF3baHKYB/QWaI7Tugwl5NoCEpel+E30uTDbRp251hGdmfCRKHmuNd421hM6?=
 =?us-ascii?Q?1tsEw2wYbA5LG49KmvyIBvFGxpmciuabuNNBDdWS/Q5DHJJ2p3dqm7TvAdbL?=
 =?us-ascii?Q?BYPG0Z5ChYQnXjTZgauw++/F9TSfa7bLe8qbIRyENiElgvKRsJQ0xiuIS48g?=
 =?us-ascii?Q?tbhLvZTEtmIPF2i0cQS9xvpK6titibxUcAPHYHuDYaSMghcbuRWZ8Oz6nSyd?=
 =?us-ascii?Q?x98/nqnem3/j8HZWAIIvhjK3PRAqh39yZVoo1bzW/CrgL/xXPrVl8ug3o+8d?=
 =?us-ascii?Q?pdeufKnTNmfWoPkHexCxXLO2x/PmNIjBKomTohmFUgNpcG5NLJCS5YPZ/S+Z?=
 =?us-ascii?Q?xN5VgSt16ErM9k95W2VLl3a09lQSbp6W+v6wq9tH2vqk0JR8mT6xkVqzPwxP?=
 =?us-ascii?Q?cu6glerlH+Xpo41rOzsbm46yEzWdHOukSW3+w6QZauMmrFRB4Izhj56ciSDE?=
 =?us-ascii?Q?QXh8zWHGHkj3xstiYeBFdspFwxCzKCFtv1JOULEB+Nvdcy4M0ucFYAZZ++0T?=
 =?us-ascii?Q?yySNrLyzEZi7Vhah4hJ/FQS+oUOiiGFcsMXMah0QEBd9FWmOk8mBAeoMutfZ?=
 =?us-ascii?Q?NPYcs0LTT+apioPxFB8PNm8VbiSpHHOw1anfr9czFE1UOc+gSLS99ePNLlTf?=
 =?us-ascii?Q?SzXLILe0zfpawOAIJAvxkv3SDrTiLgS7+cy30qWjauk4ZCjhD64vjbHI9nQX?=
 =?us-ascii?Q?Cfw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ie8ElT1YdLE4qkYqSjwJF26m/n6DLk2VBIQbiGywhAkRmdn3wZkC3kPtF/sCyK9m6NbXDjR9ZDlax8wqZemCj9EBxPfFEsaQuYmWTdiR8O6AfZiYxwcjns5YrGE1/6O6XlJiE5aaX2GB7srCuWXBRFMtDSSGypWZibthmGE2WH8LtqRsAihvzcUECHZuDvJC
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:RRaLSJkEYpcSwXAPMb5e75cHecpY4Hcg2bM7d9BB6drqMYzLZ5p7xHBv8uEzH9/fM8PdFCrFUe1dMuwrfVhh/JRccrz+NigG4OPKP7UF0BsrzZXVndV05Lj4pI76eN3X3eFNl4V+C1dwn9Vr7HOtUdLM93J5Yrjr1f4mfw+sbAPBE9xfMlxSQRLNt9rrVIAivdLVhq7QbxrYhFVAU0fr0aYwM1WExPwLvue3lgOUYjceVMZqHsFHk74WqrQ5BzzzrA2qkNPVbLZ4svcyCzoSx0zGJ+FX26JHcHTgrh1C+KztOz9YABlsyJ/haKa9AlaTBM/ILMbEZCdXaBdC3jJL8odiTp9aG/FOYY2KvEtTLR8=;5:wgTlMpMFNsIZDFihRmtX1s1G53MT0cskYL0xa7NFRcf0VF1WxLHqGUoz3g4SGNFm6Es6os2m3XsaM6rLgTcNmcAEHewvRmnmetGAIGvmy4jXvw+ZiRnHNil7cIFprLGj/bfmMdkDzQWkKndOKExG5q1+vfAlNYlSAPjqO43tHEY=;24:99BXMicWiJftvIXsMykPVcNXwdwFXL9iNGxxGsCQ/xKd/bLzaez25/zMz1ZqJ6prBAysCmJB054Y7GJWHWlFrLJI9Zl2TKhhhoh8r/BKLFk=;7:ltE98YGUiTmWDdlv18mVaKhVNoq8MDCMfO15amJFLko7gqgUwaTTY+/hrUInz1c3Ds4r6Tl8ZM6n2BaTON4EuULvcev5zstyBW/lCEHVhlwtZ/V9lsKQaU+Vpem0CpCHtwM+DRYSLe0rOgG0r96DQ3Ion6ExX4WeWDIggZDShfrxbEEOnbjmKRG+DVp+AInDIgPPEkgoGdwS+McI9nIttoHKuCrWDOmzSqyh9NzLQV9z3K7a098juOrDmYwXg1FC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 17:03:06.1118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d876a0-a86f-4987-8965-08d58dbb4941
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1595386352511078978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allow linear scaling and modification of the type of an io-channel.

When an ADC channel measures the midpoint of a voltage divider, the
interesting voltage is often the voltage over the full resistance
of the divider. Likewise, measuring the voltage over a resistor is
often a way to get to the current through it.

This binding allows description of such hardware which is external
to the ADC.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt

diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
new file mode 100644
index 000000000000..23af661abe32
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
@@ -0,0 +1,84 @@
+I/O channel unit converter bindings
+
+Allow linear scaling and modification of the type of an io-channel.
+
+When an ADC channel measures the midpoint of a voltage divider, the
+interesting voltage is often the voltage over the full resistance
+of the divider. Likewise, measuring the voltage over a resistor is
+often a way to get to the current through it.
+
+Required properties:
+- compatible : "io-channel-unit-converter"
+- io-channels : Channel node of the parent channel.
+- io-channel-names : Should be "parent".
+
+Optional properties:
+- numerator : The parent channel scale is multiplied by this value (default 1).
+- denominator : The parent channel scale is divided by this value (default 1).
+- type : The type of the wrapped channel is modified to this type. The default
+	 is to use the same type as the parent channel. Recognized types are:
+		"voltage"
+		"current"
+
+Example 1:
+The system voltage is circa 12V, but divided down with a 22/200
+voltage divider to adjust it to the ADC range.
+
+SYSV        ADC       GND
+  +          +         +
+  |  .-----. | .----.  |
+  '--| 200 |-+-| 22 |--'
+     '-----'   '----'
+
+sysv {
+	compatible = "io-channel-unit-converter";
+	io-channles = <&maxadc 1>;
+	io-channel-names = "parent";
+
+	/* multiply the ADC voltage by 222/22 to get the system voltage */
+	numerator = <222>; /* 200 + 22 */
+	denominator = <22>;
+}
+
+&spi {
+	maxadc: adc@0 {
+		compatible = "maxim,max1027";
+	      	reg = <0>;
+		#io-channel-cells = <1>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+Example 2:
+The system current is measured by measuring the voltage over a
+3.3 ohm resistor.
+
+sysi {
+	compatible = "io-channel-unit-converter";
+	io-channles = <&tiadc 0>;
+	io-channel-names = "parent";
+
+	/* divide the ADC voltage by 33/10 (i.e. 3.3) to get current */
+	numerator = <10>;
+	denominator = <33>;
+	type = "current";
+}
+
+&i2c {
+	tiadc: adc@48 {
+		compatible = "ti,ads1015";
+	      	reg = <0x48>;
+		#io-channel-cells = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 { /* IN0,IN1 differential */
+			reg = <0>;
+			ti,gain = <1>;
+			ti,datarate = <4>;
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 96e5503bfb60..5dd555c7b1b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6884,6 +6884,12 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO UNIT CONVERTER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.11.0
