Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118613-2-14008911004118159469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118612; b=BKxpWkHySN4JHnTxp5Hzwovl7Y1LQBiLA0yNr+NTcVdoS4M
    r99undWA85cltCEXFYqwJu/G18Aa6clP22GbcYw7tzktp5Npz8xyC4J5+k6iMGLt
    SCYDxrtS8BsDcQRjieKTgNzVdYO/OpAnbxQptEf6KyPIC5E2a6kMb2cEU2DpPHfx
    Ox6OJGxWKleqW0n2BFMA3BBuX0fwnKFgmsoWSbJgCASqcMtwTH9eTPGEtJNIGGLP
    H/7KrpyMAuQ/YXA8YRy+fAAdFIfLcwpwHUy6Ht6mcqG1EGWZft0x2in+FXP9oCsj
    9AvtfZdfh9Ia9XfUKnhIoLmeb9QJn0CaaAQI7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118612; bh=GynX4Q
    51D3thEsbZwMBYDnEefgQXowF20YCsol9GssM=; b=C5ay+du/hEgtZzUoqL0tHo
    fuCiKu96vK/lFK3I4Lh9z1hiYDoDmtRnuI+NaCneEjdHm5vnSEZiSKD7OWez1yHb
    +TygudPWUNRuVyqoE0b3D+A/zQ3LxrHnjVizqPD3JW+tErpIJo1CTeUDy6UBC70V
    7UNytnz2pclQ7xPAq6gU01kiznQptU2MaOOf3apGRyB9Qh5H4jNkoF+udXgvSpSq
    PHlnKweWe6ntmTYte7LAUE0pd0jO2jjn6aRO1YrtN5fHKgCZFKlxoWiT299xUF8o
    tNKTeOYTh1t/zAPP04skRymkjPYZOxiPgEcqDsOu+0p4UlRppDQ6utOrqg5rC0OA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MX6egxJk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MX6egxJk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbeCCWj1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:27 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935083AbeCCWjX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 053/115] reiserfs: Make cancel_old_flush()
 reliable
Thread-Topic: [PATCH AUTOSEL for 4.4 053/115] reiserfs: Make
 cancel_old_flush() reliable
Thread-Index: AQHTsz9Zdz+CCRkZaUeOxrZE64ozWA==
Date: Sat, 3 Mar 2018 22:31:19 +0000
Message-ID: <20180303223010.27106-53-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:mj3AvHJYZYbCNN2LTR2pOePUGG9vegcDU4qcVeIf+J4NNo9DQT3vkETCo0HDxdCOrhJ0leFqVsXsdsYsFDZOAWVDNgSkWCakhJ5hT35LOSbnPEN/9uH+uvCJulxGVz8yjkbEbBBq7/k185njkAzJj8rR8hIr+BNcCsxgmuTWUSm6efK1yXuKNeBZt+pNC3rA8maND9BXVu/5/lQCY02OiuHisb7IaxgFkIGnRn8hfmZ8L9vkncbkiCwlvHP3x6CS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80da9096-9a04-4c21-01a9-08d5815799b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113BED2A9B3DC49FD445D76FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(551934003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wjEg2YG7ETS6Z+AgLbI4083VDa57WcM2iDxKJ/DFiCi/FUPxWpXRYTh95WfuPRzgchqrMQHYBSdF7NQwilxyPtrJVK032vTJdCzOahvrleXTC+IwkogY4ipaTk8h3exh70g1zKxXMsdAmB5q8znG/k324xMEDZd8FVbr3bkpg5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80da9096-9a04-4c21-01a9-08d5815799b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:19.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Kara <jack@suse.cz>

[ Upstream commit 71b0576bdb862e964a82c73327cdd1a249c53e67 ]

Currently canceling of delayed work that flushes old data using
cancel_old_flush() does not prevent work from being requeued. Thus
in theory new work can be queued after cancel_old_flush() from
reiserfs_freeze() has run. This will become larger problem once
flush_old_commits() can requeue the work itself.

Fix the problem by recording in sbi->work_queue that flushing work is
canceled and should not be requeued.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/reiserfs/journal.c  |  2 +-
 fs/reiserfs/reiserfs.h |  1 +
 fs/reiserfs/super.c    | 21 +++++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 9d6486d416a3..a72097b625ef 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1961,7 +1961,7 @@ static int do_journal_release(struct reiserfs_transac=
tion_handle *th,
 	 * will be requeued because superblock is being shutdown and doesn't
 	 * have MS_ACTIVE set.
 	 */
-	cancel_delayed_work_sync(&REISERFS_SB(sb)->old_work);
+	reiserfs_cancel_old_flush(sb);
 	/* wait for all commits to finish */
 	cancel_delayed_work_sync(&SB_JOURNAL(sb)->j_work);
=20
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 5dcf3ab83886..6ca00471afbf 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2948,6 +2948,7 @@ int reiserfs_allocate_list_bitmaps(struct super_block=
 *s,
 				   struct reiserfs_list_bitmap *, unsigned int);
=20
 void reiserfs_schedule_old_flush(struct super_block *s);
+void reiserfs_cancel_old_flush(struct super_block *s);
 void add_save_link(struct reiserfs_transaction_handle *th,
 		   struct inode *inode, int truncate);
 int remove_save_link(struct inode *inode, int truncate);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index f9f3be50081a..ee095246da4e 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -90,7 +90,9 @@ static void flush_old_commits(struct work_struct *work)
 	s =3D sbi->s_journal->j_work_sb;
=20
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued =3D 0;
+	/* Avoid clobbering the cancel state... */
+	if (sbi->work_queued =3D=3D 1)
+		sbi->work_queued =3D 0;
 	spin_unlock(&sbi->old_work_lock);
=20
 	reiserfs_sync_fs(s, 1);
@@ -117,21 +119,22 @@ void reiserfs_schedule_old_flush(struct super_block *=
s)
 	spin_unlock(&sbi->old_work_lock);
 }
=20
-static void cancel_old_flush(struct super_block *s)
+void reiserfs_cancel_old_flush(struct super_block *s)
 {
 	struct reiserfs_sb_info *sbi =3D REISERFS_SB(s);
=20
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 	spin_lock(&sbi->old_work_lock);
-	sbi->work_queued =3D 0;
+	/* Make sure no new flushes will be queued */
+	sbi->work_queued =3D 2;
 	spin_unlock(&sbi->old_work_lock);
+	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
 }
=20
 static int reiserfs_freeze(struct super_block *s)
 {
 	struct reiserfs_transaction_handle th;
=20
-	cancel_old_flush(s);
+	reiserfs_cancel_old_flush(s);
=20
 	reiserfs_write_lock(s);
 	if (!(s->s_flags & MS_RDONLY)) {
@@ -152,7 +155,13 @@ static int reiserfs_freeze(struct super_block *s)
=20
 static int reiserfs_unfreeze(struct super_block *s)
 {
+	struct reiserfs_sb_info *sbi =3D REISERFS_SB(s);
+
 	reiserfs_allow_writes(s);
+	spin_lock(&sbi->old_work_lock);
+	/* Allow old_work to run again */
+	sbi->work_queued =3D 0;
+	spin_unlock(&sbi->old_work_lock);
 	return 0;
 }
=20
@@ -2187,7 +2196,7 @@ error_unlocked:
 	if (sbi->commit_wq)
 		destroy_workqueue(sbi->commit_wq);
=20
-	cancel_delayed_work_sync(&REISERFS_SB(s)->old_work);
+	reiserfs_cancel_old_flush(s);
=20
 	reiserfs_free_bitmap_cache(s);
 	if (SB_BUFFER_WITH_SB(s))
--=20
2.14.1
