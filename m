Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474964-2-16082100389613200544
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
    t=1521474963; b=T0PwRLdmrC2+uVW/W9bzQKkBCjnZm8rUSc67Amk8nUHEPrl
    7LLlnDRAJkspGWEtMCHMWGtKBKe5MnKvAsYvrzTlniaY6l+nhvcepW5ZRbhvvfx+
    xO3pcXi6AhIXavQqNKXJmMN2J1UseHQ2E1JZBdy9NfcR7NhMxMmufl7ZNkDpZduQ
    NWhqBZ1yatk+xV4BZ4rsN7ufKZrJGQO9qJ9GKnRGHd7H+sniUN/rGoHeEZCQZDv5
    64iXcd1oR1z1sn/kLehQ5SI0ngdMCQJ9t/Qb8LkbMIQ0iPpvl5uOhYwfvGtYOayZ
    2dqb5lZ3G1q/ApcEJqkSUg3vGEwMfHezylEhQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474963; bh=a5SoDx
    YedAgu81FGBdvckwmd1R8X410HOUbkBCP9RBw=; b=XTRPkwmtqoIXsp6EvOWdSV
    Z+DLmOsNOTKYkfc0/gsNmk3j9h903JY18C18HK0lU93H/AsocygFjxjJBY89V+Yt
    z6FR0xgkD+uXfi7BoaKYDUwtDmeMaJx6DG/y7cmnOgM0xZcIEh7akRvVU9hJtcat
    ujQkeOjOTui0ddlf8GoxFOBm/2dBH533RE8JbQY26coNM9pxYBgkaroT+2BrC8My
    9hdRBArFLxo/AEh8jgl9EDu2ijAIWf/97Bhbikln/vr4c18QcpHWHFS6OE3iHwFS
    KvKZ9souJqIQhU6eEvP7fmMfkqj9F5yCdat3KcR0hqCOlBAnubeJAj49x79ts6Ug
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gJooFjgP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieelnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gJooFjgP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduieelnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeCSPz4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:56 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934399AbeCSPzt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 41/97] IB/rdmavt: Allocate CQ memory on the
 correct node
Thread-Topic: [PATCH AUTOSEL for 4.14 41/97] IB/rdmavt: Allocate CQ memory on
 the correct node
Thread-Index: AQHTv5qtCTZvFJaVfUGhqzWoy5f7Qw==
Date: Mon, 19 Mar 2018 15:55:18 +0000
Message-ID: <20180319155411.12348-41-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:lqRX/ao7rbJ1BLp2OdBkGyMXTKNtruopZcuMw2tc7Vd3Xlp1vkD1TE3MgpquFkVzbI9Q1/op8UlJwSfP4tuoEXDQqtaZhmCYZaJw35ZXWc2JFueBgs2ZLrPgIvigMSlsVsx2mV+Y73z6EU+Upa93gGcqCNPwzQW4JALI9TSxBxOE8lVA36ujRMtBCkWR/CasnkT14AMIugjCbB4QnTrA3M61yIMDWzy8ypTM7SK43vm7FU/qz8g058ccxKINj0tG;20:9o0vLRCpPYTSNLs4wlSBcC7bGYa+UVcZmGhg2Iyj7tiiFhU/ygATD3vW7y8ohw0afz3xOnja05U42WK/ZumWLsVROzLdz/12HgGCy9tEk2kQw2UqE4PiudG6aB5+dqnQ4GgXIcXUsb+XYkJkwQop2dSdm7JjQMFKhHabbwuia3k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee1e8a94-bf9b-47f9-1999-08d58db1dfdb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09676E77239FAB8FF6D5B97DFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pf0xCX34IAKup2/u6lLi6AqyZh3YFZ8x9oXPj/xzWersvYko4lVvpndLIgIkIprYodzKchsrWGosH1m0ug50UjWpL0yT29r/bqTkxfHWxlNubUZ1SckqqtWm7mquA+oLsP5S8V9WhAXeR5ohVtVf2Xkrl/ykPOzXNqgwQTyktii+YhyvQ20yuJ5wNuw/2WBFS9BrncKgfM5Xe340E9sF5160EnanrCX1NGQOfzQcg0zl83+0NLULuhoT9aR/VoCOGZx7sJ8UX/uXvugou3HQj92DKPPL1xIPXMW6Du2gNGAk7Gm5sC9d4c0bzfEumkmNXCSO20Hkbp/V2ICl5EbCcg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1e8a94-bf9b-47f9-1999-08d58db1dfdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:18.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit db9a2c6f9b6196b889b98e961cb9a37617b11ccf ]

CQ allocation does not ensure that completion queue entries
and the completion queue structure are allocated on the correct
numa node.

Fix by allocating the rvt_cq and kernel CQ entries on the device node,
leaving the user CQ entries on the default local node.  Also ensure
CQ resizes use the correct allocator when extending a CQ.

Reviewed-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdma=
vt/cq.c
index 97d71e49c092..88fa4d44ab5f 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -198,7 +198,7 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 		return ERR_PTR(-EINVAL);
=20
 	/* Allocate the completion queue structure. */
-	cq =3D kzalloc(sizeof(*cq), GFP_KERNEL);
+	cq =3D kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
=20
@@ -214,7 +214,9 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 		sz +=3D sizeof(struct ib_uverbs_wc) * (entries + 1);
 	else
 		sz +=3D sizeof(struct ib_wc) * (entries + 1);
-	wc =3D vmalloc_user(sz);
+	wc =3D udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc) {
 		ret =3D ERR_PTR(-ENOMEM);
 		goto bail_cq;
@@ -369,7 +371,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct i=
b_udata *udata)
 		sz +=3D sizeof(struct ib_uverbs_wc) * (cqe + 1);
 	else
 		sz +=3D sizeof(struct ib_wc) * (cqe + 1);
-	wc =3D vmalloc_user(sz);
+	wc =3D udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc)
 		return -ENOMEM;
=20
--=20
2.14.1
