Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B21C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50042083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IGssNvdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50042083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeIGFQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:09 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbeIGFQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHwl9opUHM6ToAhMUj/iB6Ftj7uLFX1Z+XEcXczVFTY=;
 b=IGssNvdrtfoTR7QTvKF2jcNlfwZ9Ia0qiTXhVLQKe3ENF/qdshRgGxyQ9efe+wcqlsPYirXiO1Rby3+4dLo9upclfoHtbZZ4YvKTaHl9ltN+CkJ9ktRyVnWVffNHMgraPBbOgPpeUrZcjp8Gpi2EaPEfaBcgNCemqwandNlpnyU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 50/88] ARM: exynos: Clear global variable on init
 error path
Thread-Topic: [PATCH AUTOSEL 4.18 50/88] ARM: exynos: Clear global variable on
 init error path
Thread-Index: AQHURkLR+UC6DBJXV0KjcIzgZSnUAg==
Date:   Fri, 7 Sep 2018 00:36:29 +0000
Message-ID: <20180907003547.57567-50-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:g/xR7LE/U2ovbA7YUQPB8ue3SdfF05qL8T6E0DatSbNC4jweDoT8qxBLfjmR4cgBX9M5DOlyvtEn29ZGfVtI+3KdilT3Nc1sA3hAJVylHkZqKJzi3eAfSN2Q8dIWNWYL2vzjmoU+5QYXAlfL7itns3SkZx+rgiay1lAj19GhbOEL1kORiaVol9yc7lCPrfP//H7HLfR3PPmEUXNBFLBV49TetEBCHFdu1yoTQlA8fa+okg9fLaVDTkgl6bY3e+WuWhInVTn4xhLqJJB8VUbjA7XgIzxCA1PcB8fMsF76HkIvbDvQSjc2CaTDi4nuQSt6y1wpy0gj1xW2AcDx+QYX7OS7f9S6FJkdZ2TzKIXIDj6Dwy6WwE2i2J66FOblBYaSxP1L56mSnjSbqfBucj4u1iYopZ8EZxrZRH4IPmzzPoqjsF0Ga7fOp3A/EVh6TDKk6TVDOWB0f1X717WmfGkEIg==;5:kvzdOmfO9wJ+/tVLvlBWOCn4DgLWmLr1B2ejrRZLeoWq2MdtjpLvudWV6T8Og7w2NNtCzNfyARv1n6YVpZyltewfjVI+4ELu2ybiZXKoxsg/FzdAjp/W4G61QXqh2EL+1t/FJ672ZmID5p6M3iXMnJ/6dq4vWk69ynhWvSxYtBA=;7:P6cN8yhN6gmhUbZpQ96nU8Uuj+3okf/v+s6pZjGmM3BQ1YLYg5bT1m/WBdxmzq8AlN/zO8fQU9fRK8tTfBTn++7pzdkModFPRZqYZy+FCidx0yTkynrL+6YHEC6cu32nEuifRNdH73xuY31avme6PeBEkqTpAv5M1qXFI7V3ySNJEX1LfcXbY6OaIn9mgN7Sdm0cSEf33aBbsUjO9Egvo24ngNBNT6YCsPhHF/oTmIogra/bJv4YaGk8FI9GCjkp
x-ms-office365-filtering-correlation-id: 9f453e58-6c86-4361-9e29-08d6145a032b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07731B38B83485DEDBB51793FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GvD1GioQtkrGE1J+Nv9JGtLydU6BPSow1baFABEpS/iCTk8YokWFNyb8iBjRyoCmaSp04eNRBwbTjUvGHW+u5xHYFLbl5Juk0FEtRufGLBpl4+caOjGGDsiDVrauJ/ipeBjqRCmgiYw5NbHYepQLRJHQS2rNEPR4gWbp+1bsyR8erDvfCX9zwrp09jz7OO27ZrmTABBFW9SOS0ZUCZnEv3ebghAxZ1P/KgvW/bJ6ZSxkJcEqobcUPLrupksEDeBbq1A90zhyTRBB9QfYyoGkjgPw8RcxHXQVxDjUTF3JCaVSKVbCbtBJbRr9nM53mgQUQhKf4hSoHTJUaCWTb0Ivnrx0AkdTqFPkgro4t6i0BaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f453e58-6c86-4361-9e29-08d6145a032b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:29.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit cd4806911cee3901bc2b5eb95603cf1958720b57 ]

For most of Exynos SoCs, Power Management Unit (PMU) address space is
mapped into global variable 'pmu_base_addr' very early when initializing
PMU interrupt controller.  A lot of other machine code depends on it so
when doing iounmap() on this address, clear the global as well to avoid
usage of invalid value (pointing to unmapped memory region).

Properly mapped PMU address space is a requirement for all other machine
code so this fix is purely theoretical.  Boot will fail immediately in
many other places after following this error path.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-exynos/suspend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.=
c
index f3384e3a675d..7ead3acd6fa4 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -203,6 +203,7 @@ static int __init exynos_pmu_irq_init(struct device_nod=
e *node,
 					  NULL);
 	if (!domain) {
 		iounmap(pmu_base_addr);
+		pmu_base_addr =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.17.1
