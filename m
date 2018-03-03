Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122550-2-3009897998443669557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122549; b=arjQ5pXnPTjuarrby3Upl2K0TJzfiwQYcXQjeFnlK81FUC9
    Zy22VkapHBOSB2WqnxfeCUAqIg9wGWe4zynbpOM+Ji61iN8E6kKI8XoXsSC2p13I
    6KTe/tYVXfK1DRlviUc02PnnzyVp30A04r84Q+AutljB+0tBCXt7zpPvcksStsFB
    PutaCA8a1rCHHoO63jjlu5YPZWZ3Z7di2LYub5g/mvymjbUBdYeCKZtOqqnRDFii
    SKcOIuIJSL0QsUeJkj08FuEOSL29xX4vegmScIiyZ57vPRG9cRDTfwBNGwEqzj+d
    hnug4xAJ2f0sgUCPeZ41NvYAK5PsDg6jbQZIBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122549; bh=WqKIlG
    PG68/mJJt8T72o7IcQl+zSvJoMyQJkTNgOnDQ=; b=I4PYJexOzWHOij08r4QXD/
    2jC7S1zHxf31CURTuzM+ekUUADTq1XpHN9XnRgNliCRbvlAnZocqEBBBimPTbZnn
    2RacPEt1dTfuafyBJCBJrAiCQbVAdK306AfqyrGbaq87qD4dlQjRPw9PM+jYIA4b
    9HwoGG3sbmlyMYjj9R+kbopb1uXKIXNzFJcTHzxth8wVwm62bOuI08SOi886kBeY
    sRbl0Y/+GUEYqn0/qXhGPGeoPgQRKhbRza91Zz6482R8VcXeWxnNw3dBp+Va/yeG
    BbhaWGXadQBqVQQkzT9/NK6B7+CHtFbqo/j3QcrQBCfY/viR/fgyzH8EvRWb3whw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ei9uL8W7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ei9uL8W7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeCDAPj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:15:39 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932498AbeCCWan (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 62/84] dm raid: fix raid set size
 revalidation
Thread-Topic: [PATCH AUTOSEL for 4.14 62/84] dm raid: fix raid set size
 revalidation
Thread-Index: AQHTsz6xanx6qyq8wEa71zp/6Lmg7A==
Date: Sat, 3 Mar 2018 22:26:36 +0000
Message-ID: <20180303222518.26271-62-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:Ta0gqxUrEyc6cpOd1rnYd3GkKkjKNzsH63jq8NpEdU/BZw1PPASYYIQq2HoGg8XSjw1kxU9D3ov3EtnpDgKdbvCyErra91IVbsKiv8Pr+F95arep3kF2lumKCwoPWr3RG99SYbX/P0yAgxFZFtOToe7SEff3xKkX75YhUC7SuFVCz/E7dRtNOr8VHuk3UocP6hK3H9OS+v14a9zSIJ9KsWqNUkiCNPsXuRKYQhV8buzKQGHjwJguoPzZ/vqbKnHO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04784654-6b79-45da-31e1-08d5815665ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115799FABAD5BAED31DC4A0FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DvMCdH7G3kFNgQ2/GsY5j7tK8UQicVJVZ2p87ww9onIbjcIs+COmPGaZ4FpOkaMlkIQyWGjvnoImD+L2VGDGB3EOa4XTW7t7Og47QDpQY/AwZA7Sg2U7WNnBwZJrFAi1GpPfshwIC+/7ULGZpZMUcsPVe2gyNs9twL+PinGvgvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04784654-6b79-45da-31e1-08d5815665ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:36.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index a25eebd98996..33834db7c0a0 100644
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
@@ -3845,11 +3852,10 @@ static int raid_preresume(struct dm_target *ti)
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
@@ -3878,6 +3884,10 @@ static void raid_resume(struct dm_target *ti)
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
