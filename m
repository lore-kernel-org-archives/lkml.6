Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234809-2-13793536917628414848
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
    1523234809; b=t95Tpi7DE7ob+n1/Q9CysZDkAmbW9ocCcB2M6Sudm5m/bSwwgn
    TV6daM23jMYwxO6/JWFVz78v2yxKmfj5J/1L8XuMiBQalF2F/g5PRXc9viLhn1iY
    /1OMscOvnYvNMIGWVJ2eABS4go+ZIkijXb9ZSDA+BMxfGX3c4fWHW5axSevNSzKe
    XenmnDErE1bXQ0fUTpfgvNDkvjshwkvD6x1mpku6PyxjCV/YjBQsKiCtHPp/wFhy
    dweh0aqe2lk3wg2LLOwngYsuGNtbQe5uVF0qx1fxyg1SGrSk4eR9RyfUTRv34hny
    umQHwFA6vwhiknWG0UgBJcWPyixfrybIMl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234809; bh=cyWuJwmgRx
    DYsA5J7m5esUwq9o6erHmhxXV12FFJkWY=; b=R+xHBpUPx/2dWviM8eOY1ccjbU
    2OFudJAVzqqjpDz+rlRmMzjNmkYQn07cMXw2RmTa1B+betslWvIBMmgCJZa65nRh
    bzgb1eS3JOfQrzffhIcuivjLwi579nzgztJPIJyBqefSOgEO6TJmMa87FLP5J4KX
    ZZf2IjsoTm8bpwZbgeCnj1HDgCfu//ztC2F7ZnPx++eit4oru6tk+bUqDwKckaLI
    Udu9YsSVDaGNnpGSnPzd5j7/EmZx68p+HGx5fylWffT/a3/C2326PI76zlLrSR6F
    BUmrKXET+cbJjOdXKu65frnmDI/HFMZuWqH2Pxl2KLWw7yNSCbArEJERhqhw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJKo8AKf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJKo8AKf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHqzwA7KqPJQHiGDrRja8Lf9ZjCSJfJ2FgsDaG7O2SyRTJIyPNfbnKpdKEoUOU/yE3AU4z5k7pK50DGza+rgM/0T1SKtO3dZhxxz/A+7VlNLorY7iwsK
    TDNIiT4p3s5zDU6in3YD0DdutVztsT4mw0GlLB5COKdHgVNBKYe6LemyzLlElwFbQHCBFq3uUD07MZgy4f/AHk8fh/8zoJcGG5i/f+kA0Sg+O6iRgtoiPvsh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S932797AbeDIAqn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:46:43 -0400
Received: from mail-sn1nam02on0092.outbound.protection.outlook.com ([104.47.36.92]:18624
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756731AbeDIAmQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:16 -0400
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
Subject: [PATCH AUTOSEL for 3.18 083/101] ocfs2/acl: use 'ip_xattr_sem' to
 protect getting extended attribute
Thread-Topic: [PATCH AUTOSEL for 3.18 083/101] ocfs2/acl: use 'ip_xattr_sem'
 to protect getting extended attribute
Thread-Index: AQHTz5uGgT7RSMZOTU6dyLSucTN2Bw==
Date: Mon, 9 Apr 2018 00:41:41 +0000
Message-ID: <20180409004042.164920-33-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:T8EoXJlf0BhYZVGjvw6+ayiZ35v/Hq8hCC3iLHdSJA+BeBTMaImgsS/WLzy04V1ZamUNAN2ViUftqj/D0/UkfbMj9sdh+6fPFC41XrX8CuNADTcVYxYAnFNAfgA7aNakSJfnQ8S3nQ6jwTdKMtM4iYNeXnbyj3lEDMiLusdXD4jx0egDCLBQoM2YLYG1TsMUVKx5pqGF4kK1G+V5C8K0sG0jFFEtiZBZnWa/fqaAr8brzDkGMabC5oq8NNrCBh3q;20:4h9D8CAG5540nBnEZ+sst6ENMb0A3YgPFFl0PKXiGTmzzTVHJp2fgNVAV4yGsLJMLo8z5D/SHtibxIhEvcwubUKElXU6rms32oE4V/Kfd1HpeOUsNRyjG2+ZvhhHDG0aLANi5W+89I1yhh93531zpfMdtIZxKpu/apOgOlkav1Y=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a228be3d-3d72-47d9-ef84-08d59db2bc48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106211A5486F59ED02B53368FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(7416002)(6116002)(3846002)(305945005)(59450400001)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eMOT7qtZqW9N1N+UM2LEKgoXf2Z1hRbTYdJt2PE8NGeIjSEh/hkK3Ol7qici/MM6goc/nTGICriKxH3VSANa6t1HbWVn68RKV9DdU3cie39+N9bdVrfkxGfAagaKjFs/EzR6ychxOwbR6lHcxEt0/pkDvb11rvwgNKWqjQZBkh3tAQrjx6SZuqd3O5mxI8Z5W/Jdqg89cY7kDA8cCmKL0wE/Jky9T9w2PDhVTUkpTADDqFB8MZLGTKAK9ZNaez6kcpMGoqCw9X/kPlQJa3HHiIhaCi6asJTeAtbOuEqlfLw1Bw4TqBmjfUcr60p6zGbLrv+PORQQ2+8iAFOBFgKw6mcZoCN2+xk8ITvyqNql7qEw3oCSO87ejqJj9sYS6roUi9hFu1ljeRPcQFyfGLjIrbeuz8lDfbOcjcyt6mpb+DE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a228be3d-3d72-47d9-ef84-08d59db2bc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:41.3772
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
index c7641f656494..512be47d9c44 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -300,7 +300,9 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode=
, int type)
 	if (ret < 0)
 		return ERR_PTR(ret);
=20
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl =3D ocfs2_get_acl_nolock(inode, type, di_bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
=20
 	brelse(di_bh);
=20
@@ -319,7 +321,9 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_=
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
@@ -350,8 +354,10 @@ int ocfs2_init_acl(handle_t *handle,
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
index c237008c010d..068e8af5388f 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -645,9 +645,11 @@ int ocfs2_calc_xattr_init(struct inode *dir,
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
