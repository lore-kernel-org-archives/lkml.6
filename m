Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00783ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E512086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VGI7Eosk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E512086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeIXVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:08 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:62688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733084AbeIXUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv9HiXhYWkXAXaB5awmIZyq9d2euUprWX/1gQ2OYVXQ=;
 b=VGI7EoskfH9tyancyzAoZdfnZTuX5soy0kClLDKwTFBTu5cn8hofoXb3hMYmGExznGzagp1zTo7Zl6hTX7L6fDMn8oT1RrJnwwb37dE4dPjLYoSsQnUDL2YhAAmtWut+7aieOMsR+nsdTRmmH0CfanFDsPnEHFYm2SUVGZqCpDA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 44/76] Revert "blk-throttle: fix race between
 blkcg_bio_issue_check() and cgroup_rmdir()"
Thread-Topic: [PATCH AUTOSEL 4.18 44/76] Revert "blk-throttle: fix race
 between blkcg_bio_issue_check() and cgroup_rmdir()"
Thread-Index: AQHUVBWoen3YZ0qAXEebjgZh7NFdTA==
Date:   Mon, 24 Sep 2018 14:48:29 +0000
Message-ID: <20180924144751.164410-43-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:FyEypP5mt5JNnVQ7SSs2XRihC1zUJYoOVbx8fjrWDdlPBCAZrSDKbs+04fIj1j8S5KcZXnUZekgqW5YjkNYqGyJVf8i+8n1Jd7Ac43R3pLd77k6sloSsUDU3xrXAAazcWjnxpsi3e8/uyas90xeYcO6Ms+LLFNRqcMd+vYHcGVd9LQJ4SBPullJgyCqm8TZfLPILEmtLHjb1VrCuQPIVrmoEd4e6ui4NK9Bpd7D8H9DjDnEigdhwqa8jsgtmoPU+/34YQAJwNhFCklHwP0XfCFiyOr87xSmpJT218QPtOw/OiFqjEgPzyp7rrII/UJsqnPdCc2wNQjTeOEZuK2rQ2Lf70V92DY9hwxPysTuyHCjeiKYHIkV/SGdGhfjXLSYDarQCxXpYbjab2qNBFEPZybKWySgLXTzaW5s/XOr8byQjogU9YngAL+n0f+j9/H4pgHZbUg4LmVyYVhksyBRhdw==;5:0FFyWbEMkZjnX8CrWkKKogIl0Rv45QawuWiXCUOpXR0UEHqya20m34J3c02uS9IcsLjVggOcbqH9yzKFebg2r7S9BpW/sNPrzDk5gzLSPsA1di94fdVQlCWhT2BtOrNx3JQR942i/DKpMQuqS+QxKXOIPwyVyPD4Fte+YHn8P4I=;7:h9SBJQbeQVqSCStN/TVtGwirRpnUW7tRV8em4zneHroD9sHuqE36P0MoA6mZz4U7L0TztXIKmaSOJUgkHJJRBaGpSiW63wPGoJggIwt3YzCkJNdFuRBvRIs1lc9nOtFDDw1f2rKjbL68G+JwMSiAJDT1ERtKqZC/OoRMWK7R55rOvnk4rvtTmW+HwnYGY1Ad4fV5IMY1dyTbIbGZ/VUK+8T91BRPlZK0f8WotEx8b6rlc2Up3ZgZszdcc3SJ3JCV
x-ms-office365-filtering-correlation-id: 6ad9b977-29a5-4d56-b2f7-08d6222cdaa2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085563CB3016453CF4CF1E33FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(85827821059158)(168385556255192)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(39060400002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J6lhqkd3axbhcG4TE/1jYWwH4yY/wgHCAksdIUNmAUrECgcZl027jq7sY6jEr2Fy4yY5r9lZNXFBtkEhXGLvZvcFbfCpwQKN5yWzJdzJ2WL4l/2LZvVrBq/MJSX23HtR7BWms4vw+srGV5emvRDmKEop3yfB3qQUOkSotdmcF7SvwHiwEy8KrDNiG8sOXN6cEECux7v1ZkbPQiUlDB+8VBSlENCqAU1vu7wTMGoYTDynNXz9hL/9JyQY+eLY1kNJrek5gvllZ+Nxj0dTZ/53M1wOqK1lmYa/NbuxSxpB2/NCv6b+5i6yHRHkVlxpL2JYlg4CVEE6KdsHv8DzNYhaRwqomWpTmVbib397/v8ObP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad9b977-29a5-4d56-b2f7-08d6222cdaa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:29.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

[ Upstream commit 6b06546206868f723f2061d703a3c3c378dcbf4c ]

This reverts commit 4c6994806f708559c2812b73501406e21ae5dcd0.

Destroying blkgs is tricky because of the nature of the relationship. A
blkg should go away when either a blkcg or a request_queue goes away.
However, blkg's pin the blkcg to ensure they remain valid. To break this
cycle, when a blkcg is offlined, blkgs put back their css ref. This
eventually lets css_free() get called which frees the blkcg.

The above commit (4c6994806f70) breaks this order of events by trying to
destroy blkgs in css_free(). As the blkgs still hold references to the
blkcg, css_free() is never called.

The race between blkcg_bio_issue_check() and cgroup_rmdir() will be
addressed in the following patch by delaying destruction of a blkg until
all writeback associated with the blkcg has been finished.

Fixes: 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check(=
) and cgroup_rmdir()")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-cgroup.c         | 78 ++++++++------------------------------
 include/linux/blk-cgroup.h |  1 -
 2 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb87c40f..ec868373b11b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -307,28 +307,11 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blk=
cg,
 	}
 }
=20
-static void blkg_pd_offline(struct blkcg_gq *blkg)
-{
-	int i;
-
-	lockdep_assert_held(blkg->q->queue_lock);
-	lockdep_assert_held(&blkg->blkcg->lock);
-
-	for (i =3D 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol =3D blkcg_policy[i];
-
-		if (blkg->pd[i] && !blkg->pd[i]->offline &&
-		    pol->pd_offline_fn) {
-			pol->pd_offline_fn(blkg->pd[i]);
-			blkg->pd[i]->offline =3D true;
-		}
-	}
-}
-
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg =3D blkg->blkcg;
 	struct blkcg_gq *parent =3D blkg->parent;
+	int i;
=20
 	lockdep_assert_held(blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
@@ -337,6 +320,13 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
 	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
=20
+	for (i =3D 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol =3D blkcg_policy[i];
+
+		if (blkg->pd[i] && pol->pd_offline_fn)
+			pol->pd_offline_fn(blkg->pd[i]);
+	}
+
 	if (parent) {
 		blkg_rwstat_add_aux(&parent->stat_bytes, &blkg->stat_bytes);
 		blkg_rwstat_add_aux(&parent->stat_ios, &blkg->stat_ios);
@@ -379,7 +369,6 @@ static void blkg_destroy_all(struct request_queue *q)
 		struct blkcg *blkcg =3D blkg->blkcg;
=20
 		spin_lock(&blkcg->lock);
-		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
 	}
@@ -1006,54 +995,21 @@ static struct cftype blkcg_legacy_files[] =3D {
  * @css: css of interest
  *
  * This function is called when @css is about to go away and responsible
- * for offlining all blkgs pd and killing all wbs associated with @css.
- * blkgs pd offline should be done while holding both q and blkcg locks.
- * As blkcg lock is nested inside q lock, this function performs reverse
- * double lock dancing.
+ * for shooting down all blkgs associated with @css.  blkgs should be
+ * removed while holding both q and blkcg locks.  As blkcg lock is nested
+ * inside q lock, this function performs reverse double lock dancing.
  *
  * This is the blkcg counterpart of ioc_release_fn().
  */
 static void blkcg_css_offline(struct cgroup_subsys_state *css)
 {
 	struct blkcg *blkcg =3D css_to_blkcg(css);
-	struct blkcg_gq *blkg;
=20
 	spin_lock_irq(&blkcg->lock);
=20
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct request_queue *q =3D blkg->q;
-
-		if (spin_trylock(q->queue_lock)) {
-			blkg_pd_offline(blkg);
-			spin_unlock(q->queue_lock);
-		} else {
-			spin_unlock_irq(&blkcg->lock);
-			cpu_relax();
-			spin_lock_irq(&blkcg->lock);
-		}
-	}
-
-	spin_unlock_irq(&blkcg->lock);
-
-	wb_blkcg_offline(blkcg);
-}
-
-/**
- * blkcg_destroy_all_blkgs - destroy all blkgs associated with a blkcg
- * @blkcg: blkcg of interest
- *
- * This function is called when blkcg css is about to free and responsible=
 for
- * destroying all blkgs associated with @blkcg.
- * blkgs should be removed while holding both q and blkcg locks. As blkcg =
lock
- * is nested inside q lock, this function performs reverse double lock dan=
cing.
- */
-static void blkcg_destroy_all_blkgs(struct blkcg *blkcg)
-{
-	spin_lock_irq(&blkcg->lock);
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg =3D hlist_entry(blkcg->blkg_list.first,
-						    struct blkcg_gq,
-						    blkcg_node);
+						struct blkcg_gq, blkcg_node);
 		struct request_queue *q =3D blkg->q;
=20
 		if (spin_trylock(q->queue_lock)) {
@@ -1065,7 +1021,10 @@ static void blkcg_destroy_all_blkgs(struct blkcg *bl=
kcg)
 			spin_lock_irq(&blkcg->lock);
 		}
 	}
+
 	spin_unlock_irq(&blkcg->lock);
+
+	wb_blkcg_offline(blkcg);
 }
=20
 static void blkcg_css_free(struct cgroup_subsys_state *css)
@@ -1073,8 +1032,6 @@ static void blkcg_css_free(struct cgroup_subsys_state=
 *css)
 	struct blkcg *blkcg =3D css_to_blkcg(css);
 	int i;
=20
-	blkcg_destroy_all_blkgs(blkcg);
-
 	mutex_lock(&blkcg_pol_mutex);
=20
 	list_del(&blkcg->all_blkcgs_node);
@@ -1412,11 +1369,8 @@ void blkcg_deactivate_policy(struct request_queue *q=
,
=20
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		if (blkg->pd[pol->plid]) {
-			if (!blkg->pd[pol->plid]->offline &&
-			    pol->pd_offline_fn) {
+			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
-				blkg->pd[pol->plid]->offline =3D true;
-			}
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] =3D NULL;
 		}
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0fce47d5acb1..5d46b83d4820 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -88,7 +88,6 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
-	bool				offline;
 };
=20
 /*
--=20
2.17.1
