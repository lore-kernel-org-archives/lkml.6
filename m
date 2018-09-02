Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277F2C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5320837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JqxVBCM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeIBRao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:44 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeIBRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSK3J22/k0pCMerqWX7etcn4BZO7jrWo6lU9HTIpI2E=;
 b=JqxVBCM98w4hI5WWahHC2b0rIwJPSXZEQ+P97gpGEFiFFCv1VlYy6pMgK2cmQsKGz44/5cfbntqWq4RQtlrvKQPeAPCKravodyRwivTj0m4T5jMpQumMU4jvkvTPeTmIyN8o9VbAFaKJ3hvf1jNe0NYLhH3ZXhc2OxSVLFpNaM8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 40/62] Input: atmel_mxt_ts - only use first T9
 instance
Thread-Topic: [PATCH AUTOSEL 4.9 40/62] Input: atmel_mxt_ts - only use first
 T9 instance
Thread-Index: AQHUQr7wzpP5eIhjFkCVHGQlVZgWvg==
Date:   Sun, 2 Sep 2018 13:14:54 +0000
Message-ID: <20180902131411.183978-30-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:W4JDAZVEGneSBmrp4M1EHUFSw2TXuJK8Ki2lDfbexQz1waBMm1iFvUioQFHdt3lU6U0ytRzepHE683EJPz0S3AWF7RAcwNrjE7VYnK2EFOCXEGInSpYshymbTjkOl/k/qOK1w8MMcP2Ciac8VuMIP6W8rzKABDXTtcHSIROD3aXFxM1Sf7rXy7hr53F+KBSWX340OBygIIpvxqDx1irVcJRaWK2rLk6FEuntpVAIyg759y/uQEBNVmFMXAf3fGntB7CU9RwkysT6LUFXTrr5LVCm9aEcssJ0WzkBbdKRBdP/X9GYLO19Fx9Ko/27Um5qNLM0q7WipoUaPm7gWgz8RkJ1bFZU3OwYuX2SO6aLxsZcXkkkiGbS2LMNVUwd3Y/E/BKgL7BGm3YkaKWrxfKvm1upyWMRTMjf9Do3beChH3sNmbnI2WwICo+gY4v6lG0la4mqLdiivk9RWAbNTPh3OQ==;5:vEllmngYXON+/1BauGmTSHRGyMEd7PwtnLAlUoTuXCMTF7X9PXQILIHXBvmqNjtKpGRgEjNuAGd+m8StTNks0OAsVsFCwotldO4EVC/O2m0ZEN82QUF+rqanuQ9dsIIbPLA21qL0D1KJKF8Cwxu6wWv17ADXcoQgigA8pDrgPpY=;7:g+Qqo8vxZEAlfIbhwAczaWADe5ytpnvgUzXetdhnCkn0M7Bl4v3Vrb/t34sUYvYvMUj5vifgp/4aGSJx4+b9boZ3FhQgXhXBOYXeC09TYJOyy3+E25N06TgMi6fkC02lbXcFSEyjeoVJANXCeoU551MA8tM7/pgr4NFBTipJD17S4mznQNCkoDPb9AjCsULdrP/EtUlicge5l+pMzNoqnEbNUwOm4opJuxx/o27SBNYeoBi79K3JwBCStkTVaJJ9
x-ms-office365-filtering-correlation-id: ca6e74da-5ae5-441c-3a40-08d610d612c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741DD2771FE5FA5AC990FAFFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t8Sz9Efza6gQY2ftAAp2CFgoTVg/InFnk6+WleDDcJC9le412qJ3n9xaI8qgLsOKRDOytaGYMnxJeE4naDdGxP1xO9/ZcMwW1TxRJSvwbQTq+fT2NczOm60y6HHLYrX3yC5adJGfoirh+xqJeeLfRpWWSIyfCueDsy+kvV0pPzUMx4fgLVhHMeAHOaMafpY6IngpyG/CQc8ghWHziJwIP/kiujki4gaeV5rdfUB6mxvFFewYNyGsr25HFDmMCc7wbsPbkol/N8ATsUNORIiFooVGTSABaLdM/l+DfMbh2LsiZbvGRc08+6FAj5FLQOkiTFGNTboEy2BJTkQmbGjStK2yYKHoMSAQGl0Nw+FXmBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6e74da-5ae5-441c-3a40-08d610d612c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:54.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

[ Upstream commit 36f5d9ef26e52edff046b4b097855db89bf0cd4a ]

The driver only registers one input device, which uses the screen
parameters from the first T9 instance. The first T63 instance also uses
those parameters.

It is incorrect to send input reports from the second instances of these
objects if they are enabled: the input scaling will be wrong and the
positions will be mashed together.

This also causes problems on Android if the number of slots exceeds 32.

In the future, this could be handled by looking for enabled touch object
instances and creating an input device for each one.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touch=
screen/atmel_mxt_ts.c
index 26132402fdf9..c2fb0236a47c 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1671,10 +1671,11 @@ static int mxt_get_object_table(struct mxt_data *da=
ta)
 			break;
 		case MXT_TOUCH_MULTI_T9:
 			data->multitouch =3D MXT_TOUCH_MULTI_T9;
+			/* Only handle messages from first T9 instance */
 			data->T9_reportid_min =3D min_id;
-			data->T9_reportid_max =3D max_id;
-			data->num_touchids =3D object->num_report_ids
-						* mxt_obj_instances(object);
+			data->T9_reportid_max =3D min_id +
+						object->num_report_ids - 1;
+			data->num_touchids =3D object->num_report_ids;
 			break;
 		case MXT_SPT_MESSAGECOUNT_T44:
 			data->T44_address =3D object->start_address;
--=20
2.17.1
