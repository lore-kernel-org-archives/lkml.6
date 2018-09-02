Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2407C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFBC20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dWaMmyc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFBC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIBRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:00 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728405AbeIBRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTMY6J99PVMkGyaJeAOrRPUj8qr+yBVgGCzkoFCL+Is=;
 b=dWaMmyc86s4E4i1YejNLMOosWADVvkfgk/JdQ98710V4fIdzLkfSGNNxBWdO6YnERpwTKjw30i7Q0QpImCjpscEGddaPFxZF3XkbXqF2bU1F/QLIgVcvxWm9dCJMlVzFLjRXSqqUHPI6ZlpBVG+U8j78QyoKeosdOCKlTgrH8ws=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 069/131] PCI: mobiveil: Fix struct
 mobiveil_pcie.pcie_reg_base address type
Thread-Topic: [PATCH AUTOSEL 4.18 069/131] PCI: mobiveil: Fix struct
 mobiveil_pcie.pcie_reg_base address type
Thread-Index: AQHUQr16sUl/SdO3SUKR8PCQxLBPbA==
Date:   Sun, 2 Sep 2018 13:04:28 +0000
Message-ID: <20180902064601.183036-69-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:NaulRX58jdeZb9T5G11/MBrfpTYdoz0rLFJJXApZyiMeq8DKOEG120EQmRDB1EICltXI5Rik14GmBeiOkEA6N6LA5LEwdCv98V14O3IF8Ye7hi4IVY+P8RH4lNlvTlaDNmtYmWbvEfV0qYdI1jyEC/nJLVrw/WtftgB8LBeJMk0TeCSQX3+Rd4vnRCNhS/FvoU+TKnR0lfb6JJQSeApnPFCyrkBT1QHnf2oUpbS5k+q0fxe19TUrzlI1/g6PBh67A0I9TanvW/72yJLmgBy6RFk/ayVHimZmlswtWWvUwKl7fsBQCHHft3umu/Pz/bd/NufEwlWZxcWt72wp0y00VhHZJgFhPXF7AwvwaFaYI0dosSZ6H7ghB0O2jqW9FULt9rwHhd1hsA/IU0uEZuaE7lwjQ2WgaAvuPP6czGKRqjvax/F+rYnvyxuoqrGnRUVo3k0Km+jOdeIVrnYTuMfZCQ==;5:jX9D3GS++YfmyPtXtVmNz/x5SgnqA/cFZSLQ5QwIArsHlozPVjDuo3PT4gUyA0vW/mURsfApmuH7zp08CJqXDtN3DB5NEJ6OgrwsplC+cxNZ294Yiq7lEqAKO2ORfrF3ebXshJ8QRdLbjjrH8sF2eMruHlH/EicwKAfWNKeN2FU=;7:TOvL2dXutNoWetg3ueKQSPHDfTkrKtlJUnNKC9YEnu/IROo9AeaFGrcsv09pqaM7XYyepbJGCLh7Sh/TOe2mDWeCWiS4xdT3OGSm7cbOYsJMh7swi3Mz2sV94b7Wk3w+16VXDCHY+hZWmLwUdnGL8hsAZKAvqUB/PqGgGrFUE3tr3YKzH4Fk3gm5ovO2f1jwaJyN99D264nJfuVLryktxZde7Vu5bWwtbBrCu6UgP029JRNCK0h1ff+jPE2XhVfU
x-ms-office365-filtering-correlation-id: d8464601-949a-4863-3381-08d610d4abda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01208F215D2059B0A363F3C7FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XEndJzSiEgrYw7NiCCLqxj+YcpUyhALJrUIPY/KOYVboh4TlvRYycTpwCqmZB7FF/t+0wZ9CqhydiZbD02gNgHOAksDEVWwjhWGMRJRIm7axpKIP64YOjdQN5m5TB0CdPvhyNR5L/+60yH6TV39mhUe4NW1kqiNtxbK0N9x/7DxQLAyGEJRfAi9Kbwyv7ht686UvmSyBpyNgzl1dusG40aGNGr+9TeNzLrMR8pxdZeQfSO0gwtF/4pOHiZ7DygvG4RUDYllIFmm7vAaGcoWQWQeitX8Byfsy47TS/uXrbcjsQndtYiaJxfWHZ0+XhljgbZIsQZBQvC61I5h43NUiRivgF+0b7YkEY6LICOa29Vg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8464601-949a-4863-3381-08d610d4abda
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:28.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit af3f606e0bbb6d811c50b7b90fe324b07fb7cab8 ]

The field pcie_reg_base in struct mobiveil_pcie represents a physical
address so it should be of phys_addr_t type rather than void __iomem*;
this results in the following compilation  warnings:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_parse_dt':
drivers/pci/controller/pcie-mobiveil.c:326:22: warning: assignment makes
pointer from integer without a cast [-Wint-conversion]
  pcie->pcie_reg_base =3D res->start;
                      ^
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_enable_msi':
drivers/pci/controller/pcie-mobiveil.c:485:25: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t msg_addr =3D pcie->pcie_reg_base;
                         ^~~~
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_compose_msi_msg':
drivers/pci/controller/pcie-mobiveil.c:640:21: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t addr =3D pcie->pcie_reg_base + (data->hwirq * sizeof(int));

Fix the type and with it the compilation warnings.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 2c81be37b010..a939e8d31735 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -132,7 +132,7 @@ struct mobiveil_pcie {
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;	/* root port config base */
 	void __iomem *apb_csr_base;	/* MSI register base */
-	void __iomem *pcie_reg_base;	/* Physical PCIe Controller Base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	struct irq_domain *intx_domain;
 	raw_spinlock_t intx_mask_lock;
 	int irq;
--=20
2.17.1
