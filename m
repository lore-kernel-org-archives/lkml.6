Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236243-2-6000143945805956109
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
    1523236242; b=G40GV2a/17DDbuVadNFCMdk9bD5XiCONk4nY/piM+iWEWxNGye
    4lre5RQAac7IasIMpLv1KZLMjgPuO+tza4hOSpPFFC7ScAYMCnkxb2Q+fvRbYeWI
    4mEWJWIhjiMj+1jkZRujJNKrYll7Sbxk1Q8AvrxEE4MZTzMvcMmkTkgNpY+r1OCq
    luB43/Pjl/Hh9PW4JkTGDGqZarvUmEPML5CLL1aTBKD3YVLsBR/vsbn5pyKVNEqJ
    R3RpL/GLAGXp7J6NRM0uV7SjCPK7fVVF6jqrcL9RHh6ZHWwqbrRL+sYhVJy+jz/R
    kqStBRhmNJdQ62poV295A+HB66uEfY33cF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236242; bh=13niqeUduz
    aFDsw42+SdxgGOYFxiuMDlApDLejSfymQ=; b=Y5RcREtfm/NfuX05SFW4l4pjUP
    3/Qt5HjZpU9hiTQATSlPzaqTi2jIrVnmxOmw+8fKopRj4OLnihT1g/oMLKSS2trF
    WEcJ9ynY2RcZEcYYiv/fCTLp88dODCRnsb8dnm4OZqViJ+Lf4/4NZV4ndDpaeCfb
    AOuQNOAAnPhA3ENsf7Ivywx2oYYeglIkYkLR0bY50hatV/izupUPq/Lkisd8Ht2S
    e4XV4bp8YzS4UDrgxpA4X7F1IvRQYucYhQOsX7O2cEBU49MDwWrT1fAAeR9d2EGE
    qP8POXHpaEihwCm4gJp7RJVU/Wc6dkOVCPHTnsb9UOBroPrk01x7u+uXlqWw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPGTNSYN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPGTNSYN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFg9p9pqVXCtxZjVQFxAIScmli+S3/Bk6fa0uPuopx6bKBFby+FlNnhe+xM7XZ688iy+whVAJ8kLytEeFfV3KzYFKvOYFoqukyc0kSsU+fg3hPm1j2W5
    k3D0lQOA16xmbt1aMMLwTtaN5ykrWJUFX2VjDZREp6/L0GsciwVK2FcFV6CuZX+cjQrrSkCfKSyLc/06JlajeyPhU2RuiYCkH/uacORqTNbGprP8ojfA6CJa
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1756958AbeDIBKj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:10:39 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:43760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933009AbeDIAip (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:45 -0400
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
Subject: [PATCH AUTOSEL for 4.4 137/162] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Topic: [PATCH AUTOSEL for 4.4 137/162] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Index: AQHTz5nUlGSVW/AFtU670GlbZUoxSg==
Date: Mon, 9 Apr 2018 00:29:32 +0000
Message-ID: <20180409002738.163941-137-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:1ufTmjN4iv+tJBqpWJcuQ2bq/Bc2idKc8DHjI8RW5sGfOxA7CVB1c5vpn8eXjd5NTC0StAaZ4y/CwV4XA6HDsi5Frkyc7dH6/w0M5sYOnF43CvYSQrOnE1HkjXFrxZeXXFpCRSnBsFhkaut3YdDGX2xb1dcbaoD02JGih+vIs5le1QT6DK+b2yqkO30pwChgTHiKGalV4+ojIsKVbi7ijakzOtwfRFDxJoyV3NYlkzSkrBEyPmAHavtAOwlKBfxA;20:kPQBIkHawEf20rhcHuVo8TXjTZappbeH05qHTV9XMTnqgtWKFcBTb0Qyb4raW5+CpOg63AY/DuKAivD/ff9sHM8IxhBrVdqLQBvxlUHULCjaZ0raJDUGIpyHzzoOWdsRxhIYzIvyXKZT69uJoi4MTXaf5pGVJeu8/YV6FH6u8kQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 071941df-c962-46ee-52a2-08d59db23d45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095ABD04530A6236E62E91BFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(6306002)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(966005)(68736007)(66066001)(110136005)(316002)(54906003)(7416002)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rOyhg+TIH0iqbeggWRsls10HqRJZGRPOawDxW/i2gU4Q9+2cLdVcJQuRULqqSbxKom/s9qEalincJzbhL+pEFNnlDosLgn8HqQg0ScbxO3P8iIsV7+O2snL4Geb8grLGTQk7QeLQ6/dwdix5/vzv2Gm0lH9B6X5Ew7JROUHZRr1gKar8oWJtgFm5Cm2cLnFGLIA9HefEbkcrbC6nZwTNa21WfwEMtLok/yEErLdPrURfCMTJ4kp9nMtqkfiwh07v+RofZw6r1ViQs8tehEA3zqoMQuKUM4JGuvJtcWLIEKt1Gl+CqXP8PhUf1JVNxMh7EcBsXps69t8MdXhHQk6LZ2FNqGVr993q8lW4Y5Ld+EdeUNNJNjjkaHkWGs5SXhMAD6VCHGzWtjKpDDSjFmATl73iXxt/3pt8IjVvkhAG2rI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071941df-c962-46ee-52a2-08d59db23d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:32.6150
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
index 164307b99405..1e0d8da0d3cd 100644
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
index d2b7192c0937..7f78daf88f35 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -639,9 +639,11 @@ int ocfs2_calc_xattr_init(struct inode *dir,
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
