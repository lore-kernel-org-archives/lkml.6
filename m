Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480998-2-10750355947618578746
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
    t=1521480998; b=fjmoJlSAUxsfmPmiaVgWZmWrnScHDLOYnd67OfRFEU6sFQ6
    NQUx+0hO88X1EEZTinD83Fgj/EXIUYAT9bkxRez1S2zbYVNXyLyzzoLkOMEkhMZu
    +JfArxJTcVjTXqlPtYaGxqifBdKUXDvq7WlmYFz1kX1N9fnLgTSUQO5sz9R1BObm
    D8ygjkqaWOvhW0j3TcGD9qxntW4FljCskFEJ+K3CnTVHWtYffj50R6k0JKNuMS4O
    w2KuoDORF1onde4D+pQOXMKLOGzR6zgoHGbrnroS0z7gIv7uQgSq38m5fqnjM+gr
    ReSmF9fN2CGMYCOpPR1Rq7ozrsxtbxBsmqFhSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480998; bh=Mlq7wl
    j7JU19THV2Cbgiv8pBRyV4AUFJJ0WqLniX0e8=; b=C2ozv1R1ZsFYAS45GTKZUr
    63RcaGhGJkDnprYaHqj9uCgGSnACy5TDOKaLM0/nxjdK2imhuwd/fFCfixkG4uK1
    tt/f/ezNYQAVFHGIinD5F3U0aQpDIlOK/K9QLYapvrWUW4s9pblop3Xy+FZySpTY
    p92RrZUGDA5YOBO0+93N3S0/KFh0BdvzAnWHTZtv6KeFllRBC/KesTlPgQQRPdtS
    M5vWswwgDwA2jow2oOlbGbSwjVRRcJcCHkHNwYT/FVgofIzEznXE1JHjdrM4J1pj
    eo5rK4/wAI73ttpemdYZFdONKGmXpGSmntMeu3OfuzsiiCMxCOxeXA8CEq7NhG/A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fPrq5krv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheefleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fPrq5krv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheefleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeCSRgf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:36:35 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:60917
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965985AbeCSQGp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 281/281] xfs: account finobt blocks properly
 in perag reservation
Thread-Topic: [PATCH AUTOSEL for 4.9 281/281] xfs: account finobt blocks
 properly in perag reservation
Thread-Index: AQHTv5vR3Hpvrwjo00yCVstDP2q0NA==
Date: Mon, 19 Mar 2018 16:03:28 +0000
Message-ID: <20180319155742.13731-281-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:OexGJEcfkJeRMVqOpbcCYQ+IR1zeBNMXtzObgTGQE+tMsRQKQBIhEFQMzGe090oLJ1A3e5xaqdHBS8yxxD1zILt7BkHKxQp4Sq3qvNtNpKxaahGf0C4SJYE6w4lk9Or9ObfiPIbGl9Y5ej8CClv470DWRyJULzHD7CgbphYEADm78rUByZOR1d3vI03CU0Ww117S/YZGH0tFs6ZOupXm8aV5Wms+VmIQMShlblUSPadrUuXGoKqFLj4BoZC7ccHI;20:8+Vqv3qHZ4JvoRDFKz6mQNnJOJF4UYnyPXMDhN1+lsq5NyXLKF4EkGb5gmqMjP8n+seYP90n32N5xRfH/a4SzegL+mHXa4iGsG4C5MfXfYnWjtM1skMzSat53/QHGf2kCZzWX14WCr9h0zLXOtDHMlSE9gg1cvxVQH7Vakbh/Nw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44bfef08-ef26-4c60-8e2f-08d58db36593
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728C202E582226AAA09320AFBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(15650500001)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(551934003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YaT8/hsKxdc4yXXKimwWQ4grU3tUKIc26Wa+G7OVWD4OXobG/Ns1mj/zXvhVkyi5utTcjT5QKclcH9C+4H6JrjcKeY3JD/DAcs9fv3GGxiXxDsrPMJiXvYJB9ZwRDxVt5qH8819SVi23MlEc0AgYQT3r7SuM3o6815LG6We6Za8bhMM5beKSkIYQX/hktfgan1l7JooARcYlYtXbJbdYZ1Zm/71NRy4i51bA92o2WapAGerI9fTlDfS8l1jPu54fODR6NUbj7RPtH0smKdaL7SkeWQGCZbWXtr0cX15MCGXFedIu74t8YoqZq/JVMcXNr9PEzaEuPmNQWIBZ6gkUAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bfef08-ef26-4c60-8e2f-08d58db36593
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:28.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index b9c351ff0422..1c63e5a754eb 100644
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
@@ -352,7 +373,7 @@ static const struct xfs_btree_ops xfs_finobt_ops =3D {
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
