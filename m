Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496001-2-10123564615819018117
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
    t=1521496001; b=rkACYEyXUi6Ut8RmJctp3oA+dqVZfrZnGxcw53PFCB1N6kZ
    MbGiLo2hXEKfe9EWVcqP5oqLEXMy1yyN6IVS+a7DERGtfz/fgdZsCpiV2MINUpcf
    gz4V3gqRw7qsGTZWVD68eni7fCluDSCRogtB0F8roVvMt04Bw6OJhk1VRjph6s2N
    Rpd0UmOPc7Lnv0pNcyItxw6mTOgenQQ4Ba48R9TkriD8sRC7sOlKoWgmUJ9uwB/R
    OweR2WLUahVVQ7w6AVCmvbv8ml6Sx6HskTW7AXao98VGRfhvZYZx64WHuspoOWFN
    TOMPNhji8Wr+O04cJjZ+5w89PG63SXwE15uprKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496001; bh=R7tPuq
    AY1ojszNIjGDiqW9PSi2HPDmRJITz0TpAGLX0=; b=VciCT5SBZYBhu2jPaI7GUh
    KqzBTSvZXbXG0dIgg5yn9emCHwpTCbbveVyjoQE/YztlLFVj4bXztcxlOu8pFpwu
    mRaGh1Ledz+OAdwSMzKR/MCOC6NrDJqNay2TlNI7A5xSbU6OnnW6iDv5OSUyWV9/
    iR8e1Prkcm8evx73zjjBxGrWwJxeBPRWJgwl4Bcgnw/AIvVIUYnft8hamMXsfRDr
    l1FaPQogluCZpNTxX8Y7EVM2hWuIwFXInHrS1ig/H6fvHx5AdWMyvtj0VZq+KRdj
    xNaJ4GvEI/KZ607Qf/ZjzfFl7Rl8wJSxDXw4gODgRGcxu07efuLZP+E+gdDWy7iA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dKkFF3/e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgeelleenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dKkFF3/e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgeelleenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbeCSVqX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:46:23 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:16414
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934770AbeCSP6X (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Grygorii Strashko <grygorii.strashko@ti.com>,
        Schuyler Patton <spatton@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 019/281] net: ethernet: ti: cpsw: adjust cpsw
 fifos depth for fullduplex flow control
Thread-Topic: [PATCH AUTOSEL for 4.9 019/281] net: ethernet: ti: cpsw: adjust
 cpsw fifos depth for fullduplex flow control
Thread-Index: AQHTv5sVmv9LhqLWG023DqvVNpgN7w==
Date: Mon, 19 Mar 2018 15:58:12 +0000
Message-ID: <20180319155742.13731-19-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:frenJESuaRqi18TF9Y5zlpSyXXrXIMI3uCTY3yCz8r/FsPdcM8nF+B7VCffB96w8RIx2Bsobad7AUzsNewNZOPaHSruZzHg8f2HMuwhE1kEiEzBINtiekGH78/wv0f7B1fb2upCM+hlwipsZx6Atc0tIKpqyfPbGIqvpQh0YiAYRV2TjNZpWKjxH90rimpzis5PAqUDxION+1lhpFL9W75pzcAnx4wNHI91skDGg8VB0/30bYhKRifYuR0avO7G9;20:ooC+DH3hY4r81CaP0jLuUgjp4IltHX1jb4WEJ8BYIHPmnsmNGZ0rc9tvOQzao3crvyz7sjsUPTRi3F6dcCQ2ANxrWRu1G0VTHfY/qEsT9VxMU+uIylrQLnGRtuhdlN0VhOnpKzYNWZ3FJJRzg/jz9+2Fkyc+RT21Tucu3/pDZz8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2db9d252-5d2d-41df-16cd-08d58db237fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726EF4659EAFFC890F26A72FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JBBCQqTTs3ysf1kSOtRaSkf/QSrF49vKgf36t/gXnl1zTJXKCY3clYdJ6UmTED6BxeniAlVDtboP2rD/TdiqUCYHslusW+d+Z4rabtEUpHhPAvIdZXNwq/leZLbdgoWAGbVfHx0oWMayJcAAYtgmtLkoFFKJ/jTXxSBBoZgBoevmwcmXoInXjVQWrbWnDA6epRUAtYk7KZbR62N7t2TJ0E+2z103XUQcYCc/YSZepdtANxQmkBHSPaeX+uc2/dZ/dDIjvlYkTu1FqCaHRZimfCiXHSs6qbIAYdvmPDNMwymjGWaGTAr0+a1u+zmJPxS/ZAqM4mdECyOf0xbA8+ALFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db9d252-5d2d-41df-16cd-08d58db237fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:12.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index 3f1971d485f3..024191a3ce91 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -282,6 +282,10 @@ struct cpsw_ss_regs {
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
@@ -1159,11 +1163,23 @@ static void cpsw_slave_open(struct cpsw_slave *slav=
e, struct cpsw_priv *priv)
 	switch (cpsw->version) {
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
