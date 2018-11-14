Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE30E223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="YciM1raX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE30E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeKNRP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:15:58 -0500
Received: from mail-eopbgr680067.outbound.protection.outlook.com ([40.107.68.67]:38263
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbeKNRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji7E1PoSw62OepkWFOb+ouND7MoV9wYdADzZNPgSVig=;
 b=YciM1raXZmQA2OYKSHeytE/sGxvSUFlWMPUl2RswswMAIebzjcHfDHRAlnko153TgFxRMszAZ189or/N/1oSiTE6Rm968NAPeOi2zw8t9IMvQCWAI1d6ztp4cCMFEEYWzQYyjoNdjixer63H7PSkmm+S7LmHlIMIpf+oXHeb0kE=
Received: from DM6PR07MB4377.namprd07.prod.outlook.com (20.176.95.147) by
 DM6PR07MB5626.namprd07.prod.outlook.com (20.178.2.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 14 Nov 2018 07:13:56 +0000
Received: from DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::2954:d777:efb7:5edc]) by DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::2954:d777:efb7:5edc%4]) with mapi id 15.20.1339.021; Wed, 14 Nov 2018
 07:13:56 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
CC:     "Norov, Yuri" <Yuri.Norov@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Topic: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Index: AQHUe+maZLYYsimik0+i7t/nnXCYJg==
Date:   Wed, 14 Nov 2018 07:13:55 +0000
Message-ID: <20181114071346.31210-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To DM6PR07MB4377.namprd07.prod.outlook.com
 (2603:10b6:5:bf::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR07MB5626;6:t/YktHMAFW6aKZAYgT4e+FoLe/2QsgrzPoL7RlPSzACiOUGOeOQ+vkpRtF7brIBY6MPLuJRKQISExmqxmQrsWTu3IFpvxAXvDBAFowuGAHsYsbYhblUgxK4hOGy1Axhc9sBYvwOqJ6eCB2nczPKVzlLiX9ofhsgdoedqb1Wl0W/eZHMtLFDLbxoBQp1GMp7c7noGPp/t87bhqKJjrct1COscNNQSIAAP78NyKCDyePkDCAqHsdfgatWogvWi+T41/lN8yKAP+m1tKSafPfuOUFEU9NqoY1v7YwN70rheRpn3t6nq7I/HCc2qZoK+2Yw/sXzkISAu/m5yivrIs6DJ0Dl4deS7ayYJDzIQA09g3Kif81g69TLw6Hcl4n+/I8JNnBB1xzB4eGxl3A7rIHotjySUuq8Y+pfG8vUvkjEbdCZ8MDx61qoyfWmMqZ3nI21Xwlyp2fftvNIyTGuVe2HzAQ==;5:cn+udTyii0hdz4zZA7tsNepiJC+XnODFZpMucBkU/kM6EPnPQirOsFD0kV95eKN1ZBRQhPZx0BrA6I/ZNVXpsXWqI+pBhzhzDh+SoxfQi1w4gOp3JyrFJh8HxYi/HpvhM6DDM/uvaP9diItJRSlypKzwyRoBCTBIb1gbMPqKhr4=;7:Y02/CZhN7OY7y55R+XiQrRteY7uybx6zekgHAXBVboBwt5zjrGzqcjzJna4JqMzqn9pOz4HhbCCxTM6sVoeTBfb8Fu1UZ7dlU14B9vtVVkJFA4TcZHunhmlDKSj3GDyc6NyOdHE0Yv1CMNhRAGpyEQ==
x-ms-office365-filtering-correlation-id: b54dc28a-fc49-47ec-c262-08d64a00bd13
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB5626;
x-ms-traffictypediagnostic: DM6PR07MB5626:
x-microsoft-antispam-prvs: <DM6PR07MB56260C8AA5FE97F66845B638E3C30@DM6PR07MB5626.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231410)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB5626;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5626;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(14454004)(54906003)(4326008)(105586002)(99286004)(25786009)(71190400001)(71200400001)(72206003)(7736002)(66066001)(966005)(106356001)(2906002)(26005)(5660300001)(256004)(52116002)(305945005)(68736007)(53936002)(476003)(186003)(2616005)(6506007)(2900100001)(42882007)(386003)(81156014)(486006)(97736004)(8936002)(8676002)(102836004)(81166006)(1076002)(6116002)(3846002)(316002)(6512007)(6436002)(36756003)(478600001)(6306002)(6486002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5626;H:DM6PR07MB4377.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QqDz8tiB+3fMHcxsiCtbnlO7wtEeher7xqI48HAvFWKezZFOkSPE4eMKfvnOljwT2NfVDhNcUoblMlm5FFvUpdL2Wy1ibdo/j0cY/E8jOUc/wR/ZVLVkbENHq4nPk+JNrImT0J+yq4iE6GDEfLvv6i9T2vqijpXjddDN1vtGGu8b3trURs2hl06fBg+WmEYRdzM2RzqZket1sKbFaUyvlu6QmW4LhnamGemZW30SdC1czrsrUIzny9nmVsvZ/ZI3gTy+WVzCanc7rBXYlof6E1jWYhub+tnDzT8pRyV3yosvmIY3NQa4W8KfDrst0GaU4xdIuX506UqvA55My0nohigR5hoP2LSlSs9PsKGj+cQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54dc28a-fc49-47ec-c262-08d64a00bd13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 07:13:55.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discussion:
https://lore.kernel.org/lkml/20180702084622.GA15274@yury-thinkpad/

Although RENAME_* macros are exposed in kernel headers, they are not
used by glibc. That's because linux/fs.h which hosts RENAME_* is
considered unsuitable by glibc developers:

As Florian Weimer wrote:

> <linux/fs.h> undefines and defines macros not mentioned in the standards
> (and it even contains a few unrelated structs), so we cannot include it
> without _GNU_SOURCE.
>
> It might be possible to include it only for _GNU_SOURCE, but there are a
> lot of things in <linux/fs.h>, so that does not seem to be particularly
> advisable.

In this patch RENAME_* is removed to a separated header file that
conforms the standards and therefore is suitable for inclusion by glibc.

v2:
 - rename dedicated file to 'rename-flags.h', as requested by Florian.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/uapi/linux/fs.h           |  4 +---
 include/uapi/linux/rename-flags.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/rename-flags.h

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 73e01918f996..34c308203746 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -39,9 +39,7 @@
 #define SEEK_HOLE	4	/* seek to the next hole */
 #define SEEK_MAX	SEEK_HOLE
=20
-#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
-#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
-#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#include <linux/rename-flags.h>
=20
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/include/uapi/linux/rename-flags.h b/include/uapi/linux/rename-=
flags.h
new file mode 100644
index 000000000000..7178f0565657
--- /dev/null
+++ b/include/uapi/linux/rename-flags.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RENAME_H
+#define _UAPI_LINUX_RENAME_H
+
+/*
+ * Definitions for rename syscall family.
+ */
+#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
+#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
+#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+
+#endif /* _UAPI_LINUX_RENAME_H */
--=20
2.17.1

