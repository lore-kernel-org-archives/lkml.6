Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239127-2-6660268514577339612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239126; b=ekC9Sh19dk612n0PhAtgBDVE36SXQ6hJOw9/4uIhv9V7U1uPL9
    ddcOBBz45CQWpbYRHhCcnjRsEsSlzf3p0d7BkPt3Q2vqK89RfxTPJvcfJTP+q7CP
    X+os5Bn4gyXwyoxZUhfzp4XpfmBAXwRgdEjRyELQnazt/Idn7mfvyIRYLOA7qCV7
    RqYmoLe+MWsGagkei7uW4Ed5Crzjg561sy/VwZ2UeIlKGYJZWSdrq82ryGmek1Sc
    Q2YuQLioJFmQfJDxT6JyU13kOqA4rI+e2l3xHRuBlgfbi5j1TdGKPiVYtHZ1T/N2
    Nsr4lrwLOgsvcLHuLB0Obqs4ENFKQfyx2I6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239126; bh=YOyHSLBolc
    Yf43Y5DmZDZx1p8hpySzGud9rk+xLUo6g=; b=dqOoL1TZ8jRZPjtkLk7F4LtcLs
    TAsLTjHnCn/b7d1+UrWt0zmyP+o5Y1+Q/vZugVEfi6nfBKJRfRzZ7UCidgbBm+E9
    FOirfsaWlDUUkb/qLZrNDJs7raUZS/4507Ac+eQM8UcCtXMJ9QhTLckDZv/ABl+w
    b6m4x52u6S8l0vvILGRFNNUpIDDnK97ps3VslVQadO/Fe/gwNewRc5fTbyi8wKbg
    6ploYGYDRbKF45v9E95z82cV1KftE2Gqw2inS7Nsh7gkH0TQ8oWIZ5XIeP+iBVS0
    hujCdI6M84ZyE6k6mHKKdH5Nfwkz5ncJ2QbI0/72CvZuLUMjeASzuWHVlW5g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWNm9V6i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWNm9V6i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDtReFIeAjXBHdkC+6GIvQ5T9sy0k4224gREKmsRJrGVFJuJD3/5POCJe5RYzS0AcU8xART2prXgbLuTWzTN0XsJMGVYY8jFR25UJaQVblZEZG8gEM35
    y6RO2OUaKv8y38zSMvahvZS7PuQvL6uGqAV0LS5P5m4xHHOuMgbd7UWb6OBzdXhZLPoWNmgMAeZ+G6ianmGzfJSoJlHmH7XY1bJIGAB9wf2VLmc17ZsjgUU9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=z-L-gfZlSAspNxnL2BcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeDIAcs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:48 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:38400
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755038AbeDIAcq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 212/293] NFSv4: always set NFS_LOCK_LOST when
 a lock is lost.
Thread-Topic: [PATCH AUTOSEL for 4.9 212/293] NFSv4: always set NFS_LOCK_LOST
 when a lock is lost.
Thread-Index: AQHTz5lJ+qSNkhrxikeN2/30S76ynQ==
Date: Mon, 9 Apr 2018 00:25:39 +0000
Message-ID: <20180409002239.163177-212-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:2VC6dOzdhZHDSnpXQtBuK1/xXljEzLxDSgPuGJU/lUYAs2/l4LEZiW5d0eyZcwEod13J9e+9qps3XyMl59BmsCn8yybVSohPtwgdlgfKvhrah7CuguNF0kbGkGXompJ4pvk+VXyN+2zfVVyYM2RaG1TWCt0bsLfxBfg7p2YNwqIv6le2cMRHxtt8QfaaRsi2f+4wcWCcmHvrfjexgLlAI2ck5ZY9QtkRHRXmk0D0UJ6Zekf3GZ1YQNt+8ktFbZlo;20:RNRxszPygwsjE5Eu/wE+x0A0EqkO03u/w2q+NLTbP5IrW5NMOG4Y7a8E8AP+Z8UEcbhYnq9HSDefU+l0kHUV0ObAD+KIxdrO+gNBrYl6dX5KN2d/3k9h0Agceex303qvp53F1zV+NW4HVbf5IXFf2yCWPJscPj1G6p9rEShVf4s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 168d585b-c4ac-4376-e6d4-08d59db16990
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080629EBF50FF8389B05E5ADFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r6eTuI55v3i0KOUJoqIjMSR6B/BkdTGfGu7OJsRHRVUFeHGk5sDYM0lRY0xj5XGe+MIbi3M483YJ8pgN3rufl9QQBCa58WMaNoxa2nSLtwMDXdWtzT8wasoM9EQcn9BZugt0SBRemP6THALM2CYtBzJa3tJEC2QnEnURjpRvZBV8bVqNZR+onxOTuCsgZkFUbMnF7VRrojAG4PJzSDoT8VyIqcFyLe/hl+g4o5DE/uQYup4wvvBiUX8PXuV97l0AEIwjET8dyfN5jjie19uAleK7t7A2Sj0P4YhVT8Xmqhpg1zh2B8rZxK/13wzbCboF95I8h3waiLfYGLodHvTlK5/DV3OZjS76tU/QV2FR7ed4O6yexblsWfPajc3JfKroQM3XAdGO3bM6KUO1EtbVVb9zhL02IVOk1SScEH1WTYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168d585b-c4ac-4376-e6d4-08d59db16990
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:39.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit dce2630c7da73b0634686bca557cc8945cc450c8 ]

There are 2 comments in the NFSv4 code which suggest that
SIGLOST should possibly be sent to a process.  In these
cases a lock has been lost.
The current practice is to set NFS_LOCK_LOST so that
read/write returns EIO when a lock is lost.
So change these comments to code when sets NFS_LOCK_LOST.

One case is when lock recovery after apparent server restart
fails with NFS4ERR_DENIED, NFS4ERR_RECLAIM_BAD, or
NFS4ERRO_RECLAIM_CONFLICT.  The other case is when a lock
attempt as part of lease recovery fails with NFS4ERR_DENIED.

In an ideal world, these should not happen.  However I have
a packet trace showing an NFSv4.1 session getting
NFS4ERR_BADSESSION after an extended network parition.  The
NFSv4.1 client treats this like server reboot until/unless
it get NFS4ERR_NO_GRACE, in which case it switches over to
"nograce" recovery mode.  In this network trace, the client
attempts to recover a lock and the server (incorrectly)
reports NFS4ERR_DENIED rather than NFS4ERR_NO_GRACE.  This
leads to the ineffective comment and the client then
continues to write using the OPEN stateid.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4proc.c  | 12 ++++++++----
 fs/nfs/nfs4state.c |  5 ++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4638654e26f3..883662d25714 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1934,7 +1934,7 @@ static int nfs4_open_reclaim(struct nfs4_state_owner =
*sp, struct nfs4_state *sta
 	return ret;
 }
=20
-static int nfs4_handle_delegation_recall_error(struct nfs_server *server, =
struct nfs4_state *state, const nfs4_stateid *stateid, int err)
+static int nfs4_handle_delegation_recall_error(struct nfs_server *server, =
struct nfs4_state *state, const nfs4_stateid *stateid, struct file_lock *fl=
, int err)
 {
 	switch (err) {
 		default:
@@ -1981,7 +1981,11 @@ static int nfs4_handle_delegation_recall_error(struc=
t nfs_server *server, struct
 			return -EAGAIN;
 		case -ENOMEM:
 		case -NFS4ERR_DENIED:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			if (fl) {
+				struct nfs4_lock_state *lsp =3D fl->fl_u.nfs4_fl.owner;
+				if (lsp)
+					set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
+			}
 			return 0;
 	}
 	return err;
@@ -2017,7 +2021,7 @@ int nfs4_open_delegation_recall(struct nfs_open_conte=
xt *ctx,
 		err =3D nfs4_open_recover_helper(opendata, FMODE_READ);
 	}
 	nfs4_opendata_put(opendata);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, NULL, =
err);
 }
=20
 static void nfs4_open_confirm_prepare(struct rpc_task *task, void *calldat=
a)
@@ -6493,7 +6497,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl,=
 struct nfs4_state *state,
 	if (err !=3D 0)
 		return err;
 	err =3D _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, er=
r);
 }
=20
 struct nfs_release_lockowner_data {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 71deeae6eefd..cfd1222ef303 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1429,6 +1429,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *stat=
e, const struct nfs4_state_
 	struct inode *inode =3D state->inode;
 	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status =3D 0;
 	struct file_lock_context *flctx =3D inode->i_flctx;
 	struct list_head *list;
@@ -1469,7 +1470,9 @@ restart:
 		case -NFS4ERR_DENIED:
 		case -NFS4ERR_RECLAIM_BAD:
 		case -NFS4ERR_RECLAIM_CONFLICT:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			lsp =3D fl->fl_u.nfs4_fl.owner;
+			if (lsp)
+				set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
 			status =3D 0;
 		}
 		spin_lock(&flctx->flc_lock);
--=20
2.15.1
