Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121650-2-4044245510029059777
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
    t=1520121649; b=M5N8kJPfu4+0S4KUV40LHKatizsZl3wdXMgbhSfx0ArkBZr
    tDqUGZDNTW7I6/K+ZHjWdarY/d9chJzoAaImvupXgcHtJFm5GO+PBsvCDkCPjnWc
    0bm1bS5/MjchtWtUz7vD/0u0Cbz0iLDpvojWcKer5FGCqGbWOssvEkhH5oG+O7yA
    1V3C71JtZ8pbNbY7oZyPJBGGGjwRnEOi4L+cliYj/nf35t8YlWvB6tAxFYH3Wt7w
    49ecY4pIRY3KPy0ccHOiFsBDDXNc0q3UFFBz7osIPL2puF4/0Vdw3YWFw3v1bYkD
    52DY+eGVj2wyBB1MtwlG1YpJk3d5RKijC/8ljeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121649; bh=XKm2fx
    sZCFyGxt/BwmLMXZFolO6n3Ube9kA23RPhdrI=; b=Xol5BiqZntw/bVQoTfbO+k
    2qCL5xIKEEkt6yQk7ALOp8yP6hFVtJ9wYSGmWDXZrQhExni7JSxRK2iFYZzIqqmA
    +miOU59DTKNwVTcYWITwoVLIAgr79fY2oeTt0skF1fJtpmsgbl7Q8y543It7aeHl
    5y8DOMJkLRts9oQkFAHc+uPrw+a+LOXJ+VFCBhgdHRIUuzrCYx/NW6Tm6CigdXwB
    ZvJz9+ct6TFXGvHOUUVAZBn+dzM2YdFSEB5h4LJPp0LGZ/Skssuf/n5PSa4hDXbi
    gTPOwkDNL3wapPtXNs8mTvLBq2w4U0lvD33jJuCH8WHwsunuP4Sealh9msGi/fZA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/7g6z8B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/7g6z8B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbeCCWcH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:07 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933465AbeCCWcD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Steve Lin <steven.lin1@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 039/219] net: ethernet: bgmac: Allow MAC
 address to be specified in DTB
Thread-Topic: [PATCH AUTOSEL for 4.9 039/219] net: ethernet: bgmac: Allow MAC
 address to be specified in DTB
Thread-Index: AQHTsz7tQclT7p7PFUycPori/b2SIQ==
Date: Sat, 3 Mar 2018 22:28:18 +0000
Message-ID: <20180303222716.26640-39-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:FwyXglfAJ0SwRTXYlnDAuckxEHxD8B4Q28HOsbT07t7rOC0WwHh8Awe9xXGgSgPA4PC8G8cIKO40DesRoVDZogJYBAL4xMVF/hJg0G7FET2ZZIYbSqoZOBw34wEFaqJ0qRwT4t3annEcU+LMNoLNTJ3PIWo3eOF+Tmf1flsTlDqPVjkHwmDMMb77gZ6dsKQNy5S2WLwdiGYbVpniyX92lsonzApkI0TnaC2mwk9XTavn+YvxsYpVCwpEoCyX2nUgQPd3pu7h+BD8crALleD054drlyRCG67CDuKCEpCekshr2Dj/GrT4KIighOD69/Po3YgXEFZ9KqvFk+XWSa+wXuhDy8qXv/GnN8YdiUQNTSUj3QSF8+ERCYSSZJjBlIW5;5:wZzTYqsz2EjkcX0lmzTNNlLja/ZEdBxEZcyUWSaKmy0BoGUagtQRMA3DSwOHikzHsiJGpN/oGJ4ng9cXlOho9lMHmiGr0r2pLQWExznwQ8QkwuMU2SRn7d4guGyjHWi9DdweyR5oS2vv4d1h5Dt4ulHsHL4FGs+ASUWjo5AtW+A=;24:PyTMcOq3x6s1QNvc6XAbqgTpl1zSln5UupJYOoseMwXfuD04ax27ewgBNSAHpdVNNlWxOp2pPQzsEUcU6mfCxRmT3NH+MfuOKhNoNVlvcEY=;7:FblFFG9rUrZH06IA3zrwNdMubJwL75EYReLrptyL6S8AJfxVozVkNRwZkWpz7LR9fZxBsXw/IOHUZYhQ0vUJWgvLZgJ8iqKyl2yKD+WvN9VL50DqPJuTI1BXgIEz6FJAzckXZSgFj2pNKDUE6O3dhQKVwNIbDiqUugsgFRfvTRn1HTdHmm0mov6gALR2Oh1geylJF5gQAIAkyJXoUSoPURKZ//OIkwXI4xIEBzwiuw55hqmE4XFqn804XnU57ZtK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbd162e2-e9f8-4025-4487-08d581569524
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10835740E077DC34D8C7CDADFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(1076002)(2501003)(22906009)(217873001)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UITUat9q98W4JXD5mlKjSZGoaaRFfkp30pgtCrRXWYdyDn2fqTeL5DXrpl/x8aJt1QlVy84GOxzrKA88NKtvCLy/7tkBrnG2C5yqM6KA6XUY9OVL9w2gz65EI4n1YTpSg9wJ4PI/tlp/WEYRef94pUT8l6twR7bn9o2gl1g3Klg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd162e2-e9f8-4025-4487-08d581569524
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:18.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Steve Lin <steven.lin1@broadcom.com>

[ Upstream commit 2f771399a3a2c371c140ff33544a583c6fbc5fd9 ]

Allows the BCMA version of the bgmac driver to obtain MAC address
from the device tree.  If no MAC address is specified there, then
the previous behavior (obtaining MAC address from SPROM) is
used.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bgmac-bcma.c | 39 ++++++++++++++++++--------=
----
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ether=
net/broadcom/bgmac-bcma.c
index c16ec3a51876..1ee11b600645 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -11,6 +11,7 @@
 #include <linux/bcma/bcma.h>
 #include <linux/brcmphy.h>
 #include <linux/etherdevice.h>
+#include <linux/of_net.h>
 #include "bgmac.h"
=20
 static inline bool bgmac_is_bcm4707_family(struct bcma_device *core)
@@ -96,7 +97,7 @@ static int bgmac_probe(struct bcma_device *core)
 	struct ssb_sprom *sprom =3D &core->bus->sprom;
 	struct mii_bus *mii_bus;
 	struct bgmac *bgmac;
-	u8 *mac;
+	const u8 *mac =3D NULL;
 	int err;
=20
 	bgmac =3D kzalloc(sizeof(*bgmac), GFP_KERNEL);
@@ -110,21 +111,27 @@ static int bgmac_probe(struct bcma_device *core)
=20
 	bcma_set_drvdata(core, bgmac);
=20
-	switch (core->core_unit) {
-	case 0:
-		mac =3D sprom->et0mac;
-		break;
-	case 1:
-		mac =3D sprom->et1mac;
-		break;
-	case 2:
-		mac =3D sprom->et2mac;
-		break;
-	default:
-		dev_err(bgmac->dev, "Unsupported core_unit %d\n",
-			core->core_unit);
-		err =3D -ENOTSUPP;
-		goto err;
+	if (bgmac->dev->of_node)
+		mac =3D of_get_mac_address(bgmac->dev->of_node);
+
+	/* If no MAC address assigned via device tree, check SPROM */
+	if (!mac) {
+		switch (core->core_unit) {
+		case 0:
+			mac =3D sprom->et0mac;
+			break;
+		case 1:
+			mac =3D sprom->et1mac;
+			break;
+		case 2:
+			mac =3D sprom->et2mac;
+			break;
+		default:
+			dev_err(bgmac->dev, "Unsupported core_unit %d\n",
+				core->core_unit);
+			err =3D -ENOTSUPP;
+			goto err;
+		}
 	}
=20
 	ether_addr_copy(bgmac->mac_addr, mac);
--=20
2.14.1
