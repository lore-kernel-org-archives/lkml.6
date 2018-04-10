Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/GtaHY+DM0EgA01EwlSgVNQjZE44gw4hpxGl6mAgW5HJtp5+OSRKkq6/k09ej9V9sKAiX7
ARC-Seal: i=1; a=rsa-sha256; t=1523374108; cv=none;
        d=google.com; s=arc-20160816;
        b=os4iO2vu+EgTNEmDGv+7xOXa5elACoJKnsnT6+X/7yCA1Lyv1KdHBMswiihIR4CYfn
         kowOAvKBuu2WMVpMZHpfI5zyd6NcpI1H0PF0egk17xbQu5LDm6cc1GG7jBDoo2p6eXW2
         CqLfA1tTiJxc0PCoz0P/LCHQMmddlSU9XGiBj7xSeP+zxdYSKPPxV8OxqGeDIGYSRjiT
         LOwIdIvbwnUpVyRGux9b5342/BwpUg6EiCaFg9C86QnrRzcC0GCBKO6qjLZvUyrPBst5
         GsZ8prT4FWTv3KfRiTNiDc7OT8Q2ZNiHKSWe2tws0NQyKIBAOXgi5e6mv0N3GmzcmEWi
         9sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=yAnugvRNYJ0E9ZFmkrbfybHUOQ3pcUOOa/CQs37wA6o=;
        b=Hy5YtyH5rVi2/aGRfLiWzGOZzfMXU3T0n4+NFGH5aOjJMmfVA2mgcwZ4gsKrZKdbL9
         FnFMD43gD+PPQpiADqUq5LBQSvEaSXnzhpQEXar86vQ77Zjm22lDWSlZUsBw6xZ5Z5MK
         KM3rbR5VyFrjejaJ6xn0eVn+vzitvxC5e7wAPAS2pl/sTkEit3JmyYh7Z9SPS9QXe9uG
         I5202tXINW7XfIG4BfrtNSugjRoTh4L2y6rjSZlKSyUxX/8iXgwH5RRvu64GvmDRZRmJ
         AJPWzY1lE5EYacxzIEH+3BH72swBmL80blBDhr9YtkTdu95UM62YZUt6nlj/TNTR/8Um
         BXCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Geyj0O1b;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.94 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Geyj0O1b;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.94 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt and voltage-divider
Date: Tue, 10 Apr 2018 17:28:01 +0200
Message-Id: <20180410152802.30958-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180410152802.30958-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893bc69e-acf3-47f9-3789-08d59ef7b34f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:M3YEkcrteGleH0K40tGZYKWM5TuTC8mMKPEdbUdZ3zjlGd8iRf6HoA1MMHjgK11gd3tLMGnYKdQR4znvP+guIIIL64lafYoD6nzyMiK7TY3uVQNAbQRoN+xJ2A40WaYs5vv90ShgEwMOw/AnFP63gJ9gM4JVa36zQOlRWtlXOAlig1UlmFiTZUuDnrNGk35+g4fpcM7NGLKJl8tu/D4ZwUfIoqy7hq4K6warDH8hXFG/4ur2xKXTF8dlgGUWIOuF;25:0lDEzlc/Ql0xQHYSMc6cT24Ukn9lSuUc8W2HzukZDWPzXkP9AkuEJGNy3w83+j2PXdLEZHEFE+5g9MhGw2mmJdY67wfeYZT/oPeZ7rl5DSJ4xM20SxibgRkvX7fF+2UlBufo8iLYIJOS41JvY4weL07zf7vI+8sZ+dcKX24lqu4aLFVfy4etXyPCKKYiK3em/FBRkGAKhDifLFh+K8+Xs1E4H9Fg7azK0T9K7hzDlnSf0v89sXpIc3mpEPP+mdZu1bb7Il8q0S+mBgfCkjwMPWOTNcWHlWTcfsVZxFPkA4PrL3nCYWkJejULwDnIstQN+wNP+/joCoDpeTD0rteMFQ==;31:iXCCqZ2YppznG/7DlVgljYuE3MEKGSjPiUosXrTbJ9NO+Uy3ZsdRJkPhynXEz1K5M+utAkBUr9aUbjr16Ac9Jf4P9H2FAYFbsrkTvoo9djA/sIIZ8SziKDb0LR2VwiJo+UuVo5FwF1uGYn3dJhGGQKlKlzpW010lxnV3shqKIu03WDUi2Qo5A1zk0fLfBopydeM0hmtNIbZdJ5J+jy8ek4zOE/jASInnX/tgfacBRSo=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784BE407ABFC3FCF1B04856BCBE0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:eXKp/k2U97AwfLZ4BFMczLHh7W5xiF+pfApD46o/XMC007h2ffp50BPB2Unk+50tKL0YnW6MdTcgCaTlM5hKSegRd09Y/IgL8/bGtOwuQTh5dZNF2e/snnXAaKVdzSNk+yPeIZtAd7zsO+IhYhDerKdUXeRVIZ7ensk/uEE1l+NY3U0VKrQltE1is33SNZboXD+BeI0FmUsX1x29pbXZ9kKsbVLDdolDOkhI0oxZSPManp6qivDCkT4SQ93p4kZe6l8JyphuoZ/1xSgR4/baYV1Tx1EogxJGs4OVdgEi2FJnJ8HI/aIuPOEQP9F004l9dH+Bxw5Ch/MdEoojPqX/Whtg6+j1K523ae+czXwQjTg=
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39380400002)(396003)(376002)(346002)(39830400003)(189003)(199004)(50466002)(8676002)(81156014)(2351001)(16526019)(186003)(81166006)(6116002)(446003)(3846002)(1076002)(16586007)(76176011)(47776003)(51416003)(52116002)(6506007)(386003)(25786009)(2361001)(48376002)(486006)(956004)(11346002)(97736004)(2616005)(74482002)(26005)(86362001)(476003)(6666003)(2906002)(6916009)(8936002)(106356001)(105586002)(50226002)(6486002)(7736002)(6512007)(305945005)(8666007)(54906003)(36756003)(53936002)(478600001)(68736007)(39060400002)(316002)(66066001)(7416002)(4326008)(5660300001)(15866825006)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:D3HymADjMY9QDsMHzNQg5zV4eAQfbBFFB2nbjXb?=
 =?us-ascii?Q?0/UC6XdKrxpQmQCOEk+TyK+bcG+mYmooH3HZKH5uAabqVINWjn5Bo7+pxgZR?=
 =?us-ascii?Q?MKIMNox5miWK46vFYIkiys4airjFcaxXBznSzAwk9QWuVGBYHEaDp7apDpFn?=
 =?us-ascii?Q?+7lDCEwSDBJmd5JE0A7ipthQGKzajwNkzu0Cu8S6y+OZLJ17+WFAUyt/cEvM?=
 =?us-ascii?Q?5TZgopMeb1x1BirWgnkqwUhTdITxrXmXxF5bRHux6eC0gUFpIKOT0QL9ita2?=
 =?us-ascii?Q?1NLQ3a1Fn5IlXvwZ7x14kAV2XoGW024gE4th+ZOBVNqr2Gjd/ddVk4844dUY?=
 =?us-ascii?Q?bSln5RemloIIZ/KGPTajafu9ssORL9BEDtarNiyFT3mDht5Fg3nPvyJ+RRIY?=
 =?us-ascii?Q?CBMRXcyuj21TQPXv6ByrETq42CchdHXCSBxdTy6fsA2ndjKPp+pfzuILk+16?=
 =?us-ascii?Q?YTtpLiP5/m+2YtfCDXuompiH5HOeRthhBVQY/8MZg6HgiVPAuYAHf3C5pGSE?=
 =?us-ascii?Q?9aOGqkYLoqQkASEI1y1ryszT3McXDkUW5BYc+4d2t69lWASPo7K2n6HorFA+?=
 =?us-ascii?Q?ytdEQbgPdHoi0iVrWOb2YPqaNKt5L7vVTl2GthcSOgQ/EjxyjBG9rXIL9czS?=
 =?us-ascii?Q?irFJ4+aRn+LxeNtyHRzPi+5diKbHxt/wKG1nQhni9lxrteGzB/jItzA3AmFl?=
 =?us-ascii?Q?uH3ZyaWWYu8jNz3PQwb+sBiZKETC/xK8/A5t5/WLPRcEhW87qSWW65zK5q3b?=
 =?us-ascii?Q?naFN+xZ8b2Iw7cES8Q+3Y/+FcRPlILPXAspgAN4Kv1a1jYmCerZ8Gh+kiZqZ?=
 =?us-ascii?Q?K3DRS+MFAOyKBoJpjiVIhhJ7OSAwJHisiYJVTnazs3w9m0CMIBgEb86CeXVy?=
 =?us-ascii?Q?06B4+9DqEosu7oV+IkTnU/eC2XOJRFZfL1A03PPPXX1qgOZPC/hvAIUEl+ti?=
 =?us-ascii?Q?ePHrzwGUdH2mHAzxGKEq09z4dJGszFy8w904wM8idNgBJaflIGvSKS3f/WJO?=
 =?us-ascii?Q?9IVqaf6BxZfP0eokgJ6yeu9K75LlxY5Y5URgGq9PCu8h2UJZ51yDvANzDDM+?=
 =?us-ascii?Q?kUpO+OC7GCumR4zGF49G6OaepFD8ukCJLWOKffOcIWuwm0mcFK/QE/jfh8rG?=
 =?us-ascii?Q?WkAEL5nT5jC6PMVHTjE46K2AzoQIWmKgcLKDS8cTAz4NlOUJ5QV3YZ0LvT/T?=
 =?us-ascii?Q?UdqHxp5skIt2RqueqT3WVaqjh4racaq1+LoWxQlh8NMHehwH7MaIg2Mhv6+V?=
 =?us-ascii?Q?lsrZG77F1yejLypS9gBc66zB4ZBllCS4ySQZcyyWHnMW5nap84TreBSYQ1t2?=
 =?us-ascii?Q?gl2GnZuoQv+8Oz/d0U6ds+yMlE3r2v9roY7RDSMaiK8uL77hq6mhTJu6ZP62?=
 =?us-ascii?Q?ibdYRnJ622K8Agm45u7RqXYJp1VgZK8SGz2IcwVbYxL0er7FAI1rDutM47Ot?=
 =?us-ascii?Q?7+Tf34pToQHhr5YSSO7EGJ5gCSQxbw9Rj4uiKux/dVUpVAssUjm/S/PwBF1u?=
 =?us-ascii?Q?Hm066sZ1PIh4cIg=3D=3D?=
X-Microsoft-Antispam-Message-Info: eNfMTlhuxVcI0PkJulMioTLqMgKDM5aQ1c2H7hcnGPuCsEIW+ytf695dJzit18HAQK6oNGdu00WO1ccaEJKybD90VJ1SPVeMWTXCHzZd8a+NBf3AuLH4aBWNKjMSmh0HAdv6kZ/DbMD+VAci6xHWzhNPVAj9iP61dbCBdTVy3Rpr5996KsRXq1ORDZ5TbfCG
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:QpzDYxIMxs78lu2ObIMz36GKqUAv3scPRNhvEmADr5K/5jDECfok2XgPo9UuzaA9W0Vkqyyw0CP6+KJtANdxcGRNdxPbj9z5tkLB8WfrwQLkKdLmbxgEQ+LqswkPICco0FIz2xwPFAV/KAHrJq+fi14S5hXCkf3tTw9KKaMM3nZYeAlMhBc40Eibw/8MQHzoCr0KC0zkYyzGSNEX+Jmd+MWmiU0n05mEjwlWV6wzH9L+woPbv9oa2fq+QMuOlTJavtZkkWGJfjTv1mMZH9iXj3UcaYv6kkqYGk9DSLANVD8BDeqi2FP8D7nPMdGWLX9+yqSmxZaMgV5r19BM9wtustMokgjK5UIIPGbz61Gr3iDcH7nJp9KgnoK5oMeopqWXzutPvqaEX5PLjh86P8dsdAGLhQ21c42uxHGn+rRCnXZl2D1zBfDSDR9SVDHCoDMQ1ncMkYB6DdwmExbMkbo+iw==;5:yT5ccxbTseDFjzr28WQMG0xXwXpoiLzXhULgVIzyOmp4+13hHvqREcFIGq6Os/76opQBBstZ9U46p9OkUvmpAvLsMMMl0K8ZOxdPvfroUCvQEBjuLZrHcJfIMzgS5ImqpcF8H59QQbBaFIzcp9L3zdcwfrohgN5uPsFWVtoYej4=;24:0TBkUyMk8Piks89ZQwAKbHZ2PQPlpDeM4A6PfvS1jAc0/bhnntLLMvzf+GvI2FppGmjrDw1k9bgsHBpe7idfL4yZXFNLSgHfVUzLpa53LUU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:YPvR6nGDfAu0dZt0reuqIuFfiyqiXwTGRRqpeRJy26cIdwCgFjPB6ZeHTEHt1uF+DWdnc4g1atZ1TTnHKrDn6qvRFBcbEFoSbsR0+8J7IcnQTbR+sy8s20KF+6Zlg+l72xlF2AybkoxJ/0G5FNa34yOJvXw1fLB69UGh3+U1gQ3VsqebQBbL7r71h5BU1i4tuhYplklkapJmbWv3ifRPuKLlnd4bhSKs+ny1BEAp/8Wqz4zPTNUcA0ncoKfHG+s4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:28:23.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893bc69e-acf3-47f9-3789-08d59ef7b34f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373529205381513?=
X-GMAIL-MSGID: =?utf-8?q?1597373529205381513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An ADC is often used to measure other quantities indirectly. These
bindings describe two cases, a current through a shunt resistor, and
a "big" voltage measured with the help of a voltage divider.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-shunt.txt       | 41 ++++++++++++++++++++
 .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
new file mode 100644
index 000000000000..4d842aa85040
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
@@ -0,0 +1,41 @@
+Current Sense Shunt
+===================
+
+When an io-channel measures the voltage over a current sense shunt,
+the interesting mesaurement is almost always the current through the
+shunt, not the voltage over it. This binding describes such a current
+sense circuit.
+
+Required properties:
+- compatible : "current-sense-shunt"
+- io-channels : Channel node of a voltage io-channel.
+- shunt-resistor-micro-ohms : The shunt resistance in microohms.
+
+Example:
+The system current is measured by measuring the voltage over a
+3.3 ohms shunt resistor.
+
+sysi {
+	compatible = "current-sense-shunt";
+	io-channels = <&tiadc 0>;
+
+	/* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
+	shunt-resistor-micro-ohms = <3300000>;
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
index 6e950b8b4a41..237fcdfdddc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6887,6 +6887,13 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO UNIT CONVERTER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.11.0
