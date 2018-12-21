Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F994C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15421929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VPP+NlCr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WuJ+tfWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392115AbeLUWGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:06:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19985 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeLUWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545429968; x=1576965968;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0PKDVzVOfAWE6AbD7hU7Js0UF9v6uYViSnYDr1p6pZY=;
  b=VPP+NlCrFQyosojSdi4xaHK/ZFGM6sZtEUFecUCupeVFgeNieF2HVdnd
   J03BTHqlGO2o6KmtCVXr3iU1Wd+8rXZQ0uLoO0Tve7E4OiJi8NA+3v2Bm
   VBisT/EPGNTvo0l5Hsd/eUcgktzNJqHuhwP1IirscheBymI8FyZEGLAcZ
   lSD2HIkMVEaOjG87VEIRdk1grf3aKWcCQmRvY6IYa9FtrXb96yV0rSLMj
   myguOE80eiKr9skg3wxmgfDK1WDlgAENL4yJE7oYsN38KFWB5J9VYarfF
   nkkMMkcwMhmIi6ExUUV7VOSnr9QVH1grrAHr3yDKJVv+gFwoUbvR505fa
   w==;
X-IronPort-AV: E=Sophos;i="5.56,383,1539619200"; 
   d="scan'208";a="98446506"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2018 06:06:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PKDVzVOfAWE6AbD7hU7Js0UF9v6uYViSnYDr1p6pZY=;
 b=WuJ+tfWXZsMprmBdaysy/Z6emamTvKGLnPruLCiofuES7Ul8S6Q/BcTubUnaGQUHF7RCAuxv8JKw2xNf440/+ONJuU0V3G1N62SV2SbfSwXGhZUIQS/FdtPlMOlu2z6yKNTDB6/dG+CSf8swHJWkFCTzSxqaLceJeWGoufhGZ6o=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0512.namprd04.prod.outlook.com (10.173.49.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 22:06:03 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 22:06:03 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "Palmpalmer@sifive.com" <Palmpalmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUmXldu0Zay3Cr8UK9zdWwWtKLwQ==
Date:   Fri, 21 Dec 2018 22:06:03 +0000
Message-ID: <20181221220555.13679-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.1
x-clientproxiedby: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To MWHPR04MB0401.namprd04.prod.outlook.com
 (2603:10b6:300:70::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0512;6:fkfFa0C1LMcmCoi6vpGWq3TNWSOQeO+707IM9/EueXFDvwiKKY3JjmXpwBiJfM1R55ETu4f1ZRPVwGbaVAO+N2q7i5185kQfqKSxDXxsCFOVrA6BJmJ0GeShCovpLv1+lUEdD8BVb8bDvE+OcHlsuv0Evgiv7uuoShxsl9lL38LDHF25ofFj0G6wWmqbcRbMF6hIMIemyRyfsdKFZaeEEnd43ogQ28snAylUAnWhe2uvUdGZSnm16O3QNVCTzPPJc6u4+EQA/QFpspkjuKyaSZh5Hy0jSsR4ZvukxJ+hpOON+PYnbQ5fEiXRIc3ZeiX/aHu6I9yyx5YoeHNlmF60T+CA0gFS9q3WeaZbvtbfMter70+GntOM/VorE7fAhu9+W4QPwrodNi0IHoKmaF8HJ8SdV2AX6kYdCYwuMM5RvMgUBt7ZBl+2RwzvsUF1KBcx5efLSBFppMiHLZ/ZHCIDVQ==;5:yvuc1OfInwtMAEzMORR2qyFLPYyxXNPQ/xdUAUtmrLv8gTjfIruCXAgbs2jIQhYcjQJ+gg/0wI/R9gdMhK6Sz81mwDi3kqfazSTKnP/N6t+gndPhPAG6a2jWySi54RsZuc2m1+U+hEWUR24u+hwQLTbzx0h+ZRcIQ0MgZLFGBe4=;7:zSRgKApEOJ13Mk5fTWiHWyFw2x0ETg3XEqtMbA3GCW7H/QeCgc652LNH+8lYQP9h2WJiCmCOtI6hPZFakvop0lxC1nxXOc2vK50lHjif8DoOENHMnK8McJIF+XMsGOlTLpV6jJFMdmMHu1+oU6X30w==
x-ms-office365-filtering-correlation-id: cfeffbe1-9873-43d8-74f5-08d667907f7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0512;
x-ms-traffictypediagnostic: MWHPR04MB0512:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0512325DAAAEF07A972801AF90B80@MWHPR04MB0512.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR04MB0512;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0512;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(39860400002)(366004)(199004)(189003)(486006)(44832011)(66066001)(102836004)(36756003)(52116002)(386003)(6506007)(2616005)(316002)(476003)(54906003)(68736007)(110136005)(186003)(1076003)(99286004)(97736004)(3846002)(26005)(50226002)(256004)(6116002)(8676002)(8936002)(25786009)(81156014)(81166006)(2501003)(14454004)(478600001)(86362001)(72206003)(2906002)(71190400001)(71200400001)(5660300001)(4326008)(6486002)(6512007)(305945005)(6436002)(105586002)(106356001)(53936002)(7736002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0512;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5p1Y7JYZCmIsoDg2vaOHSZ0dxtQCXS9obous+rdc0kHPkT6dqvu48YBKF1gATSHhI+FXKlI4RXoKFVaOXk9geId3Pt+rWSkBWgSm5/XPcvwmKqaN9Xink9wc+XeFFaymJ5Ltq98FFUj/Gf2gVxRleKOXAGbrraVctZJEsqe84ra2Z3QvXrxmS4Q/L/k4mDGCRcy/ieXvI4PdhRNb8mr1DUgD64QHujPhaFNthufG65E6XVl/qBWV2I2J4AvFFNi0LS71T5+JWHpS6zH8R1D84asibPU0YtnOHtxCItFaAQMPIcYU0DT7pVaJLavCLNko
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeffbe1-9873-43d8-74f5-08d667907f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 22:06:03.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable generic PCIe by default in the RISC-V defconfig, this allows us
to use QEMU's PCIe support out of the box.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Keep the Xilinx PCIE enabled

 arch/riscv/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ef4f15df9adf..2186d4ee1d4e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -14,6 +14,13 @@ CONFIG_EXPERT=3Dy
 CONFIG_BPF_SYSCALL=3Dy
 CONFIG_SMP=3Dy
 CONFIG_PCI=3Dy
+CONFIG_PCI_ECAM=3Dy
+CONFIG_PCI_HOST_COMMON=3Dy
+CONFIG_PCI_HOST_GENERIC=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCIEAER=3Dy
+CONFIG_PCIEASPM=3Dy
+CONFIG_PCIEASPM_DEFAULT=3Dy
 CONFIG_PCIE_XILINX=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
--=20
2.19.1

