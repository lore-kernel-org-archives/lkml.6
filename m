Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489247-2-9433469491387028983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489246; b=lX0HEVmhy2a5aWXOAIb4vj3hsvdCV4eow+lkgpzVcfrMojr
    VDanCsmIbhxG3lhrmhumkgkiQZ96Kh0OFbVf/0ebJjnjTAKiW7AxKK1Uym6AmeUu
    6dNf8XYLal4u1R4DCnl0VoF5I2nQgWl0k1CW5tJI8r7mwAfnK8LS9dCIkZyWP6lV
    /KiNCWideuEID75+9CqCJa+x/7JgO3XnJBPVbgJ4ZA7c0rZjVAaTaA/Vo0flcqDc
    UZZ2f1oFGBP1ALmj2PSETmysMUgqSDYnT+kZftgsNn1LLij+RJSaJEvKwHEY1BI2
    DRK+HIVnVaZyzb1DEhK+ByrQDro+393v2eoO6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489246; bh=VzOuVx
    Msgj26QyfZVydbjSwO53pUVcR8uaVAEJTERN8=; b=P4lf+uBC/P4tFxLsnBZc60
    rlujDTfANcVEadgR7SwGn6J4ftk6OP+FVjkK2CqaO/3cPZxVZ7V2LyMCSwRaZ4Gf
    +c12QqO5gpAG6rbaDZojqz/mHSSzdJupIRZmpqxGi1QoOi0Eie0DwkIW46HCRZHV
    4ju0qTRuE1/e427E3xguxEQaxDri91pn3Eu1tgZ//8/mquZV00C+hhSvNnyl52eM
    7+Y4Fcvw06cxePCWsmyrgEB+O0GdS+2ZNreWyIAPbDR97SY7TYjIz/OWwzaHBtSK
    jRWPopA3qTTHy9E/qKJxlwGiAcogFHrz7zQMLE8CpWF/xU1op+a7GlUlDSVKRG2g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HUobhzhe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HUobhzhe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935482AbeCHGHM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:07:12 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965809AbeCHFCR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 104/190] gpio: gpio-wcove: fix GPIO IRQ status
 mask
Thread-Topic: [PATCH AUTOSEL for 4.9 104/190] gpio: gpio-wcove: fix GPIO IRQ
 status mask
Thread-Index: AQHTtppCSIjdI1Q0ZE6E7PBvZWCtRg==
Date: Thu, 8 Mar 2018 04:59:37 +0000
Message-ID: <20180308045810.8041-104-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:jN7LJVAvoj0WO2AzQ6yhZe51nJNOqk6//kq/clpw4vnkPLCotke5hpZX94h4cM4ri2dT8Ivx2oaaY9kkK2pSUMBBwiOy1EVh6WLBjEEnB/DMB7fsZVz0kZyExbpBn7GfvVJeOVqUa5r9afTCjdbJulZaQX4ScgO7XgFd1LmH1OiV/FCst8fTtPW5e0i+kt5deHj7uUwVjEqN8kxqHCqy38DOKr4XmIbEam3IUQOcrP2DMyshQeSK5yEPGt+LaVMG;20:X7CdfBYwEhJODzpwzpwXd9RPn57NI2AJgwUWHHyf/EpZqlAgK5n6RZbh2fGuGnpuCEUPjXzNCnZasvwv9jDg4L1g1Ih1+JVHieeYzk3MRh/QOwi84gjqZ0Unl055+IyHKF5h38fjfW9lV7/ntBtVtV2J5aKypl/Nv2dOlewQnTY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2acf50de-3216-49bc-a836-08d584b1c11e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09974221B8207B8826B6D88CFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kg1H+QP10TSIuf7ovZb4RJoDZvUYuCRsmOculF+DBQ+/giQ/SFXL2Vp7stmlpz8Xnk8HMPTlj4nki/zBjPb82Mrog5b+WviM9Z4W2GJgDToYVfX0WLzW47Zb0c8c4Y/OnYT8fsNG0RILz8ZECYtLZZm0cLhbUY6MlE78hcg8074Tjf1wqOEMWK21zLWYiU+eNZnT8YPd1ubpD9vbnkmk0WqfalNPxslJGJXE3GZ4vZiI87WHO7cVihJ+oj2ttY2njCc7keGDI84d4HlSOF0zdXHjIkfwKc3cPwgagOd3+og0h/uGbNdrC5x8wpgaTOkrsnN0HyymV7PBAciSqOq81Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acf50de-3216-49bc-a836-08d584b1c11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:37.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.co=
m>

[ Upstream commit 881ebd229f4a5ea88f269c1225245e50db9ba303 ]

According to Whiskey Cove PMIC spec, bit 7 of GPIOIRQ0_REG belongs to
battery IO. So we should skip this bit when checking for GPIO IRQ pending
status. Otherwise, wcove_gpio_irq_handler() might go into the infinite
loop until IRQ "pending" status becomes 0. This patch fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-wcove.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 1012c86925ad..5ef4980f3f14 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -51,6 +51,8 @@
 #define GROUP1_NR_IRQS		6
 #define IRQ_MASK_BASE		0x4e19
 #define IRQ_STATUS_BASE		0x4e0b
+#define GPIO_IRQ0_MASK		GENMASK(6, 0)
+#define GPIO_IRQ1_MASK		GENMASK(5, 0)
 #define UPDATE_IRQ_TYPE		BIT(0)
 #define UPDATE_IRQ_MASK		BIT(1)
=20
@@ -310,7 +312,7 @@ static irqreturn_t wcove_gpio_irq_handler(int irq, void=
 *data)
 		return IRQ_NONE;
 	}
=20
-	pending =3D p[0] | (p[1] << 8);
+	pending =3D (p[0] & GPIO_IRQ0_MASK) | ((p[1] & GPIO_IRQ1_MASK) << 7);
 	if (!pending)
 		return IRQ_NONE;
=20
@@ -334,7 +336,7 @@ static irqreturn_t wcove_gpio_irq_handler(int irq, void=
 *data)
 			break;
 		}
=20
-		pending =3D p[0] | (p[1] << 8);
+		pending =3D (p[0] & GPIO_IRQ0_MASK) | ((p[1] & GPIO_IRQ1_MASK) << 7);
 	}
=20
 	return IRQ_HANDLED;
--=20
2.14.1
