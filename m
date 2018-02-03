Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680837-2-699222256158678592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680836; b=F/2S9ivqedjGGoKICj8cO80Gowg30CE6Z7q/d1Ey3UqA9h2
    UQfcLeVDEhAFrO9pt6a8bwt0ZIJ30NO00Nm15OqxMne/CUfPcnz0kfC/3Nkn+EBJ
    ap/BUgMWUMOy5X5wq6kJUGlrqcyf16vNiXgtd9dA6rgCanYX6eZH/NFHyLrl2aYm
    vTvuJ4IWpNLLv5VIU2rvL6K/oNBaWydw1pUESh7EMbzbr1SQiFulpX9gvVBKI72h
    Iv+RMB8a1772Vo8MhOEg69BlmOUysNoHDvv0oYWT3i7pfTuwnQENWoHgvuh+VJrA
    B4FJcIkPT/DHwO3PGlgfYw0TJDuNrBUUWHRDMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1517680836; bh=VOXOg8lim7za5VekaSi5+JeV4M
    ZR1tQ9XcvmXqvkD5U=; b=QOiZ0xUo4UyjFi4Rxn/ho0kj96t+KpSYG7D1tmi4CY
    ZX1kwzaoTH4LTC2Lkxi1p2CC2ZoO/r9B/BHVBbvD9l4BD+PK0gDENcffHQhoUOVm
    q/kijSZr5Q0529wOew58FQZRvYwPXwg8xxMQMgUlAdMQo0JOdahJeS138ro0Z5FN
    TVy4GR8G8lnA0kGkmQWe8ejeY6KBiKkayYVUtRB2db7tK3/9R+sbx2UieUo1fhFn
    ybXF/1LJB2IEm4Q4+BL1Tw2fF79u8ei7Rp7/Yzzm1ofnU1eOyaApmm5p4bUxvm6m
    J/ofLAk4HKmnNiep4UuMNJu4KulONuvQVFXjUxXsR5QQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JpT6I89g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JpT6I89g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeBCSAa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:00:30 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752235AbeBCSA3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 001/110] net: phy: fix resume handling
Thread-Topic: [PATCH AUTOSEL for 4.14 001/110] net: phy: fix resume handling
Thread-Index: AQHTnRjdCvnbE4pOgUe1DKcl1cdl9w==
Date: Sat, 3 Feb 2018 18:00:25 +0000
Message-ID: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:5ROY2B60DF7+p2QyVyyV2eMNYOW/CU6rKme8fm9EAgh2c6Wbwy6VvORpq6TOK7Mkqaf8E45QmbSd9iGbUAiMvCLmbOStY7560GM6Y+idpOb0aMVwm5u9vhHJJtnDT1QzI8vtDaTuCY3hoCRk52YkQ9HcSNoL4famunWlEQeS/6roQwdPvTKYFRGGMqGIZpml9rx6MoTuIB4DTcZvFJ1pyB5+cuM5SbtrsZx8HHMbIv3W0XUB5OamW8G+lkR9KrC3
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(5890100001)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1603b30-5912-4abf-108a-08d56b3000b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043DF9E0B6A20C9C5BD8479FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: AdRTf/X8c+5eGbAAD5xAteM29aVc1Opq9UL3AoF+GpV6cVOkX1dlggYN15F0Nb2oVx9zz6rQtkPOD5lIuNSGHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1603b30-5912-4abf-108a-08d56b3000b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:25.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit f5e64032a799d4f54decc7eb6aafcdffb67f9ad9 ]

When a PHY has the BMCR_PDOWN bit set, it may decide to ignore writes
to other registers, or reset the registers to power-on defaults.
Micrel PHYs do this for their interrupt registers.

The current structure of phylib tries to enable interrupts before
resuming (and releasing) the BMCR_PDOWN bit.  This fails, causing
Micrel PHYs to stop working after a suspend/resume sequence if they
are using interrupts.

Fix this by ensuring that the PHY driver resume methods do not take
the phydev->lock mutex themselves, but the callers of phy_resume()
take that lock.  This then allows us to move the call to phy_resume()
before we enable interrupts in phy_start().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/at803x.c     |  4 ----
 drivers/net/phy/phy.c        |  9 +++------
 drivers/net/phy/phy_device.c | 10 ++++++----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 5f93e6add563..e911e4990b20 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -239,14 +239,10 @@ static int at803x_resume(struct phy_device *phydev)
 {
 	int value;
=20
-	mutex_lock(&phydev->lock);
-
 	value =3D phy_read(phydev, MII_BMCR);
 	value &=3D ~(BMCR_PDOWN | BMCR_ISOLATE);
 	phy_write(phydev, MII_BMCR, value);
=20
-	mutex_unlock(&phydev->lock);
-
 	return 0;
 }
=20
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 2b1e67bc1e73..ed10d1fc8f59 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -828,7 +828,6 @@ EXPORT_SYMBOL(phy_stop);
  */
 void phy_start(struct phy_device *phydev)
 {
-	bool do_resume =3D false;
 	int err =3D 0;
=20
 	mutex_lock(&phydev->lock);
@@ -841,6 +840,9 @@ void phy_start(struct phy_device *phydev)
 		phydev->state =3D PHY_UP;
 		break;
 	case PHY_HALTED:
+		/* if phy was suspended, bring the physical link up again */
+		phy_resume(phydev);
+
 		/* make sure interrupts are re-enabled for the PHY */
 		if (phydev->irq !=3D PHY_POLL) {
 			err =3D phy_enable_interrupts(phydev);
@@ -849,17 +851,12 @@ void phy_start(struct phy_device *phydev)
 		}
=20
 		phydev->state =3D PHY_RESUMING;
-		do_resume =3D true;
 		break;
 	default:
 		break;
 	}
 	mutex_unlock(&phydev->lock);
=20
-	/* if phy was suspended, bring the physical link up again */
-	if (do_resume)
-		phy_resume(phydev);
-
 	phy_trigger_machine(phydev, true);
 }
 EXPORT_SYMBOL(phy_start);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 67f25ac29025..b15b31ca2618 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -135,7 +135,9 @@ static int mdio_bus_phy_resume(struct device *dev)
 	if (!mdio_bus_phy_may_suspend(phydev))
 		goto no_resume;
=20
+	mutex_lock(&phydev->lock);
 	ret =3D phy_resume(phydev);
+	mutex_unlock(&phydev->lock);
 	if (ret < 0)
 		return ret;
=20
@@ -1026,7 +1028,9 @@ int phy_attach_direct(struct net_device *dev, struct =
phy_device *phydev,
 	if (err)
 		goto error;
=20
+	mutex_lock(&phydev->lock);
 	phy_resume(phydev);
+	mutex_unlock(&phydev->lock);
 	phy_led_triggers_register(phydev);
=20
 	return err;
@@ -1157,6 +1161,8 @@ int phy_resume(struct phy_device *phydev)
 	struct phy_driver *phydrv =3D to_phy_driver(phydev->mdio.dev.driver);
 	int ret =3D 0;
=20
+	WARN_ON(!mutex_is_locked(&phydev->lock));
+
 	if (phydev->drv && phydrv->resume)
 		ret =3D phydrv->resume(phydev);
=20
@@ -1639,13 +1645,9 @@ int genphy_resume(struct phy_device *phydev)
 {
 	int value;
=20
-	mutex_lock(&phydev->lock);
-
 	value =3D phy_read(phydev, MII_BMCR);
 	phy_write(phydev, MII_BMCR, value & ~BMCR_PDOWN);
=20
-	mutex_unlock(&phydev->lock);
-
 	return 0;
 }
 EXPORT_SYMBOL(genphy_resume);
--=20
2.11.0
