Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494486-2-15673523571016967830
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
    t=1521494485; b=wJm0yhhHgyWhsu/BglgR8EvgRprGr07TzvyYUuS3tD7HlyI
    TZMiCy0GqZsXjKxF8QDGAFdNmZJeEryW0vFiEDb7DoGWELD6era0Q5/f4xiQQKqV
    7+g/xeORK1fb7EyqXk0x3X9g4SdsE7AYh4bRpLmoqvbvRbopTjVB1faJaEqFHrxL
    rvMF1jtojb+R136vfi9q5xxkK3jB/G4rcXmxlCZY4n8QVNUvMPd4UB5lVL+iHDcr
    2Jycb/kiYQgglLUpRAPxrNCJqDBwjEbEvufO1Ax1BRXU/Tq4bQSbaA2DRU5pNwcA
    r+day9emnofYIss+nfb0LOJ3479dPYGbbZDCiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494485; bh=oAVqzO
    DNrVIIR4U/KbiZ0w0HCimhrokN6EG9mD3AOxk=; b=tK4HZW2wPhUtoLTLhlW/0C
    Zes64MisD284zdZdiXDPVQV+oNIUyjKn5kSZcwnbFsP9Al/kEDMac1mI95yLhdk7
    dnooALnxTnXCcCOgfBsevkjoBvws2dy8x4t1YsAD9TYtRKcicc34s+fMvEmFdkSw
    WN1xkHImVe3LCu3umbi+ErcA9TiayiDRF2ozxXxwtRN1V+xNOQIKwBBu88r7nwzV
    OZ7KraZdmrFee6w8l1j96MLdWumeM8gHO1MapNT06CGJbPKPPdmQcM1MTSHn61BC
    B1sAQDmIX+akumG3b4wPgHICGJw48DtH2OMk1ciyeRU7HmHhrLzSbmV43TcCTP3g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqKlM93N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvfeenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqKlM93N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvfeenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969820AbeCSVUu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:20:50 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:4912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934310AbeCSQAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 097/281] selinux: do not check open permission
 on sockets
Thread-Topic: [PATCH AUTOSEL for 4.9 097/281] selinux: do not check open
 permission on sockets
Thread-Index: AQHTv5tO4GFWglk0mEmJg9D4KhfStQ==
Date: Mon, 19 Mar 2018 15:59:47 +0000
Message-ID: <20180319155742.13731-97-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:YTrmDtt6903Fq/w9XmT8f/56BqZtSxNcGNWW2gs6WqcPzqu6EQE8GdNkNAC3sunzWW1S1Zm5LmuGkyGdIY76nOoiMuoQM217zkysiuqdLhUDgq9yGWesVaHffdB05rZiANTU+nbK34Kk5aLeQicKpxE6Sv/zEVfulNmklVhOt4OPScqX1VeCAmYmIFYs649bTFyS23sp25W7jN7aG/UPY4+sF+iOiajNprJJGEdxROXM+N11kcnVfwB7tQslQl7L;20:EJeyjDLUWOgMWwr3eWXuJaPmwvoa9CNpynkU9DZF4TvxhNKCVOIZ8KCicItx9Zco4zZaxuIlWTDovg5JSSgZhQIWZ6WfvgIV7WGX3H7n2SVy0e7wtvO3bdNO0Hg9u7M1/KocPGCDvotcXt9vlLEdf+ZiUSDY7hK8rnC1+B4sZpM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6610d526-321d-4266-9b98-08d58db291aa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933EDDC2E1C0F412F028182FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: icmf7CMMjN/wsMAdovH4o8VmoC8l6A/MCZ0oStvF8zwPdTPuY10SOGDLtoG2i8VgO+Kc6M7fB8oWsIjoE/TS7QtCJ+rPz8zcvnrlj90LTSK5INJSaZegDGVeicCZqoxr4CNDtyvV7VsXQq/20UW71hkHBZJPI3TOnx2dta5buKejpNSilu6AwtGMgVsltTMi1n5mrF/WJ5f5O4UHMPfyFWAgS7gCsarRpIOz+icf/nCN4ZrVSsgdVxkJOtD5B656v42yss72jnIlKrKp2cItq8yB7YKPTO9LerGvS7YNS+pmCxmk60QKtbXue9KZPKEiHnyktMvT9XP57ECzs1mVXA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6610d526-321d-4266-9b98-08d58db291aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:47.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index c2da45ae5b2a..a3d2db613974 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2049,8 +2049,9 @@ static inline u32 file_to_av(struct file *file)
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
@@ -3047,6 +3048,7 @@ static int selinux_inode_permission(struct inode *ino=
de, int mask)
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iatt=
r)
 {
 	const struct cred *cred =3D current_cred();
+	struct inode *inode =3D d_backing_inode(dentry);
 	unsigned int ia_valid =3D iattr->ia_valid;
 	__u32 av =3D FILE__WRITE;
=20
@@ -3062,8 +3064,10 @@ static int selinux_inode_setattr(struct dentry *dent=
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
