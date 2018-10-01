Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B6C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166F02083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lCDsXgxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166F02083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeJAHOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:54 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729456AbeJAHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B02HdpFW6GfouXAuXGvpKzwxLWsuaoUl8yYuP8wmWoc=;
 b=lCDsXgxDvE6GWYeikurToS3AvklAxEaRHPciF1tR4wY1pMYVW22fn+9KGGw6p7SJWc9FqVK68duBZNz5RYSBGIfjBtkjsbYg1uvS457QnmIvPiNpsbvgfU9VnZ/ufMuX5nr8jgJf6hBr66as01UuSSh4kIX8LWYNQOcnM74krp0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Harry Mallon <hjmallon@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/37] HID: hid-saitek: Add device ID for RAT 7
 Contagion
Thread-Topic: [PATCH AUTOSEL 4.14 05/37] HID: hid-saitek: Add device ID for
 RAT 7 Contagion
Thread-Index: AQHUWR8iZrrnnztA1U6NxrrWAVPBOg==
Date:   Mon, 1 Oct 2018 00:38:55 +0000
Message-ID: <20181001003850.147107-5-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:dbLSZ5OpKS830BGCAi+ThiEXLEt7DWZIdYk7sJJ9O/j0a1EbGURlOMJLwd6wY5e1WIyMyUDBVyuEseee2N7uoD6wVD6ZszTes7eXAYHmEuErE2miCtALC9izXKsrKj0GY9cUWBTM5rVn2wOqkpOeNT/edvwczfFkj4LwPIT1WOCKO1zOZ06MQdRkFchcuesh9+L6i7uM+JWJJM27ywdV8fvQYCiWRr8hIREA0YDgBS1mQi1o7UzVvKE/+3DboZHiYh9x3HNgLbFP402L/FSbJF3cHhysrpbPY28OCk8tqADcnGfAYhH523XeJfrDpHe+SP8OhDFgGn/vfC+Aan1SlSLGiFEcRdYOpeyitiyGWwyqQmKpp4s+5huWYT/+af6ZKCUpaAwE4qE8IsyBCHrSWgKRrl8k8N0OeGnR0TRGinT6U4hwSSuRckRWqfE1cOCuDhshSmBKKYoclM9uu0uxbg==;5:Z7pK8KEDo6/021UviqUd7RUb5/lqVgx8O0ht0tX4bVR3V7sHTlLAl/l/+D+lOi/JjDYxGMP50Cu2ru+G29B+mYqC58YnUloTOJYvPuLvI3zUwN0RzSFF0QA8ZG3U7OS9kMiwaE5C2bORmGQ0brASxl7mzFfkxSr74dgyz0cvbU4=;7:Q6FIxlnDxwu762HVPSubP8nQuXBQAS64KSocyf3ln2cdVBGHDKVt0MlmF5oRukCCFG/5py0ad3k3GmdczOegt0Y3a4jrqHhq9IYAuWvejUlXztvfQqsN2Kv4onkqYql4zWAEePlHC5ecz734aXGZ4qWhZjJveWFEVlO4NLwP3wv2aY5I3J/J4j3YYW+g/NTqBTzWKXfF+uKSoflZ8kA34nJh0ehNqDcXWOaqwfkhrGvxAr4NUkoivxthx/e/F3h3
x-ms-office365-filtering-correlation-id: 118ec3ed-555a-4c5a-1c01-08d627365f06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696BEC7CF95C71C803198DFFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(39060400002)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1UkbCQHBuzxUqqdnbK1NsJaT6hA+7vJwh8+tE8v2HsfeTjxKh+IkvcduigdR7031VO8tP9DMj4mTnUQbJAbgOlMp1Rx9A2vBhAgIZGDT2/94cD407EJ6GZhPzGkrsdjx98VTRD6kfj0fMYg7WK51OG1qYhNkekYi+vmGgNNUy8R7qQ8np7lgTgTcUvJjxWkIxXEKapGHw+DgUYed/dWEpJDPXw3tgUWfcscqqusQYFxIFqkYkDr1YdrDeOE+y47vQNBqhVtLd+82S13YivCgdQfjzOJCmOGi8QsYItiapeoMEnK3xzpIazCDgLSDOAClGdtRRC6JrSNTs7uQ4IzSbPAlER2/bVgAuq+5evX1FVY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118ec3ed-555a-4c5a-1c01-08d627365f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:55.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Mallon <hjmallon@gmail.com>

[ Upstream commit 43822c98f2ebb2cbd5e467ab72bbcdae7f0caa22 ]

Signed-off-by: Harry Mallon <hjmallon@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-saitek.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 431e88960af2..3fc8c0d67592 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -926,6 +926,7 @@
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
 #define USB_DEVICE_ID_SAITEK_RAT7_OLD	0x0ccb
+#define USB_DEVICE_ID_SAITEK_RAT7_CONTAGION	0x0ccd
 #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
 #define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 39e642686ff0..683861f324e3 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -183,6 +183,8 @@ static const struct hid_device_id saitek_devices[] =3D =
{
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_CONTAGIO=
N),
+		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
--=20
2.17.1
