Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE6ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28821476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OvONkr7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeIOGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:33 -0400
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:32793
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbeIOGub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lm0Na7iWMDmyQQkmzs6UnNYlzsLP5EQDJ4PstSIkEg=;
 b=OvONkr7N0zDfRGxY1KLrFeQ73irzQ7A5U2yy9QlVhBgkgMCgirGjv7p052lWUTtpBDysslPB6Bc8WRrt+foBkKxH3sEphKkS6IKxCvHIHzDxxRmoH8QL21WTnBZxtt8gOn10gqzW/Oh2wD/GlBdKdnQSgRMbxIW5wT0Df0sgpK8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 44/57] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Topic: [PATCH AUTOSEL 4.14 44/57] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Index: AQHUTJQHCQy/Etx9xk2NvYmhtQ2UWA==
Date:   Sat, 15 Sep 2018 01:32:57 +0000
Message-ID: <20180915013223.179909-44-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:oZO3D2UYRLsZbNIHOZ/V9+HdLHigCVuaWnsVUA0eOgAGPo22UjvJc1FzCipimjz5aS1baWeK9XX5t9TEnoWWCzOX+ZdH2FcseujLiKiDFJtYKH5SrJIyseZYMDKtxQG8BffA0u6kNXQudwUSZRSMuK8o8vYQ2nqZm6oQ0CmzG9sdZTqNGTFVi5bFPTlinyoMZCIA37HII8nq7/59e/npPr3PFZnmGzB/jHKHVgeHxJke14k3b38nwaHHRlA3vdXToc2oOqecNLGZ0bG5s8E0LI+etD26Rmw1Xq2nzsdJ4BTakC6GeT0OyuXAuYPYMpyezr9KDTimLBwLf/LJiyl/tBLhqErhmOmMEcS1Dbe9av5moEd2sX0YyC6E+ALk8uaVUYbn0QckEjOcSczkWvvBWg1g5mcj1pxqKDDtnUoNNuW//zMXBhhnchRHZmqQLVBwzsAV6kaPW3gJtlwAEw9c8w==;5:UvBLCMKE5PfnuxUMMcPy7QZibXs8qfwVhYuhTjU5rj4jZnIxj7Pju1fsTEMEm5Jw7a/7aQU0y0IuKCL66vBnYMSqijE+buR9QTrTTyP+TiD7PLG7O3sCxKT2I2nR/VLaC8GMQqGvV2EpL785eigsqe+fRa/+keUIz+d5rrmUQYQ=;7:DgkUIrXZTEdsHQBsLoP0PL3Ry9TvfQBCm++msXpmAxVC4DYzQ/UMTNgCFIn56XFgaJFf/GxnXRmzre8BszJeS3aFp/ycocAMzBHgfZM0fyui6tbzCiBVcO+38Sa6amFES87cPAiOdiqJMud8aKN8mastNWCdlLq0cpP1PdrqjoFrRM+9E1b25Nw5/UNNwe6Y72nsGToD6oUxTAqUEsR2bNBR48+WIwUFOsBV7YSvG/QTFQ7wtoeEbQlVkZ9eSP1t
x-ms-office365-filtering-correlation-id: 6a337928-6c9b-4a27-2aa2-08d61aab3a15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB047146CBABC85E2287CE447AFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(39060400002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KZUINMIjj02/bJuJ6V7hKkmbNq7wu0ggsy8NR8U8sX7nJ2/Lg4hlLKwRMQTW+r9DpRw29aHnYZnfKjF9C7lOUv6jZj1XwMYh6KhFOefdNhX1hUUTVb+OBfsq4+dc7ez1jpkr3nTN6bY9a40zuhvyo37CBz05qblPYHapCXhHO1XUKrV/m0m5PHCUNu2sm/AbHNB4bb/862PhY4EdtAF3omucWQ9jXGQPC+x5gBBwkcvL2d2hNJYJhIY+EtIvQfILQ9tmoN6LMBRwD1zrKf9mCz2aPjngd38pWHw+rb19n44gKC1GgH4aSRvJtFEtWXkFNxNQ4/ci7T6mKnDMXqnLU+cVidIB5y/UTspO/ykCHlA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a337928-6c9b-4a27-2aa2-08d61aab3a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:57.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7874b919866ba91bac253fa219d3d4c82bb944df ]

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bd170cb3361c..5747a54cbd42 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs =3D devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err =3D -ENOMEM;
+			goto out;
+		}
 		p->read =3D bq4802_read_mem;
 		p->write =3D bq4802_write_mem;
 	} else {
--=20
2.17.1
