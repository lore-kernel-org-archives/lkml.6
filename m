Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EE820855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iTVBNU8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EE820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeIBRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:22 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIBRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZEaxPetBbQUbUjNrhvUw5ANeEVbLxuc0dYEBr5fYrQ=;
 b=iTVBNU8VI1EXPRo0DYwQVCn6wS7qhGuvHTDw/+wSAzb9XNFqj8ZZFDDz2GOxl8hGqLCXoK7xwKAa6kHIrOKeNwmvrxUuUc6kNtA8uUeV+Jn5o30bPUbGs6FvOhcnupGKR9b+StTciT/dADjhlKn//UHEafKe6LlEW98qw7QcZyM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 39/89] rpmsg: core: add support to power domains
 for devices
Thread-Topic: [PATCH AUTOSEL 4.14 39/89] rpmsg: core: add support to power
 domains for devices
Thread-Index: AQHUQr3SYay3BA1UEk6XoE6k26Q9IA==
Date:   Sun, 2 Sep 2018 13:06:54 +0000
Message-ID: <20180902064918.183387-39-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:lnlbBzCYNsw7jNEH/paJWQsokcey+nXM+NsuY/FwuAhK9HLma6F1Lw3w2vflgCUjF2lOzKK6nWwb8dKOP5BEvH6WFQFiNGi2GLP+GSTEXmEH1mdR0JoA2yNHwSwukVFurP4fxkpaPbXeiBDhInmdA2TNmJevtlxrJAyO+rVDua0lISX0Bo2k5oR1D0nJ287gTq5h3Y7wUVm9AqRCZ229L2ilY64hJX/dRd8laAUELcj35FJ9X53IiRXTS0WgG91MZzdKdHEh0KQvapDAlqlaFJZQpAOLhGPQZq2o4mKpo90w0F+jBPE9ld5hfs2EvPNP0lYB7JSpw+IkcD0QReBUX/rJ6AWbOK0lGNNOaERv/A5Zi9e8JewZdZYn4p3dNGtq5x02ZeFfixc3kqQsc8iHyJ2Kt7loKJeS2+Yran6+iuYFXbsQOk1t84MxW7zHxDVMDs95YbGvX1LXVX429a5ELg==;5:eRSY9G7PAQcTC+heWQ4hS+jt4q4Z+MtBpdrYx807OYj8BcOxjUkBGCYYzq1c7Z3JzxH/ii29VEhEIbo1oAkNt/0Ec96HttsCex26bgARCGnn0IZgipgG8xlKt8Tk6WTeXnUyOAI8oJ0TDdk4vF+UnJmx6/09d9dXES19TsqplnQ=;7:CVfNDVeJeTLW+SmXAZK/iVrYaO+uYAYY00jikNoCzoFRJUhlVUBjuTNR7JyGpIHDX9p2+oRUETeuF2Uh1dXvlV/4cWFXiqvupfIhcQdY8ZQFzk6+jP/Bw9IK1CRKqsNHJivjCrQV1Sm+voVaW0pb1atgeIPP3qnwPVFJ8x2AmJ5IsncT/nky7qxEvV8of0T5Bzahk6fxHFl35JSfnKXIcAGzXzj4udW9qDzr7bUcB5SThzBs9WOuJWMjQw5yMt2T
x-ms-office365-filtering-correlation-id: 77c6908d-dd71-4020-13e4-08d610d4fe37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0856E5F53A0F987F20080B2AFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(6436002)(107886003)(66066001)(5024004)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /7yyaHnub/L2fusz6a9VCkbecwsxlRnA/LW9Yn+v8jcxtjutd9Rx+pSktt5AueM3RFAjaY2JZ57XcNRgv4ZJJJhl+FQjnujPQgyvYIDLxsu2uqTQC8QEofqLnTTR35iVihA8h5qqwFba99LkMwtBLX55HnEJ6x6j1CKIxQptuiROSa7v33d5Pc1cl6rTSU/iXCkDvHwQQsul7eogRJMIcs97s9mp1Sv8yCQQ7bfBNCdJRPZgrmtj88Cf20rmR0gdfhYIj0c0grUonR7et+RGxuWbTzwAEhs8WyrfpQs6kptbmsiRJvlki74OInSNQ6ldyR0WBN//f0mm7sL7GnX8L8tI9rsWHbnY2zL+otjLwwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c6908d-dd71-4020-13e4-08d610d4fe37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:54.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index dffa3aab7178..cec4c3223044 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
=20
 #include "rpmsg_internal.h"
@@ -418,6 +419,10 @@ static int rpmsg_dev_probe(struct device *dev)
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
@@ -459,6 +464,8 @@ static int rpmsg_dev_remove(struct device *dev)
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
