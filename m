Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680919-3-6864570311575160362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680918; b=VH5fQj/ojvC2WIZb9ySZBfflOS7ZDkcyKFHN8pmNOuCQQmd
    ffV71tHTeLQqctLraiYSbhHZggvRDyr1mEgkO2KX5KMwFUxjaah12JYlaSPAq0/z
    tzJsEBi3qAdLGW2lIgqMioI+SyffK6X3ubRWtF2ppvxqqPjn5O4/sSe6yYKZY+va
    TXUhUZOcRF7inkVzg5iMz3HReZPqmPiP9oDOrVxIEmhEA6ZOhNQ8wjWvpNP5M/+2
    saH3S8UbcQxF1K7oc2keujSESX7C4m5ro05cRIbAUyai92eeSiuNTQ9kZq4XPIsD
    ZWjiD9jtq/dmKFFNFeEzUojL74IvTslX3vXkuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680918; bh=wZXSYl
    v2aUux4h/k0mSfo3qWCw47mv3NAHWdsMCh4vU=; b=DdqxYxZAQSj2S91tHOQqhS
    G76BhvCNTXVPYWn8nxJ5BVfL+lFPdTT+p2qkpEvd/0SNHj2UceQnS0YrtPh7mBfs
    TAFApBwsy52ldO5mICzIRFV/eUFz7ynDdzgDCBmZeQUJHQCEBvJJaVfWOkn9fv1G
    CzowCFisZLG417BJuYIj0v7k5X18vO8olLy8GUvNbUvhVcEvvzfgo0+M8fhlgAvN
    lD3tWc/jnCdorKZmPx2J4VR3Z6nMlOgLA+M87oNDJ7A5AD9Ti99MwllfilWlJyp0
    6ZvZ94rM+9u7L9cSMSiU8h6/UJQvUpdam4uP0A3H4OeLXjiUbP5iuuy74mWxRBQA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cmgV50Lx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cmgV50Lx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeBCSBw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:52 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752748AbeBCSAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 010/110] net: aquantia: Fix actual speed
 capabilities reporting
Thread-Topic: [PATCH AUTOSEL for 4.14 010/110] net: aquantia: Fix actual speed
 capabilities reporting
Thread-Index: AQHTnRjhdKrS9A63rEKaz2tao+3Z5w==
Date: Sat, 3 Feb 2018 18:00:31 +0000
Message-ID: <20180203180015.29073-10-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:E5TYKhw9Axs2L940c+M0AuPXYvNKVlKeoE2q0pwQhOA8xx+VJuBMzbDElUgaNcI1Lhw002/QWmzpl9IIguOmQ3bBsseJ/uBj0G1BGjWGmerng3dflzXjmqy/ceZj3lGLCBE7v2ZG/aEs2FlpbXQxDXUAjdPOagOYG0UYZu7Xyc/EK0FiBjQGdnaET0mNG4qVqzSGKRpFnFxxeOhgYfrrpuenV9KDcGdy9Hvt4+fkQeyeHQv68X92FMfVnkWvZGlD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d85caebb-bdcb-4756-028b-08d56b300553
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043C33171C68E722F0B060FFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(8666007)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: gVS5iRIZo1zK3U7Zy2R5FPbVSZrNJNETasDfX3Tr9aQP1OjsiBpoM06exnCPfZwEQjRQLTWGOy/DGWdoCpepWw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85caebb-bdcb-4756-028b-08d56b300553
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:31.0971
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

[ Upstream commit e4d02ca04c6d48ab2226342a1c4ed54f1dbb72bd ]

Different hardware device Ids correspond to different maximum speed
available. Extra checks were added for devices D108 and D109 to
remove unsupported speeds from these device capabilities list.

Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h            |  4 +++-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |  7 ++++---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h           |  2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c      |  5 +++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c | 13 +++++++++++=
+-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 13 +++++++++++=
+-
 6 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/e=
thernet/aquantia/atlantic/aq_hw.h
index 0207927dc8a6..4ebd53b3c7da 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -85,7 +85,9 @@ struct aq_hw_ops {
 	void (*destroy)(struct aq_hw_s *self);
=20
 	int (*get_hw_caps)(struct aq_hw_s *self,
-			   struct aq_hw_caps_s *aq_hw_caps);
+			   struct aq_hw_caps_s *aq_hw_caps,
+			   unsigned short device,
+			   unsigned short subsystem_device);
=20
 	int (*hw_ring_tx_xmit)(struct aq_hw_s *self, struct aq_ring_s *aq_ring,
 			       unsigned int frags);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/=
ethernet/aquantia/atlantic/aq_nic.c
index 483e97691eea..c93e5613d4cc 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -222,7 +222,7 @@ static struct net_device *aq_nic_ndev_alloc(void)
=20
 struct aq_nic_s *aq_nic_alloc_cold(const struct net_device_ops *ndev_ops,
 				   const struct ethtool_ops *et_ops,
-				   struct device *dev,
+				   struct pci_dev *pdev,
 				   struct aq_pci_func_s *aq_pci_func,
 				   unsigned int port,
 				   const struct aq_hw_ops *aq_hw_ops)
@@ -242,7 +242,7 @@ struct aq_nic_s *aq_nic_alloc_cold(const struct net_dev=
ice_ops *ndev_ops,
 	ndev->netdev_ops =3D ndev_ops;
 	ndev->ethtool_ops =3D et_ops;
=20
-	SET_NETDEV_DEV(ndev, dev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
=20
 	ndev->if_port =3D port;
 	self->ndev =3D ndev;
@@ -254,7 +254,8 @@ struct aq_nic_s *aq_nic_alloc_cold(const struct net_dev=
ice_ops *ndev_ops,
=20
 	self->aq_hw =3D self->aq_hw_ops.create(aq_pci_func, self->port,
 						&self->aq_hw_ops);
-	err =3D self->aq_hw_ops.get_hw_caps(self->aq_hw, &self->aq_hw_caps);
+	err =3D self->aq_hw_ops.get_hw_caps(self->aq_hw, &self->aq_hw_caps,
+					  pdev->device, pdev->subsystem_device);
 	if (err < 0)
 		goto err_exit;
=20
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h b/drivers/net/=
ethernet/aquantia/atlantic/aq_nic.h
index 4309983acdd6..3c9f8db03d5f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
@@ -71,7 +71,7 @@ struct aq_nic_cfg_s {
=20
 struct aq_nic_s *aq_nic_alloc_cold(const struct net_device_ops *ndev_ops,
 				   const struct ethtool_ops *et_ops,
-				   struct device *dev,
+				   struct pci_dev *pdev,
 				   struct aq_pci_func_s *aq_pci_func,
 				   unsigned int port,
 				   const struct aq_hw_ops *aq_hw_ops);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers=
/net/ethernet/aquantia/atlantic/aq_pci_func.c
index cadaa646c89f..58c29d04b186 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -51,7 +51,8 @@ struct aq_pci_func_s *aq_pci_func_alloc(struct aq_hw_ops =
*aq_hw_ops,
 	pci_set_drvdata(pdev, self);
 	self->pdev =3D pdev;
=20
-	err =3D aq_hw_ops->get_hw_caps(NULL, &self->aq_hw_caps);
+	err =3D aq_hw_ops->get_hw_caps(NULL, &self->aq_hw_caps, pdev->device,
+				     pdev->subsystem_device);
 	if (err < 0)
 		goto err_exit;
=20
@@ -59,7 +60,7 @@ struct aq_pci_func_s *aq_pci_func_alloc(struct aq_hw_ops =
*aq_hw_ops,
=20
 	for (port =3D 0; port < self->ports; ++port) {
 		struct aq_nic_s *aq_nic =3D aq_nic_alloc_cold(ndev_ops, eth_ops,
-							    &pdev->dev, self,
+							    pdev, self,
 							    port, aq_hw_ops);
=20
 		if (!aq_nic) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/dr=
ivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 07b3c49a16a4..b0abd187cead 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -18,9 +18,20 @@
 #include "hw_atl_a0_internal.h"
=20
 static int hw_atl_a0_get_hw_caps(struct aq_hw_s *self,
-				 struct aq_hw_caps_s *aq_hw_caps)
+				 struct aq_hw_caps_s *aq_hw_caps,
+				 unsigned short device,
+				 unsigned short subsystem_device)
 {
 	memcpy(aq_hw_caps, &hw_atl_a0_hw_caps_, sizeof(*aq_hw_caps));
+
+	if (device =3D=3D HW_ATL_DEVICE_ID_D108 && subsystem_device =3D=3D 0x0001=
)
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_A0_RATE_10G;
+
+	if (device =3D=3D HW_ATL_DEVICE_ID_D109 && subsystem_device =3D=3D 0x0001=
) {
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_A0_RATE_10G;
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_A0_RATE_5G;
+	}
+
 	return 0;
 }
=20
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/dr=
ivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index ec68c20efcbd..e4e3b8e2d67e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -18,9 +18,20 @@
 #include "hw_atl_b0_internal.h"
=20
 static int hw_atl_b0_get_hw_caps(struct aq_hw_s *self,
-				 struct aq_hw_caps_s *aq_hw_caps)
+				 struct aq_hw_caps_s *aq_hw_caps,
+				 unsigned short device,
+				 unsigned short subsystem_device)
 {
 	memcpy(aq_hw_caps, &hw_atl_b0_hw_caps_, sizeof(*aq_hw_caps));
+
+	if (device =3D=3D HW_ATL_DEVICE_ID_D108 && subsystem_device =3D=3D 0x0001=
)
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_B0_RATE_10G;
+
+	if (device =3D=3D HW_ATL_DEVICE_ID_D109 && subsystem_device =3D=3D 0x0001=
) {
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_B0_RATE_10G;
+		aq_hw_caps->link_speed_msk &=3D ~HW_ATL_B0_RATE_5G;
+	}
+
 	return 0;
 }
=20
--=20
2.11.0
