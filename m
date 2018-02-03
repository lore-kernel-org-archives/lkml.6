Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680908-2-8441164583577537368
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
    t=1517680908; b=N7gGevpBFh1VYRrxJds4yatk9pHuYE8+NE+Y7Q6uNSiqeCA
    MMjEbX/2vVZGYJcvFO+Of76c9qRA2iOqOtTAhkVJQQ0HQSKvXaceYb5wReny3GS2
    Lu8jK3uAVxSIgce1TMl/ZC5Zj80l5RMZw2BgPkq9Q6H26UThdkMooCKjRKO1ZOAb
    smdUjfZqrnxsLfjnSOAEHaYGPxcr6VdCw1vOWsvVC6VmFR3/EKZGsmDWI6iMWi2m
    pHwNmQWNlHPZem2aklkt/qqyyYxp3w4UUqYROjO/bxHQSMem6uUMCynVUQXufAMD
    Saa+7qTJEAenp69cj4CVymBIJ0tH8mm1NTgY27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680908; bh=h07yI8
    JWiYkv+870SGpjcIDX/IqcPExI85rWJuxBKYc=; b=vbg5fi044tT+nIw3tF4Esg
    1P2eFJT2LNHqeIU78fmVAAKRWXf4MotHRHMeHx5J77rd44dd3olxAcIFCLNDKSoI
    FkFZyTmOUWesbd17vNAjVkZ7Q8oV9jYEqN6iZ0kOIwLow0XS82HwNdjprecMZiCM
    UXkdHR2lIAx5nGAbRGDWZQ2/dTM5vdaAXeWPDsqUQdOkcLNykDkyc/RwlMoCTMkl
    qPlEBbpALru3suHTIPasgjzpEEZPmuVFGIzoXFui26CNg0u212oQE15v14PzjiQb
    xeOIF/IjQBQGi2O691Pz00gOUZMuYcYIqqTdsSAMHmlEGToj9nBEXhMQ7gFsLj3g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OBajf0R4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OBajf0R4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeBCSBm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:42 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752816AbeBCSAx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 022/110] net: phy: xgene: disable clk on
 error paths
Thread-Topic: [PATCH AUTOSEL for 4.14 022/110] net: phy: xgene: disable clk on
 error paths
Thread-Index: AQHTnRjlzqLOSzPfFkOr+YE9vpO2oQ==
Date: Sat, 3 Feb 2018 18:00:37 +0000
Message-ID: <20180203180015.29073-22-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:o8BeVokveFffom0PzKqqka61yqAkJ4OYNzQNhofHdrbq4rpEmpaQjXtWVL51XCElL0okRyKUumXm+wwOK4xafs4Lm6gGmq6hI5KH0s9k4Vw9H8w0PwPLNzw4MOAk0UQHCRaFOQMUGiaICVCfcIMuGdBZKLfHI9+VSKb8WU8CFdDg5kbZ8XnliySQBiQecta5ZsYg7CaVDRXfZTkK8esmOqpE9eNS3ytNArRmnx9Gy0ogMav1UYVZtcQY3SpJEJtHTjd6Au+8ig9HlgKGvntnzo/dY4/y5mDBqEIPpyPXFqoDhzG4FbrS6a+XM0Kn6iiD1X2jCf+v2fG8ZzXOniUfBDrkXd9kykuvTp0leT8ggT2hUgI8aZF65riNZ0MC/f7p;5:HlwFGegzMEFTArKLd1kkFfSoF1FmGYA5EGf9W7Eu4FfpEMeFfZGPin9jOQNBftfOowRZRWvQFdWOvfe7R1apxxfGjIk9fxY+6Ej1ICPMRNyUn+2l8c/iunqo4np8sAiUEn+VvCYKNk+sIkwRWN+IOZOUsy1Om/AixxQQjIYUTGQ=;24:bTZ4Xele9tdM/QrvWN4nOnlcYLfHDzs0HYZ7dtUPMTEflxJgdP8XayL3t04AIFEmiIDhit4Hztxf0L/53iyV1OXpZ52hU40G2aUqg2qSUtc=;7:yrUwnunnbP/KRvPDdsLKXMQG1T7OxNviJUx+PF4na1WmIYQRy5Ndm1Act78GwdeZ6/9Nd+wo0xKJSc9qGl1euJDVoOh70cnaaVTQFCkrYZ3rEotdOn2x9LKw2hwhb5wegirJhLQKa+ee9EnsfvPgo0DL+Vpq2vk6IG8UeeCMV1NOlpwvle4tXyiQfFbp6jaMs3cpjqDzuMwIEh/fAfhM1RsdpzoNgdOdOfhMyXQY/2pZbE75PMFxdk6gXosGkcfy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54805180-e177-4c00-929c-08d56b3009d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090ADF8FA993BE66EABEAB9FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(4477795004)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 9eERrAOEaCwKUYghODVhapY6UZXt8mIYb0qTaVL0v3ux9fdtpp4GnxP6H06RjPFjIBNY21h5p8zNyI2zW0pUEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54805180-e177-4c00-929c-08d56b3009d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:38.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
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
index bfd3090fb055..07c6048200c6 100644
--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -194,8 +194,11 @@ static int xgene_mdio_reset(struct xgene_mdio_pdata *p=
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
@@ -388,8 +391,10 @@ static int xgene_mdio_probe(struct platform_device *pd=
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
@@ -418,7 +423,7 @@ static int xgene_mdio_probe(struct platform_device *pde=
v)
 		mdio_bus->phy_mask =3D ~0;
 		ret =3D mdiobus_register(mdio_bus);
 		if (ret)
-			goto out;
+			goto out_mdiobus;
=20
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(dev), 1,
 				    acpi_register_phy, NULL, mdio_bus, NULL);
@@ -426,16 +431,20 @@ static int xgene_mdio_probe(struct platform_device *p=
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
