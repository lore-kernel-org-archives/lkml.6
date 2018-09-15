Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA25EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9563A208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dk5B7nj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9563A208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeIOGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:41 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729654AbeIOGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuI35dqrTn8fmVlifC1iLxg5pp3LzKnfQ/s4b9+6GxY=;
 b=Dk5B7nj8ekszfzzn7seJPGqqRvdWxNlMN6GOJ0NqccNz1DWjuct+BqzKvLsh5hLCFXzT12S28411eVNa7fuNFhmiHTU03xaaEufC7YgIf34Ew6rLMg4Et/fvpTJaJ+aS84a6VnlzyX07s68Trtew6nbPNGIpZoObin5Zi5ee+9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/34] parport: sunbpp: fix error return code
Thread-Topic: [PATCH AUTOSEL 4.9 17/34] parport: sunbpp: fix error return code
Thread-Index: AQHUTJRCqKTwBUAuHEOdSBlwlt2Nug==
Date:   Sat, 15 Sep 2018 01:34:36 +0000
Message-ID: <20180915013422.180023-17-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:X7fkMmgylJdJYIi4w2jlLMz799DTbLl+uaqdSP8QhgSAUoEaA2VYXJzJkxp/LcjNRip4fWDZECZwI8p9vcgzy4/a9heBl0jhrjDG2/7NbfSlE+If2+ZXSfRGjDDY7idRRkIEAeAZEUWV/7tyxICOECR5BYmjst9Hh1BgIfGVhY8ifFyUUdI296W6AAW4WAA0vWjgNjDEeJTGzoLk8vDS0GBin/Eye8bDqzvuORcBXZLWAQsrS+MUcXZGuBsUJwOUxn8fMg2aftKcHkS0kFanMI6UE+3Z4dOx7cvHRs1NgSA+xlZSv+wCPIKOyR2zpsQjVG2jKUXlPXdKCWhhoh5YCu8jf0YuJd9jyJ979ZJ4Y8MgI19fWCSyjsPB7ZdTkIk61Fo+rAAxfSnu4lLFtb2Cxn5bWCVKZcbJglInCpikbq78SXDW5ZHu+STU24e8iFMnfoY9ASWw91zqe1Ma84UlZA==;5:a4y79mDXnuqVHhcMq0VUfTQ2CRQqyrOrSqsQQRPD/wqb/4/RPuA04une3IyLVs8n1kAFA/5rR7pWKH0D0Syvpp3U6iEuNIY3JiLLz+XA2e513I7NAojm3Y6PLQsbSMP4GmybKQN5JeueYysrxf208FmpP1bjY3Z7GsJvxIy96F0=;7:nF8uuL1gnfSFTg2vAhNNWSV+6yw5PvXccQCuYLhNQwjjNGD0+aEFN8u4ntbYXd6oFn0vu/IOqOdvZsynE7humVw+DHoxlgi9hSXf+SHhBKld/t+6O8vQk/OPj3csipjLZUS4BCKG1P7IJvjyjnaeMMO96PIZaFgnyNUz2bJajttbfR8vxHMgfD9c33MF2Z19CzNG3IZEnrFf8+phGeylDaitmc2QMVrmdaBMshE6pihYi7PT4ca0/LI0ZI1dOPfM
x-ms-office365-filtering-correlation-id: 60ad1887-ce13-46c6-6878-08d61aab6589
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823A04B15303009C54A49AEFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(39060400002)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: roYC6+CoRGzhWUPYNBJ4LlFykbxpMGAcK/i8IeNmpJMjQD953lslewYKfvUwD13yIpfd5b7giQmWGCJ0zqAAcVvBPu15NlN9LZm6F2ssFMcPPS9r3pPAxEPazn7r0ImNdC3VmwQ1KMGC+UnR+UZKCByNS2zlKe0kH9qhYL2o21sPMT3SOWr357OARKVIOYCe4jvat5osXHnP9OlkKrbY0gNJpgogQbaoc6z+dUbBfenZs19S9CXCTh0anQMjt1cBPHJFVSRyQXWI8ZV30ILPJYMOtCOtNmSr2wUiHKemeetHl1SkVOQ5qFaHGl8114TAjr4ZlX/BnHtBuqYe9z9cG8EQ82xPnxQZ9DvofXgGKJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ad1887-ce13-46c6-6878-08d61aab6589
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:36.3643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit faa1a47388b33623e4d504c23569188907b039a0 ]

Return an error code on failure.  Change leading spaces to tab on the
first if.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/parport/parport_sunbpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sun=
bpp.c
index 01cf1c1a841a..8de329546b82 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -286,12 +286,16 @@ static int bpp_probe(struct platform_device *op)
=20
 	ops =3D kmemdup(&parport_sunbpp_ops, sizeof(struct parport_operations),
 		      GFP_KERNEL);
-        if (!ops)
+	if (!ops) {
+		err =3D -ENOMEM;
 		goto out_unmap;
+	}
=20
 	dprintk(("register_port\n"));
-	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops)))
+	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops))) {
+		err =3D -ENOMEM;
 		goto out_free_ops;
+	}
=20
 	p->size =3D size;
 	p->dev =3D &op->dev;
--=20
2.17.1
