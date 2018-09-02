Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E8AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B092204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cLPDM2sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B092204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeIBRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:35 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728376AbeIBRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOFYojo5r7UAtqpNNGLVGD0ycT4tyGkewnkRfOSZ1RM=;
 b=cLPDM2sdqyLUtyTgS7xTIFnSqMEKctFB2Vsiq+buivKF9xuySQN8gOBDIxDFy1Kr1tJsFd4FrXlZu7mAxKYCc8j8JEhGg3EZEPSlMR5gztFVZ+p4hq1lP3/h8kI88u55ycJvpFymTbk2iITfULc3T3bjheOzkP8xt+EcaCdy9Uc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 068/131] PCI: mobiveil: Add missing ../pci.h
 include
Thread-Topic: [PATCH AUTOSEL 4.18 068/131] PCI: mobiveil: Add missing ../pci.h
 include
Thread-Index: AQHUQr16yPmdtLSUUECBsv83+4Fj4w==
Date:   Sun, 2 Sep 2018 13:04:26 +0000
Message-ID: <20180902064601.183036-68-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:t0yyI3WBuhwQYy31C5IqUl4EUp+yymTk+XGgq2k4gB3m2s0cMxA5MXWsWJvhUN3a/qzzOPmym7YrjgObyKqXNg7ANG6Akmc4EHFdbNO/RtEhkh2a7KAX7Qm4HRzdSHyNwx+owMI4u+bV9WTC8u+P5ioTfOUJxFTqXSuHNN4isR0UJd3iZ0d1wWO27ldhQoWxP1vC9SXHWi2zFgGNC4KLF5nPki5J7Ne/i+y5NqhHTphbDOEDp0VrmUXFuJj1hjFP0NWkzgrqklkeUZ3a+4kHxUSvJ8Q7bqqX3dscSsWAXkpeSHND8NObtCoJxkU9J7s0sMgEmibD1Y4bcq3uKsoP8mTXLwNoLhCxE2kABcNLHHhIz73h3pPVUsJdL1SsdunOlR2zsZ98dtGkgxVe39mFSKvyBUjgO8c7qPM7NoVU7PVxlJ6T2rF5FQw7qYPSpBzzLV2oOlpcZTZ+9BHAqL/Wlg==;5:Kr1K+4THbxuSpbWMnOfuoZHRsDxHTdSc1J41JDOpJeldMDqS7lRsNiA8YaQwnyrhnII/jeaqjx2XuZVtxYiR2Huw2IJzEIER0XD2QcS43TQgVpoP5y63YPsAeR7OhtiO/UEbantNr42uXFxmh9FPWt7jtCL+VDPvAyDMvJjYqNo=;7:AN9CIwNWzAAdKDblUVyPh/9XAZAQE6ht1Anxy+GtGeu50n9bjNBcmNdBmDAhkMctXK0eT4B9YaqYqOZb4Ja4tF/qAgVr2QtZbDrjVU/FjYMmbX0qrs07P6aPNvFmyNt6mRNDeuKmfNjTW2fHKzAaxtcwymqatu/ae+EmAqkiWrsmgYuof2vp+zdyXVONedPLvb3hIfYfSDOrru1DZnwEYOp6CGCgw736rlb3yRUKXiBHAIy8+jYzKraHYbrcF26m
x-ms-office365-filtering-correlation-id: c0c92443-e7e8-4ee0-e4c3-08d610d4ab9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120964904664B8F2AF3A702FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5heu/a06ZgZmX+nsZ09maF5ci4H9aG0CaWlQQSmLuRXNmDDsYPO9KE5sOnG/xyzxcJjv5nvNvugXR7mtzW58xSCS900UGDcyBqrIlshb4ObWiVswAAm/ZywKgWPHAodCguLUTNZO8MzsZK3S0n11oTspQoDSJF4ChTY7/JrW7NOCJrslmsThQzTI30VctcD9x/N34RUyEubFe71yH07Im0Bvvs6gLT4dJGybiAZ8horXG8JMmBiEJHcfNY4UW+Xd4Czbhq0NRrBZ9CPJ/ty+mzsDL9BA7LliIQHX4WRVHX01H9AL4GOr8ZEju4X9jC6lCOIvSe+xKmMfeqa7bpwPgfPMFux4/gmZ0GCBd/V8EP0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c92443-e7e8-4ee0-e4c3-08d610d4ab9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:26.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit d3743012230f8dab30d47caba1f2ee9e382385e7 ]

PCI mobiveil host controller driver currently fails to compile
with the following error:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_probe':
drivers/pci/controller/pcie-mobiveil.c:788:8: error: implicit
declaration of function 'devm_of_pci_get_host_bridge_resources'; did you
mean 'pci_get_host_bridge_device'?
[-Werror=3Dimplicit-function-declaration]
  ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        pci_get_host_bridge_device

Add the missing include file to pull in the required function declaration.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index cf0aa7cee5b0..2c81be37b010 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
+#include "../pci.h"
+
 /* register offsets and bit positions */
=20
 /*
--=20
2.17.1
