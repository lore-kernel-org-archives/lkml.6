Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238297-2-15864043248724573976
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
    1523238296; b=Vztc3ktfg56RxrOC81zGP6/DvqhctpExRz14NksDr8w/ksEy30
    4qn/+s3DnT8sc52IP0eea4rHIkXRClpyAU6rvmXpnWoi9iTN6DHGHDAQg/BERQvK
    lhDfELn6QWfl2G4KJJPL0FVc3jmqgIzCLcSHHybzFAZGM8oCISNNdsN1cfrnKO/V
    tRg3pQktqxDfEc78gJZOGLTgmnNXy2B08DUxL8VbnYHoF6z/jQ5+Ym5sJd+qXjMm
    0STRg4jFEFLdJzLO/C4izwVm7GDJsnWDReUJ7N9vab5WMVjVcM/Ub2suRivdQwzC
    j4GtKhAi0dq1ovUfQUz3RigyuT1nTz+PUx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238296; bh=LUiADdZjpt
    tcxBq/CKb7N2osAK7nkiuSmzEfjfffaNo=; b=uviN7fWcswPI1r5UN+WNWiKpib
    6dhbC6Gtxy8+T1bU90xpxnU3ulDqt/e+EDKXuBa334hL8KX5vxfr3rudwBtngXNR
    GmEWDH0BDucUaq93ODgDRTWQEZtdwtxQTeRssrK6Sf/KeAgygeu6XPH0IebHji/4
    qAaiKHbIvEJSocx1ZE7B6s2WSpapsXMjrZyNlWsjOhJcGzfXEP264bkEVLIlTzlo
    CuV4uN2odIhk2f6eP6VS626EFuSfjzsox6gyUSiKoBBYq6tw/H1VtUEuEKtDOI89
    0SuCSs1UGzh/EA/LOzuKa3npGHsihDGJDgLe/xqr3aBf9cyrtmHZxMUsrUpA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jDM6khIX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jDM6khIX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMjSum2jMjixOC1nvRT+ydXbYvrPEWOmdjDoMeYABRnmJEUJBJoqgasjz844ZMqSoKK6xIGpoM/UKRvSZIYtiAUEM6bbdENB+wdmRbPndm5ALEOP9WqA
    SNaPSSiAYy8WC0ymasxyOtvZMQxcxV76qqNAlXuFHWc4dhGwvEn2docWJU/JTA6fV4TEdiVPWKhBTF63Bk0cCyP4XgB46onHc2dKVFndLeMqikbhWnrxCQUM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeDIBn3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:29 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932510AbeDIAeq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 283/293] bcache: fix for data collapse after
 re-attaching an attached device
Thread-Topic: [PATCH AUTOSEL for 4.9 283/293] bcache: fix for data collapse
 after re-attaching an attached device
Thread-Index: AQHTz5lrKOVgv9J8IE6EaNrdyzEdGw==
Date: Mon, 9 Apr 2018 00:26:37 +0000
Message-ID: <20180409002239.163177-283-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:AZ/wl86DGn5+BUbhZCJWgGC5LyEblf1xySTZn/93KubQ76VkqOT45tP0AcrMD+LvzkPe9VBr2fX4kTGJ4g192m5lsoOtpDlnqx7ZZqCtDSUfVbwjAr+/fe7unrq0iQ90oT+WSqTnoiGACjoWWbXI9wehJK2c2x8RYB983SHc2j8ftU9akQJMRZlTeSIwOLHV0ir5ztS/vRDyDeyWUqS+xIG5QY8XrccnEUm0g7ca1S45GnmzLiKaw417LtgwL2BI;20:3XyVn9wDmIueRTSPFEFzErTCnjvkFvDqU/m61Y3NA48cqXaJ9tVDNQN5h135qb/g/KhymSPsRQa0DwBIDuIQ95O402HiA1kcRrdufxDTDRfdj2ZIH1pR5zZbpipO40AaaY1j0mjIXKiTpMdo1hYZpF7ZN32ID6P7xup/XOzOc5I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcaa6005-e470-4d70-5c4e-08d59db1afe6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806C7149CC033AFC7C00EE4FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(5890100001)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ndL9fnou5xi7VQV640f+/MtNVD5nKdqeR8Y85241vYUQGujtqiMbeHg8tmn63B695N5Fxx+wC71Cs+G7+JzTcyiU0+2NQ9c8L9svLHZdYB1CaOlkkmK6IDcLoN1mkDptXq98eiHjIqeZFNjzEC/5BFPEYYdllSN+SZQFYI8Op8PFituXEGMbzDYh+LcSPZ/+7AvEBfgAQ0OscfMPKNwiUX1iYZ07tsE0o7sOh2L98viargHbQLwCO7ifDwBu8HXrSL3L/gIFEKuaZt/IZ0HSP25QZR854Zof+to6EdYErRxTLBVNt+Ve5RzbpgXYwwc3NIDtZDcooc+elUyIWU9MQfmZOmSaDJozCgY3iephnQYSvqHmnCBGPnR44L36M7clCwooJP/WclvY0LfkBLXFcOhPNbiomK4h8eZnE7LFIl8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaa6005-e470-4d70-5c4e-08d59db1afe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:37.5509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 1a006f989ac2..757b13deeb1c 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -932,7 +932,8 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 	cached_dev_put(dc);
 }
=20
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime =3D cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -941,7 +942,8 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct=
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
@@ -1185,7 +1187,7 @@ static void register_bdev(struct cache_sb *sb, struct=
 page *sb_page,
=20
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	if (BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)
@@ -1708,7 +1710,7 @@ static void run_cache_set(struct cache_set *c)
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
