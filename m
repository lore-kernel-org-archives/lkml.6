Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476303-2-10878973325994501911
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
    t=1521476303; b=OVmCh70EYeZaEqi3EuuZJJkoWPLqQt/rzin1p6VMnz+nzt4
    uvBHBMGZr50tI6JHkpupCZiIJl2P704j7wkIhM9GdErkUPfXBeeHFZftE08Pynca
    pwacTWToDovXYCwHIytLNt6BXfcSIecubC1ZKJKU2q9CsMQrWDWdpAPga2lQBQgZ
    /PTriW1H9VQSfGZLbcIT3iHCWbGaW/oeC/hZYfyaKKcUTmDa3OpBBGcVx0MsG1dI
    FZ2pgQFhMbcUM7L57GJeJc896gnLkInlkmDgG/SSPqGYYJlcSS+cpuEuuttF76JZ
    LYyTMcmq4SRsYUbNJTKYIWH0V81WzM2RLhtR78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476303; bh=xOR6lC
    l5qdZ15eCCvYsQTPVMCzMw/SKBtZXNj25r2ow=; b=wUSiqocDkMVhzi+1mzuHvD
    ZJANTSt04gYY1gKblBXC4LKJicA6zINhEvxSCcVx8dYRrc2PjxQTr9+jo4BgvUmt
    JL7KcOOk0yq4aLwfaCImI7TPv6+6a34yIdL4jUPIwWIAZBHh2hWqnKqDkivbNZ2U
    0IAaExSLr4DasstX0B11fvQhFI/zpgtCsXa+0mZ82lhqKOSnbbSeAK2rAruoy9ni
    /l3De0eilZRv6JTx2iIXkNSy8KROXvKG6cQe27wP8lVxtaNl9rehodJ68KWQK5Kl
    s885rZgBJqNCyjXKOTe+P3Wj9l6IMtJ9jox2my1x4rKNGmxRQsltPcjvPDhCshKA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RZkrJemq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvgeeknecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RZkrJemq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvgeeknecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966987AbeCSQOf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:35 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966977AbeCSQOc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 092/102] xfs: fix up agi unlinked list
 reservations
Thread-Topic: [PATCH AUTOSEL for 3.18 092/102] xfs: fix up agi unlinked list
 reservations
Thread-Index: AQHTv500sYiCnYWvc06IDu/y7HjX8A==
Date: Mon, 19 Mar 2018 16:13:23 +0000
Message-ID: <20180319161117.17833-92-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:IVPO8Vgt+qarAIIel+at4DXqt3KmHfkKglX6jj1nwZ/WDE6Lml77VgbBIMUzUmyU8qLE/07etDvH7Ocd5R9ZemQO8Tpdzo+Kc2iO3UvCr5j6wNV/I4vnJ9okWXTfDaG+YQQuUzFotEJRuuaRHdst8ZzOsV2nzZVG2PfGbf6zleEI4x4LagB2vBAhrpY2e44eOYCWJghJ0TCpcjWz3HlFRQkIBVQxJIg71M39niwprvGmbA90DNUGkizD2JtN/zSx;20:5zt5fwCb4nu3WhBIen4hGBgjmON2/+JOC1jp+yHOQN9zm9ZtpiVgxly/AwcpM+5IOiQfBbQGsYfdq5m2aLRvecEgjBJYakU9MsjRQe/pernC/9XLDnszqe9pwxIzff3H1ckjAzfdUXz/Gr5Y+8gumJwD4XV1KC/n90MmpcC/lm4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f2a1b32-535d-44ce-369a-08d58db47708
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11120D11145508372C6C218EFBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(99286004)(106356001)(6436002)(3280700002)(3660700001)(10290500003)(66066001)(2906002)(6486002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(59450400001)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OcpTDbTCiTSJOXMflA727ra1e0LP3szjW1umr5CJuFHVAb752Cr7OOEgXMJopu03nkCdfqV/wogS5eQi7SjadVxd4Z6wV6nG1b8/IPjhcahVv/Y1C55ntJU3p012PGg4zF0yPblQ8hBdkp4p5QcOvFT8SiqsOnY+xF2xHVjSiw8VHDOUpED6+BfLKr0Yogr5NvxaGNTKJOJdr83id+YF3daOQsuLuziH1B/RvltTTOobP3H8mtuEf4hG0WGc1jujVZP6D6Ve3o6oNsY8TlXmOce4rET5uu+mgxxf599UueIjd7QT4TrFbXzqQYCEylLjN7GGzIDXyVZBVo6cXDFcFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2a1b32-535d-44ce-369a-08d58db47708
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:23.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index f2bda7c76b8a..96bbbfd021fe 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -257,13 +257,14 @@ xfs_calc_rename_reservation(
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
@@ -295,13 +296,13 @@ xfs_calc_link_reservation(
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
