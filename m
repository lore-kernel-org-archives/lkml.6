Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495876-2-3202552712754649114
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
    t=1521495876; b=poM+VWHGLY7osCpKi6goM2lUod4fRHNJ2mEPhtCuUKIyipo
    gM1ACtQXUrTxVkjNzFYSwVxesysUswkjhHBEnc07SBhRJMq2iAmsh+49WU0y9Qem
    +MykPzBDiQ99lJ1g283YhiyehSpqwGATkABki6RPEEZgurpkGp7J+kKRRmWS1CNg
    e2s6Sbhe+FT15mv7AYFso8boTj48n9foKbEo/td9h9basPATS3YNgDbi8DVmX1cL
    3U7/S/MEnhlJntxVSgKlmndy/FZSmJkSEX4oMn8ZLwmSGJcNE8ZyttMswpAd/Twp
    CTfFplddalvlH9lA95MVt2MHrfWDujZKLvH5GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495876; bh=TBZpOA
    AUAigNZ3E1rRX19wnMpIpV+3WJxDXxewVKDT4=; b=aKTKMsUkpgbDbp1HQsSY1i
    FuQa4amUsMMhKey3rVE0toN+4yx6HtkVgyi1fjvrJqBcqbJVcpbVRQ2bt7ieTjzF
    c/s2/47QNyqLL6ixG5pqX9HcuHvwcQZIXAEdC7PHVXPsioKLydz/XvkyMFtnNjtS
    Ty3JvwMYKhx1GyrHuWdjwvlyKk6fmboqOGE4dryreVeMq+6Jvpo3AiCOCviG5xKL
    za9uy9AeD2/Fk4Kk6zTC6c2grDcu1WNut6eq11R6rA1vh44VfEHTYxsuaToikvSe
    cwPOoFByRHddCzhOXfy6lDxXklWLkjnhdkTfwM0POQxZ713zmc1h2cJ7jCRpMtZw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D5V1RHDQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdehieenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D5V1RHDQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdehieenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934696AbeCSVod (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:44:33 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:28722
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964945AbeCSP62 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Wahren <stefan.wahren@i2se.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 030/281] net: qca_spi: Fix alignment issues in
 rx path
Thread-Topic: [PATCH AUTOSEL for 4.9 030/281] net: qca_spi: Fix alignment
 issues in rx path
Thread-Index: AQHTv5sd3EYMsi+jLE+FEB19kLmkzg==
Date: Mon, 19 Mar 2018 15:58:26 +0000
Message-ID: <20180319155742.13731-30-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:hNQC/zPdw+idIZqHpFIt47dRmNwOwLCYCVnnqXxNB8qwCuXJC+mWsKkfGgxxK/oYQ/hbpRrkkO8joiqFKA4SRIywLbwtK2Jn4kQ2rCBCP1iTrEWkK4Ry20ohWr25PY9N5Q2Utnab3LndVunjNz451t0Fs4SR5GYh0hA+MV7nGs/j1/1SGyFGuDXgjDbWYD1aTQRtjkIatqiY9nCbS28OBxee6AyBg9Wm0oXR0ZwUYthOXKnhqLZt68bupYB+23aQ;20:EuRg7Obp3aycTQFocKrUNcZvOlPJfOi07t13jW0NAJJ7zbAh3/gPifGQ4yuA6LXG+XC8VKLRCqMHmqOdNNvVkfwiKNYQKHc/slkOME7cIXoh1w591gUtQhiFbZAgeBjhl+H3IlG3PZz8qArZ0A2i9fpvKY18OjDJ7y3U4XkhmfY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d69e65d-48ec-4e0a-b5c4-08d58db24045
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10152106CACCEC915F557169FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: G1Og3qtJsfHo6js7XGIJX+Vv2KbFMjTnH6lVUcM2LZy3LuIygEjordSBeEm8N51uvo+EqWL2P0XW9j0zldHG469cTn1DUjg0jyx+AC9aPxGSTtqNwEBhkoYVH3fmY3X0740gMiOqKQ5WIRRFuh5P7KKgvRhaIgK1qp9yknkJGOeC6K7PAc04+OF1rlyUFRCImpy9TqiQgKwoVo9roZViQDA8CIEboJL7uzS7wNMa/rrpI9+tDMq4If34nX0J4oRNatwYHNPhxJTxBCfGZtwixVaZYWj1Fh3iUHN7/RWsiVaF6+n2xnDyBAKmPejgGEcA1vOBPrOJesE4OcdhZimp7A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d69e65d-48ec-4e0a-b5c4-08d58db24045
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:26.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 6e2add979471..8bbb55f31909 100644
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
