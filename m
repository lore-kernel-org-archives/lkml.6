Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480101-2-7122397821945474972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480101; b=LdDOJB6ayYU4YUp59koSgemTtoVxEE2AAhA+Lm2/Hq9h2sW
    cD4yLpqMJ6FEctXgEcrMWaQmIYZk1Y9SyFtINCeTmZF0gaVJkkBuTeKSPKUVnAG3
    uOE1hw9qddqUz2q7wy14PnqVzqCh+KUC9bC/c236MY3rmw4A4qHJD6B4Bbofp3sc
    IdBiKAXwnoENNmJGSkgXa+UcqalMSJL95RMhw1wgyC29FW6BNzP8KfWGNvU6ChGz
    j1VofxbdWJ/uyZCclmk3uMXvVhYqWpRtsbSGfQrafeVy7+7hQwi6Un4QU64NoD0C
    zWYICg7ToK0+NGXcVZHMBCmKBGbmeg5YQTaIEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480101; bh=63rveW
    nw2MF6M0vedUr+UcZYRfFwoZuilXKSEHQ7EkQ=; b=rxrTMG9Z8UcwgoLv5CEyU9
    49rJb/AAJE3MqLg/2JFdP8G5PKdWa2q32WFYiuxvaGp4geFz63hLhpxN3H55yP2B
    JuJ1kckDVC2PTajrwnboHJ4uLwOfgswRI47wLU7Zn18phbL1KCQBu/8wEqSVr5a2
    xbabP3E8Fm6eIWdA07EtHCSzCIkKLOpS8+1iiNj7xLTxTf2lKZYLtbmvi51lCRLx
    /8aX7uai4qWX+xEP93YwfUcFZl9///zWDuUGUSO4ky9r0vzhGK1NVOVAbYeRN9sm
    GFEoe+9LeyQ+hfCNXEUgZJvbtV7tY4SS4zjVAaA9u+MWXA04MThMBQ9GEVQ9AvYw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iaz5enx9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvvdenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iaz5enx9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvvdenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966397AbeCSQJI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:08 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:45505
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966300AbeCSQJD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 065/167] selinux: do not check open permission
 on sockets
Thread-Topic: [PATCH AUTOSEL for 4.4 065/167] selinux: do not check open
 permission on sockets
Thread-Index: AQHTv5xFQmPkkQx+qkelfFQvFjie5Q==
Date: Mon, 19 Mar 2018 16:06:42 +0000
Message-ID: <20180319160513.16384-65-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:YyJp296DxQpeaUEkHnW4gUmi2hIYKv/Z6NQsTmEjf9UHe4VLhiXdyuT5kHshfLbyEGYe6MO0LMxhvQJqZ28IDW9AQ7gYrq+lk2COjUmTOeDkfzJdJ5PeiBcnpeREmz5C+lA4Un8bEcpSrcPzulFDweQmW+c4pI8Jm1bOS9Lna4NP/DyGlGgGm90KcuWn0fUQyUc9pkSouR+OiLysmq1qZ1lr1eZZirOdfXioX7V2EXPa9APOzJEcDKBY13EIlNAs;20:wEf+cSQAmS6rjQiz1PFXzzcNydmFTuPumlJfGUk41sGe1CDg6xMLtAzHSugQJxzF1BUQeLo14W+SLVlQsRynwCVsWRe9f4FVAiTIps7Rc3v2LFZjsXKSWZm5HihNPmCvMO+nh5IqLON34dGWkmsIHeLaTamHXHv/bujdlIEADd0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab5238cc-9ca0-42d9-37f0-08d58db3b7bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965C992993C590357470120FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JqeJeUQM2jnDdrGXI4dqCy2/y42kDpzluIeLwLDO7l6c6AtAtAum9defC1OPFgYdErw307AsRoXtZiWCdDo5WlGjIbtQokHScivDnxlxJWxGNdXNIaqRR52Cp3VzXJAvkj0xoNwK4yQxzFO4vr0SI/o01DANwZPROnRu+6vdyJA4P1lfLaQ/qnnjxLrVlK4iF2Ye+zqCK5SCoPOTsv7I6CZoMHNP49zZasVnw4AFuiCckLbu0BmAPF86/kiutRK1j1tnFrbXJ7e5/5pyvB9uUTTMuypnRVBjFc3xbD5XiIyQ6FbMnMhGA8DGqgdQArCSw5PnUDv1ESf29zmloYc2jA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5238cc-9ca0-42d9-37f0-08d58db3b7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:42.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Smalley <sds@tycho.nsa.gov>

[ Upstream commit ccb544781d34afdb73a9a73ae53035d824d193bf ]

open permission is currently only defined for files in the kernel
(COMMON_FILE_PERMS rather than COMMON_FILE_SOCK_PERMS). Construction of
an artificial test case that tries to open a socket via /proc/pid/fd will
generate a recvfrom avc denial because recvfrom and open happen to map to
the same permission bit in socket vs file classes.

open of a socket via /proc/pid/fd is not supported by the kernel regardless
and will ultimately return ENXIO. But we hit the permission check first and
can thus produce these odd/misleading denials.  Omit the open check when
operating on a socket.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/selinux/hooks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3f370eb494d1..d41dd75c1804 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1958,8 +1958,9 @@ static inline u32 file_to_av(struct file *file)
 static inline u32 open_file_to_av(struct file *file)
 {
 	u32 av =3D file_to_av(file);
+	struct inode *inode =3D file_inode(file);
=20
-	if (selinux_policycap_openperm)
+	if (selinux_policycap_openperm && inode->i_sb->s_magic !=3D SOCKFS_MAGIC)
 		av |=3D FILE__OPEN;
=20
 	return av;
@@ -2928,6 +2929,7 @@ static int selinux_inode_permission(struct inode *ino=
de, int mask)
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iatt=
r)
 {
 	const struct cred *cred =3D current_cred();
+	struct inode *inode =3D d_backing_inode(dentry);
 	unsigned int ia_valid =3D iattr->ia_valid;
 	__u32 av =3D FILE__WRITE;
=20
@@ -2943,8 +2945,10 @@ static int selinux_inode_setattr(struct dentry *dent=
ry, struct iattr *iattr)
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
=20
-	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
-			&& !(ia_valid & ATTR_FILE))
+	if (selinux_policycap_openperm &&
+	    inode->i_sb->s_magic !=3D SOCKFS_MAGIC &&
+	    (ia_valid & ATTR_SIZE) &&
+	    !(ia_valid & ATTR_FILE))
 		av |=3D FILE__OPEN;
=20
 	return dentry_has_perm(cred, dentry, av);
--=20
2.14.1
