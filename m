Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244641-2-14118494020813179018
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
    1523244640; b=ApYKlw2ee50yKJSHZ9DnounlzkZCWtLyPJsVfyEzMJ1VV6rIEC
    U5fvuWRS6um+dQjcVYSgIR7bSRvCKQqayYSulLlZaUn0lWsSHu+z6YICRfwEEm31
    Wnl9dd5+seTx7mUfalJf8VzwMfOdVZbUyrV5Be7ND+R0QuPwPD1h98PWVKQ99N81
    SxYaeVtInacbjwZoC3WvvquSfcnfdWIYISqJGnhEBN4LjK82WTQZ67zypE8zwepp
    +4wzrF+XVqqGlPiDQc34ETlGF1ocWIJgA0yczHdSW9/MhtsM0fhM+WaWyhrK/poA
    xikNuNlEtUcJk/qQaDWelY8Qu3QeP9KomV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244640; bh=QkqnkgAx4E
    Qd2ib5lPWy7GkupD24uc7HLvxuUbqgMu0=; b=u4N+7pQU/qq91kn37qTHqTVUvl
    /HMQ4pRg37BSxYxyLbYDOr9Hu18tCaAoihIDrSF+SBZM2jB1LP7C4XP/1d9+kPCZ
    GQupHy9utHgaGXSecz7JfqKaRHqLmYrkjovkfwJ7j2IK1syhUHQMQxnxR7glVOmV
    xLNCH9CTio/52yxVwN7R1zmTZTZ6p+1iYwZci6Qs4xV+/YmJCYrk0/Qc15WJXmaU
    crlNE3/mS2F6SeD6psGsEQzpxLt5J9SRahBbbs6b0ZhsFGYIuzPPJhoOIfgcx0Zh
    DPGfR1f/4f12OEmstm/4WtKYsmWxqeTvzyOFVHYA6Tbv8A2yWqcmZgGzFNPQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mUW7IseE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mUW7IseE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEQjyrnoNfO26VFMBJcn/S4hnNug69Gd/ndZftaBW5nqCMycNh3sTgVDSeMj78eYoz8ZnMDvF0sv3WqP1wS3Way9LyG17mYBWwhKqU8wQMIuu+01IRTr
    TMkt8vNvMQexqlWBXL+CYjCWdjXoCLLR2hr4idocI1c+XLVfKQraU8dEe2NIb+pA7SsTTMKEtvOKplb4z1G+CjA/rcp7Fk+U5hqBRsTcycAP6+fs5eb4qqKz
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=z-L-gfZlSAspNxnL2BcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeDIDa3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:30:29 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754558AbeDIAV6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 003/161] NFSv4: always set NFS_LOCK_LOST when
 a lock is lost.
Thread-Topic: [PATCH AUTOSEL for 4.14 003/161] NFSv4: always set NFS_LOCK_LOST
 when a lock is lost.
Thread-Index: AQHTz5h1FaLY5hggrkyPIdbAu9fXTQ==
Date: Mon, 9 Apr 2018 00:19:43 +0000
Message-ID: <20180409001936.162706-3-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:IrkQNjM5IZnv2T6qRTk0De9DPJywnxN/S+2PmlITupOtCCAwytIyrV68apWwtSwSL7zpcbCqZIGRY3qSzkFZ/iqKvjEMqT8KDBPm60Indw03dQRCLGKARTLr1XVc+z+LSiMBBwv+5gXl94BRH5xqKEb5sgUYteQaalOeVZTVMnm2sSh1aEbVpJh/p4mBwJgiCHi8yhQUVOa/GsQ2aGmNjNyKcO6RSa2UHLj+9F5t3q8hYKI0oXUFrTsffeK4HmVB;20:buud7N+aRN+1gNvrhs4TgKypVA8YCt6to/0/UhI9o2jDmqspY35gYH1qZ/nrRe+XGa0hlIAYqv9xo708WiKEgzTmylTy73JfOHEm3/QJCSHJX1ojgGGqiEpnR1AZY2FC0NrBYhs+0/uu+1iv+wSeSTBi9Z9GZhkwg4bAAi/5AQI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8e67af1-406b-49b6-47f0-08d59dafe699
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936EEA021A8295C3F117050FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: J3vfU/BpNG1kWYfqK2LgMGAXTpusdmYdIEmuM1dkbI/MgU7jBEGHI4kPZGQWokl5bBwjPM3c+ogprGbExCxRBBrIFbuohxeXuXMS9Wz0Ryt7sv43ugPC3P0dmBZVfwrTnRdxJy9gKqpIhaEmI+r1kn+mIf10M1ZiDYA6eblHhdU7J+OsAbqVrNqjlCKPgiuxdjIOxsVi6HUrCtdC49JZTrxKbWjdAdtEaVrFA83ZB3E3QKcc8zliiLb8LlieMsYdUcKV8l3B3iTxKpOMyapGqhRFzfTC5b0NtmnsspPosd1pexi7O4EOAnZ0Hgfmofd01GjYfu8wcKa9hHevlnHWwUGVNh0IlIwsp/P7RKGxKy/PGBw+Wih3K1RXStVHxb353awbVWHG04DBl9k0uxNr5WzjyUvrlqnLe/i6exd+r5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e67af1-406b-49b6-47f0-08d59dafe699
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:43.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 2241d52710f7..ae8f43d270d6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1885,7 +1885,7 @@ static int nfs4_open_reclaim(struct nfs4_state_owner =
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
@@ -1932,7 +1932,11 @@ static int nfs4_handle_delegation_recall_error(struc=
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
@@ -1968,7 +1972,7 @@ int nfs4_open_delegation_recall(struct nfs_open_conte=
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
@@ -6595,7 +6599,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl,=
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
index 0378e2257ca7..45873ed92057 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1447,6 +1447,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *stat=
e, const struct nfs4_state_
 	struct inode *inode =3D state->inode;
 	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status =3D 0;
 	struct file_lock_context *flctx =3D inode->i_flctx;
 	struct list_head *list;
@@ -1487,7 +1488,9 @@ restart:
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
