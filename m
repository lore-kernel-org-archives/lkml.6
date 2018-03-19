Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478314-2-1720634036475684292
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
    t=1521478313; b=CxsHSjHS6/DRFpgOQe7y/fIp7wGy8RLmmtSf7nlYWNbLiLi
    LTHwJxuh0zKUlp1dXYkWdRn6iTQGATspEMyw9WqZvYRB1LLpFK4xPqbe2Y94vs5W
    gg4CcvFJvfPtBK1CnW/ap/qsBtQIgBuGdnsuajCbyf6AJS4Cky+MqgOeKiTMq5Hq
    cAKDeHvnKYIu4KEc2ztYO0JaZHUTkUjjq0TvpCa6s6YHx5499m4yeDMUYpHUDP4I
    K7hpx3hS9BCZ7cyW4EYgWJcoA+AX2rCPFJQWdgjZm7M+Nejku8P0JVnail0gCwJc
    e2QrM2H1G2F1PEPIhS3ZWKlouMebmi6b1sZUvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478313; bh=9zE1Is
    zevH1PPhu11zxmUW59rtPNzkTIVWbLkT7uFZ4=; b=OJXM7THhfpgaNYSVHZmR+D
    ovEamIJlV7PqWdeFmR4rcvqnfEDOW97Ia08UVirDTmzaraSqj/9MPxjlJgTY/oOe
    +Omy/uF1Y0F7vgU/IlrRNydzQyl3G5iHrwKQIucuAvARw1lq7C5AwPjql4f6U90/
    2ib/RfhkcEwRMKP1LgxJTP7m1DK3b+pPDa39/B57AdzlwZkHtKm57C2xYqjYsDJo
    1QJ7OJtnA2wKeoo2ONTpODKubIIZWiswNrEN21eSSf9hfsamlYNAWLU8Ht8ys4eS
    84+VDdBf0S9xvuu2gy5NYLPsrw3y8ldNH5iFzAEuiCh8TWGNntaB948uzhj91kjw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U660X+t8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtddtnecuvehluhhsthgvrhfuihiivgepvddu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U660X+t8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtddtnecuvehluhhsthgvrhfuihiivgepvddu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966796AbeCSQvL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:51:11 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:3838
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935147AbeCSQLt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Grygorii Strashko <grygorii.strashko@ti.com>,
        Schuyler Patton <spatton@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 007/102] net: ethernet: ti: cpsw: adjust cpsw
 fifos depth for fullduplex flow control
Thread-Topic: [PATCH AUTOSEL for 3.18 007/102] net: ethernet: ti: cpsw: adjust
 cpsw fifos depth for fullduplex flow control
Thread-Index: AQHTv5zynY/wpO2xUk+YX2SpRABV9g==
Date: Mon, 19 Mar 2018 16:11:32 +0000
Message-ID: <20180319161117.17833-7-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:2ENpBWAyN+yJbIV3PGjfKF85Oh45cqT8bQYwlJe3FQMmLiqyHuRs9NV3FB4bfAMjuN+x+LqDAcVMf4H0mknZvYFwpVXa+sAWDQSkblhjYGja1WXniMz0sfjOxh2mR1uhU+SLjT4XtBMC1Y+GI3OZTSJRTPsQgDtlq9m2/l1aQOslksxfcUy9ATGyOJ/da8zB5QJ0fk/r7yQTOUESBg21GXm588K1FE1kAWYNku0qYxpZO1c5WAKOzkO3fOOH+xJh;20:YgqE4eWWhhzFW5OkVAru8PAHBnApvXWxaffy9nNiSWPsuN9B0C7lnmUw+WzIc303sJNMPMqbjLexIFEwFCf4ufoPyIlHHpJzHKtkjuTqlptWnpTSc7P3Nq2SyuyDxdwAzluNIgRsK+SIUvGSiTiAF9MRemmwOjuNB3VaRWxA2Uk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc60d9e0-1a08-4aba-ea27-08d58db41501
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08052873997A4EF94F7EC0F3FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1Usds2j5gaS5x3vhLySvNd87Hg9BETmg3lg+cw1Ikl2rVNsCHwAUrfQ3EH3YtThT3tQ7oji6Gc2NGb6QQTUkYXIIgqqJpMsw93EwLb+nOFKMXQyyEmUZOBs7rM1GP3qKbHEJhDcxuPi7ULM+Yu8OY2i7AoEnuGFeuKGRa61630th0+BSbisU1HdCaNJRi3z3cwqLcLMHxyNW0RkarpIGlwSiKTQYiPS31m6pWSgN8DuRBaNW6XOqNLtfTRwO2ArlBvtPWpUZF1PoLRTAqUgHeMUNx0h649jbBc54m/bivFpPh6cGZGz8VHN6UiiapQpUMVJXS+oQG6Qa4IerFARn+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60d9e0-1a08-4aba-ea27-08d58db41501
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:32.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 48645504106e..7503451a94f2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -293,6 +293,10 @@ struct cpsw_ss_regs {
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
@@ -1120,11 +1124,23 @@ static void cpsw_slave_open(struct cpsw_slave *slav=
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
