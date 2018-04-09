Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236628-2-4129655103843627304
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
    1523236627; b=k+6o2cuWiRF1fmHsQOSyTNxSrMrbFz98wEQZdAIEE5Cg2sh0bk
    HHJEOxylgzEcIIo15O/rvVllZ409Wsq/0eRjiHFP4/ljlfUaPbUjfvbpOLIXPJmo
    4v1gS8DdM6XPQSGPXT+opUTOEEKfBExP47XTR+FKZcg+o2fSvoWWdM3uHiGdLGcq
    yuvqYh3a0LXqa2PSpgTPZsfsGrplMVw+UWD9UgWBBJHWBxVrijkm6aENa7BNt2is
    hx8Hny6uKptZOH5LTtb1sKzsV2oOFWlpntleKkHeDgmDRFV/lFi0k0v7H827c952
    ZTYloNdBuv1PQ1ZIvmmmCGAWJ4r9MFupHogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236627; bh=6TvZeqAWM3
    wW0hLhdXegnVu9l8x4poxpEdq8ySZtkII=; b=eMH9eZCZEDzuu5DVLwV74TqXwD
    Lv3hRy9f5g+GEJyjW+92CLRdqynoS2C13ot9ZQlrnDJPxwLz7yTYICZnZahb7pNC
    hC+1ZnRWDiZB3w7ZbukBjn4j73sAykE8O8g3zk/iZj5s9rVle3SXhNE2Y2v7BL4X
    3vAKkX2Z94CMKMnHPMenSAX+pSU9rGN+8GygCsgVp03zP1ev/hSEYIrxBg4zZxfc
    KfI9Q0Ocy3Q1jRF4t8dUZ4jWmnuB5iUx4Ggzyb+g1ndhjiTMlnpM0fEqVPNVVOju
    RSZMcDl0SQ86YPBZ8hiXe1/M8eWJStcxdzKyG0C+B9uvFSWzXwRPW1kkWz2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h5xs//Rm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h5xs//Rm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNX1dRqp0lR57/QXpBNOtuw23sDKId5GJxvv6lJ/l58D5s5je0k5sowRLmM5taMuI62JoPKw8B2iiPytkbWsIeiB0Ft1hPSvn0fG08EuH2E46G+Wg1PU
    CwJO5L33HqgEQRnFrpWR0akL/GLU/quwu7T73v6uZ3nGLIi/dHrYHuT5IUV4ywSNxkbNp3lEy8J35VmNLHUBIU33fmM6dEQtQs/PWIt2MVR6S7Xg4Jda1j/I
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=z-L-gfZlSAspNxnL2BcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757137AbeDIBRD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:17:03 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:3232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932858AbeDIAhv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 106/162] NFSv4: always set NFS_LOCK_LOST when
 a lock is lost.
Thread-Topic: [PATCH AUTOSEL for 4.4 106/162] NFSv4: always set NFS_LOCK_LOST
 when a lock is lost.
Thread-Index: AQHTz5nDeGfBMX+iAk+wOuodu2NkjA==
Date: Mon, 9 Apr 2018 00:29:04 +0000
Message-ID: <20180409002738.163941-106-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:EGgBqr5k+00/7fkJlS78M8zpn8mPg6Rg9tAdmjX9by9H0fDjc7ASxNV8wbqggrrphVz0zjS+X+V8RPKdusS+6lXN/SLDvsFSy/96Q2za4fgxcsfWKoWaUw7Hw395JB9OiHc3Hf4taSCvpsEhk+RJ/t5aDMt6bcfJzHsvzzc9w3RCHY6yQPMgrJWdUZN/j6+n0amQV8vh7cyn6rEUY9a1IDmT1SfojSwyFnOG9Hj6GJW+4SAjtDlNWBD6Oom92NWP;20:rtgfBouUWr8hglpuiPJEI1G82SKohXaRs1hjgeQcGClgK56OQB7+VImFXy+2Gw90aZa3uYUEK2MVwQ0Vbpz8/15knPg+48TZ5M9ytc17mqYywrDdMaVtU/lpk/PDUOZS1N1hlWGESE0C2aZ+UyMyTtPSDKhH2GXqiSdKjm6kdFs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d941bc7c-3480-4a7e-360e-08d59db21de0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11101946F77A978FB4A6B289FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yaU1uMrKER4q8Ei/hxFCiZlKUIj/SJrU1yUD5rlzIb9s9+TBPzCiT8zVpmRqkyIzRgFY+BbEJY9Jw6XcVuL+UMHXguPr4sU8dW4bkXpEz8olyQPiWbfKKDpQIqqImLQ40KCR/8SJaUfKcxVbqTgd9xBwePc/L9vKeeE+Y2+mDZF5BeCjpHFTLHpdVL7OBlu3cAF4zXGxSxM1K+Nt+Mx9Y96P/VyWVyGSfw6Ey9gVsU5D/G0eOopYm7YZOLX8akrdu0j3LMGS16ppkp+/V8qzDc4NAmQDbaHpdZAg0DBPOsJ3S6AfYibQyHHWzH/F0ntrE1AE0NUCWKnwqJXmD9AmHAzw6Hx+x41JdGgwjci37EXi0tAMwTSkxxQBYp68z1Ora+SOtPiZlFx75lMURfe0Xskii+FRO9JYf0Szn8+iFr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d941bc7c-3480-4a7e-360e-08d59db21de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:04.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 8ef6f70c9e25..681b8c217a85 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1780,7 +1780,7 @@ static int nfs4_open_reclaim(struct nfs4_state_owner =
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
@@ -1827,7 +1827,11 @@ static int nfs4_handle_delegation_recall_error(struc=
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
@@ -1863,7 +1867,7 @@ int nfs4_open_delegation_recall(struct nfs_open_conte=
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
@@ -6151,7 +6155,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl,=
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
index 9a0b219ff74d..eef49200caa7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1386,6 +1386,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *stat=
e, const struct nfs4_state_
 	struct inode *inode =3D state->inode;
 	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status =3D 0;
 	struct file_lock_context *flctx =3D inode->i_flctx;
 	struct list_head *list;
@@ -1426,7 +1427,9 @@ restart:
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
