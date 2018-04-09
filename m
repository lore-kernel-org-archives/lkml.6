Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242623-2-11171432629897081406
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
    1523242622; b=WJvGXp9SUiXaKsNtCPNd8fy+VP0trb2uk8905Uqb8Upk18EzKr
    SaMURVgwHxpEuq55OBuhR958YJjbv6Gb2WI31pjXt8yvcWUZkvVho/fkrXZbE+7E
    0EGq9mlSGMu+POr/qSSbpl6fkwrxijBRcqqqNxWa+tJO0Aa+3SE014JHd/360ofa
    1KHCeHAeFKvbe2SPVztkjEdqUo6vRYN7THK+lHkcK6H6Q2Tas8I1F6mHHj17/Nbt
    gLO+66VzatoaqxdqOGzJc9W/az7k0N0QFD/cVmkKLKg8BfEOCk7jZfGR0jIonGj+
    XG0HhIMNvYd5WCLLgtL1pi+TZc55KMGYNqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242622; bh=lA31hX01/+
    k3hSjlzBAN4XDdpkZJPQbi8Vgno/hGA78=; b=DoSXh1FTJMlAuUhDUWXjiXdaok
    JFWgsszLYK2zNcBu6rh/sjppY8DDHC5N51hmtph2Vh5JQGE1R/xFWEQduBQ6SUCa
    wS8zHHHy8yggAVm3h/igbPDX44F+nOfx1X5de9z9i1BRW7RSBgbqdwXHgQWCeRJW
    MatY+n5mTuRqK2ZOELg8lP6cDl0G7lsGNzhzkAcuUtcKdcizLIE87vHlAPo0eHHJ
    whYKZgtCDLEOBYKvW38gtD6z2dWZdxcv0XVo23x6Vf3q1GPx7dGj6A0bhsPr9xIb
    sMQYEz0RZjUWtddTlGLzySj75UtW110sTO3q9Mv7gzESgSgwE44MKhROc+8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oA7IVDLd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oA7IVDLd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCojYbWQLu9a1vQ7az+TISwcmx4+o3wI5qve96dGvbqwC2JnO4/OyhhqN3GH7lXRqDXn5W5+fftVPgpuM9XbfndP0DPSQoUTSm63h8wn41UKEEWnZpGM
    BYqQxCJZmQOHIpQXrUpQ7bp5wm2+WkaCvci34tL9Q0vxkDsuOuNcqClspRDYPA40Skkid2Y7Jy8DiN5/Z89Ivum/L6gBkZSg0vpEN3c9CSXVmuMrkmPDSLVG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755532AbeDIC4g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:56:36 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:42928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755235AbeDIAZp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 138/161] bcache: fix for data collapse after
 re-attaching an attached device
Thread-Topic: [PATCH AUTOSEL for 4.14 138/161] bcache: fix for data collapse
 after re-attaching an attached device
Thread-Index: AQHTz5i+vCAwe+zmtEuKKP4sQZ3JAQ==
Date: Mon, 9 Apr 2018 00:21:46 +0000
Message-ID: <20180409001936.162706-138-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:tdc62DnRuhYhsUiFYMW0hBeom/L+HaSvajOY8bd34P8IKWXTjrQym/p6oL4ZkXsqBUm7TSMVW3RKjNHjOVBF2N7McEejh1v2AvThxDS/TRJeJ3+l7OirCdoqqxfSh0+sjwNi9ORnbkZB6loTjjGkgHXZqWXVQOUbIdESFWB9fRjd4oyBpyV4hL0nY/HM4CTzxXjfHbMCvM0NtTHMo26zS7EhbcZ95u/Adi1QEKkb8whXOm2VD6DT4KqqiYC62pSE;20:AeH4bOUn1DeWLuqzVYKdzTNXPuWZdVlmstlxuGjkcVfT3E/qT7wgHcqFY7KoNhdm3jiiLupUb1PJGA2y8UEb/gFrCUiNB1itq7CK8P4VHiUB0bJbIqu7MeRmNzWJBYIgakJ6KdJDiqIX2npNemua98axrlM6ZJZA7MEblhU9pv0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c8798be-feba-46f2-f7d0-08d59db06ded
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725BF24ED40DF3763676483FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(5890100001)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ILIDoC0Ysb9UjDJfYgJmELITl6yLkP63JxEpyHUWfyE5JAWLdv+qZFeh82tIa4Yoo/9JS7XZUOa1nEfqQp/Dn+gRbuK3iTnYVaU/3TqIihDuH+HUA4IzC+/WgdJbJvv0TtL1No3tmZn2FT1yYXDic7VjvqDbqwJ4WTk9zJRRjzZJUYltFqflBcXMM88yBYWRfUaycLPmUKykiTwmOKWQ21UL8E3tVcj0qgnJyaCc/lWhNpLgArem22fzbXUvtVitasfFGmaAP6icrwaGReMCCHdQlEcaHreyEPublirBhZidUZyi5x4aWgliS3sVAIJXVnvrGCNFf7eT5APu0I0fzXMQki5nNbxb8dDOOHsxUTm7+/ExWE+QhjrckWgNu/iCO5otYiWsC+glvoplqcETE4M4slWaX5GghkjFbaJH2io=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8798be-feba-46f2-f7d0-08d59db06ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:46.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index abd31e847f96..e4a3f692057b 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -906,7 +906,7 @@ void bcache_write_super(struct cache_set *);
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
index c8cbb6cc1405..31cf9227da72 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -933,7 +933,8 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 	cached_dev_put(dc);
 }
=20
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime =3D cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -942,7 +943,8 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct=
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
@@ -1184,7 +1186,7 @@ static void register_bdev(struct cache_sb *sb, struct=
 page *sb_page,
=20
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	if (BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)
@@ -1706,7 +1708,7 @@ static void run_cache_set(struct cache_set *c)
 	bcache_write_super(c);
=20
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
=20
 	flash_devs_run(c);
=20
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 234b2f5b286d..6dd03cf9053b 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -265,11 +265,13 @@ STORE(__cached_dev)
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
