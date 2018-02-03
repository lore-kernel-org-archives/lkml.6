Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683097-2-835825969743848183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683096; b=vpREEiEcq3toYPPXkD2wCVq2cIDTKpBcidBZU+USnQrme3i
    l1v19xZ66HD4HFGWWu7/vqkCFCUbLKi1U652nOrvbdFSDtUF2hjd+NfVdOGZ4ZLU
    glGWrjdl7JCOmwLUwRnX0Bic/EF87B3Q8q+7YYNdlhSp09qTT7JrdNYfoSMpS9UN
    uvw6yin2IOf8W8SK7peABz6JJAj4K0BmzI2rPAIxD2XCSp/XdL+Z73SfIbbdM+HF
    /Vi6VC8nuOgJbUo+Da7zBjb7JEmN/vTlJP/+Zj0AST8Tnoz8KVW9ayp17rmMmiEX
    W8/iYmzVCPS2gJft5wYy8mWCFRzsEv9bL5ANknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683096; bh=Vza3LJ
    OYhZgeQHt+KhGtVCQFRmEAYldyUZuiTYdoU5M=; b=P52dNir0jWhO44dc8pDFwz
    zlvEH5u9b35zsXVX9SAP1y79aNxhcX6VIGshG9f9J1+i3fOosagIAIEKCr0+ktx2
    oWouHze34pYlt7hz7e2C3iSYY5LfgGbzTOZQheCtKs9dQ4StlNE15d77RiFI4kFG
    SWLT/qhM3/d++AglH/Dvp0fdVlGcGi+5k+mc4FDqVbYmts8TEfEwpc9V6R7/Q8nq
    8RPgK8LD8A7LLWX8m4RNwylV2fkwPkxzRn7FtueeXITAO4ixKJe4Bkmi2xruykp8
    1gR96QkJXqe8KnBKsYzXXgTXOYv9+a242OYCu9nZG7RpwwR5lisIftXDC4w9ZY8w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MzvVJUSx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MzvVJUSx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeBCSe3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:29 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752235AbeBCSEV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 11/52] net: phy: xgene: disable clk on error
 paths
Thread-Topic: [PATCH AUTOSEL for 4.9 11/52] net: phy: xgene: disable clk on
 error paths
Thread-Index: AQHTnRlRGswHVYqqdk6MMjHYP0haqg==
Date: Sat, 3 Feb 2018 18:03:39 +0000
Message-ID: <20180203180303.8490-11-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;6:MeU6yEj8dYZkHT9GsJWc89JDnx9AYTXl4KuC6cnzgjY8MsaO233dZReK8LtZUtuslBcMnxzCt2MfsNaqfRLQAXIA+3iD4YpxcxH+aMB2m+/EmQBee0Q92PbiDa4BkTH+qwWRUiw7FkKB8/rscQs8k3kyMd8+PeRhhnfavDblkv31GGnBZ6mqWF6tMKBtc6r6/BBIUbw1ewg8flIRw4BRENfvIESs7I2uaCbPpuIwki6WCby9d/uNdhRH9MjpYnJLuFBpTJv+PsBR6AlvpHQ2rCqryJsmrA0ejbT1RNtSKTy1LB6fnVJE3lAoEKZZdi3m5xspbW6Jz4QcDd9vQfS8Z+IAbWPKG8R8fZp01pNqILNKmFyYRup2/EM9LKxidxSn;5:umNr97hQSvBvyHP6WNRPMWpSmEiqTxlIVhQEbmTeKbv9Zw9Zw2lzk5GQNqh2AQE4knxj7Idiy8WxZTh9cXl1O2zGs+sJ3GytZbZGlwgNwX6S9PXz/2DFJZKGN7gxdQRCw+aAqY5pfVY+3M0CorbidJ7BJmQRsJkvgErkv7IavWE=;24:fAEnFPS+8rsuFw6L16vDMeKBzlyKkeNlA765CNGgLqb0FNzUmc7ePiURfqVnNF/6PjIexrmoxVFTlT4T4+Bvq06Xj6A9K5eJ9CYNjJRLy/Y=;7:mdAM8PUoda298cJHxHzmmD41nAr+A9gs8ckGaJz0xYeERNNo0Ua4ovfOi6lf5Tw6j0pOZbiUujrIV6jbU1+cxSQTLga8HuOHbG5R3VNxNlxlLlZQdPooHM2eF6oWG8Ngcw2U7Inh5F3g7M1OPxH6DElqlrzFIZTuK/x3034laaRNZ9P8xfJ+yONmhC85saVvdmXjN51SxxgJX/Lub3XVuYlR4KEIfnn+csl6XptGK2LkyynpHdkbDRQPyi46ptN4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e16481e-6334-4721-1686-08d56b307448
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB109173444FD5D9155218C693FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(4477795004)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: GQ81AXmxGFkpstDZhYlEvUngWklDAeOvlRFH1LijhGAPWEUsisjBCSOFPH8/SxzMuLJtuH0ybKBuzzgMbVpNtw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16481e-6334-4721-1686-08d56b307448
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:39.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit ab14436065c8066c265540312742390d6d07ddd2 ]

There are several error paths in xgene_mdio_probe(),
where clk is left undisabled. The patch fixes them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-xgene.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mdio-xgene.c b/drivers/net/phy/mdio-xgene.c
index 92af182951be..8eb077b677f6 100644
--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -197,8 +197,11 @@ static int xgene_mdio_reset(struct xgene_mdio_pdata *p=
data)
 	}
=20
 	ret =3D xgene_enet_ecc_init(pdata);
-	if (ret)
+	if (ret) {
+		if (pdata->dev->of_node)
+			clk_disable_unprepare(pdata->clk);
 		return ret;
+	}
 	xgene_gmac_reset(pdata);
=20
 	return 0;
@@ -364,8 +367,10 @@ static int xgene_mdio_probe(struct platform_device *pd=
ev)
 		return ret;
=20
 	mdio_bus =3D mdiobus_alloc();
-	if (!mdio_bus)
-		return -ENOMEM;
+	if (!mdio_bus) {
+		ret =3D -ENOMEM;
+		goto out_clk;
+	}
=20
 	mdio_bus->name =3D "APM X-Gene MDIO bus";
=20
@@ -394,7 +399,7 @@ static int xgene_mdio_probe(struct platform_device *pde=
v)
 		mdio_bus->phy_mask =3D ~0;
 		ret =3D mdiobus_register(mdio_bus);
 		if (ret)
-			goto out;
+			goto out_mdiobus;
=20
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(dev), 1,
 				    acpi_register_phy, NULL, mdio_bus, NULL);
@@ -402,16 +407,20 @@ static int xgene_mdio_probe(struct platform_device *p=
dev)
 	}
=20
 	if (ret)
-		goto out;
+		goto out_mdiobus;
=20
 	pdata->mdio_bus =3D mdio_bus;
 	xgene_mdio_status =3D true;
=20
 	return 0;
=20
-out:
+out_mdiobus:
 	mdiobus_free(mdio_bus);
=20
+out_clk:
+	if (dev->of_node)
+		clk_disable_unprepare(pdata->clk);
+
 	return ret;
 }
=20
--=20
2.11.0
