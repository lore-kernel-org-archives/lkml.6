Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAE6217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="SGQP+SwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLRLkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:40:43 -0500
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:59488
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeLRLkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5GNmIlsDrDVmMk+cwz94gexgmxinF3UcoymoMYuVQQ=;
 b=SGQP+SwPEOIHIT9pX5FCPJ8oHZF17Zal89oOvBuKd+at1Vp1C7EHNut9CTIz3mt3hiUgroZzzajUh1b0MkS4GPVEWW1qjjsCR0pT7hLVpP13elW9r/N83wcIR0hIepHa6z7N8n4HAQ6ND2YfT+3FAeKNAIFscC3wWbEZB6qBtLI=
Received: from SN6PR16MB2542.namprd16.prod.outlook.com (52.135.125.202) by
 SN6PR16MB2671.namprd16.prod.outlook.com (52.135.127.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 11:40:38 +0000
Received: from SN6PR16MB2542.namprd16.prod.outlook.com
 ([fe80::8820:cbd3:3b2a:c3b2]) by SN6PR16MB2542.namprd16.prod.outlook.com
 ([fe80::8820:cbd3:3b2a:c3b2%3]) with mapi id 15.20.1425.021; Tue, 18 Dec 2018
 11:40:38 +0000
From:   "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Andy Dai (WH)" <andy.dai@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Mike Li (WH)" <mike.li@bayhubtech.com>
Subject: [PATCH V2 2/2] mmc: sdhci: Moving sdhci_o2 into sdhci-pci-o2micro.c
Thread-Topic: [PATCH V2 2/2] mmc: sdhci: Moving sdhci_o2 into
 sdhci-pci-o2micro.c
Thread-Index: AQHUlsZ/ByZq7QlBvEiu25ygq1WO+w==
Date:   Tue, 18 Dec 2018 11:40:37 +0000
Message-ID: <20181218114003.10002-2-ernest.zhang@bayhubtech.com>
References: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
In-Reply-To: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To SN6PR16MB2542.namprd16.prod.outlook.com
 (2603:10b6:805:d3::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [240e:b5:4028:7276:3c98:20f4:6f5e:78ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR16MB2671;6:AWCv7xNxs2f15GP6y0+N/TaROQo9ixS7szpfUIXaUnbGfwR85jV1mABAA+lEBLystIArzQYRhlmf/yc3dUGpntsyqfuXHwBO+uwUrpYkCqiDDadyYhyjcTpZKTdM3vl8y4bHwJEycJ8NnkUwdWS6yh4PHmTiY56DkAdpK+reKKzzub21jF5+I+mFcOo1BPzYnu8c9ve1T+eU/8C5+V6FO46oMfZ+jI/iva3sbGBhcnc3/fQrtT4x6+RDa5s1IUSl78jGNy5wouiGX1HzTIMwhyZyFToyA7hhsGJCBm2aOm9XkldB002PF2lUV02KIQtexfLHrn/+lJfSS0ZfIBLTZqjDIGcXlJsNyb+gjRqzLGCmDPids4w6O+XNekM1lep+wenY/J1xdiPkDvk4hA4r6VMakb0JV7BtBqMFN0OhF7UDpSKwOoBRiamzjSk6LgVbQQzXE8390xf1QnXkqu1zPg==;5:v7PRV3/9wxAY2PoNQfTNDrrFQau1QHFd6YU3SSnrmPJJytDMFLI1tXP0nscahAmyy8Bx+b9q/QrgfVttm+1w4KU8yarB+/mM923O5rE3ZJP2SQmfBuy7iHnfXmhagQFc8yFpjtnSn7vpyi0EfDqldhUbMpFbVZwqwGbT7/vpVcM=;7:WeRRTL9b3ka5sliv3ERJFNOltGhAb/ACjhXSGM5vVLES9dPSiogeby5YDCBZ3IKTcO2QMqFz+8G1a1dn9gpG6k11iVGR4x/bVD2YXS9BDbnuhhWCyKIKlgM0RXenkst4jSJOIbQU5jN7O5B/8+kSLw==
x-ms-office365-filtering-correlation-id: bbfc267c-c87d-44b4-f38c-08d664dda0df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR16MB2671;
x-ms-traffictypediagnostic: SN6PR16MB2671:
x-microsoft-antispam-prvs: <SN6PR16MB26717BA4A440B70646FFE15EE5BD0@SN6PR16MB2671.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:SN6PR16MB2671;BCL:0;PCL:0;RULEID:;SRVR:SN6PR16MB2671;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39830400003)(396003)(199004)(189003)(386003)(6486002)(106356001)(6506007)(486006)(107886003)(6512007)(105586002)(68736007)(71190400001)(71200400001)(4326008)(81156014)(6116002)(76176011)(7736002)(52116002)(2906002)(2501003)(53936002)(8676002)(5660300001)(46003)(14454004)(446003)(11346002)(2616005)(1076003)(110136005)(508600001)(54906003)(97736004)(99286004)(8936002)(256004)(36756003)(575784001)(86362001)(305945005)(2201001)(102836004)(6436002)(25786009)(81166006)(476003)(186003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR16MB2671;H:SN6PR16MB2542.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rZQXCc1j7mdXEvg7d69I8umnIxnMRX/KviW4WpQyz4cy+Hn1q09c1HFS9KomO7Lx1XFIEnZFMPp7FgHWkY6p+TuiLkzwlmOmx87pvwcwN9ebPRgTlMDYgwoFvcbD0gf4RFnjxESntyjaG7SdqWc3KyhOf+dA6MZXZ9XR2KKsBSIs+W9foSzt9x0e+IZYethXCQ8mG5N+dQNwR2m9TyfiEN8fvjXKtsdHF44igjyJOnzgIA97htlfAMPqqjKLqhPyuPy+fr1E19y7wK0DZzaK3Tf2WO8eyyHq2jKz2d/c3jgO6of8RLnUxyqYD5LVOAr/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfc267c-c87d-44b4-f38c-08d664dda0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 11:40:37.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR16MB2671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving sdhci_o2 into sdhci-pci-o2micro.c

Signed-off-by: Ernest Zhang <ernest.zhang@bayhubtech.com>
---
Change in V2:
	1. Moving sdhci_o2 into sdhci-pci-o2micro.c

Change in V1:
	N/A
---
 drivers/mmc/host/sdhci-pci-core.c    | 19 -------------------
 drivers/mmc/host/sdhci-pci-o2micro.c | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h         |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c
index fc4f35653602..99b0fec2836b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1257,25 +1257,6 @@ static int jmicron_resume(struct sdhci_pci_chip *chi=
p)
 }
 #endif
=20
-static const struct sdhci_ops sdhci_pci_o2_ops =3D {
-	.set_clock =3D sdhci_pci_o2_set_clock,
-	.enable_dma =3D sdhci_pci_enable_dma,
-	.set_bus_width =3D sdhci_set_bus_width,
-	.reset =3D sdhci_reset,
-	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
-};
-
-static const struct sdhci_pci_fixes sdhci_o2 =3D {
-	.probe =3D sdhci_pci_o2_probe,
-	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2 =3D SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
-	.probe_slot =3D sdhci_pci_o2_probe_slot,
-#ifdef CONFIG_PM_SLEEP
-	.resume =3D sdhci_pci_o2_resume,
-#endif
-	.ops =3D &sdhci_pci_o2_ops,
-};
-
 static const struct sdhci_pci_fixes sdhci_jmicron =3D {
 	.probe		=3D jmicron_probe,
=20
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 506b93e5dcd8..7f11cee71db1 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -665,3 +665,22 @@ int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 	return sdhci_pci_resume_host(chip);
 }
 #endif
+
+static const struct sdhci_ops sdhci_pci_o2_ops =3D {
+	.set_clock =3D sdhci_pci_o2_set_clock,
+	.enable_dma =3D sdhci_pci_enable_dma,
+	.set_bus_width =3D sdhci_set_bus_width,
+	.reset =3D sdhci_reset,
+	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
+};
+
+const struct sdhci_pci_fixes sdhci_o2 =3D {
+	.probe =3D sdhci_pci_o2_probe,
+	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 =3D SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
+	.probe_slot =3D sdhci_pci_o2_probe_slot,
+#ifdef CONFIG_PM_SLEEP
+	.resume =3D sdhci_pci_o2_resume,
+#endif
+	.ops =3D &sdhci_pci_o2_ops,
+};
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e41a85f0b40a..0e08021179a8 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -188,5 +188,6 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, un=
signed int clock);
=20
 extern const struct sdhci_pci_fixes sdhci_arasan;
 extern const struct sdhci_pci_fixes sdhci_snps;
+extern const struct sdhci_pci_fixes sdhci_o2;
=20
 #endif /* __SDHCI_PCI_H */
--=20
2.16.4

