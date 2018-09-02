Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB521C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACAD20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C3HjyzSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACAD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeIBRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:41 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729864AbeIBRaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axv9/f215bohpog8R5xOtJwtX6zVxkShRa9sq1Ll/74=;
 b=C3HjyzSDL7WirA/9/Sm4uFsUDj5Jym2INJWzlRyIOdoyU6KI2UtFdeWB+YlhsTzRDKRfD1/WMBPHiK1IXJYL6A7tAJRNOb+Fx44cpF+scARb4axi0EyqKKadpT1VqJN4C7H2ZAQ2Lp+4704QOS1YAn60noC90z4T1cCbLYlPaZM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 36/62] MIPS: Octeon: add missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.9 36/62] MIPS: Octeon: add missing
 of_node_put()
Thread-Index: AQHUQr7tuXcV6eS0MUuVej0Gi22fSg==
Date:   Sun, 2 Sep 2018 13:14:49 +0000
Message-ID: <20180902131411.183978-26-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:U7TDvTA3CB5v8SU8gYcw/fWKuNar1kXcPtP8t1ZcODcwnbcpaEjEc5cxXOriOoHtWmbPHkcYBQ6IN+6XLrhIaKPpEx+P2hHkInenXTukolnCVEqt9j5LcYks6uTTijwFqENYgJ/YIDtzrNXeNePqs+YLiQNyGEsrGPoPLmYcrsMT78jZvGQx2vz6IVIRCUDWD8y2ntGP8w+z//UUFMDS8nTyoJA5sWXiVdbK43BABkXYuWeFY3nLloMqoAon1IYCoFScSy8/C8X+fvq5ISo/ISoUvx5e+u7ZnRXrHFc7t+EAljqYSU7bCaiJO1iELUQp6b0JOH5XMt9VsU6mauXw+JJPEvqCfUTpCs7N/YF7SKTM8PZW5iXYeXxMVTsJ6+S1T2CHq/jitBYdG2sl/XnRngykUqS8ZxfCBxQdi2S0+YRBtafffLsXuBLYKMpo4qsMCMXWLr886unrYRuhhD/LRQ==;5:vPUYBcoa9d7UXJnr7ES3x5T7RqFV2hY+P+DRSWDXnMr/0zfluH4VvEe/c/UszPZxHEinn9zgT5lVJZS8WP8iJhrhU6mcHUmvAVCmABUqIhcfSodGnWXWZaOKVLQtmSaJHR2O5mnlkVgaqVj1IzljBVCIf4SFvbywp3Qo7OA7A1w=;7:n83Jpwu9wMQPlLhCvb6BfQufZeMqIm2ezUaQ7EfrZMoI8cmsuTeSy2HHkr/Pp6Wk3/OsMSGoiue0X5amEoIuqpoXOBcigGxG1PzYmX4nwzR12Rzk/m4++zlZokGBiCqBPBtdowYKErWuC7QmEYs8bp+VLP/qFv7nK5YDCMSBLAtkIGevpV8y6ZLR9kwcDob4eLr+PStEWisr5FiMCvrJAwJaEeAjmy7csUz/hbzH3AiqQlsvPP+SfNI+6rzSRiNz
x-ms-office365-filtering-correlation-id: edcf1edc-8da1-40bf-001c-08d610d60ff5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741DAD2C05E0AA3467E87BAFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3lyIf2P6PxgjI797/qfMgAb8yvafmLTI/BL3Jlv76DfLz1LQZFBMNhhxxpj+ZAU/DGzmpywD3e01Ta49i8gEWVIacCHE0WAQC/bh5j3PZvV+9eCRP+12nLqwtVexCrOBRVGo1rA7VjaCIaDvoYzULMA+9AS+oM5XNMYBwwjTLyOhObjtO0teh3ds/MWNnlC6va0zTxZMKczPtuaME6Qk/zHva2lKCX847UuYcHeBGC6h48hNjEKJ4vMlH+siqNTyACUBVThbLavmU4MiKcwkRznjsDQksyk7R2GFtSJRgehELgRKgcFwk8mRZT1bgLKFLOeX/7Qr5VtPg6wAyFLIQ+NK3JPK3PvgvZhJCpk1yQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcf1edc-8da1-40bf-001c-08d610d60ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:49.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b1259519e618d479ede8a0db5474b3aff99f5056 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19558/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-o=
cteon/octeon-platform.c
index 37a932d9148c..1ba6bcf98570 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -366,6 +366,7 @@ static int __init octeon_ehci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
=20
@@ -428,6 +429,7 @@ static int __init octeon_ohci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
=20
--=20
2.17.1
