Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481271-2-11289742663023996159
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
    t=1521481270; b=OBV23T0pBY8p1FPRyHzg47sqj8srqG8PA35GJPq5/uouBFG
    wLLQqT3c7eUz8lNP3Ii3TuoQEQsPnrd+Aq5Zzc1JjDHDpzjvzpBxS9rqeaCcczXX
    4P2puFDqDzC/Ort6LJNHWi6Yu21WZLQjJkNy1prRarGjCknxoXxKe2SmRdRZAMv3
    2MGQUSiH5wsKB9cThXEDoOcLrCJyI1NUbzatqLVhJ/kxLMYtwv86vI8CAwq6/VM9
    XdBBb3/K1PcNolJU3/Szy/XcGkJPLcIEeaAoOvkDhlEDfh5TXls9rX+PjxM3MaTY
    WxZ/Qnd/xHPnaS0+cuOL+TaQ2IEpcPUiTqLb2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481270; bh=qaYw43
    D4NZ8o64Fkxkezm57Lcskl6OD8badBxgtuMwE=; b=stt71iCZZqX/ENbKYkwiAb
    bz1WC3g03l7Lcvik4IGsgQHYVVfYD27JuclUIsValCazkBW1tWUYJCPejq6dJs12
    GayUSReCtvelwDqevvC+7vo2UyiRZZCVvMBze2J5PO6WtZg7SnGHuZnTsJzhiEam
    tpvJJMEL3D8TX6mXNna++qKlYyYtejdoO5xuuPEGMzQPDvX3pYEme9R+qUTOq7E9
    8rNYCw3h3Goc0DaBoXaysfnw/4vGX/nBRWvj43kmVY/Yg4CO1fcUj6XRUfBgIxUJ
    EedQeu0Nx8fgo3TB0z9RKy4u0a3rzZgFmlBTnmhVQNnjlhqcStDzxItMg550XQTQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVokIbTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledtgeenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVokIbTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledtgeenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965883AbeCSRkz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:40:55 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965882AbeCSQGC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 264/281] bcache: segregate flash only volume
 write streams
Thread-Topic: [PATCH AUTOSEL for 4.9 264/281] bcache: segregate flash only
 volume write streams
Thread-Index: AQHTv5vE6WhT4Z4gwUWDJSvh7V00Ow==
Date: Mon, 19 Mar 2018 16:03:07 +0000
Message-ID: <20180319155742.13731-264-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:4A9zQyYdCiCzJ5DczCqq0ZWkaw8afJ0O6QCm7lKYD3w7JKucp2Txgf/Rc4bl7Wc9PBVRibkjOvVoMltceQ3KPOgTkJ+0HnnXOZEWBE7T60/sZk77/+uvvSHCCoF7Q0qgz9wq0K8U8nRYfcdZ3p2zuQRQCulByrnc4VNgq5eTt6i0xn0Kby8Y8D2b+ZbDT8SpbsmsWPRq7yJ33pd49hKMommJtTjsGR5DV4nruAagubPStWrbABa0nh7nRLddeaUN;20:NdVrg+hlzsQ8mRJt+7/2+4e/WM40VRuk4XyoBU4+gAoWZeYMkgBt6P5qM2j3sRYwaEYDtNCtVGs2mrbEBuU4NNN3M5TmX7YOEn8Ll6b4NKJfYKDwYW7ua9MWIjzpW4rgz6/uB4pTDXDr7gp+abbcRTZXa5QsOEbQksqtfep9jwg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5f1be0c-6d04-462e-4d40-08d58db342b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101593F87EB6644E356E12BCFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y2bBcnrWfiAiR2JDoOnqcZMsVB9LJDQ8EjeznC19yHv0wM3FxbBVh4gG+YgU+6S4+MHZ5p1vE1xvqgVLE1WLvPtt6Z/8ZeZps+jnlzKY6KbkmfIsv4jSYscZ3N5JhKyOyMvmi9iw5RVjdoBgF6FVeDX9NGEXWc2lERtKpiuxBib3vtxIqy2mbxq6CeawQAg72eqtAz+NJ1WEf2GCf+eNm4aKzZ0tjYLQyTOhZtC5RKBlLq/N6V6+A1gMStKR46aBPILuLA4dkyLNfCLjBa2vZ2C51qbaSHrT/51hjTZzHkmT6rnKjFaBnqckVEU+EDx0pPARz2FBDmXCKmsnUPe/pA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f1be0c-6d04-462e-4d40-08d58db342b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:07.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 537903bf9add..d23337e8c4ee 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -512,15 +512,21 @@ struct open_bucket {
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
@@ -537,7 +543,10 @@ static struct open_bucket *pick_data_bucket(struct cac=
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
