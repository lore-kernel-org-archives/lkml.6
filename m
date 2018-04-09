Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233014-2-14767862655978453684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233013; b=QU/RPLtKbTnva5m5m20xTKk59zyY0Q+YNO77WMG2ja6nDkv/ut
    MuG61pKd9W4FYOCZz6kM/FwqsrTVYo8XK4zlorMawjhjsEXr7zujysCD1ya9OYrm
    OmD5Lh2Myzhs/og8Ko9CoGmMiseLcft0Ad6Maj8nduB06KDKCFhIhgNc+SNmLnLX
    jC8HEGSy8CybXrEm2l/rDz/8Hg3Vp0B2S4krv86lUZ5DnKlg7Uh87Bm1qCDI8WN/
    lTkjT+rNFSi7N1/5jcQ7YWZJg7EieT/kSK/wOA21rUnSPtNPRB2JHFy15Sx1vYil
    8ltvnGIQysaor7QgLhpir21qIKDVoVERRjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233013; bh=n0rXqjul+s
    TmFZct//k4dT+9U+O18GIqO2KZT7SZdUo=; b=ShiafX1rlv4X4bpHiYeNT707RO
    Sz1hB2wM2zaZzMA2jlxwS3/ADbfAbNmqZ28vxIK2YjHHWj1eOQVXzVQy9pjEuAUy
    dKiktHCtellwbEEiyd2xPEsBSqmZBU/mmuWe/wLnRKg/6JwcCF7UAvAcSgUSoV91
    8eCN3lswRW7OND6gV5EqvUVW6D7rGjKvoQPj1xNCaWTKk96nR1Z/F9kJHbTtdphE
    v1jtTcwQalDbBBymLTsraYTyL3wLAhlPSBKW+89556ZXB5YzHCsnBNr5m5JjySMu
    7UobHlfLC+RTG3EyKPBZllvpXKNx1vvlwDvqS2AgsJIefaZgBTTLXxuJaudA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2XqFksc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2XqFksc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBLmdXxD237QinPLx4bpS7bOj1bgtQn8T9eSw10CHNWq833sJEwlzEiFYaHFK2Mx6y8JLwvasY4GmsK+sDAox2w6GtG59+V48gixZ5ewYYNldPIj74zX
    yLEz/MTkkK2npqIFH0MDrn1OwKicWyo0lO2HQ5H1K8mT3jrOMyV5fV3w6QHHdWHMOzamGL7DLiUooc9/OiMdIODAA5j0W5MDSdP+XWJ+idlo5pw+4KArrazk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=z-L-gfZlSAspNxnL2BcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDIAQu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:50 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeDIAQs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 003/189] NFSv4: always set NFS_LOCK_LOST when
 a lock is lost.
Thread-Topic: [PATCH AUTOSEL for 4.15 003/189] NFSv4: always set NFS_LOCK_LOST
 when a lock is lost.
Thread-Index: AQHTz5gLR8pK3fbZL0msNpHOo4sBvg==
Date: Mon, 9 Apr 2018 00:16:45 +0000
Message-ID: <20180409001637.162453-3-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:tkZNka376nX8FB1MIp6n2M1SLXCqDv5LX58aDlOYhoEWOR3bZHhnnLbHYbo7EZ5CPGSdU4ZDbV6Y1/W7mVtphbawvKXIZuQWAbPO/Jc14FMnzlctrul6EEn1CE5XZIPqAT+VHjIJFHF8IFgDGwVyUCQxN0jGxaiI6YLbNObY2m3UpKs6aPo/KVy+HfBg5PMJJDPRLx30JWz5LXpGtkiNXVqN3nq+982BPPJBJO1ydgIlP0eS6zCbd5j/gB3ZOFcZ;20:wfQf56/Ar6y5PFyRUxRSgicviplbG0MYhwUpxVwDT0TOf8iz9el8GIboWriPQAq6JmZVqzhX40tPhSzbR34YZJe21cog0uSMn/F3A24EbfGKtFg1JnT0+7kRN8uO4TNmNUsPSXrMVr+lrot8zlcNAD7MXx77+dvSeRrDIihAoT0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: cad8de84-f051-4902-8c8d-08d59daf2e06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968DCC3023E4042F68E2421FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iha1k1aaE3YUClobRCkQbGxgZWYmmlJK0DxgPX8CQNegUvfrt9K/eJW0u+11GpSJsLPsJAO3EwsqeKjv0X5J9qRfDhd3XPM0r5WQsMNFJYcXpCEqT7PlP9yzxyfNIxIMAFM+oKkWzjitH1Z4AgzIj8nDK5KHnhTPho/D+JKhvWD/Ak72TWKYiZYZp7kwHqzz34W6q7olVf6tNrkqG4N8fW+MH9WDjEx+C+20WPrnf/IojpAhvmLtZ26rFxVg0Q046yE0Sx6MudGu0WFHhuMQzq+hpo7zYG58b3+dlso7ygllK31gduuWL+0O/usLanEKT8x3FhAefks6/uzgnHRioE5GAV5x1pxO9ddb6ncEXVDArctDXW9arzaG7Gsc+CAJOSNnmVecq+QqDJ22duWf4+nrU5XXnwTuJ55o/fsNYSg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad8de84-f051-4902-8c8d-08d59daf2e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:45.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
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
index 56fa5a16e097..083802f7a1e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2019,7 +2019,7 @@ static int nfs4_open_reclaim(struct nfs4_state_owner =
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
@@ -2066,7 +2066,11 @@ static int nfs4_handle_delegation_recall_error(struc=
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
@@ -2102,7 +2106,7 @@ int nfs4_open_delegation_recall(struct nfs_open_conte=
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
@@ -6739,7 +6743,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl,=
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
index e4f4a09ed9f4..91a4d4eeb235 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1482,6 +1482,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *stat=
e, const struct nfs4_state_
 	struct inode *inode =3D state->inode;
 	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status =3D 0;
 	struct file_lock_context *flctx =3D inode->i_flctx;
 	struct list_head *list;
@@ -1522,7 +1523,9 @@ restart:
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
