Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523247054-2-16565696848332958329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247054; b=BdmJPGu31hweSzQctY/p2JUOCCxBYMpjAmrJ+9o8IkoCTp+IRr
    cr+m+I0xQxfsIFIjqGXwwmvzwuudQfthfsBPBTO2fe3Q2JyrYnI1+4DIUjcWQi/T
    FTd/k/s5Db3aDpDSVbIfVrQmdrlJnDmTzDYtELhM9J++crJpFz4CupUKnNI9FJL1
    c37Bdjj6UKl/VtdxZrXvFddd/ovZdCu+0d++fhrmhcufdpzbCzr8z/ERrLzchsyp
    9my3CLJXeXXBenPTgafibXG1W5HMpglSLUqzEoDlG8ipe7Q/Hqhp6MeZxWnNUsLl
    z9VV+MrBCdcYUB2v5Et6/dzcLaZy4ocivShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247054; bh=kaZp7ERR86
    G1X4grMJn9j113W9g1yAh8aikwX96x6sY=; b=hdtzDQ1UTZzrpiKlQ66o2aa5EB
    FGnxkX7VnoqEtwjQPlVV3LLGztQ6VbTFwlCKHbeL0FqkAV/mWAzs8meggtc80V8n
    uulJ4dxInQLeuCPbVZpsKDqiqEIHs+sO3ZZpTWuHHgd95fe+cDrFqnxAffnor05l
    zpl7YePingYsnohJpT7B9E10FVJpKS757WhbBXDamf9555Bk9cBc9MsRicCHRO+M
    c9pmY+OM4DrQYZXTFJFWnSPS5a5mf4cR8Rf60AK4fw2+q9MRIgE6A01UNuMgXstP
    KAK4XjbAkacFh3IWtEFLex9yRFc7W3huwzp8Oc1bsORmDl7KC7ynF/QksZEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A1HaAyRG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A1HaAyRG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/iokx85+SkeKRQq9/MA/UfbxEVNNd/L0kCyyOxJLDQFt8reHS66thnfWMxJk5KbyRBY79/sTXeKsx08Gi2EBjq2Ck7LDARcLvHZilPEEYZJ3j3GMO/
    Jd7HZPBpvlAAA6cin5OWIaju235xqRpq3D7Xbrd1IfG4AbbqPvTPB8G+bj5NlVEH9zlFGX7h4uZR4qtwb5kewU3K8/xXHUpIxM7AiGzczyJXZZPlf2Tf5AcS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=yMhMjlubAAAA:8
    a=sFSi5EiQHAt6g1ozJDwA:9 a=wPNLvfGTeEIA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeDIEKi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:10:38 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752995AbeDIARC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 017/189] xprtrdma: Fix backchannel allocation
 of extra rpcrdma_reps
Thread-Topic: [PATCH AUTOSEL for 4.15 017/189] xprtrdma: Fix backchannel
 allocation of extra rpcrdma_reps
Thread-Index: AQHTz5gSzjNeZZVx2EO47IImEBzoWw==
Date: Mon, 9 Apr 2018 00:16:57 +0000
Message-ID: <20180409001637.162453-17-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:2BSQyQwWJ1oVRS8aM7AZF9SiHB10NCmPYOMlenGOXVX064/PWRSkQcQtuD2kuycejuELqQTJwK8JiOvrigUz+FrDJCgbDT2YVDmBggE2x4Gvn3IE5QV3hwBWxwTN7WFEvTPNM1CVEV4m9L4rzyuhGzdHVbqHKYLwx4TLKhIHap+pARizce/JKP63bFuVq3eM7IawaV24OBfydZB2xFbjWFBCQpn32nJBXZKd6OuAzvzFFPs8isb6LxqJ47jiLhn3;20:YMb0O3yVOhG7e2pdPTIU5o+zeUGGJIcHRI9LKZmktVZkv+8J8zYoLD5RimMuzGz7PuigdUgg2hya1A2uHfSE1QlH1JTrHjV3CeC5NgCF004+PXJbKjhs1AKz1hjC+KPk/+6qBKQW6eeFQu9AvqriS/tT87SobPW1Ltszakjnf/A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a36720a-1850-4e75-da02-08d59daf3528
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127296776A08CA36F5F5CF0FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: j154mWEUsBqmcGotgAzxd1tLsFPR6ziR5PlIb8CqFWjefaf3WMyY0LjSPZ6WoBcYbFAPVwU1l/W4C1DjW2krM5QTI9IlZOkL7gvI/buWkA1c7O/a4PZaDIMv4P2uEaEpMR2abAsjY7ilS4ANQK2DSJFLAwerQAXu9Q4phnhlHVJsQ2T6NZnhJxPtoTwkLcPsIdBl+buVLrbaffdTheY7Yw03eerra8Y2KMxJMkNHn9t99CjDuhrWHWsF9rT+Jx7kQOfaQV5NaaeTYO1TbylSM3QT0A0tlMCrW37tfn/UICfqivhPyYLHtTHtH56xmLOIhZhkjSs8rVC6llEfLXxfTeyXbZEXKyohq+RoBYXQDmElPyfYRlza2uUSs44gApumnKG2Dw5MFnrQzgml9W+YRJCXH+ykfaGeMvAIJe3PRH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a36720a-1850-4e75-da02-08d59daf3528
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:57.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d698c4a02ee02053bbebe051322ff427a2dad56a ]

The backchannel code uses rpcrdma_recv_buffer_put to add new reps
to the free rep list. This also decrements rb_recv_count, which
spoofs the receive overrun logic in rpcrdma_buffer_get_rep.

Commit 9b06688bc3b9 ("xprtrdma: Fix additional uses of
spin_lock_irqsave(rb_lock)") replaced the original open-coded
list_add with a call to rpcrdma_recv_buffer_put(), but then a year
later, commit 05c974669ece ("xprtrdma: Fix receive buffer
accounting") added rep accounting to rpcrdma_recv_buffer_put.
It was an oversight to let the backchannel continue to use this
function.

The fix this, let's combine the "add to free list" logic with
rpcrdma_create_rep.

Also, do not allocate RPCRDMA_MAX_BC_REQUESTS rpcrdma_reps in
rpcrdma_buffer_create and then allocate additional rpcrdma_reps in
rpcrdma_bc_setup_reps. Allocating the extra reps during backchannel
set-up is sufficient.

Fixes: 05c974669ece ("xprtrdma: Fix receive buffer accounting")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/xprtrdma/backchannel.c | 12 ++----------
 net/sunrpc/xprtrdma/verbs.c       | 32 +++++++++++++++++++-------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  2 +-
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backch=
annel.c
index 8b818bb3518a..256c67b433c1 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -74,21 +74,13 @@ out_fail:
 static int rpcrdma_bc_setup_reps(struct rpcrdma_xprt *r_xprt,
 				 unsigned int count)
 {
-	struct rpcrdma_rep *rep;
 	int rc =3D 0;
=20
 	while (count--) {
-		rep =3D rpcrdma_create_rep(r_xprt);
-		if (IS_ERR(rep)) {
-			pr_err("RPC:       %s: reply buffer alloc failed\n",
-			       __func__);
-			rc =3D PTR_ERR(rep);
+		rc =3D rpcrdma_create_rep(r_xprt);
+		if (rc)
 			break;
-		}
-
-		rpcrdma_recv_buffer_put(rep);
 	}
-
 	return rc;
 }
=20
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 8cd7ee4fa0cd..371fbd9b55bb 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1093,10 +1093,17 @@ rpcrdma_create_req(struct rpcrdma_xprt *r_xprt)
 	return req;
 }
=20
-struct rpcrdma_rep *
+/**
+ * rpcrdma_create_rep - Allocate an rpcrdma_rep object
+ * @r_xprt: controlling transport
+ *
+ * Returns 0 on success or a negative errno on failure.
+ */
+int
 rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_create_data_internal *cdata =3D &r_xprt->rx_data;
+	struct rpcrdma_buffer *buf =3D &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 	int rc;
=20
@@ -1121,12 +1128,18 @@ rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt)
 	rep->rr_recv_wr.wr_cqe =3D &rep->rr_cqe;
 	rep->rr_recv_wr.sg_list =3D &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge =3D 1;
-	return rep;
+
+	spin_lock(&buf->rb_lock);
+	list_add(&rep->rr_list, &buf->rb_recv_bufs);
+	spin_unlock(&buf->rb_lock);
+	return 0;
=20
 out_free:
 	kfree(rep);
 out:
-	return ERR_PTR(rc);
+	dprintk("RPC:       %s: reply buffer %d alloc failed\n",
+		__func__, rc);
+	return rc;
 }
=20
 int
@@ -1167,17 +1180,10 @@ rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	}
=20
 	INIT_LIST_HEAD(&buf->rb_recv_bufs);
-	for (i =3D 0; i < buf->rb_max_requests + RPCRDMA_MAX_BC_REQUESTS; i++) {
-		struct rpcrdma_rep *rep;
-
-		rep =3D rpcrdma_create_rep(r_xprt);
-		if (IS_ERR(rep)) {
-			dprintk("RPC:       %s: reply buffer %d alloc failed\n",
-				__func__, i);
-			rc =3D PTR_ERR(rep);
+	for (i =3D 0; i <=3D buf->rb_max_requests; i++) {
+		rc =3D rpcrdma_create_rep(r_xprt);
+		if (rc)
 			goto out;
-		}
-		list_add(&rep->rr_list, &buf->rb_recv_bufs);
 	}
=20
 	rc =3D rpcrdma_sendctxs_create(r_xprt);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdm=
a.h
index 1342f743f1c4..3b63e61feae2 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -564,8 +564,8 @@ int rpcrdma_ep_post_recv(struct rpcrdma_ia *, struct rp=
crdma_rep *);
  * Buffer calls - xprtrdma/verbs.c
  */
 struct rpcrdma_req *rpcrdma_create_req(struct rpcrdma_xprt *);
-struct rpcrdma_rep *rpcrdma_create_rep(struct rpcrdma_xprt *);
 void rpcrdma_destroy_req(struct rpcrdma_req *);
+int rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);
 void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);
 struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_buffer *=
buf);
--=20
2.15.1
