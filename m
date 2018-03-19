Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478478-2-9056027293312791861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521478477; b=Lecht3sa0uH7vGSJMAf8f1/Ee33gZPNxDO0/Gp/GZW4Lsjk
    cxXAeNzLySDLLRM3XzlURBU7oT4lN3HQlSB5iUDkSu296jQ7HM8guCLQnc+QUw7s
    4k5QMMD1WbDnbeW/bhu4gnGowBi9U08j7PVQVQNs5piSkh2DuGJrvh0DZKwGiDZO
    /lUzt2YKdZYLYlAHzyDKfYNJ2822zCv/Phn3nu94fAnJAqr2ti/LLkG+oZKzLAkL
    /8P7opKKW2CRBEcYA/pPdsvY2SawksAmNpazYP5S7bnsD/+FmktB0lkiYhn9If1q
    0XxFjIsz6KWIUGtfgy1pH3gRcXAuJF1OX89k9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1521478477; bh=iFOdDdlWiVGL+0mLpQ26KKnsWi
    Vn0QijRKLOsBT+kAM=; b=vlO5GIJj5EHPj7nEbtDYh8cpH1e54Bb1BDiUWz/Ci9
    dn+ch1IIpxFil7vTh3mdNM6BwWgPnmwly08ewuerhtbiC82tp0RECzHJ3B490gHl
    LWiU4XpVrjwmksrvLD6z9/r4zaEGpZdVDNdNehrEE8UkCN+3t13EPgv33MjYCgtI
    yGNfQDCfNM4TsGNwd1K1TN21ao5Mo/IVYnSj2tRj6+21PFGJw7C5Az/fmQ4GCed3
    rcrgG/GcFheOenAB6hPeCa4K6E5EFYAbFi4ZqCjv0f2ecyHV/3Vrm6KC0Lmnm5iG
    hE70OFfvnaXiV/Sv2qwLw+oMTbTs50bcjwwtoq2MPspg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DxZ02oOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekvdehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DxZ02oOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekvdehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967572AbeCSQyY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:54:24 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:3838
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934084AbeCSQLl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 001/102] NFSv4.1: RECLAIM_COMPLETE must
 handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Topic: [PATCH AUTOSEL for 3.18 001/102] NFSv4.1: RECLAIM_COMPLETE must
 handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Index: AQHTv5zt2nqhxHMnbUuJ3iCxCwoGLg==
Date: Mon, 19 Mar 2018 16:11:24 +0000
Message-ID: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:D9mvM6oV9EUn7dmqIUWgx8cX1zgagkXqAXJPpliXqX6/8cCRUKuC/FNCDsufJgIaWXhJ9JI7BfScBYu39V4Bft05dxfYZWmZRF97ih6i05OqB32SCTK5uA1/OJyPLzw8GbBl+MDQTCAKbz8G0dnWp2KXu38vVgX30z+7qKIeXUNdkAF0DuqWNYAMPOlisQUDKACaX62SrfZbLujkYld/iTYqwgdyjH1TsQBmmrH8oEUYLXFQCjHSt8Yeg8Zj+Jfy;20:KCJzWW0z28GjajrMi2MQqj2WamkOKNfrGYl74aJkbVlxaQAm8DXBZ5J9a1b0S26PYh6k70OWlHlf4jBRVojx7PCHbxw6X/1DP8H0zvCiNNvVrR0Wc+LPpG1JsGy7tkYDHbb4dvZWHELc1PvBVrK6i6gzgN9tozGrJaFcWfnuny0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96d30b20-69c4-4d1e-5f2e-08d58db4134b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080542E68FDC6F231657A56BFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(15760500003)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 74NxuK05Iaul32UsG5L3AE8+hYU+wdZkaczJUyXejkEATsuPTorTrZxgezNYGmAXeKwNbDWyRfWvBQgNwF9SHu5aRyFKQZseldoRAjt/atfoo4BBKybC9Dl4m8cBFSJLveGYIRr7txCoIIjuK+We9rx8b0mNmob1YULbGsYg6gyYiSWKUL44nmCEvVUyezQF8M6y6lyE3V4t5SHP2B7D/k1eviwGBxQsxsqqDjUuPfPocfpF9zU4oxjHC7B8U0eHMGl4hMqDtrbr+qzq16caYj4lnCImwYf5R52fYL7D4CI5tr5fjpf7pM26Ws1Vf2G8qqHrK3SLerrNr17TFaJXjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d30b20-69c4-4d1e-5f2e-08d58db4134b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:24.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 0048fdd06614a4ea088f9fcad11511956b795698 ]

If the server returns NFS4ERR_CONN_NOT_BOUND_TO_SESSION because we
are trunking, then RECLAIM_COMPLETE must handle that by calling
nfs4_schedule_session_recovery() and then retrying.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4proc.c  |  7 ++++++-
 fs/nfs/nfs4state.c | 10 +++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f7957690ff20..321044c183f5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7429,6 +7429,12 @@ static int nfs41_reclaim_complete_handle_errors(stru=
ct rpc_task *task, struct nf
 		/* fall through */
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		return -EAGAIN;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		nfs4_schedule_session_recovery(clp->cl_session,
+				task->tk_status);
+		break;
 	default:
 		nfs4_schedule_lease_recovery(clp);
 	}
@@ -7507,7 +7513,6 @@ static int nfs41_proc_reclaim_complete(struct nfs_cli=
ent *clp,
 	if (status =3D=3D 0)
 		status =3D task->tk_status;
 	rpc_put_task(task);
-	return 0;
 out:
 	dprintk("<-- %s status=3D%d\n", __func__, status);
 	return status;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f471662c0a1f..972992b36660 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1563,13 +1563,14 @@ static void nfs4_state_start_reclaim_reboot(struct =
nfs_client *clp)
 	nfs4_state_mark_reclaim_helper(clp, nfs4_state_mark_reclaim_reboot);
 }
=20
-static void nfs4_reclaim_complete(struct nfs_client *clp,
+static int nfs4_reclaim_complete(struct nfs_client *clp,
 				 const struct nfs4_state_recovery_ops *ops,
 				 struct rpc_cred *cred)
 {
 	/* Notify the server we're done reclaiming our state */
 	if (ops->reclaim_complete)
-		(void)ops->reclaim_complete(clp, cred);
+		return ops->reclaim_complete(clp, cred);
+	return 0;
 }
=20
 static void nfs4_clear_reclaim_server(struct nfs_server *server)
@@ -1616,13 +1617,16 @@ static void nfs4_state_end_reclaim_reboot(struct nf=
s_client *clp)
 {
 	const struct nfs4_state_recovery_ops *ops;
 	struct rpc_cred *cred;
+	int err;
=20
 	if (!nfs4_state_clear_reclaim_reboot(clp))
 		return;
 	ops =3D clp->cl_mvops->reboot_recovery_ops;
 	cred =3D nfs4_get_clid_cred(clp);
-	nfs4_reclaim_complete(clp, ops, cred);
+	err =3D nfs4_reclaim_complete(clp, ops, cred);
 	put_rpccred(cred);
+	if (err =3D=3D -NFS4ERR_CONN_NOT_BOUND_TO_SESSION)
+		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
 }
=20
 static void nfs_delegation_clear_all(struct nfs_client *clp)
--=20
2.14.1
