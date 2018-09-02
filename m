Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0855E2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GEGxfI3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0855E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeIBRta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:49:30 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728245AbeIBRUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g/5QU6UUr1uM8HxXsT15mw0w775PxnniHI38DqhVwU=;
 b=GEGxfI3BPIHTb8qGWj+kOufXOn1sIOSg+tHlUCn+UcCiHrmfDv02JVE/yovW2WiCeitMDFJ0DCYVhGAWTmQPFMs8ggnXK+abbTQb52Tcz8GkLglB90vRHQNTQyJ0tz15dpqK04Ttzuu2dvEe/9ZsjsJB1ApYjIkcaskt1qE/irw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 077/131] gpio: pxa: disable pinctrl calls for
 PXA3xx
Thread-Topic: [PATCH AUTOSEL 4.18 077/131] gpio: pxa: disable pinctrl calls
 for PXA3xx
Thread-Index: AQHUQr2DoCjeJbEi0UKQOSnMgEfiqg==
Date:   Sun, 2 Sep 2018 13:04:42 +0000
Message-ID: <20180902064601.183036-77-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:nOZJkTWdVMFG59jnpl/2dIVFDGzya9V5/albswMLQS1o1PVVcmlKDXdT+GdZzxfqOno+tAy0vHX5+S6dmz3O41a++LfzgXuOgI9/5q8O/mFWOxsmjxXDB03Cdq4XWPDi2FJpIwFN16SHJUNsq9ueSUHfzz7uBxQOSqhJrxCcn5rUN7R5D+SLXW/xfauPguKn24fNUTGWmfxDfD1y0f3V+b1WCv/YHesjZG4fd7GKegrU40P8+mYFcaVVXCa8ZJN0/dHoQmXsjFsO9ZfLPI3ASAbKD/n1xA3our1qfQSSdx+Y5aaPil9NNWqFcMqDSTd8FbmHChil9IYjzfHe+LqhAPOICmzA9QeIGwtL15PZ9nGKkOS+hhOBTBvC0xdGNWh0NcyXsx6KeBDb7HBCEN/hhqJ4bSNrRs0UNXJlimLnxK0rwfnXbNhlKQ2x2XtpS62/Legc1w2vksWjYPSfLmzGYQ==;5:FK4UVtx51du8jngjCLi1LzBQxIA0+EionIEL0qBl4pf7+NtA3mhCknhmXE2NynAthqMG7hf4ew+zKTPDhxgpsSepqEfkhxcalyaijHeKS5Q98dsuv25mrXIvrfpqS2K3kVZbi1W8/a04u/OGyLNEFh86CdwqyOQ1x+wENLT7XpI=;7:DuWc00mYhm15L8JeEWfrynZHmXJNlbUX+ceCUBAoj6E5EK7byD+Withx/FT22BvTCwj6NC+WDHgae1XDI4yEb7LHZFopaQRQF/LvbWrudIWZvJwYidJ+eA3g1S8aMc7YbD5SqdNyrmTB8kFkYh08rsXurnOeqH7+PZGAGyjxA2Qbn4LWW0tIgVdMhxIPJmpoAAvhNbovFX/ecz1SYznG0Z92DsI/x3eWGslJG4xWiEsUmSfEulPb9mlurm5dW7s+
x-ms-office365-filtering-correlation-id: 4911a33f-c6a8-4516-bb51-08d610d4adcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07410190DD06C707298AE5EDFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003)(32563001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 98iy0EbcEu8m2L+uKhlg1sxaD2cRvMCmqEQWaRERvsb0gbNsmqR43DJoORkYF7GKVAy/HZ0dAXwK3EIxXB1X0/K8RPiuHmz8RP8yZ0+QfpQZF5vCHkTVccGRtTQCTCz9YwL90qFasJ4e2ZGImQcxPD+yeZPxD8L0auu+iQuTgou7O7//1ug57j0Yyu4YOe7PXYYNg8goXBdApP0EXu4xfeZJqM4c6Zzd1E1xmI5YUKwzuAtNQ6ooF1PSU53mzyGoN+dZL6n4YcDiilNfk9G8NpeMC5lG7E1jLCyiliAPYzf1FS/6CdgnEygPEf1TqCa2lX0vKsmib2UGZPwzurEs90wugbtkJtphfW8z3NWSPyg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911a33f-c6a8-4516-bb51-08d610d4adcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:42.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit 9dabfdd84bdfa25f0df486dd3de43e53e79a1892 ]

The pxa3xx driver uses the pinctrl-single driver since a while which
does not implement a .gpio_set_direction() callback. The pinmux core
will simply return 0 in this case, and the pxa3xx gpio driver hence
believes the pinctrl driver did its job and returns as well.

This effectively makes pxa_gpio_direction_{input,output} no-ops.

To fix this, do not call into the pinctrl subsystem for the PXA3xx
platform for now. We can revert this once the pinctrl-single driver
learned to support setting pin directions.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-pxa.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 1e66f808051c..2e33fd552899 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -241,6 +241,17 @@ int pxa_irq_to_gpio(int irq)
 	return irq_gpio0;
 }
=20
+static bool pxa_gpio_has_pinctrl(void)
+{
+	switch (gpio_type) {
+	case PXA3XX_GPIO:
+		return false;
+
+	default:
+		return true;
+	}
+}
+
 static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct pxa_gpio_chip *pchip =3D chip_to_pxachip(chip);
@@ -255,9 +266,11 @@ static int pxa_gpio_direction_input(struct gpio_chip *=
chip, unsigned offset)
 	unsigned long flags;
 	int ret;
=20
-	ret =3D pinctrl_gpio_direction_input(chip->base + offset);
-	if (!ret)
-		return 0;
+	if (pxa_gpio_has_pinctrl()) {
+		ret =3D pinctrl_gpio_direction_input(chip->base + offset);
+		if (!ret)
+			return 0;
+	}
=20
 	spin_lock_irqsave(&gpio_lock, flags);
=20
@@ -282,9 +295,11 @@ static int pxa_gpio_direction_output(struct gpio_chip =
*chip,
=20
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
=20
-	ret =3D pinctrl_gpio_direction_output(chip->base + offset);
-	if (ret)
-		return ret;
+	if (pxa_gpio_has_pinctrl()) {
+		ret =3D pinctrl_gpio_direction_output(chip->base + offset);
+		if (ret)
+			return ret;
+	}
=20
 	spin_lock_irqsave(&gpio_lock, flags);
=20
@@ -348,8 +363,12 @@ static int pxa_init_gpio_chip(struct pxa_gpio_chip *pc=
hip, int ngpio,
 	pchip->chip.set =3D pxa_gpio_set;
 	pchip->chip.to_irq =3D pxa_gpio_to_irq;
 	pchip->chip.ngpio =3D ngpio;
-	pchip->chip.request =3D gpiochip_generic_request;
-	pchip->chip.free =3D gpiochip_generic_free;
+
+	if (pxa_gpio_has_pinctrl()) {
+		pchip->chip.request =3D gpiochip_generic_request;
+		pchip->chip.free =3D gpiochip_generic_free;
+	}
+
 #ifdef CONFIG_OF_GPIO
 	pchip->chip.of_node =3D np;
 	pchip->chip.of_xlate =3D pxa_gpio_of_xlate;
--=20
2.17.1
