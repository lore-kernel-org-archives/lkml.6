Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475819-2-785118771700006118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475818; b=lds1+nhWwqqDr/Ed1pJRn+bG/IEmptuk6lSSzDRgtbtfQfS
    /y7W1hkyJgTVnMdPGtCgyUtLZDAjkfgsBBReuOhoE6rNYeJlDhmSE/8H22D9d4Et
    wwejh9SxOrX1MpKBBTW2Vh2CKpU+I4ipCOSCVIeMWlt42OzcpVRexnwuVn2PtILP
    ptSYDqH2V34m0b2xQHOP+/6W3gVCTNOFG+Ynhpxx/8F46AnRPYm30efVM0LVL9mS
    fA5xf6PpCwr9hZ4DHMm/kicChtaj7Tw7ptjq44OkHoiYuL4R+MXlZ9g0TMRf32pU
    4IQ/6aqsRAPiKTt8Ces+UoEh6hHqtTLIUM+vfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475818; bh=CZ8XzU
    gUuoB1uieydTG+jOS9tM92U1ll6acT9AN6Uls=; b=XXvxjLsHthxb/FNDTVYvjV
    iWg4Jk5GTOC57gOAHtZ0V4QRXIpoA5cUUOTrmxdkIiwqZCvpbOBK697EWlOpQ2si
    3RGnuXCXdSULlc3G9dmTAwgWMPgmo+opb2GiF1K/6YIKAzYPqce7uZq3yJQaaECB
    cqKcmFYMHQWkUYMQuAahKarVH12TJ4wqEw+3drdNywsIwvD3JLk11y6+sAvAYDSU
    p+G8sVsNOH4E104kjgyRiH28wR/7hLsaKAr0NmM6X3rcmuLlgmCxjOTKjk8LYpj2
    fjAWgzPxppatO6Ce7ZoJqapow3Akh31HIubxf3SHgD0LyPy2QeoomPfNIFa6UKBQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dTcZryE/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieeinecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dTcZryE/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieeinecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965918AbeCSQKO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:14 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966536AbeCSQJ4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 099/167] ovl: filter trusted xattr for
 non-admin
Thread-Topic: [PATCH AUTOSEL for 4.4 099/167] ovl: filter trusted xattr for
 non-admin
Thread-Index: AQHTv5xfai/CuIT3CUWUgLLDkcW18g==
Date: Mon, 19 Mar 2018 16:07:25 +0000
Message-ID: <20180319160513.16384-99-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:F3eEosKGinlY2qGY7fcBEoHl+QCYF/Ky2/yJkQeLbx3tP6oxm0HNEQ5FPCI7a5pyRgXSBCoGJMfcBJ92vkbB2Ty+ZiSsP6aGlMF2/dZVRwvpILPdmRyKYiORgNdgH38Sr6kjH9Vp7d9OGG35sdLaieTmwRNJDkBlXAWxU0nkKzfsHbhBnf1Y3HQUX6JK21kEUGu9DqmpkAAohvJOOAGc/tjn7SNMMfLJ+VDH0n2aJ9T1kFh0+vDfsu+qJFg98igi;20:dKl+S3HjEFgbqn4Q1LjIgRICP3DfKQdTptTSUVAx2Nx7IeMH0maUJSkxzqtKzoF2/gc0/2NqCuAnubPAlEPStcWmkOgsnNIiWNFNN3Cvf3qQPy3hxRa/+ms+KrNwnwDMO8ddXo/Y24Jr9fl0HPCg5cpn1PeUPqpVE3mOsYY+aHI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e336fb05-f338-4c9e-a512-08d58db3d939
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10952C5F5B93469F6DEC5219FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GeAYIATjwaeBSiEbAZUUuNNo8dNsRbh2W29QdM2fT1mAVxBErOmS7JLqpuwKpaGz3Rn4ggUFtTCkssm2byiV5jDE8jHeJK2+xXvnDEpR0tKDeAmkBTTg/f1wDQB9G8g0olnFOly5HxDlmkuqiCQf8arvmz0984ToTfK89/OUDjS4VICU1kK7uu15NfcUCO4r6uT7+KpfMUx9Rv4cqvgx51+fewDYLFf9A4JwW2HZLgFHIIbJZ8WQED2/nRECWzkQ74vO1u1LGVYRljWlI7DvrhaPqkU4E0EujIzJ93WEUigGKRrHNL4R+cBDThst0r9FtT7FMEnNAYvYI89TEktJDg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e336fb05-f338-4c9e-a512-08d58db3d939
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:25.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a082c6f680da298cf075886ff032f32ccb7c5e1a ]

Filesystems filter out extended attributes in the "trusted." domain for
unprivlieged callers.

Overlay calls underlying filesystem's method with elevated privs, so need
to do the filtering in overlayfs too.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/overlayfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 220b04f04523..985a4cdae06d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -272,6 +272,16 @@ ssize_t ovl_getxattr(struct dentry *dentry, const char=
 *name,
 	return vfs_getxattr(realpath.dentry, name, value, size);
 }
=20
+static bool ovl_can_list(const char *s)
+{
+	/* List all non-trusted xatts */
+	if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) !=3D 0)
+		return true;
+
+	/* Never list trusted.overlay, list other trusted for superuser only */
+	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+}
+
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	struct path realpath;
@@ -296,7 +306,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list=
, size_t size)
 			return -EIO;
=20
 		len -=3D slen;
-		if (ovl_is_private_xattr(s)) {
+		if (!ovl_can_list(s)) {
 			res -=3D slen;
 			memmove(s, s + slen, len);
 		} else {
--=20
2.14.1
