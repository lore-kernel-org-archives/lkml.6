Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245687-2-1948095860317236573
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
    1523245686; b=uNuX/h26+SBs4bdUnZ/Yzg+2QwjsZizmnvzRW6lxjTOLopw4gx
    cRPval7gr+LEcSjRhVxU3/FmDWdvdQa86AlSYSPjP+4Ur6Ji9+1Ix9Scnjdp1y6J
    quwOEcIV1/iI6RWxfVv8Ze8Mtg9c61KQFfGwrvdb6RMjlCd+CXKZBzE2Mwx3x7J3
    gI+/t7icwtsEWUpO+7PYiReGvmr83mXVijDQVIix5MI/cHSGbAuFDTedtE1mIhXB
    54NZMl60mvSWplJJuKLSwUX4XOssauH25gwXqphFh/DyRhHtguXlCuEehupulExz
    IOVlOzxSyRCuwqPo0UHNxHOGJstbqtY7KXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245686; bh=3Rekw/VesZ
    rQPxD3iuVTJmdfQKlxAM7Tuu3Hj2Ydo3Q=; b=rI2iXpcEHoWL+HLIL4YPE6IJDH
    14Ha2h26dPO5cUj2U8suz89Ycj7szEOjl92ZbqSicjJGEzs3mZpzs2sk6XppWy5I
    c7zzcAon7QftcgJWLOLvK5YbkS6t8S+E5yJVwVSMgvBfEc46NA7VjRQ2ZW7vUmPg
    RtpHLOC8FqVNsXdff3wYqzFyGI9mi5xmjZ1JMsPvP726oXjnaVu44Y7ildEG1n3r
    32Izn4l0odNhFvb9RR/VQn//24x1rGg4DJysZUMWpkElCbMR0JsHQ0mhspPWa2kJ
    cAfuDW63CMGT+h+ieNlOWrPq6kcfm6pG92QiK8imG8gD32K0xb01zwx+CRgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDLq2x18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDLq2x18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAANWYtjZFLhzefZuxYYHBbvIIcmOxeScFw/B8IXiqXaevNt91H3Gk+woDlbQBIQgcq0g3YpjVY2U8gFndj+nqVY8+i9HMc2APSZLfTx/Ml+IvyH3lWB
    TF07/95R+nF4IgYJ1ULtkKQq6ZSRjkj2YPUHv82mx45BGEe3/X5yeKlXLPFMeImemCfWXUkt0ZUaxM+fw/pxsDXYl/JluOrZYr5eRktprrLglLTXfogrlnyF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1754141AbeDIAUI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:08 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:14464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754083AbeDIATf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:35 -0400
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
Subject: [PATCH AUTOSEL for 4.15 117/189] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Topic: [PATCH AUTOSEL for 4.15 117/189] ocfs2/acl: use 'ip_xattr_sem'
 to protect getting extended attribute
Thread-Index: AQHTz5hCI0nXsI/5UkWGq+Fj2cviHQ==
Date: Mon, 9 Apr 2018 00:18:18 +0000
Message-ID: <20180409001637.162453-117-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:Ol6MTibpZ5uExzUVrBo08RzIMojZpLvpxVYoCVh0Jd2mo9VClp9brEaT3SnMX2urEcsWhaU9oMH7JlgijRz85i7R0BRQgql6PTsfMuAqs7qTVl6DRVcjgciVMAU4UwIhM8rAdttbdu1RDh1EZIUXI/Y62YHWy40h/vZ2X62q5CZ9MZtKv9gGvS//G4NhlyP3ga2xsgIOLepoWz7cyMk0xIY6JcKbrit6XdEGKg3t/H4hjCipoQZhXHuAXLTtrCt9;20:AGxlE0e08yPSrWpsuRjMhe92kkiEP+5tJlpFNPvuwpSYYwVgsqAB8aScwmxdHlUxAASaqDYRwfqR7PKet55aMvM08yCmW0qrsPQt+VsRb8GVGkj5gaQmNcqIGtRZAKq0V2/aitW1SBJm+DzBZGoxzpV7TNaiUQoBU2QOuH5Yxqw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5513ee63-8b7f-4b85-b053-08d59daf8f0d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726B95B274C52B1B13BDBA4FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(39060400002)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(7416002)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xm7FAjYRIWzFhC9+ZrbDiWixQyzCVXdj4abbhpPqB264LhrW42bETkr6enSn0RaN6bVbvn7XNAGMnDZeJiw1RPZFZq3p6dNr7YEUqxVXV+Q3synSvHCn9lF+aFST7cN+R50dSuDqfluAmARy3jRXhUNZ9mxsQ4HUHzke7JO5wg4b+N8ueJ316GniyYdSJJ5qP1j8kU6FM+25JP/JQp7iHb8vzNNYQErCc1P2qGsuGJ6XzTBU1JyxBpS+QL4yedhWVG70qtCii1CkzNYDe3feoYVobmLEzhLfp8ZemKobRUdn5kaXO9ymHTVFf3CJIQTxFLMStLmQBixkqHgL4WxbsaabgXQH7j72So7sOuZjweczeVBxic0un+Y+dVYChjB3W4G9LrxIYueZ3qeJR368HgGHv71n2WIpomO2Y2EBEGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5513ee63-8b7f-4b85-b053-08d59daf8f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:18.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index c5898c59d411..e358f60f25f4 100644
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
