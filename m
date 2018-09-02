Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7B52077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DE2R7Pfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7B52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeIBRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:43 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeIBRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u09aW+bdqGND2zMIPBMFSjCX1hKGsmRvUBlQNV6ksu4=;
 b=DE2R7PfzrgtKfHwKoIewJjunvUuLT+lJYYj7t4RuF4/XJPP8IhFs3r7QBAg7bhv5sCq32tb4MWhbO1Lj4ZI77V8hcfYyGzf0MIo1eyOs/aX6Y4amCNbBva/7+n2V0tCgP24i7i9j0gd1LWHqstWyN+zZPRPx6y548ieoqMe0Jjo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 064/131] scsi: 3ware: fix return 0 on the error
 path of probe
Thread-Topic: [PATCH AUTOSEL 4.18 064/131] scsi: 3ware: fix return 0 on the
 error path of probe
Thread-Index: AQHUQr13G4XNdwTB8ECcWEZdI2twHA==
Date:   Sun, 2 Sep 2018 13:04:22 +0000
Message-ID: <20180902064601.183036-64-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:h+xwTXqbZ0snxWjI84k60Ff95A5eFQj8hS3MnbewzhB3N8FiT7GhksETgvYbI5xe8Mv9PfyjN/PH/tJfNjaa4lkydpVVSNtlxnOaXZyKMRlLfDmo+KJEf1p173M+pG4cfzUulVlMudFlFMAiBK7oI7/h9Q2tBnSvePmysmlRdilt+qRUzSkz+5azCVx2eQ5DmH/PGEtc+S8d2eLbpaatmJmsRxQui1dCy/3wA+/rs9EcVloBrof7l808CzJ1N3rWLX9c8/PpZ1Zae6INpRMEwQEVUFAg7K0dCLs9PDiqVsZlf0fjPBh9i3z3ZIMiCTMRnJsA2qB2ZEsnjoeBRd2f6VkUvfxMatZTyCIV+vZgGEqEXHNQbn28iuJgJI5RuPvcnmgGlE2IGwdpaq7OuEF0Dy0D7EIFOJelXZCQKBD+r0TUXUJNc/cOseAfRxwU3+DKzMtSyLLLSWzq8SHIlbMofQ==;5:gAbuNN6WukKXsHKNQrMkAK7ddqOZPhYpuqAz8LOGanuOVmW5fMpPzxU2lkkQHoIoUlLFkaJC2GP9Dqs+OUiTx5FqaWfRTLKcYdFYLPp3yoPRt0Atl2oFPxiG/6u2jZ3iNj9kB+0HNOUxHsJxidAINR5xcFUYjEZoEHsTqqSvojA=;7:V64XLZyoh1lawE2dugAK3FOlNA9RjEC6ET0Sn/5zqvWMPR/ErOxPGL/gJK+WFW9fkkUdton+usKNSKwSkee8gbuik9ZMLf6H6PnvRhQYnP7596xOtlWeC3Ny126nTgfrvxBV6wQffS4ApLY0CxelXZKBBlVR0pjHhCtJWvQb01jaI6G+LFQ374gdoC/BIkVC7HdVry6NgkcDReg6n5t5TjpqpW6YgyqH4cWtQoPE0gUYAMK6edP0zX36Lq2qmNC+
x-ms-office365-filtering-correlation-id: f96795e9-1bc1-4074-998e-08d610d4aab5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120263347E57F76F4246C6CFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(4477795004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cTBC7gp9RqZjdXQxpFU5Ip6LjmHpY59Nn58L+enFbRp8W4Tz8OJPHXyS2SZWGN+xDEtCtQFNNlUyqHRGNsaeGEY9bYOpwJtgPVLjGCL5poDPdqUvE1V3L20w5yQEoai47XIHSI/f+ZiTgBc0pVWs6A+0fsG0FSc61gUHNg/RbZ+BJ22uRfJzuCNkkKXpjuEx/3w4mcAqAd5Pf868wLxv0blojF2+FLJifmHpZAZT2axI/NfZCiGaNPPFstKi1sLhSGxwbvrXAYFGGxBok8p7g02zrtqp+P5SVj7hGHapfnWbovlO/AvNu6CtGkvMXjFdB6FfM9X6TsmMOQEitXKwp+hVy3HqmxF6XLgd+KlPbr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96795e9-1bc1-4074-998e-08d610d4aab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:22.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 99ba4a770406..27521fc3ef5a 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2038,6 +2038,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twa_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2060,6 +2061,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D ioremap(mem_addr, mem_len);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -2067,8 +2069,10 @@ static int twa_probe(struct pci_dev *pdev, const str=
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
index cf9f2a09b47d..40c1e6e64f58 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1594,6 +1594,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twl_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -1608,6 +1609,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_iomap(pdev, 1, 0);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -1617,6 +1619,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
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
index f6179e3d6953..961ea6f7def8 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2280,6 +2280,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
=20
 	if (tw_initialize_device_extension(tw_dev)) {
 		printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2294,6 +2295,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
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
