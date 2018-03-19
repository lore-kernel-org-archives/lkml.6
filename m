Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477509-2-12177983058243951745
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
    t=1521477508; b=rtwimz6Q8tg/et+vwwO76aW2g/m05DtlOOPetnjTTUOcUDa
    o4O2Ib47OdhWUxiH2sbxtzzdxPOxb/d5qXvkgiq7tRW9aSkuuwk0rl+0IIZtN9aT
    vpVCvrpZC4dqOSdSn8xnqoDklhrvMr9Vbj1CWe+z0GiPDMOcl7/J4v7CUmg+AsNh
    T3EjuOxUQO2Ykq+luL+EvIR53s+rXjYvyF/Auw/uNjY1PvWApgKRkf5OfR5vGJGP
    HEGAOJgAUiJcbaacx1q0Z69s/8iulAxwejkV8WA/sUQDYGbTC20tw7J6pDurFMOT
    C9qkKE5ugLZ2W3UFHu/PpuXgaaHnmREHyE+jsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477508; bh=jruFgD
    MN4TuKN8EsutFE/mPVlO2rWE5eeOPRJI0ZmTM=; b=Tp9RBOOkv7eVdqpvJQBdme
    E8O/sUwLy+GWi451TxzmTBf0H8qixpmZQXGP5MBTJwYXgY/atMN5+PH0G5mAy63b
    T+g2dAgu4vlra1iybWfrgzJwj3G8q+0ROgcFUzqLvb1pYdbEzp1ALj/y2SFEqtUw
    Z7NMyLcz2d1H/xhylVmugdYLIz4tHpDBp/NJW9gqrlMeHlpFuMFKoSRoTu1qMCBx
    eh0me0mnzXky8a+qXqunOLoUPfEm/h3WLBJjLyAg7X3HiI7jyd6kM8e+cZlKHbfN
    EtNy22QlIrmfebOB9OQRtc+zC0iej/T+jT3gmGc+iL1c+11E25EiftlN0n3jiZmA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W4ydNlh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W4ydNlh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeCSQiZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:38:25 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:10304
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935265AbeCSQNS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 056/102] ovl: filter trusted xattr for
 non-admin
Thread-Topic: [PATCH AUTOSEL for 3.18 056/102] ovl: filter trusted xattr for
 non-admin
Thread-Index: AQHTv50a+Ku37pHceU++LJOEzQTS4Q==
Date: Mon, 19 Mar 2018 16:12:39 +0000
Message-ID: <20180319161117.17833-56-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:VDYs2X8QMUDDsMygJ9UG6ElIy1KLZgAy28rlQ4ohwlAovZ4wJN5E6MlmR0dML3aHzPCQ/d4uji4QGpypQO4s+n7epVkOc0vnjTv0KpBUCtzmMnMLiaxg+TcRw3j6/GIwAPH20lX3DK57mHnjoOc9ZAz/9rw2VQcfnPUoPoKPp0gKP6006e4+m3jmK/JG+gfkyvhXH8edJYTdvwQaEW3YE7ISLU+tbrDM5r+RfLXZi+EtH0jTh6kJNhhqNsYj8Ikh;20:yLMI5UuwprBxPf5E90Yo+ci0vXr1FTCPjH8sAUatRaQuRo5zPZwPozvnjs96m5dRF3/X6j/f1D5xcKSMTqFz6XblNr9xSTOSXR6ph/qN3xgzN9nWVcx1nAnehiwrvDsDtPydxfJQpNTlSpL2IL4SA4zF9J2zah5z3nM9h89mL/w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 759c9d57-8967-4563-2628-08d58db451d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032C72A0CC76B653A140B6DFBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6Awzjd8Px4R36XQX5NTOyUam/YivNNqWY6bmGDW4vnlUV4yi2wzqoMNRCat0qwTpMZbsFXYmZDnY/6mAT/KyEO7mMN09Z+UK+vP6WtNislliPtw6XUg8uSudR72iIlTIQcBtNkEx2KLUwruIF3vAX0wzK62U6ihTrftEaVU69aqYtCwLe6irb2NoTweh6J2c7sxPUXJKvSsF528y2OTrO3y/9+BhpUjdXBQt4Rbn9XlyErn17OvS5N+TdTvJPBfIC30TrR4mQ7U3bQ7c/p+JHHyZGwNK4G61qbduWxKOuFoVoTYf50zabhMFNX/lsPibYDClANs64rMR5cXX+VtQ9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759c9d57-8967-4563-2628-08d58db451d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:39.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 6d52041d13cf..df5c2853c4e5 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -258,6 +258,16 @@ ssize_t ovl_getxattr(struct dentry *dentry, const char=
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
@@ -282,7 +292,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list=
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
