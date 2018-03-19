Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474652-2-1475031407824015376
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
    t=1521474651; b=Z8kh8lHXh+7GIlLXsxBG40C3k/QNdPYS3ZNE/DVdUkIwuAH
    ilc+MHpYS9YidhK3Mkpbzl67ow6Kdnmfi78z0Caf3J9wIRemC9oJGkzeDyywgY3p
    BarZrkeEB2NlE/1tNwcIlB94wGWYt6rOigSSrRtVu2UiA0ulb1ia+We5TckPefUt
    5dn8Y2i4EBaRI9YkTIwPPkGMJjLcu1vp7SY/VpyFnIUL1yhGx5C1kLbPS+QmRYCm
    FOBecbjE/fCpOZwvl4Qg+6/2TTm29HdFk9PScCoLVNLTkHEd4NLxu1kNTVbkuz8M
    vssN1jG6dh1o7nY0HVTaCvkB0yutTpPwD+QtvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474651; bh=Lkh5db
    TwoG82op7jwn5tUSEYgya7InhTrknPJG2ZxV4=; b=QHG0Tfcnr8U+9b2mvObQWK
    HLLd4fQvcwIvdzAPoHNPzudiDsYBu86HHrzqFBzUdxkxCjCxO6APb7uYPHOPB6wQ
    vA39putKhUvnMGbWC2nYCYdvA482CQnJp4jWdOGAsNHZFI9xWTggUmUJI96WssVn
    Ul6M9dM7O1rPmFn9BsvRkz/kDH9XZYP65fTNrddPaSthUyea6dvxoR3NUiGKuZ8H
    ZW7m8MYIXbCU31iqQaNrYKLVU3lzqK0SQDl06xrUqJADlt6oaNAODd0tWbJszsW3
    fNxd+F+V+jRKfC0PPb9PzrQ5GFhNIWD89NJx9S9OX3L0keAPMOVlwmLov8LryamA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0QgvHCH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleehgedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0QgvHCH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleehgedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934143AbeCSPur (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:47 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:63552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934137AbeCSPul (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 122/124] xfs: account finobt blocks properly
 in perag reservation
Thread-Topic: [PATCH AUTOSEL for 4.15 122/124] xfs: account finobt blocks
 properly in perag reservation
Thread-Index: AQHTv5nXq03HA5IfJUGurkmQUHyB2A==
Date: Mon, 19 Mar 2018 15:49:19 +0000
Message-ID: <20180319154645.11350-122-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:Zuv3f0NMsMLJ6qS8vRUtuAtKW+l2Einir0z8hfCvA7K/v0U247yZvI7IVLFxrnW+Tv+jRsdqBa/3StvoWNA1O9Okzwb3EKgrux1sjYW6InJNTlo6C9LIKmJu0AvySL2TNZbYJHoUqguSku3VMFEQD7uFQhZ9QAFYFo9S0TgFL//oRNjcOcGPejlVV70cIVVAycHvEEOd7ib/5jUgOD6ZHQVchPV82QySmPsIlzw/FZIE0h6Lp8aXE/749teXLigc;20:FTsspGpDGVlj+56pWrTZQuq8qQTP/eyabQnSWETjyn0Pw1yOvt+NbTFUcwA8SVdjjFo8KdwVRM94QD2LIos3Zc6qT8pGxhsXsoxAdxnGn3cknh/wFUHlpn21Xg+AY9wVaIM9f0VBpv6GF7KPrWvqhq4XnaqhOL/1z+13dt83cvA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51cdc43a-704b-4d0a-6e54-08d58db1294a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063773C4297C2D6CE18C63CFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(10290500003)(68736007)(110136005)(478600001)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(551934003)(7736002)(6666003)(2950100002)(107886003)(76176011)(26005)(6436002)(86612001)(54906003)(6486002)(4326008)(186003)(15650500001)(3660700001)(25786009)(53936002)(81166006)(2906002)(2501003)(81156014)(5250100002)(86362001)(2900100001)(5660300001)(8936002)(6116002)(8676002)(1076002)(3846002)(3280700002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(22452003)(105586002)(102836004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4t598pNH799FkhsHm2ot+wMKNrB0BNikVj18hCJ10c+Fs4AmpUr5FqVpOb2sLZ88N/GCDdHtoyr3ZaCkD9GqO8iJl67dfjLvrgvy0quBBnQzTmHoTL/+kzNIpLYf2PIYXNOkxCMdJ4mtwVZEBq1dHBj0ENPNOeUDm0wTPaHr0ChXt5j+kG5l/UwcQTKx2yv1i6KcTGz7RUblW0Ynd4YF6mQkl++eSr/SdYHSCys9YZZ/CMKKnoxu9Alz4WQpDHpN9tjlABvfIMFg/PU+r4L5b8zBnlQNhQ93mwbxKNVh7cat5eR2mnUw8NRRg8Q+V3jZFnIxikn/56oO0dxRmJIdSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cdc43a-704b-4d0a-6e54-08d58db1294a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:19.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
