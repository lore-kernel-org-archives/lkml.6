Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117437-2-13389010281646953033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrofr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117437; b=fVQRPnBlgsGGWe0Y+7ueEpH2Jtb1KfUWNbZKpWNb7KNC5dK
    L/ECXGgi+3rOZa902IvWo9L99k2gtuaolZS0hdHRBplxMTyhSstk3ZbRikrDENPp
    DMjVR2wTOL7zsbR3VZ9qwNl1X6pU/ydpicCDSnN5kim5eNxALBvua7Kugkn4lnuN
    DfKPFhoMwEbDM2wHT/dw2O6bd0rsJlMx8xEsBhZTiScguujIIDc6BFO6JRjLVs3d
    BIPANo73NPFbj4qUmgj2rp+daKmJNja3GYBlNZbZgTWdOYb2CcVcOYDCLaDEzxhi
    V2XFqrkdh0N3AJsqnad9805MS9rVTqMesjhDAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117437; bh=4Snu5B
    WBnPZw9arcAC5sibRVovYIKv+F83/7kUxtUnI=; b=erHYcMRYh7n0GGYI4+hDFY
    8HpxlM6ySdB3XlfCwULOwPGzxgEt3IshR545/OQ94Mywb9/j5NHLGHSf00jztfL2
    ry0e052udn64J1bo2xOQDvopK69Hu2na9Z59Gzb04YpIcDrFI7NljM6YmEuRXE+x
    tz1wr7+imwEvkpw3rg5kMBHLGybYRzCg8ijbrxcZ/vVavo2DjmI4zd8V9I+t/LoL
    PkHBVCre1nxXCLDxxvK6Oyf0vecZKOc7N2SaDCGmUtAyRzhsRB3PokWsv1tozsSc
    1f3GEfshSP2FK4Ep0EZmub+lUWnzzcC2pjiadDgLtUCNvgjqaa+ZoF89VCC+H4nw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2SjN6Ly x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2SjN6Ly x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933545AbeCCWuR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:50:17 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:64496
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935470AbeCCWlO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 30/63] reiserfs: Make cancel_old_flush()
 reliable
Thread-Topic: [PATCH AUTOSEL for 3.18 30/63] reiserfs: Make cancel_old_flush()
 reliable
Thread-Index: AQHTsz+mP/DYhJyksE+HmaCQcSjcOw==
Date: Sat, 3 Mar 2018 22:33:27 +0000
Message-ID: <20180303223228.27323-30-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:AK04SzPb2XbFYLJobO45cHPjcLg0aKMOg/ZMMTJ45sxCVEjwAhAfZR1EKzIhwoSsXICgVd5J0Ei/6LaJNtvYCNbspEGWwdenKc/5P2OkgwfbDXtO5R0TQKjNLtir8bDfMogJlNx22o2jzG7mwujFGSS0zbzZV1fXhvAhN4vtDOi7+rCs0nPzNqbhdjELJq7N4ceQLCAD0VCNyd2Bn3JhMzs4VhExYh6rovCNHLP9h1WVXkHVtPSamYn0/Vdfglum
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25d90c8d-849f-4d61-fc9c-08d58157dcd2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06B9CD0039B428BB23F375FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(551934003)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2UDmCc09x7yGvF0/PMQJghWXjsMlXVgqYKiOvgz6mnMe5JRy5zGilcT7dF3kEpxgdgfPuCNprXjRs9/oSfPzMRvwli8lftniteKLa+bJIqOgHTZBpVuS9ADYGdE78By1aiwdaBY6zvk+VOpYsVCvF199mf5LkX9YdmPUBZoFRWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d90c8d-849f-4d61-fc9c-08d58157dcd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:27.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index d571e173a990..e503effd284d 100644
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
index 1894d96ccb7c..8fb8107710f7 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2946,6 +2946,7 @@ int reiserfs_allocate_list_bitmaps(struct super_block=
 *s,
 				   struct reiserfs_list_bitmap *, unsigned int);
=20
 void reiserfs_schedule_old_flush(struct super_block *s);
+void reiserfs_cancel_old_flush(struct super_block *s);
 void add_save_link(struct reiserfs_transaction_handle *th,
 		   struct inode *inode, int truncate);
 int remove_save_link(struct inode *inode, int truncate);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index b27ef3541490..5b8acce4f863 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -89,7 +89,9 @@ static void flush_old_commits(struct work_struct *work)
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
@@ -116,21 +118,22 @@ void reiserfs_schedule_old_flush(struct super_block *=
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
@@ -151,7 +154,13 @@ static int reiserfs_freeze(struct super_block *s)
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
@@ -2164,7 +2173,7 @@ error_unlocked:
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
