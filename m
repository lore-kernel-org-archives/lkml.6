Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF82C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF15B20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AhhT6Url"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF15B20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeJAHNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:20 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:27216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbeJAHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgl3idjQCY2g3LivRKvyMWtaCzEyxTiR7iKe72lT/Tk=;
 b=AhhT6Url08WK0DYkj/IyS2h7XesSiXG2pFtCyBAww2p8hEAkpxKZAVDRJ2OJ2HK51zgHKO12nf2pYXOfDsALccGK+SiTR/6mGw4fkdTAhhQGNxNFBGVp1vsBaFgTUzyF1QjnW8ISXHuB9JTm0OUsCA62DLp6OwGtZ0tpEDNG9G4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Harry Mallon <hjmallon@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 07/65] HID: hid-saitek: Add device ID for RAT 7
 Contagion
Thread-Topic: [PATCH AUTOSEL 4.18 07/65] HID: hid-saitek: Add device ID for
 RAT 7 Contagion
Thread-Index: AQHUWR8FBQD3GQ9SmE2n6Xr1w+2dJA==
Date:   Mon, 1 Oct 2018 00:38:06 +0000
Message-ID: <20181001003754.146961-7-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:4HAb3ZsRsG8inqC/Cn3WvVTQnXU2lZQ07DNqXtRdZaqVjWDaz9aW9ZQ87TpUaWJYH7f3SEFUHxKLpXhpwsrwY8bsWztrQP5BOZFDADmbYCWtZ277VfgkLPM5zKm5rH3h2it+7a15JyRtzeW7JzE6dKahcPJleiKsp3oWFWz2tdwYgvau2ZlixpNtIlE+Y9KXNBUzwTaYMr7mS43NxYtllAmSzoF3MrV9H8CLLB5gljEEO25wy5+JSgOSdRUXtEMp/ET94h+j+yuByUpFbmm0JKG/HOT/mD81zmN934KopHq61V2E2WNVv/cNslfh8EpGd/CmLNgO91wB3uGg+0Q1Lkbw9nfwviCVUUFQMSUIDY080LUTmANVnx+6PmCg4E3VO/SKUbFjFisiivxO5zckm+qFxol0Bovk2Z5McrfSjbmfIPosbgH+HJLP+2HJdk1BpzlaaijCr0NUwvZ8yCMWMw==;5:Gr2u8/9B1aIKziueiwBoE6h7r67+c3ySSv3vlbsVE7pwLTS8OLcQjV/4NI0GdvSpHakXc9BsAfmEfgeL8T1L89WfO+Nm5FYoB0WdTGRpflDWEGjTOTeiocBeRX8uUpHV1Pjr6DXveZowb8dcWpjcOwzbcGSC0NdIiKXGx2UP4DE=;7:U2NZ6MOsXEmJMOahTiQjJF0YuclWBPG9CdeuPueml8AZ2oNROy5jJA6FpDyQL+TrvC8lmFv+4WsJidmRV/nBoii6kE99NbjX7ggJJzdS6sPZOaJLCR0CuyvWpldrAq9R5f+cN3Qq/2or9VdPlsPq9M6Vv8dgdtSbzH8LV4RLxUiEWk9YGXpXkzZtS8Wbp5HBtkW96MHZNpfQf0QxzO5CBcatp6ZgE1ARabMPyYdR7fAPmR6FQyrjBHNHMShI29PE
x-ms-office365-filtering-correlation-id: 77a507d5-31ad-4df5-0597-08d6273627a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469965AC176E58428C228E4FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(39060400002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c+e9y6ptDWQ2aSZS0/zkG5VhBk4nK0FAu6e2wsXlPSSKcfJB1STJL08BxLDlp/CsrWq0ylwY9soBauJU3DHItkFuCZSlAhVC7FS3SwNZR72U7X1v9ahvwcx0RqG4hUUm1G/UO1FQRJcxzgcrnh8gObcLfchZe8chzBMKBRy9Z3VTdUj/c0gLOYBrPu+MsDCPEcuhMNLtbmW9YswhdE1aplJXUQuFy646x/h8BC4WbzyzyDuL5sK7zT/9tTXHM7sGixN6LKrmNgZvy4zLJCAGIfswLv2RcqM/FTo+obj2RQvNmuwR4A+WIyYFpx/Nd4w9cIW1AV1tPju1R0HGTx1pQuD7mUu3JuPp7xRp8Ofipiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a507d5-31ad-4df5-0597-08d6273627a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:06.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 251e184f3f7e..6046150373ab 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -951,6 +951,7 @@
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
