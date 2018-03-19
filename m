Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478714-2-3942825023548989511
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
    t=1521478713; b=Op6lyFu40mLBOos8sgtUUJFf08HHWazv9ZprsSDZc7HwAKa
    MWg4uNRO22pXm2S6tsPNMb8RLz+B++7nUZjVRV/0B7ynP00k84EwOAUF8CZTcc2R
    ZmcnWLmuipPRgzbfoRlbw9RYwUHtwvtnKiDyYrsi3fCJCHjlMWACftUJt8ydhYuY
    sWdkOIa1KXK0I7LV+dRuYE48C6OSscD8ZNTixKz2w/oQBGCH2KIQfa8mvLxyUYOz
    BI9fVrTFH6Uf2uYzHgiEjuaSXRnOlh+B5rr41s+kVFyNRZ80y+Gf1I71+RVhOMtR
    0NPB3hPaHKUIG2DldUp0sHHspFSuswgHbHtsM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478713; bh=BvBBH4
    mTSAiZ/KFa3GpVoD5cIsEwLFsbUC/2NUAERuo=; b=qvLWMznNggplY7bYWtnRra
    NAY/EC5YJC0fAbULEVkWVKM6zMnX7KDedNwSc+twYknTw2R+a6kSXql+x2QN6u+R
    HDqy3uJLtdqpISx7z5eKE5oal5bWrER8zKmwu17Pz2J+VQq2RTs9SvMfH/sZLpvX
    TFIGBmFIKRe75+fx31CmaFC79diGaf23nfLp0Fuy5MAKvhqv81k42n6jr5P7Ic2i
    Xb64BJfzihc7tkP96D+VSr9z1W5eD4oYZ0puBpShbbz4KYH66dbjjK/1929EGo1u
    JYRuK8hRXcrRfv8ynJg1Wk3WS8H/cmA+iQO6stmbsxKpk+GCSZjF5Mi3Gj+YRbUg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M8XK5aea x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M8XK5aea x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967608AbeCSQ4T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:56:19 -0400
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:24704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966758AbeCSQLb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 155/167] bcache: segregate flash only volume
 write streams
Thread-Topic: [PATCH AUTOSEL for 4.4 155/167] bcache: segregate flash only
 volume write streams
Thread-Index: AQHTv5yJy8YLnXKMDUWSDkI9zXDw8w==
Date: Mon, 19 Mar 2018 16:08:36 +0000
Message-ID: <20180319160513.16384-155-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:2z8xqRu4X2FFryPJ+F97e2Cx0F0SkDiKXObyerKU8UQFgSy5n36ra6Wm3LJZC/IesCEc4vhWJAFJovbhNkMRM4jqHTj7De2Lp+YwzJyK2nTcXT/pCGATWDklUxnxk+rYC+9FpcPvsd56Pi/tq04znjD+yb5+Yv+MTIBH2QUQXN1WFvIfJ7vhppWjKvFAQksRLd3aOpvZPly7IyoUc7ecHwimQQDWUKw6Xtdf2otw3y8saB5JYkw/RDfRHS7EKISK;20:dukW57BNbEPOXa5NFew0vBl7PNyE3ofy9UJ0cezayrkWXsDZuSn39HQ12Mu4w5kd5Cj/3QkwFmMQNgYCUkn5QvWy3Ski3TQRITfDPaZEz9DTbSfOBHqY8kjAB4x6e271uxRc+iXHte7iLNRKciStvbAn9F+JpjH+WUknxod7W7U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e29e0b7-6060-4c12-e11b-08d58db40f14
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098477FA1D8E314B782A5CE5FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0PnS0YCsKQuHTamTkq7j2f/LU7OEx0NvuFtlsmQxGZ0I23B7SC+EPk9CIZA6cJeJWLbLnH648y6uQioDfZ0u7CQaLpwCmqGGY6sm4Z9UlR6L8akRQjAjP9ycqiXGSSExUa2Y2UF4DMgk2WCWKS6SlGSMLhmnpd4fmGa3tF/qxPAR3ufmJfnc8jkWjeKM8JX4l7S86OAVOLcxKx8Yt5PtmeiaflnLvWZibKVFAPIEp1NcsTT8mMESfg6Mz0ehdHT+i/0mMPbPgBW2/+zKN+2liurbvCsgwHadqJcOKO39odl/U2eYx3uEhYBmAopjCyIztCImcIWPTPzB4+3IGAVPew==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e29e0b7-6060-4c12-e11b-08d58db40f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:36.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tang Junhui <tang.junhui@zte.com.cn>

[ Upstream commit 4eca1cb28d8b0574ca4f1f48e9331c5f852d43b9 ]

In such scenario that there are some flash only volumes
, and some cached devices, when many tasks request these devices in
writeback mode, the write IOs may fall to the same bucket as bellow:
| cached data | flash data | cached data | cached data| flash data|
then after writeback of these cached devices, the bucket would
be like bellow bucket:
| free | flash data | free | free | flash data |

So, there are many free space in this bucket, but since data of flash
only volumes still exists, so this bucket cannot be reclaimable,
which would cause waste of bucket space.

In this patch, we segregate flash only volume write streams from
cached devices, so data from flash only volumes and cached devices
can store in different buckets.

Compare to v1 patch, this patch do not add a additionally open bucket
list, and it is try best to segregate flash only volume write streams
from cached devices, sectors of flash only volumes may still be mixed
with dirty sectors of cached device, but the number is very small.

[mlyle: fixed commit log formatting, permissions, line endings]

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 4d46f2ce606f..aa84fcfd59fc 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -514,15 +514,21 @@ struct open_bucket {
=20
 /*
  * We keep multiple buckets open for writes, and try to segregate differen=
t
- * write streams for better cache utilization: first we look for a bucket =
where
- * the last write to it was sequential with the current write, and failing=
 that
- * we look for a bucket that was last used by the same task.
+ * write streams for better cache utilization: first we try to segregate f=
lash
+ * only volume write streams from cached devices, secondly we look for a b=
ucket
+ * where the last write to it was sequential with the current write, and
+ * failing that we look for a bucket that was last used by the same task.
  *
  * The ideas is if you've got multiple tasks pulling data into the cache a=
t the
  * same time, you'll get better cache utilization if you try to segregate =
their
  * data and preserve locality.
  *
- * For example, say you've starting Firefox at the same time you're copyin=
g a
+ * For example, dirty sectors of flash only volume is not reclaimable, if =
their
+ * dirty sectors mixed with dirty sectors of cached device, such buckets w=
ill
+ * be marked as dirty and won't be reclaimed, though the dirty data of cac=
hed
+ * device have been written back to backend device.
+ *
+ * And say you've starting Firefox at the same time you're copying a
  * bunch of files. Firefox will likely end up being fairly hot and stay in=
 the
  * cache awhile, but the data you copied might not be; if you wrote all th=
at
  * data to the same buckets it'd get invalidated at the same time.
@@ -539,7 +545,10 @@ static struct open_bucket *pick_data_bucket(struct cac=
he_set *c,
 	struct open_bucket *ret, *ret_task =3D NULL;
=20
 	list_for_each_entry_reverse(ret, &c->data_buckets, list)
-		if (!bkey_cmp(&ret->key, search))
+		if (UUID_FLASH_ONLY(&c->uuids[KEY_INODE(&ret->key)]) !=3D
+		    UUID_FLASH_ONLY(&c->uuids[KEY_INODE(search)]))
+			continue;
+		else if (!bkey_cmp(&ret->key, search))
 			goto found;
 		else if (ret->last_write_point =3D=3D write_point)
 			ret_task =3D ret;
--=20
2.14.1
