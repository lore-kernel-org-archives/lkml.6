Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237113-2-11327321689581830839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237112; b=Ou+zL+084LjvQwW88Mu0pQwADMxagZG3tEb4sZLMVq9tkOivUy
    vRxG79jQ/G3HYgL/86fCy3B+wfZQl6MLB8oC7mu2t8I6s95CzXSzLQgVAIaTuxnT
    uJNT665BTK0/fjns8Syw45xa6AkprUEdkIJOMd3ZQnJ/olOGZY+1Sjzc0f2JTcOT
    emJ7+2egUnEbtGADx0yKvE+5wT/erizqVAfXxjBS7mcbLYvoZV877Cd67Qs9mhaj
    1LL4OyuGzqdtK+Bijqs7sQegmaCc0Aa0qnRl11+SyWp5mngkJbLdI243+wbqOmb3
    8mxiBP0U7wkZWlaMW5x0jbVcWwIk7KMIJpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237112; bh=62ve8UCHSu
    bx+XO3c8ZMjx63RwJU6FBU5Hxf7mYT8nI=; b=SQFQgOKGHjuhsAorlZ2PpQfqGY
    C+JAG0XUFl5QbG8hd5KLGsipzK3otR6jKO2B5PQZyFHmX78E/Yv21+bO3FIp3kZJ
    RD0TVhtREO/8KLBIaey20mvPBrd9DmXT7Av1AaFXI4+c2+ADHogUlEnRNxcpx42j
    5kpYBMcXXiF/DDC4+qEvrKa/nLuyQnsgfG6It3359huh65d1dm3Gb8bnCZuPjRux
    M+6KOAQDJkVFU0OMS2SvLvBc026smtFxPuVVEdk050nmKW6zzI4TRDDEKnNSLNKh
    XOqU3RRPMTbn6XnpYvKJHvi9tSWgaGAxJazwWuad8VkRBqM61eAwMpbOi9nQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E3kddusI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E3kddusI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCYTDubG2P1DFAZ4k0GfCtdlnt94RptC892OsfldXwBR082pZl9WB9+q7TfEwXoobbyKSJjmnuS9MdmhAwpeBddtdWiHmxcw52724cf2vcq7RkUaJxIR
    ok44ET1PM2MKZMIN0+wAQPE9+LTliq1RBvSTj7xlAikubkmSEfCU9+yLjViZo5N3n1d2iZypjdcJoRL5z78my2WwFRkNhdVP5N++km1eEMaHK92wknkt7tLK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=Tway_pJnRvVg3gEtkSUA:9 a=wPNLvfGTeEIA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22 a=kLeBEu5l8tkQtVp4YdQK:22
    a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeDIBY4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:24:56 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932689AbeDIAgy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Ren <zren@suse.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 069/162] ocfs2: fix deadlock caused by
 recursive locking in xattr
Thread-Topic: [PATCH AUTOSEL for 4.4 069/162] ocfs2: fix deadlock caused by
 recursive locking in xattr
Thread-Index: AQHTz5mxawPyAQixBkGkq3QOAPkzrg==
Date: Mon, 9 Apr 2018 00:28:33 +0000
Message-ID: <20180409002738.163941-69-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:7VtEPgbJmYYMLhHyD92wlYI8/GEywhs51KtnsBRVq42n1tKNzXRFlVu+yAcHKfxjdwk/DpwDjifPjQKVSDKt0kJ9oWh+rFaFpnua8btFGB08JapCIG3FxnOKIePYX8z9010i7bjpU2H8Ty9sv5ocWIPQccqBvmsQDa0ClJ2f6W1KUwsPHIVGzmeZeA0+HkvhJWqwbC+u2VDm7ZJ1GDs9lP/9Y+xYthDyfIsRn6J7QLElQ+d+ttK7tNHVixQJITSe;20:TvZh++eM2A7w/ndSXfp/1GgVJo+PDxDuO+Jv86QCTxgCS+ishzhCpZGuOmGI4PdYuU9iSfkQi+soLKUpZtq3WW5+7M2+zhEapnj5Zn9pIh+eonswpx9wxkAjOTjK6hjCzOaCUu+X7CwbdynSPSHzgjGjhHxQEjc4KIynT2N8y68=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a135f996-bc78-402b-b601-08d59db1fb2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08851B38AAB67EFF09B1D00AFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(966005)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(6306002)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: siuS1Ls7RishtU3vL7fLAbZq73ey2yVAXxhy0JbwLHCcvAytTMNLzNfxTlPv1bmNmZrLTtig7zoI3vwNv5xYmLTXZzuU5mqL6CBhtoyYCABkwRYEQ/E4PY09bJHKi5t1ctdfa96uY04aY/+wVbDx7/qDRjVZAz2nJgMPm5nV1f0wgwywEpD5AGLcdavBM9xcil6xPTp4hNjeWn1IsTv2hPI1VCGuqR0QV4eB6N5dvFbQhYSGXUryou26SJv3XYmyKC4/2pXzUAr0W9xCzhVhC7Q6oTm9Ndiz0y0k5ORjO8AZTrUYZgUkT7E8BD3KfZJ1AIwFdpJphHfdSUISm1EbDAXFpPsRpqNv5qUFwjL9ejivQo2+InlN1lYZsj/g1JQ+GDxxyj5fC6qqp91PAAW04T4MXIxZFFJ+/+E06RM/Krw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a135f996-bc78-402b-b601-08d59db1fb2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:33.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Ren <zren@suse.com>

[ Upstream commit 8818efaaacb78c60a9d90c5705b6c99b75d7d442 ]

Another deadlock path caused by recursive locking is reported.  This
kind of issue was introduced since commit 743b5f1434f5 ("ocfs2: take
inode lock in ocfs2_iop_set/get_acl()").  Two deadlock paths have been
fixed by commit b891fa5024a9 ("ocfs2: fix deadlock issue when taking
inode lock at vfs entry points").  Yes, we intend to fix this kind of
case in incremental way, because it's hard to find out all possible
paths at once.

This one can be reproduced like this.  On node1, cp a large file from
home directory to ocfs2 mountpoint.  While on node2, run
setfacl/getfacl.  Both nodes will hang up there.  The backtraces:

On node1:
  __ocfs2_cluster_lock.isra.39+0x357/0x740 [ocfs2]
  ocfs2_inode_lock_full_nested+0x17d/0x840 [ocfs2]
  ocfs2_write_begin+0x43/0x1a0 [ocfs2]
  generic_perform_write+0xa9/0x180
  __generic_file_write_iter+0x1aa/0x1d0
  ocfs2_file_write_iter+0x4f4/0xb40 [ocfs2]
  __vfs_write+0xc3/0x130
  vfs_write+0xb1/0x1a0
  SyS_write+0x46/0xa0

On node2:
  __ocfs2_cluster_lock.isra.39+0x357/0x740 [ocfs2]
  ocfs2_inode_lock_full_nested+0x17d/0x840 [ocfs2]
  ocfs2_xattr_set+0x12e/0xe80 [ocfs2]
  ocfs2_set_acl+0x22d/0x260 [ocfs2]
  ocfs2_iop_set_acl+0x65/0xb0 [ocfs2]
  set_posix_acl+0x75/0xb0
  posix_acl_xattr_set+0x49/0xa0
  __vfs_setxattr+0x69/0x80
  __vfs_setxattr_noperm+0x72/0x1a0
  vfs_setxattr+0xa7/0xb0
  setxattr+0x12d/0x190
  path_setxattr+0x9f/0xb0
  SyS_setxattr+0x14/0x20

Fix this one by using ocfs2_inode_{lock|unlock}_tracker, which is
exported by commit 439a36b8ef38 ("ocfs2/dlmglue: prepare tracking logic
to avoid recursive cluster lock").

Link: http://lkml.kernel.org/r/20170622014746.5815-1-zren@suse.com
Fixes: 743b5f1434f5 ("ocfs2: take inode lock in ocfs2_iop_set/get_acl()")
Signed-off-by: Eric Ren <zren@suse.com>
Reported-by: Thomas Voegtle <tv@lio96.de>
Tested-by: Thomas Voegtle <tv@lio96.de>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/dlmglue.c |  4 ++++
 fs/ocfs2/xattr.c   | 23 +++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 555b57a16499..b41bbd133103 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2608,6 +2608,10 @@ void ocfs2_inode_unlock_tracker(struct inode *inode,
 	struct ocfs2_lock_res *lockres;
=20
 	lockres =3D &OCFS2_I(inode)->ip_inode_lockres;
+	/* had_lock means that the currect process already takes the cluster
+	 * lock previously. If had_lock is 1, we have nothing to do here, and
+	 * it will get unlocked where we got the lock.
+	 */
 	if (!had_lock) {
 		ocfs2_remove_holder(lockres, oh);
 		ocfs2_inode_unlock(inode, ex);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 877830b05e12..d2b7192c0937 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1307,20 +1307,21 @@ static int ocfs2_xattr_get(struct inode *inode,
 			   void *buffer,
 			   size_t buffer_size)
 {
-	int ret;
+	int ret, had_lock;
 	struct buffer_head *di_bh =3D NULL;
+	struct ocfs2_lock_holder oh;
=20
-	ret =3D ocfs2_inode_lock(inode, &di_bh, 0);
-	if (ret < 0) {
-		mlog_errno(ret);
-		return ret;
+	had_lock =3D ocfs2_inode_lock_tracker(inode, &di_bh, 0, &oh);
+	if (had_lock < 0) {
+		mlog_errno(had_lock);
+		return had_lock;
 	}
 	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	ret =3D ocfs2_xattr_get_nolock(inode, di_bh, name_index,
 				     name, buffer, buffer_size);
 	up_read(&OCFS2_I(inode)->ip_xattr_sem);
=20
-	ocfs2_inode_unlock(inode, 0);
+	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
=20
 	brelse(di_bh);
=20
@@ -3516,11 +3517,12 @@ int ocfs2_xattr_set(struct inode *inode,
 {
 	struct buffer_head *di_bh =3D NULL;
 	struct ocfs2_dinode *di;
-	int ret, credits, ref_meta =3D 0, ref_credits =3D 0;
+	int ret, credits, had_lock, ref_meta =3D 0, ref_credits =3D 0;
 	struct ocfs2_super *osb =3D OCFS2_SB(inode->i_sb);
 	struct inode *tl_inode =3D osb->osb_tl_inode;
 	struct ocfs2_xattr_set_ctxt ctxt =3D { NULL, NULL, NULL, };
 	struct ocfs2_refcount_tree *ref_tree =3D NULL;
+	struct ocfs2_lock_holder oh;
=20
 	struct ocfs2_xattr_info xi =3D {
 		.xi_name_index =3D name_index,
@@ -3551,8 +3553,9 @@ int ocfs2_xattr_set(struct inode *inode,
 		return -ENOMEM;
 	}
=20
-	ret =3D ocfs2_inode_lock(inode, &di_bh, 1);
-	if (ret < 0) {
+	had_lock =3D ocfs2_inode_lock_tracker(inode, &di_bh, 1, &oh);
+	if (had_lock < 0) {
+		ret =3D had_lock;
 		mlog_errno(ret);
 		goto cleanup_nolock;
 	}
@@ -3649,7 +3652,7 @@ cleanup:
 		if (ret)
 			mlog_errno(ret);
 	}
-	ocfs2_inode_unlock(inode, 1);
+	ocfs2_inode_unlock_tracker(inode, 1, &oh, had_lock);
 cleanup_nolock:
 	brelse(di_bh);
 	brelse(xbs.xattr_bh);
--=20
2.15.1
