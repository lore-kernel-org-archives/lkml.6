Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496840-2-11749260483721607927
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
    t=1521496840; b=IeY5wSECYWQOD9Bd32XSqj1dIMOrSJ/X9d3LD21RLbfCW5A
    BjRozCTvGDM5QmR9OH1xw7S2nWIVAYbUo7YmQooZcesCY4dM8QuyLQhJTmciSOE4
    h81ZFTTlJN21CFdawjdJqhKnnaYullLLWM3jTnskZk2Z3gfJIIXP+bhU97nMXxG8
    boC0e1oJeohLtXULwNeUu7ql4FyY0ESHkjnXyd2zbmeObzE9SDvKul9ndc/kzYnS
    Py40VvUgMsUo2aL52cUUmqVJmMPv2HuJZKnnEWge8vg55C8pyKZhrsO0+IYxB6rt
    3LCqyMQdCXRCqAvdvr7hSKpnV5p70SuGUdgjsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496840; bh=EaekYF
    01QqvdK9eJ3z4dBtHtrWPri1hXcw5PT0t/+tQ=; b=BDuLP6XzmuxelWMjq+HnYj
    j5dHdOx49ZlWaBmss94hUlLpXJsI87ebTItPMsY18OZlcdoTEp+PqgZPCP3s8LFP
    YsOwTo9xVtP4ZHy4VDXuv6C0hqib0aIMhoB/1kIvTRjhoReIYYJ+tP/Itv6uX5Rd
    ADpRf1kebA7CMwS/NNzmMXXc8GcoZkqPTSIhWclRc4BZ3TGApYcizi0nd7tYRF8e
    46cmP07UFzLQWMaF0kNGVL28sSXmIXB+jqdxmFCAthxMMjzacEi9JABn2+XwrjJi
    l0Yquk2h0Myh1IjdTfFeE5rLpNs1mVgee+TAKEGFWj5GQlvZXV9LJdPJ1EmpHCKA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PojmrKV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdegheenucevlhhushhtvghrufhiiigvpeejtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PojmrKV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdegheenucevlhhushhtvghrufhiiigvpeejtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934560AbeCSV7w (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:59:52 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934470AbeCSP4E (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 59/97] xfs: fix up agi unlinked list
 reservations
Thread-Topic: [PATCH AUTOSEL for 4.14 59/97] xfs: fix up agi unlinked list
 reservations
Thread-Index: AQHTv5q/01lYqPArpUCmtOwZRGk2IA==
Date: Mon, 19 Mar 2018 15:55:47 +0000
Message-ID: <20180319155411.12348-59-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:NWZoKr0KZ3W+RoUMvR71XCQ6Epm8uQUniQleEw0k45uUkQtLJjSdOxbvf0TdueUwobQtuRbpZYLQyN8WpKCe+Xsp5W+FSegAZAxyuglq9oJeCN78Gkl+oZzePP58vRl5FXBXbp5+DOyn8n3Mvl3MYNQ+OXIc8Tc6reJJXMPuDqSx9v7YFvD3bp63faHhE5c/bDxm8tqXU7bqwsTlwVf4x5RogIgtoG65s5ISMBzKQ1cXGAb/pz/URu3OB1mTWDlv;20:DRZPe+1hIL5okCL24ONgUo6EtGFutKCAhMBUyBElHF1/435T20eNnBUEHO/gvuShBynn4L694XNgqqaoOS1LVMFRmcR6199C7XUifzQ88Tc4tmi/ACVTC48L0M/aJx1tql87rH4mdVMkyRR/+579J3ht80+CPXIJ9kgiU9BqN30=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08f838be-cccd-406c-2154-08d58db1e84c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08074CC45734A0AD7C324B97FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 278Erot3wEmAf0+m5htOwa7kpSAgJNc6pDjVX6oE4mABfLYyzxQTle5PiEaIlPb8BcVRic3ggheWheXQbArqN980PxkFcDnJOzv+ZK7YMtBWri6y9BnnV4XZRjvJLQ0prcWg6L855FCKiTu6zdJJmffIJieuB1L2I6nNF2iGRfsIdSS58c69yRC67qvf6uysHCH5ZNiNsqVWNTqEUKG+TvuOrdd4hY0cjWQJcBr/Uzkc2wzyoJ1PaRFlS15mdkyaCKDL4vu6e3deWjjKtgvyRxelYwJQ37KghUk4BV/7MasdqoIDtlCp93XIANl0JY5p0FzPySRKR90wkq1S0t1Zpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f838be-cccd-406c-2154-08d58db1e84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:47.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index 838566b85622..173b1bc13ffe 100644
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
