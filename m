Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497842-2-6241323203242392055
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497842; b=uYY7XJJEfbk8YEHMOT5LPAD4uEzAhe5Ch5qNLG2LujTqwaS
    kPv+AdBkeyTdfJPLh1rIIips9yq1Dg8xNseQaFJrtN/FqlS1xDugaK1xmGkPEJnS
    /cRcDM/P/uFCQHyl0lIscG7c/B0Y7vU9wvgP/xKxEq66uqIpFlSRVoIQ5jvU1/ql
    e9v88ZtJTzEq+NKGU6XbaqbGBH6r7oJ7j5xUY1VtoO+E4/qeYCDENcn2gL1EjwgK
    DBX0Si29T2VWH1uIanfr+7m5sEh34w/MccQZ3SRhJXW/siRB5Ue7l8jg6HpZX6R/
    bwyh/xSvv4bp6l2awaznhIHMUBy9i6SuE97b9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497842; bh=/qqzdc
    15InV0ir0cUiMaqDrz8yNaQYO0RwHBeueyKrk=; b=fp1SgNhRr8PfgXkSV5x+Gm
    1eHQ9onX/F/l//HXpjdPUyVSdVXm/XJZLDJ+/LFrJMkAdzzITNca+n0SaASnrMyf
    4f1uYI6luiau6j0m9U3s575zYnzaiwCBJsc39I2kJc0S3t/FnsdixNXI18egsG34
    NV07IAKwGp48UA7qXe9ub9c7vCl1vKZ0mI6ke2PjeslDFPLZQVy6yerqvRXctUcs
    BjMEyWYvAZ2jInwVWhBYkVkyGX+Lj7YS6nYvqt4cXEA5LpnZV2IPQN1IAKki7dYz
    D/68DvBwyigbDrNXjpG4v/llpwEb1s0QgVnQIltQnQDxQfpP/6LOQjDQ7/LNALwQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l301xuag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeejgeenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l301xuag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeejgeenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934145AbeCSWRS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:17:18 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934011AbeCSPtt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 103/124] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Topic: [PATCH AUTOSEL for 4.15 103/124] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Index: AQHTv5nJ9Dlooindz0uT4c5u1C9gCA==
Date: Mon, 19 Mar 2018 15:48:55 +0000
Message-ID: <20180319154645.11350-103-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:lsdiU6l+qqCTpSzM089MuSt5fRhZV8fo2xGwhbHr8RqMeG9O6LQ4VHXfYUTgXZdAHYqqL74gd/44PeK1CdBUYK9rDZ+Ek3w72Qpsm5TKmmBnBBV4IASmTbmn9FBaks6rfjp7UF6KzLFkct5EUnI4AuWThTVTknt6VEvwH0Azqfgc9cYVTAc+yPQ9BA1Q7FxAQQu8nISgZluE9IM43n2ASvu+/wi1HJ3qNt5xS4nX7YGCLTB6HJSJO95/WK++akYD;20:qARogn/e0JFobsE2aIsmK1ZNWYt6BIlAPLZbmEEGf62rKTzFa6US2VCsYH4dzQpXLXCFfVbBrJXb5QKc7exd9xDn/e9lwPtte9a02em4yMTN0ARfb5trUjXBCsnZFc4058piF4IN4yUlHxp22RM+NiDcTkwVTnGdECf2c9zJ92Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc380848-9604-4c2b-e0d7-08d58db10881
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110978442B6DD667F0411771FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /uZzjjYHXUiVXO560h6u4OEz4vm+54C8Ac+7+iEdpds1vMS1p3+ZujjaqvYcqt5511YKWEZVJG3J9ZLP9f4RAu+GeJJd3R86Ct3EnNFzSrHK7a9ohPjlE57WhkeKf7kIebQEYKyeynzRKPFdvFuiRQm9ZjNYc/S0Ps5AMwXcyyzq0UTylQIZMzOLMgqGBEHi7kyzfU5OnLKWzcrLRjTcPQN25eiyrdLNrsd4MWekvq3qFuO4XOH7q+AWRjyEwon9P8HC6QecYJxU2wgKs4i8tSkgevN1cNRUnQNfLgbBlMSXVt2fkz5YULGAzOBVp4k+tX2Y9q3wQEIti8B3W/Mg8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc380848-9604-4c2b-e0d7-08d58db10881
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:55.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit ea0a42109aee7b92e631c4eb3f2219fadf58acdd ]

We'd come in with SGE_FL_BUFFER_SIZE[0] and [1] both equal to 64KB and
the extant logic would flag that as an error. This was already fixed in
cxgb4 driver with "92ddcc7 cxgb4: Fix some small bugs in
t4_sge_init_soft() when our Page Size is 64KB".

Original Work by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ether=
net/chelsio/cxgb4vf/sge.c
index 14d7e673c656..129b914a434c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2619,8 +2619,8 @@ void t4vf_sge_stop(struct adapter *adapter)
 int t4vf_sge_init(struct adapter *adapter)
 {
 	struct sge_params *sge_params =3D &adapter->params.sge;
-	u32 fl0 =3D sge_params->sge_fl_buffer_size[0];
-	u32 fl1 =3D sge_params->sge_fl_buffer_size[1];
+	u32 fl_small_pg =3D sge_params->sge_fl_buffer_size[0];
+	u32 fl_large_pg =3D sge_params->sge_fl_buffer_size[1];
 	struct sge *s =3D &adapter->sge;
=20
 	/*
@@ -2628,9 +2628,20 @@ int t4vf_sge_init(struct adapter *adapter)
 	 * the Physical Function Driver.  Ideally we should be able to deal
 	 * with _any_ configuration.  Practice is different ...
 	 */
-	if (fl0 !=3D PAGE_SIZE || (fl1 !=3D 0 && fl1 <=3D fl0)) {
+
+	/* We only bother using the Large Page logic if the Large Page Buffer
+	 * is larger than our Page Size Buffer.
+	 */
+	if (fl_large_pg <=3D fl_small_pg)
+		fl_large_pg =3D 0;
+
+	/* The Page Size Buffer must be exactly equal to our Page Size and the
+	 * Large Page Size Buffer should be 0 (per above) or a power of 2.
+	 */
+	if (fl_small_pg !=3D PAGE_SIZE ||
+	    (fl_large_pg & (fl_large_pg - 1)) !=3D 0) {
 		dev_err(adapter->pdev_dev, "bad SGE FL buffer sizes [%d, %d]\n",
-			fl0, fl1);
+			fl_small_pg, fl_large_pg);
 		return -EINVAL;
 	}
 	if ((sge_params->sge_control & RXPKTCPLMODE_F) !=3D
@@ -2642,8 +2653,8 @@ int t4vf_sge_init(struct adapter *adapter)
 	/*
 	 * Now translate the adapter parameters into our internal forms.
 	 */
-	if (fl1)
-		s->fl_pg_order =3D ilog2(fl1) - PAGE_SHIFT;
+	if (fl_large_pg)
+		s->fl_pg_order =3D ilog2(fl_large_pg) - PAGE_SHIFT;
 	s->stat_len =3D ((sge_params->sge_control & EGRSTATUSPAGESIZE_F)
 			? 128 : 64);
 	s->pktshift =3D PKTSHIFT_G(sge_params->sge_control);
--=20
2.14.1
