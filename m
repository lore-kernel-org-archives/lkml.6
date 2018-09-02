Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D1BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846CB20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SSjcf5Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846CB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeIBRcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:19 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729327AbeIBRcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ6tzIc73aVBWz8NZRgLCPnCqXFI3erOapB513Hvatw=;
 b=SSjcf5Rlz7JAPm+d1M04lmxGD4cJUj1WY1IXyJOyaJalCAxL5EYcD9izslJTxnW6NX9ODhZ1ugayj+Ol8qWetuFi87Ne6GyyMgoXlhpLvzrlw0yIHXoMRWvaug+iXf2yvyRPx1bcvzQMNwHkJNjqxazNLfdqsMDy6/OQ6MlYJYg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 19/47] scsi: 3ware: fix return 0 on the error path
 of probe
Thread-Topic: [PATCH AUTOSEL 4.4 19/47] scsi: 3ware: fix return 0 on the error
 path of probe
Thread-Index: AQHUQr8WVlExInvSSUuboBoqx6kquw==
Date:   Sun, 2 Sep 2018 13:15:58 +0000
Message-ID: <20180902131533.184092-19-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:vLtPEEoHPUx7doVUSWPBDr4sDmxfRzeCT+TkjKt0dYPBTCIeVf5b3rXPHYGv2d0r1DiCHNB1q/BOIGPUmsjIKWDjLQjI82rprUWpDCLkNUpto5DJruh1RmVS4ak5NgRlfvIURDPiu8yQDmpCSohe1ofP2bGNZo1aWhSpMpxMEaxmtDYrUrJiM2mh5/I7M999smo2wZBz/qJKyqH0AcL32yiTeKwUei3lm+QA9z9n4jMHKdjn7x5EWkT62+zSym+Hoi3yBnymF7LIrmGC07KEoQOYCq1Hu0H4N8/bXlrn+yxzCPcq2pwdeUpaVbK+KRThB3gy2eJkNv0Z963+QuRJpOBaf/tYsxDQsUbyhSNl9TBSh2wlJnIGFWp2axouKlDh9YHq4exwKcPdTIHee3x8H+R+5Fglmfz3v7ClnLWLRz40nwX1U5IS26IYebX/G/WlPX0iV8QFoHRKhqf9RSpvtw==;5:+YTqhI35xh7CB2Qnw2ycFETPqtwm8ImJsB+6JT0/zg3+M7LY4L6SzgC9cX/LYLy4DMR5yCF+b8vTIlmGqe/MtvzKt7taB+9NAleV3sbU7NxB1GFEb+I0Wx0UGO/SaBos2NF73+KGPVGI/0UYOwrsqOQXuZCOXZFFKCDwXjY4Ceo=;7:/q5hMtT+hof9hrAidrwn3Q5kWSCPGn52Fvg+3BBdW9guHLdFfaC+f4SQVYGWEb0AukmBMDiF1+9hSvyn07nGL5PM9gPd5Q01Soa6XT7tVKwOBtY81at6ykVOqunmVtsDn6dnWWfIFaf8h2y2kc7yJvmBND4iSEdH7PdJEgj5zkMT4DPODYpLnQbJRh6tp7e+JmD6wOkIBG0BGpx5rck3Yk0VrbRUoOlVYU2pGCMRzuVJXbBiduMsONlVuHZil1FK
x-ms-office365-filtering-correlation-id: 98a542ec-c607-419e-9efe-08d610d64796
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06290099454B5891E4D31BF8FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(4477795004)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: brgnkmRZo3xL2qCG8rA2tzi5YKgPUB9Isgxv5XleGJGRwbmAx/vLuDougNv827qcIqDPFMulwTuUvGbTs7poj3xo0Jqqsavmj9GyvplG0OH4OHPT8hjFb9oI3ZK0FFhR/1CNOBCQ2XzGp3MGF92/329a1wmP9AcjikNpELGUvmkuEPCiWXpcidDUQrlm/ENKnEy3wR7Jtx7dFSS+bGm6xzIMpyW6rDt1JqMeTREtTtBQhU5rckrJgzkuwVm5TcGxaPdwar13GA6x44UXoUwDasUBMas5zcF9b42+SUhWwfoofN+h/jf/jxwrR6BBzKDHdsUF4OPvO3WxOB5jFEMNJKL+JYHHmDrnyk+kmdbbC0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a542ec-c607-419e-9efe-08d610d64796
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:58.4020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 4dc98c1995482262e70e83ef029135247fafe0f2 ]

tw_probe() returns 0 in case of fail of tw_initialize_device_extension(),
pci_resource_start() or tw_reset_sequence() and releases resources.
twl_probe() returns 0 in case of fail of twl_initialize_device_extension(),
pci_iomap() and twl_reset_sequence().  twa_probe() returns 0 in case of
fail of tw_initialize_device_extension(), ioremap() and
twa_reset_sequence().

The patch adds retval initialization for these cases.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Adam Radford <aradford@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/3w-9xxx.c | 6 +++++-
 drivers/scsi/3w-sas.c  | 3 +++
 drivers/scsi/3w-xxxx.c | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 5466246c69b4..b78a2f3745f2 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2045,6 +2045,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twa_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2067,6 +2068,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D ioremap(mem_addr, mem_len);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -2074,8 +2076,10 @@ static int twa_probe(struct pci_dev *pdev, const str=
uct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
=20
 	/* Initialize the card */
-	if (twa_reset_sequence(tw_dev, 0))
+	if (twa_reset_sequence(tw_dev, 0)) {
+		retval =3D -ENOMEM;
 		goto out_iounmap;
+	}
=20
 	/* Set host specific parameters */
 	if ((pdev->device =3D=3D PCI_DEVICE_ID_3WARE_9650SE) ||
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index f8374850f714..f0a5536a9ff5 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1600,6 +1600,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twl_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -1614,6 +1615,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_iomap(pdev, 1, 0);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -1623,6 +1625,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	/* Initialize the card */
 	if (twl_reset_sequence(tw_dev, 0)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1d, "Controller reset failed during=
 probe");
+		retval =3D -ENOMEM;
 		goto out_iounmap;
 	}
=20
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 14af38036287..308a4206b636 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2278,6 +2278,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
=20
 	if (tw_initialize_device_extension(tw_dev)) {
 		printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2292,6 +2293,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_resource_start(pdev, 0);
 	if (!tw_dev->base_addr) {
 		printk(KERN_WARNING "3w-xxxx: Failed to get io address.");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
--=20
2.17.1
