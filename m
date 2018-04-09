Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243272-2-17085485657571872249
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
    1523243270; b=KUhsGQ9xdN33iAsOdQKU/wczAFQuRpLp29SmA0lSoxHCAisNJW
    m5F1FB22moUvOMWxGkzVQx3IDukAr+qYfykYqSZ1GLBnwh5yhhIn84Fr65wsi89/
    4xQjkm6TsDfaHvzciWWrBmxsEjlHBib1zvR5iP1LoMfGY4uMvD3RxzV/wLf2JRQ+
    /RqK1jR4uur78qoDBSM9BYuHV+C7q/pi4kFTS1j4SuAmousj7jp/eHxpyD+77OL4
    Wsb6LxigKVyfYjBcNE6Yhv0tvcOXeiq/cerfAgkwARx+R7ENi2aD2kLAzeK1wSay
    BPyeE+8b92xwqgu1BxXizeG4JERHPcq1H1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243270; bh=OT9E3LEGUi
    dbqRABoXrCIhplwPWqQxaELiGIjstLk9Q=; b=u1HjZK2bze+i9tWCkHkfOLfzBH
    4pQBFdbyKf7s9ZBFAaUq9a9qeltpj4w6Fb27OknSR+McpvQN+/Ed00PG7CQPH10y
    RUnnMuT21RR8kuCqVPOb/x+DE72VquO0V28RG4feTc/abjaJvhjN//150uVO0nj3
    mmqNGEBKSTbao6f+CaRSahW9da6ovvoygpxah62BKo1yFoTENQQ6PHLPCrklKtIJ
    QYZqttLKvk1alemolIR/ov/xEjLBIC7xgz8xxuUC2/DZIAi/rsDVdjC6UnuVPqvO
    9D+7z4eDCvez/iCJC+vS64ftJCM/+DvyzCTAnxVZK4AwWLtok8zCkiyf1Yeg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JLJwe9R2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JLJwe9R2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAJF8b8FqQQyxF3gsn26eth584ZwHE3B3czVbzEIhQ7UsFXABg7udV0IZM3T+c+Q6RsohoatteAhXVL3EOdnCxPK2jw12fW+rSSEd3/BkuGsGxBzTBw
    4N2xokaKchLrOjVjJ92niyHU00GQPn9rXCFnW+wzqba4ziJVAdVw3V4/4511sERD7XHklqnhXv5Pz3KiStHqwxiYv6pq0HkHGqSw0s+1PYcTlsibjpOBSMr4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=o8Bf2xIQAAAA:8
    a=IXr_WNlcAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=UtV5FjuMAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=GKoMkwwqKZRgV0JW1dwA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=kLeBEu5l8tkQtVp4YdQK:22 a=K24ECnMRWNUKRqF_MnsZ:22
    a=ehT88nhQmDs7a44Z_RBH:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDIDGj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:06:39 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:44416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754105AbeDIAYi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 097/161] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Topic: [PATCH AUTOSEL for 4.14 097/161] ocfs2/acl: use 'ip_xattr_sem'
 to protect getting extended attribute
Thread-Index: AQHTz5ioNyOFIxBt80q0Z8r+m0QT6A==
Date: Mon, 9 Apr 2018 00:21:08 +0000
Message-ID: <20180409001936.162706-97-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Y2GOFJxqlqC9EP+wbG4odi75ale7IYna+XppRob6yX8Kxbk3IUgOfx2XZMa0fm6eDOnO4somjMUYFxVzSmkoTv/X1AXl3f1HmxwWSs0mjB40lzdmRRUHVg8jPKOlo4vduyJcjn7druKHYChwhtD9j/1wK6FBXI1jLDsvL5VgOEvdNkN4EJYpLN6+7cBxXRWpsUlZnJPdDcfhlXCeuBExjofRhdW77HQ7IGQDOcPTtC34n5JehhFZNl1uE6hT9+wG;20:1PsHXb5wbURELfmvq4hXym0Mh3AC8FAZjSVumTB37a7rEvFyG7JHom8yCPQ0KE4UdXngAgrnAmxMvnEl8oCcZ89/3e6NoXXyv9e+yXeeOcCDkEsLqfJ6iiSp3BSJs7LlLBoE3npyZzKaGq6l4lFogc3snzYWddgHc/K+bSWJhCI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 227e61ee-3782-4b48-f20b-08d59db0470b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09835B026CD26D4C126AF78DFBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(39060400002)(476003)(2616005)(7416002)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lplCTfU+6gOKThZueE9GfMEhCxP54XK7vuiAOjpkwSPLRwPyB+/jMjGSlMkQeu1UBRb2VKysxxiDfgRZTpwlaWz4jHxE5f/qPYq8aPTa/sX3xZPmVNAFNdAqptow6au7eODQMk63PkjiWhYSOOnKhUQDlCA+WEbcm0/Uk5eh6aFkjb6k+dvIc/fvWc4dOLeRMQeouhSvxXiVbBqDaViEg1iDZ3qaTLrCSJhvMsMDClA45BmPPiwWc6QyhzO9PiGxOZMsJThOnT4xAdsvqfqi6dBNXy+FUdZH52yKOT0FpEzfEPoYtWFk1JUA9jxX7h5VaeK6wWrKT2hdMK67A+kDkLcZ8e8CDm3khle7D2JZgNTvwiPf+ESZHJmwFaw7vhOElaMNu9LRKSRTAYZnAXE7r8vDHvJ33V/gphhV5Gahwio=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227e61ee-3782-4b48-f20b-08d59db0470b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:08.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: piaojun <piaojun@huawei.com>

[ Upstream commit 16c8d569f5704a84164f30ff01b29879f3438065 ]

The race between *set_acl and *get_acl will cause getting incomplete
xattr data as below:

  processA                                    processB

  ocfs2_set_acl
    ocfs2_xattr_set
      __ocfs2_xattr_set_handle

                                              ocfs2_get_acl_nolock
                                                ocfs2_xattr_get_nolock:

processB may get incomplete xattr data if processA hasn't set_acl done.

So we should use 'ip_xattr_sem' to protect getting extended attribute in
ocfs2_get_acl_nolock(), as other processes could be changing it
concurrently.

Link: http://lkml.kernel.org/r/5A5DDCFF.7030001@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/acl.c   | 6 ++++++
 fs/ocfs2/xattr.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 40b5cc97f7b0..917fadca8a7b 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -311,7 +311,9 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode=
, int type)
 	if (had_lock < 0)
 		return ERR_PTR(had_lock);
=20
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl =3D ocfs2_get_acl_nolock(inode, type, di_bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
=20
 	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
 	brelse(di_bh);
@@ -330,7 +332,9 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_=
head *bh)
 	if (!(osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL))
 		return 0;
=20
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl =3D ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 	if (IS_ERR(acl) || !acl)
 		return PTR_ERR(acl);
 	ret =3D __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
@@ -361,8 +365,10 @@ int ocfs2_init_acl(handle_t *handle,
=20
 	if (!S_ISLNK(inode->i_mode)) {
 		if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+			down_read(&OCFS2_I(dir)->ip_xattr_sem);
 			acl =3D ocfs2_get_acl_nolock(dir, ACL_TYPE_DEFAULT,
 						   dir_bh);
+			up_read(&OCFS2_I(dir)->ip_xattr_sem);
 			if (IS_ERR(acl))
 				return PTR_ERR(acl);
 		}
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 5fdf269ba82e..fb0a4eec310c 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -638,9 +638,11 @@ int ocfs2_calc_xattr_init(struct inode *dir,
 						     si->value_len);
=20
 	if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+		down_read(&OCFS2_I(dir)->ip_xattr_sem);
 		acl_len =3D ocfs2_xattr_get_nolock(dir, dir_bh,
 					OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT,
 					"", NULL, 0);
+		up_read(&OCFS2_I(dir)->ip_xattr_sem);
 		if (acl_len > 0) {
 			a_size =3D ocfs2_xattr_entry_real_size(0, acl_len);
 			if (S_ISDIR(mode))
--=20
2.15.1
