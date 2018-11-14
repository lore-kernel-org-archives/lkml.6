Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57414C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E992086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="J9KNV+Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E992086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbeKNR2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:28:15 -0500
Received: from mail-eopbgr720077.outbound.protection.outlook.com ([40.107.72.77]:59840
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731385AbeKNR2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tHiuUp39tpByBVR2CRCLTzFMJR3GVaFklE49BKPWto=;
 b=J9KNV+EgUPDz+tiY01d0ipHV+Dr+c2GCSaeCV0QHMflDodzCH8hMwAPjTDqGdu2YY41tcXAekqkPJ/xlfS2bbNdeN66z3mmYLnQMKVSzkfF2BxHEb9/sJccdiHCZmGu/TLi3o9fQEwBGbk8WrQ/AThLlfingobARdxjiIJI8Zjw=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB4872.namprd07.prod.outlook.com (52.135.205.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 14 Nov 2018 07:26:07 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::98fe:75f8:e8ca:f46d]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::98fe:75f8:e8ca:f46d%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 07:26:07 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
CC:     "Norov, Yuri" <Yuri.Norov@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Topic: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Index: AQHUe+maZLYYsimik0+i7t/nnXCYJqVO3sCA
Date:   Wed, 14 Nov 2018 07:26:07 +0000
Message-ID: <20181114072559.GA16695@yury-thinkpad>
References: <20181114071346.31210-1-ynorov@caviumnetworks.com>
In-Reply-To: <20181114071346.31210-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0115.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::17) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4872;6:WVStZ5MEYH67/BJ97Axz3MeY4hcqcbx9KsDoL21F2RuUeQWv5mlavbvS78gXTQ0egpkmG6xBut1KeE90DBXa1vi6lsBdIfaRGxocbgADnZ12OOPKkBbBqS+DdLy89dHloBCkejLHHYQlKBQV85Jp74C9jzW2JSycxW1XnFgRxMiNzOzAxIkRnkAY4UzYEsUxIbSnQTMql/5MlkA6yKEp5Wd/nlDWBy2fusVARPLIJd+IF2zVZuKCQvTNGCgj/DmC0n/O6LVZMTMsCejceO8wLR0Enl4HNkamDT1p2VL+E1A4neWXadv/KfXBAgVM7hnItqB8l56/UhAAYLcI/DmNXD4bLOpHSVA7phFtHZUPEEM06Tx8JOT35Fn7S4fpHRAG00IlLvq6lBKijx8j+D2VMhs012MR6HGtY3IczphpuxB4+wpfW6qCBTttRaDEfhy3OQlNWb2Z77MvMV9jgWdrVA==;5:kvYXV6g0ISE2L+6usXyP3RORl5QUf1CfV+zzrC+LKHE7RD6eT/4HPYUoxQjjWBSKjmkXK4RAwMgZ7tbg/iCfzNKHZO77L4qSqlEvRzXcIFzU9uyY2385C2BSRKJEVoMdTUjvlmzQEk4PgGpwdZ3mNZGR//+TiSkxxcW/rHSSh70=;7:WjVEm3peXBaaEtUG2zF7KUsOtwVL/K3FY5nEqMGqGJ7X7jWMGD9pDvmP7p60jjvJ9bQYzdzADSD8ga5o7J4J3MoIANOIsoupOyeQGMZyo1aQvd5Ah92E7Q1o1tmG+yPbLRItpDXPLmtVYNy4KWFemA==
x-ms-office365-filtering-correlation-id: 8eb25b21-9aed-4e72-8b5b-08d64a0270f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4872;
x-ms-traffictypediagnostic: BYAPR07MB4872:
x-microsoft-antispam-prvs: <BYAPR07MB48724B0CF81FB0CE0BC076C0E3C30@BYAPR07MB4872.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231410)(944501410)(52105112)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4872;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4872;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(53754006)(14454004)(102836004)(42882007)(54906003)(186003)(966005)(2900100001)(72206003)(11346002)(66066001)(486006)(476003)(446003)(2906002)(76176011)(52116002)(1076002)(386003)(97736004)(33716001)(6506007)(3846002)(6116002)(33656002)(26005)(33896004)(53546011)(110136005)(316002)(106356001)(105586002)(71200400001)(5660300001)(6512007)(53936002)(6486002)(229853002)(9686003)(6306002)(6436002)(99286004)(256004)(6246003)(25786009)(68736007)(81156014)(8676002)(305945005)(7736002)(478600001)(71190400001)(4326008)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4872;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pf1VeVxsp07VJYydu+SOOYEl+SuPHcFkN4dxfS77rJJ5mG14pRKYgV2UFfg5W2/GrE9Zrkk/kD2zgv3GBXo9D0skSYPFtvCBzm7ETr2TlSVMxDkePEUGqsbAG8GGqFS2faT82ORtY2aj/zMs1IdSq1NBbPGGmiSdde5NUbgq8ycCH4+I5K3WZIupUj+pE+QSlXKKaqfH/g4XC1fJAVY6oQXc9Zk3IsVBqibIGnBF5rMXu6M+gCEZFENAu89qWvEl0Tc+glqQK4pL8C+co/mFFyFV8uaKr7gj5BwkyNESAFWFz4YMiToh8Q/BGVZJidbItFADKNImZbU3HMNFb/WjevEWicCEZmNriDGm4BJwNqA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D1644F668FEBB4682C6DE6611F7C69B@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb25b21-9aed-4e72-8b5b-08d64a0270f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 07:26:07.4394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,=20

It seems that I forgot to rename guards in v2. This is the correct
version. My apologize for noise.

Yury

From 61215b1cb559e69fb57f2a82864e72e3a1ef4b12 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 14 Nov 2018 09:51:49 +0300
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Florian Weimer <fweimer@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH v2] UAPI: move RENAME_* definitions to separated file

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
+#ifndef _UAPI_LINUX_RENAME_FLAGS_H
+#define _UAPI_LINUX_RENAME_FLAGS_H
+
+/*
+ * Definitions for rename syscall family.
+ */
+#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
+#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
+#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+
+#endif /* _UAPI_LINUX_RENAME_FLAGS_H */
--=20
2.17.1

