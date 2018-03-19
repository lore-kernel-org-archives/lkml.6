Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478427-2-1003661918345456801
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
    t=1521478426; b=A3uBYAzdwWsDCTPhuN8q/Gu6hamo+8utcm2iP2NayRtvBSm
    o8ezVOp/Qpd8cdUhjZ/1HDhq/klIAcgdCIJS77UsRGgcUb8rxrm929vFozHskuJl
    1oPEGC0wKq8NuHdM125rdjcm2B+u2bloBGSZPPRFMl6hCIRYRUrBb/+IlwuSEz06
    aW2OJ4G9xJXhaynEWhM959MHIXEjn4Gqa9bZuh0ZnVHmXw2WvrLYlXACNjprlrTD
    js6dI5LLRAR1UrYI1MyHBaZD2wwPX8caBZ4FBnF6eIjLMSm4oxRPdPsnrUwdPSPd
    axNSHoWdNBiImlD2QLBY4JF6FoBjkFZlCHb4pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478426; bh=goOisP
    OVPSATavKtsEwWQR350rIUHw9OH1TgEGy+M0k=; b=a+MziZhhUbSKbt8MG64Jiz
    siPHNGedIsELfegUxWxlciiUA1NA5DjiHtHClPnxpTfyonXIue8KYpTSaB/zFIFu
    SjRnwPJjcETwTPPjZZRMTtYQzUPflbHDZC2goLEn2WqjL6xsYXJT2VGD5INcnZoS
    lUQhRCgPkSNkipYU1ag8lcPAQq6TYzjcn6dfgNuCrNGzjkBV3euXwzGLcyfAj4gq
    dn78Qpmh+Em8M8u0KmAqqJH6gLswSLKsQJf7IuJLShP367nD8AJ0Mz19qcA1M6CZ
    szQe5usDfljQq/r0hHmqoNtlaGap01H8uJ1tOBWHiBLTkduauC/bYgprotWyeWwQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fA2ilPGE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelvdefnecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fA2ilPGE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelvdefnecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935115AbeCSQx1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:53:27 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935103AbeCSQLp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 162/167] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Topic: [PATCH AUTOSEL for 4.4 162/167] cxgb4vf: Fix SGE FL buffer
 initialization logic for 64K pages
Thread-Index: AQHTv5yPOfWGp4Gz/EisxPJWyrYR+Q==
Date: Mon, 19 Mar 2018 16:08:46 +0000
Message-ID: <20180319160513.16384-162-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:hmd232AN1X0bqG2uiQDqt/EcLzZM5FfkmgGElnXdyOS8Y/LObzWOMFxRc90Xn9AGc9K7mmg1E2v/HZRXdK5oQhAy/aea1N0eYwgpqldJMIaD+11/u4Ffg8MFwRJMjLUIdOpAOYQLg7+gINTF3yJm3yveT1KRJOzTPeb+wbFKpPA3xelrM7nmTbBJUAMYJTXZ4P68ZTdy6oqn2vs30XCIvV+5uVGwETGftPZmiE8LUNWeav1OFA7BPT2AXyPVql48;20:RlqwkCytoEQFpDVvjBkMmVXxkRmTFYFGb6nXhIM2U8EoTVFmscOXj1kMoIQHcPDXTfYz2DmiBXFAhsbWzZU8CsMUOE48Z3Py+6ZdO/cMavCk1J7bCXRcxhWi2Lbdqn7JkBIilxX7Y82/8aOCQalgVstK8t+BQbcFV/adQrVeSwM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f95b190b-9040-43bb-5637-08d58db41151
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984DF5C657375423910B95DFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(575784001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AH0NjuHgZKwUEbi40eaoZesmL4DjJb+5qI/WNZhcxNv+7YzF6xhyjF3aQbCNgoO6J0UEYPvHXtiBLLDvEEJJmE8eCDwARnqLnvAS/pDjGPeNk9zZMPgQjTccQvzJqo2wBgCRn6Rfszp+dahjmjSqo+5jqD4HLi8BPFSf7XVxYetI2xcBlE4+uvCt/iheYNzf3C9+M5Mz8WgoZ5/gkTS0H1j94WJ/5qzFnb1SRsu4LjNPSsUhP1bUEiNACi3/OXCfzl9cdwLz9m6rthdl/zdAaesw6ha9zxGSB5pqlFoKg/3cqXVEhqi+d5Rj03xGRbL1BbJUdaLNwxTihHfzR5FGgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b190b-9040-43bb-5637-08d58db41151
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:46.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index fa3786a9d30e..ec8ffd7eae33 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2604,8 +2604,8 @@ void t4vf_sge_stop(struct adapter *adapter)
 int t4vf_sge_init(struct adapter *adapter)
 {
 	struct sge_params *sge_params =3D &adapter->params.sge;
-	u32 fl0 =3D sge_params->sge_fl_buffer_size[0];
-	u32 fl1 =3D sge_params->sge_fl_buffer_size[1];
+	u32 fl_small_pg =3D sge_params->sge_fl_buffer_size[0];
+	u32 fl_large_pg =3D sge_params->sge_fl_buffer_size[1];
 	struct sge *s =3D &adapter->sge;
 	unsigned int ingpadboundary, ingpackboundary;
=20
@@ -2614,9 +2614,20 @@ int t4vf_sge_init(struct adapter *adapter)
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
 	if ((sge_params->sge_control & RXPKTCPLMODE_F) =3D=3D 0) {
@@ -2627,8 +2638,8 @@ int t4vf_sge_init(struct adapter *adapter)
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
