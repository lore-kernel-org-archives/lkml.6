Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244556-2-7123923607220981444
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
    1523244555; b=nhJfYgURfJg5atkFgnn9Rdf7FQl/YQrJ/oYOfYpQX7pVgGjmXJ
    XNhOtvoQ73gV64H41bFwV4VEEe0RvJl7SsDgi0nn1s5J64pOZ/nQY7WI81WAOD7e
    lL+4WkdxmrWkwbtVCr3/0+3BIjyyQ3SC8mNn6y6wPEQ8rcy63rJ3mmejnNXkHG1D
    qsyjTVIO7HyCohmmAvAqwPinJxw4qd38akrMsZuxKsubOLvlzmZ2QRGCzcg9wEpH
    wLxuA7Oq9rVO8LoWyb9E65AZcpjA1yLwvD55vkUunBn8mqVG6Hy8RNNl3lhLoLji
    gwAUjVmKXVwJJOd4uaPua8LJKdwcjegx6RLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244555; bh=o2OpnnV79f
    wPkItyp2DBUFos482R5Z/eZPm6rh0kybE=; b=cB31Szua8TRWgA1ttkQ1lB7qnO
    xH45lwyvAGiw0NgEhtW9dlu4NtQZLJgCsx+2nztZeps+29Pfq2ZfpkexpjL470lm
    jVvNnl7EGv6pv3QWRUX4IBW1uQPOkBh8VsvP0wXqGDvoEv6YU01oIBjJCrIr8dmg
    V28qBLB1hVDVbCmy+3E8zvqrL5/BXpEex/IjQa+Wcw21+qNIEw1EVBIQfNiY55W6
    KUGGWtaosQqisb50Jp/XCrhagXC010bYb/a259Lxm6BJLS/4BY8fYDvOSWfEXP8o
    IFfa7ababkPXUCvHv2HZT1WTiAhxhHZyqKh3eJ8OGvDPcD9wdjj6Q9CqlxBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QeLrI6xv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QeLrI6xv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMIX8BPAKxd8Y67IQr19XhCOzyFqKTaTYoavGpBZBAgiQfFIbmtaATxaZ9B/e7YVj7hWbTl+JCPemOSjVSU6z4DXqHQUuHYfZ3a/4pHd0BTWWNqKZac
    MAqO9TGl1kb/mU+p3EzlD8NgVwMYnOmAU/4XzBCH3VbAqZXRNgwk8S5WRmj8dF1dydIj3AfFgRX6xDrOOGUiEX2cDafkoWKu841LhEJhMOqtKAk1P1rynVX6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=yMhMjlubAAAA:8
    a=sFSi5EiQHAt6g1ozJDwA:9 a=wPNLvfGTeEIA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeDID3I (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:29:08 -0400
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:20813
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754603AbeDIAWF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 014/161] xprtrdma: Fix backchannel allocation
 of extra rpcrdma_reps
Thread-Topic: [PATCH AUTOSEL for 4.14 014/161] xprtrdma: Fix backchannel
 allocation of extra rpcrdma_reps
Thread-Index: AQHTz5h6PyQH7vH7p0SUxOsDSvjPDA==
Date: Mon, 9 Apr 2018 00:19:52 +0000
Message-ID: <20180409001936.162706-14-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:uQGhCoJ4ap/u28TqWvheY58FqQFVCWkJscILOk7kYXldDcoKllB/IeVPvvAqZSITT3Dxqr978BlLkqrkiIMr2EJhLjIYHDSJSiaWIgBFfaIYgJwzG6MiZj+BE9mkFZPXPOHoKz6wncDLb4XhjkGkyXUhbuOgrJNVDBiiHD6+TCjJmbKnzyQbr3lxIsQGBnr/Vl6+oFg3Nn9PpIiTtKXUcn3CWFrTn2ys9GkcF0tMuZAnlrY2mmA/n+/lzWpC2GTx;20:Liw1nK8PaCa611nOL/XteDf8VeMrVeSkE/Um6rzclEtqdam+6HMMP7/avLjMWb0P8Ypj5ic1Zgq5y+LeGZHQ2NANCRFFlajRUua+NASD/JoTKHWC4MiEEUn5n7sZNMBT1UPnbTgwTAs9WNVxA1QZcTy5EgzJUumqJClNfsaLYOs=
X-MS-Office365-Filtering-Correlation-Id: 0d8fc837-1172-4908-e7df-08d59dafeb4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125954341577D02207C1BC6FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YfQBk3TeRHjh7RFuXOXwzN8omvXzlpQhkOra6SM5Rl+ApwcWZiXrtNClIKypJUaxfWlaqkpS9ODiqc/Hw0Rje5VOTWKBorQiKoRAd+pes9PiLAvTy2SQyfGelHfCyQ4cTepkdhkiLYlBMPfIc5+3VPNR7pUo6+pv86q30140Wt+YnnNjxZhdJ3fUm/Gl/ELCAwMmf169fFvnnOiWxdQmt+IHcGYUXzoF0GLA9KchVoozHUiyt7mAQT/V4KeqyU6umftY6CUhQfPBvBpMkpKEeKMXq/Riv0ZgeEgnXXQ6C+o9HxK59wBAri8RsDyW5g/Qx+JT7Nm2eRgllIQQzaevTqqI6csW4u3tqPL6VTkIsNdaFhXpAhnO9WtjG2BNVJam81at6nWt6uJz9XAC/Y1AVT/DCKUOGnRsf3cAqarMILw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fc837-1172-4908-e7df-08d59dafeb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:52.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 823a781ec89c..25e3602aa41f 100644
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
index 9e8e1de19b2e..97b9d4f671ac 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -951,10 +951,17 @@ rpcrdma_create_req(struct rpcrdma_xprt *r_xprt)
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
@@ -979,12 +986,18 @@ rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt)
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
@@ -1027,17 +1040,10 @@ rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
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
 	return 0;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdm=
a.h
index e26a97d2f922..fcb0b3227ee1 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -550,8 +550,8 @@ int rpcrdma_ep_post_recv(struct rpcrdma_ia *, struct rp=
crdma_rep *);
  * Buffer calls - xprtrdma/verbs.c
  */
 struct rpcrdma_req *rpcrdma_create_req(struct rpcrdma_xprt *);
-struct rpcrdma_rep *rpcrdma_create_rep(struct rpcrdma_xprt *);
 void rpcrdma_destroy_req(struct rpcrdma_req *);
+int rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);
 void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);
=20
--=20
2.15.1
