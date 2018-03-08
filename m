Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488834-2-14278982328602779350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488833; b=wARTF5Z0Hg7r8edgjocrJGrgXU4b5ixz2Fxt0yzHOPNNq5x
    d0XsTECTgY4Sr4lt1yaHqJ/aICZ83RToPGclb6PANwlex49k9PPenrBVM9fkWccX
    OLVp7qsQimvsAE2HGspeiqu0JBk9tO1el+3rswQCuJegNCyeuusGypcCqSLv0nbR
    OiHvLHf5zw/KiZhJIoCKssRRTDgZ6w3gLQwF8ZAth+Rpc1EZfMclofLSJm+O3IME
    fwQKcuNoka+P60EXqG20zcF8S92umHcswzD/rbWyasvZLpTJAKGQ25pHQJpHHCsi
    RIIgS94QbaXLyLVuibUHS5kNWfNHVYzwFUBeAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488833; bh=RXjD/X
    CrsJux30HkLrjUA/0zKzTxie7Elt1Cl4ZjGNM=; b=OJlZ5q73VCopVRvdmjhbpN
    o5xuuVxgs5xLg8jsjpDEyz7suWLbwk2xJ6zYbL4LIBF3c8adygsdAVR+7UA4sQ7V
    Jx1sLcN6ZJe0ohyYhJhkLUmBZYyxkTohiXF4XuYhrqXdEqWb8irQD5DESxgIwq8l
    iFBxeTEwNjx0yK7JsWb8sDS5s8qCMRhce2IKVhrs3WGtCRDfmXjQqXJ4jHotfqH/
    5FruIWkLdw+t6uFXvWCg6GQXoq+KRQwPyy59Ac7dHQDiac365z2yLmhp4XzbC1k3
    qYY9cp5vtT8mjlVkZo09+l4LXuoQltMKq/pXgVwk8jU8c9OC8+0BfgqCenzYxdjA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JWjnVCVe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JWjnVCVe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965684AbeCHGAa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:00:30 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965678AbeCHFDP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 128/190] power: supply: bq24190_charger: Add
 disable-reset device-property
Thread-Topic: [PATCH AUTOSEL for 4.9 128/190] power: supply: bq24190_charger:
 Add disable-reset device-property
Thread-Index: AQHTtppIT92vg3crykCr1HzEL0yXLA==
Date: Thu, 8 Mar 2018 04:59:47 +0000
Message-ID: <20180308045810.8041-128-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:6MnlPvkUynXp1m5t6fABcfkI8CHYt9itKhloXbb3KkeRSYYNFdpah5BTKbcD9sVZjEBtR/FlDEZyU1j2Mg9/ta3oeDT4rXlQZLOwotI0JCkL4K/YuZDcxipRLTMumzFLXW2O35gE/8Bhnq6Ko2jC5awoSHTjeyEZ5nRZRNLkpmzNCSo0aB1+KmY6EBIiH5eo4Ok4ED/e9+OQq2nM5nuonpvHyfKKEUstvk3ANL4yxdGOEQerjM5sLb1gJ1oblhSO;20:pTy/nSoc7Z0yKS3TRrIX60V0e23OhWjrd4n+rR8fnfFJ71O2mxdzbjs1Mkjjto0THqXOraiRs3lV6mWcfk6hOKMmVMeXNEjkhRHux4J1ArDoYt0IkKwevQnRaXWEWqn3hMP9NDFFeo37uWS6MSvvxOzUdVDenluJrOQ9h+T+GlA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09e5e394-94aa-4f45-a650-08d584b1dc40
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10132F58AE0F5125D2DD3F35FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DgnQaeQ6vS6uMUPTyfbkhj0ZGFiRklxB6W7LyXXEGFKRFo1GmTkhXKIZzQ2uf/rZqqjQ2EUoiwYKdxXtBYQ5W3Q3UBPhK40FS4qWWKiv6HUZZRjKrnFOb7aGfiSJjioEtB9sFgk6uUu8UY1h35V/6ZJYvYOjYiwJaqdRNLYfqR6knDLfh35riPP08DLjwmy+TiMzMydiyG3AZBkQ2tr7Srw5PDihna/mjAhdw/vbL60T9v2SkGHen/W8pXVnbwjWOIpWZkx7uqCTah20bf2GstAB5JxbWdt+wNLohQ1pBXMgHZQtIzQK++lBruK6Dm64weIS01M/lhBkKXpIdC+S4g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e5e394-94aa-4f45-a650-08d584b1dc40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:47.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6cf62a3b97e78ba41d31390e59a1ddc98a9e3622 ]

Allow platform-code to disable the reset on probe and suspend/resume
by setting a "disable-reset" boolean device property on the device.

There are several reasons why the platform-code may want to disable
the reset on probe and suspend/resume:

1) Resetting the charger should never be necessary it should always have
sane values programmed. If it is running with invalid values while we
are not running (system turned off or suspended) there is a big problem
as that may lead to overcharging the battery.

2) The reset in suspend() is meant to put the charger back into default
mode, but this is not necessary and not a good idea. If the charger has
been programmed with a higher max charge_current / charge_voltage then
putting it back in default-mode will reset those to the safe power-on
defaults, leading to slower charging, or charging to a lower voltage
(and thus not using the full capacity) while suspended which is
undesirable. Reprogramming the max charge_current / charge_voltage
after the reset will not help here as that will put the charger back
in host mode and start the i2c watchdog if the host then does not do
anything for 40s (iow if we're suspended for more then 40s) the watchdog
expires resetting the device to default-mode, including resetting all
the registers to there safe power-on defaults. So the only way to keep
using custom charge settings while suspending is to keep the charger in
its normal running state with the i2c watchdog disabled. This is fine
as the charger will still automatically switch from constant current
to constant voltage and stop charging when the battery is full.

3) Besides never being necessary resetting the charger also causes
problems on systems where the charge voltage limit is set higher then the
reset value, if this is the case and the charger is reset while charging
and the battery voltage is between the 2 voltages, then about half the
time the charger gets confused and claims to be charging (REG08 contains
0x64) but in reality the charger has decoupled itself from VBUS (Q1 off)
and is drawing 0A from VBUS, leaving the system running from the battery.

This last problem is happening on a GPD-win mini PC with a bq24292i
charger chip combined with a max17047 fuel-gauge and a LiHV battery.
I've checked and TI does not list any errata for the bq24292i which
could explain this (there are no errata at all).

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Liam Breck <kernel@networkimprov.net>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/bq24190_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/=
bq24190_charger.c
index cdd71ecd72ed..8ed2782d1bb1 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -506,6 +506,9 @@ static int bq24190_register_reset(struct bq24190_dev_in=
fo *bdi)
 	int ret, limit =3D 100;
 	u8 v;
=20
+	if (device_property_read_bool(bdi->dev, "disable-reset"))
+		return 0;
+
 	/* Reset the registers */
 	ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
 			BQ24190_REG_POC_RESET_MASK,
--=20
2.14.1
