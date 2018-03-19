Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496206-2-16264125720759326431
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
    t=1521496205; b=GhTT3jsdqJ2+gCvxEqjo3kcBPHfQB4fMriAx9NWwKT0Rzmv
    kkh0HqhbZPP2yEeqyjuSmGLIRMtQG+BQ8VaSQP0niQtcXYo2WjfqLB6GC7QjuHr3
    v3jkyhCU8VEgBBl4ccz4pvqshwJJbVXo3OIzt/KxTIUftE/TZXLP9EfM2rFFWkW6
    avYLdDnqcMBhwPGIyTwkwljXQFdkZo3UUk2r3iVKXOgL2cozzztMetsQzhwUbm7o
    GS8lBhF/7Y+frvOo17uxPcm8/91fAc3TLPpQZtO05aCqpkZSyeHdOoRvhT6UoiR8
    sniFPkfJYF9QgB8KCWJCKaeWaDV+payJT1XNUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496205; bh=p2WV7f
    7XPoFOdXehKK8+efAoqiR0Tdkp6tKKh2eeYc4=; b=MVC+JJpjPH2l5yqfjyJk8B
    RUwe2n/pcJn3IIQO/B1MuS7QYhjXUdSb6zpASNi2p/xMKrYk/AKn1eS6+sOIbcdw
    UNai1F8x2NA4Z7pGf7wjecfBM1nZFR6mqkox3ZJFsBCwD0LXHW25zzEjMV/s3/8L
    JqJgSkMZB+flwmu4xdoijM8NTXH3Zkl6LW7+9rzbdZ1hbvnAuGDQ2syZ7QpLbF6C
    JCFx/8ZCEWY+lFbJfAkgMe2jt0mnzbMI/Bzln1UjDMMqNXPV5zeD1X5UloFWX7iT
    MUpWAjwVqvlxkJ39sx1zV73aA6JsiGmjA4BW6NFKU5yspgc2dkMzqVEginjEfIHg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eu9ils/y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleelfeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eu9ils/y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleelfeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970019AbeCSVuB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:50:01 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964900AbeCSP6I (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 008/281] NFSv4.1: RECLAIM_COMPLETE must handle
 NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Topic: [PATCH AUTOSEL for 4.9 008/281] NFSv4.1: RECLAIM_COMPLETE must
 handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Thread-Index: AQHTv5sN0jdg5OLQS02TYqsEj1fbmA==
Date: Mon, 19 Mar 2018 15:57:58 +0000
Message-ID: <20180319155742.13731-8-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:VdTQ2WVyUvYFaHhKxzkdKgxhz7d8NLYZyVAd/b8/GI8rwJTlKcgEY9G+kydQ0o4mDv+/0CtPHl85ys947j8dmbv6qsGTbxB0yGBHH2WqNBjxOtiWRHv1Kvuv4GkOGRNQ0ZMgDw5WlXTaA8PNCQcIm4aCHKKaBgMDXFr/NHJ7DYcFgcXYpvwStDvg3VqJneLzKN0pb+entEi5UEBgStSbDWSOwS6i2MZsuPE1HfZHZAZ0LsXVA5Zur/1y99hiJl1q;20:vXWpd0d5CCkdo90sNjlJU0pIl3nJIZbXU13bv203+a/XP0jFlYzWQ+sMrGOTp/wto9YsBkmWovXn8yPCfg/EM1a4YvyADQLov/dup9HCcn8WQbPOMdHDdYrkzdrDe3Dfer/wlMgviAD3D37/mEFAhNjd0YLKu5uTyC70NirUt+g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33d9cfa0-e4b7-4ced-f034-08d58db22fd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933DC64014BE5FEE150F61FFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(15760500003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: cUQ/JZ0UAmFhlteCo3p5357mskhCPvlTHhgzcrC5YQmXNPs4J27JfG/ctRiW5+n6BKTAgE0kf62CaKITfOvYWOcYIsZC9IrWJR/Ox5Yc11D5P1jREUpYVm37CmtioCn+X6kTklaitMIW2EXDDrwjQeFV2d4VjUBSyJit3Ych3I61EYfwN2ceVDGu2I7zPSKx6BFqPkWzciURZHkfVrwsCHss4tuHpDwkAFZr5+tukaTqNdkHdGMzwTpzDSwnP82dwjU5FELlINZthSutpYZcXjz95FYQWwxFwmtaWG/CXfZrwnpMl9gNJA6NC9q59U6P0t7aP/EWB8pD5spHjpTvuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d9cfa0-e4b7-4ced-f034-08d58db22fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:58.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 4638654e26f3..d0d2a5e980aa 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8173,6 +8173,12 @@ static int nfs41_reclaim_complete_handle_errors(stru=
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
@@ -8251,7 +8257,6 @@ static int nfs41_proc_reclaim_complete(struct nfs_cli=
ent *clp,
 	if (status =3D=3D 0)
 		status =3D task->tk_status;
 	rpc_put_task(task);
-	return 0;
 out:
 	dprintk("<-- %s status=3D%d\n", __func__, status);
 	return status;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 71deeae6eefd..0bb0e620cf42 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1637,13 +1637,14 @@ static void nfs4_state_start_reclaim_reboot(struct =
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
@@ -1690,13 +1691,16 @@ static void nfs4_state_end_reclaim_reboot(struct nf=
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
 static void nfs4_state_start_reclaim_nograce(struct nfs_client *clp)
--=20
2.14.1
