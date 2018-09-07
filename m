Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23539C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F1020857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FdnCZoGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F1020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbeIGFUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:48 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:56221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731263AbeIGFU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQbspvzo1VWbd7QaxL/xU5hVgdv8g7zHcrTnLly26pk=;
 b=FdnCZoGY9S7XhQJN2etkDmeDcVrC9yChStmpi6uwRy7o+ugdPEkVJxyTNrOewwrEVl3/eDeWJ6gmwxKURqisMUo/KNZb8c3sofSIAkwB/tjlxWjwZAgKFoOQQUAMWFnD3EBr4q7LYF2UkiJXLyUSv6WnVZRIhXCYzMN1YjqsllA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 11/19] fbdev/via: fix defined but not used
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 11/19] fbdev/via: fix defined but not used
 warning
Thread-Index: AQHURkM/nIVnyqrKOEGAlDhkh8Ln/g==
Date:   Fri, 7 Sep 2018 00:39:33 +0000
Message-ID: <20180907003923.58019-11-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:CKcQ03+4/cHKPN9wIcDzMLus94Z0/kaXC2sEVukwZX40R05QpFrSs2uxCTPRsslh3m6bRurAq2rKlPNqF9AJ8IYtC/5wzVvnyanJdxyMONBBD8N5O2j9uDCHz3fne2uBmbJ63X9DRQcJKw5XNOGvHokX83kncks0Yu4hZzMf84xJUqQm+n5/T+OeSL95z8XdVjXCdVa/tGy9as3xMbpWPNN6dyMWx9xNxSsA+LBRjo0j/FaSyZd83RIEl2D5lZntx8Ry5mLyE89TC8HLZzeZlkvmiq4u0vYLm5TA4hFmCndf3ig7Co03WRf/XFj4YaUAeptA1VkPOJWqO9G+S6UHW0Y+PNYATOs628Le59wt8IH4kqY6KdoMTPM6uycm2pnwVkeRR0S0bMKA0XrVpkgQz4BsdUDMKX/XBVpSYXD+gSkJL2z6D726W792UvChMwQDzzojvGgH8QTYRi0Wd/CuAQ==;5:i0/1lSM145rOHAhG9shzuaocGO/8YRU9mb6LDxzzLakxnXuk213fPV76cLTbFRMOUNUCdD8iEcTq2UFYjSEyz4SkaGRIbGuMlDT2zlazeHKiKRHFuesng4HweKX7NdsCJORPR8W3OOp02Ck18ZoIJnPIVbdhtUVtKE2MW/xtnOg=;7:HjVpPBkiTwVjW1Bo8HZBYm4xLP8IeRwG1YWGftLt2j7NqDr8GrJK4EiN9uLr5UjsjBN05i3T4Dvg8KcAITdCD7bsAUkVGsRcxLfmMb8lN1u+SFsXXi5qA1mux5/QKetgWynGel6BO1RoM/l/cQcVyouhfzCj26zmZoiLcZTwPSmbGPjgmyDDGxkWaeSGb4cUKvL8mXphNI2oN7zoxB6NHNfN4scKuC6sB5LRQL5rv6p9id3a4DhysNy+9JDpFNGS
x-ms-office365-filtering-correlation-id: 7cd855ae-aad9-4111-9b62-08d6145ac101
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046991FB715CEB6CC624EC93FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VbRF7XPva64LMQtA3y0JWMaEP0bWDScNP7xWaaB2D2OhKJGkkm/kO7ynPsIU+JJrp7d4ly0LBWdM+9ECUz9Rr62c0eRe8/Veii2YtldaZywbn6tF7786sX6KUiWHrSvuOIryPmaopX6N3t3cRuoVSbnxY0S7b6Lk/ZzcqtJSzlFyQ3zRg/NL6BeXZa4BXtlbAQ44OgaM7afMvsIBFGm2ck/CukxL/kkf6fBwOYRahxvEBhkrbGKFuEVuXSKyQMEg9NM58NHt6Oli6TVi4CcScfpHGZWtwMr0YrD650TMfOxqdV1RJTO7V8IHJ6fa999NzhrHn5wJUGUouFwkpUyVwu/rH/5OoFhCufEYiGaYBbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd855ae-aad9-4111-9b62-08d6145ac101
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:33.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 325c43c6ff97..34bafcd904d2 100644
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
