Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA375ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7642F21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LEEml51R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7642F21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeIOHFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:10 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeIOGr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZpZ5gtDBmopfP1x47odh10TVJkAhJfXSh5Sukqi5NA=;
 b=LEEml51RA13PILwqMTo3QqwXLVDmeT4TtzKPeK5flI/a9qE8ktk6f6iCMRJVbUnLn09Tl8/a140fyOUMIsCWRz9jI99eYa1btHdVZSg2EbrpKXW6xR1zRnjjzKg29CTHylKf22quLy0BabwGr+1MgPpm+nInwWGsWNxK/z8b1wM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/92] mmc: sdhci-of-esdhc: set proper dma mask
 for ls104x chips
Thread-Topic: [PATCH AUTOSEL 4.18 38/92] mmc: sdhci-of-esdhc: set proper dma
 mask for ls104x chips
Thread-Index: AQHUTJOnZZbUGZ5Zkkm/ksIEYU/Smg==
Date:   Sat, 15 Sep 2018 01:30:16 +0000
Message-ID: <20180915012944.179481-38-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:JMvlbA8V5zrSGK5KapQWKdJVIJ4CqB9Ibm6iV75R0/Y+3UXmzKZUfWDqhj9/O3ptFcPhQ0JwbFw3dqxAjxRgJN2ppVzLwv1HPbKlS+jvTUpnQrPaboKsir6x7PCYts/Tqkc2HBXvsGWLHjx263q28uH+/detm8g8DSJbsdJkueVz8hhjRtnZt4C8DKV4jUhOz3sYCWL0L5K5fnoXKpi90Rtd8S5tmIqrBlA52HXVtIgefKP8kcTy16yLvpYXk6mTApRIMLi5c3XWjc4Wc+eXB3LNHtx2glTVwwY7Zt0dP0lWj4Vou7vEdzGV/XcaYQfMQ1qeWdSpLMnFI9lF5NxBmp6PKj6F7bCyD/bCFVyDbLoCmdhNQKKs1yRaQ3QZRhfsvIWFUn4a1Swz+bzVBwjJ5Bm6B+05rmZopyiq7ueXTzSwDAeC/xKK44cIXuPemukXgxXTcIbryRwSgH/Cmsbhww==;5:VZ/su/KLN1W1KqldvVKmnGLn9CIdrhDVBwEGsGjt3g17bl/CiodywnauDSG/f2xgQTmYc24l+gfRBQQDElfO+XeyZ0lgg42UmjOcRDKAB+ZmQlhddrRjL1AFplJ7XynLw/mvJhJGjJ8SmBaiHNMzGNMCM8rpyTAtyC3x82wj//w=;7:lIS3gAixrTjndExPiM2XbVJ7RjrzzXiiqdGNVrC9iGbTf30uR5nynoHGFsVFzCFfq51G5Y5FDXj3l6omuw/K8TJmTHeOdGP2dk8ktwzzkgUE+cnMogQpHUSrOYmYDkCxVHIsp+89HPhH53BULybaAKFCduoSPJVWqn8i9Ipa4LscncUwZm3++Z/lWah3mSokpMAvoCFytjqAP/VBu1Izpz79arDdbldT8IITiSO6PLIOhWPOelLVPNeW5OkIFdM0
x-ms-office365-filtering-correlation-id: e43ae76b-0804-4de6-5c8b-08d61aaadbe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB07412645AD66FB5EDB76061EFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: v9EIxfWQ17iosvgXiuv8PGpDKcoix8jR0uHxBgobmgc9g1DRsHnrKul8nNw+OYUDjDOJ/pte5jfp4qKciKo+f3woYdA6d/4ZbdMjUuzP250fIDWrQsQpgz7NcydeRP8gis9B7sJJnl8IGBzLbY1p8hRu+DMym/H/TzmWAbYaTl2AxnY5GdMDytlxLRoo58ZcEnhECptFUbItR7t1GOM71RTCEf0GtfWWMWPOyF8YSpg5q8groSTJI/JHu0h+vm1NHIdMU85usja8Uq4gXw1BoZ8HkJwbt1WdJq78/Eg6LzJhopheoVz4v+2Lg3UlXwGPwMrgCz7A5RWDUdTqqMJMCGwYuijGGrKByG1lkhjGRWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43ae76b-0804-4de6-5c8b-08d61aaadbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:16.2606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
