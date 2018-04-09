Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238622-2-6128948193851547220
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
    1523238621; b=OQyoEt8kjn5RI2wCVX8VNDuenYLoBdznfEYFTILUO3SOpBDuWh
    LpjCkQVcTYv94+8mylJT2H7jr1lcIVSBnqzxdghezWIVGhLBo6dy6H7ZVaPmnGbU
    OcWAvUgoRsDiea14wHRD0o68mlw+Vp/EKAin2FXRgqfRKO2tC44JNLAg2FBPsUv9
    HWhOhwZQpTYzaZF25ZcHxeo/4/b8Q6sywaaByj+/DvU6etKtzX6VsR9h7uAl8grg
    mamc/VBVVLRTnCBN0xNi27B4Ybag2tbJwkSIE4K6KAb4OOiEM3mzTUgHbVCeIzbf
    A6pNdF3NWSt0sEbnsz+x0XCK/5RZQIJdZ2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238621; bh=Kz0MN6+5OS
    Mr/ZgGj2YV0iroZ5ga3SDRXB7gTzaDOIE=; b=Cww7YrYjzxJyOHdTKTr14EPRXv
    n71sI9gVHYsWRuriKLQgZWYyR5ZD7N40gsIGnMAZhX0Sc9KB+UOhKKSJ5tRdN2aF
    EclZR2VKK4UnqmOh/K2HH9G48DQF32Hm3nmwTxE8syDzbulsRoAYKsuA+FSBMAV+
    0DRHVg5OWer47upuqNeKKajg3f07/MIyG0KycpVTTMnXnPRAMf7E0IiWovFbCHhO
    N6CHzvrpMGU6I6dUjkVmtZn+DzhkxSlkgNDO24SQPP57Io1QzpzqPoImeb9Ex9Mf
    cxTUXsjj0oesJEAXSXcK/KGhN/Efbx57SDx9STdPt7E1ZJobxOVgmdxYfwKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i4Y16lDN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i4Y16lDN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNiImEG+EGF8YI1yANztku9AZWgoJisFCZ99tInoHHyLe1bEsqf613K85dZ871sJ0MMO9GiIDjb3rfw+HTeSWiLk6Bu0/joDvC/aNnfAU5NX7KMCgcJn
    jk1v+GA3TwkSp+uDA7y8PvBhR0ZHZgg3jt20KYiXjbWJTWOZe9vFcn7wlRw1PUlCkGwJ676jGHZnqYbCIkXXm6Sk/SLMa+kiKKt+k7/faptfCeP1J9YmfFka
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1757444AbeDIBuG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:50:06 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932370AbeDIAdz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:55 -0400
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
Subject: [PATCH AUTOSEL for 4.9 255/293] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Topic: [PATCH AUTOSEL for 4.9 255/293] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Index: AQHTz5lc9RYsDcpPdkyg6+/RB74WNg==
Date: Mon, 9 Apr 2018 00:26:11 +0000
Message-ID: <20180409002239.163177-255-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:NARwBpRCsTinAATVVTxWOmWSTiv9ybgAm36nzXKS8Vb4wr8zS6LzyNU9E0+W2x0OXqRnbDCOvLJqoudNkBBqC/BskzQDdJLkXF3+4gOdRxHJD4WMykurPMp4TiDAcMc6LNWwT0YyxT9ni86ySwOstiEoQGjaCN5Bg9l2XyzzqZYYNa94TNFCBI62+7YhtJ3x3K1wirwmtLTqkhFvauwXOAoqb+Ue3P2RFpSj81ETs43Eo2LpEqMmv2hGIvcf6C4t;20:DJkauzBT1jRCZDSDu12G9b931IwX5wUHHp6U5S2GZzDJvCo1lmbZY0aeZPIBrgTEY3HpJbyfzDaFAcGm28yD5HSb0XrZofXd/wqwRg5giahAwHR4GK21LiMtR8l5n5+iofjRLeeAUEf9eWWVq0Gyx+Pp8H+DzNlFPtRJHmSgtCc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7aad3ebe-d756-4ee8-31b7-08d59db190eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806E241026629A0FBFC0D4DFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(7416002)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(39060400002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Ro7HC19Iu+16nRLjb6/XAnsHc6PBt3ZTjZ5NrMzll8dGROAZEF7PaAJp/5N+j9eA4E63LuVjPhetpcnETac1lj5mM4+t31nntRPw7Il5X9ZYKrDhSWI0JcUxK/zJMMvFn+duOywSH52BhieldNCEs/UwdX90aBnxnDCO24aiu/vCyBNz2GcF3W58H97alNTFJeg5wtpXWpndeleZGJJn6d05KU3rAMHl6KTk6M3sC5MxO42ZLAHb8wRh3jIdpdwk7mHQIZ/+xpQKgGdSqr7BriKahIyoK3pAJyrpQBfHdcAmldrSxynHhc9JfIYE2rOuUg/Y0ElHgbhHLSt8zUPEtidgNxkm2QzZW1+u8W+ltl7nGWAX2xciAi3GwXWSNDngas9Nx7Fqb1FbyZq7yFVoGCvVjD4i4iVuFn4phH/xk3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad3ebe-d756-4ee8-31b7-08d59db190eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:11.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index bed1fcb63088..ee8dbbae78b6 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -314,7 +314,9 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode=
, int type)
 		return ERR_PTR(ret);
 	}
=20
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl =3D ocfs2_get_acl_nolock(inode, type, di_bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
=20
 	ocfs2_inode_unlock(inode, 0);
 	brelse(di_bh);
@@ -333,7 +335,9 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_=
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
@@ -364,8 +368,10 @@ int ocfs2_init_acl(handle_t *handle,
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
index 994e3bfaca7a..01932763b4d1 100644
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
