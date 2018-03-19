Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498721-2-1928659361314902744
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
    t=1521498721; b=Yy7nl8j6Wf2FU9/28pkZg8YV++UJ/CaiMIZZ1Y6FASsUCZG
    K10XZLdscjgtzPUB08wmfTNNWfh0UROCPbe4108GRU6FHLyaL3Ml9z6jJ7h/RBbv
    JE8CONIM6uqplZ9cG3ylMOf5W9YN2irgzxqZ9JbI5uLx3D76DUZl8ePqLsd8VPS+
    HqVifoQc55atB3cQZO7BgCe/SILyZjxQ5G8WsLmLRHJKbYEf3HMTB4Yg5X0J2fum
    7f74+hdqhwCXr662KOcJLsN3nVYpLnrBs6FwsVwjKpO4K03Hf2Te9vIAlssbL11M
    NCYKPfylqsVVVqd3ljhnK+zTwa5Ha1TMGozDa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498721; bh=a5SoDx
    YedAgu81FGBdvckwmd1R8X410HOUbkBCP9RBw=; b=dWpiq2LzSi+hw7UTmlXCer
    j6rf96rRqTkjXU89McLlqSDUh6d5RQUuqqsa1InbvF41/k3Ju6XYUscmXn8wRHiv
    fWxno0TQTgNq/Cyt+vB/JNF3ySfo4O0Le+J5dZ5De06NnyHMm5pS+goNcCj7mYq/
    E1gCQSjlSD7J6ReGGWMvJscAmgvi/pp4lAg8RPxoWSi1R5LOullI9DE0k9HBzE3A
    Mn3EsZL8+F2CO/Vxh5iB+IrbPoLHwz94fXkks7cbp56x4cpNxbN6KchuYWuqxIKC
    XxxWPxAKfcOxqVe8OQ/DAv1PKJ/Lkx4MT/vMuyCuhZf3eS8MMEovanOVlNNc9TZA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZpYo1LSr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudejgeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZpYo1LSr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudejgeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeCSW3x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:29:53 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:16179
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933788AbeCSPsm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 055/124] IB/rdmavt: Allocate CQ memory on the
 correct node
Thread-Topic: [PATCH AUTOSEL for 4.15 055/124] IB/rdmavt: Allocate CQ memory
 on the correct node
Thread-Index: AQHTv5mnbQd7mrByYUCqrKy/dkfr6w==
Date: Mon, 19 Mar 2018 15:47:57 +0000
Message-ID: <20180319154645.11350-55-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:0G5+LxgeEAon6Km2E9FNW7jBh/9l13ZUxbiUit4ZGmZNuY4ig7EtdK5q6JFN73o8/ONaBKBN9X6ixQqCRljk5yJw4YFsBKoj+NuZF+090PbOdxle7wJg4H8elsQsFofZlNbUdDsd9dhYe/MSyH9VC/k4Zv6UPHPbNwaeTjdHnFrlXIYT8zjAwrJKn2aauzV6QxLjXf718rxP2uc2Pej6NBI1QU6+3XDWf7b2M1EC12qvqqbpOLhzzvQf5ST6caaG;20:B4zIYMyGVm42xNr9O5xPRwYiPrN4zUjqFcLz07c7Xjc2CY8vw+ELlx1EFYcJn1eXldAwBH48rfWZTkIVKjJG06TEVWZMbKtYSfNFLDRNYPfJzNfd76loK3aAqFUixboulva3ZWGJz96wYykPoOAWMStERKsRUrzku6v8zVrWIq0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e05b47a-25ab-4281-3418-08d58db0d42f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10314D1C94D020E96F10DE69FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6JWSJ7ADS400w039BTA4Y8pEKjfK6Q+OpFKVwSaTTEmkgQ4HAMMpNPUBbj87+yiUgcTurF416O2KEguIVY4NnRmLv2MTwZ+vgQVE154V7gV6ikTs45tNybBqH08gmTr7uaOozi4p2lRkWeldxKfc9gMS5KjjJxvq2IZUiK1x4BirkNkot/CPGMhDU6hPwlDG/DrM4az1sUWOaGAJ6O5YCAWkatUvN0gWBsvfsUCFzPBbzNFOXobZYIOI/iOxgJXS3Kvy7IZkUDSs6qEAFrJ8USVKDBDB62bL/1n7VSqztKkrJd+9ANDW/e+KHGE7ArbZNL7Rk4/q0/Qt7po2Jyccqg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e05b47a-25ab-4281-3418-08d58db0d42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:57.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
