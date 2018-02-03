Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683556-2-6679061633458425284
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
    t=1517683556; b=qLyOpjTGpyRfDgELxSDZuknB40m4fcborXFzEZOsI2XIfe5
    Mm/Ppk718lSqGBAH7VNTCnktt5ZFnVDRC/3tDF/1oV4hVnZzriBUFZjHG1LcQt1Q
    yrZozTE0RtwBSGIVwF9ZO4Fxv+zExnT97h3ZpRCaMyfvcOFyQKPAaDl0RHCT9Mzi
    RCmu3IGsB4slWLT+tqB7p6gLJznBgx5m0X4YDnyoxd1J0SgS+f2kqYSRLpzaI7iC
    yp21e6T9IcuQ1xofs5Nc4ZjeFNk9KFV+PmCX3/jt5Ucc6h7UKfabKJNfEBagKNeH
    fKu7Y4NfOI7Jn8Sld268FaY2Xj+aNSFlZOhbiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683556; bh=OGhXWp
    0iSTUCvgw8RbdrTNIwYFbeEv+dTn8w1T9iE/M=; b=WiR6u9sLen6TchD3x+rPSv
    K08RaBEu8iarHCOh2LVi6t56JxeMGepunbiIH9sqPdA2/4hT+nceOJ3qjkwzWBJP
    Yi1rNIOfCIsl15V36tz32zjaM650vYRbWlZhRtS3iyXSxlf4vA+JZMfly96YfyXi
    P2FtJ4fmTVMAaOzol10k0ftup/d8FXqL1VzKbeZDkGHnkx6ZZbFB7YnJ+qnqfLXq
    /4JgU9a8aaK5MMXVy+AGGWQDrI05lVzXhkN5CW2g0ip5c5THAQOW2wqZyqBeS3gz
    S6lfxudABTYlS/zYcB/NLPHa4nCst2/XRSsiNiDKmQ/CkzVFS3gO2V2x2bK5q+Vw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g3Oh75LZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g3Oh75LZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeBCSpt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:49 -0500
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:41422
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753093AbeBCSCY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 033/110] net: mediatek: setup proper state
 for disabled GMAC on the default
Thread-Topic: [PATCH AUTOSEL for 4.14 033/110] net: mediatek: setup proper
 state for disabled GMAC on the default
Thread-Index: AQHTnRjpnBkLAVw2306SiS0OUxCPuw==
Date: Sat, 3 Feb 2018 18:00:44 +0000
Message-ID: <20180203180015.29073-33-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:1zfZetemha3S3wx/8yEyEJBki0X1x5lNKoACzZk8eqiZeGNezbeOppCzK77QTt4ujdP10JLQapEQxjRHuA8e5Pauwrp0s0w/isJrTqaymhevs+XY7mdUvpWZpVxujk6o9MNNT2B2ptCukI6r5XcLftvzn1RhlGue69PatDBMyeujol5mBfvfIbi63M+hIoG2Vpm3SWstSaXwqu3/t3xt/VSSozE6aEW1ELNPmgmfibs/bn04dZKhOY6/gV/cQj+R
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8476f540-4298-4081-0a93-08d56b301f75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090FAB5F66B53B844378D2EFBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: EfvSszZPbXi2W93xzVHkYdX76FFFs3keNj1dbNdS0dzRLPKmBkhG5bD173Gx+TXKUMambqbkA0G6gHMvQhBhuw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8476f540-4298-4081-0a93-08d56b301f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:44.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
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
index 5e81a7263654..3fd71cf5cd60 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1959,11 +1959,12 @@ static int mtk_hw_init(struct mtk_eth *eth)
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
 	/* Indicates CDM to parse the MTK special tag from CPU
 	 * which also is working out for untag packets.
--=20
2.11.0
