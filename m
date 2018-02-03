Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680948-2-14516162912369337505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680947; b=HRduDBVP+UOREMu/zj1dMOd8UwYlqcgU7Rpds7nAUI3/KzA
    O9Xc0VLNjOrTOj6s2rHVlDwySjbzLzVq05UR5wwbiIA77BvNimSb0yZOejj25snd
    TBd82bOsZ/HdtNh/rfmdF17sMvvAeoRPF/NuxverP/o40MCBlj+8PCCBu4aBus2s
    Hxr479ep+rM2W1CLR/xrp4zmDZMbKz4uNfl4KA4+W9+MzW2ve2CWSI5qXH1oFzfu
    496bdlNrHN98Mx3GxkVkYWFI6jlckLlJEmZZxzcDlKrguRHyPhS0O/hQA1j6+3NG
    GWQQBYPd1nf9ChA6kzNVjCQWE3A1JXbBpmDsGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680947; bh=SecAV7
    m7CekgFyttKgSwNXQT4AdRxODyPorGYF4fcG8=; b=BjAgNCQdVQr4yeQt3r8xtl
    KzHQOhLjBymfHE7Gl2wMS6knpMbfF+QJvyGhAKjfvd4fhJPj9AWBT3R6Y507pXxG
    81WCiMnpxvQhBYfmTo+dG47GQxzv+DTJkVk7wcSdhqoF0memgAgoigSeVmjVTEdf
    ZBi3eGVBUFDV0z2t7OYOGTarFZp4MlR5WE/Srfgd0JZ46+8eu5vgo8M4RIG75hv1
    X8OMLK71TPtQpsBlwQXKlFrSFJi8vVcceZFY2mZXj2n2/TeJP/Ys5QDO85gz/5MF
    Mp5xFm/ERxCcM0ke0YNcYemFs03N156Tk4n2zVFcpXJt93t/LB3pLTShoKt3gw4A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rhqle2Ss x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rhqle2Ss x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeBCSCQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:02:16 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752817AbeBCSA5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Igor Russkikh <igor.russkikh@aquantia.com>,
        Pavel Belous <pavel.belous@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 011/110] net: aquantia: Fix hardware DMA
 stream overload on large MRRS
Thread-Topic: [PATCH AUTOSEL for 4.14 011/110] net: aquantia: Fix hardware DMA
 stream overload on large MRRS
Thread-Index: AQHTnRjhg/BwjHUIsUGY0+ZjKUhQwA==
Date: Sat, 3 Feb 2018 18:00:31 +0000
Message-ID: <20180203180015.29073-11-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:a41RSPfp7ghC8s7boOCXUoqN7cYl1ZkFBlJVnw8hBwZYsVOLOSED3VvrtvgCNQBt6XU9s3iRMuh5huGv1Ajrdj66X4mBbTIEH7lKpQarGSRFArPiApXbVZaPMKPYS254svq7zgn6ZT6xCWsWhsldBPzzrWGpT7oaFPDzeGjeyZBJKb+0DaqIslkWcqvtRc8DDG+CKJ3894UbJT5LnjA2HZg+xVHUmm/3XuRlSEl2K3K6O3tY0leU8F71/UUjFyVF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe336544-a367-4cea-6211-08d56b300593
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB104389CDE1CF4979A0A6C48CFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(8666007)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(551934003)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: BKTE99ZIesXBKRxL2x+kHWIqv5ENSQXnbTcIQLNt88tGUpBb/7WCHF2GuzmZ+JaRlUiR+nf7yYyeKPN0qwOKPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe336544-a367-4cea-6211-08d56b300593
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:31.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Igor Russkikh <igor.russkikh@aquantia.com>

[ Upstream commit 1e366161510f266516107a69db91f1f2edaea11c ]

Systems with large MRRS on device (2K, 4K) with high data rates and/or
large MTU, atlantic observes DMA packet buffer overflow. On some systems
that causes PCIe transaction errors, hardware NMIs or datapath freeze.
This patch
1) Limits MRRS from device side to 2K (thats maximum our hardware supports)
2) Limit maximum size of outstanding TX DMA data read requests. This makes
hardware buffers running fine.

Signed-off-by: Pavel Belous <pavel.belous@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c    | 12 ++++++++=
++++
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h  |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/dr=
ivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index e4e3b8e2d67e..36fddb199160 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -16,6 +16,7 @@
 #include "hw_atl_utils.h"
 #include "hw_atl_llh.h"
 #include "hw_atl_b0_internal.h"
+#include "hw_atl_llh_internal.h"
=20
 static int hw_atl_b0_get_hw_caps(struct aq_hw_s *self,
 				 struct aq_hw_caps_s *aq_hw_caps,
@@ -368,6 +369,7 @@ static int hw_atl_b0_hw_init(struct aq_hw_s *self,
 	};
=20
 	int err =3D 0;
+	u32 val;
=20
 	self->aq_nic_cfg =3D aq_nic_cfg;
=20
@@ -385,6 +387,16 @@ static int hw_atl_b0_hw_init(struct aq_hw_s *self,
 	hw_atl_b0_hw_rss_set(self, &aq_nic_cfg->aq_rss);
 	hw_atl_b0_hw_rss_hash_set(self, &aq_nic_cfg->aq_rss);
=20
+	/* Force limit MRRS on RDM/TDM to 2K */
+	val =3D aq_hw_read_reg(self, pci_reg_control6_adr);
+	aq_hw_write_reg(self, pci_reg_control6_adr, (val & ~0x707) | 0x404);
+
+	/* TX DMA total request limit. B0 hardware is not capable to
+	 * handle more than (8K-MRRS) incoming DMA data.
+	 * Value 24 in 256byte units
+	 */
+	aq_hw_write_reg(self, tx_dma_total_req_limit_adr, 24);
+
 	err =3D aq_hw_err_from_flags(self);
 	if (err < 0)
 		goto err_exit;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_inter=
nal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
index 5527fc0e5942..93450ec930e8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -2343,6 +2343,9 @@
 #define tx_dma_desc_base_addrmsw_adr(descriptor) \
 			(0x00007c04u + (descriptor) * 0x40)
=20
+/* tx dma total request limit */
+#define tx_dma_total_req_limit_adr 0x00007b20u
+
 /* tx interrupt moderation control register definitions
  * Preprocessor definitions for TX Interrupt Moderation Control Register
  * Base Address: 0x00008980
@@ -2369,6 +2372,9 @@
 /* default value of bitfield reg_res_dsbl */
 #define pci_reg_res_dsbl_default 0x1
=20
+/* PCI core control register */
+#define pci_reg_control6_adr 0x1014u
+
 /* global microprocessor scratch pad definitions */
 #define glb_cpu_scratch_scp_adr(scratch_scp) (0x00000300u + (scratch_scp) =
* 0x4)
=20
--=20
2.11.0
