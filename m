Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245257-2-6839172820662562168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245256; b=Pif1Q5McR6ES4tNbO1XXe7Xnu0QUMzGyabF4aMkp2x/0IuLQ2U
    YUHFMHoBUPM4VV2EgFxKw6HxocwrLT2tDhteftIIPoVPPUd9DQPb9GvXSmshpx2V
    2bRdsPnJyU835YYOlj5ec6FZ5hXtZFDlfqzffTYvhzrV3US4B2GZ5pW0GE1rEU/I
    b0Y+apnbkWkqdYGu4ykCNHIJUzFCnf6W7AqXwvste7A6LH65SzFeEHGR8xQ17DUn
    g7z1KFXMHvEGr7/DgeE4ErvTlHhpZm526WQCYacMCT+YMog2SbYubGkpRP+TMKXi
    dnTXKl6NmKPEJ/do00FvteQcLJSZxyPDUmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245256; bh=Nw1usw0hlY
    0mlEitAb2CPXou3GTnmmp6Xm2mkbOBSMI=; b=XbK/YvNWd20Spd3Nqt///J+0on
    dXrv2ZrjgpS9xZIYC3qlsXUlOxwe59mn8JgV6k9R8jHKS6zxJBGw972/t/cqUdlT
    TWaMNJZW6cTOj2UElAv1lFrbDz2F73VNqegZSgBZ5KdPa0cV9Oplz+1wDUSBBMGd
    9XZw6vSoalWBUcelG5+GC1kZm9OlaAkWsq672qNPCw38zOT2pQoYRepBlqgslyZN
    OYY0wYSX1f43dIJrBU6eQTkUFH/s68Z8oXoewvho9KvLK67wh9Z16D+ZUUzH8/BA
    aLFhXWIKLUnSDHbdmavcI/CcJ1gnITKyQ1/GLSQAh3xLtKSoaQS9mrqXQHyQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mg0i+V5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mg0i+V5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCMQn5F+AO7CKH/mq88dpMZ52BkFfxAGzj1J5+dpfWWm7t8kqGHXWT2+Rjmc6p+x98VREuhJrL7+FKcNwyHLwcefKJ/xo4P/QWt33jASMqu0TKLhwG2X
    BARevYRlNS7d5YZNlpODRnAY5+iBIMWkF3LCwJ5hVwt+izCxa/PJeViERYO3rULX1Y9YMG2pCmk5xAAiTEQN6M8NH/a4Juj/yGtClPXYBmztdMhPwqWRwZM8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDIDkG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:40:06 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754365AbeDIAVH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 162/189] bcache: fix for data collapse after
 re-attaching an attached device
Thread-Topic: [PATCH AUTOSEL for 4.15 162/189] bcache: fix for data collapse
 after re-attaching an attached device
Thread-Index: AQHTz5hahNFw44/2w0+HxIsyaWjffg==
Date: Mon, 9 Apr 2018 00:18:58 +0000
Message-ID: <20180409001637.162453-162-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:aIdyC/rY6DC/aal/+/935yC5NTzioM7uy+H2EO2aqAqnPCg5LJIbhnPg36Pn/YBKSN9ORjx8Zwn5013c69vBdROw19fIDlNS45EtPxuuBz3QVwCkh5I2JG1i6odnP0Lt511sZdQZIKWXM1LKEQpgTyhlf6P7ami0CZCdH6e66iqQSSwZ+DyrtFyip6MMCp6SfV7JTi+qPNMb3bC4Wf9tJfIrXc1qjBkdh0TO6SGpFUF5quyO9UzGTV71xlVvZlYD;20:hMK37bhl0dAcDKZlAQUSYCzqLP5zTgIMy3IrGI/Jt5F6IZSpLKzb+c7RTRKrIAY7uCkiZQRqWm15UFBtpw/SJkWhlSbvem/Aw9qHenNs8kST0eeKmE4q5rQ4NxAQ90GnimIF5CGIDqg6Vvhp1O1wgJNBuyqufaevp8z6HaIikvQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 974fcd69-2f38-466c-ef20-08d59dafc8cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11108D833CD09E979F11DE90FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(5890100001)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qeI8wOa4pB7eFOFQEEC7B2xrayti1kewDoGAXnE4SRDVocdRQAQTxhV+uuuQwnw+DIiuDrsEV9g+i1pHOBKetUAAaGZwkO9yIbiJwPC0kVetnpT7WH/NM4eHDY3kEwXCAEe+Fnd7p5slasIKBxM9seYBUKRgt/FhDGCeJCR0D5BKshtWBOI8ABINfshjlREpJLEJuoBMUHwo75vKa0+wYQK65x+lk5pUGL0LJ8bzewoJfsE2ZmaVjNKi3ydWAJdcO0WAkeliFEo4/HPFSoz+fCK+5x/x1pE+eFbSZoDV6ioKR4CCFzEoa/v1CmtIbj3+WrnHiXKqhvE7b3Hb56c/Gw1bwNdUVqZYCJ5DjOnvlNbTfV9vYOSW+4t5eHqBPYomTpeum2h1OtuEvMYXZtM3/i5Ov9fOvqAkLXt7oRsRvHM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974fcd69-2f38-466c-ef20-08d59dafc8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:58.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tang Junhui <tang.junhui@zte.com.cn>

[ Upstream commit 73ac105be390c1de42a2f21643c9778a5e002930 ]

back-end device sdm has already attached a cache_set with ID
f67ebe1f-f8bc-4d73-bfe5-9dc88607f119, then try to attach with
another cache set, and it returns with an error:
[root]# cd /sys/block/sdm/bcache
[root]# echo 5ccd0a63-148e-48b8-afa2-aca9cbd6279f > attach
-bash: echo: write error: Invalid argument

After that, execute a command to modify the label of bcache
device:
[root]# echo data_disk1 > label

Then we reboot the system, when the system power on, the back-end
device can not attach to cache_set, a messages show in the log:
Feb  5 12:05:52 ceph152 kernel: [922385.508498] bcache:
bch_cached_dev_attach() couldn't find uuid for sdm in set

In sysfs_attach(), dc->sb.set_uuid was assigned to the value
which input through sysfs, no matter whether it is success
or not in bch_cached_dev_attach(). For example, If the back-end
device has already attached to an cache set, bch_cached_dev_attach()
would fail, but dc->sb.set_uuid was changed. Then modify the
label of bcache device, it will call bch_write_bdev_super(),
which would write the dc->sb.set_uuid to the super block, so we
record a wrong cache set ID in the super block, after the system
reboot, the cache set couldn't find the uuid of the back-end
device, so the bcache device couldn't exist and use any more.

In this patch, we don't assigned cache set ID to dc->sb.set_uuid
in sysfs_attach() directly, but input it into bch_cached_dev_attach(),
and assigned dc->sb.set_uuid to the cache set ID after the back-end
device attached to the cache set successful.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/super.c  | 10 ++++++----
 drivers/md/bcache/sysfs.c  |  6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 843877e017e1..40f02679f176 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -907,7 +907,7 @@ void bcache_write_super(struct cache_set *);
=20
 int bch_flash_dev_create(struct cache_set *c, uint64_t size);
=20
-int bch_cached_dev_attach(struct cached_dev *, struct cache_set *);
+int bch_cached_dev_attach(struct cached_dev *, struct cache_set *, uint8_t=
 *);
 void bch_cached_dev_detach(struct cached_dev *);
 void bch_cached_dev_run(struct cached_dev *);
 void bcache_device_stop(struct bcache_device *);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a7fcc51d44e9..d43ac7ceb90c 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -946,7 +946,8 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 	cached_dev_put(dc);
 }
=20
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime =3D cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -955,7 +956,8 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct=
 cache_set *c)
=20
 	bdevname(dc->bdev, buf);
=20
-	if (memcmp(dc->sb.set_uuid, c->sb.set_uuid, 16))
+	if ((set_uuid && memcmp(set_uuid, c->sb.set_uuid, 16)) ||
+	    (!set_uuid && memcmp(dc->sb.set_uuid, c->sb.set_uuid, 16)))
 		return -ENOENT;
=20
 	if (dc->disk.c) {
@@ -1194,7 +1196,7 @@ static void register_bdev(struct cache_sb *sb, struct=
 page *sb_page,
=20
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	if (BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)
@@ -1716,7 +1718,7 @@ static void run_cache_set(struct cache_set *c)
 	bcache_write_super(c);
=20
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	flash_devs_run(c);
=20
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index b4184092c727..c54028b92bc0 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -267,11 +267,13 @@ STORE(__cached_dev)
 	}
=20
 	if (attr =3D=3D &sysfs_attach) {
-		if (bch_parse_uuid(buf, dc->sb.set_uuid) < 16)
+		uint8_t		set_uuid[16];
+
+		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
=20
 		list_for_each_entry(c, &bch_cache_sets, list) {
-			v =3D bch_cached_dev_attach(dc, c);
+			v =3D bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
 				return size;
 		}
--=20
2.15.1
