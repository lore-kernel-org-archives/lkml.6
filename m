Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EC9204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fzyrwuYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EC9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeIBRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:43 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAO7KfJ/vx2v2u47QoXlXUbS/5Y7QdT4z/bdEZYy488=;
 b=fzyrwuYd9eOiRacMBtT+UoN8piYYGaRi/auwNIFsPe4rmmD/kwAx9Y6dJXmNVhvO92iDzCAGJ6nJh+JFgXk/om21CJst9IJboiLbx2VmTN5Y5Q7UW5SKOa5LXndBoK9lLLn6ZjKcfNMAWR8DJkGmKeZjRwwksyAyJp167ekRibM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 65/89] Input: atmel_mxt_ts - only use first T9
 instance
Thread-Topic: [PATCH AUTOSEL 4.14 65/89] Input: atmel_mxt_ts - only use first
 T9 instance
Thread-Index: AQHUQr3nqkWAgPI4p0qAvyEl5GN0iQ==
Date:   Sun, 2 Sep 2018 13:07:29 +0000
Message-ID: <20180902064918.183387-65-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:vstfjfHynRELAu39NkfmY6vt1BG4E7XXguTL31wKzbwLLD8eIzMaIjDo+yGmJhrtvFQsDkpykNKDbO1GFC8wSwPCThxjQV/lcXXk8uEjTcu28RQ4BYALmgxATwI9+bUiqZBuIJKlgXfHVE0+GizlxCiRsE+EkH0u+Eq2R1i5oEsPWgZUunVIjvFdsHRqfGYyVBgq6juq+R9fWwifVt+tIJLOMYYQLtilMIWeMnN3fyj++8MNBI8gePw7BdF0ZD/3MW8ms9BnSu5kjm7L1mlVh57NHrjTxhGw2YCS4S51VRTr/CYEFUPnI6ncA4eyB24wYCuWvO2ZkSKaz0MnYsjiTWeaAZzmj9pAhSj+/JzbFtQKAoAKjJCwPAWvVcyu9iNx0fAjXyoYzTHdMse5H7IzBmzwiG/bLVsbLsK2pqkV29S7tYWTylv+CaLDBliunrk2q30tLDLS1o+4YEwC3t3Bfw==;5:/pIaVSE/TQ5S+0V26C2RWYSlRLEfZPW34AqAZ+20/2ORqdH7SvXZJQ0zp2/T5nXqmzinZjoNMmXcmHvp/voRmun/TVSizFmUwhkbs6U9T0YssS/W3l3zcwpGJILzLdXrSSjhww+mPeRT6x1/Wba2CTtYgwKUgIbAkikrWaWB8IM=;7:bP/urFnQQITXkM8i3fpxtdsOItpOsMZXHpvoUyL5JHZZ9IAlY2bZrBahaEBCJSIL+MsDOE8liBsOlS+pv4+AXZwI5wIGo4EFg2jk+RVvZAYcKaBNdfpwSdphgz8BxW5AkKRD5anga+i12bNiKFjPRPUGAy93MvQxOkCuyxBnKAk56yDJ6lDWFVeRGEh8vMeeQr9Ayrc+yIylUK2POOQklRHPltad31HpcNC4YAvzVwLLAJsQHEYrfkUXoXO9iuhr
x-ms-office365-filtering-correlation-id: 73cd376b-6fe5-4b76-f133-08d610d51622
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149D3F1B41C10696DBB367AFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(39060400002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wD2us7tE19HLC9EB335tIQ3jiQ9pFeg/I2Z9KQ+ZF+NM6gh5DniAmXtiR0VuevZN7elLUjW2VdArbpstmPC0aQBhHWDrNjA3xApdiV0oh1Ov9YjY185/bDOak36K90GwqZNshM7sFnPkR9vVR3jQKqDIV0+NzZf0RyT3B9LJfHhcXaKnzU4/mAQ6dCv0eBA68YufPXuoB2bSEu9vhy40OzIq2aDhzoEve8fQzSq9/udPUUAe7R1c9CbPemMUxbsKGL+r709FMnPisBX9NtF0++kF1iytmRlU710O5442KaR8JJSz2/DZE1mzwQX2NhFl6RVY65ia6dUpf9n1gewDj7owaqO0NoRqtpPiPG9nN3o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cd376b-6fe5-4b76-f133-08d610d51622
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:29.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index fc149ea64be7..59aaac43db91 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1647,10 +1647,11 @@ static int mxt_parse_object_table(struct mxt_data *=
data,
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
