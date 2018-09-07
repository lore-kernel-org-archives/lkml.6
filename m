Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B851C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CBB20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c3tx4SbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CBB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeIGFTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:01 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730743AbeIGFTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCWbhETRdRDl1yeWQ8xk1giFDJ5ZakcUCIvqL47/O+0=;
 b=c3tx4SbQtbzNbNuok9A7cWOpBLcOM3lUnXycr7FkO+0xYsBJ6Vk4RR1TmBHjvs87b83FDICX66ia2suSeQ3Ft88Q6MQoG6ju5oej91Gmx8sOgDzAcE3vYpNj18S0RhtodwC2U1koR4A418c+kD5TC+9VEd8PNgF4n89l8WmkSFo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 21/43] fbdev/via: fix defined but not used warning
Thread-Topic: [PATCH AUTOSEL 4.9 21/43] fbdev/via: fix defined but not used
 warning
Thread-Index: AQHURkMbJpFoggLSWkiTZGVg0yGHKw==
Date:   Fri, 7 Sep 2018 00:38:33 +0000
Message-ID: <20180907003816.57852-21-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:liSJy3Xkm8sSxvoG60ElI5aPlqpibFMVmZJwYfxE93UeUidCH8wP8q62BqBDIFmYSTd/vQjSqpOziMLZsxE7HTm18ZeeqyMD/SPbuBkO2jkfJhan9dm8wNjk8w9kdgmDlbLFxdUwl2qsG6ATPk8eRW9jkZm1OCc3Z3q2Ql9p/J4zC9TAWbpsP5AFIury7q0OBfPXYltQE/T6xCsmJKPtfDni7WtcaOEQKIXlCv6TPO920ekTB6KVyxsXvq6FZYddcvtqHnK+AfxKWGVHhn8jxDZ4T3yg9EFzWzkop7vDhsCcopF6KEomGasHFWDrM7lVO0dTTfMcQ2pb8H3ossr5gezCJjOMreIuQy7IZNnLGHUd9bkEt7VS+5TarBrvORCSGMiguqIHObpvA8ouY+QjbCIHRbre7dMDERTJ+mC4/0oMahJ6EyGQSoG+oe8SzF+NC1AKM6FV6MZa+GA2VuOYyg==;5:OwgfFQuNGo16rI41G2CU0/b9jJM4SJPsLbEjqJ1C5vvr9pUMpiFmldHGXagg1I5pYZmnQq5JZDX4r7Ua5tt1daKAvG5wBbOXWJCT0pQ2nRA6XZ5I91m5cJtrdk0A25r5QLfeNICiP2jIH4uOEC1yZafLoWejQTJIh8UIWEP4otM=;7:kvktx40WUxdjjZ2L4BDH98utoFk6lGFJ6+aBW1rc6XKkOQuCKHkZYhVVouuGrsFukP3M5eDYSCK67rC9lub0wTfaQaPnaj4qlfb9thUKLBZDnailNMEid0188w56jp+YiX9FKs73VRniLBEu2KUtGnX7aK/OG0fBRDjG4AgHXDo7jZ1GcONi+Oul8TEYMiGFgWU89DwTRQkyu9EjfvIPJp60JJ+bOeNp0PTjlXnn8afMgCtWm+icCzod7yDJK561
x-ms-office365-filtering-correlation-id: f87ed899-5bab-4689-e60e-08d6145a8c4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08559683849D7EF05D3D4165FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mpEoorVtTIihrgbcVIxf+bkfgYpVdt2BifWTDtQI1uaV0oOLz9Yq4Tr9oX5Q+wtRaErM42yF7oAU6hNgutobPtxOPyuRQbv2vaSba41EMY+nH48ww+EhpU4XG3B0+VhOZILjH3g9qREbjKduaeNVuTCMoP1Mb3pzu0XG2vh/o6UR9bjmQ2o+GQ44zeU0QCME5hK66VkebyCRNgHILJUaFjOvU9M1NvB7XN6GixhWsJO+utQaSQZUt0WhwBHrR6u2nois91skLZBb6V63t9WTaaos/O5pehepDTkYQuoBZB76bzkeiKkpw9+qsov9u8aRrSbgxXkhFNO+W1QfhVAz3p7BTAu8Gf2Qii5MPcSXGtg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87ed899-5bab-4689-e60e-08d6145a8c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:33.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
