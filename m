Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491276-2-3914882080716511558
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
    t=1520491275; b=tXZ+g5aU6Gd0ZRQYA4oVubiSwtoiLrA6TjHXaiMaz0wXw3Z
    dv48PGsEWjLHYXCuojCzzVFuCy7RMCRR+30YczJN/kkaP0cExJ23VE7Dyku0NLXl
    R60V3rlf7sSNFm+neC+330GjYiyiaaapRXNkyky0kzTcvivwSFp/TtusugkA8XH8
    TJbtOnnUwZyqKAzM1vgFph1cGyJ8uusECL9cEfnFw6KrWUeHpH4q3aGi3fpv+HzR
    U/gX6p783q8UgVyjWrVl9vu5PHIGkzIN5GYSj5/dmHDDDKci+TSM2ydZNZ2w8Jef
    kLtg2DDEcKmFWj+zpV693T/8tarEhZR2kpjoTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491275; bh=Wf2jXc
    VZOT2Z9mBzrfGCRvJb5+7RE+3B4jxCzN4Z4G8=; b=j2YEn3Z1qMClXnx+d9QkQH
    ZTfmqU3/p4RRi9+Jj1bLCmuOzYWIkTkA46Dgqvn17Zm5ktS4NSaFpTqTVI7TLkeN
    gd5+/YZq0TwIBCxYk/ott5OyLymj52GAzezyXieEqbdRkj8ZtxBOw4UeATK8uWbA
    Ccu+ACwK/Tu/3WZztz5LNxsNyriwjXs/hpdkw+yVS9CnhwAS8IALNVlF5piC5rAF
    Jao+VExesJ5CbsGQEx1FFefKqRWA3Z8T6WlKDVX3zygpBULli5Rjc2jczSemzQee
    8b65xLCUowy+XH7nSY//qNvytlwqUqPqXhWn29JP/UH6JH8zbTLwiu/YanWPJPtg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VeA9e1rX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VeA9e1rX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbeCHGlB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:41:01 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935349AbeCHE7I (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 46/67] PCI: designware-ep: Fix ->get_msi() to
 check MSI_EN bit
Thread-Topic: [PATCH AUTOSEL for 4.14 46/67] PCI: designware-ep: Fix
 ->get_msi() to check MSI_EN bit
Thread-Index: AQHTtpoD22YSCWqcKkGq95a3r9pRaQ==
Date: Thu, 8 Mar 2018 04:57:51 +0000
Message-ID: <20180308045641.7814-46-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:n9f4aRxPLeHHs0Sr0Vfii0jExhhOKVOJuXgPaKWXnnLCKZYw8jL5VqY0X5ayOi6iU9EuFOPJl4tn9zNN6O4QYHZbahVS7nubXmdPcwQk7CPiPk4OizesCxzFLfrWidZzt63GJ979YmZkggigOSp7XZyqLOisryzRH27yVok7n0txVBTXk29Blpkr6F5WknjXS8XPQljaWBmBvejCn9ZIntOTzX7mESLD1c/4ks+StMfogL293zwQ8HNHXYugT94E;20:wodZgjXzIQ+ZjTtRZvpectog2C21fwWFF9isVNFtuwO60e3wacnbX0+NTLCiRTxIX/lEiLd/jGS2YuCdyXc9RQF5lxo14ZMKlcEamXBPfS11YfP4UVX9+9OoneoyavyaxDg0meCwCgtFw1ClQdmUq26Kwp72Ruqaua78ySK3SJI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8397f4a7-2151-4f86-d925-08d584b15201
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D4136A2596675F810605FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UM7ZhY8hK0uJ8qX527m+e2DLIokQI8bLwEHoo53C3wZdTDErnUzPcTj6z5/I7vgDpKhWqWtbWdjk+RgTVtfvgHRFTCOtvcuYdEA3SCK0jWXGswAq5NHWV1R3aneLvFjVMsa/uKXgc9aMrkkSf1QmGaxzLVkmUt+sXC4GQHzeAhH7PFRSnr1OHAfYD/zivtkW6JzgSwDJPc83qJPiIvjxsLZf7x/p+cn+hIIk9cv7h7qe4bSp9RNR61BQY7YET++WMuagO/oRaF5CBhScTvn9kI4WpqF5O8pWUEduTwLgpTYCEuwEYrt7Ye1yzZiwjLTTABdxNf3V0/W0HWi7pMJkMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8397f4a7-2151-4f86-d925-08d584b15201
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:51.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
