Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B74ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D3F214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nArx/JAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D3F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeIQIaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:55 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729897AbeIQIaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9D3pORyqmlO8bHTS/fIqawvT0i7eyLkQVDYM6So69Y=;
 b=nArx/JAM4jsmGbJRUZcaWLsM48A9K7FsGO/RKIFfjnh71Ww+xMdoozITylR2y+wpaX0GynQ1gfess7mSbjQTFtw8LwvaCxjPVUns9KkSKbjawfUp1zyhjIz2CSI+3snM3QniJhf3jrAskq7aji5LzdamdcxTn6RNm/ImNZrYnFU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/57] staging: rts5208: fix missing error check
 on call to rtsx_write_register
Thread-Topic: [PATCH AUTOSEL 4.9 05/57] staging: rts5208: fix missing error
 check on call to rtsx_write_register
Thread-Index: AQHUTjMNQnY5D07DC02h5utnJsgw1Q==
Date:   Mon, 17 Sep 2018 03:03:47 +0000
Message-ID: <20180917030340.378-5-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:vPGj/RfSjOJmYRqZFMJZHV5KUAheFtXdwBavJIlHqpGMDWKkL5GzJuNqaZF1+FS6QdfWtmttM/5cV47/0+Qjn9EJmKuiOtS3I13epY1jjKa87Mj8R6Qk5LU59g2PVkjpJCQeyhR/rOpKWwCnimjQbQj/FGlHYi/8dzClyZl+MnMxdSbO5TO29lV+OKbS/9j4+/TwX8UXMFZCSPGBY2f9intvkcV53+NetVtrzYFPXYau7KEOEIyzGEq8txlJAg95irG7EPIdZ/qy4PnEoigcHG/bA/UQotN5dBBlejZxSSi5midiakiu4jvDTWHnrC209Lx1HMPSEyGX7dnsT7yi356AB2FLqLPTzhmc3eDSOQ9ElA1+m/6HkQFqZvEJIYbBSJRi83Z3u1b2OZPaYZILdURWW7FOiRqeFCbTp1hSS72lEMBmIfR16j25I7LcLwN9i+yzyTqoJK7p0g296de/jQ==;5:qroMHNq/S3piG1uH1tgpOVRuKWQ4udiJqxU9RwmhnFYjLsPDljAHmwHlCjxhoJxhoZlG3edOL32iDT4/4XKg52o2E9Bu1i04jf/gKRokZlf9/2YXf3xaLFAfynbhpl/xI8tKbWaGEkuHycEJPiPd39KrdYq61goqLtWkiaBYei0=;7:p9K6c1I98wvGj+3NumixvZL0gh0610aJjG93eWxmOekLx7xVuWpQBFfWxwx+HXXAdRz2urKGoOcpVKGpzCV4qTyM7fKpV3mKy/be5bytgg9mtznMNlSyyVrWeA4eXSy1K11CZKjYZuUY3CCmQECxzTsV5oXr9wilf5aJhyeBDWTg++zbJyuN0XPeHGbcXKAkqyM+lN849PgejCk/0Q9DZtYZVa0IKB5IIiAQwWmKt0FcWic2BvNKGTKftrozntl3
x-ms-office365-filtering-correlation-id: 9f75a494-8f6d-4bd6-78cf-08d61c4a7113
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120B41572450BBE5CF1BADFFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kr5nN5hEp0i15M3IMha/+Zz2xIFU7kkqFi8V89hkgUl6TGQPyOq6mkPJr2TbcYDaNtvalSowFTI4Hfg8dh6pOD/hibRDGEaTz/NxqI8JMOWnlDJWKWAS5P3duxpam3gOfEGtb0TQlqmqMrFyTc+PiNntwJc0N8dtxnjFfwxkGYzLV958XOvV7k4PgS1nDpfyK5eDpSO+fgo451cO6/tqJO51aqkRnT902Pv5opapDJU952EDrFvihBe+i0rM2bkUGbbvPJ180nRfYcSdU6ZWgQUZ2kcxmXTNQythsr4RpJpX4+4pbYsSZc2Mu3bQGsbFrLFyIidcqZXMG16n4x36bk/VODa1muFLO91xSDjLqiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f75a494-8f6d-4bd6-78cf-08d61c4a7113
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:47.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c5fae4f4fd28189b1062fb8ef7b21fec37cb8b17 ]

Currently the check on error return from the call to rtsx_write_register
is checking the error status from the previous call. Fix this by adding
in the missing assignment of retval.

Detected by CoverityScan, CID#709877

Fixes: fa590c222fba ("staging: rts5208: add support for rts5208 and rts5288=
")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/rts5208/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index b0bbb36f8988..9e63bdf2afe7 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4976,7 +4976,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, stru=
ct rtsx_chip *chip)
 			goto SD_Execute_Write_Cmd_Failed;
 		}
=20
-		rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+		retval =3D rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval !=3D STATUS_SUCCESS) {
 			rtsx_trace(chip);
 			goto SD_Execute_Write_Cmd_Failed;
--=20
2.17.1
