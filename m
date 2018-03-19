Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499171-2-10406332176815764299
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
    t=1521499171; b=PCDwG7NKLPqwRLi4zKWyKYXfSlyKJ2ZOgtD4KYdcmc58n3V
    kk/C6uifCnDWHMgOhzUoRMhUKo2MCRpJyhlISJFhUUQYR7pQak1ET39O9Vby0S9z
    WiCYvsQ4pO+ByJW/RTZWvcjJ80xFc3tvYIrXGYYxGGWdkQu+RVjDBJ+iA78zF3//
    rX4+bsDyvZd84vMLx5H3Y/WMJ8+vNM25WCXkbC3p93tUKvB5SHQrBUCcxOye14LA
    R0ppv6xkVQslyt9EGixvfU/+Hv9aIKgE5kBDBIoqmye5QZPkbSIXtnt4HtkVrs1/
    rmAragwD7V+feEwx/GjLCllwefTg8OyJ2TeDpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499171; bh=mIJuwr
    jFuy00NElqImksnC9O3kkCJ6r8PR1wnoSdw/A=; b=r/tdzPvooeotwkfpF0MQcR
    o0XxyPxgMecrAUEZ1M79bxkCUdeKtL1rMvb673NFasZxNhvgrVecECtXwj4WU2Zo
    mZk/V8SjjVUxmhYv0Rv+lIlG1NSu8bBTcxP3kegtZCtVHim5KmG3lgN5qfJAduRn
    b4l+VDJuvHOcfomhsecAK6ewT5BJr1FcStaKjHOvhjKWAu0AAOFyFnP/NkskR2ma
    /3s5ju4WfPoMu5kRFk5kHWAd9KT6lMfk3yZnkhf//fNrPwWUhoR0LJufVd7dTfZY
    bM1dTfPejCalIaoyCCaLE/nTzbZTVt9CzMx1XLajk8UmzDNi9hRm9VpmFCnxhjTw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F26pXLH1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleekledtnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F26pXLH1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleekledtnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeCSWjM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:39:12 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:59200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933327AbeCSPr2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 021/124] VFS: close race between getcwd() and
 d_move()
Thread-Topic: [PATCH AUTOSEL for 4.15 021/124] VFS: close race between
 getcwd() and d_move()
Thread-Index: AQHTv5mQmSW1GNUcFEax9DZp3kcERQ==
Date: Mon, 19 Mar 2018 15:47:20 +0000
Message-ID: <20180319154645.11350-21-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:Vv/O+Rpegaa7wB1svYzaSzjrdp33bAtb7GN/M75QFMzVuzT59LzVu2wlu2djxMkia5uk50bTs9grpTDJH/S03liTM7rp0lmfnmbPHn/+0SBH/+ONxROdo3oXm5ZJkgZNlWOO1cuIbr0iAHMZ3fLqcFGNsiykmRDUEN48YZ0wezTBWN5tR0UGjXJTvqe0JfdQBjcXmRgaK6X0xlBLgUIS9Htngj1ZyEjIHXCEH8i3WWMroJ8V6x39J0s4+4sDdR3L;20:e4MfnvHM4SCkODx53hNujlvGpFz9XzkRqh38kPgXakrydh79N0guBo5/1eixSbFvRPDiBX7XTerNu1uSHNQYVlz7ORv1AYR8Vg1UGBUE+UiYKl4NKRprsvg4cGhsprWWBDi0BA7fJeOGOhT+9YeLpepwbHXaQeKJBJ/T1GqmSEY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49cbd878-b24b-4bc9-afc1-08d58db0b6ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998F75CDF2B5B7EFFBFB54BFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(966005)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(6306002)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /8eyMea0azY8MLfPA0E6vjSit6jWhjv1Tbm5JKjqCU3+yMdk39cZKEC9knYo7yhev+0/TeD0ISY/U5avQwdlaX0ZEZaUvkkd5iGJIYvdPb8WbA2pkLw2ocP+PZAR5iaZNKZeYU4AccJdetxDspNZW2pEhodnz3KSAFJx19pmwP2NPZyvdJvjSEqgHAIJF9MZDyQpIB64wchYuoeVnbMHYPCigXb3+XOAWAF8ONQV+Nf3w82UY/du1mRYG1bebNigy8lQISnaWThEeri5610nYFgmWusBnKfSi3HvV/NHpauYhPMoczRYd80+aJO1eLCeE6GJyNW/mFRzDVL7EEv86A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cbd878-b24b-4bc9-afc1-08d58db0b6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:20.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 5c7df1df81ff..10b47d16a8a4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -468,9 +468,11 @@ static void dentry_lru_add(struct dentry *dentry)
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
@@ -486,12 +488,17 @@ void __d_drop(struct dentry *dentry)
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
@@ -2381,7 +2388,7 @@ EXPORT_SYMBOL(d_delete);
 static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b =3D d_hash(entry->d_name.hash);
-	BUG_ON(!d_unhashed(entry));
+
 	hlist_bl_lock(b);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
 	hlist_bl_unlock(b);
@@ -2816,9 +2823,9 @@ static void __d_move(struct dentry *dentry, struct de=
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
@@ -2830,6 +2837,8 @@ static void __d_move(struct dentry *dentry, struct de=
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
