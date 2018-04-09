Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233866-2-14389021645552328531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233865; b=bpKanTZWnhGCUEbuZD+12tF0G+Rs87pquYvdiXbOdR9Tiro/w6
    /V9LFk9QxT7D9NXc/SKyO3C+zkMJq76eQV5GYXIiknBkMaV0ah510w0os8R54B9Z
    k33hgsX10RgV8rz3KLcV/FG1B3zXu6i8v4hjZdZHYw+/ENkMbtgfnE1gwCXPlayA
    fO2nEyriI1s4P+5kJLi3Ezv+VYZK+co3kUt8gYAxrJ9kFq7agLxXURQB9rZdNdpO
    YuBYngQE4Md5xuF5Q8O8epngcFUG2Miqn7VvijOQLrJT7+zkFkIH1f0bCQE0cct8
    7ZV9zpE7/F9PZDgO0DpOJNpTaIxBSXs/8xNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233865; bh=MdMGigCiDi
    lByoyQEgYprmRsT+TTL8vE4YP1q8SlPFA=; b=YTd8ARxVZVDaW5hiu05ytJGVeJ
    wjYPV/990MF7a5CfJA82agN3QQRbRX22LxPXQFAS6VRZ6UhAfowihvVTIipSoi4R
    B6QFHtIy6V90yJQeoDFg1VTRD6cBk1kXAZnem7ae42+/EhCG8umUF8w5S2BXW+VZ
    Xj6KYdXhzHEz2ttfJWIOZ63vlsmPLNvP8iXqFCtb4LyAcNfchDxUafoEk0hsVXSH
    6wKyNRUnC6DrvddUO51Wv+tWMjGFMyBtp2pENLqpTFXgVtaRAQBZeSFdY7gKVhlD
    r7Vr0pjGpb7Ep2MKoagCEzeRmAPEEHq2FVXX+cCzPOFZwVjrWlS6PYZGitnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJ1OCHQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJ1OCHQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUtEsTjMp0ZbxhE8xw+lF/By0W1P7kuQ8nHpkz5MQjZwhwl+K3/19Jap42ellmeJN0lJkAwCuRZS5Y2mVhOovTQGg/UqSgZkpVw44zCXYkRlbPbXn3e
    pKE08HEYOYucExn9UBqFZ5gB91jNt6rbF/CsHj3T5XLt9GeSt29xeNbr5x32qROTb7LggWPLzc8c0q1TFCw5RdzsYuTs3NWIWAfCF9q01QIpXmdZR7C4yJ8G
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1756104AbeDIAaf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:35 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755787AbeDIAae (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Ren <zren@suse.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 139/293] ocfs2: fix deadlock caused by
 recursive locking in xattr
Thread-Topic: [PATCH AUTOSEL for 4.9 139/293] ocfs2: fix deadlock caused by
 recursive locking in xattr
Thread-Index: AQHTz5kmfVmN5kBiHEqQxSvPMIWSYg==
Date: Mon, 9 Apr 2018 00:24:41 +0000
Message-ID: <20180409002239.163177-139-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:p41xzbdVxXqMM5voLz1JTlQimkUEujiaSWyoSwXp51nppS1QP3gWZGKmbCpjBVc6zbjRLjuORi7sO2cDv3vlXabCHmy/JR2UPoRPu5D91yfYVlCzYLGAYcXvhNCxDW4FJevuMiN+WcYcqH2sPz7qb+I/Y89jBpCS4d/HN/VSlOzbAJZoCEaGPbMeGji3o0VZcn8fH8x6iMgmmsBC3HudQE+PSIxNde/2BpEtNNQwGcQf90lRUCCkecD1h7ZO6S4L;20:YDOSXHo9rNOdWH1ANQnIMkJIe5x46hriPJR2TtuZmcrPgKod8aXtJ8DxjO+t/oquJ2JsecsP8xz5fhACcn1EB5FEiEF7KSzXSO6giJGzw6ptZXbEHPGLtjVK4TKNzxTIv2AXIg1tpA12fRCdEYw27ZUcQKTlDpF2Ik+fxqUhP3o=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ab8daec-5539-4d38-2790-08d59db11807
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807DC1DCB83F80CBECB5637FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(966005)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(6306002)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Qc6ea8nEnKYHvHjYucunZRO9BgAsiduLDxoa9f7ufEFHrih4VE5yweTC+aOOGdSxKl6/NsR/R8UjyUhdfDO43IE47f8mG4ofUgkQ+CZ/wqGZjl4F6qk74/BSdfMSojcAJXzmpPhM64ce6mWrMVF1aejQx3R3z7Bhlx+b8soqiWqRc2fao/tqEBdyvXqT9euEE08jSiOq3rQyONnxwEQdjITslQ4paOnnQOncIsP35PdUJSqNOQ3kj7AA+Tq33JVwig2N2aHy8hYk0ljXhcWa5+HpVXXypMEH/hVYJcb9OxkLkDcSOGr9lvrwwaacHTg3ij0tWZA3BXig2439v9UN9MeiRkzyjLGOoYy0NnhZISiTreK79qkLP6vHoJKF9RKVbjX6pHDGccADQIyM9qqTTAkzO42vbBHy8LEaqjOYaBI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab8daec-5539-4d38-2790-08d59db11807
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:41.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index 785fcc29d85d..5729d55da67d 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2599,6 +2599,10 @@ void ocfs2_inode_unlock_tracker(struct inode *inode,
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
index cb157a34a656..994e3bfaca7a 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1328,20 +1328,21 @@ static int ocfs2_xattr_get(struct inode *inode,
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
@@ -3537,11 +3538,12 @@ int ocfs2_xattr_set(struct inode *inode,
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
@@ -3572,8 +3574,9 @@ int ocfs2_xattr_set(struct inode *inode,
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
@@ -3670,7 +3673,7 @@ cleanup:
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
