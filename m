Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481314-2-15604880267500501092
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
    t=1521481314; b=XX1qMZUsItwJ0SYJGrNga/e17zruEYIRIEMtJAjlN2Iulrf
    oR7SPtzi1u+Z+7p8OxNbaMVxpPFkYG25PsOKB3txtee71uE6i/CwmYVYjNPrZYxR
    4DNDcBVZ9UN4uKQetJA1mbgBKhEr7zYAFFlnjIMcgaDKj0J2S5hS9GbR2dqi+Ltp
    l4Xickw06fiUnGoWflchf80xE5Trkvb9sHhfLjJ8vAuAzZRctBQPv00ZBq0hLf/S
    DVAhBbBoJlsWUdv83XNSj6CFTjo75v9sWMQ0GRrzK9+uF6z+ATG9Btk2WZqw7kNa
    7UM7YSOYPmTffKiMafc3aSU2/DWj7ZctRa3nR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481314; bh=LeJ9EJ
    TlmgpEDboBCERuUEltZSxPk1sAVDjyPL00N9c=; b=HrkUVx/9yu9e2Mg65sK/9m
    f4o0boYEtzB7Q332MLapfIUpsiUFsfQY2PzvVFQYzSPSvAim8CzPSLknC/uYk2sO
    4zRO5OKbd9IN+Zk4e0bbSEqETmZ4hqtbjAxbz/U0rz0FGcjp6lpeMW2YZkcXx1uR
    1bNA5zArPYYirNBR6UpEPpbnK4fzkhm8Bx0vN9I85fYbTNheDNULvbUGpt4rFXOf
    MqQk9H6pcI5l448IVvVH14SIo7ENeR2wsyDxs2V14eVD5xibMtoOKpMa7dyQbV2G
    NaviIJvaFa+lN0vKUT6VzhCsRhSz/cSEpg7Da8NK4zsHx7HyboBGEHjlDPOM0lgg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gjqYV55c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdegieenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gjqYV55c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdegieenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965882AbeCSRlX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:41:23 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965873AbeCSQF7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 262/281] xfs: fix up agi unlinked list
 reservations
Thread-Topic: [PATCH AUTOSEL for 4.9 262/281] xfs: fix up agi unlinked list
 reservations
Thread-Index: AQHTv5vDwK9Ug4nmqEq+dcoY2h1S7Q==
Date: Mon, 19 Mar 2018 16:03:04 +0000
Message-ID: <20180319155742.13731-262-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:WdzVTWy/2ztBzQ2HHNlvEcg8l5XF/w0gxo3ghHLtj/RO5Xt6beKRZYKBKcGFbAPYUjEWAKpI1cOdzPaYHEwYagVDHt8LZQdWANJc5Of3denlOMyHBiwX1mwkKbefTcZlSu6x0H6/bsh+LfE15OOEz44/0ZfNZZLdXAkUb5NJPSdrFSwPsZfRoFrvjqJmomwg/lt85LXIcEeX2Y2kIVdEgzf457R85OoWm54vYjnHYXm05OEa/AaspYSxgKXlsb+8;20:IeDPDShxbqPFaGIwX2DruwBOxZOxW7xbhyvHoAbr8Pc7lBksficbbkmQSlHlw+8aUCT6ueiaY+WF1UUfXMGfsY4qggCxUa32zIr2N1H45NEP+Uh4Z6fGVHtSqKl1R2rLYCO/y7q9Urfkytx4x9K2IlyD1KN5DOmCKDA5przqNLE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7503ece-6737-44c7-5e98-08d58db34220
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015B4D268952AE37B9CF651FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GilIqlv1GGbmMXtwPx2ruChx+VppmXGpFu+RDZ0PoDeyL40gb4fLQW+HgfVPgC4ktiYCZN8SjShBu76ncsZX52hrg6rScZoYykVqa6MuUhGlEDUssSmEfSK14Bas0dZgzL85q2WnqL6ibb0mTIYXYjyvQ9SnGfIiZ9H1j5RMlJ4o7brlvE5a5fX6QYMB2JfR9jsd5ucAeTFAsnTsSYUh5Ys4T8Z0zYM8oMaWKOESXkwTD+4LiaQKCxYhF1w7yFvz694BE6l640yZopHdQUk47bHCGQXR+SNh0ASnyJe8/fJTAH719bEa/KhX9obY02E1cT1Pa6a3qHWMtgn/JdFS/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7503ece-6737-44c7-5e98-08d58db34220
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:04.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit e8341d9f6348640dff01d8c4a33695dc82bab5a3 ]

The current AGI unlinked list addition and removal reservations do
not reflect the worst case log usage. An unlinked list removal can
log up to two on-disk inode clusters but only includes reservation
for one. An unlinked list addition logs the on-disk cluster but
includes reservation for an in-core inode.

Update the AGI unlinked list reservation helpers to calculate the
correct worst case reservation for the associated operations.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.=
c
index 7f685401728a..6c85a131827f 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -282,13 +282,14 @@ xfs_calc_rename_reservation(
  * For removing an inode from unlinked list at first, we can modify:
  *    the agi hash list and counters: sector size
  *    the on disk inode before ours in the agi hash list: inode cluster si=
ze
+ *    the on disk inode in the agi hash list: inode cluster size
  */
 STATIC uint
 xfs_calc_iunlink_remove_reservation(
 	struct xfs_mount        *mp)
 {
 	return xfs_calc_buf_res(1, mp->m_sb.sb_sectsize) +
-	       max_t(uint, XFS_FSB_TO_B(mp, 1), mp->m_inode_cluster_size);
+	       2 * max_t(uint, XFS_FSB_TO_B(mp, 1), mp->m_inode_cluster_size);
 }
=20
 /*
@@ -320,13 +321,13 @@ xfs_calc_link_reservation(
 /*
  * For adding an inode to unlinked list we can modify:
  *    the agi hash list: sector size
- *    the unlinked inode: inode size
+ *    the on disk inode: inode cluster size
  */
 STATIC uint
 xfs_calc_iunlink_add_reservation(xfs_mount_t *mp)
 {
 	return xfs_calc_buf_res(1, mp->m_sb.sb_sectsize) +
-		xfs_calc_inode_res(mp, 1);
+		max_t(uint, XFS_FSB_TO_B(mp, 1), mp->m_inode_cluster_size);
 }
=20
 /*
--=20
2.14.1
