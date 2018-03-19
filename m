Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474973-2-3180478502581968694
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
    t=1521474973; b=f5tTlZ/oy4SE921hFOFoYQn8c3gdz6lHuEWM/KOfu30ahaK
    RN4hOqv7XyLv1LW/10jgGkArr8NatHpPyBVT4hoObck27oBRBH02VRfpEVfc7Px0
    mKnRINXLTpAUe11rixfVm1ZXPOtK8TMob1yaeZoEF1pMMl8kWtH/+5OgWctAk9Lr
    py67IM0ctXSFLm+4Kz6rQ/FGZe9oJmk0wyppYfTOP4i5RRXqGV6BLwrMVMja3j2X
    EOSN/UEykDwuqUvMgXO0NuQcEuoVVYa23eM6VP8L1d6qlACH6UtLwAHOzZU8ibBt
    PrYp5NyX38J0vGbXcZBEf6gjE5oulmu+GKX5GyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474973; bh=Gvkqeq
    Xf33opmmcOR2OSyxpBy6DBv4xNnItxfnKFSRI=; b=cnqMQ1X53Tc/wP90dftw2n
    JDguJWYtvTTRcVrhhOjjvS/EP4F3NSTz4lkTApFXgdtYoYEUowBHDEaiikk95mUd
    jqJmoWcMp9iQsY34o0ZDioWyZg7YRrDEYIbui4kSiwiq7kWposZ+ZJMNOnoeIjFp
    Gf+IZCLZ0NVW488vzT/AMKIkwwGmUxdObxK6ZhqO05mDOYSAGW66c6nQXKaUHpEi
    rFhdTKGwZdmwAiio1M37psaOv0A68cFoXGKE9DxeADVfPsVTWNpj10b4qhBSd/Kn
    OO3iTIppuJmiaq7fvwxRAfK6DoWTCv0xDpF+ubhdVs1fH197QAunvKmGjJjLTDsA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mpAYmDrU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeileeknecuvehluhhsthgvrhfuihiivgepvddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mpAYmDrU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeileeknecuvehluhhsthgvrhfuihiivgepvddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbeCSP4J (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:09 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934379AbeCSP4D (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 58/97] xfs: include inobt buffers in ifree tx
 log reservation
Thread-Topic: [PATCH AUTOSEL for 4.14 58/97] xfs: include inobt buffers in
 ifree tx log reservation
Thread-Index: AQHTv5q+1DD55Ksjr0+4eFUKXYE/OQ==
Date: Mon, 19 Mar 2018 15:55:45 +0000
Message-ID: <20180319155411.12348-58-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:r0VYP2xH85Qb70BrJuamCBvUMsxDoapZYKnPK6vkD2z5hv9Dgq2AWhRo2ZMFolVLt1/wMgjT0zSWUw9wb3HbC8A9UNMojeTv2nMCZFVtkhToPNktWaPq2tjw97TlSVpqW+yJgyJcUK3tvm5CJ3Ky9F3sg5QZpj/Fgf/5mEhlqr4Xqc5/yxhnjqrQbmD/3H+iDRhcDpmOLccD4QYpM73VHmx1KiR7ZqF/A1by7Dwnt8GpkrWhKONf2oW0UwafSN0t;20:Q7q33qGXA2crVUgGW9DAKenZm3rJ6WwuWSU3mqQwcVvr3VtRT8SIGwe5Yom4gQIBLsDess9BIr8lF3Sni65wZQwf8wUVyrD+UkIBToOS1S//I9vEO4rsPzOssc0YIQTu5TreWTHwoj0pzXOQS0Qul67ZtPtNcfuModTVpmV0ugA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5444aae-f1cf-443c-15b6-08d58db1e800
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807C6545E4A02039B3BAB5AFBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(551934003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: D/fUudDOJSFoxoW+bFCR998AwPgmq3Q8Opj3qbPxoTSMMzjkGDtIqg95Lj5QDPAhYvJ4BM4ZxF0eRWOOh3RTx3pOHv3XytMx2OLQaHXxTMEGUw+iVqd+vZQKJGFkeMVTEwe3mH0VRznV0oSql3wMcK/kOKvZy6Gg3hHke4NWPlqx559uzwy4glzu7+gTD9GbTN6VF8W4tfKWpnik3fsmyFnSuvaHpHPxll25hfNvoRuN3wOFUu1ZmxMJOHAS1r+wH5wpKZ6LXlCSQhm5WvQaT3epcONot8D0vYoKVvjbsFEAOTenUjO6BZenzvIHyU6EjuGvXQAyLyBEcgr1Wea5ow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5444aae-f1cf-443c-15b6-08d58db1e800
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:46.0168
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
index 6bd916bd35e2..838566b85622 100644
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
