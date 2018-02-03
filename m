Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682005-2-9904318367254707813
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
    t=1517682004; b=TzJ6H5dt2uIxkflax4AJ6N4on6Y2mjcbfgmGB+TOywANdnV
    Q/1z1/O0AEAxhdFn9+1McIEr+VCk67xr1CFL1hNEVF8guo06EYA6b/MT7NMqZjHn
    QPjYTiSarFlUEH4JvXGnq7mdSWldasgJ0i1PVrrC4kyQ6LeHpu1E4dBExf+4P+sD
    Mf3mIXEkQ4VRicPp1tI9YVxAG7uHIzME8FLlcl+WxzUTsx4ABjqgRmsvZZwWNpw/
    kqPZ7NqeSRp+h80m8ud6DivgAPNnbryggDo1PptjDUk5/GitjtNJpvqemTWw7hZI
    +ovPPiIogrUBfDGllr5Nw0e1m2Da575z/Qad3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682004; bh=1c6dBO
    S9xSqEtHDQkmPwXY22ICOvpGYumAI0+Fk3F1w=; b=kPrsU6VVLLxTU0PsE9l3SF
    go7JzRnQj+f+47WdldTdPdeKpc8tC+caMu631c8L+MyRgGHVzZWd8lM8kDJgOY6I
    LYQYSX2ruyzmoEXLta0f+YltL7llYuzCr0dP4x1MeqUZtUd01AWaI6x+RIgRq0z1
    Y+o6YuIBfsqjhiNnK7WGsYt9tDcec0BvEEkFfi4UyIv0y5PrtuGxs6fsQZHAY8TR
    Bk390hf+oXNPkFSiMKNqrAZ9+ek7g9z2fmi51mRukzBC+BId51GN/bMnPHKUYCPQ
    Lc/28CIScAvXg7DwvIy7OsIdJ83xGvYLgAGKsw9INBVfZD4ZWnera6AwJ2Wl1YRQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O5zsNDqc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O5zsNDqc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753985AbeBCST4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:19:56 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:12511
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752716AbeBCSGr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Kochetkov <al.kochet@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 06/24] net: arc_emac: fix arc_emac_rx() error
 paths
Thread-Topic: [PATCH AUTOSEL for 3.18 06/24] net: arc_emac: fix arc_emac_rx()
 error paths
Thread-Index: AQHTnRmCuVL4B62sBUqnzJGqyHCWCA==
Date: Sat, 3 Feb 2018 18:05:00 +0000
Message-ID: <20180203180444.10801-6-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:oGTjv/9ElGzGgl3V1cI5E0fQbat6ic1tF0tC9qQnDVAalrwq7Lz2Q+acpMowmrzA9MjAVgnsVWEOIFBviJPM0fQkVcH6Z37+YKuCT2Vo/i9T9vAgTXIAiLszFYme92qe4G/qj44GpYLtUSlcgT3+EnHC84Mhsv5X0n17bwRCayTgRuQi+j1GW2/JpE9pAzgq57fwamhw6mAoFt2tXmfrXBwQ/QXJq1+RR0cw6WMRxAhS1sffPGMsb7b3fmAHVXKi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23ee706a-a5b9-4af2-3908-08d56b30cbd8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993703A5FDC906256787594FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Y0MIXjOtCJCk6gfQMOLlXOXhhTetBTYmtfppvVMGETyKr+jdmDk6aSbtuXN3wo49K6QVPJE1zP8MerOnGB7rvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee706a-a5b9-4af2-3908-08d56b30cbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:00.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
