Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485450-2-17944363341863538275
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
    t=1520485449; b=n9FklUE2RF0S8ZxXGgLxo2h2z1jXoweC1kdThndxka3zSPR
    zOTYVGz7IdwCjkc1Q9jX8588on2ixYobgaZV6z1zXJK66+0M8ptYnEmx2TjnL+mT
    iV8mEi2QJ5A4gX90ZQb8c73esTaJ8FDgv2z9cQKi9GJCmgPHhOf5rLR7GdiFjvWs
    9tOQmL7PQaXM0ZQtU4XiWgB4MgbnUCVYV8SuQP2cJdSTSlSZvylLEKPekdNxLZwF
    xegp7GQVYUssp5VFs++4TCTL6JpDHiv8fkSkTGoJ71QqIRlTEGXlMSzFPD0hsg6V
    /X7NoZxq/vBI3tX9dKz4IYPIw4VKB3bNOKTwETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485449; bh=mEK9Mv
    chroSNn0bAHLtknwrTIvUpCx04yrZVdbH5WP8=; b=T7EWFXijzjogIhsfLu65VL
    SmVfrd1+ngk2Pc0dZ/XEPm3j/NByJATMLpu/HtbZQHmQjzRKb6umERh0S0D3JJeo
    Ys/gzDWEkmbzdj/fUKOnuTyU9HhbSmedhHmEytzTjh8hQJRhn1cP/tc3DLqQswsn
    uBBqD4COGcp//cf/ST8pMRPXc+E0jPfU75MvxCS4kZCHsCpRNND2Ep2dKCbZS5jX
    ZmDPtmxvTk0uE9/Pe5bq0Vl7pfY7QrT4SodExtyYYbmjuR2zZVZLgymk1W/5Swky
    Gw8gTSgi7YOiMXSDG2UmeF5bXZjzksJQUqFpvfxjnkVjZipys+iGlk2u9tIBkalg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mkmKFW9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mkmKFW9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966118AbeCHFEG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:06 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965206AbeCHFEB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 156/190] dm: ensure bio submission follows a
 depth-first tree walk
Thread-Topic: [PATCH AUTOSEL for 4.9 156/190] dm: ensure bio submission
 follows a depth-first tree walk
Thread-Index: AQHTtppQ/I7+9fexrkenTaq+KwFZxQ==
Date: Thu, 8 Mar 2018 05:00:01 +0000
Message-ID: <20180308045810.8041-156-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:nWuBn8FivjHQxQZASbFyLZ6DJXJ997/gMjGEdM+5tNWMAE4x3SoMzt01mip/pt4U0KBI3d64/i/E0uDANLHZn/RWVVQICaqYSen0rXO4mMmEqjAqqRvs47obJz7319hFrd9jDdIHuQNVzwV5JStoic986YQcsTbWThmhCtmK7AOxQAQXy0OZRlvd3CV8DlLlvRpB7FiTgcZMOnqP2qdTuA8bntNGNi9aSl4CezEjYAzpGLaEKDXczmjCpfVPHqmj;20:+LHBuLge3h/WzqTAVwF5vEvUgYms31mvy74xFUQpYRJ2atHrtiIOT3nRzu8F4EzPSdKsDxTHnbgtX5YZaMxCG3uJQqqvPaf/RhFwCLqtLGxkIwIdQ611aMXFsqLuVR8Fht1H58ymeNE88A06VbJnxkMO5R+fU/6cublwlTp67rg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31d62c0c-355a-46a2-875b-08d584b1fee0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09198E0E50AAA319C9BD970AFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vxdQgp2xxVYkOPeQUKdVWgb7Tgy0Jbu7dOC59iaOtB0AI5oU5P4lHOoFy5qKMo6QVtHqVeV6gvEcUsE+8WnKta8XT4dLZeXaY0oCnuZpHbozSKtOL+dYPSer5ZCFtgIHo9o3fm/UyyM3y3Lur9M+XPdUuL46DAp0hG4eh2D+R6BgFsfmk4IRXmIjmeLA3YLX9J6NgAztMhrsdzb3byROf0sbLh/saXt/RroBGsa5MwvZlSKnBf7RSI6MsdmYwQhnzxEqt6rd6HdGtPS0pQalxVXPDy+y6XZa/2hHBiAzpkDFWCORXN+dnhOrGrhb1uBsbg2bba+Cs03zHa2gDNc6WQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d62c0c-355a-46a2-875b-08d584b1fee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:01.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 2ffe7db75acb..2b2ced91dda5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1320,8 +1320,29 @@ static void __split_and_process_bio(struct mapped_de=
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
@@ -1332,8 +1353,8 @@ static void __split_and_process_bio(struct mapped_dev=
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
@@ -1854,12 +1875,6 @@ int dm_setup_md_queue(struct mapped_device *md, stru=
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
