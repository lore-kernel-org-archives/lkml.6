Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521480761-2-2254265167383539214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480760; b=CeFoAAORsnAAcUBwE6snp5/xQuyY3jIajB30XLeJ2+9PKzQ
    zQiOUyAEz30okur7VSX6oy11/uWGVQEUTIF31XfIw7ZLI5EH4Lc2CjxK13CicH4Q
    pd1Gie4n+XMcZE4Lb0BjkOeO7OEDX/+k0rQ+Uqj5WVfc5XWWYCC3xAxX7WA9KOK4
    tMv0A3eRzxjnopU2+EovJkqeZO7chg2iuzBf64WHgMnip1bOqCH0lT3rLPRrzt9Q
    TvATjm04f5sPM/2PmTM/dN/zNBVENWIsUHoSaTi2SBu4fJWvP0QjrJ8r1fog8BIR
    ak91e2apa8fEbYgBiLyDO1QR0puAidQ+Csvg+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480760; bh=rjNK28
    W3i2hLenFKkoIkdqK3mnMP6TYIA1nDDGHBt9I=; b=SVdASBbnXLkurDzmg2x/TW
    MuLON+OCphv+wlAebhaoeXd/UscWya4EoJTH+rLbgZzFVnlEGHnPa2be0LbL9400
    LQ367DLwOiKSzqosRVgZrz2ElzXGt6RYSwRyyrqom20PoJtCDZdVPzsos71qzbgy
    YsUfxXjF6NqVoMeFvC/80n/SKBG0Vt9pS/xSxI4Cq3IyEAEvLMHlqP3FlovSvECi
    QK8TTY4iY65rP2vQhKFR9Jej6COMU5ZXhZs5nSqqMi/vzUhSPyIj7Zlksl2kotq2
    AvL8poo9H8kKxxijCz1bmzFVRdcEdpgP90Sc9yE6Xf1vZ7VrIH44tzLM8xnU4Mwg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mis4l9vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdeileenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mis4l9vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdeileenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeCSRcU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:32:20 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966025AbeCSQG6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Wahren <stefan.wahren@i2se.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 022/167] net: qca_spi: Fix alignment issues in
 rx path
Thread-Topic: [PATCH AUTOSEL for 4.4 022/167] net: qca_spi: Fix alignment
 issues in rx path
Thread-Index: AQHTv5wlx+eAelyjQESK3ud5b26isA==
Date: Mon, 19 Mar 2018 16:05:48 +0000
Message-ID: <20180319160513.16384-22-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:hx4uaTgJgOB7VIEi/DhcuX+BPQZMrokyYJax45sjOJJw7qRxhC0zY0KPuEKtiBe/kn1UyjceHz0r1VX4yyTo4WfRXyMR2Hqbjlxo4S+Dsd5cSAdPlq43OBU8o0DZbNZsf2yHHdyyrOB9AT7y9Pa+9a6NVhhmo264h5MS7zZU82UZ1Dy7z/38ULsqewqRVaeXRp7lmOO6Yn+GFECpuae840eKvARZruVcmEyizi9aCBxE/F/tYS5diy0kCP21zxNL;20:VJw3JzlWgZmZDqiuUIleH2HCJnM7Mat7tbwPtgL2Trg1nCJEw7yCGT2dNEC5ADAM6NGqsLsRZrDOr87Cx1YkE+pAh/MHAF0ZcaRLfFYWU+KBrYRoaCBzJUHqVMgphTxkRF+R9bXIRAUnOcw56x9gdtyUgbvzTtVO8+xz6PQCyk0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10e00f81-5c5d-4c4d-33eb-08d58db36d38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093D53A4A9B13B3D3518955FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YA4axyG0yqmfIkvP8H+OTbxEGrFTTPXxxk5FRAMFMExAdCj5IYYl/EVqQmNRsfQoInRT7kQ9qZVvQtl3adzULEyWcpYOqG4wMrhs1gu/OoLAnU8PipC1I/xo9A27w+WSMNGBJNxqIp0lxbslnB5fYXnTJJ1carDrvrX4k5/vSuJytaScy49rKFFN4RFsBe2LRfZiksdgy1Wm8ERwae8/PpBuhnHetv4qLy18PsbxSDke4xXTal9FtqRlg3nviHSvLPl0WK5GwtawehHSqc7c6Ag7KKJlCDnjP3ci2BcrsnSkXdC8BzixUtcuoPZAKteloKh2FGUzKgYHTeenJa/cXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e00f81-5c5d-4c4d-33eb-08d58db36d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:48.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 8d66c30b12ed3cb533696dea8b9a9eadd5da426a ]

The qca_spi driver causes alignment issues on ARM devices.
So fix this by using netdev_alloc_skb_ip_align().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA70=
00")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet=
/qualcomm/qca_spi.c
index 1ef03939d25f..c90ae4d4be7d 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -296,8 +296,9 @@ qcaspi_receive(struct qcaspi *qca)
=20
 	/* Allocate rx SKB if we don't have one available. */
 	if (!qca->rx_skb) {
-		qca->rx_skb =3D netdev_alloc_skb(net_dev,
-					       net_dev->mtu + VLAN_ETH_HLEN);
+		qca->rx_skb =3D netdev_alloc_skb_ip_align(net_dev,
+							net_dev->mtu +
+							VLAN_ETH_HLEN);
 		if (!qca->rx_skb) {
 			netdev_dbg(net_dev, "out of RX resources\n");
 			qca->stats.out_of_mem++;
@@ -377,7 +378,7 @@ qcaspi_receive(struct qcaspi *qca)
 					qca->rx_skb, qca->rx_skb->dev);
 				qca->rx_skb->ip_summed =3D CHECKSUM_UNNECESSARY;
 				netif_rx_ni(qca->rx_skb);
-				qca->rx_skb =3D netdev_alloc_skb(net_dev,
+				qca->rx_skb =3D netdev_alloc_skb_ip_align(net_dev,
 					net_dev->mtu + VLAN_ETH_HLEN);
 				if (!qca->rx_skb) {
 					netdev_dbg(net_dev, "out of RX resources\n");
@@ -759,7 +760,8 @@ qcaspi_netdev_init(struct net_device *dev)
 	if (!qca->rx_buffer)
 		return -ENOBUFS;
=20
-	qca->rx_skb =3D netdev_alloc_skb(dev, qca->net_dev->mtu + VLAN_ETH_HLEN);
+	qca->rx_skb =3D netdev_alloc_skb_ip_align(dev, qca->net_dev->mtu +
+						VLAN_ETH_HLEN);
 	if (!qca->rx_skb) {
 		kfree(qca->rx_buffer);
 		netdev_info(qca->net_dev, "Failed to allocate RX sk_buff.\n");
--=20
2.14.1
