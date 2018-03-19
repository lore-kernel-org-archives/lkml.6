Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493479-2-14292468706957389250
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
    t=1521493478; b=dgtL9x330D8c+1aSw5Kvz7BF4IrY52ux84rRRijdcFxpz1b
    NuaD8Q8xbbjQOuGQ0Rklapo/sr+fdMDS62ioh0A3ZZy9CBvBA+SMrGHwz916lu7J
    OnNEBLzuDmykHt5zxvUWBDCOnFXyYBEJOHWWRW2JYJoqJrFjOzhcb3f1ek3gjzkz
    AvJ7UOw/omat8rdNQmOqhaDjoelH0aPSKqfFkr10qS5hIqj+Segr18jeezTa0jFb
    2NJ06Xn82zd2CYt5hC3taEE2lnH0nL7+txJWpwr5zYcxhROe54bo/E4jZGY+DgYC
    NHfHscYQnnCBYtnUH2w1yOdmj1cUnafd2czvE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493478; bh=7+Oz9C
    AxlfWcdwtkl75+BpqYZskAqVE/fdY7TtUklW8=; b=KXK59ghkZ89nNolLuPnNPp
    rzI+0owPomAEW4URLuK1U0TX43/GXkRaW6UXZrQQMjVvkGA+uLmwMkwrSmkOfl9B
    b1OujfACucUn6lS0rN5sBK5LrkEoev9gU1vQkm7ov30Ho+/i/RtWtE9Sk/4Z/egI
    cqWaPvMXnYhqpBhnCszyTDdCsPTXDJKKST0xwC/hAU7OoRJa/dYVIHHQRwek75i3
    ZXL64/elSMqYfAU8xNaFr3nNDsmvJEdSeAGDUTHB5VEB0ib0+TXNVua+YYh7f9ox
    95RKdn3lrq6kVjj4DW8P3+IPZtt5MqI+gV//b2H7LsYaT6KsenJpBjJ3I0LxDmiA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=czC5oxTe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljedutdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=czC5oxTe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljedutdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeCSVEV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:04:21 -0400
Received: from mail-by2nam03on0123.outbound.protection.outlook.com ([104.47.42.123]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934680AbeCSQCh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 151/281] xfs: include inobt buffers in ifree
 tx log reservation
Thread-Topic: [PATCH AUTOSEL for 4.9 151/281] xfs: include inobt buffers in
 ifree tx log reservation
Thread-Index: AQHTv5t0O3C2anpaskWzEQNduB3xqg==
Date: Mon, 19 Mar 2018 16:00:51 +0000
Message-ID: <20180319155742.13731-151-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:jwQDK7sffsu+XepUhlb7+axuvfP7hH0roWYDVFHvRHdjvQoyl/GNaXXTjJ21J4xP7QHDxYZgHkuEMOexea5OC0e90VuPwpi8/TbJaAT6fL9n/aO6qq/v1sEM3d5b2bwn1WKZVcNjcGNldCV537fjrnOgbKH56HUoT5gja+E85Y/mFVjm2Vyoc94YrW2fGQdFzFdwtRJmOAvqGU+lsezuj3AyVJionGhMzU27batktM9gIRaOcSwIsoNTqGcZlsm1;20:6cf8iGLpAqOqg0tliyvoB4H72XMbhjdvYySclQ5+g+WSUHbTZABoZvzlYXYuYAz6gZ6XT7TGBPcjYJHrHgF57aPWC4BZ/X9+z1reIvMA2v6K4P7Sb0R4X2lM+APZHdD88C3p9+Thpv4UhjY4lo40x3GtDknA+/BaC/Hld6TU/sg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f01e44e0-e93c-44a3-d268-08d58db2d310
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093369EB3DCC588C5B324902FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(551934003)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: mYoIK86qib0da7tJj2+pRvUtRVKoDulIigUuntEic+HwqA/RSlHkdpNBdfpqqi3ixxBujOgAdWBGudz6KUd2UR2CppxBfjyB3NYwWo6cgGh1eGENOw5cWVB6GOtj/qszLr9oPdS2WrhB0F6GLuA5FT5HpwieeQbWGcEWRBKgf5Ge1KEB/rCKC3e0Lk5o5Ao5Adrh+cGRXEiSmynC9NK2uwA6b7Z6LaCfEuZp7aNyqutrv8qr0o+KDfmb5ftYm4c0BRzQKcrXW8f1uGCYqI2XXxGLpiheCU0GRJVGeUssvpNI/LocoKav/qOeIcskks3mVPvUKX3PQUlCqWaamlEptw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01e44e0-e93c-44a3-d268-08d58db2d310
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:51.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit a6f485908d5210a5662f7a031bd1deeb3867e466 ]

The tr_ifree transaction handles inode unlinks and inode chunk
frees. The current transaction calculation does not accurately
reflect worst case changes to the inode btree, however. The inobt
portion of the current transaction reservation only covers
modification of a single inobt buffer (for the particular inode
record). This is a historical artifact from the days before XFS
supported full inode chunk removal.

When support for inode chunk removal was added in commit
254f6311ed1b ("Implement deletion of inode clusters in XFS."), the
additional log reservation required for chunk removal was not added
correctly. The new reservation only considered the header overhead
of associated buffers rather than the full contents of the btrees
and AGF and AGFL buffers affected by the transaction. The
reservation for the free space btrees was subsequently fixed up in
commit 5fe6abb82f76 ("Add space for inode and allocation btrees to
ITRUNCATE log reservation"), but the res. for full inobt joins has
never been added.

Further review of the ifree reservation uncovered a couple more
problems:

- The undocumented +2 blocks are intended for the AGF and AGFL, but
  are also not sized correctly and should be logged as full sectors
  (not FSBs).
- The additional single block header is undocumented and serves no
  apparent purpose.

Update xfs_calc_ifree_reservation() to include a full inobt join in
the reservation calculation. Refactor the undocumented blocks
appropriately and fix up the comments to reflect the current
calculation.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.=
c
index b456cca1bfb2..7f685401728a 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -490,10 +490,9 @@ xfs_calc_symlink_reservation(
 /*
  * In freeing an inode we can modify:
  *    the inode being freed: inode size
- *    the super block free inode counter: sector size
- *    the agi hash list and counters: sector size
- *    the inode btree entry: block size
- *    the on disk inode before ours in the agi hash list: inode cluster si=
ze
+ *    the super block free inode counter, AGF and AGFL: sector size
+ *    the on disk inode (agi unlinked list removal)
+ *    the inode chunk is marked stale (headers only)
  *    the inode btree: max depth * blocksize
  *    the allocation btrees: 2 trees * (max depth - 1) * block size
  *    the finobt (record insertion, removal or modification)
@@ -504,12 +503,10 @@ xfs_calc_ifree_reservation(
 {
 	return XFS_DQUOT_LOGRES(mp) +
 		xfs_calc_inode_res(mp, 1) +
-		xfs_calc_buf_res(1, mp->m_sb.sb_sectsize) +
-		xfs_calc_buf_res(1, XFS_FSB_TO_B(mp, 1)) +
+		xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
 		xfs_calc_iunlink_remove_reservation(mp) +
-		xfs_calc_buf_res(1, 0) +
-		xfs_calc_buf_res(2 + mp->m_ialloc_blks +
-				 mp->m_in_maxlevels, 0) +
+		xfs_calc_buf_res(mp->m_ialloc_blks, 0) +
+		xfs_calc_buf_res(mp->m_in_maxlevels, XFS_FSB_TO_B(mp, 1)) +
 		xfs_calc_buf_res(xfs_allocfree_log_count(mp, 1),
 				 XFS_FSB_TO_B(mp, 1)) +
 		xfs_calc_finobt_res(mp, 0, 1);
--=20
2.14.1
