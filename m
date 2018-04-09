Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236265-2-13289567945377618813
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
    1523236265; b=ewBI9RYUjciQWX8reI0AbvDnscmaSkBi9kByOggjCZUhD4XMOe
    SOARo5LrUmLMhIqnqhGk6RuC+FS0Xl/gHq8xGn/xmVVyJuoLvPag8vnPyop+CCeh
    xXevbn0qhfiT3OeBP4MjCGE2/p9m1fx7GQe7FgMP4BfvoD0N1QI2Mza6WPxsNyJn
    N5spDcNhrjHGQQwRVNxf4x8Wb1YzhOf2kfBH5GPd1y093Q/ptcdIqrmDBv5kfuxD
    hFdBWzkeJ79L1umRH2AN9jWubJoA+iu8TQ/Z1jxd6cmQ3xnad68YXcbjAR6Rc7Ir
    IWlSQd/wlyD5MESUIYCPGTYd83ZLHueRK96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236265; bh=SdvyzhfCwc
    xGJeTNBrMJ4xVeBR9/XMlWknHEdNSo150=; b=sGNX6bmV4ca69VUQCu740xxAN+
    8kVN0n6Dy8mD8JN5uLyOXiksfElnYg/XlpmKrNgbyVybOQPidkz5OtCvoAybP4fN
    in2GQaZkahfvDfV6K2BeblNpnTZCdSstge8xddTBAmEZwUzl9VlPYDM6WPtoVo3W
    INsHILymqzl2GaDtsbXSp8TtmPcFXnO84J0z+GVnhIMgssokAaOZAHxMo/8D08CV
    t6GICgy65lji3+79XAgNvZ3T/N5I9u0rC0vXtKAer7tl8gyA81EBA+uIv+YDJ9lM
    BUzeMaGp6yTY34IYRRsIhpTwsnjXPYaB+v+Y6lGxIuSXpHiKpGcnfcMp+lOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IvAu7v8P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IvAu7v8P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEA2BlC7cAOHrjn4TKsols5IYxF53sZvwBPtKajw7S7DmqHfcPVmqhpqL2Efuy1W6Vh7quCv6aPgNSk4PW6jU8G1aEjK2thCWf39vQ2S2QfRBvQ+KJvC
    1QWnrxibDIB2PDgf1ePSVFHv+PT0Zy4rvIvfw8evkB2zgWYWRg8z4HUEu/FK9C2HivKsv7KaXXH+R7OfwFcSfmAYn6Z6fAbqvvMNu5QMDZSFUTx1DrVsy3xt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1757165AbeDIBKz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:10:55 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933006AbeDIAio (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 136/162] ocfs2: return -EROFS to mount.ocfs2
 if inode block is invalid
Thread-Topic: [PATCH AUTOSEL for 4.4 136/162] ocfs2: return -EROFS to
 mount.ocfs2 if inode block is invalid
Thread-Index: AQHTz5nTwfIqQwA/aU2VsPFNkcdfpw==
Date: Mon, 9 Apr 2018 00:29:31 +0000
Message-ID: <20180409002738.163941-136-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:uNxc3GIKaz1vDuRA7gOjwPNl3+PabZEVnWkztLXbx9pOT5cb1tDTsIo+fNlh4NS3Bz/iXj3FJ8bZP5dmmrFgd4ievp44YdTLawmIPCJw6+nLCUa+aatYTolOXjdF3YYqPzbfcaj81j5/O8XjJPpJUJYDUVJSayrMLYKzTPfKdzF3TZK4d19DmkRtTTZn2CqaSltcvzSsAj3thkKIOlr+eU+qy0HBi3QpppeR9cQ9OQysTOIsy4b2NLjt0Y90EJHV;20:Zo/zBhfAWXNTS37d/gjoP8qch5lnIykR2woilc6jAcYE+tmXZc4wLnCJsR/zJSHmW0/5Y+t+8q7VLw2PR+XBkJBX8F3ErAJODel6JX63s7StT+7VS+SQGm8qoaA058fpCICI7p9a7CUJWmPwhopkL7JU5fJ93xe8qw9oVVJR2fE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cce309b1-f435-4e06-f485-08d59db23ce5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095F8AB9D5A24BA3A21F9A8FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(6306002)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(966005)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: n12Z0lDrPGZh4WfrKU4+vf8SEd4F1jnE9LgR+c08GdmUjThbpkA39kaJfKruxs7+FXwej7OuocLyI/tyXWdLGoZl0XWx5tjwAdD2XqyhdhjQLjAj0pEhrvOa3pXpk+Zb7XH9rQPW9qroV9mHOtZgXJTVaKlhYw+1wsFHu7ZcXtnqH0VYmShe9gv5WHqwsLyHBLo61DSIGzYy+rHrDGtordYwyWlzyYF8843au588nVaOLu8EjXnWGgfLozhxfWOU/lVgHYdLljeiWVXufQoDkMJP//KTA5kRCRx7/qkw/GPXZOWSyulRhf3qkZIrBDywwuB8FzK50Zc6d86f0BZKNHeTVFOUf6qOecM4D4SYfmE7K182CnXxwX5laMg6vjSei6wh9fFF6UmirfwMMBrX+34ZLHskU4qQ7tAiuZpjlLc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce309b1-f435-4e06-f485-08d59db23ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:31.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 2de4c8a9340c..4f5141350af8 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -477,9 +477,8 @@ static int ocfs2_init_global_system_inodes(struct ocfs2=
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
@@ -508,7 +507,7 @@ static int ocfs2_init_local_system_inodes(struct ocfs2_=
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
