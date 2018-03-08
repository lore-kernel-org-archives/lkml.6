Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491991-2-16119934337610122932
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
    t=1520491991; b=LkGcdEGHHRGv0U83ki0lKh/2ISuNHdhOFHdcKjSFuu5CDC8
    0EIvBw1HMJJc7PQPVg6PmRgOKuxFoPa96kYWxipzkRwmAirIEZafXmVm1+sZerRR
    88ST45CK4ACj6HTtn0sprwFjudFF3x7xRPQ1hHfrPk07C4WwLDv3vMWyHtQxe9/1
    /zs2yjApfrzaPjf9rIOqTVrnnnnQJLOZlEBVGOilg2Zs1JLMWeZ85MeYvYjwdnSv
    QDlr7XcXMwlCl2tRnZXFgip5doDuRChgPG2OZOV5LTBKPZDnWAdjs+k4BsQxrIan
    7D/FToN2/h1AQ5Up291vyYqJR3UHrr2rTXqBlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491991; bh=dOLJEf
    N8RvsdM+q9P4bEDVPl0XiWWAZye944O2ks4Ok=; b=nYujXh+HChTKhBV+tFW5hN
    a35Hw/TbqDo6x473nIWxCbHK5dFJ1IC4mA1cB2fEYR2YNUQo9Mcwfp//D//+qnDn
    SS7eFpzEl0XBDDRh6y0Mc2kokXFFdm/GahUuKqq2PxB/89eMby1jL13e/Lhw7iZr
    x5GTqXQvFRkDXxXRGhBkE5oqyE0vLmARfAs5F6J/zl8q84QTqH9uIzkc2tT6WRyM
    ILcetpZW5vyj3V2XcFNxOB/eupQTZPIkKGynza0G0b9nSp9kFhG4KlLZh9SoWCDU
    VqpcyPjZ0C9NmN6pfiBTKQYnPxCZPGfiqUKPfDArDi2m9wlxS5ldZMmRvTlQ+kUw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hR/bSMFh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hR/bSMFh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbeCHGvU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:20 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965022AbeCHE6J (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 08/67] dm: ensure bio submission follows a
 depth-first tree walk
Thread-Topic: [PATCH AUTOSEL for 4.14 08/67] dm: ensure bio submission follows
 a depth-first tree walk
Thread-Index: AQHTtpn5gSdG8BrM8kCcPe54AEj2FQ==
Date: Thu, 8 Mar 2018 04:57:34 +0000
Message-ID: <20180308045641.7814-8-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:egRFjD/v1kvNnkFfNHFdE998dARAMO4qIrZhmsOebiBpdmHGKd7WcWUUwX0G3hwFkG8LaYXjEX9Zcv6XVvNv3ojqj2sBILIINCdJGuTbtB8vBeNdTFt1/XbN6FWFPpAAgJYyNqV1IkawY6gC3c+/wITZ9Z7Y2U/PKFgI2CzTv71PwCZH4QO/oXYjaC1DEzYezMRMjPWW7/4+5PXSD0TYcS81NKz94SdyEJHMdc4wCoOiImjZMMKjnMUrJNYV+GUN;20:/0l4sxkT5+EqOU9SUoLgzsXpbIokB8hRfsvrW3hhp91EKDpGQIcAJLYhuAam5xUgBMqh5fCaFRp8d5nh2klHdI7eYPzVTGcJ4eA1vkxzW+j82aZSfilCATg9uWp6qpEiSCIded78Vo1e3yW/saMLd6kd7o/ar51pojL8MHKe9OQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73668705-c8b1-47b2-c0f9-08d584b12dd9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08888FB3333BB37BBAE27356FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: C54aKUqE2Gz2EGO/nCvkYykQfnhO4q608QjPSNLV0W3p68HMW4C4VUvVxPTmDkYocw/dNAQZQ9loJGlP3+S3MCedxbV4znLq77UxvBDSwtDYrB2JJS4z/+9Rzvb3CktHhsdHQtgQApfOlszOb088Ui5reSgz/da6M5QYi90AysmkZHS2wXogMIsuZOUCO+9bvJ+Kxuk3+9wwgtQ0hN8NZyzPIEjcpuQW6KPBYuGWRC5myi3EjiXschh4V+V4fjVx6NHy10HAC6kk1yKU+6H60V5LiefYcJRg5hLa+nxkhLY1T4BObcL/88xrwdbVpKs30OockfEYF9G5nbvsxxyruw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73668705-c8b1-47b2-c0f9-08d584b12dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:34.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 18a25da84354c6bb655320de6072c00eda6eb602 ]

A dm device can, in general, represent a tree of targets, each of which
handles a sub-range of the range of blocks handled by the parent.

The bio sequencing managed by generic_make_request() requires that bios
are generated and handled in a depth-first manner.  Each call to a
make_request_fn() may submit bios to a single member device, and may
submit bios for a reduced region of the same device as the
make_request_fn.

In particular, any bios submitted to member devices must be expected to
be processed in order, so a later one must never wait for an earlier
one.

This ordering is usually achieved by using bio_split() to reduce a bio
to a size that can be completely handled by one target, and resubmitting
the remainder to the originating device. bio_queue_split() shows the
canonical approach.

dm doesn't follow this approach, largely because it has needed to split
bios since long before bio_split() was available.  It currently can
submit bios to separate targets within the one dm_make_request() call.
Dependencies between these targets, as can happen with dm-snap, can
cause deadlocks if either bios gets stuck behind the other in the queues
managed by generic_make_request().  This requires the 'rescue'
functionality provided by dm_offload_{start,end}.

Some of this requirement can be removed by changing the order of bio
submission to follow the canonical approach.  That is, if dm finds that
it needs to split a bio, the remainder should be sent to
generic_make_request() rather than being handled immediately.  This
delays the handling until the first part is completely processed, so the
deadlock problems do not occur.

__split_and_process_bio() can be called both from dm_make_request() and
from dm_wq_work().  When called from dm_wq_work() the current approach
is perfectly satisfactory as each bio will be processed immediately.
When called from dm_make_request(), current->bio_list will be non-NULL,
and in this case it is best to create a separate "clone" bio for the
remainder.

When we use bio_clone_bioset() to split off the front part of a bio
and chain the two together and submit the remainder to
generic_make_request(), it is important that the newly allocated
bio is used as the head to be processed immediately, and the original
bio gets "bio_advance()"d and sent to generic_make_request() as the
remainder.  Otherwise, if the newly allocated bio is used as the
remainder, and if it then needs to be split again, then the next
bio_clone_bioset() call will be made while holding a reference a bio
(result of the first clone) from the same bioset.  This can potentially
exhaust the bioset mempool and result in a memory allocation deadlock.

Note that there is no race caused by reassigning cio.io->bio after already
calling __map_bio().  This bio will only be dereferenced again after
dec_pending() has found io->io_count to be zero, and this cannot happen
before the dec_pending() call at the end of __split_and_process_bio().

To provide the clone bio when splitting, we use q->bio_split.  This
was previously being freed by bio-based dm to avoid having excess
rescuer threads.  As bio_split bio sets no longer create rescuer
threads, there is little cost and much gain from restoring the
q->bio_split bio set.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1dfc855ac708..902b6a5d3a4e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1497,8 +1497,29 @@ static void __split_and_process_bio(struct mapped_de=
vice *md,
 	} else {
 		ci.bio =3D bio;
 		ci.sector_count =3D bio_sectors(bio);
-		while (ci.sector_count && !error)
+		while (ci.sector_count && !error) {
 			error =3D __split_and_process_non_flush(&ci);
+			if (current->bio_list && ci.sector_count && !error) {
+				/*
+				 * Remainder must be passed to generic_make_request()
+				 * so that it gets handled *after* bios already submitted
+				 * have been completely processed.
+				 * We take a clone of the original to store in
+				 * ci.io->bio to be used by end_io_acct() and
+				 * for dec_pending to use for completion handling.
+				 * As this path is not used for REQ_OP_ZONE_REPORT,
+				 * the usage of io->bio in dm_remap_zone_report()
+				 * won't be affected by this reassignment.
+				 */
+				struct bio *b =3D bio_clone_bioset(bio, GFP_NOIO,
+								 md->queue->bio_split);
+				ci.io->bio =3D b;
+				bio_advance(bio, (bio_sectors(bio) - ci.sector_count) << 9);
+				bio_chain(b, bio);
+				generic_make_request(bio);
+				break;
+			}
+		}
 	}
=20
 	/* drop the extra reference count */
@@ -1509,8 +1530,8 @@ static void __split_and_process_bio(struct mapped_dev=
ice *md,
  *---------------------------------------------------------------*/
=20
 /*
- * The request function that just remaps the bio built up by
- * dm_merge_bvec.
+ * The request function that remaps the bio to one target and
+ * splits off any remainder.
  */
 static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 {
@@ -2044,12 +2065,6 @@ int dm_setup_md_queue(struct mapped_device *md, stru=
ct dm_table *t)
 	case DM_TYPE_DAX_BIO_BASED:
 		dm_init_normal_md_queue(md);
 		blk_queue_make_request(md->queue, dm_make_request);
-		/*
-		 * DM handles splitting bios as needed.  Free the bio_split bioset
-		 * since it won't be used (saves 1 process per bio-based DM device).
-		 */
-		bioset_free(md->queue->bio_split);
-		md->queue->bio_split =3D NULL;
=20
 		if (type =3D=3D DM_TYPE_DAX_BIO_BASED)
 			queue_flag_set_unlocked(QUEUE_FLAG_DAX, md->queue);
--=20
2.14.1
