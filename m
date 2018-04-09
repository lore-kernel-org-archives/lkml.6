Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235898-2-12952981057317162736
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
    1523235897; b=RtBs0rc0+JY4t18wR+S3VMpOY9k8gCuR5D70+23ie8oGOPEWUd
    Wyor9X1wmON2SDNUSXgOMvnn3vw2YUzeSutqcjZ6GXC58thhBekAiT4Ph1tCWqtZ
    NcXGp55IY2/TDhMvT9AuM4GmB9/902ct+XnNLoYYsVqBjo845pBspW99XGo/JaQ9
    C2UnD9/WLtxUj2W2SIrps9K+ORVxk9FeTTav7SdvFTp63E+4qozDpNPlHk1AASB2
    ZyCH7EOsCQLqEvdsjOBGYPkJLKLr/ds9tWBAXFCuPhTU6kVQ3myETJNly4f0+i2j
    khQHqJG8WYfyUtduS9k4MSIFb0tjS5kJKlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235897; bh=ZUhoN+B+2q
    iCROWH/mVEGi/NXIzpi+2Ses/q2ptjw9s=; b=LMFKD5+r7rPaIVaEb72B6Yhxfg
    urA5XH5fZ5ja9BGWHcSVeL9HSIRaaVaJ1icm/ZkWeLaam+nFvEwDuKQhLMYG5ttP
    J3RhVcZKkRIHxkf5GlP9BU+Dr45PtxzLsshl1X+AcFi/IIomlzXdgZZNP5jM+y4I
    Y/X7Y0cxpQCXitW0JinfE5zvPNGF/SjRvAxqbHoulB4KAqTsbEhDoaMDVAoBZ81S
    5UP8a+kkrHQEBfXYYI1e3Ozb2Dex8NahVFhLOI+p8R4s0DGP0cnsoPsdpPVQr+9p
    5FMGSZlmS/7ecSUTlApaD2rZI64ORWVW5547xjflHpGRdzVG201uKKVhzF0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dWNCZI5H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dWNCZI5H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAyjFIKYndgKxenylY1Edn1HRVIBANzlP3XBGjLs7oAuXGfVq+dzQvfmpz1jqsSojD++h3eE2SAa6oMdwQK/m6nCU4Q2EHjp6vbDhHNBwj47nQ+V8850
    fNCZqFHK0PxhdNti83mTAti3mSqmFOPWhnNmKMdQGTjA263ysUYcB6FD6WISvEzfxuUY8y3t9bC8+fg5pda7+AhoiREY3TWOfCp2xSuyLXXYjAAU4LZfTZdg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933143AbeDIAjd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:33 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933107AbeDIAjZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 157/162] bcache: fix for data collapse after
 re-attaching an attached device
Thread-Topic: [PATCH AUTOSEL for 4.4 157/162] bcache: fix for data collapse
 after re-attaching an attached device
Thread-Index: AQHTz5ng3sImlIyOSEaVlxJD+YHr3w==
Date: Mon, 9 Apr 2018 00:29:53 +0000
Message-ID: <20180409002738.163941-157-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:FfdmwZUbhY/WruNubNfRqoX8MY1x+ZiQYm0ydTp8e//dWevEcNNbRjVt35Uy0jJR0heHKwJ4X0jI6jtj76UC2+sZS6t3eNIZQJtO90lhBoJf8MpV2H3v/OJzULZNtB59GClRc4C5I1pdkY54gjge3uxLqzlyvsiSYOVdz7gYzJ9jbVLfOcV0Lq3UChmRFWY93NnN6nk1xRoS175iEiXmpiplBdeouokEQaD21kI62SJSIW/Isq7q/77ul9H3eCDT;20:8wNIsUtuuiA/NS3lv43etVUy8ZTbsmem7B56yDmFKPoXTcaTcWKRVQBKbD6bYlUTczP+LUzTXixMXYU9bNXjagxCw5HZu9Wbs+XJsk6V7WOnSSghbDr936EhR9Ojf4lUVSGkHMzc8o/MQyTMMiAA8V8I/X6MP2PicQM8vFgMNLs=
X-MS-Office365-Filtering-Correlation-Id: 010b0e32-d19f-4bb4-5bbd-08d59db255e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125DDAFBA9613EBBE85EB7DFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(5890100001)(7736002)(105586002)(81166006)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VIp+27e2zGMEgmfEEtw+cW3X9tLActuDTGcV9VmhppJhsbC/zbUe5RWsCCKBZyN5ndgoTXC2J6Y9KSHkz8GjaE7zRQFllYu8xApmexZXkJ1LvI3IqQ9dLcH9TwVIOtUL1bV1fDSyPWHSK334Eiyx8i+LjvHDg4fQJolb/4Jf5qwLVQIDgb3VB9g3g7hsXFxTvKUg4NLMjoleb4I1aS31MbnOCfdsYx33js9QP6wGjDaBOO/3ruhCWmMX8s+IVvNxdtbsbtW+/O0bio3uB7gv1vpoQDaEHbukJGB8EvSn1VQH1FWSrxj0Q5WBdwdIXZGtJeFLsMVwEHXZJ+8QtpydrW07A+oBn+5/by4Hr5/WZKFKrVRuANSZ0cqW1ni/miq8OwbH96tKlWZZClbaE1oabyottA3yQkyyrd4cYIWyBQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010b0e32-d19f-4bb4-5bbd-08d59db255e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:53.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 02619cabda8b..7fe7df56fa33 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -904,7 +904,7 @@ void bcache_write_super(struct cache_set *);
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
index 132d6417c66e..4a3ae14d25e0 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -930,7 +930,8 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 	cached_dev_put(dc);
 }
=20
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime =3D cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -939,7 +940,8 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct=
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
@@ -1183,7 +1185,7 @@ static void register_bdev(struct cache_sb *sb, struct=
 page *sb_page,
=20
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	if (BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)
@@ -1705,7 +1707,7 @@ static void run_cache_set(struct cache_set *c)
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
