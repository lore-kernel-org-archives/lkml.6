Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498123-2-16292416138098819845
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
    t=1521498123; b=D/K4hCQ52ERGe9kL4ktLjswoBn57/TG12qbJe/+nCI8KCXt
    K3UNFlEnDdzNMgWiWWN0wTXRDuwIwj2YXGFgoS7Id5FmWfkBSFyD43AZbHkjwsJA
    MDQsjSLLiHr4cm5+5NmNYIOlZsn2zHI8FCKQS2jHfvfI7dELqo7ffg99YIXkt7IJ
    pHQUqXrXSbub0H4pavzWY6BVIgzCIvYjQrR3zvnCnhPM7xS8Tak83jNy3icWCRq4
    mFik6pSfsx8fpUasrjkRCYYDNpwLgN4ldMa3iVuQ/xQ4r49DnxDMBGZxRaxoWagN
    STVAgBYWMs808MJTx04ih+mPX5mYeU7ugyDV1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498123; bh=N6T3V7
    7UnWX+WraIi9Ndi1OLq7Ug52Z4exeUM+yGTLo=; b=WEpdC22B5G1iz/NZq92nFe
    ksoLP3bW0nIOxxB/CKDQmIDDkVENUIjjKl/q1vZq9QxtZbPIP8AjFjL1CbYKE6j2
    3bmLWlq17+LE+z4PtDBAyKZAgPqTOj2JH1kyqecottSw8Mbz9MIpRgO4ZP0DOQDn
    oqXYGK3NwjynSovY/oxN3miL9TudlXxxEcg5XP8wqc9DkDFox1PWnsSRkwzmPeOL
    cqygTSpzq7B4TSWEBU2gQXQ+F2JKAhpMpYf7wPVRIuG7wGG/1Ayz4eJnETOBRnsm
    oRKUvkUhcQ08Q9TpZT9I9odO9wNH+1LR91vhVLXah7PQz9MuwbcN1aLavK/fqivQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WJjtbudN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeegheenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WJjtbudN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeegheenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934061AbeCSWVg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:21:36 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933918AbeCSPtP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 077/124] xfs: distinguish between corrupt
 inode and invalid inum in xfs_scrub_get_inode
Thread-Topic: [PATCH AUTOSEL for 4.15 077/124] xfs: distinguish between
 corrupt inode and invalid inum in xfs_scrub_get_inode
Thread-Index: AQHTv5m2QTE5pCINukeP+9tiUskNVQ==
Date: Mon, 19 Mar 2018 15:48:24 +0000
Message-ID: <20180319154645.11350-77-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:r+mNnQfd8qnX/zHkmoVd/pdISG4Zy8BPi1/9TGaXK/uIr8ZDJjyo2w9i+3CjVYuXhN49i9XcoEOJbBHNyDxPtUfW1FoRdVH2eZDEbJ2yhAi/jIAzKN7Fjno9r3OZ9NWagOOq6ZKV75GCgRhNcOjdUc6D2wUwbtO6PexRwjas+mruFvtDtDEaVNkg8yFW3m5k9bA4WuZYSsdNaFag+OwLFJS6k33Kmo75qX2fALDb+vveimYWux8ZirtZ3Tu1VLvK;20:mTK2h2jjitFuHJ8szruJdYBY6rT97B7j38RNL0c3biMh1a/mP/6rsewQM1ypp/A3NPjYYMdmysdhwbGpOJgqhLVSpXB+IoOQj/GCmFQ+YuWTcxAJ75tO6003BbXEcy2to/jtWfOncPjFMOQkInlS89Jv793pjIXdBXjBEUICSHQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05076445-9459-4d12-dbb1-08d58db0eda9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919548BE056B8B04102941DFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Ln1BETgM0A/GxT+Q2oMlYzovgvsFwFNXkEYixtw85IrJ+0N5VabiKUtZJDVJTXsEczcIL9ObZ/40o+s4KrjaV7NeqPM/OfP3tCP++QqGhcZwdhBET/zpV0eOBpmbWN2jayMzTb1naXTry7NwOlxfPaaF4lz1ySiZkKMTZD0Sqpwh60IhtXgrO1Cu8voDtbL9Y/USx3QOOxSqJYvscfowr+YO2NMo5sOl+hJbW2RMIcIYmUGw89w0osZLllC38O0gKBIcxhuh5NpTpqFXYP4dnJOfD70FV3cJnjcZt2N5QlUr7rGLCIPKWrivmX8TwPtk1OcjiUDxa/ESZ3jXFJ5TIw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05076445-9459-4d12-dbb1-08d58db0eda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:24.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Darrick J. Wong" <darrick.wong@oracle.com>

[ Upstream commit d658e72b4a09c0eb65c13fc5c15bc6e6d93ed8bc ]

In xfs_scrub_get_inode, we don't do a good enough job distinguishing
EINVAL returns from xfs_iget w/ IGET_UNTRUSTED -- this can happen if the
passed in inode number is invalid (past eofs, inobt says it isn't an
inode) or if the inum is actually valid but the inode buffer fails
verifier.  In the first case we still want to return ENOENT, but in the
second case we want to capture the corruption error.

Therefore, if xfs_iget returns EINVAL, try the raw imap lookup.  If that
succeeds, we conclude it's a corruption error, otherwise we just bounce
out to userspace.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/scrub/common.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index ac95fe911d96..0047d497cc56 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -503,6 +503,7 @@ xfs_scrub_get_inode(
 	struct xfs_scrub_context	*sc,
 	struct xfs_inode		*ip_in)
 {
+	struct xfs_imap			imap;
 	struct xfs_mount		*mp =3D sc->mp;
 	struct xfs_inode		*ip =3D NULL;
 	int				error;
@@ -526,10 +527,33 @@ xfs_scrub_get_inode(
 		return -ENOENT;
 	error =3D xfs_iget(mp, NULL, sc->sm->sm_ino,
 			XFS_IGET_UNTRUSTED | XFS_IGET_DONTCACHE, 0, &ip);
-	if (error =3D=3D -ENOENT || error =3D=3D -EINVAL) {
-		/* inode doesn't exist... */
-		return -ENOENT;
-	} else if (error) {
+	switch (error) {
+	case -ENOENT:
+		/* Inode doesn't exist, just bail out. */
+		return error;
+	case 0:
+		/* Got an inode, continue. */
+		break;
+	case -EINVAL:
+		/*
+		 * -EINVAL with IGET_UNTRUSTED could mean one of several
+		 * things: userspace gave us an inode number that doesn't
+		 * correspond to fs space, or doesn't have an inobt entry;
+		 * or it could simply mean that the inode buffer failed the
+		 * read verifiers.
+		 *
+		 * Try just the inode mapping lookup -- if it succeeds, then
+		 * the inode buffer verifier failed and something needs fixing.
+		 * Otherwise, we really couldn't find it so tell userspace
+		 * that it no longer exists.
+		 */
+		error =3D xfs_imap(sc->mp, sc->tp, sc->sm->sm_ino, &imap,
+				XFS_IGET_UNTRUSTED | XFS_IGET_DONTCACHE);
+		if (error)
+			return -ENOENT;
+		error =3D -EFSCORRUPTED;
+		/* fall through */
+	default:
 		trace_xfs_scrub_op_error(sc,
 				XFS_INO_TO_AGNO(mp, sc->sm->sm_ino),
 				XFS_INO_TO_AGBNO(mp, sc->sm->sm_ino),
--=20
2.14.1
