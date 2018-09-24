Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF0C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BoE8vLAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF0C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeIXUwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:54 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388233AbeIXUww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2iugCv+44QG55XZ3euFS74q6oQ+kPDvUzX/kfrL954=;
 b=BoE8vLAJJoYcr0zmjPMVlVuAtueaR8qeBF4zwNRfh2QkC0NgYITHzyFUmPN++KdHvBiStTlrwNg8IlsmS52DLYY9M2d7I8mw/ofsCcw7EcbsvQgCMax03NglRn0XPSxxnX31ltBiEPnNEReFsQeJK+AKqgLNx7NctnLCqEYofS0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/36] md/raid5-cache: disable reshape completely
Thread-Topic: [PATCH AUTOSEL 4.14 22/36] md/raid5-cache: disable reshape
 completely
Thread-Index: AQHUVBW+ZmpoHzg3qkmvVz7ar4jwdg==
Date:   Mon, 24 Sep 2018 14:49:06 +0000
Message-ID: <20180924144851.164533-22-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:xyvtsA5JMPvzG69t4RUE9332BlQ5JCFJVu/33TuLFh0/UOj0wEFiNLvT3WZptXWm9GykoQJCtvadeja00RgVNxwzZdxgqyWCBBVEsOgS2pjVpTVhJ8R1+W5rLk7P5Dxcn8TgjhH1Zqh6QCQKJZoO058U/jLg1UNHBNEp4tVXolvRzqGCz0MnkabkoZkD2PaCGww/k6aIZ+px9RMsdYHcme7xTiN+QaCf/A2aVaRbn4IjzdPx//nJU+u8kuveQ3jKtoSd7vg4CmNRLnAI56h2ODfWvE6uHz/ndRr8yV6sc6kU6V1gw6ezzl+qrVd/ir/O41aoy7wkahZzbEkEnmUBuCVse3BV1imBroWPN+XWBu3KtR/7Hl6QYpJebDcW4tzVDB+YlCyS7o9Q3fc5l2udfsV2V79DdzNXa4CcPJEMMB19TtdJUCnRVhyz7P/MEoUM/nFWtzeBoRgqJFQrBTIxHw==;5:Dwvg1xmKByDQ/RnepBNM1hbRuRwCSgPhhd/jpr+3P79RZwgbYkHDf9bpOYvmcg3UbGHppiI1bAkOOI4KE+/duHpSLtLcrrRpUcgNpKYj78WMKLWI2pQ53WEKXDWK+rlQlFU7lJwcaXg9xS+RTvwF+yNoWlhECimtULAe/JSRb2s=;7:1WbvE6CcIPQQ/KkLwDlH5ub9q4QymmZ0vsDNIRql+46AQf65LTQovm1b5d60dSGhhvdpeYccHIba6Iku7HV82J+uGqeYl5P1H0lzny9tO3xnxT6u3AvOORs/1844PcpgPsP0iCT3wv+rchy1gPzKdDdMAG6m19/r6WC5qWkF1foGdb0ZY7gVhW0VWlkFeITnXqYQbo9TOR0B6b7Nkeoj10ZC2La5pUQ/TK/u0u4IeSdTl/W73/f7OubslBu5/KMk
x-ms-office365-filtering-correlation-id: 47fc2ed6-30fc-49eb-a95c-08d6222d0af4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04704B7F414762DB62F767CAFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dLcfgII5B/zyGeeNjGQDeeZdoQbXCEGJnqyzqMcA/FfVS6x//3UcqwFN0u0XSy5u8PjDyR8sKclnuUnMYwpOkQmLHe+KKnm+GeDNf0Wdn/xRjC7pkDEYIrOQgZr7pNFpk8iXLGwlTXtV7Dhu2Cgs+Hk0UJkLKOBfzrVKaRIi3cMDUiAG7wZFTf3PrWlInt9j/lm3xs91fFnKhnRLsXl1+UDvKTCdKh0AUsXc8s7wE4lynJ9mEf++Y+wxxTuH1SYsmSFl6wltnwRaDZ12LNgOnqhy6WPXRO9pxsgfhOvKmgUb4VBi7LvxjIQLR6K7aJxQAxwc0TYUaCI+n3u4KPn0m7aBgZZDBKpTbv5B0D/LKIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fc2ed6-30fc-49eb-a95c-08d6222d0af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:06.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index 284578b0a349..5c908c510c77 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -43,6 +43,11 @@ extern void ppl_write_stripe_run(struct r5conf *conf);
 extern void ppl_stripe_write_finished(struct stripe_head *sh);
 extern int ppl_modify_log(struct r5conf *conf, struct md_rdev *rdev, bool =
add);
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
index 5018fb2352c2..dbf51b4c21b3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -736,7 +736,7 @@ static bool stripe_can_batch(struct stripe_head *sh)
 {
 	struct r5conf *conf =3D sh->raid_conf;
=20
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return false;
 	return test_bit(STRIPE_BATCH_READY, &sh->state) &&
 		!test_bit(STRIPE_BITMAP_PENDING, &sh->state) &&
@@ -7717,7 +7717,7 @@ static int raid5_resize(struct mddev *mddev, sector_t=
 sectors)
 	sector_t newsize;
 	struct r5conf *conf =3D mddev->private;
=20
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
 	sectors &=3D ~((sector_t)conf->chunk_sectors - 1);
 	newsize =3D raid5_size(mddev, sectors, mddev->raid_disks);
@@ -7768,7 +7768,7 @@ static int check_reshape(struct mddev *mddev)
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
