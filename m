Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682541-2-13296854462914111682
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
    t=1517682540; b=hGKev4tAH7py68boISo6J/TPMADZXfN0bBqZEvOeeM3SwAi
    ehUAjU9U0g8rviFAzEboyhkUS1IE06xWq3OvHi69/0hBv4uNoKIg7RrTJFZFE9zB
    7T0yaq37pyAzL9RdsWyWjbyx1RYqYEsi8BSV+eMllkQz4vh23TFKRlX3Mfj1C82X
    txeHkT1PUK4gQ3ZaB76wnoS+fyFVmAotiE8uPZr6cTEu4n/qvB0y0yiTHFO5Rvq+
    PeIcI37IFEeqNDG1+PSP7dvPYJ0BMfnytqX5PDPIZwqDJOA6PE0/BM67S/9UBzFZ
    637W/QU3M2ruru8zcPGl302XXQPzs81nAc8VWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682540; bh=HIgkKX
    YNN0wm4+PcECqqWd0evx8vuW9n0APaVBWvTgo=; b=Dpt1ppzwDnd8zEyPmXaAaA
    4VCbMg912GmTjASHBe6SaYU2mGz0vcvMIm9cqPmCInxGDAMf1oq2cJEDszDB4s5n
    k/QCEf9ludCLSPY2RQD2kagFMwTUT8MCz6pjKRGaS8rKJbV4YwPFrsGEbbi6JMif
    Tv9OZzfSdX1UxXeLjDEf6QL88SPoT5kOnq0OBeQ3SKlhpgJxfzilIqnZx50a8t/l
    mojNb054RsXoSM+6P1wQNrNvRMQgaSdwcW5NbrU699vVHS/zmcY0YvYmDePQUEpB
    87aAotvOPiIga0Q3KCzKdSrpWVU7s1eOWL8jay5QaqIgLED0MmuA8drfcAk0VmjA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UpYyKXIY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UpYyKXIY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeBCS2z (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:55 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752753AbeBCSEq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 108/110] of_mdio: avoid MDIO bus removal when
 a PHY is missing
Thread-Topic: [PATCH AUTOSEL for 4.14 108/110] of_mdio: avoid MDIO bus removal
 when a PHY is missing
Thread-Index: AQHTnRkH29+EdzzaLE6lRTK9+dWkgQ==
Date: Sat, 3 Feb 2018 18:01:35 +0000
Message-ID: <20180203180015.29073-108-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:yEQ9VYiRpf/sVaoz6uVAdaewgCtypVhdo/3vNvlyrS+6zbUkoVTMzJB7BnisUbklBwReB5cUTedJWwTmhpWpep0MPa/7DtHMo+0C71SQA7SyH6GkB+WzXSYSdaAH9DVFbqxUe0aGLROrG+8naOk0iF2aao58aii5hB1z4g4nbvFC+eIM16tvv6JBS0cDcyVxZSfTha3Fhlb4CylxAQuDql9l2knOP4Blv8rUJy/O2c5Mm9rgtS3ipDQwAp7U/dZz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7273e35-acb5-44a8-331a-08d56b30599e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099356E6C7004CDD3CEBEF75FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(8656006)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: t0FUVUxC3yqSXnMJdb+eD02a5IA10BezvfXyZDRecRWDhqwnaOEbU58xOCEdZqGhJRt0JatcXW64wSc8QKGoRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7273e35-acb5-44a8-331a-08d56b30599e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:35.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 95f566de0269a0c59fd6a737a147731302136429 ]

If one of the child devices is missing the of_mdiobus_register_phy()
call will return -ENODEV. When a missing device is encountered the
registration of the remaining PHYs is stopped and the MDIO bus will
fail to register. Propagate all errors except ENODEV to avoid it.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/of/of_mdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 98258583abb0..8c1819230ed2 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -228,7 +228,12 @@ int of_mdiobus_register(struct mii_bus *mdio, struct d=
evice_node *np)
 			rc =3D of_mdiobus_register_phy(mdio, child, addr);
 		else
 			rc =3D of_mdiobus_register_device(mdio, child, addr);
-		if (rc)
+
+		if (rc =3D=3D -ENODEV)
+			dev_err(&mdio->dev,
+				"MDIO device at address %d is missing.\n",
+				addr);
+		else if (rc)
 			goto unregister;
 	}
=20
@@ -252,7 +257,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct de=
vice_node *np)
=20
 			if (of_mdiobus_child_is_phy(child)) {
 				rc =3D of_mdiobus_register_phy(mdio, child, addr);
-				if (rc)
+				if (rc && rc !=3D -ENODEV)
 					goto unregister;
 			}
 		}
--=20
2.11.0
