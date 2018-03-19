Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475030-2-10400244321289564348
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
    t=1521475029; b=OSvsWRllMKZ5MUuKTTqi/SJiLg43WjKfULHl3704UHK5DEA
    FsgivJEtSuvtvA16nyzfVrtC3wXc8lhYkHELobRlAAeVlq+2MQGXZ2LD6oXBTokE
    +wztHQULTSHWPHqtdl17HiIMp5alOFc1g4nSXo8lAcFIFz5D1HYBmliOVqngi++x
    y4MPLpycqQbm4KGQBvKKBofabe5VY2JBM17bdcF14twxgJvr6fStgn7YavyWllHP
    GaU7eP+wX8kcaMeoe5iLBNTU+AtwnuKslS0KUhDIKnIzlmRvRBg6NWe4c9cDJ8gq
    KRnZqdoOofmnuCw9tE2rfAOAC81BG8W5jfMe1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475029; bh=rA9fSX
    TkKf6dkYdQiZQn8OxyhGVCpZsBbtyCDG+uS8g=; b=MQGxyu1aT9vAODhX6SJ1sU
    LMObx0JDOQ6lgLdUYZnrBMv2cfP4+RMfEnwKJmOLjLM5okUzmYcqsJvvgbxY4muW
    kKb0ORyD/Ws/nvWOIPqA2IjhTcMDi2glMXMIu6U301/0hVOTG2EbXLomP8dx+l+r
    OrL0Uno0VKXBl+v77PpxjKXvfl73s7VpFh7cc6UN9ivdEP908IHBvw5N34pB1Zrv
    PYKElyQ6S/lJszc0NPVuMwvE65iegi34vVlcb4TO9SFdmewP+hYwm/OfB2/uXRN+
    P0TInczeATANfqgnsCCbzQreWqx2Vx/G9IOXZ3AKwjEwoJ2MnYDwSFwzYP82WTGA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y81oL8IR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekieelnecuvehluhhsthgvrhfuihiivgepiedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y81oL8IR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekieelnecuvehluhhsthgvrhfuihiivgepiedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934103AbeCSP5F (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:05 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934640AbeCSP4t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 77/97] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Topic: [PATCH AUTOSEL for 4.14 77/97] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Index: AQHTv5rOfPqsXyXcuk+X7RBjKjIhCQ==
Date: Mon, 19 Mar 2018 15:56:13 +0000
Message-ID: <20180319155411.12348-77-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:S4wve0jXwvP6gYhpqclnKWfVi2bwow3Rzes6d/00t2VC1gpDxy6pXa+3rr5NNYRDbDUIoQi60fpZkAAF96XD2+LQtAB36LwOf7GttDcMoN7/pVCFNxix4lzF9SAWvZtQeZAmt69xcV2rMr53VYHX+urADPSH7kNcTvgXIuV90XLrkHQPETlVEpcTfmlPA9md4XhBzC1S9MrTnCTxxs1HyiroY6VETOnpmt7rON+2QorGykfOryTxOvD/C49eAj1T;20:+BfuCPfqUY0FuaCto2ebfXMZwNusmjpxhHDY1ibN1BnBs7K2hAQ/xueOi+0IsoCMh/MNcUxTzU3oc7HNKAZKIT5oPIeHo2zsrZ3msqUdHZANGz4cZwKV85do3AUKpMiZ6bmhGqBSKwZgXM28EgZGdpRSedT5m1rKNat6pw8tkFU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01a5f5d2-cbaf-4ef0-e4a9-08d58db20018
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10314904A6AB93A47342018CFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C8En3NJukqTMGMy8wsuctQo1pdyxPv4OmqrkLGc+VLBk54cTyaVj68ec630biz/aOHie4nYslUKUCItmYq5xFtKyU7mDyUOI1974gUQILCegAPHVuvnT0D4/jH0H+yV7O1wAjVBJJoJeFpwV4ljXetp7BY8xX0Y1FN1I7pS7QGSYJq8DQl+fAytP+UqxVeaUCS0ErFY8coIT4U3A1q62Wqz3/9W2YfYNGkSKxH69QUSUssvDyFxID/zfkHG6EJudglnC6qEC+srzslix7IisFG3ptscmoZDIGP4sYcXK5MxqETqv9blluSCugSKoK6NRlnyYgyIbD2jreAB/AnILNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a5f5d2-cbaf-4ef0-e4a9-08d58db20018
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:13.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 05498e7f2840..6246003f9922 100644
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
