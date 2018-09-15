Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECFECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ADB208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LL39O+MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ADB208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeIOGyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:54:09 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729910AbeIOGwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lm0Na7iWMDmyQQkmzs6UnNYlzsLP5EQDJ4PstSIkEg=;
 b=LL39O+MMVgTxt0kLp+eMUbgkRiizSRQdfMqGpjlvnk8GgpUcdMu1nEPi8Wf5VM2bkkmfnMxSH+taXKsKATO9HhIR+AjhRMbzSoVkFkzPJtP0FZy84mLpJBDh/BP+FInRuDYpfolHjVqanNMybgITtaOzUn8taRJ4gR1ACGSytUQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/20] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Topic: [PATCH AUTOSEL 4.4 15/20] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Index: AQHUTJRZERt+OWKol0uQwXgDrkgtJQ==
Date:   Sat, 15 Sep 2018 01:35:14 +0000
Message-ID: <20180915013502.180110-15-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:NxGdFttYSgrCkBJ4XhgFRPQRI7CvlS7Dpe1r1liJ3dkvwNSXsNfHFj3XG1xGC8uU0Zxx2ESvMgHBx7AltllSsPeYFMW3AsNfBekFxCFk9dHSg5ey1LJl93sHlh5EBUa5x7MXE9pgPd4E5Rh7VPMMYk9fJay6Cwk9NYFZUDFVxvqMDt2JRa8eOuk1BCR9zAO5Vf1XL8khs5i8TEh25FoF48cJLwpRiLt8Q5CdmkZ1bwCT5S34YbRqogsbk+ojqjnW5eOdGlkZD+pvHY0j0XzouDSsnfRci/DsdMqzmAtih5BzELGy1bfSFlwhmxn1d+ATlzOzJzHOslKZ7SwHm+nz7wLALWs8EWJhwIW+DK9Rj/NZlCvR6yXY45zSdAgBiTBiZVWKEuSXtj9zE+1zdnWVxyWuIggv9+rcsCSoFhG54sZbK4DHA1OZNkOIfV7jZBvhrJ+xpIIbobfVVnbi12EzLA==;5:s0Ahdmadkqi1pcDZ/JJxxr/46aW1fBPCGMzzgDPJlahLK6yoyGGAQz+bOofr+k6oeUS4ADsAXHV7Dmu/ic+vI2pp3lNAg+7tY8PKd8dj0l/8RLc+eJsh4s27qZG62Z+Y47sZ1849jnL6M6YXGIFHSkIADNXfYgZE1ah/8bPHW8Y=;7:w2fDgmVPvJaxoKc6kZQi7cDb5IP7UqQENqD1tCJ4x9sLk399JVFmS2MDyFRNLS18ah/s/NtoQsXQ+q86cxkmD0KGMn+S8Kk64gTYzCPWXxqppMro4L+dDoN2EO+hU01DzswMtUEi3v5rcWSO84s365ZLHJUOVHvIzs+H39sgysYtZXpGyiHlBVkVIkkd5Yu7Pe/QGqOK4xGEni9VII6pk5QwC86gyXEA77P6UevZmmyZTxFk2iM6ecpcIi0H9FGi
x-ms-office365-filtering-correlation-id: f5ea9b6c-5c81-4947-1cb9-08d61aab80ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB018139CC450AF11088045D43FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(39060400002)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wMlkIGWyQ+H4ABCteDkTaeYTaIdgEPeZyBWLUijdJRn3pOvBGliBaK14jCmu3VaJR4yzv4BkIh/iS2F3aQ1jwYej6WKwzekunEBxJhZBkSLj/DxxkOoll7JhDlHJocUghKLMfkls+OvmzIKeeikb6uNhG8Mxw1htAuf8veVJ+RHmBdzaKbymNfVzhUnBKts94FSRYUjQIfUEqjGYtSl02c0izHNospCv26qDDGXd9CbqgtU4/4h7KOr8DQfpfj/NXFYaU2NYJc/zJAnE0SudC6m96fFeLhVRNffEiFRAVmdpXCJUJw17MgdkgF3fdq5dA47d/CSuTFRKjrR8BC55D7q0CYBvKAwZ2bdmYtXqpss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea9b6c-5c81-4947-1cb9-08d61aab80ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:14.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
