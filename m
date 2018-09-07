Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G39FkQTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeIGFgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:36:50 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729181AbeIGFPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOMQ4K7BauC85bpxOgBDILcXyHMPpd/jlZ8NfzhCSno=;
 b=G39FkQTlgcCb0b6JdxUVymXGSZ88Hj1ph0Q/cnneAdfxKXDoG6SZeMnhVS1wS04FyqRQdO3/IOh71kJbOAQxhfgHHZxkqfqgOV6n0TikiZ/UiuAlLEKUXC2rnqo21M+WCsAhgofoUWvD5o03DQgM7GRXCelOE7VwA0maBN3KXLU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/88] fbdev/via: fix defined but not used
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 45/88] fbdev/via: fix defined but not used
 warning
Thread-Index: AQHURkLPaFfgojEkQkiJmv5FJBSdYA==
Date:   Fri, 7 Sep 2018 00:36:25 +0000
Message-ID: <20180907003547.57567-45-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:sNoqo3/ocejZsmZ82YRK1CiQNYkqydv+Fk/jHAZgleeyVtvqmHsNKojCApaNXnNRVds7ypT5FxdQ+eL5RuqODqmA4+zzJmQF4LzH2/eVfv1GPBiovHVz9oem9GTbstdaxPoD4eIYmDJRy2EHCbsYsFWQW3WgoKjs6gZH74aFSuukaWsCztNAsZTPNvLDjUcwYIAx4mv9ez2LhhcpY6N30MscLmYGrFqWYwdpqzGy9jru7Qm7TRngjJmFU0heQbwL9dq1TQvI1XKy9Hy3kWes8dJxOp+GLdOw1dj3MCRN3Corg/oqpJTS47s88CfTyPHoMr2mw4VtDT+TvNuUyscDhAVNoY16Wk5okP3uL4TpEUOkgp+mQVT/h3/MJJ2Bz2ssT7d7/RhcYpA780gpciTRxznaJxw25eo9b13OOt2fgLe4nsA9wr9Jr3jTYfwt5F7zIs7Z8PZFakVBpzyKKNJhrQ==;5:TAZqf0Ihp7B/VLOq1WZKLLpoTTfGivrR7lVH8uBMi2xLcsuM+gNMqJWI5AjZh1vBWcAUEwveIx5WaGOIC9N8p1lE5W44+Xsx6L+FLsYU4NoAlfoUKcukvjWSpsb3Zyo47Fr8CfF96OP49diGsxk4fCKFIukPgGJgBe/MnQhI9HQ=;7:gXOW8hkRiMpBhqQ+pzAZ4FbJqOibyb000HVsZtDM0a+yGiJ8Qf79dnbxvQQqQ/4+/GTZANn1jm6AIPnjR8ua1XsB0VMXXdFtApk1899yaMQE57etCi14xLVyTGsgiz014fTSUBOCcPUDuenOYffdrQJxCDlfGpY8xhkTXQS1bM8cqAXTWy1oeIWUF+Hiqr6hYnyMZ9mwoVMYfZlxn0kyoHkGswqr2ivFVsy3g1lL7sYfLdlOE6syJqUrb2YyRl7s
x-ms-office365-filtering-correlation-id: a0edb09a-d2d8-46e5-429f-08d6145a011d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773DC9BCA8B0FC24E3AF90EFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fW0KHebDd2/fGJkSJJa6a7ckzV144hTDs/3uCgyPsPfvvqNLRH8UTkg9gzC9jL2eV7yjISQI++Um/oxj8LuZnI685AufjWrrYfHgDfpojxdnm6jYENaOEnXlxPfI3GNL8UsphfdhiXhLZHSiba38lPCXgOlaWkGsw1DINyrI0YgPg9kj7vmsfJTjA/zM12PETk01O5dQVvI6DiN0pumh7v/YMxMmUnWijcrq9psa5o86PQiuFVh+RB/ZY2ezU2JhmdXcfKuach2/yyrFlR0qafOcFT42Qwv7VH/66Ui46EW1VJOiHbkWBKIYgE5+1nomGZiXztEc0ZBStVd/v9LYU2HcujQHfyLnhFH1782ea2c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0edb09a-d2d8-46e5-429f-08d6145a011d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:25.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index d2f785068ef4..7bb7e90b8f00 100644
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
