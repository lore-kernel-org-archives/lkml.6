Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4978AF5JHey1jBP3ma3CCLJM5i6qQniCIBYwl3arndxIkE4J/6qi/0QpdWIU1XgYIjWWGeM
ARC-Seal: i=1; a=rsa-sha256; t=1524517716; cv=none;
        d=google.com; s=arc-20160816;
        b=GE3ITUOarYZ7POgECSkz+H4Z+/NyXUf5uHxc+EvyRbemmCXWrG0a3v71CcBeMkihuO
         LZbw3CDJiwWroymOtiy2ClVNfUyVtpTJpEGzrmGif5917HIhxjLzUh1hmtwyMY6JA8VH
         ezHDRRFVn6z1jf2laHizvKjrbn+Q0e70BhdBnJHSPJ+hIghJlj73YmGlK88r4cDGlxxB
         lx+gz7/QwTy7k4japrU2WwinvIJZ2BSbZq2OkqLm4laTZVPg/6wU19SMVw1+Un0hftAh
         x+ujTdrnqn2Z7hjQBWyEt/QJ77AyncVutXFMyw6CRqEewi6SwdILq9L8ieXvV/tbT+Yi
         qkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hze0jtfPsPLD1sihIt8RntY9ODjyr8MMQBxLhbOsBf0=;
        b=LI4WkFlFB885532mp3eyLYvy9x7XyNxQkhj9+ssiZpRQBq4gPoL/o8mVtGrumw534A
         0WezHDOWn5TjfqJEv/R/99Jeyv1G8N9s/3CeZVb8O8y+Uv8VdB7Rw/xlQJ1T5u42MiH0
         JLKjlaG9ayjhiUyU0qXVHO9tiYoL3i3reO6WwnQQNXxSUWCRYtD2gSi0f+hGbfbSJjwI
         bQdg0msVBqAOtKCJFUQCMx63BlKPYOVMPeCjHOv3uU99xQu4qNUzmgcNHNJpb3jkdr/Q
         P+0T8/BriSXHKKgAO2t9qmc9qhoUK/Fr34XS2mrjWGs1TTYHT/K1UevMoY08DH6ZrhvD
         2Itg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TGk51XT/;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.102 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TGk51XT/;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.102 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for voltage-divider
Date: Mon, 23 Apr 2018 23:08:07 +0200
Message-Id: <20180423210809.29586-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423210809.29586-1-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::18) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:h/EeDF607EaioK55SMLGgcAy77a3U6gOG/+Y0zfoez5gkZBkWv11DKtXCUdymgXdUHRShV3B0paXnoDEgfVDdppi72rie1To4yi39FiXSC1NdGbpocQDCqry+WrG7ALWBG9vI5XWHn4DAGa/BgPmkgPZpobnfz1MUGkfCxJ90E8szBkMrbPN545ZWvAEtWpMaW+Yi/YcF4tWCEeMtTmTcS04rzMQL5c9LAK9Q2lMTEi4poyqUtXpBHLZmiUxWEbY;25:NNqwBoXXSxACEcw8vupl+tFJyL3I3o/AbjVDB6JBjGV8CYqNmvBIPPRj1umd3xAJhirpHLK0NYDjMNXUYbAcH0YGukEd4SxLW9olwCFMzZxnRGgj+LABBPz2INMfFnheBNOeiw0zd3YsRIAq1Ud/IvdR2H7+E+RWvsbuPEiVi4JgEdVgJKFa+uzn/lASKYKIKizs1V+mVeU0kseV3L9QOcdQcJdaS63vIfLCLl/FpOT//2ND+3OPezDYtaDE7ih34QSG1TgUJKEIuhrEHalHH4XiiUAJASguQnSk2We5upO9TygVBb1C9PwQ7VAlDJ//T+RIdhPujkXlid5OwRoTVw==;31:rD4f88h8lNZ5tYroC66CmIqNDcdWAbK6pLUxJIshqlsAOcKSLfZsPFaafPPistZiiUSlCLK/o3XVix2qxvW8kX9cns/aaIMwm/u1R6NIEr7I4z+IRGglGjuboSqPdcKX0Pi4BLCKfZNr68+vIgGClY/uRFaUeh2j7eDjdTWay37g981Hs1Ye0f5dWuGUcuf+Rw9StPF8jN6+Xq5Hpy3ndxPgDxGj2Sx7+HswonPD/vY=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779EAFAEEAEE501E80654EFBC890@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:VvOwbDutrHUKEVXfbK4TQ+mMkuA18yAlvdK22/aTUNCxyTBGgZyHehUxWXDjmE5lrkT7D//6VFsrSpUCTr+uwLNGVKxZjXax1AJGjDAcsj08Our41j3l1uMUayjjPOvNKGdAkmTW7K3ovtbkyNgwKGTMOl6/eoJjlrLmfiBuJOLowPBxMGLFP4my6kFhI/09aeOsgmUOsgz1kjZbaBG0hlaji482Tuc631TvLAFlrvMevqm8o4QDx5WqIJQf7uhZw/T0VkAe7HG+4QgpFVY+aNBpNTp4daX07ZzW237dtYX98r3LrHU2QE/C4IppciesOgp+nRo0zjCtZJXima0XlrpFLiL6nUVeCkHBtP/ViZw=
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(39380400002)(346002)(7736002)(5660300001)(8676002)(81166006)(305945005)(53936002)(25786009)(4326008)(8666007)(6512007)(39060400002)(11346002)(956004)(51416003)(446003)(2616005)(386003)(52116002)(54906003)(6506007)(8936002)(50226002)(76176011)(86362001)(476003)(316002)(36756003)(16586007)(26005)(2906002)(1076002)(6116002)(16526019)(3846002)(186003)(478600001)(7416002)(48376002)(6666003)(6916009)(66066001)(6486002)(47776003)(2361001)(2351001)(74482002)(50466002)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:QwxXn6IZ+DUmmYTkg6c8kaOLnofIpkTaRjjiqan?=
 =?us-ascii?Q?r0gv39i46FKzMst5xrz2fj+FGjEBjYbsqgXofjVnDpQJsWd6EkFuGJiC62wm?=
 =?us-ascii?Q?N9PNnqXRGzgSJJUYc78W31U9JC7TOzpzdxj4cuIGlkNJWUhoHmTht+/zLuC5?=
 =?us-ascii?Q?R/vwNcZf8PjpdIMCxDo649EB/1FLfnE5uQWY9wAxgI2PpOu5S6S5HCYs8nFk?=
 =?us-ascii?Q?ZRHy0qlnN+l4bHfbsrB3r5JK7u209+mRQBXPj4ePdAVCYfv9qoxh6rjk062o?=
 =?us-ascii?Q?dVXtoCDJMw2BjtqON1p0k3dlCSlQEzxGqwOecyYePZbrG9S/Rd8LtcvwmMYT?=
 =?us-ascii?Q?2s2AkkFC99SFU9V6B5coBPSmy25Oy47wGB7AabOzEgv4tBmW8fnvov4ADc3W?=
 =?us-ascii?Q?G1pux+hA/rKM3cdl7Ajtuvfi0gPNC9NoMgw563xMpzPsHvhx/QbG04i8WKEJ?=
 =?us-ascii?Q?cILo+2PkKS7+/tO+73JJDTLtUhujEoGcffvp87JnbQO+LrBTfVfw8RanBtSL?=
 =?us-ascii?Q?2uSMjIoOpp43lj02ld02MOz1tSl6NlR3mUZ16C4sYzPJA33LSWvAv3JMWwaH?=
 =?us-ascii?Q?KiTdcR4Gdym5VoFgTBhnHuSgj88AITsZD07dqLw/WNO0x8iOKs4yxEXruh94?=
 =?us-ascii?Q?41+tAG/FFq/hDg/R6pLw+GF9+Hj4e7bfPfY02TnSzUMOYiIjmnOkaqHkGSMh?=
 =?us-ascii?Q?alm8aj0roxL3YK+IW2LoqsgBwmMvkkdegDc7LDGLz/cM1PRAAcizYP2mbUrw?=
 =?us-ascii?Q?mKvrsFvUnQxjQU2Vc+fMnEvzjJZglOd6KItYgYYCKE3xAkh9Z0QDpHnIuThB?=
 =?us-ascii?Q?+Ig4sK7HCwSEJAvIfuEFGQY4Ikm4CYvsUTOEtTHXi84J8jMPryFGmas4a5SM?=
 =?us-ascii?Q?CoSqEtCzcEZNeoS+WwD7gZf7lW/q/JqShIjZcxGdfVV5qAcJwVQFBKEaI9Dm?=
 =?us-ascii?Q?MI9sjkFspJ34plIs4cwTRtNQingOLfsRooiVyHWuuXeJ98jhOnejLiOQQTZQ?=
 =?us-ascii?Q?5e+v1jFhPZuuXA2tHdFPwOaDndpJins1cIo8GGdkUeJRnPo+q+AioVwQjDeS?=
 =?us-ascii?Q?4xTOcjhyq80YG0OYxVqBin1MphZmmM6MvWZiKQBPMiMQACVRlEgs+/Z6OO8e?=
 =?us-ascii?Q?sIp2LedFTkj221iF/S6PZicqUg2UfYW07R27DqJNDcM9rnv0gx0KQBCh/pny?=
 =?us-ascii?Q?RmFGicBkgIGa+DXO4mZN9gnM2wYHATIH7rM7gFkWEQJMSqnM9PF5Q9ks7qA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: QbMT4AP9RHB38cOc53C6iTeORGUPDxPhlnFhRucBtxJ4BCXuPFcsnsP/yTD4iP8p8WYdiID4dwpGCQqnGLtY9CqYpflqOt1ZrdWybuk13G7H479Xu4cqE/HDANxDVbB2z6lHtkf24W+KLPjKjU+qaWLffiuLogV9vM/4RSp2M/CpFXMe46M4C/gQl0J3FBr6
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:UUfJeAkz8oj3IhyV/KtvBf1/0y5RYC+j7H+xn61V/0yE8sxeMO2JDLm6OSV+8Uv9C6BUcjUZTp/KQV0hrVErCpra0pepWgHXIje13hXgWNyIzqKE50vBl/EQVK3XDqC6raoXAu7Mc/oNhM1aCxUo7tIkKl6k27pakGAPY+QlSqbzn5B+7XkFfBOJIeLNLvrwS3eNizRY5xh9AYTzYag5ERO8nZLYsJyM0dEnEzHFqxRmQXf5uTgPJ6ie3Cyl/99B+saP3HK+fXrILJOJ+mqe8+Ct5OCoIrv1pJ4Y/GhrMhx3LYgizG/cPHjtipA5RfaYGEdRanaz3VwkpzEaoZwGfIRlmEpOi47uxPncDfe4gAfA3hrcjFzII60tJXiM2x7C+w864KVuDs+XPiFCInjn2wRpsLzBDuogiZ7HskE/vdeLiwHZKc0e1F7ems7iD166A5wsCzYtDF8TfYg30TWJlg==;5:G082ouUqWMJNValX9TSQc84+VI88REoMOoLLZkJC1yPPUDg06HMQm5mS7sc+UpXV13v48sMoIJzk6dmiXrZ/pzm+Su6FsZ3zAGgAlm6m1YU7Bi23sXz0Di1wHMERbnTLyyG3HwFfx99XEzNsWG6PQhsBqN0mkWBKDc6DF7j6NfE=;24:s0PiL1k79MSvJWhbR4wv/VOxUfoKhfu3choWbwSWjdDq3NpNxwSglwVA6C8MbphPNKuMI7Sm75u5t2/ZMOv4VCE8k0d8jAJstMF9irWoZmo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:ULt0/PuoxTubJtKHEUf09lWcnt/msc5/A+Oentrrpo7i0b+hlIlggMtVR5UIgWJjKhAtzvS3rhfyOSmHSBLCED2tuS96GL/tsv21MR1VvqvdV+XSKb6BO3hV3KW1yQ1rH/gk6QhcRGIUlkyfvL93hYo8Q2jhcYWs+OAUHWZqSvWopA/4P3kxDl3Xw6CtGCs8ShpJSrOXedZ/JvswaiETCu1XCSua/D1KsJH5hFAE8PCuUgqT3NjK3B0YknRuHmMW
X-MS-Office365-Filtering-Correlation-Id: d9d74514-826c-4c34-2e65-08d5a95e5e94
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 21:08:30.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d74514-826c-4c34-2e65-08d5a95e5e94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572688738180066?=
X-GMAIL-MSGID: =?utf-8?q?1598572688738180066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, a "big" voltage measured with the help
of a voltage divider.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
new file mode 100644
index 000000000000..afb52ce77c27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -0,0 +1,53 @@
+Voltage divider
+===============
+
+When an io-channel measures the midpoint of a voltage divider, the
+interesting voltage is often the voltage over the full resistance
+of the divider. This binding describes the voltage divider in such
+a curcuit.
+
+    Vin ----.
+            |
+         .-----.
+         |  R  |
+         '-----'
+            |
+            +---- Vout
+            |
+         .-----.
+         | Rout|
+         '-----'
+            |
+           GND
+
+Required properties:
+- compatible : "voltage-divider"
+- io-channels : Channel node of a voltage io-channel measuring Vout.
+- output-ohms : Resistance Rout over which the output voltage is measured.
+	        See full-ohms.
+- full-ohms : Resistance R + Rout for the full divider. The io-channel
+	      is scaled by the Rout / (R + Rout) quotient.
+
+Example:
+The system voltage is circa 12V, but divided down with a 22/222
+voltage divider (R = 200 Ohms, Rout = 22 Ohms) and fed to an ADC.
+
+sysv {
+	compatible = "voltage-divider";
+	io-channels = <&maxadc 1>;
+
+	/* Scale the system voltage by 22/222 to fit the ADC range. */
+	output-ohms = <22>;
+	full-ohms = <222>; /* 200 + 22 */
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
index 0f7bec878919..4d534c9321de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6894,6 +6894,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
-- 
2.11.0
