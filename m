Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx496AaMsUM/CeRrkPb3i6rF9/U8NU/owR0T8nxy+N8MQD/+bLSrvAMAFGOUII8ZLyLllX+CH
ARC-Seal: i=1; a=rsa-sha256; t=1523456181; cv=none;
        d=google.com; s=arc-20160816;
        b=O9eYInPxQm9w9lgIrlY6Yk/ZJ68FiiKvhqPYl9mrgO63qE+xZVRDKAquWAs/6qAlJo
         RuwUVgMkHAYW89zuzYCoqipsDxz6R8a9LUlB7T4y+gHLVuq+vdcmwx8Do4lgA/hGeUF7
         QrL//ZIWw7FoRLFvA8Q5mswRkgj39/UEVYr89zIt1bCfrbVxSyiTLQEJ4obesp5pmTNv
         JzyzalyHXvjmwCXf3vBOkB7xPD9R+zhwwiQyDgAanWl9Efl3ytCP4en9cUbkslXsNSZ7
         q5iHmoW7wGfT3Qu3CPMwxe17gG46IKlkGoFEaiPbk41AbeTIt7GvSeGsYEatgg3ESeXh
         A0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=a7kNCR1mm3t5gEL/E68U2twIVnHSo7XnCzroXrs09bo=;
        b=SnNxD02MKiFau2qMrG80c/gyWlmIJFKNYQyeha9JEV7wQWPM1u8zcQmONx7nSqdkW9
         uAnKD6qG4GXxW6zI4fWxpEatyXQhDmRlYJhqZGffaf9ethUNX+e0F1gz2j1UIi517Jln
         glSVMGKtY2eKTysXDp4REnbGeHN8yZkOhCBvaE1ul3QOmACeQPPaVXu61w7mE85XTuzn
         bB1VS6qCCZ2FzddBFJw7kA7qQgF15ToYKVN7JOL57tpgSSlcRKKgS5k2jeUCKGyI8n9d
         LMEjh2aMptZyL5mPqNXy8bBFx/tPu9VG1XANT1bDKXDnWfyhaOtne5KwYgS+nlhHlex+
         T4DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=UUbKGlgw;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.3.95 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=UUbKGlgw;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.3.95 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH 1/2] dt-bindings: iio: afe: add binding for adi,lt6106
Date: Wed, 11 Apr 2018 16:15:54 +0200
Message-Id: <20180411141555.15044-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:/M6OojrXw5aVfzmrKEthzqp4z/PuZ9QjoSKlUeP6ycuR21DVv+nQkBUxNN3pfjE2ZWYnY+Mc+CrZ0BF4oK+s/EZF87jIbcrow3YwpmjPUPwAiJsSCPCCvLiBh3sdrchQ6eOIsbqUMego7a68M4+A3csK++jEPPeHT6dbxYeuz/0IifNMxYId8JN92WyMj/bsEFEPLoX8QrSw3iZ0TFi0Cw0kr/T0ujlSGSPt005roH6QAQtB9jEYfnKqwBRizMaB;25:EyuuJ+j6ASqosJoP8B06BHFLzCDEmjSkDiyl+PYkKQO4uobvLeh0HXCi8nNcxuBdFbWuwexircipnJYrlRI7cpnxyuy5kC+1xi2tp2L9oVdWU72lboeMB6tLR76P4QcZ/jgbl5p6Y3akIAcqKHrRejS/djzagFE9a8TS73bEOGMhzonN/+dUAmRbUz0wSpZzrKNsmNcns2PUVmqc8m8t2gWiyT1JpUstG6TEWxppCVwwNzu/xi7PPrH3hXVsyheuCqR/hPakMTS4C7coqTYZvmEsM7E1sJLLQKINaZRoLJQUiaV3gf+mX2z++OAgUKS3b4hTCiECFWroH8pDojiLzA==;31:6NfjG11RtdHL7cG+sqkfV7XP/IcYXkGXauqMGy0+FmEkiG30y5D5oH8FST3A/WIZ78funpaVasysHP9A3/MNieCGw7NFC4OnfLuSofZ8XAf8/ZNqS989aP7DJKPDqD1DInP8Njw2F1ogQw/zvMRB3bIjFsWl+Ni83l2tHvDo6xvxiaqwl/J7jwBRXM7yr9D7hW6spNV/RhGqkZ6xdsBp/EMChTr9cTEIb/g+vV+OLrA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2783E577FB38E37BDEFAB311BCBD0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:+L7nO3L9TXGTt7FGp8uRK4Dz9+JkruteQ7Yx6PzNGmZ/TeSk0Eb8EKUGKE7thc80AL3XshmbgoIzuicBLs5fBkt9cgrkvOcFZBeHAEBFDz9mbGD2ir4EI7iFWS4LzuEfrLa5xE9OhZ19YGtgS5D2iYLJXH9FS7Y40rejZXq2djpMPIiTjyb0oB7dgs4PxHiXw2b8f34QmTvB76K6ok9PiGUn5QXpZHce8YDzCQo2ALzHscWQbyNfrG3XMGYo5GaHf5S4VxYB+TF/xE6Z1UyEv5VRWjRv4pehzbfhtn2k4oyW7tEgGLbMkWiHZEsOjmh8YlWVtUFzwN9Ta0cZnZa7moZSVN8XYAJKZd2WmzHbc0ibXHXE7Dt7LYPScKhaRkOz
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(376002)(39830400003)(366004)(189003)(199004)(8666007)(6916009)(52116002)(54906003)(6666003)(7736002)(16586007)(6512007)(81166006)(6306002)(68736007)(81156014)(105586002)(1076002)(478600001)(39060400002)(66066001)(8676002)(47776003)(305945005)(86362001)(50226002)(486006)(53936002)(76176011)(316002)(446003)(51416003)(8936002)(26005)(7416002)(11346002)(2616005)(6116002)(186003)(3846002)(97736004)(16526019)(48376002)(25786009)(2351001)(956004)(476003)(4326008)(50466002)(2361001)(6506007)(36756003)(2906002)(106356001)(74482002)(386003)(6486002)(5660300001)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:InQc3dW74N3s8P/iyDiqZRUqdz1EdkGfzJ2sbBV?=
 =?us-ascii?Q?K8o8BDM9bVQO6+em2gfiVYRfwJsv3ubbqRqE67CPmjLSefV7FJypvg+hEvB5?=
 =?us-ascii?Q?faqMgTkObfBnfu+F18sRRvk5bBzbhmZO95f0Eqh21VzDvicTUq4MQf2iA/VU?=
 =?us-ascii?Q?jSa91PKyF715YYCmXZ2TWR+p7KrvJN0LUmMUC4NXJ5ZgJLF5kxkOqO1WbgJC?=
 =?us-ascii?Q?DWqJjsGz6ki53kZ+67gJh2YJdkM/tBNNSYvrdD55K2eqPSO9y3oMk9fI0X9p?=
 =?us-ascii?Q?UnBy/lIIThX6rChXFAQJR4+aabwAAVkHQOPp9WJ6aTxEiHeErBre9kGoWCYq?=
 =?us-ascii?Q?Cm35yiXFXJWOCsY5iBKCfkT0/wzYSSiSsaJFx6zP/RELH6DfIs6aJwqcQfHB?=
 =?us-ascii?Q?/DW6GWYTwkGNLS2HFpphYtEGsfk/qBYtUTVU1HapM8YUq1lH2A2RSLAQLP15?=
 =?us-ascii?Q?fLcdH1ry00O9gitwpZGtB+UFz6hhpmd0P/jO3mGH2uPHG+wGia382tlyjQ64?=
 =?us-ascii?Q?0Xfc+gHRHGJtjFkvlHAnuHw9xNxPiV5Ys/vIiPMhMR9MIYkx+HwAYMOYnCvS?=
 =?us-ascii?Q?ZnbVueFb7XAtSkqg0Lo7wMZolo9Hvl1M5/FLeUkpUt3f7Ll1t3UlRymj+UXb?=
 =?us-ascii?Q?+ImdDcN4BzcfDsSFukHylOMqDUOR4i94H1kULfdAsJN4Juv6DGU0THqaoXji?=
 =?us-ascii?Q?d64XZNZ4PVTjzqusm+mbWBSIXnlQ1up3tQhwAfmDvL2/cGFJ5cL/PcYonGvt?=
 =?us-ascii?Q?TiOfKQzkpedqXArkp14Tj1ibfLdjVLsuRVFtX+tfHbMnm1K/j4H/2l0dkS+N?=
 =?us-ascii?Q?lCAXTyEzCriF4pP8VSAl9/qdjP27sARN67438ExA2LeJBBWMO5hVeXQxaOEx?=
 =?us-ascii?Q?bVusknASmsZJT9Io4kl49OFfF8dWQyIOQWO+jce+Kwh3kizQvzZXuC1i8Zdt?=
 =?us-ascii?Q?c8Z+0NKBltRhO2quMoPxmomFypR3hmh3iiCuMyu8eJ508lq16bxqK9Rxoj0q?=
 =?us-ascii?Q?aTGAD8LRIU090MWyu6OEh0CO8Bjpfr2sLhXr58Mwe+5ymwmUSFNRvWe7zTEw?=
 =?us-ascii?Q?H3qy6Y/VKX/VS+i/97fCsenmoSp7Y1IPIfOMSrRtzEkDY9afkxNkuJM3yfB6?=
 =?us-ascii?Q?STnD51EhSbSQb9ZSM+NGY4iGwnVaVCqK7P2MWvu+GyTLL0jGn4vrz93PcZgf?=
 =?us-ascii?Q?2YejA4J+orzYDzTrsk6UwPRpFd5xbq8EagIzcEe8Ly4y9Oabm2L1DYWM81bt?=
 =?us-ascii?Q?oLl4EBvRJf4fECrdMystWZnNG1K1PXfmB1YCSXS+26+VaNHpKlxVrAQhwK8o?=
 =?us-ascii?Q?xW5k1m2YhTIw8pFSOTGr+3YlI50AhJ85IFUDBl3XQIzrIHREHBBge5qrkTMJ?=
 =?us-ascii?Q?8oxKx8BX3/KcYBvaJcNNli3PNbhDU67B+jTjub6KX2fct4yPM?=
X-Microsoft-Antispam-Message-Info: LRxHrW3qRofGK6mUaW50eqeOVrvaXQib3x5p0d8EGDZJ9elS6GeXoNWidj0p3Nd5rAKtT0GNCQztrG44K/IxxLHAUg5a5JesNsxazyyQjUNBoj+izXCfshpAz/6l+Ibx+dEUVg4gdU2Tv2bTEivGUQqB4PF3TtYW7Yk+HYeMMV9GQQJGQV05XO2nd1IDYY7Z
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:mjhNWqeJ2mws79aFZAugcqCxa8LW7Flk4HzFKx8PqU+J8IbguW4+d8xjOnyG/Aa/8QZ37uBl1HfA526fzlaYtMSwBVjALivynwmD0G071Z/1bz4l+6t7lLa+mqKINkSQ0BObkFWR1hprnbj4KXaKf4O1qQVCAHwMGeuNm/SmM/0h2xUeYINUG74Hot+1dMUbUmfaqAiGC6MhTwJ5PZVbsIndwxnpRwEsDUC/9rO+S4+CGD61PGQ7QwVyAgobqXSPVGuAE/jk98iEUyG2CCB5aRHQhvj8y6TaYo7B1HwfczHPfffnOZrdvYUUuo6Ai/zpiLDuqZMkzu6f7/tvMUaPfoWdinT11kYGVfE1jIVWF4UYXNKBgJZOFllAsj6r66bTLLK5/zBqczcesKB24ozlP+c9++hpXDdKiK1vximOIQqb6ZomuUrIBrGGgKOosc65HlkwoGOQRxVn6QH3baKZ0g==;5:dOFFn3gGBlTSnHE9uW9FZrOw+PMsJnhFYq3lwAzvjLUhcRPYVEULmYUdt3f5ssRo3CPZg98U9ghS6mZB5dRNyUqOGJ5aSnqPK9BVqI/WXlh8v+auTSfNBy90bWkugEpT0hqcSqa9btIyZ/o9NVuYllLTkfBjIkcmXrxMqtLf78o=;24:TGRp28lLU2uiCRmAO+eISc/AB7/oz7Fa+EKqIkquFNXY+7DEUtQvuv4/q5ONZ0s4TBUqqI0V1nWCFUn1epUaMa2xMHg01x44x5nkZ/1m+MU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:k1yUeZ+jlZhBEkFAYmr9kGnccunfMCk2qkrtuXtDwzSGUkJdFHsDOv4GzLHewh7/fZl8+p9I4w77/kSg95BjMa1ProjuEKCA+B0x2ZzLYH9Fm9zBq5QYQHBiirJalBe0KdcKUt1CzGxqZuy0JEtWl9y3eENS7KQ3hyybmUnNprod081YmHTR/gEakGpqcYTkg6ogfPYbA7bhTaW/0xDA+lEEEtrsQpSK98xrsxH3vn2xNpXxZzbT2MFt4G6yTVAV
X-MS-Office365-Filtering-Correlation-Id: 655fb024-3231-43ab-7a3f-08d59fb6caee
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:16:16.7783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655fb024-3231-43ab-7a3f-08d59fb6caee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459588817312399?=
X-GMAIL-MSGID: =?utf-8?q?1597459588817312399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a current sense amplifier from Analog Devices.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
new file mode 100644
index 000000000000..98b6d93596f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
@@ -0,0 +1,50 @@
+LT6106 36V High Side Current Sence Amplifier
+============================================
+
+This binding assumes the typical application of the current sense amplifier
+as described in the LT6106 datasheet.
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/6106fb.pdf
+
+                                             .------.
+    Vin --------------------+--------------+-|Rsense|-+-----.
+                            |              | '------' |     |
+                            |              |          |   .---.
+                 .--------------------.  .---.        |   | L |
+                 |          V+        |  |Rin|        |   | O |
+                 |                    |  '---'        |   | A |
+                 |                    |    |          |   | D |
+                 |                -IN |----'          |   '---'
+    Vout ---+----| OUT   LT6106       |               |     |
+            |    |                +IN |---------------'    GND
+         .----.  |                    |
+         |Rout|  |                    |
+         '----'  |          V-        |
+            |    '--------------------'
+            |               |
+           GND             GND
+
+The voltage Vsense over Rsense is measured by looking at Vout. They
+are related as Vout = Vsense * Rout / Rin. The current Isense through
+Rsense is (almost) the same as that through the LOAD. Hence, the
+interesting LOAD current can be calculated as
+
+                 Vout * Rin / (Rout * Rsense)
+
+Required properties:
+- compatible : "adi,lt6106"
+- io-channels : Channel node of an io-channel measuring Vout.
+- sense-resistor-micro-ohms : The Rsense resistance in microohms.
+- input-resistor-ohms : The Rin resistance in ohms.
+- output-resistor-ohms : The Rout resistance in ohms.
+
+Example:
+
+sysi {
+	compatible = "adi,lt6106";
+	io-channels = <&tiadc 0>;
+
+	sense-resistor-micro-ohms = <20000>;
+	input-resistor-ohms = <200>;
+	output-resistor-ohms = <10000>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 21368749f3b0..76d1e03f350a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6893,6 +6893,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-unit-converter.c
-- 
2.11.0
