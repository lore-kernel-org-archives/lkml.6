Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746CF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GefPhBDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746CF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbeIGFRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:06 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbeIGFRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCWbhETRdRDl1yeWQ8xk1giFDJ5ZakcUCIvqL47/O+0=;
 b=GefPhBDdUCNlzo7+IpaBXvmLHKL+4xBtSKGlVit92lMrO1/4S/jq/lYrSzicvF6qX8oqpG8hdJtAoKfMjwDumodadFcNhaqoGNjPUD5k7vOOSrch1xU4URB7dd2v446+omAzY3NF8KpCzH2BxBPoDUsfPSJ0VC1pni7sDf0pqu4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/67] fbdev/via: fix defined but not used
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 34/67] fbdev/via: fix defined but not used
 warning
Thread-Index: AQHURkL/x4jOGVUAB0Od6bemdl9AVQ==
Date:   Fri, 7 Sep 2018 00:37:46 +0000
Message-ID: <20180907003716.57737-34-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:jLLChyhwrxYiJhrWVNePCEL2wqTMkfvKJ07gCdtFXWko4GvqFqwdhYe161NKRK0AMfI8ptTzu38BhJbTsZd+Pas/fJY1znEn8Uu9ZAtg/6HgPyI2h2bxl/S8JMzMZMJOsqMNEKyA2mfGVG1nh5hwJofOF7kMVDqMGHBvKcjVNS7Y8d4OP5EV9yVsF7SlZZ0CUK51zPtc+Qr94o/20sc4RgmobqydVGUqOmR5APOlgfyPh4u1jVW7+/LIsWH9hBzU0VWT5M7L9VjUsgp+oBT3txzOSPMCqF4uI29PFxE+G8FNFofYTsWsZi/gWGlYMv44Utk9g/+M/2hnlLRFYv3h6E3hUWXHVHNiPsT3BqJyWUbKYQ/Ufli69NPlQOZvo/JYXlaQp8WxkeuBe/MaGdw4d3+jQq8D99wiLrcpenMq6h71eWBMsE5UE3xEubXvzjZQHiOSyIa5h/gyGbY+3KOLLA==;5:ike16ifUPvz87dtNR1uskANRPp8nP/45avUCf1r5ZSOrZBvhHn0jyfSIDHmfIzhCSDx+JkB5U+LpckT5FeXRsjPdIomHRNfQxEl6XF36FQkgfMlDGpe3Oa37XW/C+XQOtP9jcB0as02IQPvpCjiyFCmWCq5HLv/D2UuJpGrAygY=;7:lgKRUYVtARpEZPsO0cBPT/iS/3Ylw8t34XkGEANPCkbj1oD4E2U+pVkS40lVqzSktPzcXChBUSAr4gK2PWCtYOAht5isQ9EWct2p9DVulsG3wx7AeZzjm6l2ZgYc5mxJddXqIMwAgppcPQjsbZN/a1e4TG4sDmOocXFg8pAQQBRxhRnijrJ4pva9OoKZfh4w6Sqt+Urn6Gtd0f/5G4v3+baXBw+sx1vEk8qkgblYt20aDCXAAV7JAYMWePJpJeeF
x-ms-office365-filtering-correlation-id: c9eae5bc-6521-4060-830e-08d6145a4b72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB0696DA8B2B7171AC4FFA02B1FB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(14444005)(106356001)(10090500001)(2900100001)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1LLz0/TEuuk33pJRJIIIRiNxW392HhyRw8Kv21xSfzom3MdfePnT4kSh+buxiEgH6LsksJnVgKZn7ExXxbawAXPU/SSTlClIzaQkB3hzBWDpCNzNmg8LvbVmsulSmOlDoKu8ymR5/uTaiJrEiRL6J9rh/fUL6P04olBN5VsAiPfBT85sZQDc0xAHbQ0Qa/OvmkZ1Jm4r76+L+S+ix+u8RaGqF757hbLGyRZxNSG970+S0nbQ5TGrBquRxFIaedzXaApes2PqZL9+mjtOt5//Y2YHO9m7eIuNZDw0emU53SuqKMWgbx4cieqC9qjFGTeQJ1v2wzqz0nycazhOCLiNzi1wQVeKfdYDxMATcrbiVqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eae5bc-6521-4060-830e-08d6145a4b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:46.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
