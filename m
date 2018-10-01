Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E5EC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73AA20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eKDsVVBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73AA20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeJAHOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:23 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbeJAHOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWld0dSEWW1nt+8YVqVDRQXB5PE9jKFSOyDaFu6F3Gw=;
 b=eKDsVVBM5Qj4v5C5z/hOVDBBtSVHCcLRz9td8Yk9Ak8cmKO1icAyyUWXm0J9h2fIZd0V8eZqRYKNauKLGPBBbqCjBoaCFFZ5MErjkZb3UZNpQ20DDLafiTifz7HQkY0Dd2O3Tij8vVLVHkmwfEsIOSszoc4DUvggqeoC4B93iHw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 60/65] cifs: read overflow in
 is_valid_oplock_break()
Thread-Topic: [PATCH AUTOSEL 4.18 60/65] cifs: read overflow in
 is_valid_oplock_break()
Thread-Index: AQHUWR8Zcx22s9YQ10WBEn9bDZAYjg==
Date:   Mon, 1 Oct 2018 00:38:40 +0000
Message-ID: <20181001003754.146961-60-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:kykvTKzqg3hr0gGtRK1SL5EPC56kmaKqzzMIt1v4NsNXjdidFsguNm1hklBL69mNygHJU1qbLkZ0oX8VwAOkBlrYexqmurMbma1mUcCVw+uWyXUZzgz6ZxZ2KVBHYQusTiBda7kV8XvecW6w4ItmfTfXl2uuxj8zbehbQvPqqSL8lXPQ+gmMyhchGAS0Dt7sM7zFAzcSF9+r1U28VWnaTmS8bp0shXsm9hPu96jrVq1oCj0+1frn0tyriG0Ib9Bco2nLbW5dbx9d4g2/5CqBA+0Sv/adT54AZePDdK911SNEqn6cp0n4TFnoUWa0uOOTN5+ZWIMBJaUVjp+DnSoSwb9YxHqwa7AafFYshjIHUtqUxrUoUPUx8D7D+mp7/lLG9Zk7NpGz/OPA1SUPEAJ/n7uKrXeH+wbHQ7E8Xjytfwi33rAimh9tFmONj/RVYsm9y4bzG1JR9MkY0gYpXdDMiA==;5:IkvgunC1I5VzsyVwOuRy3HI7DkpaHeA7pYLRmChtmEFxQmt3zQViAK76b91hNe1zXuSstBNoaVLIctvqKwYbk8ttPV2Jhq8N+ssh9jpXTsB//xHgDsdpluB7Oj+W9lqyFDGr54RepOTKn/BULmn9YBVy8SGroUlfp0JM66ijKzQ=;7:lq9OTQRVYf9G0L94R2jCxpgUj5bQcxX8UOiWdkDvDc6RwqWMb+2k++aMiWtiizSxJCRrPw43nEJWUSlX5RsF+RLvM2M72dM+kcF7flQVLmGQI6f6PFgcKzoF6UJz7jsEvICZRjkTCIFFnTRCOLR9rgNIfMD8ZRlnS7efaqY2BJW3DY+BALFsInGyWkTcfFn2QMEsUdLXVS3bCGpJCDuCRy2Pvk8RnWbhrIokan0il94zTEyAwI9HzfKe/jiVrhv8
x-ms-office365-filtering-correlation-id: 2c753192-9bfb-4452-2210-08d627364b10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08242931E358F68EB4CF483CFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(69234005)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(551934003)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l5HN+AjaDQqYbeOfziGuujXRWEOxz9y9Ixv51OYSNPPihn1wNYEPKGt657SlBjZ8b8gjqWqRFGC/oO12jQbr4Dk+9jgorB1fooZSQT2XWOLPpgz7iZEcUtGthHY8SUv2GbAbRsA0snWGVmYPADXntfc0SjD/v5pepfzyeTX5qhO5/3OvfZThBFezJkCpaHTVUXdKB9Ttbs1BRJb1whzZpOJTwm1yGueA4GcX99VVw6EAetknMoeOnrSnKdtbZSGIAwYJW7lGxWKP7jNISSuocKO4gZApuLVX9pgnguEnVBSMEcua1unvWps+Ta7q4iskUKTrGPhgBA/AbHSlxi/r3sND9ug60v/NyTznX/9Fc5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c753192-9bfb-4452-2210-08d627364b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:40.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 097f5863b1a0c9901f180bbd56ae7d630655faaa ]

We need to verify that the "data_offset" is within bounds.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/misc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 53e8362cbc4a..6737f54d9a34 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -404,9 +404,17 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_=
Info *srv)
 			(struct smb_com_transaction_change_notify_rsp *)buf;
 		struct file_notify_information *pnotify;
 		__u32 data_offset =3D 0;
+		size_t len =3D srv->total_read - sizeof(pSMBr->hdr.smb_buf_length);
+
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset =3D le32_to_cpu(pSMBr->DataOffset);
=20
+			if (data_offset >
+			    len - sizeof(struct file_notify_information)) {
+				cifs_dbg(FYI, "invalid data_offset %u\n",
+					 data_offset);
+				return true;
+			}
 			pnotify =3D (struct file_notify_information *)
 				((char *)&pSMBr->hdr.Protocol + data_offset);
 			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",
--=20
2.17.1
