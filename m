Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493093-2-8945250382792174088
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
    t=1520493092; b=vtaJqLvt9+1z+Kxoc0k81IBC3EcRVnrXZbzWHhSOO9MSf/E
    p8JotYtnrFuQ7KKiprqPNvrV9R8bqL2K/9Zxp5+P3nKfvBVNdYWamg2f11nGDEMT
    YF2cB928i8z1pw7hVfQNtP5J0qLOefi/LAEtSn5nWMB5aGoCkkw7pCxJ9BKwgHoc
    vbqPlyNuun47dSaZosyjOwpjISJJLPmTNMCotEqIxDKdszE5q9lzBIm6ehCk5ow7
    PHbZ7qpf4HKUY3xLqMtWTtI/pWCvkwGo3MsWZPLfze4FSrN5yAcTHD1gvxRmw9mq
    T0pSvtIYvvIVGvxN1lBLrx+5iG8/fuwU9F/RH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493092; bh=0ySJqr
    qFGPmwpFqwgnVG+nOSi/zWPmCvxAKLtx/lMXY=; b=Agh5sBvSSiXNT80uOsRSs2
    CrySbC73Y9lKvvC23rhCIFiPcZfPE+aaHxOJEXowINt+blzrjAYtfQFuhygETM8b
    YxfAQUtMA637Ah752eUSIiJxxLjpUvrQjBFOxsVM2xd8YBBPUmWZiVyVBbwyJtQb
    jmgc0WJKZ5mGhFADBDWOEL6QkUekUumHi6H3tpalljhhif64ip+plXlICeUf8Hi2
    fK62HDGug5k5hP9pNgbK5qc5Z661ah6sqg7Gmc0f4TXBz+Uy941AG5ru7Jh4RUpp
    pL3par7fW7Q4do08zJrAdTO1E0i+XkACuAypktvkRRkqoe0nceiz9/1X6Ms5/GXQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ef7vxUGp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ef7vxUGp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935260AbeCHHLU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:11:20 -0500
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:63552
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755101AbeCHE4L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 10/78] dm: ensure bio submission follows a
 depth-first tree walk
Thread-Topic: [PATCH AUTOSEL for 4.15 10/78] dm: ensure bio submission follows
 a depth-first tree walk
Thread-Index: AQHTtpnDjUL287ubHkS8HeGMpyVsxA==
Date: Thu, 8 Mar 2018 04:56:05 +0000
Message-ID: <20180308045525.7662-10-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:h5QDEk4A5k31YtnF3CF6AVFQWtB1aKVlMeH/e8MNDqfqeaiFmRjAB43WNR6MU2dFH7bJBDWHOeq5YTsM1L1WiTYLk+0fwJntEYic0Rk2KSkVgK6lmWVwJ2f1ZAFBlHAA+hvmMMV7s4rE6EiGs7BVkpl+mnvWq2/KvG1ppePc+EwbUX6Cc1P1PumraXeVfhjcRwMUpnRFgjFbMi5yXieBsmz1r8EqS+Xv52i8UQTTY7x2pwb25R39rhHCITOnsjyq;20:Hub3uJyKMg944FJvAjRbOvE1vWngn491W4AjmFsViNAWpmkfvk/YiCF5Mhm8Mui2LBIdusEqLJRkbHwbKbTeJrieAGE/rxugNxj6DOcV7y2e0NjaBxIgnyJpzYvDgrE7W3KSm2DOnC93e0phDPauXPvhYLfsAL4oZwAV23a58OQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53f6c789-ee39-4ed7-1b18-08d584b0e646
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902925F2C9CF24A1EECAFB7FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8pYHp35ryaWYMhX2QHj/t84mwgUU4e5pMFrash1qY+tCGLJId2MeKwpZAhPkCsTIwMdu5O1gXYHR54s4gvG/olS8fZwXlXTUPb7xM7cLNBLIVrhgTX5sQZI2LXkrSBZlHiapguzLjojCRSPDHZoI1d12skiGwpTHLiCrxRc8QeY0yGuNGFSTtFodC8JUqNyNScUs+65gMQTk4VzU+UiS8BN6bvd9QTbp9VYT3w2eyDYOCH4BkFf0nlfzFO4IhEPtyUKWWbJaXC9MFv167+/jiAaiLxrbdFUlck1vowAx8GkLn0Q18L7gBqw0ywsFIAljyIbnZVR4PUwG2QNFrpRlhQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f6c789-ee39-4ed7-1b18-08d584b0e646
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:05.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 1c42b00d3be2..04402d2ccb20 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1499,8 +1499,29 @@ static void __split_and_process_bio(struct mapped_de=
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
@@ -1511,8 +1532,8 @@ static void __split_and_process_bio(struct mapped_dev=
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
@@ -2035,12 +2056,6 @@ int dm_setup_md_queue(struct mapped_device *md, stru=
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
