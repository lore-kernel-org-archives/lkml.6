Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0093CECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aOADfltx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeITIdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:01 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388384AbeITIag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBlTjHTe2PPF6J9Ol80APjKeWx7bXjNITs8fM/bKJI0=;
 b=aOADfltxNmBrV5gndrD08TBNtIRodj4MWU/W5Fvn+IUYlSLsSWStAP/E2KIdgneAVueLEUVmnEuZGpzpYsFLUULVtophk3ae2ewWM2o3nzQ1JqfS3UXiAFdaYY8rI2B0w6uKQsnE+pjxJWpKO1thipqn9YNZIcDX9XV5AJrsQqk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/14] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Topic: [PATCH AUTOSEL 4.9 03/14] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Index: AQHUUIxyNFlragHNtU6PCyU6SMIz5Q==
Date:   Thu, 20 Sep 2018 02:48:44 +0000
Message-ID: <20180920024838.58666-3-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:FwZ01bQEEO1/2t0ZkGwKFzLw65NbfU71Y0k4QYtqkRHHDJt2vZmGTTaX9jjjT2+cc2eJtROKotl5GePCLxTuVIv7qkDoGXoVMd+5oa2okcWP8TlAFhVcOK9ixY/UXjdFNOdsHcBbpKSnGtzznhYeHHpZKCoR/0j5z4yQe1gETemVFMSO8eq9SXgqxAlVvOX106GSgSAUD9C5PoFZZoSoj7S+vgdYe9+4PMpgNuQMmbzTbwSl0XxULWg9BIFW1rglpEI40ZOtBMLz8SqddV4nhdDk6VwX0j0hRy2IQVqLgmLNcNTe8N+SZFU5b+myrkZDng4SQIasejfXCg/0b/jbo6JgAoZHo77SWDascRphur5XIRnYrCyJGG3yUbXvuDg7bV2xhrSzgCDHav9LHTRU15CwDFcFfDtFJS2IVD/GPvNvdMimr/gXzQgtwep3MVzCiRz5mwyQoMUF4LV7jw0+uw==;5:GiODYxO+B8nSbDGXW+6Tl5rgwS8LmZoEILpxU1sHHGAasmJbIol0WFZGU0I1no6uZOTrhTReSgBP0lYR3JeUlz1h8xhTDDLj9OLT2ha0KpALxHtewRZoLmpGJqOt6kBhIZJWGNKPR4O5d7q86I//7hMPx1nqZ+0TL7U7+y5fVmE=;7:ys4kS60CTqnBVrFsFOY7knZj21H8lMlAMfb2Ej37oDXOBZciRb7HyVyLUu6Zy6L1ykmQTHwfFcfSOd3ZxW9wuXob6fenDR3evqZPHG61pguN5N7CWcyxysn52a20waPmN6+kEb0r57h/zIohLdERBh8UORowRZ+hchOGT9fRSuwGGgiJchRpoAteuiwKXZeFkIVg1Ild5i0rGQCInHN/Rs2fm3/R5UbJSrE3FhHBP08DEYdpfbR4JZo7ec1iCYWG
x-ms-office365-filtering-correlation-id: b412297b-af4c-4c01-6f8a-08d61ea3ab1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07445AFCF72294E640D7490CFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(39060400002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RMuiCIN+RAnQNLBGoHn+pJzKDaLJRw4Y+7ojOx8ITNAifC6O+aqUoXvJCcsWrvWBjGtUEfr8sqZ2Zs/hs/00x2GJFqUVuwumcD7KszawG17o+1AAJX+3xOMioC81NgVNhVIjXDrQcFvvp1/zYJje9Bk2h2BHtRQE+ClFwU7e1IIi3B5IiFlnmaJxg6xUhdrGdiInxtlluHjzYxVkJnc7SAVai/M8LdWnocuuKblwGC6vVT7sXpTeQEmO8OC4W1wwUL8F07TtaEVcuiDpMoBZ7t/64OaQ2/ZOgaKnmyfdjWbn4bf54S61UCgODB+RrkA+yKivCJh6nEF+rCZ6e4Z80JMib0BNrxtNVtfjjUaim2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b412297b-af4c-4c01-6f8a-08d61ea3ab1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:44.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
