Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476406-2-7988902807257421306
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
    t=1521476405; b=VGosubGQ5Kcxs5xywHU/v8nUTi+tkffjHgHrtxKQ4mhN8p8
    bfFkCXxspzuM4rMBqieQ5HLZbPFCiQ4HSkdDl2OjL8MIz/aPOkvj8lOdTVlBsaVC
    +HupqGqt/+4MmrGpRNRzNCZQ8c+xax8+cqeXXPDCDNah2bcyGa9crIUt0oWkjKLQ
    4kwqUGVk2V1sST2Qa4Y1/FHDGHtgSrI4E+DRm7Qvd69+0gEWrL7t9jRHui37BRCo
    uBGI6ewX8B5O8zOfZ/dIVjKs2zG6GnP2qvBr8UXvzDAAO+ijbzvx1vdP89uF7vU2
    m8vr3bmbVz+RXxATds3uIOrBFwsebMWmrwY7ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476405; bh=lycd/Z
    S689X/22l55hRnaoV6VNeF+JwixreaATpAU08=; b=KtOfJkptC4299XvOG575a4
    HL0MA/bGJ/SUQ3Ub85R5sjNrjxJLfS8KwIwbBMEPsLq4+au4gqBAMKJ3n3EW8ptW
    Cr1Cqs6uVf35vvGFnkvE1JWgKZd2qzyR8grefr486YKAUBSEHMCLumFMgV/ihkqh
    XE04mY79nK6zjrduDhiYi98VZlrPsyMo3R8DTGjZGDt2teyeqQP6xsQCppNs0jW7
    7w/CdvsPeuzryIz3jc42RM5eZnwTZJr17MN8bwNlZuNekCzV5Mg8Y6DgA9OG/VsW
    ho4vy+OUn3bSop0ziAz3teSAjO6inr92OX2bx4C2MVFuhCWlErlnQef66ZZu1e3A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVFbsjvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdeinecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVFbsjvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdeinecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966955AbeCSQUC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:20:02 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:59104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966953AbeCSQOW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 094/102] bcache: segregate flash only volume
 write streams
Thread-Topic: [PATCH AUTOSEL for 3.18 094/102] bcache: segregate flash only
 volume write streams
Thread-Index: AQHTv5049hFnfl79G0SN7X0Z+LCFFw==
Date: Mon, 19 Mar 2018 16:13:29 +0000
Message-ID: <20180319161117.17833-94-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:fop1Au5vpCxYWAD5X4kjlvs1yd7LQq4VI0efEqJZYFb5WM23QqqCM10ITxBvxxa4FSGvTm7iNVoF8UHo7i6ATAczHeeoAI7A3odYMAx/hXaJrBe8D/0Hpij/1JLWKhVF/ECsQPYbEaVXNaZsAJNqnDn/MyHp4DpipkWUi8U4si8cWdSU00w6+RiAEe2oBSusQzA93NVprh1okLCmjb0aL3TgNcOBYbwJNizmN+uSTgSwcGiDfAPexHfubCNtuD8W;20:J5KfE8d9ZEe59nTAbKAXKdELpYwQOOt8TmDwg0dAA9sKu9Pu5S6Pd3+57kls5sU181ZRLmpkHgt67LhpcMtn+eVINRg+Ow0GQxo23WUeR6xX/99XCKf4IuZhqSRIyTINTVIXDTJnzJSvE/KIFwXvyASOMw98NGMkCW+vS/YtEPY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00aacabe-e59c-4e5a-5712-08d58db477b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08694CD36AAD861D336B4AFAFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fA9pt7WBHMYyi2IPRUVTuWfWQND11B5IY0F3ipP0pk1sWbmJwfMbbIaAZ4tdpxyPLVKbKNx14z95sbPTuTO9/kkxFPVfnnPkcXkm4fvde8E41p/rYQ/JbcuC8bei5SQl8I2vfPjgADgu0mkQzNA/JsjRYJaUdolYAEja6AksrM58RG7iSMN0qduJvjqqtasF0cNbB/mkIXlpQQcFxJBc6LkS6DjONUqPhO3+VmKSqpl4/C1QZQr5P0kGgVwN+Hv419rzhqQl254Mi6TKO659fz637aDW8+mcW5FuwOHgM+fxxg7n4Ghxx1nMpph2hjeJpdE5DNlwJsmU2FD8UFnilA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aacabe-e59c-4e5a-5712-08d58db477b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:29.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
index ea47980949ef..f8c5bc719783 100644
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
