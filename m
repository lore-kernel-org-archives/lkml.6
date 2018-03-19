Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475273-2-3110790240260554304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475272; b=hOW4gdDjVnILgv6ZPFUSgYrtgKaxjVdpigGGCOG0y/32Ace
    4SP8SvyP81KCowD8yqVE5QD3UdeclOjoTpE3WEBfP0hMNx6gu9kmhlVUSDcj9BaQ
    p0AvKvr6buDCfVapQuc363bVQ9HWQWiMghZ2LpCco6d0hkjw/x+8TV3mxt8eyI/s
    T8FeRx9cVpOyp/abNiOjQoswiQhJUabJ9+o9g+tHeHkJJtvDhO4vX/rAtvsVGSXJ
    /tG7yix9L0wpK3vFK0qx+Dd+w2TFdJmcge4OmHPwbwtG0uMYECE5qEiYM+bBUeg1
    z96+GUll+W/oBsw6FcZQSJNspJhfBYDTL9puP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475272; bh=eKZbpS
    DlSVigEnTE7QMlo9f7rfUS2sD3GzcSIuj17dY=; b=A4r3rzlPCOks6JhCksZVa+
    gXfD0poyGt/Ly0qvltL7CWJF2OC+Q/Yip4HDDP4LEzDHnQqIlOGiYMp/nI8RdBou
    /ttTwVWKKnw18LOmaU6/2XHzZgta2uTZL3NZH+Eef2pzZT96X50DSg3kWK/O/VXN
    f3+2Am7NTm9SuNX1YH7SqMNl6wKdIPnAYWPP4UbKJ3VJlsOBZ8awMrm5kBvaNEao
    QzUreKYXG5jNmPXcprcyxLEEEZ9+jxEQQ9lXCwwxG5M9RoOxo6UzVU82/g/N6X+g
    x1QP5vn63pB5lAipY8RgGLmLAh5q/R5dit4pAqdqr+Hsa6PSz5OLubsGYNTpLQkA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fsho50fT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddukedvfeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fsho50fT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddukedvfeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965266AbeCSQA6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:58 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:4912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965253AbeCSQAq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Aaron Lu <aaron.lu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 095/281] gpio: crystalcove: Do not write
 regular gpio registers for virtual GPIOs
Thread-Topic: [PATCH AUTOSEL for 4.9 095/281] gpio: crystalcove: Do not write
 regular gpio registers for virtual GPIOs
Thread-Index: AQHTv5tMGpwzFy+J+UerwXdFwyzsLg==
Date: Mon, 19 Mar 2018 15:59:45 +0000
Message-ID: <20180319155742.13731-95-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:Cvc39YG6yvQhrR12Xet1B67cMDEvZ2NSI7mnuw0CceZ60wqsTwkP+Pz9yOqzNvOwxe1mnNb21jRMil4kV9RX+k5CGuqiMSfMI/syY+FvdxSaEhO+xboChb4rKAzSCdQO5cNCGwPrBaJxoEUyuM27QhjDSWveKbbrS7+p8jOYlhCAiaYZr2JF+PjYJTBSu9OjLhtFCDRXhKh0CBuwQ7dn0lQdAFnvIEHz7WYawBsf1S4KPA3VApvHml7YBQGzLZ48;20:7UvB9yiwoDWjBZ9RtYHHjnyl7H3s7cPc6eP3Sizt218ciX0oBuhD3W6FIGxHbeRunAdRwqZLUMmF7RbMcq2jcOSNuW8suUUPvvgaPstHe3J/qPLlNzKkcIjPofzJYsJi2rhl13hwtXQfwyV7J4EC/jkXGH5KXH/6FY2Z7uaRdq0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b4b4865-6287-4682-6fef-08d58db29113
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933B295DB1BE14892FC1A70FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: cI5Trx9cwS60PCFZSyqItIFYuoH2qY+ioWytrupVPlk9ZL3SGGBbAKqykLUVcY3vnehZ/hBBMe1oZZkOIPi0hLy7GhrLMMLOfg1x9DmGzSEQ+w2hApUU+f+Gel6dl1UTF1yGypElE/99mZVnCe+wo+UkWJjjvXGwnV6jug+Q9X3e38/2fdIGeFM+G/ai2h7szbLuVgBXYhaOJSFLcb4avT7nB4n0MH1gi22Bh+CA+BXbRhgmNQe41UeKZaDytjnKbRsDjfZpxxwPyEUDUdrMUwC+48hiV5DykeXxyu7HxfeDgxqhhtK1pD/tHz+iX9Ef74zvwjtOUQ62Du0IBabJ7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4b4865-6287-4682-6fef-08d58db29113
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:45.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 9a752b4c9ab924033bfdb8784c680d50b2bd5684 ]

The Crystal Cove PMIC has 16 real GPIOs but the ACPI code for devices
with this PMIC may address up to 95 GPIOs, these extra GPIOs are
called virtual GPIOs and are used by the ACPI code as a method of
accessing various non GPIO bits of PMIC.

Commit dcdc3018d635 ("gpio: crystalcove: support virtual GPIO") added
dummy support for these to avoid a bunch of ACPI errors, but instead of
ignoring writes / reads to them by doing:

if (gpio >=3D CRYSTALCOVE_GPIO_NUM)
	return 0;

It accidentally introduced the following wrong check:

if (gpio > CRYSTALCOVE_VGPIO_NUM)
	return 0;

Which means that attempts by the ACPI code to access these gpios
causes some arbitrary gpio to get touched through for example
GPIO1P0CTLO + gpionr % 8.

Since we do support input/output (but not interrupts) on the 0x5e
virtual GPIO, this commit makes to_reg return -ENOTSUPP for unsupported
virtual GPIOs so as to not have to check for (gpio >=3D CRYSTALCOVE_GPIO_NU=
M
&& gpio !=3D 0x5e) everywhere and to make it easier to add support for more
virtual GPIOs in the future.

It then adds a check for to_reg returning an error to all callers where
this may happen fixing the ACPI code accessing virtual GPIOs accidentally
causing changes to real GPIOs.

Fixes: dcdc3018d635 ("gpio: crystalcove: support virtual GPIO")
Cc: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-crystalcove.c | 54 +++++++++++++++++++++++++++----------=
----
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcov=
e.c
index 7c446d118cd6..1d87b0718d3a 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -90,8 +90,18 @@ static inline int to_reg(int gpio, enum ctrl_register re=
g_type)
 {
 	int reg;
=20
-	if (gpio =3D=3D 94)
-		return GPIOPANELCTL;
+	if (gpio >=3D CRYSTALCOVE_GPIO_NUM) {
+		/*
+		 * Virtual GPIO called from ACPI, for now we only support
+		 * the panel ctl.
+		 */
+		switch (gpio) {
+		case 0x5e:
+			return GPIOPANELCTL;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
=20
 	if (reg_type =3D=3D CTRL_IN) {
 		if (gpio < 8)
@@ -130,36 +140,36 @@ static void crystalcove_update_irq_ctrl(struct crysta=
lcove_gpio *cg, int gpio)
 static int crystalcove_gpio_dir_in(struct gpio_chip *chip, unsigned gpio)
 {
 	struct crystalcove_gpio *cg =3D gpiochip_get_data(chip);
+	int reg =3D to_reg(gpio, CTRL_OUT);
=20
-	if (gpio > CRYSTALCOVE_VGPIO_NUM)
+	if (reg < 0)
 		return 0;
=20
-	return regmap_write(cg->regmap, to_reg(gpio, CTRL_OUT),
-			    CTLO_INPUT_SET);
+	return regmap_write(cg->regmap, reg, CTLO_INPUT_SET);
 }
=20
 static int crystalcove_gpio_dir_out(struct gpio_chip *chip, unsigned gpio,
 				    int value)
 {
 	struct crystalcove_gpio *cg =3D gpiochip_get_data(chip);
+	int reg =3D to_reg(gpio, CTRL_OUT);
=20
-	if (gpio > CRYSTALCOVE_VGPIO_NUM)
+	if (reg < 0)
 		return 0;
=20
-	return regmap_write(cg->regmap, to_reg(gpio, CTRL_OUT),
-			    CTLO_OUTPUT_SET | value);
+	return regmap_write(cg->regmap, reg, CTLO_OUTPUT_SET | value);
 }
=20
 static int crystalcove_gpio_get(struct gpio_chip *chip, unsigned gpio)
 {
 	struct crystalcove_gpio *cg =3D gpiochip_get_data(chip);
-	int ret;
 	unsigned int val;
+	int ret, reg =3D to_reg(gpio, CTRL_IN);
=20
-	if (gpio > CRYSTALCOVE_VGPIO_NUM)
+	if (reg < 0)
 		return 0;
=20
-	ret =3D regmap_read(cg->regmap, to_reg(gpio, CTRL_IN), &val);
+	ret =3D regmap_read(cg->regmap, reg, &val);
 	if (ret)
 		return ret;
=20
@@ -170,14 +180,15 @@ static void crystalcove_gpio_set(struct gpio_chip *ch=
ip,
 				 unsigned gpio, int value)
 {
 	struct crystalcove_gpio *cg =3D gpiochip_get_data(chip);
+	int reg =3D to_reg(gpio, CTRL_OUT);
=20
-	if (gpio > CRYSTALCOVE_VGPIO_NUM)
+	if (reg < 0)
 		return;
=20
 	if (value)
-		regmap_update_bits(cg->regmap, to_reg(gpio, CTRL_OUT), 1, 1);
+		regmap_update_bits(cg->regmap, reg, 1, 1);
 	else
-		regmap_update_bits(cg->regmap, to_reg(gpio, CTRL_OUT), 1, 0);
+		regmap_update_bits(cg->regmap, reg, 1, 0);
 }
=20
 static int crystalcove_irq_type(struct irq_data *data, unsigned type)
@@ -185,6 +196,9 @@ static int crystalcove_irq_type(struct irq_data *data, =
unsigned type)
 	struct crystalcove_gpio *cg =3D
 		gpiochip_get_data(irq_data_get_irq_chip_data(data));
=20
+	if (data->hwirq >=3D CRYSTALCOVE_GPIO_NUM)
+		return 0;
+
 	switch (type) {
 	case IRQ_TYPE_NONE:
 		cg->intcnt_value =3D CTLI_INTCNT_DIS;
@@ -235,8 +249,10 @@ static void crystalcove_irq_unmask(struct irq_data *da=
ta)
 	struct crystalcove_gpio *cg =3D
 		gpiochip_get_data(irq_data_get_irq_chip_data(data));
=20
-	cg->set_irq_mask =3D false;
-	cg->update |=3D UPDATE_IRQ_MASK;
+	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
+		cg->set_irq_mask =3D false;
+		cg->update |=3D UPDATE_IRQ_MASK;
+	}
 }
=20
 static void crystalcove_irq_mask(struct irq_data *data)
@@ -244,8 +260,10 @@ static void crystalcove_irq_mask(struct irq_data *data=
)
 	struct crystalcove_gpio *cg =3D
 		gpiochip_get_data(irq_data_get_irq_chip_data(data));
=20
-	cg->set_irq_mask =3D true;
-	cg->update |=3D UPDATE_IRQ_MASK;
+	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
+		cg->set_irq_mask =3D true;
+		cg->update |=3D UPDATE_IRQ_MASK;
+	}
 }
=20
 static struct irq_chip crystalcove_irqchip =3D {
--=20
2.14.1
