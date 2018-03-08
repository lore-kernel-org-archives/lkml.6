Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492404-2-7690841228867158682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492403; b=VSSeFd2qUP6M5SdeXPKjQDzEyqxLimRnry2iHkWnsIMtcpA
    Ra+odsDXr1wCOhPO58uspiMqn77EGGK2i2insdX/sgeoBroigft/RlvmDA8x0olV
    EfoaDP5sGPVOpB3E34cUiPpQuVfKLMkI4cB9ctNHHLPAuR6MvdM+W/Sz2o6vFZZz
    biRtcgEa+Pfss9yhtb19IwnbksO1o09Wxki/CMdUv9KkbPqk8vHA1rPh7qXre+wr
    i92jx4VHl+/0kbrrt+8TG3w1+bKWh9vfKdJJBsFzHAPKHZimpNhc3HVGsBA9RQKr
    DxCunvfJhT6HhxtzeYJ3v21uJgdezz1l7gjIW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492403; bh=Wf2jXc
    VZOT2Z9mBzrfGCRvJb5+7RE+3B4jxCzN4Z4G8=; b=HOScrC/otHJD8zHylgOSmg
    nZchfgb875IeS4sLvsET98n76YBbgKSxT7TmSvc+aytAhx3xhoIw1fEzTj6BedD6
    2QXZbyHsgFYY0QW7WB/aUc9K2MUsBBfUc9boCaUwN+3rYDSIkJyuhkDY6lLE3NC5
    4CpXlkePsGcHyzw/pbjGfK4zirx19G9e1ZdHXK4rHj+tNfP2FNqCuoaElY2iwuZj
    GTCvWDCCf+g6dYOUWuN4DDCgX8cqa1rG8Mj2bO83XM0kcw7e1r7Bto3zeyjks32A
    7LAG+XpLbj18bPXylKJZ/vQeN2mJc1e58l7AyTLh86e3yz4LdfMhcr2E8wUO3vAg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hIB0rYy+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hIB0rYy+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934998AbeCHE5W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:22 -0500
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:4352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934948AbeCHE5R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 53/78] PCI: designware-ep: Fix ->get_msi() to
 check MSI_EN bit
Thread-Topic: [PATCH AUTOSEL for 4.15 53/78] PCI: designware-ep: Fix
 ->get_msi() to check MSI_EN bit
Thread-Index: AQHTtpnPLeG+NGMoa0Okfott0VH1Zg==
Date: Thu, 8 Mar 2018 04:56:24 +0000
Message-ID: <20180308045525.7662-53-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:S6Zk066UBoxq5aQ/HqGqAP99BsCWuDc44SVaz4F5xPpAHsXNwqnO8Gk3hGow8U8DDA0r+JKROTOU7IBkj4VgEYyYk/38Qkk5HwdE5C/cSXcSrk5vDwTHMrtsUyUKJnHUjcza5dP6CvIny9HLJ8XnXiCGJCwbLffQuPpkGOodPo1jkXzpAOX1KR+SzwbMK7ncaTJPl/zSY4RQ18SixwcUY7S2tHPOV34FiA770iAJN0YDnKxxHYkPgXRY5sQLTV1+;20:ihB0P04HExDiRBtdFWOm8Igg93y/aZDV5lED33wU8362CXyLR2A5PiQg0yA3kv9P43Excm6J63MBA6BEmwsKArJeRS9c38P1AFDdgBf5YOSFyvBCNd2tTEW21naWMHytOwUGhu4g0F509kXYL79QFqHbrPJzUFzdG61Cv/xvOgk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf22de95-8d8c-4d6e-2a63-08d584b10f3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103214AC47416A9414C2F7A9FBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(575784001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mYyH37HsU38UNZZwyUSVl9y1ULZkOpybQiGYt/99rScrSMEOyPBVEvSpq1ZSbqWexv/Jt+MkjfCSle3x+AblIKqOzqPk3+P1WdHgMfju1qWvDvlG3NYiNRrgZI+0KG6LX0auiSR/AlOGJg/ixLPn3u6tmRqFBu5SYRaG3qRCJw3EYUP0YIzhVq+ZqxuS32e82z4Sgqdd9M6OECTmWyA3Vgp+MYMU1egr8rQo2zqLymFMQlIEFIT10enThS5Hsg30PChWQzzKNwvFY+YNuIbJAM/EHD407U+74WIQxpOHMJtv9XkWH3hzFhTIlf/AnvvkW5ySMOJ+hGOta56kVHNZgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf22de95-8d8c-4d6e-2a63-08d584b10f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:24.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit a134a457ed985dca8cce7ac4ea66129ea70eba73 ]

->get_msi() now checks MSI_EN bit in the MSI CAPABILITY register to
find whether the host supports MSI instead of using the
MSI ADDRESS in the MSI CAPABILITY register.

This fixes the issue with the following sequence
  'modprobe pci_endpoint_test' enables MSI
  'rmmod pci_endpoint_test' disables MSI but MSI address (in EP's
	capability register) has a valid value
  'modprobe pci_endpoint_test no_msi=3D1' - Since MSI address (in EP's
	capability register) has a valid value (set during the previous
	insertion of the module), EP thinks host supports MSI.

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 12 +++---------
 drivers/pci/dwc/pcie-designware.h    |  1 +
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-de=
signware-ep.c
index d53d5f168363..7c621877a939 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -197,20 +197,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, p=
hys_addr_t addr,
 static int dw_pcie_ep_get_msi(struct pci_epc *epc)
 {
 	int val;
-	u32 lower_addr;
-	u32 upper_addr;
 	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
 	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
=20
-	val =3D dw_pcie_readb_dbi(pci, MSI_MESSAGE_CONTROL);
-	val =3D (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
-
-	lower_addr =3D dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
-	upper_addr =3D dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
-
-	if (!(lower_addr || upper_addr))
+	val =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	if (!(val & MSI_CAP_MSI_EN_MASK))
 		return -EINVAL;
=20
+	val =3D (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
 	return val;
 }
=20
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-desig=
nware.h
index e5d9d77b778e..cb493bcae8b4 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -101,6 +101,7 @@
 #define MSI_MESSAGE_CONTROL		0x52
 #define MSI_CAP_MMC_SHIFT		1
 #define MSI_CAP_MME_SHIFT		4
+#define MSI_CAP_MSI_EN_MASK		0x1
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
 #define MSI_MESSAGE_ADDR_L32		0x54
 #define MSI_MESSAGE_ADDR_U32		0x58
--=20
2.14.1
