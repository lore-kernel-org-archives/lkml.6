Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1455C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CCF20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fHQ9k1EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CCF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeIBRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:21 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730229AbeIBRcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp9KxhUg3Y8USdVJtexrfzGO/pOAm84Pt/yMSBVitoA=;
 b=fHQ9k1EZZOgWVWi2IjyuxKlXOG+9a8gvXMbiyEVaQJAS0MVHwO4GNcj8iziy1r+nNTq/nyb49USqG4fpGsubZ67b4DdFuUwUlY0mH3V3E9nby+5+4PJG3yrEj3Bp6mbx+03RfKzxgmzjx2zK8l+Cmh3LeySquL5d+LyRahqv06A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 30/47] Input: atmel_mxt_ts - only use first T9
 instance
Thread-Topic: [PATCH AUTOSEL 4.4 30/47] Input: atmel_mxt_ts - only use first
 T9 instance
Thread-Index: AQHUQr8gZkcVUT7wXUK91sfQ4+WNDA==
Date:   Sun, 2 Sep 2018 13:16:15 +0000
Message-ID: <20180902131533.184092-30-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:Lo9Fw1Dv8DFRpAU/4N8IpzVDTVQiTlFtHEW3yqjT+RmykOARpVLsvKKO1LDVjbZ0md2UQWWjA3Bk29Ke3l5okVrzUG2GXYLro36mTgFSZrFgzoYBYkC0I8Bx7YiqROkSjMVtpi20UhrF0mqWDwx6fpgOSxTV0CYtj8zAli5zZz8POCm7VTCGApSI2/RFH8BlPQ1du2JgucP+lHd3AdCCetmAlHrymj5/CQuYm2238tee+JFbU++YIhbTbBO0DCmu6Ue9eRMtp8dzXGtIP3zlXLOYI7PX/hAXQT2jbAHDQAo/9qWlw2jomyBYleS1zNq+ljaBn9FFkqzQsKXxUfkUxlDOHj1fJAhdHmaRI89Klq3CCUa2LeVC9qYeggynJncWwBF9KFNGUfhrajz9wSPAdGIR/PsqgXzULQLfl3sCqyYHR1R6/BSlG+I2E2uMlbkMU4C2PoN8n3uqcAkQlp2v4g==;5:4EJZJf+PXlHwpYxNQG2zkHv7V9f3g0/PMFjvWiAm7pH2s5/xDExRx7LBKteELADo3fcrDsFQg/NXBY66dSJJbe8I0wPo8mjT9dZuvUWnz4CfbvPJCdgZLW8BaiP3vJDpPuk2my/vBF1Z1WutnAYqYb4N/547Az4frirMP5u3pR0=;7:LqAF/0hMVXdaYjse1AGmCFJ/KjbDZRGdxqRnMdfL2Hto/l6zuzz7wx9TgFPKHUZN1+NzIodFUekIF9RSoqz96INe1NYz+Y3i3HUGOqibOFpQm0hG8HNSudjgLMdNYRjkZYvDYepz7IE29qrVxroAslYdypul9nyxrLIIOE7HTnya8WDn9IM4FA8RRdedaeh1ijk1iGOH8x32CO+PwskpTTW0tWgPZDVA/eCEspudUeKjepRRM1EBjj9nsBpoDoFe
x-ms-office365-filtering-correlation-id: dbe36030-3af2-404d-32ce-08d610d64a3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01677EE940CBAC83DB6A6AFFFB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(39060400002)(107886003)(72206003)(14454004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ITIWngXkUHf1d+47ZuipY2FpuMxE6xAJIHpuCXZlW/Lrjbs/dAlBzaSfXQrjROObXhdJRoyGWE0jLnUJlDqLmaJC1zK12EuSmPPRcuybNLFu8IQ/Tmg8T/Fjw+bNKKj5Qw9qHIRatV2yL//2nz12/N1nkz/MI4ejGe5RxOl3tkBFK2ivOseMUYLnUm7C+2+5j7qaTnLYLiF+kYHTlKyT9VmJikTgkyRzMeiMcN7HpEEiPp2glBIjGgtvYaPYUpQRvn/bUsw1KovWFqq5USveT0PhNd1ZOIv+rJbtWEx5ioEvfaHfRrr3JbMNOSU6svQb+ut501tqcyqSBe4uI41ZKBGo1LraG0eFTdLTFnaD9is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe36030-3af2-404d-32ce-08d610d64a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:15.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 88dfe3008cf4..be2f2521c1c5 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1593,10 +1593,11 @@ static int mxt_get_object_table(struct mxt_data *da=
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
