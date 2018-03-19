Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499442-2-2740405743690601571
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
    t=1521499442; b=qS1K/eNukte0KETbkOoCIxD/5Mg6207UDuYcHtW49CxSM5T
    VZWq+jC3mOl64hQCeWYH/KKIG2+UZXHG2yPJfk+7BbVglpLUb3e9ZgFPu2oJ6e+M
    LIrGHyX3mmkVfdBhtNFqhrXTH8sD1lrXru8GymhF1dlhUOr+D7dJSbe+yUQ7DKXX
    IDXmU6q521yd3JkqFAOnO4Abz+8457IC92jLJBz6NY/xU0EYEOBnDFknVV42wenz
    UPHLt9gE78DwLO/Zfrvmdl3iyRGezxemENkvbglZf/ST+BIOXcrzvwF/tzipP4QZ
    LtFTbuxUXu43rMxDTA6pdosfCnewClAXvr9MO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499442; bh=AEJHIX
    LB25U83nb+H0i2fL+5tTVmxjE1z3g7e5f5rMA=; b=DBMXLO469zOFG0aXyvewAo
    gDXc/3ALpH9+/hMqgdLpSrVR4fpZZOc5KWH+eeNeHCIgMuuhTIN2KDrAbQ1Fll0u
    40hAjHJCW+PMOwMBfSvKC01l64j691CBGsomZRMo/yq8UPUoMRKBa90hmvN8UpXq
    QpmWvF5VoDnjdD6imc/BU7H1KBWrbaXIqb6WnhUk/8sPspVeGdn229dsB45xgXQZ
    ihz79GqCj5LPlaQtdjaVRcNlQe7AZAECGcwosna4YyN2H4w/1TzAm18eTiZli7wB
    tVGnnABiqHhTx8BuBAIEt59htS1K4TqjeUKbWCv7yT0vcTr3NBt+e0HWmwl9RuAg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dyHLCpDr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgeefnecuvehluhhsthgvrhfuihiivgepfeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dyHLCpDr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgeefnecuvehluhhsthgvrhfuihiivgepfeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936687AbeCSWn6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:43:58 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755775AbeCSPrA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 003/124] i40iw: Validate correct IRD/ORD
 connection parameters
Thread-Topic: [PATCH AUTOSEL for 4.15 003/124] i40iw: Validate correct IRD/ORD
 connection parameters
Thread-Index: AQHTv5mDvnmvcBocA0a0Vg2DJqqBhw==
Date: Mon, 19 Mar 2018 15:46:58 +0000
Message-ID: <20180319154645.11350-3-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Gv4Cc8LDBN1HnOpgBDPMBo66tJDj+9mkkbTxGihE/7j5voGzLzHVVQsZDAysN9W+RAckKHVVRb5TSrLrIcgTEbeejmvYKDzTD4vz2ZjaeLKnQvjM+sDZEG/vDknY2QKTrVMhtODk2zEVWLxrdudbNWgebMhf49tPKMovELc9f68Osd8Nns72Z5EsI9m2EnbSlP0BYIwe/W1xrAMiqV4za+UsUNeYKQuy1WW3Awj6IRy4s3di64cfOlgnuu6yOI20;20:1yW/1sXb31NRSej9nvzyG6PLReyjPCKDqE2R/AyIhoV3K/tSOtmURHFbbeDdaNV7ARgZVe74ZXSMa34Yob/K8rMvQzMtLGET+rEw/2WTyxV/hnN9XY1Q2vsA7y7lpzLaWyfJM5j+UgZTDaO3bE4tOqr83gmvLD3AuQ0dfk33yZw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4252253-0992-4849-1933-08d58db0a624
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10139DE0CD60333806761B77FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(15650500001)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FYDcLsWhMiE8fIKUBKUaZYuZhkuvOMd7MoRg7qGkBbbIsKEC7V/2m+UCVa9hDh6QF/sA4PYSgVRxG81WX0t6sGGo6Abi2uO+dL6TwW0BlqwdZfsFtOdIz/GXL0HzwJ7IpQ5Hxm4q/e7Kvi6wnp/ks0kzUtCwZatHelCGNjBAQeBaym8hRTpbW72nQu/zbk3xJnJjWqco1OyCSGEWMFquJMclfgoLFhohIxeWKFrJSa4Q6RaJiSob2Mu2VfXtbYMoxsW7KHtw9VS0FAQJva1d3zvdsIXA9EUhs/rqLKtp5o39q9GMibWA1PVVNlsUvPbyXA836PQxAi38OJdPdkKEHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4252253-0992-4849-1933-08d58db0a624
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:46:58.2105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit ce9ce74145aa6814a370a9ff4f5a1d719baaced1 ]

Casting to u16 before validating IRD/ORD connection
parameters could cause recording wrong IRD/ORD values
in the cm_node. Validate the IRD/ORD parameters as
they are passed by the application before recording
them.

Fixes: f27b4746f378 ("i40iw: add connection management code")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw=
/i40iw/i40iw_cm.c
index 77870f9e1736..726d7143475f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -125,7 +125,8 @@ static u8 i40iw_derive_hw_ird_setting(u16 cm_ird)
  * @conn_ird: connection IRD
  * @conn_ord: connection ORD
  */
-static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u16 conn_i=
rd, u16 conn_ord)
+static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u32 conn_i=
rd,
+				 u32 conn_ord)
 {
 	if (conn_ird > I40IW_MAX_IRD_SIZE)
 		conn_ird =3D I40IW_MAX_IRD_SIZE;
@@ -3849,7 +3850,7 @@ int i40iw_connect(struct iw_cm_id *cm_id, struct iw_c=
m_conn_param *conn_param)
 	}
=20
 	cm_node->apbvt_set =3D true;
-	i40iw_record_ird_ord(cm_node, (u16)conn_param->ird, (u16)conn_param->ord)=
;
+	i40iw_record_ird_ord(cm_node, conn_param->ird, conn_param->ord);
 	if (cm_node->send_rdma0_op =3D=3D SEND_RDMA_READ_ZERO &&
 	    !cm_node->ord_size)
 		cm_node->ord_size =3D 1;
--=20
2.14.1
