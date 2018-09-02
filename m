Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68EC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE6C204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RPZDE7t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeIBRXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:00 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3jtWaM7yjR0d3lpddEhAUHh/45+h2x/gvdifvD7kdg=;
 b=RPZDE7t1y+gYHqrzS652FdgMKZw6rIvLCNVJiawiFuMcXMsOYToUNV0hfP5IkgGcr8PuX41vfQmmJAt5S9ikaE36VRRB1rWOkRVbiRd/c9/S6+sm1gLDC0xZf1InP73yicisUmR1yw2zU+9qrGaW/mKpqFK6Ut2BVtokaDPJf0k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/89] f2fs: fix defined but not used build
 warnings
Thread-Topic: [PATCH AUTOSEL 4.14 28/89] f2fs: fix defined but not used build
 warnings
Thread-Index: AQHUQr3KLj3uW3K82ESF5Tt2QGxkNA==
Date:   Sun, 2 Sep 2018 13:06:41 +0000
Message-ID: <20180902064918.183387-28-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:WrDw9fED+OS6B9qGjA9mFBrzizkEgxH5JMFOs+od/wcwYMI8HUYyo1fyjm/gzyy8aEQlA4ZIXJrgnurTcYqNTHLMM7DzDjA1joBVUGw/KBiMpo+h4GGngj+Ye1VffECAh49V0o4buOCPyzZNdf0toqrQsed9akZzo1bSqZ5vBAwHC2Q+xQKsWTTxswKXX3I2mFGx5u9UUDcpyLtJbb70Y3BbBRVpwVEbNhbLlzQIimZ3L1fjdhzIswfK18StKbHl/QagQCqe72k4NpRfmDvqZfIeeA1A3ou4wT806gDlKJUtdj36bzgLoH1f/B0nddigvbgPYzgLP1f/fhw9wN4QZsUuaEYt5yoiAsiSxZYUAaim5LdwBCfDD7E3E50rume1LTrT21Op+OR86db9vkYVkMKkYPwHgmU5ASQHHs74QvH07geyZAXUiXp/JTx6+New6VzVhQIm+FENScEVl5pDSA==;5:1DZMxxoEEK6JHAXzLqBPJuvnfFTJyIkPoQLX8TJVsbBaYyCcGyXXi9xTZOIDAnNIU7DaSvGuMGNVBLEfbiZ6zJYRb/NeP/0EbuW8H0618q+0krAgy1FqLKp76Mz0rVTPYLAfBjzd2nocDM7bJtz7sbqcEyFuNiCG+BkUe27vo+U=;7:i31lCIGw/EPPAqV+so6exRfFCA4sWt87XVwJRLRpDnD1VadV5O32pNE9l+Y7ccSGHNNi7vXukxnoJBA8v/PN1UheCjR6oFpZtQyxsrvGVqlYxajeInizHeqlGSW3nC53JvELqv9ay/ADtAo2XdavmKSu8ICIDmQlM9UsFYoAxr/8eOz6Mn4OHFDY7hJi4GKtGCx03ckwKtOpARpCEb5z7+ZVKWIcJfj4ysBruLLTuRaDdnj0WOTBRxBEGJurs1nG
x-ms-office365-filtering-correlation-id: f02310a1-7595-49e0-37bd-08d610d4fbb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085653052FC6824B354C19EAFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(28532068793085)(89211679590171)(50582790962513)(42262312472803);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M0EuRjpANApFK6ie3jHbGL4LDSaCfCjnWH3cR9FEFi3tJwGwuPKeiSHxm+7gE4IzJ/Tq89n6jTSqQb9WysK1294KuV6H6aGw3t7Vm9PstCph26GG5DNn9UgbtX3rcyRu6RfpAAcPq/+R8dPN48hJLT6jTJoAgU1NRvGFH5MNrdxzogpWN9KLCEp+RjKDGlEa4Sw0L+VBQXrEGzJkdVQWU0oT6RJpcwhtMR6fQt+wLlzPm9rOK/1EnfDGs1wVNM1NCBsezZBC2XRDiZfPLYVT8tPy5TzPbUR0o0M29BHSUpoTwS+UvJjhNEbAfL2JwBicMriMuSYSfhGuH9p49UQgGIf0qS6KczM1O+QrvskT7Mw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02310a1-7595-49e0-37bd-08d610d4fbb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:41.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit cb15d1e43db0a6341c1e26ac6a2c74e61b74f1aa ]

Fix build warnings in f2fs when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../fs/f2fs/sysfs.c:519:12: warning: 'segment_info_seq_show' defined but not=
 used [-Wunused-function]
../fs/f2fs/sysfs.c:546:12: warning: 'segment_bits_seq_show' defined but not=
 used [-Wunused-function]
../fs/f2fs/sysfs.c:570:12: warning: 'iostat_info_seq_show' defined but not =
used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e2c258f717cd..93af9d7dfcdc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/compiler.h>
 #include <linux/proc_fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/seq_file.h>
@@ -381,7 +382,8 @@ static struct kobject f2fs_feat =3D {
 	.kset	=3D &f2fs_kset,
 };
=20
-static int segment_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb =3D seq->private;
 	struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
@@ -408,7 +410,8 @@ static int segment_info_seq_show(struct seq_file *seq, =
void *offset)
 	return 0;
 }
=20
-static int segment_bits_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb =3D seq->private;
 	struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
@@ -432,7 +435,8 @@ static int segment_bits_seq_show(struct seq_file *seq, =
void *offset)
 	return 0;
 }
=20
-static int iostat_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
+					       void *offset)
 {
 	struct super_block *sb =3D seq->private;
 	struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
--=20
2.17.1
