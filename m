Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7420EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NC77b93j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE9B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeIGFUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:11 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:49312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeIGFUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCWbhETRdRDl1yeWQ8xk1giFDJ5ZakcUCIvqL47/O+0=;
 b=NC77b93j3qjOkmmovchZ35nb5XrFnmDAlxHE341al9HkXIVDdHY9lB5ZONSQ5YHciAxVkTN+O376/gKETsCyKDzmUGO0qum4UDUncyNInBJkxQQ7PLRbRycl+yxRjWrpZh3hYV4BSBQ3NTf/+TG1rIToOWEIdVaqEu/dI5B4Tu0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 17/30] fbdev/via: fix defined but not used warning
Thread-Topic: [PATCH AUTOSEL 4.4 17/30] fbdev/via: fix defined but not used
 warning
Thread-Index: AQHURkMwaL8RueWk7kOFH/cxKBWObg==
Date:   Fri, 7 Sep 2018 00:39:09 +0000
Message-ID: <20180907003853.57942-17-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:REXZixj2+NYLcZu2bp+s1oAhYYG50Oz4wC2UZ1bnxWYIlpkDAAKtuuavirWm7UwEOx4PuExEW3Gf/gICP1fblSvfolljb1TAXajwHcbOAvE6GoH0s9AUedERotaYHBvWShhk13/UT6MjLbYjw9B7AA7gR2ivbuupGtVYTmSmoJAjmAprQLbwxKhzE+76rTsh+PlkVZQlRfnUJQCwDMtdFMNfvwI+gw/+G+iowznbKLc+vg5/K+wYA2JzcbdfdfAMlzRNFAKvn9mQVTWTotcTvOBijJ+G3gaoIBKjfsSaGNxuu5FHjmkh68jSx9uUz1f38LcFKxVywGVs07XsEg2TGUuG2aiwhd+n2tZVdEHhHIzeTD7PTjK0eKDt2nJgFXDwynDbbJ2X3dAQSCfqg3/8zudtqLapg6c28F+NgiqbRh9xYpXkKB37853WQgJxL01LyI6hp99wUtKt+9/n5A7zMg==;5:AeY40Jx0udlZuHoxxW8ehSAOyIGUWl1vum87F7avHP9aBttggUep1RUxA10BLhK4KGD2NtLaGcodAEfy2LgCu10cyvQywK+4GiFBKFdcVXv/H5IM/YluH+Qxk2oNx4aCWH6SZ0RMyFZv2cmncjXMis8TM5jM8SDlxTz0jKybAG4=;7:2wvAvvtIlIHa+yb/syyUpVWqbpyjI+MP4XXkaZa7OcxqUkjMGGjhS3Ine8EcCw/rsBsPWL8GhxfJpW64tmjezKlrIWQT7Jk6ZotHPH1r2DUXo1fmSCn6fjZ2iA3IK/Tl4Vdkh4Loe1tf4AUiFH3XAIYMRYcLvPPYFKGnK02UleFL5bvRhdp74DXOMFSLrqva21qrFAXwnBOtKqkr3SjJKKzt26x2gVXfTUiHRNENKgCVY3UYasZB01cZQjXrKSh8
x-ms-office365-filtering-correlation-id: 8bfd7eb7-1aad-4e53-1ae9-08d6145aba1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822758F4EDEDBBBFD8F0B77FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qnzrMgLgVZkaF8si39my2JC/eFHkVNHaDtsGorUoN4ZfOhktijkcpc1V7+kAwH18Zpv1DLyAm1vJdLDnB7+phIwCTaK4Z9eDnOBEsz9zjYjzbHMPXoGMCxK4QSeDKAJJrotK68R5arZLr8XHJpqZKqRvf7jmBjPawI7G16dnndazrpuGECIEc94IdvNWpHUnJRUyNJNQMgZQHW4L4mmsAbxhNBs0j1y6l4sR68iQGizFdIk2OPzB5FSr3TK1OjieruvVEoxndniKTeuaaW7o0ijLfVfC3LrLmuvJvTSwIzqFMIjS0iOecJfji+v/52qsMcSU6hOvEf8vg6ZTCBe5QtF6EetwiyFewuwd92LGKBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfd7eb7-1aad-4e53-1ae9-08d6145aba1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:09.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit b6566b47a67e07fdca44cf51abb14e2fbe17d3eb ]

Fix a build warning in viafbdev.c when CONFIG_PROC_FS is not enabled
by marking the unused function as __maybe_unused.

../drivers/video/fbdev/via/viafbdev.c:1471:12: warning: 'viafb_sup_odev_pro=
c_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/via/viafbdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/v=
iafbdev.c
index badee04ef496..71b5dca95bdb 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -19,6 +19,7 @@
  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
=20
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -1468,7 +1469,7 @@ static const struct file_operations viafb_vt1636_proc=
_fops =3D {
=20
 #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
=20
-static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused viafb_sup_odev_proc_show(struct seq_file *m, voi=
d *v)
 {
 	via_odev_to_seq(m, supported_odev_map[
 		viaparinfo->shared->chip_info.gfx_chip_name]);
--=20
2.17.1
