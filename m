Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475015-2-1916895868791696964
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
    t=1521475015; b=DBp/AREHD5dk3bUMkNomBl7LbLPx3BH96JdKc6G/Ik1nXfm
    KBIElWyllYokKOaTBVVKLmfyxxhubgKJwZKf8mdiFaZ/gIbbbQkTY2i0wdh7anPe
    dLaoYD0iy6qremprNAR1Y2+p29HdzgFJU6N5hDh5DqVtZG5OpTUgUpookl2uHz7s
    mlMsOifOjmbGBTT0cQBuqmkHmDQn0/39+ZNFCl8ZEp2FXWT+L70ldC0QdaBKfqG/
    gCGIDGhOI8wfYSNxg1/GMGbb8a+9lfHy0JoCVMWwhB7B842ruVyqK6luzbKRM+dV
    uZIHcWpi6eMVYcm2Xhzb+2nwjlg8jdvJqmKk0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475015; bh=TffSY5
    qD3pdx1b5TtJQ83fc2z2hySovqwkS+cUWEsCM=; b=FPpuDRSH4kd4+UBJqvn52F
    bhsWx78knZ96V7BY85LArA+QcAGe/TkVehF5v1KeBCY8KdS2HtpHLQRDYCHAJ+VA
    0uREoUS+4xKfD0Tc6G/D0H3+6Ysy169StLQRlHSGLwlj/JAQda7kZaoDiIxJFsKI
    WN5lnuhLq5NThVojQGvp+CVhVjiGuF0/UBRK4RP5UnA1lYm5cbrTInCbRp2OYB+d
    r0Fp1HVwJhb4WQuPdJ4wHLPvARtHE/ItwWJnJfLAmezIFCDvucZTRpDYEC6bCfSR
    MAWYenipwidC556u9soalJLFilA2MYRhBVoS2eBPSol27fWIJNz+f0wIIN2bjXLQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iF1fIarY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeludefnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iF1fIarY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeludefnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934604AbeCSP4p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:45 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934565AbeCSP4i (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 67/97] bcache: segregate flash only volume
 write streams
Thread-Topic: [PATCH AUTOSEL for 4.14 67/97] bcache: segregate flash only
 volume write streams
Thread-Index: AQHTv5rFsGbJMBCS1k2hM1vea05/pw==
Date: Mon, 19 Mar 2018 15:55:58 +0000
Message-ID: <20180319155411.12348-67-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:eB9HlGkocyBgJx1d8pnKH0O2iSKuXR9ghFDqWVxoXTUe9xCzpC5zxAQpg/eZXcpN9PQe8+JY5JbskbQ58kmmYftVXNkAvcjc3RbdiPW30+Jph2b5fDqnHU3YfGG7sEnPazv1jADpF3a5Co50U1ASBKbkKo2oWY/BltAfqOOccZEZ/f4elUKrDiY0WF78TkHWs5rdhvyzgnQK2AUN5tdNACplx0hYhPakhzC79R0VLoK2Jw7qa52hCE3/uzozY+mD;20:PX2LhwSsaSR0o9JSI+1wFaec2NlYvnqLylEzZEdFORPM21xMpIF2xtpFOTQuNSUSFvgzYsSSfTjwj1ZFhpdcdXiD79kWusIh1fMselaOs+KwNPs02etqGVK1Zq6u5dUbTMpZue1dSHmIk19xYeBkqNyZ5CS4YK7LkyubApMNNUc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66c585c3-4f46-4f5b-54d3-08d58db1fcd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031994FAD28D6E802613833FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MwVZTRq/6YKtgkJMKFXMeAAxsbJ/2JI/mTiMrmGjDZDhJVo45GS2lr35D/nXExgA1YsI6lpAImEjYqHX5//WPtJcvqK9QWkhInVIQTdZNbr6vSGWxV5McYB1K/qWs+Xkdgm3tXBX2t4MOWAED/ShlN5OXm/My7O/TfwfZ9I52BWnK9vt+ODkyK6quSN3N3q1MGB0/RPJHEbSMaH2x6s3Vsud6JjOXl9GDEe3+wRwqybOc+pJ58QuAVTiBndHvpP2q0hEc6T9JJm3jBQ34djWk3mGc7Gj1GhR3GY/3vE86/n3Ab82iS/h9WTrZVHzWa66Nygrv0MhQgOUqqJGCnrFzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c585c3-4f46-4f5b-54d3-08d58db1fcd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:58.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 934b1fce4ce1..f0dc8e2aee65 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -515,15 +515,21 @@ struct open_bucket {
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
@@ -540,7 +546,10 @@ static struct open_bucket *pick_data_bucket(struct cac=
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
