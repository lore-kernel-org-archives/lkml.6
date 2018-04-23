Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx48UWgrWy9fkp9Khs09nF91DVEj2k5tyoE7aWUzzsVM3FXtgn31aKuDXr5Y5ROB7QB3ZP1Wl
ARC-Seal: i=1; a=rsa-sha256; t=1524517710; cv=none;
        d=google.com; s=arc-20160816;
        b=xmelid0eluqMZwrii9mYF4gz0NMQaCc6zw/UDFCHT8WgV8G0hoRykd2xKUaoUe3OIo
         wLVKxGPRp1cQi5Lkbh4/Q6W3LkKs8MSUFBYvHpu/g0Vv8G7twQsl7Bups9oR8ruXX2iz
         z1O5kAkHI2vWkeMAobDcsL4YSJuePsniJIxMl5mAL2iKc0b3pE2ygcozYwlQ1PQuN/GY
         eO9/BCvejKF/lOXhsWq69Dnudhh664w+YtT/DgXgES4iqA2zt3nfuZMjm6l+lcZjudhB
         iAaJ3OIerRa89aFQcheoxZr1NyAZSSgk84KUxKzIKY9N5oXvuGY4DMO5m3JL0o/0axHc
         bwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=wLb/qkgjFDJx3cf+vv4EqPLYVx/KeUch6ZCj6DOcqy8=;
        b=vA+0jN9ac7EAMO2MmY9k4sXNgFfOZBVs2mT7Jg5iWO9ZXFGyATNLT5IW/9//mNoDng
         HFYyTiajLiLqp+ue8kqxE90ENtynfg5q2LQYhQ5wXhLqEFKpeiVgXNTsG3IuI7hK6bIK
         bNFLz7PKMR6rLwGvw5xofGYHIv6PAcjTw0GhxgWjzXxXkTG1kfKhoYRROu1q171XVwg8
         D9v13EiYHNxzDg0eYggxIB2boRqsob7LfMZ9s8RhMOczxqZaqs1Au+aQZGXsSOLtmVOK
         flkrZp5zGLc94x9iovNS/ZxRvtS1FLqfmheG55hC1Iqjxr7mDSnYWliRRv4Yf883eO06
         8M6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Z9SiUYXE;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.120 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=Z9SiUYXE;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.120 as permitted sender) smtp.mailfrom=peda@axentia.se
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
Subject: [PATCH v4 1/4] dt-bindings: iio: afe: add binding for current-sense-shunt
Date: Mon, 23 Apr 2018 23:08:06 +0200
Message-Id: <20180423210809.29586-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:pAI760QTwp2/fncrl6k4ZT4O3+gEZ6wHsnpe0LHarQQzlwncPjvGwY07ADJinoau2/AOd4tuc1c9hI6dlwaoNqnCo8xZqYtf9NtAwHuhDGYX12X2kQjnPt+Z4NaWh2UsR911msA3f4bOtjjfu6Vf20onUh3IOiVfOC+JWCpT+e7wRjHesfE54luAVOX9XxgdFasa6iTKPyZtbi0Mxh2iAY0jPU1uD0PHhr5BnbO7kNxG8iSrxVn+qvr7LCzAPjvd;25:A/bgHt9rHcFgiam9fSHOgkZ/lARX9ZhuN9EYpHy+S0AKEPJ3wpafTQ4ioh1E3X3TbcWX4dkIjinQM10iRdu/RRG3AlyBLPJ8ajNgQ4NeKdc7UnXsb/sZMbsLifsVfqsDdUM6uJbhSDj1zV+Mi+3wAiOrMxz3VEB4lJlA4G4pJfEp2Us1WoTt7aOjMtZrEKeEb5FxiSIlgLl8KCPVSSReFQvdwRhdIPfv5QORm8zdCxgp4rWVnrdukC8vgPMu8wGuWd+eDmgY0SDFXzuBCyU3uhTwyuIW8i5prG7b9wErW/083lCnL2d9GLmLvNCcn55mF/2gf23ZwpEMeEPtwHULmg==;31:j0aFRpzHJO3HAQU5RUb4M1hn/IFm7V/CC/CpOS/hxj0LqfXOgvGEdrhWc0JONm4jaixWC10CrSvYRPWes4YvcrFrsLtoB3ebCfnNVvSGdlU6kW47COEKnvqBWI0PIvx1iPFGiBms7oM3uIeMId0sCKJ/jd99iN1CZdOYJhpnAlysO2jsv9T6xgUb/oZgQmExpReH0SPKStm4BBaKhk70IFx/1+8yg/cAPZBc0d2NuSw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277950EF59E9CF9EE912F09ABC890@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:50HZa+GeaC2i7mKCH6LEqaAHkXnxdkNhEmtSOgPQ9e8r95c5gpaQFzlw+b+K7GY6WhHCJJcxJX5Y93FcHvRHkFBGUHqMONkCX08Of8gfotyZI7JPZhvQIS0QXc11TGmKaAAsuC8l5Vk5BTQ0fkQ5k6IdtGkqVxljp/lFRHAU1UHGi+RcFAU1kaG5IAqOegxu4Kc1h+IamwI+HwH+yg9Kcnb1jUnH31BM5zkdv9iZ2lR1YTh8qv2SGbLAikJSbcpPbGsyRr2dQkGq6euMZq0ppdU1B1DgMcynuhsjIKFCSf4u7aZBoYvAinOhZ4w5/p/6rgt70FpoZ1q0en2IlZm0Qg==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(396003)(39380400002)(346002)(7736002)(5660300001)(8676002)(81166006)(305945005)(53936002)(25786009)(4326008)(8666007)(6512007)(39060400002)(11346002)(956004)(51416003)(446003)(2616005)(386003)(52116002)(54906003)(6506007)(8936002)(50226002)(76176011)(86362001)(476003)(316002)(36756003)(16586007)(26005)(2906002)(1076002)(6116002)(16526019)(3846002)(186003)(478600001)(7416002)(48376002)(6666003)(6916009)(66066001)(6486002)(47776003)(2361001)(2351001)(74482002)(50466002)(42262002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:x0AIVBopHH9oqS7iy6ufsxwtSlTfDsTW7T70Ree?=
 =?us-ascii?Q?7GEeXHchh22KH8+7HAA2+bloUWMxlJbxmZppSod7ktXxS7dgmbZW4rmcHFG9?=
 =?us-ascii?Q?1Iwbi2jIUyA6WZNHQruuyq0U7LcbMueAViunVsxzGSoxomeAHykK5mJDgJsF?=
 =?us-ascii?Q?sgBnfi1SC17bCPNay6FsvzleezWI313K9hdU1LTb2lG4WxSPxvhfTROhOC1s?=
 =?us-ascii?Q?116LW2w24n6B19atSoLxoxnSnBLNYCXYRZ0iKjdQtMFMuxtP/73tHicDWA6K?=
 =?us-ascii?Q?YJfvENjX/xPWbjovoFYB1J1nPDcJhcokm0iMJwYd3Rc12gScDuUYzpKHJp4p?=
 =?us-ascii?Q?37vZW0Lw3w3VvvgH3amA9C1ASP/ztasgEr/AX9ODFqTjIso6Gh0JiYORB8Vg?=
 =?us-ascii?Q?wDtsYKDOjcKSHco7bN7B+JY9yVFJbwRs60JMgrWsc+C03jznCuPnU4zLjEXJ?=
 =?us-ascii?Q?+Eo34WwpbsTrajokdphcBYucbJ5yhtTj3GJhMZXqWZEACVDU0SX3WWE2SBe1?=
 =?us-ascii?Q?WaL/Z9vAOEvaDCC/D0zsmSKSQdwismzs5r+jGbPa23e0sRGSezyaVOf8HxCo?=
 =?us-ascii?Q?5GgFc5yQXkjmqG56OP27KTtG2SavpYmzyZZhgnZMnXc6l56UXbVmjl7K3H0u?=
 =?us-ascii?Q?8dgcnBChp/6Rf4yMPrIXA8b1iYgqGwJxy0md8RYVakQB+SvEVJpENA/pBpJV?=
 =?us-ascii?Q?eV1MUxQPayOeT+bJqA/UdEDkyp4AqyFyfMWW1oFrGdGhyTYgcyfCrbOMlnjq?=
 =?us-ascii?Q?Qnf3/D6d+MRVSgUPv8sYfisC+wd6x7su6lznWOHv/SoSkq92O2rqkrNDN9Zq?=
 =?us-ascii?Q?ImU+cTB4AJiJVbjnWzUcwQ36BtRH7k17WOaf4RByv8ZAW8qWQ+dtHZCuy3P0?=
 =?us-ascii?Q?KTgtASXWFy+fBgVRpiG65XMiA2/5JYvK7RCGy19nCA1gXlLJzqe4fHn7tVAf?=
 =?us-ascii?Q?R3ilQnxxcDZuTmCPWqJX83EvdWOwsv6ilOfxrDgLgl/qGI2KpymJACrH/bS+?=
 =?us-ascii?Q?TwXitEi7dm8PT9XLOTIHD/Wt28tusd12ln/NGY11NktCYyzk5J5vRk1IQxeW?=
 =?us-ascii?Q?8g2AsE57Hw2m4MnS3C2K8hlEI3sI5KZgxRR1KjQcHV7C5I5s3jPiSUNVQafo?=
 =?us-ascii?Q?MbcuEpQxrgTfMeL9vE0Wgs6wnPmAUXkmBZ/7Z+UYY82cJFSXCN7sHv4M18IQ?=
 =?us-ascii?Q?FIzFGqhk4AY2EKlFw+Turq3s0KnN3wKbH6pYMXdd6cRIGkqbe/HTyw1dTLQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: BJl57kdhk6NWAK4m/FqzlKMqa6NUsV1B0BwVGxxn3gOLaLW4j3Cd6r380CloUBmaFWrW5tQP/YM8PIWVcE7j9d3CNF1ROi5tMiEwTQQn/KKZsIEvlRL0Puboa7nGJ71yp2UMW4Mi6fnjHE1YcnQ8qhK4rIClN9Q7p1W9Ep7Ap/AYAbKcmfWYNNhpx8o3naG2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:ML72nfajEFF+9cjOKcCB+vKyrlVFaaDApfzMxkYtPTIsiiztygYDXnkEeZ/8qUpWCUeugr0/TAtzTna3fd3cGjcfQ++83UZFvtPNjg93bpY/Wg4abLXA42DR0qHCSfY5m0oO/fMtlTBzMLlDqk0nhCPm58lWnSCymBd8l8lIotEE1z7q+zAWO441gIDKLw+6GxFHZcDnfnpT9LF8ToraiyTSwbxy6VYF9uvwjOcLHkguxTgh39naia6IkHUtUUh3Fxd0Cp6V4i9S8ok7hy9KmkJrhtUNwIr2Q7+mgjL76bbK7fvcV/7ckAERvSQDITLSX6grU3klwcZ9pY1Z0rP4c2OpHi+xRB/3b4Y0OYPrLBj4QRpEoPjzY9pca5cfrbqRErtLJTICnTp2c/28DLbpeK7J8e93lbq7w29GIA4mhDSWJnjEf7AdlK39Io9+I4mAyMx6kZGqw6++Q1bljAA7Rw==;5:9y4IIiooRMhDWhpSeXNtolOdwDnJbIqUpiSu9P+m//OlVyVmf0S4GczUfGOqRm87jDxZldc69tBYv/4kuas769S5D2jNdW8dRDSLZBHFbMV9DxcZiyI+woJmnJoSAEsEP0j74sqYdKTmT1o92scOJMo8X7aTrJdLsI2Z3jvw0x0=;24:elmBFKpTew6KvNghvrwq2QKqrbFQ5bwYixDti5lv8Q6x7dJ1UP+gndCd/fIa9sc0lLAW5A5/mLcAiBOyxsiCaWALISZWdudhgv/CkXtFxaA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:9ZSmCXW2wyahANJ9DJIFzt+ld8XuT0NH5NSKvHm0ZkNqrPG9eOYpSXd463BiAkA0ohjeZ9qTdlVt+b7uEqVA+4kieZkCf5hJ4bF6Wu1fN6ydN7/z+XMucMXBMC7HU8IomyHtcRuyhW3UwTY/zLQNO6KXgL63qovySrKn1zWZDgMir7+PYvRO6BTkFuQlqQzcx1xc5yqUahAlU9J1Rpe49XGtT9F5G2/XHmKAWYNPL6rXJABJVoOrvQCZu7p9Qk9e
X-MS-Office365-Filtering-Correlation-Id: 4510c490-5ce4-44dd-5209-08d5a95e5b6e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 21:08:25.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4510c490-5ce4-44dd-5209-08d5a95e5b6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572682864091893?=
X-GMAIL-MSGID: =?utf-8?q?1598572682864091893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, a current through a shunt resistor
measured by the voltage over it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-shunt.txt       | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt

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
diff --git a/MAINTAINERS b/MAINTAINERS
index 36a28e979e9a..0f7bec878919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6889,6 +6889,12 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO UNIT CONVERTER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.11.0
