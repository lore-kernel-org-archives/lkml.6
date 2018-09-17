Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEDECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58309208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oXwDCC+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58309208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeIQIqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:46:14 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728467AbeIQIaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMldluV47ZVQsqIzcYG+xI0CEabjTvWLJnse5fv7mN8=;
 b=oXwDCC+/4tKVUBhz6tnhlhAt9b5iH+F32Qu/Be3IjXoKvXepSCri9U9k7DHwsA+VwkRGy9ZZiORsUKSr+U+f0GRMiedlop5XbQKDPBO0G2qiiq0LciO/B3exFKKujJvOLLBWPrkr0d391f05kwXmtSmuOFAC4mVeAWMHPinfQYk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 70/87] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Topic: [PATCH AUTOSEL 4.14 70/87] HID: hid-ntrig: add error handling
 for sysfs_create_group
Thread-Index: AQHUTjL2Becs79dCEUWNirkSag3CAA==
Date:   Mon, 17 Sep 2018 03:03:09 +0000
Message-ID: <20180917030220.245686-70-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:sH0Buv9vWJ/EPOfI/L2HpM+dsdw9EvI8Xic/GKJgmJLo/XcqgPGvr1Tpg5mhhN9lzhigYfCxWuIjOhyLXBY6MvS0BZpsJFVbjt+lBdsQHDh62a474m5T4zN/QRdsuccRjhJdZgGQpIAr4Qlv4NmFMRAhicMeI/VUs4jjFShmok/DYYiY67CtpZThs579rrsOW1vpDvCfof1eX9yGCnbHMD7tbVwaZRG9G5jJAQ1YXBtQ77n1J0fWnH9JhZ7fVOIaLWtDnaNe8G93xL7W9FOrh/WVZRyOfE2u5PlHlDyeSAFfQPhHZwiWskDhyy9rv99i1wnI8GK8jFeXuTxf7NrDwCyU+DLmvOhlmV8bMFuS7cODMkLq88pbEcGTv5orzOsfg/9O/VICxloyX2ZXs6+5IYDEHhyPbMQO0IeZlE2nzEbjcuNKW6/RDNQDGfovFxnJwqDJlIaZ6O/uOUQ70q8+CQ==;5:c2Tg8n+PP7WXLCc9lrvJIsuxAuI6jOuM1hbXAr4trkChodeNcME2x2o+REiiiFlhoxrFv00nWMF+QcqBhQVABfu9dvP0pwHrEewbLsFe4TV1kjmec5yT8RXgaDO2HEmYP4oOpAN7yVoNcVKZI309WOmxwmCrBfGPX/YQW0VUFRU=;7:y/a/6Q74IjsaLOvTJDHHxjZ+jfv6xu2YymPdGy+zGY7IIFg0Xh6FqDpJYJ2uhvivwbV4qY6KcXQwGnRElCIgyYsYpfTUegmM/rfuwP1XsZCM55J7hDgIlwr+u57cgx8km2BnB2hcgQ6xNwXkNL1+ENYC7JzeJRToJcl8u9HkoMDDKAJt42ukvppA31A5Hvd3W2pmjY7vOdpfP6EHtbhduVIhd+hpPk7w7gWkCE1PpfR+cqH3ZNIyeCxTofpFW+4A
x-ms-office365-filtering-correlation-id: 8dfb2575-6869-4344-b1d3-08d61c4a59c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133648116240691A0BB24B2FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0PU7BsrRWqhFL/hgawr79j2WztTt4IgzhIAmdQ0v/yB3LvSHRrR+0yjBw58aEzEXCWmk7hGFw9q/H5MNyJ9K4bfjjyBEW8umyB9DKPJUyQO1UxoUo7hBmeELSZCbPEx2pUUB2LPG+++vi5TrVbLFP7/fK3PunUwJzmvGFqq/t9EVs34LqIpZ/dkij8z8xTVCLLpCc5Q5b/kCm9bMa4ozHLS+j7HI/wicW0obH+TFLhfS857ftyUVDAsPTQpCUzUQIm22Kiro0G0lOHeyj98VumgiYPrVcwKwSYZAoh9Cs5nltZ3Niayo/A9wTH6zfbPxPHcg0b9/BZZcYjXTkJDal+9RbVPDdI4RrKIJRy8rsaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb2575-6869-4344-b1d3-08d61c4a59c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:09.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 44d4d51de9a3534a2b63d69efda02a10e66541e4 ]

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ntrig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3d121d8ee980..5d2d746e35f6 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -955,6 +955,8 @@ static int ntrig_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
=20
 	ret =3D sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret)
+		hid_err(hdev, "cannot create sysfs group\n");
=20
 	return 0;
 err_free:
--=20
2.17.1
