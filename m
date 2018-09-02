Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581452077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pn2XnxWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581452077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIBRUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:41 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbeIBRUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1i73d2xR4FyRnKS8HbICX7PY6Wba5A+NnQugEPzwHU=;
 b=Pn2XnxWb2uYC3ZxCcVRA5wrugS6SS6bIZJleaGlt6X3COJkQTF7esYPMh/lJh/x2Yeunr7pi3vqSt3GVVAe5b0AWgIYKMAHuHvs7px1uRsTXaVgus05rJtl88WRQz8QGaaCBjVXsrIO1TdHN/S5uROkq0IC457LuDdg/KirTwVA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 057/131] rpmsg: core: add support to power
 domains for devices
Thread-Topic: [PATCH AUTOSEL 4.18 057/131] rpmsg: core: add support to power
 domains for devices
Thread-Index: AQHUQr1xXVAes5ieb0ix5i/sIMas5A==
Date:   Sun, 2 Sep 2018 13:04:12 +0000
Message-ID: <20180902064601.183036-57-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:tZNrxgSy/2gA6xHu3etdOx2f6GQwnjBE1apWqe6Kg6CgPIUPWFDlZYse6AawqqEvA1j+GQuXRpqF8w8grHPqEjvsCgkQLUuu2Cu2kxIgMuWmaDhLqmsJvyn0gmoksCeqyXk/uQihKkwad8sNroS5ctcVMEZdf2/pGen7ZL9500qKxMA4VN3CZc6mwJ6O9iBnEB+ZR2hBBaErdfWIQ3h3uQv0D0Ye5i11RAnGsrKWf6FspZP3f0+XYpiK6cORk8q6Ps32vpR2n6e4Fx1TzyMVs/aVVUEI8ij6xNN8JUr1PA0YG7JQGgFX4NvSR8dH0COwceo/Im4mbj4DxAvePb/ZdpUQUU0XxEmVUG+GH1JdC54mWRGyB+TvSuookOyUIa5xNhmOx21ghR/LNcK/+JALmKZD4VcsFCeXgeUELMcAZwydOP9GHdDLPxIjPtnVwz8GoeOh583HqkY4/KSBOwrDYg==;5:M8Q4Elv8arDFgDHHkwO4/kCdxJomsABAJrTraqRRYFyYIyJqNaBYto+N7n0HLkK6K37OQ1q1v4Tetw3W0FLE4SEKqT1CFnnDrtuqAyIkoViYACC1ZmgXi1bQ2D62i1WC5+ETOKgtb65DgM/tSFZqEI8+59HpxpkzvBsjlVUF7Bc=;7:nDkRPMNr7qjS7Art8zOFA12qI34gS8CXf0mOqyKhGPF85KjHnh6aXE58KNYFJttp49anZv5+SWh7OdTZ9xat6YUt6r0VnrcLfWKn3TP9zZBXwl20sRR4beG5v5mD1E4QLgdPqNCs20nyor7APWkcZ2/E6WZ1itLhv/7k8CijFQ0/wI3gYRdWiwn18TY3HjPo6m/mZV9S6oasynCjKQ6nEoN8/8Z3ygFSRKwpVMIe2vuDIKJb9XH6AQh/b4lS8uLV
x-ms-office365-filtering-correlation-id: d3126e2d-9df0-43ba-509a-08d610d49715
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120338A7B69ACD0A81406C4FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(5024004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dCYtIVAOsrjk6z+uGFPWUtNMvJluPiJhh2Kdrf3Ll+Xfz6KWFfdpuH0TinWYroxrtATbHL8W17V+ACOKScoowMe3LFe9oIpFInokIn74Vb5aascOFpi6uHbHF3KPMHjhaBXDicPWgNW17lPwSqXTWj+3OD7b21o4PrzTSXu1qdp/DwA5LqCr+46hChb5d/riXe/k7YCO1exReUVxzndewb1Np5+N/mPZj8J/c0s7HTmh62ZHCQrrZa+OYFstJ5kn8SpyoQQybIK16wubRvzSaBESoImMLPI5djnAIJBulM2YyZywI3Vf272Dyb5TO5GVJYvM0OblRsIdG6elhj6775GgI+cK1ITUZ2PC8deDrvU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3126e2d-9df0-43ba-509a-08d610d49715
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:12.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit fe782affd0f440a4e60e2cc81b8f2eccb2923113 ]

Some of the rpmsg devices need to switch on power domains to communicate
with remote processor. For example on Qualcomm DB820c platform LPASS
power domain needs to switched on for any kind of audio services.
This patch adds the missing power domain support in rpmsg core.

Without this patch attempting to play audio via QDSP on DB820c would
reboot the system.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rpmsg/rpmsg_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index b714a543a91d..8122807db380 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
=20
 #include "rpmsg_internal.h"
@@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept =3D NULL;
 	int err;
=20
+	err =3D dev_pm_domain_attach(dev, true);
+	if (err)
+		goto out;
+
 	if (rpdrv->callback) {
 		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 		chinfo.src =3D rpdev->src;
@@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
=20
 	rpdrv->remove(rpdev);
=20
+	dev_pm_domain_detach(dev, true);
+
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
=20
--=20
2.17.1
