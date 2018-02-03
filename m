Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682042-2-14134910392595008429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682041; b=cFI8doHZAGutD4l3dP+KnQ6H5wbWDpsZunB/ieOZzoykqIA
    SzXmizCeyLnzYO34qMFLAPyx8Miz23Ee4hrG8Um9YOrhhyxlGyVHxsP4EWe5qho2
    QG2xKrY6XKecF+HPKnumR4BFn0BsezH90INZrv1OF8Jtu376mI6PlSINODfDYGEr
    twEIR899IsIcBhOWRev7fKnSTBKMmI0ahDT4txWiWu5j0dvNDseCI+CsHJAGKqWZ
    rP+9oMrUVJuRFrcRCLMe0hfICvfqmBosSsImjweXh5hVO2faBPmqDHGTefezb4wR
    ed+GOwdaNfKP97kXVUXdsrOnMLiRovhwtsklkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682041; bh=1c6dBO
    S9xSqEtHDQkmPwXY22ICOvpGYumAI0+Fk3F1w=; b=LXjOgs3XtSWBKHK/Y2PU5b
    +yYGHv/6OO/os+yQ21qPOMR6miGS5jUkRVl9iPGaqIhWNwyWXBaBZfEtptz+2Ph+
    GlOBS0IhZGDOo1UFi00qQR7+/B0Ut4xjWo3nAQwgSBH0SIZ0nD5T86XgqhRh4YLe
    949w3kitAKKoq7ErTCvI+ih7ndW13NScQ9I+/Rq8uHh+3P14ATEd48yujmTK4sgg
    jFpVYV8w2+3Zdy1grW/aJmfcDDzR/z0ySrQbP33unAt+3mmBQJPdK4iCLWNLL913
    0uXGQrXL/OXPTIfUVIxKDC91uD5iQqdv1lPwjbe+Xjz6eZcJcRGdNpHhi2cVvXZg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TaixLjBg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TaixLjBg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeBCSUg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:36 -0500
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:45078
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753474AbeBCSGk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Kochetkov <al.kochet@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 08/32] net: arc_emac: fix arc_emac_rx() error
 paths
Thread-Topic: [PATCH AUTOSEL for 4.4 08/32] net: arc_emac: fix arc_emac_rx()
 error paths
Thread-Index: AQHTnRluHNTH8UkmjUi9qQJipryIwg==
Date: Sat, 3 Feb 2018 18:04:28 +0000
Message-ID: <20180203180413.7438-8-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:ELg6G8rHkx/bPmHCqKLaKJuE8549J4WT70q25olR+0nYpvlNV3/dmdT9SzVZZ/grKeECHOl8sLRearTMRUh4MmU3DPDj3+UsQt2Blxki8pmi+ZE1XwxOdgZHff2jYkY3ADiKEATin+KlroH87/eSbhaOUNpXDim1ONcywxxYb8H8fEyCmMg/p9micHoixTPLPKFoIBKMLeggUCkYxeukHUFNWgR90op2NOy8PAQ3WKyPvG91+Ve+JQlktyrliumE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 685f3093-54fb-448a-85bd-08d56b30a726
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB10897EDAFAEEEF1ED132A217FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(39060400002)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: GVORDehjNoT6SCNUsUh2nT7X0dJIb8d9I/QywmZZlMsVqxmbT6x3T2UUzfzyQUsb6phtiJuHc0bzRh6+vYQjfA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f3093-54fb-448a-85bd-08d56b30a726
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:28.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Kochetkov <al.kochet@gmail.com>

[ Upstream commit e688822d035b494071ecbadcccbd6f3325fb0f59 ]

arc_emac_rx() has some issues found by code review.

In case netdev_alloc_skb_ip_align() or dma_map_single() failure
rx fifo entry will not be returned to EMAC.

In case dma_map_single() failure previously allocated skb became
lost to driver. At the same time address of newly allocated skb
will not be provided to EMAC.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/arc/emac_main.c | 53 +++++++++++++++++++++-----------=
----
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/ar=
c/emac_main.c
index abe1eabc0171..9cc5daed13ed 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -250,39 +250,48 @@ static int arc_emac_rx(struct net_device *ndev, int b=
udget)
 			continue;
 		}
=20
-		pktlen =3D info & LEN_MASK;
-		stats->rx_packets++;
-		stats->rx_bytes +=3D pktlen;
-		skb =3D rx_buff->skb;
-		skb_put(skb, pktlen);
-		skb->dev =3D ndev;
-		skb->protocol =3D eth_type_trans(skb, ndev);
-
-		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
-				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);
-
-		/* Prepare the BD for next cycle */
-		rx_buff->skb =3D netdev_alloc_skb_ip_align(ndev,
-							 EMAC_BUFFER_SIZE);
-		if (unlikely(!rx_buff->skb)) {
+		/* Prepare the BD for next cycle. netif_receive_skb()
+		 * only if new skb was allocated and mapped to avoid holes
+		 * in the RX fifo.
+		 */
+		skb =3D netdev_alloc_skb_ip_align(ndev, EMAC_BUFFER_SIZE);
+		if (unlikely(!skb)) {
+			if (net_ratelimit())
+				netdev_err(ndev, "cannot allocate skb\n");
+			/* Return ownership to EMAC */
+			rxbd->info =3D cpu_to_le32(FOR_EMAC | EMAC_BUFFER_SIZE);
 			stats->rx_errors++;
-			/* Because receive_skb is below, increment rx_dropped */
 			stats->rx_dropped++;
 			continue;
 		}
=20
-		/* receive_skb only if new skb was allocated to avoid holes */
-		netif_receive_skb(skb);
-
-		addr =3D dma_map_single(&ndev->dev, (void *)rx_buff->skb->data,
+		addr =3D dma_map_single(&ndev->dev, (void *)skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
 		if (dma_mapping_error(&ndev->dev, addr)) {
 			if (net_ratelimit())
-				netdev_err(ndev, "cannot dma map\n");
-			dev_kfree_skb(rx_buff->skb);
+				netdev_err(ndev, "cannot map dma buffer\n");
+			dev_kfree_skb(skb);
+			/* Return ownership to EMAC */
+			rxbd->info =3D cpu_to_le32(FOR_EMAC | EMAC_BUFFER_SIZE);
 			stats->rx_errors++;
+			stats->rx_dropped++;
 			continue;
 		}
+
+		/* unmap previosly mapped skb */
+		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
+				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);
+
+		pktlen =3D info & LEN_MASK;
+		stats->rx_packets++;
+		stats->rx_bytes +=3D pktlen;
+		skb_put(rx_buff->skb, pktlen);
+		rx_buff->skb->dev =3D ndev;
+		rx_buff->skb->protocol =3D eth_type_trans(rx_buff->skb, ndev);
+
+		netif_receive_skb(rx_buff->skb);
+
+		rx_buff->skb =3D skb;
 		dma_unmap_addr_set(rx_buff, addr, addr);
 		dma_unmap_len_set(rx_buff, len, EMAC_BUFFER_SIZE);
=20
--=20
2.11.0
