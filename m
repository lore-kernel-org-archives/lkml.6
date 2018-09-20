Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D821AECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8E21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L5EWSs+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8E21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeITIbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:09 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387736AbeITIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xIluBZbK/2yC3yIpGZsaP3uSUah3OOAjFddpSCjcdM=;
 b=L5EWSs+e2sl6LIndkdKyLeVdV1FgZeo3TTJw+yWgYoCbrx8JeS2jEsWsvVyjEhtLgufsXRwfpZC5ByVdW7DYqRU9+PAIflv6CVgUJjzblzzc4JktNFOl0IXeh+uaJ9LnuogRb9RZTePQ5ofwPC5BxHwkAA0RyrzzZ0FcOB56yHs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:50:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 1/7] thermal: of-thermal: disable passive polling
 when thermal zone is disabled
Thread-Topic: [PATCH AUTOSEL 4.4 1/7] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Index: AQHUUIyRhucQLg9wlkSBr+pnIAEicw==
Date:   Thu, 20 Sep 2018 02:49:36 +0000
Message-ID: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:HBMqoAkK/dOb726F00j19kOOubFUeeuJqCkW8e+CeC14FseXBAymjQud764F9N0tMyuIPTUuajdDxCbXpJP37hlqit0UZViODFIsRQ/gPDUmR3T91Z3ITI0BS2DZktBVwXIa5FpPIEVa6H8QKbpBBn1IagcbLhcP5RbzeEJIwnqX3hs0GbLXVEjp+Uj/OX0HgiBbV4OywehqHlU3g1tartiSGeGxhqhudYX07GyHe69DuI2JOsLmvdLSMegb/rGKwSCksBO3fgSWPUxbyrwD2/UhyXTchygP+cE9tbjicGuAWqkRhogWVV0uUoD+QmG5L2g5Z2XNn4lrRCYQDEnStMHIhL9gDdlbHP5tuCNVI+sgGlcMhlsmA7wcSVGOp6Ke/Ukcz4Eeh7O4UtaXCLIUhf4HeVqfpEX4HkPc5nkOfg4A6ArVYbBahncC30I5I8+qZzI9bdvXn1En2mcEZYc7rQ==;5:NBiP3MhpOh2rbaPTCC306hE09YsGzxIG0X44OunV1Faz+l07sSWoXPNDP+sJ6I1BaN3PwRmlExjPd+9bjVkltU8n+zoHay9Z2i+Fnc4R81TEoOb3rS2sKhWhGIy5wVWRnvkpJL5yFyLO9nPupNwqjgb8fKvHLuDxRd3ItxgUCgc=;7:4T5bePNpIP5jY1yTbM+afVPSClAKsdFQdUDIk61/N3hNgre715LetXRBtqZxCwklKEXIkJlyPDcCZim2OdW8TbKsJ2fdbqyuZRXWNFE3d6H2PRot6GzjXEa1O15CuVaKMntWr9a4cxU1ssw+w50vsrJ/eu/Uu73H8QXUwQ68UHWdxvxZ3dadcwxsWaEg/7fU8olxEkSStSyB0W4Mc2Xrbn2JhwY+oA0ZwW0THQzAI18O6Kyd0Z3NR4P0VmCaKsT+
x-ms-office365-filtering-correlation-id: a584e002-d634-4238-5200-08d61ea3c03c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB04699779A0C5E4184DFA1B6BFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(6486002)(6436002)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(39060400002)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kxuknvoWJNbJH7ofPJ3OPEgBVAiMUVk0PN+S0X3k/nSESUY1AmVeJ+zFSwL+u3Q8daJQlH0DT4U000YAtw9vJMg/YA7OAeFlxlIEzpdocUl3qz6YmG0TdQn/bPfe0O7KI+oTcrONdVHMLCzc8ZiP3u3K/2IF3UY1g57hoSNEx7NxpMORhmPt6oVgRBPlHrdaGbkiLieZ5mA9v023li/nUL4CnrLGsKi/KYKjhkRG1dmMRAn+g9yuh4eRq1sLmF4C1A+67PXbGaLKsPGZ6ucyIMC0qorYq6CPmo8Hwksmf+BHXgntO0FGyo9QxkuKI32HCQKcwts2ANXFCe/vsikoHPjhJna/hSD5wpz/b8OOvp8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a584e002-d634-4238-5200-08d61ea3c03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:36.5218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 152395fd03d4ce1e535a75cdbf58105e50587611 ]

When thermal zone is in passive mode, disabling its mode from
sysfs is NOT taking effect at all, it is still polling the
temperature of the disabled thermal zone and handling all thermal
trips, it makes user confused. The disabling operation should
disable the thermal zone behavior completely, for both active and
passive mode, this patch clears the passive_delay when thermal
zone is disabled and restores it when it is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/of-thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index be4eedcb839a..236c4eb5cf78 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -284,10 +284,13 @@ static int of_thermal_set_mode(struct thermal_zone_de=
vice *tz,
=20
 	mutex_lock(&tz->lock);
=20
-	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
+	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay =3D data->polling_delay;
-	else
+		tz->passive_delay =3D data->passive_delay;
+	} else {
 		tz->polling_delay =3D 0;
+		tz->passive_delay =3D 0;
+	}
=20
 	mutex_unlock(&tz->lock);
=20
--=20
2.17.1
