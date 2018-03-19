Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498347-2-12394765027116474257
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
    t=1521498346; b=iEGOWYLVTuzrIm3NZ+L9m7OuzZNBAncF9uz7PslaD36qss9
    IpXxO4g0c0goc6a8a6ggRdYphU94TtJ9Bevf0Z9Jf5nXIwKZoV46yBWju7ttB1O4
    YMvZNPFLl0K5EilD+HxeoSoYl4cL7T4xMACO5Uuabu9ReG5fceBjgzdJN3QW7PIO
    CpbfJBsEAy/auFW3Q2Xzaa1HSpiPRAn5gClxm4plZUIj9NRZIOkwcYdJUgPz/pn1
    WlOZhbkVcKYqH6PgyNITKU4viYIuKG4JMSaReQRyrVIs8iMJUEGopxrEw8/2OljH
    3QZhSu0/gYoS+ya7CBSLWxkWwxqpc6CDUL78awQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498346; bh=EaekYF
    01QqvdK9eJ3z4dBtHtrWPri1hXcw5PT0t/+tQ=; b=l8Yb1jf0LASptPTtApY0rk
    XBqW+QyGHRBiiu+F5g5w4r8iS4Tn+2SK4O+WRwtlsSbTsqnfg0/zvulB80ok2qUD
    64xHWV5kuNut1qcdwtW03gwBOSTlvJq/Cb1Em0jWwyXFV3UhjyY6ccdvNQQqTjSL
    lLWXV07QFk8ijdUzFetms5Skc+JsZUSsPAZF/DswFUE6a0NKQ7wfSNXZ3a2vXk+0
    mFj2HiU2PwNvb1ssPJtD3AMkg4dewi54goLoPip3K1UX2NuX4RFrQXWgElhJiQTz
    ofvMHVUkxdFg/ViGzw2p9XuxDiDz5WRc/JWJlzv0msOheucMyDT36QMBtIoSmfOw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QwaRURBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehudenucevlhhushhtvghrufhiiigvpeekhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QwaRURBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehudenucevlhhushhtvghrufhiiigvpeekhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbeCSWY1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:24:27 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933889AbeCSPtI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 075/124] xfs: fix up agi unlinked list
 reservations
Thread-Topic: [PATCH AUTOSEL for 4.15 075/124] xfs: fix up agi unlinked list
 reservations
Thread-Index: AQHTv5m1/4XbGMLihEedFzltOVA3hQ==
Date: Mon, 19 Mar 2018 15:48:22 +0000
Message-ID: <20180319154645.11350-75-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:VMAnf9AKx6d4kAxauz2lbRIL4nA6sUOFWvFelkb1f2O0/QU1dpclIdA4lpvleWW5qjeg2gj1rdqDYYJTN/Un5KLRmslACUbBXuQdpqAgm9S4hRU5hLL/3Ss9WaF///pWFoohM77nmOH5UL4h1x7cZNSnSP2fPaPy8F4zJqPnija4ornLv0gyCyMhSInvN9hlhpFwc0yfXte402gRzA0QF2hYSy8uPgL86oHaNanQW1M4ugvlH5zDGvxpFvbqdQfi;20:7zHVY6pE4lnLIL0xQggP/IKEnrxKD5WsVTJQ10gzfvDvjM6YkCGVgxMbl9gWmH8c/SNOe/F8YLIwgNUHVwxc0NIEk49qw5LPqQL/R7SFm0Uw3BaMV0anDGho7QbgGIfis2ZSGhbwF8z0sCz7+PRjFXRiFrRPaSiQ+WiOgrfKy4A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56a9be5e-c160-4d7b-23c8-08d58db0ed0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091912A633442821058927C4FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4nVDuH4UHU2/ovfFw7hI3itpjyT8x3qYGHB3NS0mav2G0GT9ZV8eRTlXdO3QqTHBJ6bR8v8zhcOj3dON7Q/0j380FUKPVqO+6T0z/5vaVaTFn5SlVkUKXgY1/gMJ99D56wnnPCFqe0GAtFCSjlP+shZP35ybZDlZY1lnzyxPMs5YKpSZAqTyhfGU9f5RDLTg708Q67JKMp94eI2wpa/FvGQxJw+G9QAwAfRjvFP5dLcVowycKZgvFQPzXaMtftMG/wDxnMDmaOsqOrJ8D5DbgJoqUrPhGOi3cKiNKiyDEBxiEGEytXvbplkooc3yzPC8TS0l3SkXSx1pRUA48lAJ3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a9be5e-c160-4d7b-23c8-08d58db0ed0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:22.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
