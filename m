Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46905C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CBC20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oc8Mxnqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CBC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJAHNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:16 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:27216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeJAHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q0OPlUpYOUZI5znhCL6eWyuc51hDc2K2w71aSmscRg=;
 b=oc8Mxnqwo4kzNdABz1KAkXXk//OSeosh3vZIr71//Ollffr3ZFXz/wkaxAvNJf/O4gOCWWJfoDkdHiCan/ZPa72rfK9tDkmLyJm9DAt+4pbtfTo6MeMGPSUII9A8d+6m2E4nVugfkNmfFIGIUl57A7SyVIhIeNUPKWqymfcNIEs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Bosch <linux@progandy.de>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/65] HID: intel-ish-hid: Enable Sunrise Point-H
 ish driver
Thread-Topic: [PATCH AUTOSEL 4.18 03/65] HID: intel-ish-hid: Enable Sunrise
 Point-H ish driver
Thread-Index: AQHUWR8D5x6O5Xfucku/5HevDjpETg==
Date:   Mon, 1 Oct 2018 00:38:03 +0000
Message-ID: <20181001003754.146961-3-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:Q4HV9wV73blQEn5c3JJzmAa/X8QmLEBDovT08Js02kWUZh+EGZECiJhToIN3klzWMNI3FjmQK4uAu9Ra7qHOlGEQA/bQojFMacMt/u2ZcAbAUE4b+vtOMO7HgCLFseiMRCTzQbw09lKh4Xv7ogCLOEicQMlLAEimPF60cW5J7ROLodiNzkgcGlPe6jaGU4FlRdFQWaUHXv+EOwkJUXi0jDxy5l/9h+wWhVdDOujLWiiVw4B38Nf1zWwAHuNvTZ0UGnn+szWt0v6ssJMyPcu/oZC8EkOAxAaA2RBvBn5hl+8DAbP2Npg+82ooxZHoqJlcodg1qmFBd+9Diq/DLFs7ezYto3iKjHVQhJ6HCuFzS5DoFvZL405w4XGTclbS95/uACJXx6wkRlyp6/vhLvREfj2zSWq1TsG+QXaQwk5uhruMmOq0n61VlGw/umfcJFS29jCs7vRVD7utxm5uytHbYg==;5:Wo+JZmmWboEs4eqcUMGs2NaZbhtKxevfv5/2eIZX/agkC3+sdkF4hoIHF6tBYqNi8YWYOBsHvvHOafYzYO3iZIEUVZe81Rs/f0kLY4jSDNg6k8ArDaCZVh/cqZW6MLCQNYySvOaEJJBgLAQCUmFOkMUjXH71qAmd3Au6ZbVP6qE=;7:kgKHfIeW0CUCG/J7Z/gyvGclR+vVqCN69di9OMQt9EyMZUi/6aAqb1sVmOthbDmFgpwQrqJUl48QOl07AvFoFtscKGLcrsPOwZpxp9yNF6Nuop53m5f5sNdpfF1JkPLJHwD2VeGyOC5uU5Kq6tCJVebzpsMfYXVIc2t8c34D7tULBbOR/FF4CvUURhWF+XkG+xjX67j4TEliEEF5MajbxHGfXAg8S633pc7Z0nMQJs6DVA10ZCNuZAr+3OL+Lw7R
x-ms-office365-filtering-correlation-id: 874a7714-7e92-4a33-6716-08d627362606
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04696F0CD34A285E5A5E825BFBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(19627235002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J0xzANgKg4XE/VNAuGpwS4JFJ1NAZABgsRdpl/Q8n6Ywx1Am9/4t6woZtYsw3WuCkm/3h2APQJNG2u2DaLEj6oqOG2EKAOq7mZlcQyu0qQy7LlszqbG8Ufx8uylyQAoW8GTWd2e/1NpPWelNsOEUjbTBNW0IZHiDpAvQ9aDn2/t46CYRZZ7yuyOIv1tGdrgklsyNeHpoLTl/VAhcyjYAD1NofFzoMiw5V0dHtTnzGJideCWWLvUSV1XEe7zYlqrP7n+Kr+Jdwu6Eipk1fNOtptYtH0lA4lCDL4tsnn7hB9sS567FGfFgLr4I50XFPUXvJrjBdVl3hj+r4HkEIVLtcBhTYU7aud4DC2cnGOSXkrU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874a7714-7e92-4a33-6716-08d627362606
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:03.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Bosch <linux@progandy.de>

[ Upstream commit e0ab8b26aa9661df0541a657e2b2416d90488809 ]

Added PCI ID for Sunrise Point-H ISH.

Signed-off-by: Andreas Bosch <linux@progandy.de>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish=
-hid/ipc/hw-ish.h
index 97869b7410eb..da133716bed0 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -29,6 +29,7 @@
 #define CNL_Ax_DEVICE_ID	0x9DFC
 #define GLK_Ax_DEVICE_ID	0x31A2
 #define CNL_H_DEVICE_ID		0xA37C
+#define SPT_H_DEVICE_ID		0xA135
=20
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-is=
h-hid/ipc/pci-ish.c
index a2c53ea3b5ed..c7b8eb32b1ea 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -38,6 +38,7 @@ static const struct pci_device_id ish_pci_tbl[] =3D {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, GLK_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_H_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
--=20
2.17.1
