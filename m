Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498453-2-6954408429468929021
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
    t=1521498452; b=SG04poKc8vLm9wDNRQOUhQRLBSgTGE4UGm4+pZosKkk4wRj
    D+boXzSJD7z3mklgBJ3QoBiVQ9lXylxNZY6Gel4GXlP7+f8XrtjyWKuAeglXtB1h
    TT8j/slsHW9bjjwIgXc5j5qfR23jqjEUyF4SapoF71DwfIx4ICEa/KS2ew3C/1xX
    RGi90d+XdCZ0CwjGmBwKnmVPxfdJ3Vy/RTVXEyrSXHOALaAkPv0KE+Ih92YdIKMx
    sLBpUDTxg7ICg6/MGy6ApK2Z+PstMRlOjfgP2ly4JqNiorI7nCbEnj8uLy8odkMR
    Od3wSPFVqMQ0u0rg4tdkoFVtLK/hIDz+a/3rGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498452; bh=I59lRv
    +Il4J0NP+Pbxize3dmTZMlp9TentKsbfl1zA4=; b=ZcEN0mM6BafBKVQpNrx0JM
    cz+kK3ATws4enkktmhx0ZTnWHKphMSibqP+qcSoKSQ4+4d1qC+By+1pRH1BDRvPl
    k6V1p+CNXtZsiAqTkxVil8iHXmCBFaH36994Gcal+A23jrWz0QVthi1Y4Ioc4aEh
    ZD2FKVhMPmdsAWz0zOzyiavSZMrFm9l0DYshhq27dR11zgdyCQBZ7aG6YvUU5ESe
    W+L4v/ckAo4g6VHldk6f6aoARZjd5qpJ4k53gvfLkzkLoO3HQYdH539rJ6ZYyhCx
    9BSDHRlT9Nq9e1WOFukXISMtjPBRDSczgx+hYIJKqaXSmp5Y35TV3EnF0Y5Z11Uw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N3Cts9US x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvkeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N3Cts9US x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvkeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbeCSW1U (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:27:20 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:38940
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933846AbeCSPsz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 063/124] nvme_fcloop: fix abort race
 condition
Thread-Topic: [PATCH AUTOSEL for 4.15 063/124] nvme_fcloop: fix abort race
 condition
Thread-Index: AQHTv5mtTZVoP16Aw0myqwhUhTrP8g==
Date: Mon, 19 Mar 2018 15:48:07 +0000
Message-ID: <20180319154645.11350-63-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:4hqDVk9L+9N3dj9ljlZSYJ67SMe5xNeG7JpjQzdGZlHnKjYtO1iVbg892bO89k69CoJ4J5z/k7Z1Mf9SYGmVZOrvtgMcB/OHzPst+xVkg6GBljoABWqq8P8BhAs09+fIWfBcduYcQyxP5zaUxLy0uPMB2yyo5cRKI4qXWeXX9KEiX+MonS3f9IlGOuy1D5kPfvRxn9fJ0gk6yMMDh0ZHN1i+cb6YqhQu67TQaee4tYTwyzJRpmUzrJxjacwE7q/Y;20:FKnMXLB1y41J2PCXtPg931XODHmUDKhuvjxOIr1dV4TfP8fA1P752XyIE2eR9YoKGtEXB557QwibKmoRb3euKOqHbTDcLyvLCwBoUaV6E1swCBhj4XIFphwwj3nKjtO8uAwfNUbzFtQDb3F+93anx9303HhfXNOvXA91itqWJhM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45ddc3f4-4612-43cd-e4f8-08d58db0e8d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB09369BBE6F325EF111F24F9AFBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(39060400002)(59450400001)(99286004)(68736007)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: FPj86/ushOHFuOxfXIwJfoy8L6PxogFqKIz+6plnQi0O0CiDN/uT4DJ5dbPRW8ju8KZD5q++Bk2AovY06O3WiZUqK0DjOctNM5OQpL3sJ9oaWcfotOyv90Oms9YY2sVI628oE9BbOPqkJlWoywEpDv7kGbZn1Afn4SPYi8pCj8SrqY3n1UsZaqRN5BlzVviEeUCEL4uheGQqiXyFzQR2G66TGzdFZcAxL7DZHMEbCTaalsvMfy+oj+EueO129An43w1KcW0HOQXNF7GBrJ0RiRidMtCBHQz5KPI/MT8WLX6blE7TuD+5F+V8jFcnJKThQuV2aIpVQG3/51dIds/D0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ddc3f4-4612-43cd-e4f8-08d58db0e8d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:07.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index bedb66521a4a..cd1adb9e7e9d 100644
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
