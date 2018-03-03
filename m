Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520121177-2-18038844000082201693
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
    t=1520121177; b=g4AilFgFByLeOaw0ZzIgDI560xca2HxGGUn7eqjI4Yilvxs
    7mDP9LHZ+bKc3YZd4u6s2dNU6xsaSg02RyM8obfJFYeQsDvUyl7YrduOfmRDgn3G
    BtOyAKPDXo2B0pyEBdgOKp5PdKXHOu1MeFOYo35mVr78Sm5H/TIUcsDoMTywrchU
    5uR1uVi1CvmxZJsZ1NlrJPaRbqoNrTelZHRUpLnB+AjibfrjbnMfk3/HQpY+3Abb
    URRsU6xgeuuk/wrTWriITBX8kbnoMLfrAsx4cn36IMYSwda2IqPsq7fwFxn/8WKH
    C/CH96X/OpK1hIZSWsfaWU/B6Q7wvWc7VvlQTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121177; bh=Ge1fpX
    2Vposo/7ULmO57QNXz7UGE6lRom8nfvb53MwM=; b=JP1M4xG6XWcVTZ90CUQbfA
    PqB7WNQzSKO1Dkw8wryBJEaOGTCYmq9IzSjFxzl4zsrKlFRNojFNNxk9uzymC0tn
    TmayiD1Zkdzf/a0EbnEo05meyrbMgFfGd2ZnihgMv5esc+AaZOjq5/ENk2Ik25zv
    nJ9AbumXIxn6od3OwkVS3nvz0mKIhxEqe+5rQidVh/z8iWMfm9K1HO+5GJbuUbjL
    1E6r7s5fTsgKiK8L7euTrrkzfcJ8Hw1kxceGs/IDmr0nzBuokFDamVn34SaWMAAL
    8LyQiCY+OV2xLKCl7LtOZ3ja048IoTYajaOM3qea3rCQFF12ZDlIPgvlekm+wKGg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AIZmvqcX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AIZmvqcX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeCCXwu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:52:50 -0500
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:45280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933934AbeCCWdD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 076/219] bonding: make speed, duplex setting
 consistent with link state
Thread-Topic: [PATCH AUTOSEL for 4.9 076/219] bonding: make speed, duplex
 setting consistent with link state
Thread-Index: AQHTsz767QmECbfWiEOzOTuBML4yBg==
Date: Sat, 3 Mar 2018 22:28:39 +0000
Message-ID: <20180303222716.26640-76-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;6:N+U9rdMuRXEPcrpLF7gALg2G47YgNfHKAKm/9YVRH8oLlM/9QyvahjOAz3lnYewA6zsgIb1bSeh0ztOF5NHpLQ6a3y/3h2+TyYtvNsdpehEO/SAftuTdaQfZIYca1zlW2eg83UI0XhWboWtOdE/9kDoKStrlB/6aqu0v45D/av33Z5V55VoCu4KxsN8EVmvpTXU1fGcr5FViYvNm1JOVn7dyQZD+X4GDAQs+ljJnqtInCAMhuXeis5N4GYL0NNBynSiq9qDMy+55OfGc6bySmjd6z8JOKU98Kq842MpFf0NqWuTbm9meVCz6snWNJ9ocHwR4CGZyCj97uKwK8XPeSim7uOy/FrYX4T6ynsZQnyPNfMx0Z+Sq3p+XZM1p2Tc2;5:MVuVZl7m7vkOX5zv+nLTWcJSxLk8PMGIZDb/o+7druL6mFcN62ZEx/t8I6RMcyIb/uyN97mKkLuPBUwP7wv84AL/AlOretWWsjoz6tvHputmPta7iE7+x1D8u4YnpHOLgqMdnps0WwmTiev0q0jW7KHkgfRluTkxTog1Rf45bZE=;24:hpkKZlwb7DeK5fNyjh7usgQild0QeSDuSOEoRoG2FLbao48CUsOHks6BF0+dOmGrdfClHAHJR+Ne1+tATRclXpTWRqfoSO6/g8p7O0HrDZw=;7:b3QDyb81fQe45PWos8OVOUtRS3Ow+thl/InbSy1fNIyFwmCANNH0+TNF25ITiei97T7+eKPds52cxszRLrINXTWIMAzm8O+dBRaFk8tvnTZ8To/w6x6cZgDiIQI/1wbREGRyw4VKIPtxViQMALK5fRWILazPj8a0FRErrZTr6meSxYTFmsELpK3bXChYFbdWLlj5r3o4GC+rg0h0/gMc/IeuVDC0tRwKPgH9vPm2pmaJhE+xJ+PxIj+YejhBChOf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3163f6cf-ef51-463d-2dca-08d58156b84f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097356F10019ED469E54831FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bA3OtEqR7hMQpyD4Qz9q8nB9Sm1Hr+eC2eai5X1fiE2jw9vlQfsRBQuYPKSWpVGe1V4oVBAWBq+okWuqKxsj3JAFHIcfkAUhX7DKUYf68PQy1Q+8o41BmGiUpdemJXQXo8roLsMrbMqbvcUlV1YYY0MR4NWmEVyC8x1CEKAr0Yc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3163f6cf-ef51-463d-2dca-08d58156b84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:40.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit c4adfc822bf5d8e97660b6114b5a8892530ce8cb ]

bond_update_speed_duplex() retrieves speed and duplex settings. There
is a possibility of failure in retrieving these values but caller has
to assume it's always successful. This leads to having inconsistent
slave link settings. If these (speed, duplex) values cannot be
retrieved, then keeping the link UP causes problems.

The updated bond_update_speed_duplex() returns 0 on success if it
retrieves sane values for speed and duplex. On failure it returns 1
and marks the link down.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/bonding/bond_main.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 63d61c084815..6b4b43319ffa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -371,9 +371,10 @@ down:
 /* Get link speed and duplex from the slave's base driver
  * using ethtool. If for some reason the call fails or the
  * values are invalid, set speed and duplex to -1,
- * and return.
+ * and return. Return 1 if speed or duplex settings are
+ * UNKNOWN; 0 otherwise.
  */
-static void bond_update_speed_duplex(struct slave *slave)
+static int bond_update_speed_duplex(struct slave *slave)
 {
 	struct net_device *slave_dev =3D slave->dev;
 	struct ethtool_link_ksettings ecmd;
@@ -383,24 +384,27 @@ static void bond_update_speed_duplex(struct slave *sl=
ave)
 	slave->duplex =3D DUPLEX_UNKNOWN;
=20
 	res =3D __ethtool_get_link_ksettings(slave_dev, &ecmd);
-	if (res < 0)
-		return;
-
-	if (ecmd.base.speed =3D=3D 0 || ecmd.base.speed =3D=3D ((__u32)-1))
-		return;
-
+	if (res < 0) {
+		slave->link =3D BOND_LINK_DOWN;
+		return 1;
+	}
+	if (ecmd.base.speed =3D=3D 0 || ecmd.base.speed =3D=3D ((__u32)-1)) {
+		slave->link =3D BOND_LINK_DOWN;
+		return 1;
+	}
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		return;
+		slave->link =3D BOND_LINK_DOWN;
+		return 1;
 	}
=20
 	slave->speed =3D ecmd.base.speed;
 	slave->duplex =3D ecmd.base.duplex;
=20
-	return;
+	return 0;
 }
=20
 const char *bond_slave_link_status(s8 link)
--=20
2.14.1
