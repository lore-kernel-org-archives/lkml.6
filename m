Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683828-2-7125421358245560338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683827; b=BjS2F9FUWgc8pIIE+I8V+Ld9iDhMd0NYD5I2b13/SdhySNe
    DyewJ1WVkj0sR1EMA1SWD6yCBEbDg5T5dNWZqB09lkJjLz1DMBqaZRuYKymOzfw2
    qTBRojIdDyWL0P/Z5T3lcw+selmRDRlb4vmOsiaOTnThT4TUhKkUwJsmVHsG3DNj
    n8hDUjY7TLpoftzeau7Vj/tGaUxP37rdcO/M84mHnj+q2BzoI9cdbQ/nhSFGzcZH
    DnS/wjUbY1OMOrnY7YUSSnO5b3tQdmL7RrgyfmWx0ebLIqYtE0OZaH204YWA0fVV
    DxIl2vsLT8tdUkO8o6Q+WTEwZvvNWx4PsKI1YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683827; bh=9KImRx
    wQr5bmXE37aQoX+4No3Y0KgWHTWR3Gf+BWiz4=; b=vrxhiP7tOBk854PqV6XOQ/
    ze5FzLDFjK8lqfox0w6x1En4fwuZv43BpaBudzXLnf01at4WyoppNHO8qRnYjsyq
    f5Bd1xaLSvkvc29uWDaJK3TwrS3DFaTpBr5f94urFb+KJsm+avo5YnKBeTN+Zm7X
    wmzpdhpBCqE3LelSh9sYl4UU52a3XbVUtHIc7+v54zI/PY6KW2K4UQ8JmQcuuI4A
    S85Dn1LXsfPsGnCZ0JQMwK40d3uhKULFcvB1JNFzq1TNq4vHZCmNU3OjFL/7vyqC
    TCF1qQ03u3INiqkV8AIwkDkL5QM434yUvFEKYJaW79FYhWQFimeWINBiyP0oYg2Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aID2Ac9k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aID2Ac9k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755385AbeBCSqo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:44 -0500
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:34880
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752906AbeBCSBa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fredrik Hallenberg <megahallon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 040/110] net: stmmac: Fix bad RX timestamp
 extraction
Thread-Topic: [PATCH AUTOSEL for 4.14 040/110] net: stmmac: Fix bad RX
 timestamp extraction
Thread-Index: AQHTnRjrr2ziD6MUhUWp7jw2pT0W9A==
Date: Sat, 3 Feb 2018 18:00:47 +0000
Message-ID: <20180203180015.29073-40-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:TZndtYEeyUGCtQHNzTqB3inAFCIw6uqGTYM4benouXLlO7jo9JCQS0oggiDzXGENFDu7Ei+D/i7nXxh5CNM6rwrAda9PQBo9lP0xzMdhL8K8Wq2rUvEbBDvLR4k/2VnICAHpz06nvUs9v+kIIb5tBDsfeFo6W0XNtlqloeZSBEsq5sXs7Z06wXD2LXfHLFLHifysWNxBdpv8y7r1BVguBAYq8NLcpNBGYIRnJs8SZMqPsE0n7uTqmE0UCo2Fhhcxw1Dy/1Z9NX1GBBdrzYGvRRdgd1/ulkFU1yz6SUDdr4N/gMmZWKWeCGP70mafXieKwgz6bMNYJnBsBCjq3BdwjvuTqdTLGgEsN+M2lnYVNNDX2JhjRuxXGq+SjWWCIPFY;5:sI2Tvfb5suoELUjBzIXf2gtQdMPPSzk9dQKNC1WyBwSKZccHn2gts1hyskHITYjov1gxvyizEE3Yl3JbYr8UvriZ/PTn4PlzPAURl8ohgPG7aoAs/PkFKXohiahkpdBRQy16i+bTodBVkC5Z0e/3EQuvDfBFLwDE2ENpXhocwtM=;24:q54Xjf2DnZk4VOlg8Dp64Nl5772B1xnEyRoLj1GsyaUIxbyOjKFDiFOXNvqVF6Zpvad8D2IOKz94iDAQ+pNBy8oidzaUOMxJ60louiUVHeA=;7:WdhPiCuIFZ2WJzSLiMERR0dxYNYotQKFNFvwT7y0kO6SIRWW4nEjSo/oD3uFS7GKSVVHRDc0vtYKuVDEdrd2Wlw3GoKi1DQc+ekzSPqmRgJIJ+9ozW0Exnel+KdezmbC6rZD1GmXizu10w9rJrj+ZZIGtKa4Dbd14zVkO3g+rO2zhExolYd1DbJiiPd75TIQCX/1Qs1luxFiXzwBYCrRogBiLu4o/dFlEjdj8bLxzW0fiZfWe+yL3N9GgmqK+Rp0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04adb8e3-5e89-4d53-8bbd-08d56b3021de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092B8EA3586AF24751A85CAFBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(39060400002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 6xdgexsF2C7mTJBDHdM2zG2in1edxw6nuxJP/Lyn6feZfrhTTKMIAx0KA/N784ymErwnX7alburTi3BK5JzV7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04adb8e3-5e89-4d53-8bbd-08d56b3021de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:47.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fredrik Hallenberg <megahallon@gmail.com>

[ Upstream commit a1762456993893795030d911106a7650481db0ef ]

As noted in dwmac4_wrback_get_rx_timestamp_status the timestamp is found
in the context descriptor following the current descriptor. However the
current code looks for the context descriptor in the current
descriptor, which will always fail.

Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 5 +++--
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/eth=
ernet/stmicro/stmmac/common.h
index e82b4b70b7be..627fec210e2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -409,7 +409,7 @@ struct stmmac_desc_ops {
 	/* get timestamp value */
 	 u64(*get_timestamp) (void *desc, u32 ats);
 	/* get rx timestamp status */
-	int (*get_rx_timestamp_status) (void *desc, u32 ats);
+	int (*get_rx_timestamp_status)(void *desc, void *next_desc, u32 ats);
 	/* Display ring */
 	void (*display_ring)(void *head, unsigned int size, bool rx);
 	/* set MSS via context descriptor */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac4_descs.c
index 4b286e27c4ca..7e089bf906b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -258,7 +258,8 @@ static int dwmac4_rx_check_timestamp(void *desc)
 	return ret;
 }
=20
-static int dwmac4_wrback_get_rx_timestamp_status(void *desc, u32 ats)
+static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_de=
sc,
+						 u32 ats)
 {
 	struct dma_desc *p =3D (struct dma_desc *)desc;
 	int ret =3D -EINVAL;
@@ -270,7 +271,7 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *=
desc, u32 ats)
=20
 			/* Check if timestamp is OK from context descriptor */
 			do {
-				ret =3D dwmac4_rx_check_timestamp(desc);
+				ret =3D dwmac4_rx_check_timestamp(next_desc);
 				if (ret < 0)
 					goto exit;
 				i++;
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/e=
thernet/stmicro/stmmac/enh_desc.c
index 7546b3664113..2a828a312814 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -400,7 +400,8 @@ static u64 enh_desc_get_timestamp(void *desc, u32 ats)
 	return ns;
 }
=20
-static int enh_desc_get_rx_timestamp_status(void *desc, u32 ats)
+static int enh_desc_get_rx_timestamp_status(void *desc, void *next_desc,
+					    u32 ats)
 {
 	if (ats) {
 		struct dma_extended_desc *p =3D (struct dma_extended_desc *)desc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/=
ethernet/stmicro/stmmac/norm_desc.c
index f817f8f36569..db4cee57bb24 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -265,7 +265,7 @@ static u64 ndesc_get_timestamp(void *desc, u32 ats)
 	return ns;
 }
=20
-static int ndesc_get_rx_timestamp_status(void *desc, u32 ats)
+static int ndesc_get_rx_timestamp_status(void *desc, void *next_desc, u32 =
ats)
 {
 	struct dma_desc *p =3D (struct dma_desc *)desc;
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 0ad12c81a9e4..d0cc73795056 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -489,7 +489,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *=
priv, struct dma_desc *p,
 		desc =3D np;
=20
 	/* Check if timestamp is available */
-	if (priv->hw->desc->get_rx_timestamp_status(desc, priv->adv_ts)) {
+	if (priv->hw->desc->get_rx_timestamp_status(p, np, priv->adv_ts)) {
 		ns =3D priv->hw->desc->get_timestamp(desc, priv->adv_ts);
 		netdev_dbg(priv->dev, "get valid RX hw timestamp %llu\n", ns);
 		shhwtstamp =3D skb_hwtstamps(skb);
--=20
2.11.0
