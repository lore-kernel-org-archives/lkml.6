Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493743-2-4542152582591361633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493743; b=Ye7ufchbjqCer6AqFTTcWVsJvHqm1aIC4xya6Q/UBxA8bSJ
    5Pz/rNBBQYYyS+iNCySWb3JsY9z/mmw5yfdlBTdY+Il6mN+OEq3UDneflafyDiCV
    vcYas4YEcW15uSWrYKOe1FoFdWAJGI/PjOD/rtnm26ylFN1dYZOWI5GM7b26gqQt
    nnJu15+OwTaqWpX6vwf3LNelMeab2IMLtybzxRRIebXlULWOt3h7ZitZ4YkZGNXN
    BGFE1BJ661U0lSjOVvexmruB4AB5SPvgPUJrdyJieqUlIpOpgJP9e6B2QViC/IsG
    osxaOiNWX4VDgotqatOfpj2rZHFIgm4UOEFFs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493743; bh=kP9jKz
    PX1c92pnQVgsyKg7k0KvA+aHX0IgM3UkcayMI=; b=PD5bTIRZl2DD+rOR2jw4AG
    EeLMl/JfW1k4B1HmiqcSAR+MZ7LOCUdPQfrKBAT0d6mneunz0S97CYYpgLvKLTjJ
    2qqnIyrIQsJ4uNfIic1cm60IJAfJNpTAw6SQQHzz3ri7S4CrKTDIrdCnAxCHQokR
    bbkb5OPn5ke0S+m5n4bCje8XTYP/UgMbmgyblFfK78mu7g3xhkdcwB3kdJ9joAQl
    e6tq99Z501EKu+OqUsBL51QHygAQTUu5g3tmINJW4kyV9yK9tmC84b3sXfo7bwmL
    GaGB37723v7OR+vDDbIYiJZLPqphJE0sU3/xRLWx8Oz+P2OeuCqQygEjW5VgB9hA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YlkYa3Ag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleekkeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YlkYa3Ag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleekkeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965366AbeCSQCD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:03 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965357AbeCSQBt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 130/281] VFS: close race between getcwd() and
 d_move()
Thread-Topic: [PATCH AUTOSEL for 4.9 130/281] VFS: close race between getcwd()
 and d_move()
Thread-Index: AQHTv5tmBwsaMjebNEmDaPcYUe3y3Q==
Date: Mon, 19 Mar 2018 16:00:27 +0000
Message-ID: <20180319155742.13731-130-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:Wq3rh07lJcboXLfeHHq6kP87ecw+1Yly08j8q6JsGmCwtk08EqY2z0uiMekaFnxaw7t73vS1/0JYJOlY9mxgjG7nqRGZ2UmMSSIDdkLlxtqSRP4p8WXO2F8XVxpoINiTpYT5Mkm0ihAOqQTgBHGC71w8RHpmhKLWJw+a7bEM8i5lZ0VuDyGJYF/FHoM4Dagi0GIhZdkQH6Z53XO3DvdQv8565hjirKTv5WpqNuEwN5ccpH/aHgBU5xkgEczU/lmS;20:jlof7cr/o3qhWjqXkOcEoGk0iN8UsSoohf1GEc9NmAbrVUpDgj2q1pJfSVb9QnPxEU7sW5WDMaxhDkKwIkBA9XTh8J6sEojAk8mlB2l9NFABBr3v+uiYUJLTRSAH7EWhdCtWZu/N5gKwO3K3VyUnzyzn9Yi336TAmEuMkowiiV4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70b77889-529a-43d4-e92a-08d58db2b741
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919DB5D3DF47ED33895F86CFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6306002)(6512007)(99286004)(102836004)(966005)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SruzMwGOzCtswjcSIjXUMP3pz128fV4ZIAXdAmBK007KaoyG08LGQ/cMF+pJWZ4lySc2KgDwPXvw7gFf0Qox3S9SDChVUXFcR2gIVc41mxjzhUO8cEdTAGBDNZF48pSCDssEuQMqvO0tXbEXxFi7W20F0v1teV4jcE8hDjjgkWi7EP3H8mJ5MT8bhC4vP3QTYbvC5f78pWTGaNsiYjoIkcQBvSBxbX7fWoepy/Kgup5Um8QkvXVOBvsYgydhttsLgXfvd44qFQ+B06TLGL7fTvZYnquCl3z0YtnwpF9Ve8iWbEEMFlFh5rYUKXtV23VBNGuyNQdrRPStrOIboRfaKA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b77889-529a-43d4-e92a-08d58db2b741
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:27.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 61647823aa920e395afcce4b57c32afb51456cab ]

d_move() will call __d_drop() and then __d_rehash()
on the dentry being moved.  This creates a small window
when the dentry appears to be unhashed.  Many tests
of d_unhashed() are made under ->d_lock and so are safe
from racing with this window, but some aren't.
In particular, getcwd() calls d_unlinked() (which calls
d_unhashed()) without d_lock protection, so it can race.

This races has been seen in practice with lustre, which uses d_move() as
part of name lookup.  See:
   https://jira.hpdd.intel.com/browse/LU-9735
It could race with a regular rename(), and result in ENOENT instead
of either the 'before' or 'after' name.

The race can be demonstrated with a simple program which
has two threads, one renaming a directory back and forth
while another calls getcwd() within that directory: it should never
fail, but does.  See:
  https://patchwork.kernel.org/patch/9455345/

We could fix this race by taking d_lock and rechecking when
d_unhashed() reports true.  Alternately when can remove the window,
which is the approach this patch takes.

___d_drop() is introduce which does *not* clear d_hash.pprev
so the dentry still appears to be hashed.  __d_drop() calls
___d_drop(), then clears d_hash.pprev.
__d_move() now uses ___d_drop() and only clears d_hash.pprev
when not rehashing.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/dcache.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 67957f5b325c..c697589fddda 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -461,9 +461,11 @@ static void dentry_lru_add(struct dentry *dentry)
  * d_drop() is used mainly for stuff that wants to invalidate a dentry for=
 some
  * reason (NFS timeouts or autofs deletes).
  *
- * __d_drop requires dentry->d_lock.
+ * __d_drop requires dentry->d_lock
+ * ___d_drop doesn't mark dentry as "unhashed"
+ *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
  */
-void __d_drop(struct dentry *dentry)
+static void ___d_drop(struct dentry *dentry)
 {
 	if (!d_unhashed(dentry)) {
 		struct hlist_bl_head *b;
@@ -479,12 +481,17 @@ void __d_drop(struct dentry *dentry)
=20
 		hlist_bl_lock(b);
 		__hlist_bl_del(&dentry->d_hash);
-		dentry->d_hash.pprev =3D NULL;
 		hlist_bl_unlock(b);
 		/* After this call, in-progress rcu-walk path lookup will fail. */
 		write_seqcount_invalidate(&dentry->d_seq);
 	}
 }
+
+void __d_drop(struct dentry *dentry)
+{
+	___d_drop(dentry);
+	dentry->d_hash.pprev =3D NULL;
+}
 EXPORT_SYMBOL(__d_drop);
=20
 void d_drop(struct dentry *dentry)
@@ -2373,7 +2380,7 @@ EXPORT_SYMBOL(d_delete);
 static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b =3D d_hash(entry->d_name.hash);
-	BUG_ON(!d_unhashed(entry));
+
 	hlist_bl_lock(b);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
 	hlist_bl_unlock(b);
@@ -2810,9 +2817,9 @@ static void __d_move(struct dentry *dentry, struct de=
ntry *target,
 	write_seqcount_begin_nested(&target->d_seq, DENTRY_D_LOCK_NESTED);
=20
 	/* unhash both */
-	/* __d_drop does write_seqcount_barrier, but they're OK to nest. */
-	__d_drop(dentry);
-	__d_drop(target);
+	/* ___d_drop does write_seqcount_barrier, but they're OK to nest. */
+	___d_drop(dentry);
+	___d_drop(target);
=20
 	/* Switch the names.. */
 	if (exchange)
@@ -2824,6 +2831,8 @@ static void __d_move(struct dentry *dentry, struct de=
ntry *target,
 	__d_rehash(dentry);
 	if (exchange)
 		__d_rehash(target);
+	else
+		target->d_hash.pprev =3D NULL;
=20
 	/* ... and switch them in the tree */
 	if (IS_ROOT(dentry)) {
--=20
2.14.1
