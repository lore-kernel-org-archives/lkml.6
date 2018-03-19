Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481129-2-1757414432598040924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481128; b=a4dLVpgiYwKZ7lgVhDHrE7Yk8sW6XLh2M+oFNgz6oDztDsK
    vEXt6YBqTUpIQ7R2AZUe5hnuIpkbZUiXf+avz97YwpFqU5R4CMCJ3/E6pNCFS1xs
    FHo7PmVYAUtKC0bAqJ/YiIDjavPEhyE5zxvOnvDIxQHt7vtGUE1pBrxU8fVjjEWN
    ajuHF1LKr3mi8DtgskRjbwV6zeXiLj632y0eVYedlZpB5WecyLpqKF7zOO+xxY1c
    P+ruvnhTTgyzWydOnmBSZRqEyU8IlDpLTNJ0KMexHt/pYwklQbJxTYJRiLwOXVrz
    NXRMM7OmMPgVhKdr/VKQuygQN3osts3gN5TkuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481128; bh=u3HPgX
    Gt68+HzaBia+ODyxRFIFnEraXzYpXbYv73wuM=; b=urunH/787OVhtZinOSbfjo
    cvOl9mE3LFK116KrzOf9XBTKYCZXw6uip4z39JEIeT4abTAy24MiWmYctsQufc06
    WKbblNN5vhXwnrHDyT1WPrmetW6lrA1xrZCAgRUms8nw1P3mU5kpmnSJnliiiUow
    XxQBkPf5jRJ0CltjUsB7lNTlT0h9+mUL+lfoymMnbe6fmeb+HQRJUeGxIIexacxU
    rdQaFG+/rjLn3ut1Q1Th96TZf09B7dbPaa6ACctxQxNvOymyVaidx7O0Bs6+BRSM
    kfwsvMLq4divWw1kkUnvSyRLS9XoypL9Nqz5fRdDA/i3UA55I1xg3xx09oYchUHA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wth9zUB0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeejudenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wth9zUB0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeejudenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965967AbeCSQGm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:42 -0400
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:6845
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965950AbeCSQGe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 271/281] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Topic: [PATCH AUTOSEL for 4.9 271/281] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Index: AQHTv5vKhh80/x4xyUaHG31AYeUHRg==
Date: Mon, 19 Mar 2018 16:03:16 +0000
Message-ID: <20180319155742.13731-271-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:FGg8VYuTrkt6a//JT0wgaqdcR5Xmx7nDPAKi+XzQPGooxBvLvb21TvyCezOg7V8f8L/Mfpmlzw44Y6+LBJfaejqHHjz1h7UKVQgzTzQpyCGpydnFSTKVY6YTTp7OWuFN31TVJhCxv4R6aNoheuLwcdDvTwGpzyNzybFTGYnoROjGoN4ltkYJb8k0EDVA87qpoVL4fZ5DWr0j9lnmB9n2U+UteB4b+4uf0+vI7DWrbCWvDluOuQL9EfHo3L4/7AP4;20:Vc6/dfFVLH8kOrvnEDMG9CTHEX0s6iVr79UaQGX7kTUvMn7CHpF/uvph0sBDFfiZz5e2FAS8IqN4Zr7aOZYt38y/BWT0xAoovfhun2wiGC2pMHTcsAbLuV1aBNpso4gAX9pjMtMyj3kR9eQ/1ZRbFAHGbNfc1DvlnhFPt+jk6ic=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 313ced02-7e55-480f-1e3a-08d58db361f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015A9BB9A59885FE4F616A8FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(575784001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AOANQ5shPYN7i0padwucqBHjl4T83pktzD7GUaWY/8mM2vTsooMebRdNW+YTdibEbOTSVfTuZIQlBmJVyfW5ftL8lD061lq+ydvweV/IAkPy/FR5wc0nLgde9r4RO3PB/VM9j0MKrBL7MOGPixx4SfARnHyT5bTX0JbI96otEei6xC5+KH//2S6llmI3alRLo6FOL3M8uBni4x4Rxo8kCek3dc3n9LE75T0Jhc4cN0/x1Y2c2N+LiYp+TPwB0NrobtU2IBx6uS4MMIWrJXK9gsG4K3jrrzVdnuEsbspbzHkmw6XJnfTfrFWYNg6bBvmFSy0DI7NbwxYHw48S8Zq2SQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313ced02-7e55-480f-1e3a-08d58db361f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:16.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index f3ed9ce99e5e..9d64e8e7c417 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2616,8 +2616,8 @@ void t4vf_sge_stop(struct adapter *adapter)
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
@@ -2625,9 +2625,20 @@ int t4vf_sge_init(struct adapter *adapter)
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
@@ -2639,8 +2650,8 @@ int t4vf_sge_init(struct adapter *adapter)
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
