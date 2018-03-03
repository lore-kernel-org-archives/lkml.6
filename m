Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123762-2-4400732793907575654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123761; b=ZmBXvquIKTI8WK6aYz3+Aw9jcuSZQNgyzJpVdmCtUXhcQJb
    7f5vgmPGZ863Fo/uIye4d7GPkUjUs8bDJIRkUz49d+DMEvGqBh11wnrQSmtPuRdz
    knE9Qz4koqo3M3t39dB5bEIeIyrtTjMxSgbzNN+iPqQYxdSRROZp8Vat88hqYHtC
    /fS1eZcgD9WH4cHicyfZx90HPO75ddccSOZYVysbc0qxeOP2SQfwNDd+kRLf2HW7
    zvdUxGEO/tUbUK6AweM8lnmV09nyhFfGT8L/JuMPWtL/qAPFylB5H56uSCn3fHWx
    gQ4OIjTZXcIe+Nu0xwn4zulf9PVvVyAlf2Am1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123761; bh=mRCtgu
    BKNNaOyEqF9pNZW08WT+KKc2LRlVuxb4D7Xak=; b=XEOuUwsP4AyPU7uUt5pd0N
    JeXl6jIigzzcUnWIChlpPUwna4hqNJNHQPiBqKCgTCZJjQl0164UjUL4Qs2f1zcF
    3popEbAaJUWerYtBHASNRYV18sIgvFlF9TQrDecPBk1WePYmJqruJZ3AgaY93Gq3
    +TCZD8Q40oxY8zA4s1J0GxIZOQsGYoQpHYZLGlaujcafevxygbWKUDXXVElRrx5r
    ZD3BUZv9E8S1868OpLFrFexHwcw/ExyahdNRVKCAU3AVN7szr0CteXquVVTIqM+k
    fJMopahJOHb4TCRIabg63F+5ddjr8TvbOFKCvoWSnXZq8W2yZiwSS9w5XGHqpFMA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AE9LEfp6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AE9LEfp6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeCDAfp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:35:45 -0500
Received: from mail-co1nam03on0095.outbound.protection.outlook.com ([104.47.40.95]:24743
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932886AbeCCW1K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 080/102] dm raid: fix raid set size
 revalidation
Thread-Topic: [PATCH AUTOSEL for 4.15 080/102] dm raid: fix raid set size
 revalidation
Thread-Index: AQHTsz51QFHdXsACjUevS7ONjIrouw==
Date: Sat, 3 Mar 2018 22:24:56 +0000
Message-ID: <20180303222318.26006-80-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:ijAVgWPBquGxaapnL2abkG/grRgwPA0iZ92AYgrAmpivUGo3Ks4DdnYNv/MWpVGM10hYBlckZ4gVwYQWZeNNd9uODqZo6GPMNhSap3NDO+ngOo5mDhJH0iGr8Z/VRe62fqF5bZd0YcgTLX+DT3TicenHzsHMCxAn2khD1xJFR0XjT+CrnOmq3oVWSejWrZkb2gB4ywORAR7Zhk+D+4a1gvhBoD43GERp4/E2lL0RWug+nUhr9hQoPpjV8JFEiJyUvuyCKB5YaHEPL4D2ic2/nEDlw00CivWbzbBvSC6kGq0n3BFp1RjzQl2isbQTorEdgZbq68f1FdBhPkHC+Y2z5qKo/ulEVPXi7wmhsDGl3bRNrFnarOh56lOG/NnYVi8T;5:fDhV8/g9trSe+HhD7POr6QlH+CRpxiv3AiJKSBgkN8kxfKBtHU75UiLERmWiqpkk0QnpwmC6Jy7y6+jFMfwPlUEHkTuR6tLts2tBRRUao3DTQSLJ8qNnbSgNWw4ihYhgn3XtFoXaTB0nXYzFT0XMCC0pzec+UjTNpt0oECYFmfs=;24:mo/1alWUwDlzCnxU523/jU1uCBI9+RaeIMoXx3Bo3TtwYnyLdgTuHw2NaB9Kl5PlC2M7syV0umqwAcQK2XAhmZRy/UYHuZELYCeWHzWGSNI=;7:amjrHZqLzHe9vd94sjGvDmX8khuKrSCZCor/cidjXW5+m0Rl7ZWmM2PZw79yCG596B9kYhCvDvpXweBisT06hc/dS5IH3kM1kK+jWnfyqG6lBngojHwax6RKmZu9DOBJREbUObDFL++IwNuuhfqjQY+qgFgG3si2NVQ4H8Rgp1vqbjHqLyeca4cI+QFZl1lCdP/WqvxDlmCw9gJxrYokSPoBUPATbQmC1ZVx4XKpqC1fQIqC1VVXi1XLICXmgqUA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e46db19e-20a3-48aa-c0fa-08d58155e574
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10675BBF2C89A96B01F80C4EFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Knab7lBqNT2j25iXLIFoKUfO4PJEyPhM52PgG+naQkVxR1SDD7Qhw5HPJbn0peeULwOQgWyG1wZqWWi1M2/G/CkPUd+MLgkogGc2M0NOSSYqEbr9rDCchN2PkVwbNcYeP3kv4Jj8cbMoBPh0FExWs7zuDmXj6r8bCNv4lBhLYOA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46db19e-20a3-48aa-c0fa-08d58155e574
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:56.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 61e06e2c3ebd986050958513bfa40dceed756f8f ]

The raid set size is being revalidated unconditionally before a
reshaping conversion is started.  MD requires the size to only be
reduced in case of a stripe removing (i.e. shrinking) reshape but not
when growing because the raid array has to stay small until after the
growing reshape finishes.

Fix by avoiding the size revalidation in preresume unless a shrinking
reshape is requested.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 6319d846e0ad..d0f330a5d0cb 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -675,15 +675,11 @@ static struct raid_type *get_raid_type_by_ll(const in=
t level, const int layout)
 	return NULL;
 }
=20
-/*
- * Conditionally change bdev capacity of @rs
- * in case of a disk add/remove reshape
- */
-static void rs_set_capacity(struct raid_set *rs)
+/* Adjust rdev sectors */
+static void rs_set_rdev_sectors(struct raid_set *rs)
 {
 	struct mddev *mddev =3D &rs->md;
 	struct md_rdev *rdev;
-	struct gendisk *gendisk =3D dm_disk(dm_table_get_md(rs->ti->table));
=20
 	/*
 	 * raid10 sets rdev->sector to the device size, which
@@ -692,8 +688,16 @@ static void rs_set_capacity(struct raid_set *rs)
 	rdev_for_each(rdev, mddev)
 		if (!test_bit(Journal, &rdev->flags))
 			rdev->sectors =3D mddev->dev_sectors;
+}
=20
-	set_capacity(gendisk, mddev->array_sectors);
+/*
+ * Change bdev capacity of @rs in case of a disk add/remove reshape
+ */
+static void rs_set_capacity(struct raid_set *rs)
+{
+	struct gendisk *gendisk =3D dm_disk(dm_table_get_md(rs->ti->table));
+
+	set_capacity(gendisk, rs->md.array_sectors);
 	revalidate_disk(gendisk);
 }
=20
@@ -1674,8 +1678,11 @@ static void do_table_event(struct work_struct *ws)
 	struct raid_set *rs =3D container_of(ws, struct raid_set, md.event_work);
=20
 	smp_rmb(); /* Make sure we access most actual mddev properties */
-	if (!rs_is_reshaping(rs))
+	if (!rs_is_reshaping(rs)) {
+		if (rs_is_raid10(rs))
+			rs_set_rdev_sectors(rs);
 		rs_set_capacity(rs);
+	}
 	dm_table_event(rs->ti->table);
 }
=20
@@ -3842,11 +3849,10 @@ static int raid_preresume(struct dm_target *ti)
 		mddev->resync_min =3D mddev->recovery_cp;
 	}
=20
-	rs_set_capacity(rs);
-
 	/* Check for any reshape request unless new raid set */
 	if (test_and_clear_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		/* Initiate a reshape. */
+		rs_set_rdev_sectors(rs);
 		mddev_lock_nointr(mddev);
 		r =3D rs_start_reshape(rs);
 		mddev_unlock(mddev);
@@ -3875,6 +3881,10 @@ static void raid_resume(struct dm_target *ti)
 	mddev->ro =3D 0;
 	mddev->in_sync =3D 0;
=20
+	/* Only reduce raid set size before running a disk removing reshape. */
+	if (mddev->delta_disks < 0)
+		rs_set_capacity(rs);
+
 	/*
 	 * Keep the RAID set frozen if reshape/rebuild flags are set.
 	 * The RAID set is unfrozen once the next table load/resume,
--=20
2.14.1
