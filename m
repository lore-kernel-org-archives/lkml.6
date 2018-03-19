Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496962-2-17678161558413204938
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
    t=1521496962; b=r1l04jIIJQKjsLPxNYnf88fh2RCT7U4NTMlQ7zWmjsB+CA5
    C5xHZ9el6Z3UdsE2v2AWYYkFg/ejKl2qjwU8gxxVa0o1Z7CK99eN7t714eOxmFwG
    wSEx62hfhgpqI91mZJbgVCgqzGsawfrY5BCOyYZgT3HAhC5hKU3JbFRl9lQQnFnW
    Vh8t5Sz0U5g2DDHhm1DH4ns1lgfGBcssErEBu93LylDu28bL2max6BBdsjPrLdUk
    Epm32i9LE6U3Xi+jZflQdYVRiSZImhCA+451tkCLUCj/3cQ4uDLtcpCxrUG+JabY
    XbXwxFpA3mzK2JbTO5e+qhOcm+MNI+qfnB14dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496962; bh=Y8gBVD
    tji0MYhCnGQB0AcOVi3I6Zfzl+fL+W5infbQo=; b=GpBl2cwouO5Yx/Hxubgtsc
    EeEmQ00Mmxyin/RNhNvn2P8YzfgmKCV2HN52PA8ZxC/eGRSkCraiVWgAqAZsMHfH
    kbfXMtHW/OAzhZSYnFgbZWFp12rSimy74tjp/AdA00c1RGt7N+a1ily6I1IoZbz5
    bKyLZl+HOj0wGuUl5vWXf1xVkH71f+5JYLh0vqv78a93LZPpOxAZoKtoC79wthWG
    uih39dXNz9uPI9Aq0yTmhSljR5aA3K78p12IO8Qger7CWTpUiiu942khF86OPxKg
    gVnfo72wjJvYfLqAxkT4QUVaZejaiu28lx1RPzu/X8j0mmAV2qYgj6E3ePLUpT3A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KToKeCF0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddufeenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KToKeCF0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddufeenucevlhhushhtvghrufhiiigvpeegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeCSWCk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:02:40 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934430AbeCSPz5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 48/97] nvme_fcloop: fix abort race condition
Thread-Topic: [PATCH AUTOSEL for 4.14 48/97] nvme_fcloop: fix abort race
 condition
Thread-Index: AQHTv5qzkwZdCvO/S0mki5V6Ph4wNQ==
Date: Mon, 19 Mar 2018 15:55:27 +0000
Message-ID: <20180319155411.12348-48-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:d5oVnedc+UyTG5zRLbAuGFnEecOldgmOEDYgkGjon/AHDzHsOUfUWGY0w8Ol5DxHVm6/cNTv3T8ECOCU4svgqYjMInNN6T4ozDKKIV3uKPjatMTI18PwyVWrH9pq3YiwURdMNhiu2Yu8dsZYuSmS5u1RpXTAhIJIK+MY4QEj/ZHOTbEsQW5xY5Xq2TaBAWyt2zx7nuZS8eS1qKfvlQEw+PMY+pHd+vLdh+SwngFjX3theEmbCAlRCVMPHJUH65ps;20:i6VCo00FClBEwzXyQE0SnWUaSOYe1IUDyVNRe4sX0NE2XFWyFr6gK3kZnv5FkO79siIVj+NEULNvbY8kHRgSRq+DptgVEXJQT5mPgxWS/XIlei+zRuCuaT9kd/lfeI0WA+/7WLbmYm+W+reWr+hZI4wAQItU1URG3gh5lRIdDG0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f106e66b-176a-4a03-ddc9-08d58db1e238
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967DF658783F75178B4CE85FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(39060400002)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EXcLmrIPKtZKEOws52F3291deTD4ttS5CLjQw0TPe8etxrNGNdGol+nIh+TsO9r57/5rQ0P0eSAooblTW9apM6afZoJHEdwobqS087EdfOmpTygsH9m2+XtKdf8LVhDXK61gUBJzJ/WGQj4m1OMlfQV1fYLKIxhmpbv/66X0HWh49FzDKjU35P8GAiwgfg8YpiIpcJDjyl9/qJQFVcUTX3PBJlgERCxAFt+RGFkVF8AVMOE4eAQz0IiFtiAHdgbxvrwChZdTebmGVaNBnKzzooIY11liGcqpDwZYSXnxzSKWLwRUzon0Km5Xd68ccLzPebItGzQOLSdi20lXAJ9YLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f106e66b-176a-4a03-ddc9-08d58db1e238
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:27.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 278e096063f1914fccfc77a617be9fc8dbb31b0e ]

A test case revealed a race condition of an i/o completing on a thread
parallel to the delete_association generating the aborts for the
outstanding ios on the controller.  The i/o completion was freeing the
target fcloop context, thus the abort task referenced the just-freed
memory.

Correct by clearing the target/initiator cross pointers in the io
completion and abort tasks before calling the callbacks. On aborts
that detect already finished io's, ensure the complete context is
called.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/target/fcloop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5b51653ba9fe..c0080f6ab2f5 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -374,6 +374,7 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
=20
 	spin_lock(&tfcp_req->reqlock);
 	fcpreq =3D tfcp_req->fcpreq;
+	tfcp_req->fcpreq =3D NULL;
 	spin_unlock(&tfcp_req->reqlock);
=20
 	if (tport->remoteport && fcpreq) {
@@ -615,11 +616,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
=20
 	if (!tfcp_req)
 		/* abort has already been called */
-		return;
-
-	if (rport->targetport)
-		nvmet_fc_rcv_fcp_abort(rport->targetport,
-					&tfcp_req->tgt_fcp_req);
+		goto finish;
=20
 	/* break initiator/target relationship for io */
 	spin_lock(&tfcp_req->reqlock);
@@ -627,6 +624,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	tfcp_req->fcpreq =3D NULL;
 	spin_unlock(&tfcp_req->reqlock);
=20
+	if (rport->targetport)
+		nvmet_fc_rcv_fcp_abort(rport->targetport,
+					&tfcp_req->tgt_fcp_req);
+
+finish:
 	/* post the aborted io completion */
 	fcpreq->status =3D -ECANCELED;
 	schedule_work(&inireq->iniwork);
--=20
2.14.1
