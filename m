Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478719-2-5635623517693308239
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
    t=1521478718; b=k2R65c9TE4yuDuZypfAfxfWWVEh8zCoErMRqnsyvG+Ywaq6
    5E6b9gXpMuhGt3ecVZi8lrnTXeS932c0M6hEE7b/eUdZKAbYdjT9JsPCUZvQfZex
    TmoTAxZPIB7IUPsh+UCbhzmb1reWHEtq3Avyo9WGTl2eO0V9FERapN4JI33et4OQ
    Gzxl81FJrOjH34EgYIA99xMLyJHDZY7gFsdpcEuvaroOPWN0wsB4ISzufgNr5o3/
    XPp0bjdW2xczkVWQzC7UjAptea/vCvM1wHwO/aTpqRg5+AVa4YBbaTqBXsjcTxqe
    S7Tap6VoYQ/GGltkN+qXQV6A4GjuOiOhjYjfyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478718; bh=uRg+iu
    7S9edI8zGriY/D8poCgR81BVgny0EOxqKKKDY=; b=fFe8e1hYoE6eSScS3F4W+b
    y/hE6rH62V0yGO9JxnZL3y7EbMI2IxkyXJsCbkPblwIZtmuavLNfcH7kyPqkR+GN
    Y3BSmydcUICaZ4uBIVZ8tJroIpdx8e43DoV0+aN1vdns0gkGBco4IGWGQkwev0ps
    Pk9tFblmdW3uHY9m2AJG9BhUc5F/UtRPf/E5aV9sBiscbAlrVBDzMfBu31bUnUnx
    Ep7tOasTKaBtwoWMiq1CtWLW9Y3MSR7lhFMprj8EwjmB0pqA2GxbdxwEmlXlUwdw
    CWgSAMYmrqsA45qHDf4qg8ezCfL0Z5jj5GWhtymRcbgT+h5Jmo2YafjAFe+cS46w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RP+qv2kN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvgeejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RP+qv2kN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvgeejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967542AbeCSQ60 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:58:26 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966341AbeCSQLZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 153/167] xfs: fix up agi unlinked list
 reservations
Thread-Topic: [PATCH AUTOSEL for 4.4 153/167] xfs: fix up agi unlinked list
 reservations
Thread-Index: AQHTv5yIQ1Vc+Woxq0azrTBioFZABA==
Date: Mon, 19 Mar 2018 16:08:34 +0000
Message-ID: <20180319160513.16384-153-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:2RRiDwgO6sve015w0w7iOd0c/VOf210tjBieT2WLAsSza+GC2NdX7OTNkMyxvdrrEKiDtu4PUEZjTSXn7UXxCLTY0VH10ZH0lvGCa10vRCXORYTQ+6rqleoUP6bBNN4LettEog64bPCDsR9KEpJb62u9CpW4kYbqPUf54aN/+MDq2uQCnMgiPaeTc0zAh9wyNximcij2/u1bUBpSd5sqEaiNPWxsaWX5zNjaIWNmDy4KCm8m4XEX2c/XiAUS6nLc;20:S1k7OGxPkHzraIPxLSNqxpBXljFR9cMrdMVD47bLbA+RhuTgEfCpFvxON76Y2TyMASSuRe+40XcW3KhbcutLwGQs4fKS5rSy8Fi9Kk8tXBPv01j1ItCP1/9j3l0u8KPT+8f1j4NnyAmftTLQrNZKv5ppRiTfG0f2mWuCUXM/j/k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ff12866-a09c-473c-ae26-08d58db40e81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984CC37F096DDD0F011AED3FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aSSKhWxQi0FJa6zQGpI/Xx23qg2Eeg2VHvfGYv7PG9oGq7SUrtSf/egDs3zgk6vojZcpC2A0PhaG4eBT7xXainwl4WHRlWwWHFBcPz5XaS54hYs8yJRFSmf3FMPGacxlhb3l0sBs5elEae9WIXYJKOAqU0buPbW+tG4DXzuNvwm2ZkO40MoZUsI/N7UcB/E00x14fmcQdUTnONoQo1Niycul4Cpn/3CxfX9rblXgmfrYXaYem2s9+zrH/P/9lqx2bxQmp0BL/IAr5u12ioeoFWqc8T69TSPLYXnwSLF/0XPAyFw8JBACHOPWPqiMgHsOW+teaMvr7m5dOdKCWM8aEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff12866-a09c-473c-ae26-08d58db40e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:34.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 68cb1e7bf2bb..9fd4c237398f 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -255,13 +255,14 @@ xfs_calc_rename_reservation(
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
@@ -293,13 +294,13 @@ xfs_calc_link_reservation(
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
