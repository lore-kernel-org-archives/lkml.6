Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682492-2-8467155752780481902
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
    t=1517682491; b=GR1SEGyUPxyCwARELZjvPRmUUPaJNjXn2jz2n5lrYeM43sS
    MSMPXtseFpJuC8/4HgiZhSCUpj3J0z8tLHCBh3qgFb+Ov7sw0D/iyVSn0GfBj/ks
    +X/39qUUD28Fja2w9KVPIttj4DAQMMKQ48+oVtTLi6AW/l5aMJjH70aBw+q+zvKs
    4lT7ocHoAYdnjwLq1FNilZYGkVs1nvXJOkoXj/Ut+u0mo5OiqJ5EJUPtdng09Cre
    EXR3TwLZgpymFXdjiDeDusK3kIOgndIRiK8E7BJwnXDQag/4LOkOI8mQBBFKX5Hq
    MoryNvAHcUz1Y3NLa17f/QJzNdvqoqJyf/k4Deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682491; bh=6Tj59M
    mjuJx0N47hPAg3yPm8X9AobRG2NW5Hkjz5g+4=; b=GdDv07zx3KaZTJuXISaGKt
    4EuP9PvrNU604VCZrPmO+/8ChFKxLMIiWIug8V4Gq8YF8EbdhflDQxTRWbj7Dkvg
    fElhnb+SzgVdjClPw7IqjKljFvAbOxZh0JO6Thel8I76VwT7C7+pycXW4HVVDN4R
    IRUvXgSjHRhYMWqrJval9gh1k3JmlM/X644OgbiEEcyCFRffypUzAChjGzcaAH/b
    JtpME1k1jBwCbNtuxLHtf5L0HMxJ9QFzCGEsubLfYXYTStIvimykJ/jNMjCwYK0u
    vHWuHLK7Tg9vZCqVYggrtrKVIL+rE2GAnDj4mSHyDtTs686hId1C8xiZefLUGeUQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UnP3fKOF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UnP3fKOF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeBCS16 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:27:58 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:60480
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753331AbeBCSFC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 16/52] net: mediatek: setup proper state for
 disabled GMAC on the default
Thread-Topic: [PATCH AUTOSEL for 4.9 16/52] net: mediatek: setup proper state
 for disabled GMAC on the default
Thread-Index: AQHTnRlTFJJuQ7POrkyN0i+qUs5x4g==
Date: Sat, 3 Feb 2018 18:03:41 +0000
Message-ID: <20180203180303.8490-16-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:TIy59vc1rnUtBMyijyQt3Ksln5svl9qN1jTi02TNyUkm7+8cVC66Ss+DPx9nMdwQs0sdVQfJ0x4oKjHbGMaTM3fMA5E624kQQlVk1lGnDWKe3YdakbNJzy497CDVK79cC/0MpF566exXyQ+tyGB95dH74qwBb+keZ2PjSwrduOPKlSAzeXZYL8uGAQJBs9Rsgn7uE/NU5uiGFwf1RwxTjLyJQmPfbc4rD4ijMEYET49sbU0/YrL0qnIQay0+t7D8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6d9b14f-91fd-4dc5-6660-08d56b3075dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB109123852E7D366883EA081FFBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vA4vZeKKXg7uGW615u5gYVgSXrG1+D1Wr+9cnTvytyQVM9MnwWlCohV9ZK5cglBrYdfZJGT3mdjQdNFFIMZ6VA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9b14f-91fd-4dc5-6660-08d56b3075dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:41.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 7352e252b5bf40d59342494a70354a2d436fd0cd ]

The current solution would setup fixed and force link of 1Gbps to the both
GMAC on the default. However, The GMAC should always be put to link down
state when the GMAC is disabled on certain target boards. Otherwise,
the driver possibly receives unexpected data from the floating hardware
connection through the unused GMAC. Although the driver had been added
certain protection in RX path to get rid of such kind of unexpected data
sent to the upper stack.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 4832223f1500..20de37a414fe 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1842,11 +1842,12 @@ static int mtk_hw_init(struct mtk_eth *eth)
 	/* set GE2 TUNE */
 	regmap_write(eth->pctl, GPIO_BIAS_CTRL, 0x0);
=20
-	/* GE1, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(0));
-
-	/* GE2, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(1));
+	/* Set linkdown as the default for each GMAC. Its own MCR would be set
+	 * up with the more appropriate value when mtk_phy_link_adjust call is
+	 * being invoked.
+	 */
+	for (i =3D 0; i < MTK_MAC_COUNT; i++)
+		mtk_w32(eth, 0, MTK_MAC_MCR(i));
=20
 	/* Enable RX VLan Offloading */
 	mtk_w32(eth, 1, MTK_CDMP_EG_CTRL);
--=20
2.11.0
