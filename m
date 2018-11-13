Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A065C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE02250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="SrPFiTBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCE02250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeKMSsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:48:21 -0500
Received: from mail-eopbgr780073.outbound.protection.outlook.com ([40.107.78.73]:44736
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730736AbeKMSsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVQUu0R9RwdoJoKWLnfy1SA1D442bsK0Lhcxdk25WxM=;
 b=SrPFiTBw8fxY/abTaWhY+ageRywt3mzKs8lWCLMFNGHCKURU5izTJwm2RQI1SnSgRLGa6SpvYecMWbGhjvGNVX3SJxKyl000KlOS37ilqxwdZpBDgyMFRbd2J9yVhcmwsYQ+9Kg0efzBrokji6Y/gAR6ZomRgfxhsuR1P+n2bSY=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB4536.namprd07.prod.outlook.com (52.135.225.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Tue, 13 Nov 2018 08:51:13 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::4d9e:166f:65f6:9622]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::4d9e:166f:65f6:9622%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 08:51:13 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
CC:     "Norov, Yuri" <Yuri.Norov@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: [PATCH RESEND] UAPI: move RENAME_* definitions to separated file
Thread-Topic: [PATCH RESEND] UAPI: move RENAME_* definitions to separated file
Thread-Index: AQHUey4H78M3827Suk2Nk9jyi4wUvQ==
Date:   Tue, 13 Nov 2018 08:51:12 +0000
Message-ID: <20181113085102.3079-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0102.eurprd02.prod.outlook.com
 (2603:10a6:7:29::31) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4536;6:lqNOacNckdLRegtcGpWQRl0ktodN5h34AMw2u829XB6TzjbV5DIAp2QeYYjp9tUvgTBPQugOq/9i1x5KMeCohw5oCKx0jTeNTHJbxlJDJPhANUMfoQgHDfxUdRl5P6VVdiDrxr0whoiYM4TnNXGa83eY8KAiURPSV4SYD+WbEMffW9zAculrd/4l1VnivhAuVM4YleChLi9NeqOpqm7Yt79I7OQk4UHEaQBgUwT6nmKxDNGDOhqYkDe+6hWTQD7UYcc+NlVbsq9RWTo9tIuVERGa+iQ7DplS54wgsbZEMzcUy6KmodmGkRI9/pbKCvVjmx5gT47L/TzEKc/HSGkhk+E2gjg40rfYz029my3V7OhonphHYKH8QyaAwWoYLcXJ8FME8mNp+fL+Bsp0oarecbOa7bgVO1dEIaTcfMRdw1YF7LyCzefDRa5IT1QZz0e83cX3eZlqae7uUUbd4VUC2w==;5:0PxK1hLAEiDTMHYZtdgpiKMHRYAULFdmy1PBDg4HN5OlXGYrbXFRfLHpCM41WNoiIsQQiDIm5UNRgEH44KDJyspDOtQirr6BZVuJVCIyrNhfEFwTkm0cyBYtI131z/1ecDacUeju7AdDmAaZoMEze874ZV24el2jEVRYx6qv3Z8=;7:3Ph3WJ6x6GbLlVFqmwhOiyVrS51v+Biuw4kG84/Ak3ECLKXOo2PNcPKKhxrCnAMef7vUlbC/VFD3BqjalfbYZ/D0lAhCpOskiRmutP0djASKQG+IZ0yDAXjEq6NseLJ2vcfN+UxT0RML5FCxgZkbIA==
x-ms-office365-filtering-correlation-id: 709916f7-1dfe-44e4-5a6c-08d649452a02
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4536;
x-ms-traffictypediagnostic: BYAPR07MB4536:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-microsoft-antispam-prvs: <BYAPR07MB45361E20F44DBE92D0975EAEE3C20@BYAPR07MB4536.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231406)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4536;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4536;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(6436002)(6486002)(256004)(305945005)(66066001)(106356001)(105586002)(7736002)(52116002)(97736004)(14454004)(68736007)(54906003)(42882007)(99286004)(71190400001)(71200400001)(110136005)(478600001)(36756003)(25786009)(1076002)(3846002)(6116002)(316002)(966005)(72206003)(26005)(4326008)(5660300001)(8936002)(53936002)(8676002)(186003)(81156014)(81166006)(2900100001)(6506007)(386003)(486006)(2616005)(476003)(2906002)(6512007)(6306002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4536;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: detYG0BQGRHfcv94WdPbWtf/CGDxQPMZ9RSinfpD68I2N5bVwJBWFJtkOd+Ra8l3DiiGx9zGLR999lVJB3iA1Ql2x/sjihVl7vr2HgM+J27ie/+3OuNI6+RWKMBK1ISR5eIPsKO8lzrAwVNlrurF1tfESVCrBGadmhwFgKSUDCCF3gI1MBD4K4WnttyoqZDEbhLtaOwb4EUG0CyCK0pQ200ls3H2OYSUOH50gG1Io/WVTM0pzL7thoUaNI5qUbTEHfI3Fpuqv/kVd61j4XhMdriDl/Rokx26wan6wP1WOecLf8Ysz+HopEV+3aBbAxsFtG4iO7J2Np0Ofs6JCSv5HJsRJ2miLs/Q2md2Gzo8Gkg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709916f7-1dfe-44e4-5a6c-08d649452a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 08:51:12.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4536
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

In this patch RENAME_* is removed to separated header file that
conforms standards and therefore is suitable for inclusion by glibc.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/uapi/linux/fs.h     |  4 +---
 include/uapi/linux/rename.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/rename.h

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 53a22e8e0408..dbf58bbf5bad 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -44,9 +44,7 @@
 #define SEEK_HOLE	4	/* seek to the next hole */
 #define SEEK_MAX	SEEK_HOLE
=20
-#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
-#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
-#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#include <linux/rename.h>
=20
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/include/uapi/linux/rename.h b/include/uapi/linux/rename.h
new file mode 100644
index 000000000000..7178f0565657
--- /dev/null
+++ b/include/uapi/linux/rename.h
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

