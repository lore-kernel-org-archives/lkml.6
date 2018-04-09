Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234649-2-5877958118799836635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234648; b=niFcuNXGK8+Bmo3wDfxSM9vZtC+0cZGgczLTdrOkfELVCcSqn1
    zk6vvLdjLPR5FsarqfmPVHYdpo1MpiC6lzwX6VzUDt2oqh/hEKloy8sIPJ5TwW50
    QGegtQ+EU3RjYao31rLQR1ucgsEYavS3wErjNL9TFQ5a7025ryhKlNPwvXndDygh
    AkPTTE/0e1lS1HPc/9LGEyeEj18dZNvPbPoedqoy+Nzd2DM2c3uR5Z31SHZd0Oqq
    nGKM3sVxRVg3gC6lbLNZeZF45LrQgGlsr/N1OPKuqy1BNmaHQP/CMHR6l5K5OVH5
    wWpU7X5AfjAkBxAd+t+FG1OJw6Rncqc0ISdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234648; bh=Fyq6tpbv2V
    ZHmhsl3aaN5HXR2dnU5Xtc6l6A99/T6Sk=; b=euYfCrrpx1RIqBcudXMLjdesJh
    BP/wS12vXTjUcTCxZ1gCemCMaEM3cO3+yI6wtfbiZ0yknZcRpP/DOBeXGkGzdzbB
    GXuEH3fV9PSnX9VimOyv1fash0jNPpprPme1PepVR6BodpoYEJGYj3qJuZKs/p7k
    95HMZrmzJqSa5K/Au/Fs+MrlIsXFxeUXlsa2nGDoltvZ+T6VU34DjJ4nUqVBx7ES
    yDo6MOkDdKwv7p8jsmuoIhvOhJ0FTbQSxmL/tW+LKku6+UatXHy8Fy+pQqoGvcmh
    jAKjf+dCS/JmulFbJvmVLuQfE58MBAXmc6uFD7vW9+t/8P05y3bO5sTqnvbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BpfkJzxk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BpfkJzxk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/7cxfnxd1wJc96PxFIG3IVixbNGimkFGTEUH0immmmxjtCViymBpAhaKeokhT4Jsj1274bJ9rGLRwZVTpQcBPNy+WghCNkRTx1p+xcI8fo7qXyGkcN
    YIyEq/flAXPw+uLy40yfhV/3Jzbl/0JlWcrcLrJVOVi9oQdkqvuWoLBw1hcOggFk2ekiDbLuFVygFVAKjMuLxlr4mTy2iffrrMiIXhGHWzqRmGS+vRQapBi6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeDIAnU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:43:20 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:45955
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756799AbeDIAmf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 098/101] bcache: fix for data collapse after
 re-attaching an attached device
Thread-Topic: [PATCH AUTOSEL for 3.18 098/101] bcache: fix for data collapse
 after re-attaching an attached device
Thread-Index: AQHTz5uOO1oud73zpEaEwBGCQuSEmw==
Date: Mon, 9 Apr 2018 00:41:53 +0000
Message-ID: <20180409004042.164920-48-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:xnnJa5w0JX9jDcNKS+lPNrWE2d66XnhoIjRnbRd5dBtHhkWiRkWr0HQeVOk9s+8I1z+JEvER7iDPNFCS9JEXwzRr2HuuP8SsJVgpyd8CiZFxgsKEt+RXQkIR2+BtkUhfhxaUBNz1ZH5s1dujP91RB0gTA5bBDj38XUUltGfRCGsin6PwugWSC3mJZJR1n3eoo9LsHMy6KT/YZ93kCwhHnTLKWjTLlBK4lT/i2AkoOjsxFkXlFmgKVUkOYi9hFSLI;20:3Jl5HR4yoSmRKvC3GZaWA52UpYdkKNkMi0EQvz8ofcXqnEuqWEmWavXgq8pfl7zmziOyLqkoxceBXu43B8EtdVbsOmTyRN2qKfy6zsMrR5eXY7rUBsg6GvFf5hYZJho6xufS/u84CLUBSTev+SRy7v4khjVcxVNXIWjwbt07wnw=
X-MS-Office365-Filtering-Correlation-Id: 34ea49ca-cebe-4a08-b3fe-08d59db2c4c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10308669A33BFB982DD2597BFBBF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(99286004)(6506007)(68736007)(186003)(26005)(22452003)(86362001)(575784001)(11346002)(6486002)(486006)(305945005)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(2616005)(8936002)(8676002)(6512007)(81156014)(81166006)(2906002)(36756003)(6436002)(14454004)(86612001)(10090500001)(54906003)(2501003)(5890100001)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Z3fKqfE72NnUhsBGZ8uDdAIHUMxV6hxaksNWjxlsrk4vYXM7tO2sTwRkbUnLtD7BHvfz1JcwvsVlF4R8gxZNKz2mvVp1V8G44CZH3nJsqdqtk1GEAZajhRCIjY1kZ7aqVHVXPymTE6sPs7+CPBMe+kcLT9hFR6gEgGtTQP+FO/oQ4XAxIu3kYNJ3CvIFN/ExKMIa9Ii+HYVG9dvdqyFsana2pVeB6ZfWfZlqvrN01gq47D/wzOfYUxYm0O+sLtHN7hHEFIxQwhLFHaoXsANZ6Z0TdUdX9EhPh5z1NkLKJM91q3Iw2af0a/eqIS1sxmMALqJakUOwUGHqe9Cj9P14n3bAtysqp0hOA10cYEbKZtwe3qi/sh5+ZGpQOiP517JgNDe3GJS8JBJEnxc5horZGnkH+o8pbrGhHpGi0GxbAhI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ea49ca-cebe-4a08-b3fe-08d59db2c4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:53.8459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index dfdd1908641c..b4812b1b9df4 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -922,7 +922,7 @@ void bcache_write_super(struct cache_set *);
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
index bce1238a7d10..7a2f1317f793 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -961,7 +961,8 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 	cached_dev_put(dc);
 }
=20
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime =3D cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -969,7 +970,8 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct=
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
@@ -1203,7 +1205,7 @@ static void register_bdev(struct cache_sb *sb, struct=
 page *sb_page,
=20
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	if (BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)
@@ -1723,7 +1725,7 @@ static void run_cache_set(struct cache_set *c)
 	bcache_write_super(c);
=20
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	flash_devs_run(c);
=20
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 4fbb5532f24c..1efe31615281 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -263,11 +263,13 @@ STORE(__cached_dev)
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
