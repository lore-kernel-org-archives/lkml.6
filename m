Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481037-2-15113939357798141700
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
    t=1521481037; b=YwW44gtl4Mysc4UCmb0M1eco5GJ3O17ZRkbA2VUizVoWyXA
    xyUS5UaegajB5gnAVydMXa8a251dlOJ/TYxu953ry5y57hMNvzeZ4SyN5D6PhgnJ
    j2oHgZ5/NQ5jK+uVnQtoAcXl1TdYxUvLWADSYiTDTy00FB6Aby8bHdJjd6w5rh3w
    2crens1Iv3h2fI8360j6cNgmA6XgnkCiD/fLAFmIVKMgjbr2QsZaAes1hYuVKkmC
    /kaY1Z0Zmas7bK4u0cI8vdHsA5eksMG2cAztE2vaqeBZ+RUR5tBR6p+kYx3b9cfG
    Rw/+NBSdwYi1e8yi3tEQnd2kEDZ4zpGpTbdAtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481037; bh=hcVc0f
    MrmvZXs0zhGJp9qNjT/FLPlzUzrkZYx2OlQS4=; b=mR9YaP56SVH0TbYANanrET
    Si/+zhrYDL7SWUJdrTj9DYsN7nFWUpnayMtvYakUwZ72ESpP+wzjxgjzrTeG+g/O
    RmXwUy9Qg50J9cizyhdfwiIINFeihrL+4huUy1VBh+vutwIoyb7RnSKACA5ThPh+
    4RQH2nas4dRgx54nRSxX5DlqSmG33T0A5KvAA7W+ojgcIf8AC4rmSK/H6JbtD4F4
    uOXjk00B0iwdks1N8BjM+IPspC6WUlLjf8IlKxidSKLx/w9au7rVGbYIzftbGp6B
    hEjMDLc2v7scpuow+HHwDBvUmPU4+5x7TmTCnJ69c7t9C5JpI8qbjshgvzacNERQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PvbPYiW5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleekheenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PvbPYiW5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleekheenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967483AbeCSRhM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:37:12 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965981AbeCSQGo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 005/167] NFSv4.1: RECLAIM_COMPLETE must handle
 NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Topic: [PATCH AUTOSEL for 4.4 005/167] NFSv4.1: RECLAIM_COMPLETE must
 handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Index: AQHTv5wX5g2HFNt8kki2PiSNsUUT9g==
Date: Mon, 19 Mar 2018 16:05:25 +0000
Message-ID: <20180319160513.16384-5-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:OYhV3ceEgSYs0QJ5QHU9NO+EYhlx2zv61AtONcLPquoY+xjcWs9luC5VhfDNedDfu/yVixUV9h635boPTTJIawbgTGAZ3CC4oTXScVMI4kqogD7QSB6cQqxZV47yCAmr2vgWM6UD98yJdWYqBy3fr8idnfMNpd5Se6gYkxndQOfam7XHNv3Z88MPRYyePGh7EQosIMZk8WHpZ12kTy33EQN3cj5mSklxDa96+bJTKPUQJ0no9+9rXvBEGVfSWLzt;20:aCsO+C3sIvA/DkH0HLOyCkQLeu1J1u7fefPOPpBKWaPJgeAMOMzaEeCtI/7zbYj3V6AlB2mYTrgUxGjV0lbZaFeqHG9OR2vPfEPJ/+O2z7O9u+f8F6g+uk9cd1SHlptXoV1AGFuA4IStIRS+tuwAQhCep93yZZ/n3fg+MtrNoJ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 045b5f5b-b634-4911-e5df-08d58db3676e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920C1F2A55199F1973FBC61FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(15760500003)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2QYVhF8D2J7foJrRB7/441F+m7a/HR9DdUjqEWjqDnBi1GxPt77fglqrn3iIlF7R6uXubaXPOFjsKrwsVIpxyBhCSUg3jwFt4QVuixCnzCYt2zid6V+0ORdY0PQQ0Bz25tSDzHXru4lQdn9MrDBEDjF909OLl61wzxb+PfReoE8qlSt+CSsG/xUBfA0qGS3v4NyO2PckuwvaK5ye+6OQaf6NUFlttPiTWpmZHFt0VxLb/fQK22FkxYnvU8cwwp5y6fKdde9BWMtCDnnuHKmEVyQWHw5ZON9mG/tRwVxrew8b36PE7ygUMs9IrgXkpbb6VdxDVIWz2UwaKbaYOsgVpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045b5f5b-b634-4911-e5df-08d58db3676e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:25.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 8ef6f70c9e25..bcfddfc7a1f4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7670,6 +7670,12 @@ static int nfs41_reclaim_complete_handle_errors(stru=
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
@@ -7748,7 +7754,6 @@ static int nfs41_proc_reclaim_complete(struct nfs_cli=
ent *clp,
 	if (status =3D=3D 0)
 		status =3D task->tk_status;
 	rpc_put_task(task);
-	return 0;
 out:
 	dprintk("<-- %s status=3D%d\n", __func__, status);
 	return status;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a0b219ff74d..83fba40396ae 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1593,13 +1593,14 @@ static void nfs4_state_start_reclaim_reboot(struct =
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
@@ -1646,13 +1647,16 @@ static void nfs4_state_end_reclaim_reboot(struct nf=
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
