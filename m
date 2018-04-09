Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234858-2-4813410038287210953
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
    1523234857; b=nogePS9L5wAzYHESUOPaOd3ev2ZKxxLDwLPkgMAzfE1cL2bjXD
    Ki2hwJnBB/Q2WgI1x20NdYV2mNK7CzrmKPIhVB9ySyhj0M4WYdR3UqK/aqsVa8si
    13EmwzFDo2HqjfqUQwIocIcQ32EBGDRpkoI0m2geU9JooZ6LpfHNk1gFbwGDnPiB
    lZz34pPO0q2ScUFrCgQqqTWWTkX/87kVg5wTRApk21H6ReuE+r+hTtdGjtrYnczl
    pl0Im+0g8j68DYV+mmBQXr2c7MsqhTPNNz4bMiwChFHqd0j5Cj/xt14ZnDfv3pLN
    6/DcSmFZo7DWU9BOJO/KEcWSTBgxSgY6Ugug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234857; bh=p3coOrj+/S
    BKA1jN0V1tvhStIi/ZqEbq+cOH+e4eZXI=; b=d5A8k9LC3aT+NIZbL3FX0mmoHQ
    dcKlZ74drsOpDlB3Ou9NZvyM35gjYuWlXMNBpjoECK4r5Ai84pAGPMHH8045TXzO
    qyQSfYYfvfiA9HZUrTB3vE22NnITL7/rBMmQPASMf4ozvMyhu4bZa/jSYVnNnM64
    dExgtNCdJmlT7yoFA4ImIoXl2e0YEbRU9ldqnxxfpMuOo4pOXh3/6hE2Q7+GfvCb
    uMq/RqtOjcZEdspgcvVU+QlCaOcpdRp4GMU6wejQZDADLQBk4GygTauJmautLTXS
    kYq9JgnbzXMtJAaMz0a2TRSMxIGAAvnVyP2JPLS7OuCEZwh8CGKOFjjKqwgw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bHLFSeSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bHLFSeSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDSmo3qJg96bBfA4CpIzDCu4darMO9TPaxITfKFCFIusa0V7aGs+RwcMBCfImSMcYb3KSMFWAQi6mFqHpwq3eW2FqqzaHnz5TXqliAJFBPgtPsEecDe+
    JC91D1vpli7QG/kYMy9U4w2R0NoE5hTZUeEHZo+SaxL+IsgfCdVj0q49prn/L06Sed022mBgfJfPHB+S6eZXxTIbXhMvwcgU6Bc2YXCD1ARbvXPN3j5TMlaO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=UtV5FjuMAAAA:8 a=iox4zFpeAAAA:8 a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=B78LKRQ_DW_JVSYieywA:9
    a=NtKC-p29CZ7d8Mlf:21 a=WSM2Z_KrRPBDvc3E:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ehT88nhQmDs7a44Z_RBH:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=kLeBEu5l8tkQtVp4YdQK:22 a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeDIArG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:47:06 -0400
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:21151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756728AbeDIAmP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 082/101] ocfs2: return -EROFS to mount.ocfs2
 if inode block is invalid
Thread-Topic: [PATCH AUTOSEL for 3.18 082/101] ocfs2: return -EROFS to
 mount.ocfs2 if inode block is invalid
Thread-Index: AQHTz5uGItMDP01ZuUKctWhy4o6Q4A==
Date: Mon, 9 Apr 2018 00:41:40 +0000
Message-ID: <20180409004042.164920-32-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:992fPdAS90aC5xWJOAdt2pewSSW5brYwXF5qNuW0+R+RlY4pEPnHn0IIwdQ9mY0taZNYc1SVhsmPdTgJBhCI26csehBCAImB38EYGdXd0gqOVWzZg+Z+LGDGQQ4eWjRxWFhr4JvoWiZV0PjF5/A9IH19SgrSJiC+nen+aO7pFrmxBCL4+KEYnYjtC7MaPQUaGCl3OBgnjp6CIsgiUbh1FU9TyhBrCJPcgXAN4fEApSejlf14jsdFcX1l9EHpykYm;20:aPNLBZZ+pSBGeLz7GbzKsspb1svOs4XhUW6csCLqN9X4yJfNKcMbapua/coaWI7EChODYx0KzWdIDb5VLgu6V4Q9pQ7nuCCbaIJI6aonbHyi49JHREyep463zPRut4krqpeReStqxt06Ui7VLZzaZLW8Ee7cvyVkKwZYMuoD3AE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78c5ea7b-5078-4e7d-7d22-08d59db2bbf5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062822CB538BFF5371F6247FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: x4tiKovJZ/qSAEPBTxBRPQwuTPFyFxIriK1aZqCfu+s/bGEF6LxWo+Ak9RyoRFE75R+RjvIsLKA3Yee4YPrCNiC9ZkWmLioOBuJi4POZgMokjbU3R/DCyX5Ag3eJpW8+0i6X5vuM/1NxexH47BBI/WgWJcVjIJOldJBnJLEawd0TvQfKbx50F7Xoe/C/yZnD7kypLRSeTMn1fYmtwXuFiJEg48XMzsrtpykKRWjRTpJtTJ+pcTvzW0R0ZI4iGhOB9gQnaBLvzubBS3FHJkRxW9nGl7i5PoNZgg812CNTg7kP6QmCyakj2+JwA8leC/4R8nDj897RBy5qtcPPvlQ6zLeZla8n8xAZRrOIhxUchhLh+XiwcibYXsE/8MdZTAqIo2XkAPp8Mwm1KZk72EuuIiL8uJIf5VSa5xm5h2XQfhM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5ea7b-5078-4e7d-7d22-08d59db2bbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:40.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: piaojun <piaojun@huawei.com>

[ Upstream commit 025bcbde3634b2c9b316f227fed13ad6ad6817fb ]

If metadata is corrupted such as 'invalid inode block', we will get
failed by calling 'mount()' and then set filesystem readonly as below:

  ocfs2_mount
    ocfs2_initialize_super
      ocfs2_init_global_system_inodes
        ocfs2_iget
          ocfs2_read_locked_inode
            ocfs2_validate_inode_block
	      ocfs2_error
	        ocfs2_handle_error
	          ocfs2_set_ro_flag(osb, 0);  // set readonly

In this situation we need return -EROFS to 'mount.ocfs2', so that user
can fix it by fsck.  And then mount again.  In addition, 'mount.ocfs2'
should be updated correspondingly as it only return 1 for all errno.
And I will post a patch for 'mount.ocfs2' too.

Link: http://lkml.kernel.org/r/5A4302FA.2010606@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Gang He <ghe@suse.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 93c85bc745e1..c8d4934fc1cc 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -467,9 +467,8 @@ static int ocfs2_init_global_system_inodes(struct ocfs2=
_super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog_errno(status);
-			/* FIXME: Should ERROR_RO_FS */
 			mlog(ML_ERROR, "Unable to load system inode %d, "
 			     "possibly corrupt fs?", i);
 			goto bail;
@@ -498,7 +497,7 @@ static int ocfs2_init_local_system_inodes(struct ocfs2_=
super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog(ML_ERROR, "status=3D%d, sysfile=3D%d, slot=3D%d\n",
 			     status, i, osb->slot_num);
 			goto bail;
--=20
2.15.1
