Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A0ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UNVW9XMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6954621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbeITIdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:23 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388334AbeITIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBlTjHTe2PPF6J9Ol80APjKeWx7bXjNITs8fM/bKJI0=;
 b=UNVW9XMnd8bz8rT06QtnMGbvIFx1yS/oOvqRe5um2Qd1EyJ4rc3ZSqU5PH+h7HIZ4+u+/nJVpkA0irCmB4JdZEmvXNUD4OqpW3Jx3yy/uRFLkOurCMisJNg5uSRVdZtVSHU7vb/+s0nqyR7Yp5kYEBzYC9Tgeg88R/B/1PjVnKs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/25] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Topic: [PATCH AUTOSEL 4.14 05/25] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Index: AQHUUIxiTCaNnHw52UW5D30/YBxBsw==
Date:   Thu, 20 Sep 2018 02:48:17 +0000
Message-ID: <20180920024810.58594-5-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:9QW0TWQ3L6g1IUbutSUhhEV/d3yU1IxhZ5QGFggaV99RQQf84yew1iuav43sSCW6P87xDMU5HwJDiAJA3Q4ezpa98jkyz6h3u74a8Ak3G4dER66KjNooIB7ZMDtVrSwrTO+Re0r/wqvj0n9hRj62MKpsPjZWlc3KNPc60nacYxvzTA1DGS1aCDgpt0xat8rkdKmsbBalkdQpX76u6+WV9PvBjAZ3DKqlnEfX6xtPpM3BRW/3mB0amuCeLvcapL9m4f69tZrnhU8Ym1kcCeZ37IWaoL0XQrcyO9+zYw3bbRhqCZ+/OhNR1eq2GZ+FXGL59jLGi2N2QVDz1eKNAVTColBVlOrXMEoOxbD+70YByN/akXi6jzvkbBqTdZpb1KCd6tBhboGAPiRcYvsXIabrgBh2sd1b8SNXSjEoDeU5pmsooJrNnwo8HBHRXwGebZrllWZxcj/4uMBmVfjOlvxErw==;5:zBDqZmk14+zKoF1EXeDpwRR3LSLATK7RwgLKLgnq6JgLUoO2OaN5NUT4nwmI7qKSZwHXQKe+7UfGNH9Kf/QyehajJQSQTMdtfCxZpKVsmklz7F9f2cb+XG7J6YP/rw5+lxa4Mj6dyisEXyvI3+R1YInbCTuItTuCBQZQxkmZ+uA=;7:f/qFnzKYdmNrG6UFsUpBeuC6viU90253B7Y5u/2Hko2TtmqQEDmr4GAkzJCmrRpkHC9tkJaO2sJaUlLhgb0s+gsP39QJ03X72eA1fC7fd22D5MpqJwETLjlx8GTrwsOn2fzltbZOQ9EN6C+SoVJr1uFkCKvkK/v4hw63LIi7fo60tl35PPyZczlXcfQQx+RZPMjujK/ab3weJlTjaZEYA1zwD8DDQXeFWKJMLbAQjbhMOPocXOMp5HC+fwTxAGdM
x-ms-office365-filtering-correlation-id: 589457e7-27b4-48c8-4acd-08d61ea3a318
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119F7276F5BAEC739D0F710FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(39060400002)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uZnX1k/Y0RuGJoqmHXQ2OmeDzKCMLgm6SMMylKbKbYBgOEUDuaet5JRaYuvMqLP9BJR58m9rqsNkFMThJ3/OPZV2TDHDSsrf9grwxrkUTo3GVv6Y7/5PcZLhLqsYcZxMfdLcSfO1sKYQfHKRgz/PeQb3ZxD1xNOXlZTfE/Pmzd2ZCULFqmKxRk7dLL6/IhGeZ6S0wm4qA75PBjgi6mvqGI2e790HGdkHTQRSKMPWQChdpleZQQbvxfzzTViF5bEnT4qkE2wG/XqMaQnMJPcnlHDpND/Hutf07w/DUMISzkELmnAKgw4gfcQLN3M5hmOpasFfNa/9MR8sz+Im3swyjAfAcd0YDN02xeTupAuuiCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589457e7-27b4-48c8-4acd-08d61ea3a318
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:17.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index d04ec3b9e5ff..8a70b57d129c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -278,10 +278,13 @@ static int of_thermal_set_mode(struct thermal_zone_de=
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
