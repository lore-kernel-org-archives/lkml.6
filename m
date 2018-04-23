Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+jT2T8yXRFJ9z6HS+Z6BJ6T9GwH/OiZ2B7Ef4P9R/LBBAaVyIqxD2WRFoR1A/S1ETKLIsT
ARC-Seal: i=1; a=rsa-sha256; t=1524517722; cv=none;
        d=google.com; s=arc-20160816;
        b=vYw6lY6AGvdhw8ViuZmstTauTv6JIANnrdlIPpEjqb43VTorcjYH8FscdNfqp5bWNi
         35ArxmoEZgWSuWcOM9hpPft83/D+EiAW34JLHCw2V1SVlX28lAe7frS4UrI6ytRfB/yQ
         bFXFZNf2UvkaoEzPyvwf/O35q2/D4PPU45tuxSSRXaH9zwgycSocWPoGTwEWaJt/M5UU
         qhcpdY5GYYxy8cXXHJIWFcQJa6Goi4syn1Dsg7MQu2XEtCS9L5fuqiV+AimKO9UxAUFP
         ShVoSN8iJn/Aiv/1kpRU9ezdvPWcEGWSFLRkOvgscz7dFu0jlxvfhfB1ZCBSb+PQcAmS
         CBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Vkw2BlqmPx1FeGECzbNmjIvce4GmEsXm3cUTrSlqnfk=;
        b=KZk6iz5cxi1s53iWAjYqf3ge6V/wTgAq5cHGBdPP3L6vweOXoC2WPjrtzZFuvUQ5rb
         cv87B9GnaOx2H/GxAdR3uKx5jzDh25fpuBFmkyRKuFqK0I64cyrRPM9qXmNjP6XsUOwZ
         U0chW+82Gu4bMb3vOqb1rxzIcg1hj4675JqfUy7lJVqYW/9d+hdJpxlUnUPgi3vxZlre
         Rvc3DVwQQ2XLkhwRO0ytnG2WyJlvnj9JAeFvynC7K63LMzJ0vetwMEd60xZ6nXB6XFd5
         JQ2bkz1Z2KFyFHUgfzmPOIEu1sU6jkvtRnfP6A6Lux3YT2t5Lb7PVA8O4hG+1O/UQb+1
         L65w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=prhbp6Zs;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.136 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=prhbp6Zs;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.136 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH v4 3/4] dt-bindings: iio: afe: add binding for current-sense-amplifier
Date: Mon, 23 Apr 2018 23:08:08 +0200
Message-Id: <20180423210809.29586-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:w31AGTsX4inoPpOh1dJwxIGz+4gkXcS5apE3n7y4WXRV6np/5Gfn+YrxyHX8lw+q1SQFcDe8nrj0VoCjr+pkOJUtBLC6h/mlfa0if+lyKHhgjXrvaeI4jrFNgu3E+b6fVyemfK6Haug0aEbW1Hu1huBXrs20e6FHuottQVcNinP5HSk6B4473Mu4C4Ud87BTRoVtn+/sUFnVJ1DHPEp9MrckKVH60Zalu8jG6cYPyTrUnsarY/E7ZNggMslAYepF;25:tkl4RTKn6KVbBjxqaglkZFeABpJcZGhxO0sTpgXlkhpRv08peFgKcd3XBMCWWdKZr42EBgqDqzJh3x7SA4ab1NPp4t/Ks6Mpa/vN33U3upPAaMlN5QSX44ihyFNdD+Yu3w7CsdLcRvQuYRdbhvb9LVHmTTtJJBskFxluP2W2JLLfd2QpiYbiHZu7VKSiB/Y9Lmn0QosE1MnQTr+L/nxGOXhvXVxtwDttc12ofIMKGrlY+MfR5OLizUx2VxhaXIBOyMxbjPegx1sIPLwEDOcb3vQrHfL0EsYzPsk43kLHmnQ0YE0LUN/Mm5/k46E3IzGY458/V07L9/9mfEoxYU8Ulg==;31:7AgLwjc63X8PyTO1Y8wY2Qquhc3euSyE441lfgL/NA3tIgc2WTygBdwqB0t/hCY563VZRQPOFX/PoZrfJWpascw043CiW8zJ5zm7lnR9ZpQRi6I9HxuXiQPYs/S7us4H3iZfBr6ft5cd7DdW/bEa/JJLdxkqS11p1Mj11NPNT3uW6+QrZ1zm9kHiiDGIJ8V+XiD3ybu8S2MUppXpGulY7+XJyldvYuT70k17b8zIThg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779DC266E13A49C51A91668BC890@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:bhHwV5YSb0KiG9YJSEnuqVDk9xNeSnTgBpBEkzzPoCzxLLakZVN99vnec7M7brhaUmz/vcqDGACZbw5sEqFCSmjgC4T1dnALykfnPxloV4xNc9PUvYyyhr0ZVIJLjgIMc0OPDEwkL13tbNaOIhQcwX01zouP2tA2GNsKElaNaiQXkFnBtS2Io/2BIGUhLA48cuq5aulAbTLSaJTn0b2KRpcUI/rlh8qjDtPSTLn5S4x+Gkow+ZVMLFbg1+N53M3ggBaHmSV/3xHyNOq41wby332stq3tdquRlSdLQVWIQym5Rue8xVGTzPn2zlAD/dXf
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(39380400002)(346002)(7736002)(5660300001)(8676002)(81166006)(305945005)(53936002)(25786009)(4326008)(8666007)(6512007)(39060400002)(11346002)(956004)(51416003)(446003)(2616005)(386003)(52116002)(54906003)(6506007)(8936002)(50226002)(76176011)(86362001)(476003)(316002)(36756003)(16586007)(26005)(2906002)(1076002)(6116002)(16526019)(3846002)(186003)(478600001)(7416002)(48376002)(6666003)(6916009)(66066001)(6486002)(47776003)(2361001)(2351001)(74482002)(50466002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:wnAGzwVYpjyKlkZnfwAUggB/3tiYoX1Irfj1C8h?=
 =?us-ascii?Q?uFzpl/TUuKXjA+J8he7PDq8O9xnNej0TyhkO9NUTLeX3Fyidgpmi57Q1Lpoi?=
 =?us-ascii?Q?GsT4u3wWUWq5XHtuX903z6VyPvkpnr0XTcpbLLyK5I0T5Rr6UFMAhMWycVwb?=
 =?us-ascii?Q?PzD9OfVmWs+YKj4z5ZbTzi0Js/9fiL/Njb+9RcZZL8aes3V3qIBqrNFIjYKH?=
 =?us-ascii?Q?alBcIOrAu/1/ZQDDehXZeOYnWuvyWkks4okkZGoy+SNKVGVMbTZ46vynUTBx?=
 =?us-ascii?Q?L6aHrsJidz+Y/YslobyTpp905bQwO0Jp+tYzjaRWUuvbsyzHju15iQd6HYzS?=
 =?us-ascii?Q?zndl0J5wZRfN+KsyynVkKfZkNBpBx5/U4zwVqyfhM7p9l00KQ2btoFohVYOA?=
 =?us-ascii?Q?kgW8gc1rkiHyF2rk/ExbTfOyJmi/6VoT9vdP2oJ/DjxDQUStXq+Wb+Y5i1yb?=
 =?us-ascii?Q?hk2sBfui79ChymIgLtoC6eX29zvKkbognuo8uTj0a0kNwsNJtQV/g7aIA5ac?=
 =?us-ascii?Q?AfJWuSveHxs6EJDIfxMZQatQyJoGH6ObmoUYKYRwwa0/jgm7jcekZ/9EZmgx?=
 =?us-ascii?Q?aaXn6UPjJG8F9wBLge+3S80QT3ZlLEgmIXRNXIHW0oFsVl2FZmwEvINqyIH/?=
 =?us-ascii?Q?Kbfr7OoQ5AM1Ryn394kePFnh/PRyRaqtNoXuyWLyiSAnL0A8vYivs8EhSwP2?=
 =?us-ascii?Q?FQfE2d//2BOJYId2jX9LbfbZgD0hYKQSqHdGaDaix+WFa3bMabhCYqLh0R5w?=
 =?us-ascii?Q?OEemfZduuMj0URxVLwYlqPBxiA7cTrkX3l192lF88YACoEoCzWGE8inkEPic?=
 =?us-ascii?Q?FJ6F9l7q3xC0yodPwq8GUGwTCu46aqcLoDPKXB0mMJmwMdxXo0xYncbpCPkf?=
 =?us-ascii?Q?MPscA8fm7y1197Tn0wu8N5Mq66TkIjxvpcbbckUgZgMhsv1/B/YGKaBlsqTx?=
 =?us-ascii?Q?TqzUtEXpfZUBb4rn6FrCON+n750UcxP4ig8iEEgR3pBZTlgPTMLTJBgHWg83?=
 =?us-ascii?Q?8KnLuRNu9bgBWyIfpQxVn7wCozRfC7s2/GlqQZ6wTA/BMt1zmIXVOrkcEHop?=
 =?us-ascii?Q?QTgstBIgvVjjHxLhqkpFF587+r9CETQNlxjjau5zFntckdgeOjCfFzloO8K8?=
 =?us-ascii?Q?kJGwrVpCHN2Fja7KWyAbDabbhwZKBN6E2hpjgHw5X0tSJbYHFYQ17ZtZOY9Z?=
 =?us-ascii?Q?eO9Tx5VZEGcwylw68zCAGFj5fM02HlOi1dBOF?=
X-Microsoft-Antispam-Message-Info: qWZGJ0V1l9M3IOv/9HHFlUd9qDpCceEtkq6jUizo51j9EN43fWZKNlDseiybJLQjnJYCtCo3SPORWbLeNdUBe+2H78WZDYhVmDDtMTVsVkehf2HK9GPVrZpxbcvn7r0SsFrv+0hIJBrdm+mi0f7fnZyGP6RSxa6un8zfcjGbjJqYSBAAOcGhdRAaJ5lTqWiJ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:/wZLPAbZ92z6YZeCLOYNLFwhQQG7CgRJh6URsqjv9ItZ4eKS2tWM3/5nCZFAfTrCtSb8hif+Pnix3+TuCIb2k0F1PoqyK05PJmmUoyAPt3X9VLi8LkLOqDGqZrVZCPZnrQMqJ0wVfiGU+Jpd4Zx4FUAEOBYx89XG3+faJqPHf5UdzJAE8FYd2GaAnjz7OtZXs+Hvf5pDR1TR2XdoTOpJb0UxzWj4Kj6DR4mkBwN0JRg7EPqPewcABRw0HO7oAi4eIm60nl9j9msbYGZQtB8l5b7SKLhIYCDutFtfT/yopNK7AAR4S5mCFhoDuHFi9bccwdJ0NWbGHjVioS1lYY+r1NxJXwC5f+VP+Jc+RopkHfjjGe/1cP8+h2vWYmSG20shXOcNhvClk/3z2OP7yLasrah1Nbuvx1n7vTRveIwtc0pKjioLm9nQHU2J3LOEZyuc+n/5if3BZbJHkTWN+gzGtQ==;5:6t586ogGuIEWT2KPEDMcx+ucJrWvHjM8Vyl6bp2cIlh3FzRs4kurlPbL3V4kYZ12i5y2ptCpsenlHSsFNl4LLaseahFCRuzaDK7l3k8ffx9oJ/S2jrBi1a+icpecNrRo1rIQoZMrTfLCEr22H599NVjXaZWX0DaiLFrSrR85f+M=;24:WcWEqPKAaVxOPYsXOYM9au2YZCliGSMvz/998xRmYc8zWc08tcUry7RLzCtmiodLrIRPMhNkPx7skq3Bja5oSjseIW0YhqY3kf4O/tKQ3fA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:I1eGzqozO+giLfQo3h3Dchrku6sBzFnFQsN9aQTSwi2M9xUTTBFtSe4CthrS4t6NBzof3yrJLSvEEl+X2UL7zIegegnqz6pT2Tfs0RArrBWJpj0biO5cpxHnqvAKa2LQ2i2/XlYeu4G8XOhyT8QIpFL9pLJnYd2nz6K4CCf7wsqBmcxVfeE0UXrr3DCNw64pLJVjz5+d7NN1BPmiEBnpU0SEaZU/uuTqA67BAaIV7Z9YiV79NS5jFhQkbyscKJFb
X-MS-Office365-Filtering-Correlation-Id: 5dd5d4b8-0905-4877-9d60-08d5a95e62af
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 21:08:37.5958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd5d4b8-0905-4877-9d60-08d5a95e62af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572695361215117?=
X-GMAIL-MSGID: =?utf-8?q?1598572695361215117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Similar to current sense shunts, but an amplifier enables the use
of a smaller sense resistance.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-amplifier.txt   | 26 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
new file mode 100644
index 000000000000..0ddbaebba8ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
@@ -0,0 +1,26 @@
+Current Sense Amplifier
+=======================
+
+When an io-channel measures the output voltage from a current sense
+amplifier, the interesting mesaurement is almost always the current
+through the sense resistor, not the voltage output. This binding
+describes such a current sense circuit.
+
+Required properties:
+- compatible : "current-sense-amplifier"
+- io-channels : Channel node of a voltage io-channel.
+- sense-resistor-micro-ohms : The sense resistance in microohms.
+
+Optional properties:
+- sense-gain-mult: Amplifier gain multiplier. The default is <1>.
+- sense-gain-div: Amplifier gain divider. The default is <1>.
+
+Example:
+
+sysi {
+	compatible = "current-sense-amplifier";
+	io-channels = <&tiadc 0>;
+
+	sense-resistor-micro-ohms = <20000>;
+	sense-gain-mul = <50>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d534c9321de..1b23e9ebff9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6893,6 +6893,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 
-- 
2.11.0
