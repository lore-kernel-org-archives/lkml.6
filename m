Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C43C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353112190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IEeI303O";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KHEARROT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391538AbeLUTG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:06:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62316 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389409AbeLUTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545419186; x=1576955186;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2v/udaTVPKKcQrMUv0H11Xq5jUdx8felW1O2UdTYoSk=;
  b=IEeI303OZuuBBeIeuEbYrEFH6DzWYKzFJgOJ+U1dN+Bg9gP2TeBaThx9
   zRonSi5kd1bfNBna068TiLMnIc8W9z2fK5mEKQ1Y9Kt6WkeM1mfQWRr+V
   QmbWC4cGs0AUz7w2tDVwkp5XuVVY+IiO3WoeV0CKTSrDix5muLGw/DSrC
   5f2TwsqJh1g/YsFrt6mK+DAVCZLZqi3oTh21Ik0iqqzOORjFr9KuvWuUd
   nEKWKITCAnn8+H6hmf7BxsOwTkoMkZGL2Wj5G7g5MdoMzA7Diili1DsHA
   mbMYYiSmkEgo0mQqrsGasz3aedX1nJlbnlP2m/y6wwOz6FDtp589ZxUhG
   g==;
X-IronPort-AV: E=Sophos;i="5.56,382,1539619200"; 
   d="scan'208";a="98968597"
Received: from mail-co1nam05lp2050.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2018 03:06:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v/udaTVPKKcQrMUv0H11Xq5jUdx8felW1O2UdTYoSk=;
 b=KHEARROT+a28FngR8Zn1a/T5aNrVYuClGdH8D/k+T3lV7zer2CfIzFygmRbmeQTxClRUmFGcnGeHjMzFnaIVGtMVcfqdcUBEI23CpEmTlXl8+RrsXBjD9lERvAuF0US+PDukNPV0cO5bpdsRoN41YMeIblA1p5qXYIDIn4jO5kI=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB1072.namprd04.prod.outlook.com (10.174.250.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 19:06:24 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 19:06:24 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "Palmpalmer@sifive.com" <Palmpalmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUmWBEawqGhX/hUk+WG09gQflaXA==
Date:   Fri, 21 Dec 2018 19:06:24 +0000
Message-ID: <20181221190615.19003-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To MWHPR04MB0401.namprd04.prod.outlook.com
 (2603:10b6:300:70::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1072;6:5UKoR9YMWa6puUb7f+zowibKuSFey4Eeg5Xqk1HYc54MvwyM/2zHf9CZDToiuC59PtX+kZ8i6whiFl9PCzLekISwrNs9pS9P28ftVNyWSObeBsaqunma2WhFzg2mFOMYL/uwXFJdMMvu6KJU0fifNufSuX6uT2/bAMt9C7k0v4tmZI5QOoABIA7e4fXH3Qm/pb58Vd7MdyTBBFTuQVCwufOPaMGzIUsJKUJRv32swjSXw5V5MX9mpao2RToDnyELBGlg1rQF1x+VQ0I0gXXxgU98DYmmrX8bV5Nyt/YQd44B6kmS40mbQx/RhyphzRuPOe9R+UDZu/n9BHdvoZ1eXTd8nmGnKkVWcuN5kZsdn2ZyxCrXsEKSTM96mAa4EHApAIaTU0jwpONsXaiTomxDKj6izOdaZp+YgD++0ZcwOH/mgdj2UI9aNRN1ZGZQdf46IbayD0zjz2zMDF2xpBUsoQ==;5:npFH9Xcwz+Z2jaS+cuALRFYRDCZ94UGquY/gTrykpRHSU96t1lfO9arM92MRRoE7ANE1Qlu+PXEVR4v74Y+ZCVNHwg2iZF9JbdlGmuiJEvq9OPH8kHnfl58TaOYS/rHsV9vCesmZlX6obiECaevsPTdyNGdslbS0lsdTd47WzeI=;7:ABsSrfIsPeS0eghrJiNtriq1Vl27iJn7enUeZpfPFaNRJXWUlHRNmX4qOcEn5j0Nx09ehDTEC8t6UZx1nXieSUfYNdYEeSuMqLS2fUEAnKk5skY2WK1T4yaq3ytlzDOUMH97YGyVq+X4Lvbt3u5iPQ==
x-ms-office365-filtering-correlation-id: c0e52baf-c5fa-45bc-8cd8-08d6677766c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1072;
x-ms-traffictypediagnostic: MWHPR04MB1072:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB10727D9DC2DF82507E6D08C590B80@MWHPR04MB1072.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR04MB1072;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1072;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(316002)(6436002)(478600001)(186003)(1076003)(106356001)(476003)(256004)(14444005)(50226002)(110136005)(72206003)(66066001)(6486002)(36756003)(52116002)(54906003)(2616005)(8936002)(6512007)(71200400001)(71190400001)(14454004)(4326008)(6116002)(5660300001)(2501003)(25786009)(99286004)(97736004)(81166006)(81156014)(86362001)(486006)(8676002)(53936002)(105586002)(44832011)(68736007)(26005)(7736002)(3846002)(6506007)(102836004)(386003)(305945005)(2906002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1072;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JflewFs44uPI/UoNSBTsYkrgGbwz/bOM7vs5uvZ3e82Yq3VjfpHm7HTiUPD+Ii4XwO8tcDXUQ8ZpXkAeLeK/g67WgPhhRUG6/DKm6R1kLatt+l7LDL35YX2ptMqc69WaV63N1kJfm42kOMDACkbq1BD+E50LnojAfB0Zh+Kq29APpa0cO0yU4Somi20RCaA/3tD6PvtVPil53s4wGrWEVZoL4yS/sQ5V2oB5Ctb1ifkkMNXWMnI13SX0ru24ZPnO2Rp2uy4QUIYyFGqlVx1eXC8a2V6+uoefKs1xPqf6FHscJ8sQOy9wg2k7nsexJg5E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e52baf-c5fa-45bc-8cd8-08d6677766c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 19:06:24.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable generic PCIe by default in the RISC-V defconfig, this allows us
to use QEMU's PCIe support out of the box. Also remove the Xilinx PCIe
support by default as this is rarely used and conflicts with the more
commonly used (out of tree) MicroSemi PCIe root complex.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/configs/defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ef4f15df9adf..71475c20b8ce 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -14,7 +14,13 @@ CONFIG_EXPERT=3Dy
 CONFIG_BPF_SYSCALL=3Dy
 CONFIG_SMP=3Dy
 CONFIG_PCI=3Dy
-CONFIG_PCIE_XILINX=3Dy
+CONFIG_PCI_ECAM=3Dy
+CONFIG_PCI_HOST_COMMON=3Dy
+CONFIG_PCI_HOST_GENERIC=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCIEAER=3Dy
+CONFIG_PCIEASPM=3Dy
+CONFIG_PCIEASPM_DEFAULT=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_NET=3Dy
--=20
2.19.1

