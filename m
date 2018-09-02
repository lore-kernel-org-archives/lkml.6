Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820AAC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB0C20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y6f2t4vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB0C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeIBRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:20 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeIBRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1evoarhfHVVS79UCBRX4C/foExsPjWQDVYNDxxPynKs=;
 b=Y6f2t4vG9VzThvxCDejfEHRWraBJIWLbWYhMpbn6mIoJPwT0hMhF2a9AEXB5HgwCRGNgJ4s3JkzTqHWFbeL6CZNQyXt0wJA/klNMTtcnw0VwegcoNcZv3tahT3U6tIsbtnyrKS2y7NJ/nQgC3Ct4etajrrNTwGO7wZm5fTX3sFc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 094/131] Input: atmel_mxt_ts - only use first T9
 instance
Thread-Topic: [PATCH AUTOSEL 4.18 094/131] Input: atmel_mxt_ts - only use
 first T9 instance
Thread-Index: AQHUQr2PlKeNmAyOKUCRYwGCVIcxSQ==
Date:   Sun, 2 Sep 2018 13:05:02 +0000
Message-ID: <20180902064601.183036-94-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:jkotUoaCDik5p6Y/Pt+OBdem2u9qagvQib35Xs+BVIWcATXe5xNYSXIY2vOqJhPD6iC++cR1+vKTdJfMCEKy+ajvzsKn9eUdhEJBNTRCAhDYNVbs0Tly5vKQ9Wflixto+/RjZXqQNHb3q5S/ZWXLmPqF3CoKJz7PaVr0n4UCYPg+o+HuirLGtzu25S4Ss2mhc4E7UV+npcd54CCSMuaUjktV5PIqKZdtXkzh8yA8Bb3poVm8j9PIYj6CZ0vC6OE/A1qSFKO12seBXdSjHGE7Zf3epYT5k+mlq8TT6A7ZRm2O2hTlZRTr4Gx1BGcWu4tl+pEfm/7YbfnJqnPJ2o2nlxZgwoLyyCSTjww1Qwn0VK0DiJKNd0VKOzIwM9wSoSTIjN3nE/dGvFxl8xYwMfqAZRd1cZYtNs9+wmPTPNXO6vbgfTt0HidcqGCbFNOnRCis0u/La0k+o9Cv1ccB1t0DDQ==;5:vktfsgOob2mw7ut6YdQNszljcRV5GYBjKZwPdxP0zYlOodx4yztqWX954UlzcEbbblT865NB6wvrRBtDTuPHXREGW2lCb5nn+KLwefB4lV82DWBBeTLG7QUazhr6+thZd1kGIdnI45NNzhiZhT2jzVIqbI74ca9EkCYh1J1irNA=;7:11LadQD7q6Y5X6TKMKu5Ke/hglZ2UDaIE+MSrljpSZynoHvAO9LY7jOMm+CMQlH8ep7d3H4e4R4j9MXtEG+A0VaPAwg475CfOb5wEQMP4etvUFno46nL9dyocwkLEXnIx3mTQZCeX5bm4nim2FG7PJJACPcXgfV5F6mRqCQz+OUO1FnqrXxLG/lCwBvHXeyZmfrc9A947PMKK5saw32kyz2igroY2h44uSqBe9CjCweJMlB2wMj589Cr2jBPFYpy
x-ms-office365-filtering-correlation-id: db8378be-b3fb-4c54-49d9-08d610d4c3e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184B22D28F962666814C923FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(39060400002)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tCOHMlCoZES33pu5PNGNK9ebpYZuNAL933OJFPSeJoFsJa/Hw0xw6Gv0+ZqwvMi3PyVCaoKnEHtdcoo6T+W9kAhGyKkyb+5W+20P4AXoW/fSyWEhjCfJoEnjTEOC96rj5reT0kOjtcaMx9StVM65tF8XIfqUuzadeYvbl/TMhlidpvDGqC2Cz0Uf43Nx2JDr8aEZJoVVlmnZgKH2i6FUzjdTcmT3GX0qoxRy/HlHU1yi8ef8ry9pnwGjs2BHvvVUnWHDJp0MIKxjTfu9U/rvZcldOABHVmxmWUI7oKOa25XEsXZD2KSgNZQRhvTaIROZ88prT8hwXdKtV7PDlxpQObq0CtHhMr6T8Z5e5Ikw36k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8378be-b3fb-4c54-49d9-08d610d4c3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:02.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 54fe190fd4bc..48c5ccab00a0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1658,10 +1658,11 @@ static int mxt_parse_object_table(struct mxt_data *=
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
