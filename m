Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496433-3-926675166689269850
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
    t=1521496432; b=EiQxEGPUJ+ChIT7AoS2DtqQ5omLcb30obGgquxomRLLKhcn
    FOX/HNUMaAhVyvCCPlJQu05P1T3v/R68VEFHDeDADI9OY7mRbS0Jeq5v7RBMxBMN
    oAOxxX8+5hUnxcVwwDl5DF3gIcusd1DX/qBCKbNGOPrDEMg1w0i3C5IcZ2vfqjuf
    +vkRbilnVi1PPmTVcWGRM0A8R+LUDQ3PvKYw6jeop6vU6mSAwNgfoLLr518b6QgX
    hnJnbKDXFEoFwT6X3taaYhGTDg2lC1pGg294WIY05XASXiqf10aguArrKxo36s0h
    VXAsNIOfNHGuDvNMIC8aLlt1ylFCxTgdj6Hy2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496432; bh=Lkh5db
    TwoG82op7jwn5tUSEYgya7InhTrknPJG2ZxV4=; b=syhige7iEDanI+c8i/thK0
    iWrSDwHhbpWBr7XN5rsmVMCNUifmFc8mVNW70mdZ8aAQvJw3ZhLQPYUB6gsKP4O3
    0YZSN8Ri8how4mo1rNKzDyMvFOskWDPy0yvGtI3KBDGz2QzrlENVreq9j1u+DToa
    fnr4rPM55LYvtFq4EUIP0kGiGXxB0y6n0WCTvqeucfy92cHdxBcKcYSw7H0dtzFB
    sxK1CrCOq6HuzlRwQGzEbbd4rCSO3mDMr9ulIEd8myw3kFTgTHUphBc0f4qNQMuG
    oHvgrg7YwadCydGVIpIWGhLGR5ShY7mIbFErh2vKRWFYadfgsfhYcXHOLf3tGjOg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hFGawt95 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheefjeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hFGawt95 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheefjeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeCSVxX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:53:23 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:31200
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934367AbeCSP5e (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 95/97] xfs: account finobt blocks properly in
 perag reservation
Thread-Topic: [PATCH AUTOSEL for 4.14 95/97] xfs: account finobt blocks
 properly in perag reservation
Thread-Index: AQHTv5rcL9OyKRfVwkmiTv8v9Yb8TQ==
Date: Mon, 19 Mar 2018 15:56:37 +0000
Message-ID: <20180319155411.12348-95-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:0BbX7V7eMZV35VKjuyPm6BNkgNFn6Vqhi9S5IEOnUI8y38euBmsMYtZACss5CLFDkDBRVDarAqZ/K5kuSmcJZVn+t6HIpqDVX+MbyWtAJETmDDw6iBUMZuXCTs69GhEbQmux83VkJwI9oSxzjygXEwQl76YoDaaS5RSDNYb8WeQU40oMkHqTvZS8f094CINAtBuJkePlpddAsOgs2c3VsG4iXkAETfcLwLtub2iQ44Q+vL4mSZsx6RZSLcBR530F;20:UJFKIyz0Yl7PqM1Jf116Llf1A2LmiXHdn/1YwUww3mbB2RiZnBq/sGm/97NcrDI9yKVKVfgx7XSqZNuRKsw4jSiPPhm+yiZWxtq/mYYwoH+IlapM9E7jXWLBx3REmNXmte1Bb2JrLvHBYWyWaxsDa+r1zm+qAUJ5rwBwTH8SUrg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a72e0bf8-7974-47c6-f264-08d58db21d22
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10962DB01FBB717AB0915E39FBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(59450400001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(6666003)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(551934003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8936002)(8676002)(15650500001)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sSSApb8sMRDid2qLlzh8DaaL2LGdAZmDgKFBierr1LlHyeMUxeeV6DnO/UKBQyVFR7btRcd1VgcYevBdFeLGkEkbur8CKa08LOA48uiU9ox881qr6UKXDmq15hHZo8KH9JdAaHvBzH5MUsPvKmr8lFnI0Ajn679wN8uVEvVlCOVzHnH/LTCIxcZmfCWLfULH9yKLMrlNlBtki17GW4qmLVC5/zG5twCiEfUPxUrY7ROjBTyfyc5TqF5019YrvhR9/v3GNN4NkhdxWpWuiAGTNsDbcAG3JBbSNcaOUmLdkGbmI9e9FzgWaZF7p5EhwnnHTIYxggNYS7SbuL/8rQ2vVQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72e0bf8-7974-47c6-f264-08d58db21d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:37.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit ad90bb585c45917b6c1bb01c812fba337e689362 ]

XFS started using the perag metadata reservation pool for free inode
btree blocks in commit 76d771b4cbe33 ("xfs: use per-AG reservations
for the finobt"). To handle backwards compatibility, finobt blocks
are accounted against the pool so long as the full reservation is
available at mount time. Otherwise the ->m_inotbt_nores flag is set
and the filesystem falls back to the traditional per-transaction
finobt reservation.

This commit has two problems:

- finobt blocks are always accounted against the metadata
  reservation on allocation, regardless of ->m_inotbt_nores state
- finobt blocks are never returned to the reservation pool on free

The first problem affects reflink+finobt filesystems where the full
finobt reservation is not available at mount time. finobt blocks are
essentially stolen from the reflink reservation, putting refcountbt
management at risk of allocation failure. The second problem is an
unconditional leak of metadata reservation whenever finobt is
enabled.

Update the finobt block allocation callouts to consider
->m_inotbt_nores and account blocks appropriately. Blocks should be
consistently accounted against the metadata pool when
->m_inotbt_nores is false and otherwise tagged as RESV_NONE.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/libxfs/xfs_ialloc_btree.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_bt=
ree.c
index 317caba9faa6..af3c20821a48 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -141,21 +141,42 @@ xfs_finobt_alloc_block(
 	union xfs_btree_ptr	*new,
 	int			*stat)
 {
+	if (cur->bc_mp->m_inotbt_nores)
+		return xfs_inobt_alloc_block(cur, start, new, stat);
 	return __xfs_inobt_alloc_block(cur, start, new, stat,
 			XFS_AG_RESV_METADATA);
 }
=20
 STATIC int
-xfs_inobt_free_block(
+__xfs_inobt_free_block(
 	struct xfs_btree_cur	*cur,
-	struct xfs_buf		*bp)
+	struct xfs_buf		*bp,
+	enum xfs_ag_resv_type	resv)
 {
 	struct xfs_owner_info	oinfo;
=20
 	xfs_rmap_ag_owner(&oinfo, XFS_RMAP_OWN_INOBT);
 	return xfs_free_extent(cur->bc_tp,
 			XFS_DADDR_TO_FSB(cur->bc_mp, XFS_BUF_ADDR(bp)), 1,
-			&oinfo, XFS_AG_RESV_NONE);
+			&oinfo, resv);
+}
+
+STATIC int
+xfs_inobt_free_block(
+	struct xfs_btree_cur	*cur,
+	struct xfs_buf		*bp)
+{
+	return __xfs_inobt_free_block(cur, bp, XFS_AG_RESV_NONE);
+}
+
+STATIC int
+xfs_finobt_free_block(
+	struct xfs_btree_cur	*cur,
+	struct xfs_buf		*bp)
+{
+	if (cur->bc_mp->m_inotbt_nores)
+		return xfs_inobt_free_block(cur, bp);
+	return __xfs_inobt_free_block(cur, bp, XFS_AG_RESV_METADATA);
 }
=20
 STATIC int
@@ -372,7 +393,7 @@ static const struct xfs_btree_ops xfs_finobt_ops =3D {
 	.dup_cursor		=3D xfs_inobt_dup_cursor,
 	.set_root		=3D xfs_finobt_set_root,
 	.alloc_block		=3D xfs_finobt_alloc_block,
-	.free_block		=3D xfs_inobt_free_block,
+	.free_block		=3D xfs_finobt_free_block,
 	.get_minrecs		=3D xfs_inobt_get_minrecs,
 	.get_maxrecs		=3D xfs_inobt_get_maxrecs,
 	.init_key_from_rec	=3D xfs_inobt_init_key_from_rec,
--=20
2.14.1
