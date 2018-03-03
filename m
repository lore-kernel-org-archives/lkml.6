Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121052-2-5288001420590736835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121051; b=dcPQW/UVSj/24f2mmbqIkpJNMm9XK+0swlR7JLimOHVMuu2
    +AtysXhA0mVf7wgyxkFntttm56ZRzYlK8T34PnYevF9ZznSRllyX+ueYT8P0AUhN
    1ScBo4lVKzWITcfcq7BD/Dx2TDVn2b7krVrG/sQZQjxPkBM5vHA1gP+y/8vV5gRI
    yAT8waQSfKkI0Zyf/sZ0V8cXdONi9G98pXeGD22gBy8yyVZgrzphZ2+1WxiJnjiq
    Y1weJi+LY/bbR1A5V3NjyS/g9fCGUPCk2csvZK/DNpb9ifu8wjsuSDkb6pxxThPF
    2BuVROovDRmPRb7CLCDy7SoYTBHLtGMRwlBCcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121051; bh=2w1vf+
    vpl+MPSugWYY+wezKtUSCMugAvBA1QqC1DYL4=; b=lL3e0G6Mf9PZlAMxmOZdcM
    L/vAl5UnbVI7HI55f9mGMPNy+SVn5UbHXwcCAlb8b3Q8X1Z1gWnPnKCCjWM3ygMo
    vd05xT1TkqBFHy5H+gLusvMIDCoNG45AisPxTJHcnEpNDfDwBlhOiWu1ZBMdJRME
    DkWg72RhYmecs+4PV+RL3n+eRLvcfjOPNvnbtjPJcG/zdhnUW8NPdmYCWMIh0NRw
    8umJlLLdaBv7K5kjae29O5Nctu/3MnK8TKg+vqH7Vk8KVkV1DBeYJwhSDF//xpHG
    8FQlBsjo59Pmd3XdOBX+sbY6AmnaIY2U9llZlMc7CYPK9olpiFXnIbzTlKyrY+SQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMbIm61j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMbIm61j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeCCWdP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:15 -0500
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:49841
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933993AbeCCWdM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Matthias Kaehlcke <mka@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 083/219] regulator: core: Limit propagation of
 parent voltage count and list
Thread-Topic: [PATCH AUTOSEL for 4.9 083/219] regulator: core: Limit
 propagation of parent voltage count and list
Thread-Index: AQHTsz79jFdFr0unw02mjbKZXcseNA==
Date: Sat, 3 Mar 2018 22:28:44 +0000
Message-ID: <20180303222716.26640-83-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:l1M3OteA5IXFs06TtwEVvx90DG4bgjwTmDK+zd7hj4nqif7qFLGnuA5CjNGGtZZ7EYrCqqy6CQWDWitv8CRKO4E+cT2npKZvPZnfPLikQ4W8WsF01sFT7zgdMn1pRup9BAV6Y4/2MYT/N4BYD4N+t2r1vm3iskH/nDDW+1Y/wDBXPP5IcRXdURnGVKxfy8J7M1wk7FrqCUNMdTR+AbA6BeJSNdZu/zhULrKhZkyNIs2cMmAkaz6Yg0jhZ13WjyUb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8714566-4405-4a85-612d-08d58156bdd7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097F8787C801462AE1E8A53FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Ah8OWmNJkf1fu1UEdhHZi7rz465tejMBqRKLdmgc7qnBpLcdgkbkKUX6idodXGtqhDIBR2UhsslvW+qj7jj0O/MT8B90LDcKoCcVU++33grzz8tspLRcF1v7wGp+z3ARwh8smcS8hFf+R43cICLZjREo7POvtlWvNuSbnQoXeHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8714566-4405-4a85-612d-08d58156bdd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:44.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit fd086045559d90cd7854818b4c60a7119eda6231 ]

Commit 26988efe11b1 ("regulator: core: Allow to get voltage count and
list from parent") introduces the propagation of the parent voltage
count and list for regulators that don't provide this information
themselves. The goal is to support simple switch regulators, however as
a side effect normal continuous regulators can leak details of their
supplies and provide consumers with inconsistent information.

Limit the propagation of the voltage count and list to switch
regulators.

Fixes: 26988efe11b1 ("regulator: core: Allow to get voltage count and
  list from parent")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/core.c         | 9 +++++++--
 include/linux/regulator/driver.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9403245503de..178fcda12cec 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2465,7 +2465,7 @@ static int _regulator_list_voltage(struct regulator *=
regulator,
 		ret =3D ops->list_voltage(rdev, selector);
 		if (lock)
 			mutex_unlock(&rdev->mutex);
-	} else if (rdev->supply) {
+	} else if (rdev->is_switch && rdev->supply) {
 		ret =3D _regulator_list_voltage(rdev->supply, selector, lock);
 	} else {
 		return -EINVAL;
@@ -2523,7 +2523,7 @@ int regulator_count_voltages(struct regulator *regula=
tor)
 	if (rdev->desc->n_voltages)
 		return rdev->desc->n_voltages;
=20
-	if (!rdev->supply)
+	if (!rdev->is_switch || !rdev->supply)
 		return -EINVAL;
=20
 	return regulator_count_voltages(rdev->supply);
@@ -4049,6 +4049,11 @@ regulator_register(const struct regulator_desc *regu=
lator_desc,
 		mutex_unlock(&regulator_list_mutex);
 	}
=20
+	if (!rdev->desc->ops->get_voltage &&
+	    !rdev->desc->ops->list_voltage &&
+	    !rdev->desc->fixed_uV)
+		rdev->is_switch =3D true;
+
 	ret =3D device_register(&rdev->dev);
 	if (ret !=3D 0) {
 		put_device(&rdev->dev);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 37b532410528..3c3786df044c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -425,6 +425,8 @@ struct regulator_dev {
 	struct regulator_enable_gpio *ena_pin;
 	unsigned int ena_gpio_state:1;
=20
+	unsigned int is_switch:1;
+
 	/* time when this regulator was disabled last time */
 	unsigned long last_off_jiffy;
 };
--=20
2.14.1
