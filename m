Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480617-2-14161149168458950147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480616; b=YrhffvhYAGSaDhd9X2SUhHmyU6VkV12lKIV4HzK0sZIS1YI
    XiucOATrbJc4gVFFNMmW0RcKxemPwTs9TPHJIRrMJb0ISDUVjXRSOFNPpQQoW45Y
    m3WTilfwsqpdArJq/sx7j7l7+UjZnCfOg1rxfZP0Qjz4VCeCF98VNF7G4TDh+vls
    oCYRiQaJokxd5vnz4xol3wjX+1Cnx6wRxZPu0j6oS3htqg3hUr+q6MHxGB5Cy+jt
    v3gMxKhdZfXzIBF3LjyOcVU7G9ENkCl4UK4H25UExIvawhU+QIQCjQoaKYfCF2C8
    V6TcESWStcMctZRuLIi4GfnjSf1nRqWJQChOYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480616; bh=DYb/0B
    Mou6xxIFeUB4QvtjFiNnRFl+6GxVYaqo6itsA=; b=Dp9wTDAYzI+d9TjWXT3YMw
    4EdioQQdo+2ukFFr871cTAx2Cy2jOEUW/IxY9LTlNGTY9a2tfMLXReXIEplcrZ2w
    Dxqr50BCTdw+SP175GY34TxT3bKVeEJCXXUcK/aGhCkQ5Nb7X/1xC8XRVhkxYLPq
    BTl1ipZXHKA5fosGwlVs75nt+tg6yq+ZhdOGczqnSlWbsAozeKn1tlOcz60Pk9Oi
    2lFx3FmAwBUhEGwgaojBZfcuUU015xD+fZin1DRrSPN951K01tiBoDOiZaDds+ga
    rSRQqLaA9Y1lYuxUFcrHocpCZ5G3hTfL9Sc0Xc2jlzxgCbYOtjQEAUAIQt1SKOSA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KBCVNh+C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtleenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KBCVNh+C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtleenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966111AbeCSQHH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:07 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:31931
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966059AbeCSQGt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Grygorii Strashko <grygorii.strashko@ti.com>,
        Schuyler Patton <spatton@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 013/167] net: ethernet: ti: cpsw: adjust cpsw
 fifos depth for fullduplex flow control
Thread-Topic: [PATCH AUTOSEL for 4.4 013/167] net: ethernet: ti: cpsw: adjust
 cpsw fifos depth for fullduplex flow control
Thread-Index: AQHTv5wdAaJPhrWQFke9FciTk2eNow==
Date: Mon, 19 Mar 2018 16:05:36 +0000
Message-ID: <20180319160513.16384-13-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:FuyvZAkVsy5Xyweucb4JwK2X7UtyuMjlXHZ59jISuYXhxPuI/HhvZuj7DTQYO+xmlPWUCEFX+FQ29CAK6CnHAQ4XfPJuaqXWKHRYqeY2xWbnWYHaCLl4dLvohof6s624Gplk/FYDdUdUx6hNjP1JtcKcO7s2bu0An8G8f4rJAnATZug4hWbc5yGuJ6HlZ4OWYR9lRdzuThXuWp1sHeog5f81/e5mytY1BmTYtnXDlrnOmkebYrA7WPTKreMhVOAQ;20:8Df5nsmgXbzXdDEtvMVM3ssEV0ue8CNfQLNeFavN/XNf40m05HbeqscMssEwbB1A70dhOP8KSaWpY3KSUdwJwrlULPrHd14OYYgS9gPQe9fxO9LEwzlyJo+JTIFqvzHf/AatNVAgwvK6CqRxvbQAs8KOGf04Rj1bqQ83/9FXiZo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ca58f72-aab9-48b0-cd7a-08d58db369f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920E3BB6BCE2A9FF76A4324FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4JvDT1hf8M9fW2nyJjjwWSyGgJLIcWMhQVci8O4KhcHx0Yinj+CK7i7NePgQOcHk6iC6Fi+pjMs5LMfB0nJ97+sgeavXF2E7VQHoSYabiRRoWh7GKZdOJAml5TDPbT4w7yA9yDWr4WO+k0se0xbdIfPVTuUeUMMx6Pr/C74zU8WO9mgu6FldHDMiRGMvkVb0zihvtDMBdcc52n594aw7E9S1ZhT6PcMMLd/4J4Z4SrqL00GS2Dfier9Kr6v680QItyLokupdzV6rAl2wbHvtxTTRv/I84Ww8p47c9cNENgkg8xu0iUQSXnPrtbAI/nvGDMzV9e8ApYitU8ee22fnGA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca58f72-aab9-48b0-cd7a-08d58db369f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:36.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 48f5bccc60675f8426a6159935e8636a1fd89f56 ]

When users set flow control using ethtool the bits are set properly in the
CPGMAC_SL MACCONTROL register, but the FIFO depth in the respective Port n
Maximum FIFO Blocks (Pn_MAX_BLKS) registers remains set to the minimum size
reset value. When receive flow control is enabled on a port, the port's
associated FIFO block allocation must be adjusted. The port RX allocation
must increase to accommodate the flow control runout. The TRM recommends
numbers of 5 or 6.

Hence, apply required Port FIFO configuration to
Pn_MAX_BLKS.Pn_TX_MAX_BLKS=3D0xF and Pn_MAX_BLKS.Pn_RX_MAX_BLKS=3D0x5 durin=
g
interface initialization.

Cc: Schuyler Patton <spatton@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ti/cpsw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.=
c
index fc958067d10a..6bf3f82e8a4a 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -280,6 +280,10 @@ struct cpsw_ss_regs {
 /* Bit definitions for the CPSW1_TS_SEQ_LTYPE register */
 #define CPSW_V1_SEQ_ID_OFS_SHIFT	16
=20
+#define CPSW_MAX_BLKS_TX		15
+#define CPSW_MAX_BLKS_TX_SHIFT		4
+#define CPSW_MAX_BLKS_RX		5
+
 struct cpsw_host_regs {
 	u32	max_blks;
 	u32	blk_cnt;
@@ -1126,11 +1130,23 @@ static void cpsw_slave_open(struct cpsw_slave *slav=
e, struct cpsw_priv *priv)
 	switch (priv->version) {
 	case CPSW_VERSION_1:
 		slave_write(slave, TX_PRIORITY_MAPPING, CPSW1_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW1_MAX_BLKS);
 		break;
 	case CPSW_VERSION_2:
 	case CPSW_VERSION_3:
 	case CPSW_VERSION_4:
 		slave_write(slave, TX_PRIORITY_MAPPING, CPSW2_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW2_MAX_BLKS);
 		break;
 	}
=20
--=20
2.14.1
