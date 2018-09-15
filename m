Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC01DECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5931D20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L5Il8Bcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5931D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeIOHAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:00:13 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729292AbeIOGtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZpZ5gtDBmopfP1x47odh10TVJkAhJfXSh5Sukqi5NA=;
 b=L5Il8BccX8nQfr7t1Vpaq9J93T4VxIw0pg5AGCGF83AnDgogVewGxoSeCJ9/lkMpEMZggEH7+4tehnu8xpg4RhTC6exQ4s5GRkUd3x9/jDWGv+VikDp1LxxKaKHZygxrPJts34AgUHuXK7CCK5Az2VoxuftA0fjmXcDL0gISu/4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 26/57] mmc: sdhci-of-esdhc: set proper dma mask
 for ls104x chips
Thread-Topic: [PATCH AUTOSEL 4.14 26/57] mmc: sdhci-of-esdhc: set proper dma
 mask for ls104x chips
Thread-Index: AQHUTJQBpG7o2Q5Elk6rnbBxOeENHQ==
Date:   Sat, 15 Sep 2018 01:32:46 +0000
Message-ID: <20180915013223.179909-26-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:883MEv9+slyi3N9il/wu5QRA82BmtRXiM/H2ryeaHFuR4sifpOyeNnnCMzstOPxmPdcgVHOmGBa5TiojoqpMtzv2GltUsLqhVKvkwcPZF4JvBBJmKoo79YcJkNV8LsYqfk8qnb7fhVmc9a6NrPzoIRCj6wkUFFqdA5cUHuSigl34Bf42XAo61VSAIaKhKHTJU7sBUkaqGkpldV/k+0snckQ7+34ZyWORNiPTJ9Owf7kKlYPF4dmjpfJE0A6vbsZcJ1Iz+ENOqMKVqSrz+Y9Ks5reI/MufBfwDMiBWjvX6OhYbPURlZUewcJeBAEsYsmBOXry/wYU4ex8wwZWTIAFLU32PgouBH53p8/N8xZ4jYtb54VmSYnxHcg5LF1lK+HOg2tz+1l1l6PY9HM5wD0Na2LGqHt73HhGgD/bdneARlq5cOPq9prqnHxx1VpO15UE+3sekDtPzHolBP40kSMiTg==;5:DQ+tOJfiXCwf3XH0znPHCjXFhLRdJ+hE9VkWF+Tit1f+BCRv3vTRYBGbINZVs86t/Az7lozh74bKxlwI+9yYA1R1pUvUdV1udhT8MMXqghQZXzEzLFUhURGndKvpv1qcatAUNQab+v9pdKYNJDfPUNHe4E5/wh0w5joi9FiOafU=;7:HGJHTgNRls6qyQP2oVkhB4t/0quGwPo2uZO4EqnrUUMQ9NRudkVh8sIrdcJwyYU5mZEMDCJot7JGhvQW3+Kmiu+xTT2ECsgwyMfaI9095G8NLDUZLr3f7bnEfKusmE3xla28p9wfT3AmncOPDaSPMzBrq/BfBiCwuznStzoNme91vxCvklql6W61mucxNVT2mIG56OUc3mPTT/N5Nq6Hl6glE0VbcDt62U1tYfd+vGVG4VzUT0VEQYOSt0Xtt7Ra
x-ms-office365-filtering-correlation-id: b10754e1-a1db-4dd3-2f19-08d61aab23d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822F45C0ED3F641903F2A8EFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qonfLEFXQ6dBL8Ci2233w0qLbq6xB6WqpdL/PeIX0kI6g3PaiaQur0UzRAz2RIJqWPSLORbmbd2F0yeqp4nvwvAu324IpXdxmHEmbIFivnkO9l1P6hmn/EYwDkqO6fx4VfXlmCDJ7PR1Tjs8oHf8r2LWcPs+85ywR4pP7oLunxMZAipnW7w5/Y1cJPeG+BN6+7Dya1/fEPo8SJARk5CVzo7NwMOZxHBp2bnTcrgzdrXjE/jXW1UlnB/Wmw/KaFxtaKErC70s+Nx7hb2c4AYguc9sgu1wo4iDLnTkGFwdcXfpvFBTXAKac3s/Y6EZ8IDsimmYcSPhK0Q6GbvIxGTMHzDbQh/XkwG1nRWnXDXwqE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10754e1-a1db-4dd3-2f19-08d61aab23d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:46.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 5552d7ad596c3fea953f40fef74170ce0760c04d ]

SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
when doing DMA. Make sure that the corresponding dma mask is correctly
configured.

Context: when enabling smmu on these chips the following problem is
encountered: the smmu input address size is 48 bits so the dma mappings
for sdhci end up 48-bit wide. However, on these chips sdhci only use
40-bits of that address size when doing dma.
So you end up with a 48-bit address translation in smmu but the device
generates transactions with clipped 40-bit addresses, thus smmu context
faults are triggered. Setting up the correct dma mask fixes this
situation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-=
esdhc.c
index 4ffa6b173a21..8332f56e6c0d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -22,6 +22,7 @@
 #include <linux/sys_soc.h>
 #include <linux/clk.h>
 #include <linux/ktime.h>
+#include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host=
 *host, u32 intmask)
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
 	u32 value;
+	struct device *dev =3D mmc_dev(host->mmc);
+
+	if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
+	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
=20
 	value =3D sdhci_readl(host, ESDHC_DMA_SYSCTL);
 	value |=3D ESDHC_DMA_SNOOP;
--=20
2.17.1
