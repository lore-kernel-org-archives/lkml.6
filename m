Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+gmKdd02N5bCfIpdGaWkSKTM+Sz+Dwt9k/WZdsdA7uE3KTqD84j+ZZBSGMiZhdiiqH8vVi
ARC-Seal: i=1; a=rsa-sha256; t=1522769815; cv=none;
        d=google.com; s=arc-20160816;
        b=wSB84tbz7XiyrUHU1KSp1DAGRW1juolDXcbrera+S5O3Ws8OosB5u22seWG6jqkBsC
         MfvciJy+q9a96iMFe+X4CdpMJ9/zNPp1k5kzpbcn9JPnk036Rh5DUHCuIHLXfiYlJbvX
         J/LV8dWH6cAiRBlqCb1k0zYLDtAY8s+OFBmQ/VIOhGWTeoPd0pYWs5U3IEbYI7DZvd/0
         +NuRe0iXVKWmVT9JkpMl0XMn60BQkDQpBQIFz+TSJwtW3pNbYTGltjb0jJh6CgowB/xH
         PaKxeGwc5kGmXSYkIgLLf5kbtIBxpIH9qttaON11IDr5vcjouIqLojPxJZs0xqiE6ZiC
         3J/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=2DlelUFvLDPe8tDJvu0PaJPi61Ou2+kn6Y/8a4yOwYQ=;
        b=NfQsRHgZ9ym2VnqecGDLE3du/akLUlFLajXj2oFWf4tDBUicSAhCQPgy52ZOoesdPh
         eaEPJlUYxP+xR1eonfxPGRHPHQ2gPcIqewo2eQyw+vGCH82xpOolqc+I8zh/we0kYUkF
         UaR/9WypSYaLAiPhd2pxerlZsuSTQqfQv5Dve/SxefhpDZsx81eDNX/rWn9OZdM9n25t
         ZOJF9RgynJCfjlq54VtrGCDZGRdI5mLAmrbwIEgWc8YPItxZu6fMGTg2JvsO/Gz0LYCM
         ujv4C2csmwtotAh1lgbCetFH4w+hnGBQB4puf1lrSO7T5qeSjY7AlaV/kmfbs7FRBzEg
         7pbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=eCoCmt7n;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.139 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=eCoCmt7n;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.139 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit and voltage-divider
Date: Tue,  3 Apr 2018 17:36:34 +0200
Message-Id: <20180403153635.8228-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403153635.8228-1-peda@axentia.se>
References: <20180403153635.8228-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::14) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33008953-fab0-4c96-9830-08d59978b93a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:bSw0iSB5C7ljcRjb7oUVpUCYo75Qh4p/9xXXZOtVlRahf3ogf5yQXkabxDBYP0FERShiqjfpxbT+psLZfmGEIBDLhNTgH9BPaYJCn1+9IW4Xkxkya9fP/vrcltgVb5X6TS3ozI8H++vYQaWX4YkYbShJwFsEVtUYPui+iEwg/zFgb5yO/d6rjuWXdm3yVXIDE6/O/u6fpr3gySQpI35TBP+bqJiao2czbPt7fLecDl9Pi5KcKIcm4xN60WJYVyLe;25:Jg47bk0oVNVFtk5voXkRI9NWSNUup7s6eSKmBTLKGQTQwKTdQ92ESu2hOLpt+AE+DN8bFyaRzu9LBUSPOeMs+SihPzHS6oNPHQy1eWUB9se7q2Rq4dgAfoCnsfVP4EeRnIKKS54291I7yusQ7J0ipg/ohGJbHKMhpNkMwsibQAaw0mocmBMocuwYC4GP78jXCuJ/9BkzTZgEu3VOmbvR4bX3/Me/DIPeJ/4mLMcCPDR57s8WEJPz0YKRbf5am5PDf0MJSBBMcuW59+kLWuVMeoaN7NBRdkNdgDvU9GNdGqnfVmtknJhlMA1/jOr9lFQeA4uuryZGOXcXtUhIBxWkEw==;31:KC1ix+vw2U8J7ZaKE75b2QkMbiQ0oGNbeQRtmVT7h++FLMHWJotdgsIArGDNasCYx21txNoYGKEObmtewCZ3hQsIiDwluYMo4YrIJP/l7/EbGKKT2YkwZ4KdQQYEqWgCPozlgX8wnLJQMuJew2aLC2PolOzgqexDLBtbVHBmEFGOH9CjfkhcFxv9VsppVNbjz2AbU1LVV0VZbc5eqAX4rdm0jMMPtLd8vt9aHlYChBw=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772DB038546ED17F8C010F2BCA50@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:5UN/77Muv4gPw3r47f/ccRjhjw3yBtbyEegHm8HKqL+OOdikUSd0gSNp33bKzxfghU2HI8MJT7HxgdmWlhy/OPZLCBR9m0VicQ+aa2Dn+IGhKzoSPGGheqIE4sp0g3HuNoRqVk4u100EmWeZf0PihsaLAq95VNgTx8sqAANWceSFSqpJla1I3Qq1/JhwdqBzEF8TbD98cNSLQs4QK60qdxvEdJEGN2jvMb80W7T9mmHMzlx2xQwDnbEfeZoleVnekMDjrV8urqYrL8zHCpII8GhAfD9/4tokPWYzlfUOIT43cex/plIJfP0rEbFQAA7C0DvZv7URilUAQ/hTyDpfAw==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(366004)(396003)(376002)(39380400002)(189003)(199004)(47776003)(6512007)(476003)(105586002)(53936002)(76176011)(16526019)(186003)(66066001)(97736004)(52116002)(4326008)(106356001)(51416003)(6486002)(8666007)(36756003)(6916009)(25786009)(6506007)(11346002)(486005)(54906003)(386003)(26005)(446003)(956004)(486005)(2616005)(81166006)(81156014)(6116002)(50466002)(2351001)(316002)(74482002)(2361001)(1076002)(16586007)(8936002)(5660300001)(50226002)(68736007)(48376002)(3846002)(2906002)(7736002)(305945005)(6666003)(7416002)(478600001)(8676002)(86362001)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:QXcotkMahbz+3dwjLUGckiIX5xBZErVVyFQRZZJ?=
 =?us-ascii?Q?EdWODxPJqyutzbwkwxEeizgx94eROvlLl6Rz0C2dopsBJJCtLIW/RSjGLL/2?=
 =?us-ascii?Q?K5Zgvseed5aYE+4k0jFvh1mT+LdVZezqHo0qsdSZCIkrUGG7sh2nVK2ryS2m?=
 =?us-ascii?Q?ddKFvmMoXlSCYHKm8AtA4gZMmfQZlOcIclNQ/06iZluzdkdbyWys5TYJp4m5?=
 =?us-ascii?Q?nFGY8+K8nBrsWebQ5KMXHL9qz3EnOMj/xrwWSa1HlEe7BiMg50fZ7zTs+G8M?=
 =?us-ascii?Q?sQheRl1kutncItXVEnZM3Hgcz9ZFE/vznngOU2kQtan5Tt1QkI3dTKhJL0MU?=
 =?us-ascii?Q?2D7J7mJxlNe6YMOCbZDUPcEBA4oQEZTLEZvWpJ25PMG2JsXiFjkYnD6mxVy+?=
 =?us-ascii?Q?3+FFOKFZt/W7WfcDRDksoQCB2LQiaGvS2Pk6WIyo4qDAieHg6NslgIRXGRmE?=
 =?us-ascii?Q?SHMQ9jLct36/KQ4/0+KNQ/vFXcnWegUsdCgk/G5Lkti35YOTrLY/8ORkYDMz?=
 =?us-ascii?Q?ki6LqTNfj0dztPHxp7+DncJCgqyqlyB7frXToiwY1d4b6SsQ+cpwu7f9UQs2?=
 =?us-ascii?Q?E3fIgyEGk2r0YnCuQdL021IUtcEn37DXDpFYtDeZ8eOWuGv/7CPGbF2eEZKX?=
 =?us-ascii?Q?m4QsUDQ063ezlV9/GbwcbUynzajdHjHvKMq2RBQsXIbrdIAmfDSSosefmL/6?=
 =?us-ascii?Q?NsdRh7eNV5vNFZKDOPTxvh2KXvtmc5yYkkSZfBr1NLOOIDZzYX6SiWT4bxi7?=
 =?us-ascii?Q?E4tN/wGKrt4fdRwBh2Ohqno3nEH5LhQO5Ht5hJR3ZnXLo9kedrAGHRqaYaCi?=
 =?us-ascii?Q?wo1T7PHyO5pt88zk03S6txuxGrVu2rJFtbaJ9x5KVuwmsDQScHRsbiBkHsqe?=
 =?us-ascii?Q?5sRXRw08slqlWOSj+EgAIAa/odJZoA1D0ZD0prNtQmOFC1DWUclUE/uNCkK8?=
 =?us-ascii?Q?QvF3g5Mwa0seEaxt4lVPlM4JNSOQ4vgSUf94S/3JL5lauML3/vBYOZn2FmQg?=
 =?us-ascii?Q?UYAV2zAJ63Sw6lStXLUxj94BjUMM+q1flOMj4+6o3LZGd+qZTvD+jBsgZC2P?=
 =?us-ascii?Q?5VcMNf4I2iVgPgZ1esfSS1GT3W1XPsfHtZTMyuEuprXenYVE3JZCPffiJL2N?=
 =?us-ascii?Q?NhOgzCGzMeLH1cztz8Q7EuX8f13GWRuZiS+oIVoth2P3LBIJhGLfq66ket8X?=
 =?us-ascii?Q?kgq+Nq2FAlg7XtCJcGYhpv7CskrFt4lhOubiLXVnVOnCXPwpuCw/tUN0wBPl?=
 =?us-ascii?Q?Jrzp6s9JJ4elrZN/NA4R9MpsnXrmij8IHQXfHkbTsY/RYArqknGtOjuFY2cT?=
 =?us-ascii?Q?Q9gYXPnePiQCy+SIbDauKfsLIswC7ifJOGN4CiIjunpH+wR0a78MOGkKX/WK?=
 =?us-ascii?Q?ir5O1vkI5TYwm3EAcVQOLOAQsYUU=3D?=
X-Microsoft-Antispam-Message-Info: 6tsivey7oGT+9aBskA41Af1xfUAhvapyAqmUrJUmvb8dsVZWPELT+CbqUSbjBLoBXh4xiuEqFutHgRpYXtzHN2Z1/ZVIh2kjsGP1E4y1fdm98NGh1EvCkIVwqvYO8dLPfauEMRjla/D6HZDQ+DuoncWj8PxEqLrB7GnRxjTF0Rd3TRFjAHFkwjXKCHrtlRyG
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:y+jZ5XjUP2b1+gB6U25T9jNDulGgjJd4M+OvGevSBWWVLVuuIzgTWf4X8pczQRjm3pDb8ZmihkcwzZ4LgLCL/krAgRcLadixKS4M9e44heRwZlew8ypBZxAEAl8J+Mw4aY51qvpAmfNhZdTAc+DYzTCLfEidX57deE5S0+KQ7PuLjyg/TV11CwG/Wg3vATVEaCoNTDJbyOeghiaOEVSPQoWDbiIJA21WMjYF9w4y2SK47LodmceKRsWGWuaA48wgPRQE5stcymjSi65Iv4wb8ojQlEu1nAK4HKtneUKvH02FELeRv2FtldGPNHgLIBy/uyPmRBIc7gLK6pmJHJm7NkPtOS/FtAOs37BdC2Z48SmVidiqNs1KzFrlwc3VJb5+snX5ljOixrmR9dV7y0oSHX1dJ7HT2ajlmFQPLPFfYQhizUCBt0lWL/EpRpPjqpN6LPNGxs9IVqBiPEHYMWafHA==;5:+/mpJVL6+0uhb7571qRse0EEU+af6YzPf6aTIYrrz+qcK6ggLWXV3Hcnwoz0bnNsemrZQiVo3W2eFlpKBsIjBAAHLw1BBFO0nyGc7IdHAQGae+uLiYzo8pYUNoGbR6Bc44QbMC5ykn+kLFyDPtI+jHJqUNa0Tipg6ehvPHJxx8E=;24:ltDn8Y8ADMmkEQwkhP9z0oXhAmozmjw/439kXbqcGQY0jbPrJaNzhO2WOPumQohj3ZrzY44+WCUMGnUYJiU8cE1AZqwI1yLQb0BG9qtQTQY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:BFglMAWsxE+Pcsw3V6/P/4H4ES3OBgEh3tbWNDOs8cX7QyTs7NUbS/YvHfQiBwgPR4EyoM2EpDcSu3htLnN5iQNPzucM8aWexMANGiK0zjVt07nJiGnP1WCSeOp5bgSOmKIyGZ1Z789rapEdveBRpB0kLE4r09CLoiqnH2M7ATRpOSCCNjZd633aki5qT4TNvK5uu2HNM2mu4HzKCb0OifWSHqdwoaWJT+Y/O1MAwmSTUbpMXnTRkFhBc9syq/PQ
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 15:36:51.2732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33008953-fab0-4c96-9830-08d59978b93a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739881382169628?=
X-GMAIL-MSGID: =?utf-8?q?1596739881382169628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An ADC is often used to measure other quantities indirectly. These
bindings describe two cases, a current through a sense resistor, and
a "big" voltage measured with the help of a voltage divider.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-circuit.txt     | 45 ++++++++++++++++++++++
 .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 3 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
new file mode 100644
index 000000000000..0bc7d89387c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
@@ -0,0 +1,45 @@
+Current Sense Curcuit
+=====================
+
+When an io-channel measures the voltage over a current sense resistor,
+the interesting mesaurement is often the current through the resistor,
+not the voltage over it. This binding describes such a current sense
+curcuit.
+
+Required properties:
+- compatible : "current-sense-circuit"
+- io-channels : Channel node of a voltage io-channel.
+
+Optional properties:
+- numerator : The io-channel scale is multiplied by this value (default 1).
+- denominator : The io-channel scale is divided by this value (default 1).
+
+Example:
+The system current is measured by measuring the voltage over a
+3.3 ohms sense resistor.
+
+sysi {
+	compatible = "current-sense-circuit";
+	io-channels = <&tiadc 0>;
+
+	/* Divide the ADC voltage by 33/10 (i.e. 3.3) to get the current. */
+	numerator = <10>;
+	denominator = <33>;
+};
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
diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
new file mode 100644
index 000000000000..fd4a215d9e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -0,0 +1,45 @@
+Voltage divider
+===============
+
+When an io-channel measures the midpoint of a voltage divider, the
+interesting voltage is often the voltage over the full resistance
+of the divider. This binding describes the voltage divider in such
+a curcuit.
+
+Required properties:
+- compatible : "voltage-divider"
+- io-channels : Channel node of a voltage io-channel.
+
+Optional properties:
+- numerator : The io-channel scale is multiplied by this value (default 1).
+- denominator : The io-channel scale is divided by this value (default 1).
+
+Example:
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
+	compatible = "voltage-divider";
+	io-channels = <&maxadc 1>;
+
+	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
+	numerator = <222>; /* 200 + 22 */
+	denominator = <22>;
+};
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 36a28e979e9a..9dbe5019c6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6889,6 +6889,13 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO UNIT CONVERTER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.11.0
