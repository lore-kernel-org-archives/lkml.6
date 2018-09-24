Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04574ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CCC2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YCgox/hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CCC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeIXVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:08 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733152AbeIXUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q30DVymhR9erNTTBkeAfqE/vW1MjC4YCr5Z6UuGoHY=;
 b=YCgox/hw3MiWz6D35mvKqMGeFKsHh9Bkh4UdDuOeLFKrF5TSqAmvbVcfLPd72Wx+Wl6QNsAN0eqeY2wW5b/YrfpGk0pt6MJ17+5hN02muJnTmz7tOH3mXZX966wQEcyBaR64YfA7F5t7Qe28TMN81RNJk19mw2y79f3GHHFecaA=
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
CC:     Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/76] md/raid5-cache: disable reshape completely
Thread-Topic: [PATCH AUTOSEL 4.18 45/76] md/raid5-cache: disable reshape
 completely
Thread-Index: AQHUVBWoNI3sQnETBEyeVVCZBMZZTQ==
Date:   Mon, 24 Sep 2018 14:48:29 +0000
Message-ID: <20180924144751.164410-44-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:v50snfBQSl0qZE9ZGuk2nMUX7o6+ATs2oyt47pc9WkvyBsU39XSePG0jXXakfe+P2w4iLQF6jmAkQwNUgKt4Fns0Y1/L25vgkjMYkCSdKWp/2wSOqeeVJDQA8ppSugh1avRF5hgOZZdOWV/7Rkh2MOd1WLKXoaFt1xca4Yffq/gz6YHz0DYwKf4k1xTTxUlB1DXTC+cBgt/aYcBEB+fMlbDvs+IfBPRofNUmQ3ztwOhuBaPgrOHESZE3fQxM1R2WH1WJlYh7ulMMYZx/M2u98v2SJaupR/D4VdOKoFkyTkDrN/cyE8J5RR+qjvHsSEAXGztsMizJJbqbJMFKaPnoHnrbE1NdwNomJQ8zeUEBXfIefTRsoOzUyIN2oYTN1c0cnwX0GIjL9xdfInNOrTiTIzDx8sqGc/DedeXr7kvhj4krtpZEea4nQMj/rX3RNPClcQvU/LVGwBNU6rU6GtjpWg==;5:bpq9G3PUKDYbdYwI+eATxsF0HBclDrP4rKmikr26NHVa3E8MXGV0pwXBjilz+2LY0rreqZO4V6Sf6rbymSdA30uytxR7EvzNRU6O554Pxf4PnlaznOF3vl+C4LEePRqts2dDuYEV7nsWl+GPd4vT2d8UydXUCBaXKulF7oCK3Pk=;7:OO9UaC+6UA9LIX4+MvyKsRnYyodu5kiBznQRhTLdB8GwrIQhSDoE9Z28PfFGrMyJ6FF7uH7TfZIhD/jj5T/tAmHr83jfgAbV11BdffqtjSIw5eFw4zUE+lpM6gmV9BzWSuE0/DgzCpPX6KdjbTbqrZqenmBjtrdW2dWyKvtWxnd39qa/5Qf8r889z+ffjjQaMTRstAnu/odqt1eYiFPDI3eWjjKb4TtvSSBBtf9lsfj4YAeciHnZKVnBjYzpLKgP
x-ms-office365-filtering-correlation-id: 919f95e8-65e2-4fd2-9b65-08d6222cdad8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855FCDC294404861D88F19FFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PxbYCZ/Xj0WWizy/Vjy3CJ9OJYEaW3OeGjqwALZBnJGGefTMXblZu+2D+cly2i8T005N6f4x6fV17gHVh0iud5D+H9VZgYluEDydzM+WX3pV3fuAnD0Mmpm3GkqbCavfhG1wc7A9ZxTLQH5QDbmc6t02CMojJ41vITf3EeSwMIwUi9tr4t6daGhwioi1+ZyCoVe5gzz7ZVhXLm9Jglp2RQi0kU0LEYOZm7lqkK7vrwHWICuiQYIut/MmJE8sfWu6DuQ0DZD3udSasdqHrDJMD0ddVHekbTgTmKn+DxqKLZbvJdtA7mxCt0gQvq2xpfYbK8IT7ksWZHflcc54pE+iPTFZn6GmlAgZ32TmOvYFWKY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919f95e8-65e2-4fd2-9b65-08d6222cdad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:29.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shli@fb.com>

[ Upstream commit e254de6bcf3f5b6e78a92ac95fb91acef8adfe1a ]

We don't support reshape yet if an array supports log device. Previously we
determine the fact by checking ->log. However, ->log could be NULL after a =
log
device is removed, but the array is still marked to support log device. Don=
't
allow reshape in this case too. User can disable log device support by sett=
ing
'consistency_policy' to 'resync' then do reshape.

Reported-by: Xiao Ni <xni@redhat.com>
Tested-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid5-log.h | 5 +++++
 drivers/md/raid5.c     | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index a001808a2b77..bfb811407061 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -46,6 +46,11 @@ extern int ppl_modify_log(struct r5conf *conf, struct md=
_rdev *rdev, bool add);
 extern void ppl_quiesce(struct r5conf *conf, int quiesce);
 extern int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio);
=20
+static inline bool raid5_has_log(struct r5conf *conf)
+{
+	return test_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
+}
+
 static inline bool raid5_has_ppl(struct r5conf *conf)
 {
 	return test_bit(MD_HAS_PPL, &conf->mddev->flags);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 49107c52c8e6..9050bfc71309 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -735,7 +735,7 @@ static bool stripe_can_batch(struct stripe_head *sh)
 {
 	struct r5conf *conf =3D sh->raid_conf;
=20
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return false;
 	return test_bit(STRIPE_BATCH_READY, &sh->state) &&
 		!test_bit(STRIPE_BITMAP_PENDING, &sh->state) &&
@@ -7739,7 +7739,7 @@ static int raid5_resize(struct mddev *mddev, sector_t=
 sectors)
 	sector_t newsize;
 	struct r5conf *conf =3D mddev->private;
=20
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
 	sectors &=3D ~((sector_t)conf->chunk_sectors - 1);
 	newsize =3D raid5_size(mddev, sectors, mddev->raid_disks);
@@ -7790,7 +7790,7 @@ static int check_reshape(struct mddev *mddev)
 {
 	struct r5conf *conf =3D mddev->private;
=20
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
 	if (mddev->delta_disks =3D=3D 0 &&
 	    mddev->new_layout =3D=3D mddev->layout &&
--=20
2.17.1
