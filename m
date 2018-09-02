Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83662077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E0NetKTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83662077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIBRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:50:30 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbeIBRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI1ccH5UvVsLN4dIJmmlm9RqvUI22RY1DA8i1XvSGAU=;
 b=E0NetKTMwkAZtg2L3i0lzld9njjpJ5o3HmaEYvOlrTfUBAyzdhklMnqlFShwTNry83vKZ/d43du6smcOQg9gu6DBand5KRtgUEn8Foz90l9/TcEZdqW0Gmhu3elF1i5b6SrdcR0F/VB/2DmTuG7gHVQsgE288S8hgkuV7n99JSo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 041/131] f2fs: fix defined but not used build
 warnings
Thread-Topic: [PATCH AUTOSEL 4.18 041/131] f2fs: fix defined but not used
 build warnings
Thread-Index: AQHUQr1mJjARI80mHkyCipLKNmsARA==
Date:   Sun, 2 Sep 2018 13:03:53 +0000
Message-ID: <20180902064601.183036-41-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:hlgbhrh9s0FeSbtwA1KZv3tuVWqdYrq3C1eqHUtTWRWBLBXxikOI0SPmAHTrf62p/8YceFt2TejGvzf371Khaqbs1isGsv8BtF3JtRiXsb51W0Bb7ir82TAGFEWMcTHB3ZzRhHQN2/JSQ3dE93QAJs7nKT2v9RGkjaVYEA44LMa9Kfz9Dd2DmEGuLrxs7t2qCY9jd0cx0XSMmAyNurDR2YaAACRRespNGkM0ZGiZfm1fFJ+IHFyKo2Lh2KXzoSxePu+zfWzP2uUmpP+p2Cc9LBEJLbFD19e6RcXQLDB+rAk2SHIlVbDNHFuAagLJyY3AyCKTpdwSGOQEFRK5eZSnj7p8LsO/VrXU6J+EqyCmOxXJFGLiT1eTAQ2RkrRdZ+Yvpuz+g26iMsMlszE2cMergRu0k6h+GirN6lJln4iLU7Pz9SnmjPIMYevniAK4WntOE42O9nEV6TQ58VZDGl4GhQ==;5:eEX2sUaMysvIaNxExsgGn2K7O2ipc4FRObRlZmKToi5neSwJ6IPfM254BHht3lb6g3r7CrmXGltWZz+xX/cPoRgZsP1lWoZx/l46++vJjh9y/rt/Cj3uxBRbe8DPAGe39pFJ3bBZkeCXFclEaWIkaLN0ozIscpGTwx67NtUj1i4=;7:wjPW3YvtX1xizKicejoDChgZTjgHhyGsUVw2RQS/C5nXtl7qytHG2obe9yDl78RpfMOKrgCZpm4DvYW5obDOWd17W1o5S3VKeSqbimQbLyqgv8HM5ZE2DoSJcy68egcMC8FN1AErVFj5rp3uFpSRjepU56fotchvJmaP8Wv90v+/ofO7aKeVbXY8q6DWs76Yy0FIGwboR+kxTM18aT+FF6y70wYdjkemkHcynQRPvuLxl8SAZWjCNcDJjUtM2kVJ
x-ms-office365-filtering-correlation-id: 1ba4a2e2-cb24-4b16-afa2-08d610d4933d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135DF6E316201E42D5118E4FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(28532068793085)(89211679590171)(50582790962513)(42262312472803);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QSWmPH7hhy2NoYollzvxPzQ8+LQSScJ9UHWwZEQAoCEpaDJUi+37B21z7UE9SQ4m5fAwaQE8MmGhC7iT6iSW6U31iYUTcUCgMx9z8DYG9QIhXmp6a1ngYOjmY3wPXNjtww/YYtsQ0ZfEgLx33LlI5BzIBU3h4FbGQ9y9IVy9+xGzY1ZPfxgANUFwGNNYZp+h5vAdCpmC2s/6iezgr+ynt4QqBx3HQErHFOLWEDtOSEHCORnH6QjHEde6OMw/BnziQNC4MIIeaPWgClkZHgR7FJxWYjDCNMrifnnLb6xecQHwPAq6+ZRVWEnFkDJfJ5UjnPXMKIfn7x/e1MbxNFOe7lF03DErB+q1NcFfiUTAFLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba4a2e2-cb24-4b16-afa2-08d610d4933d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:53.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
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
index 2e7e611deaef..5344e21853b2 100644
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
@@ -516,7 +517,8 @@ static struct kobject f2fs_feat =3D {
 	.kset	=3D &f2fs_kset,
 };
=20
-static int segment_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb =3D seq->private;
 	struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
@@ -543,7 +545,8 @@ static int segment_info_seq_show(struct seq_file *seq, =
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
@@ -567,7 +570,8 @@ static int segment_bits_seq_show(struct seq_file *seq, =
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
