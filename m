Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC6223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jdLmw4se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC6223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeKNAqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:09 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48350 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeKNAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:08 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="24037884"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 07:47:39 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 07:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l94fd2fl7JBUXNXOZeNFXqrFXRqC3K4dL+tXvdenobg=;
 b=jdLmw4sePebh1qQle23CXygSbCxtDyq0//rFUbv1iozlFqJ4vrPgmWZkjPzE24EjN0W3KKeLYWLmAD2+BIioxi5PeCV8brfu0Alpkvxz4tEPViEXgiIEknJ7Gzp9RNskVeBUCH6MT3ULvcLLcyzTWvHnUezCeNNvnhZS5sjhVcc=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2131.namprd11.prod.outlook.com (10.174.112.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 14:47:37 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 14:47:37 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 2/2] regulator: of: add support for parsing
 regulator-state-standby
Thread-Topic: [PATCH 2/2] regulator: of: add support for parsing
 regulator-state-standby
Thread-Index: AQHUe1/RTNGLjxpY00iad5mX/0ny/A==
Date:   Tue, 13 Nov 2018 14:47:37 +0000
Message-ID: <1542120469-15450-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1542120469-15450-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542120469-15450-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0057.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::19) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2131;6:msiURQ6+/pX415LKSndqIrnftmv4Iu66/NdCi/P/kinlXHJyzoKsyu0V41EB05LWzr/GhjXoSIG4Vm1pSXDp86kKGbEnNQFua4ZiNpbzLUbJZhM9y0scfCGmlUMZPtNCfH4Vzf9q85z1us8YOc7fs1A+XkrtTJjzTweQ0n18ZRDmzRReWXDoBLcAsYCjvMtJd+P+ww9ybcJ+Udyy+ZxaMGXwo7FPHRoA6WwmwHpyWvSrBeEQLaIGpums6qziytvzXUNtfVXy6YAkhNBLeszNOZUtnau7xYPv1ga85ikE6Ej+hwjkdu6/xDxnna8wsC1+d7PJuI7Hc51u9RB4BATYy+hNWdUqhvTUyL0nkXpBTdZgAjoqV4OAD0JzZGCNPDIW9HqCOJ3Lj7XOha3tJ4uJ8yUyZM9h3WyPs4xMZD4V1GoML52Lgwu6zVGMkpIbfNiunF27cyPFYKPOmvG//Od5sA==;5:kOQYR77HKI/oC6gBi8M5NrIAnIMUiUmDXouzYU9zo79fJIJCcDzyjzn3GH9M7zBtlP+nrOJy+PV5H3p6C6jDnRwa3CR/wMyEDVAvMmQWMNSH+tEY7L0gGD0KMxEWG/T/FXdIwewT4sH7MUdwTDU6a5NwCdXApkgHXtsAwyF97zQ=;7:kq8gBuxT0FwZ/WTNqS5JhVG+h9SGUaamiQ2JTx0JGLp2AxcU77vBmwKqBOyIeqxCyR2S4g27EjSjv6fYmQ6FpA1LTBRDJr9diAGIsrJBhLXWyNP57CpCi5oUfQbenWh81H1E6Fhn5GjnCAfVUA2rbA==
x-ms-office365-filtering-correlation-id: e47c225f-cbf0-4c1a-1a5c-08d64976f42e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2131;
x-ms-traffictypediagnostic: BN6PR1101MB2131:
x-microsoft-antispam-prvs: <BN6PR1101MB2131154905CB10B29ABD5865EDC20@BN6PR1101MB2131.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2131;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2131;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(39060400002)(2906002)(446003)(110136005)(11346002)(54906003)(106356001)(72206003)(99286004)(4326008)(26005)(97736004)(386003)(52116002)(25786009)(486006)(2616005)(6506007)(14444005)(76176011)(476003)(105586002)(102836004)(256004)(478600001)(3846002)(6486002)(86362001)(575784001)(6436002)(8936002)(81166006)(66066001)(81156014)(107886003)(36756003)(71200400001)(71190400001)(305945005)(7736002)(68736007)(5660300001)(316002)(186003)(6512007)(2501003)(6116002)(14454004)(8676002)(2900100001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2131;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /ZEkIaJcFFS6hXn9fkB/bdKNBmUm7JBna0CS9I4LxVgZw93xVvBRMWVWUa8eTpt59AXzWA7kpCH4v5vD6DjoNEqW1qgFplYkrvsnMIRb94zcufp7JFqKgRoZhG0qfciliF6h8yBB189GW0w0KMXjW+9Nv0bLiF9csa0kcQjYIiDznWi+SxcSHXBCrdYmbitLgVw5SnmRUSHDbGzXbdbauyzg1maVyttD1ck8YqDVUIbZq28+MQYrT7IicWGYCFWdkqFLJaix54PO6n/2oMdJQuf6W4Mf/BgPUl5UTkve+YbP0HegSa5/mXw/7HBtAS4L21d+qyYt4Ft0F070AlJwPiRi7Wp2USrJfyf+tr0Kl0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c225f-cbf0-4c1a-1a5c-08d64976f42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 14:47:37.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2131
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the according constraints for PM_SUSPEND_STANDBY case.
Previously, only suspend to mem/disk were taken into
consideration.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/of_regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regula=
tor.c
index a732f09..c711a0a 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -20,6 +20,7 @@
 #include "internal.h"
=20
 static const char *const regulator_states[PM_SUSPEND_MAX + 1] =3D {
+	[PM_SUSPEND_STANDBY]	=3D "regulator-state-standby",
 	[PM_SUSPEND_MEM]	=3D "regulator-state-mem",
 	[PM_SUSPEND_MAX]	=3D "regulator-state-disk",
 };
@@ -185,9 +186,11 @@ static void of_get_regulation_constraints(struct devic=
e_node *np,
 		case PM_SUSPEND_MAX:
 			suspend_state =3D &constraints->state_disk;
 			break;
+		case PM_SUSPEND_STANDBY:
+			suspend_state =3D &constraints->state_standby;
+			break;
 		case PM_SUSPEND_ON:
 		case PM_SUSPEND_TO_IDLE:
-		case PM_SUSPEND_STANDBY:
 		default:
 			continue;
 		}
--=20
2.7.4

