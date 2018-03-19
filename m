Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498093-2-3313690672481187560
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
    t=1521498092; b=oc+WYn1QmAIfVqOTApjnseyAlemeU/WVzmkaD4SAi0FfSUm
    q8gwHJQvYoaboPzM8OVpKK3PAMWL0JjkuWSnmjhhy5f7CPtuG6IsX1QAf+ivbliO
    AruFlfW9zmXzqo5bX8lMeodPnoeH7QtY/mRuuv4KRtvaONNuzE1HnIjGj78YtY2y
    ER+kaG3Jo4Yux3P/d2RVYn4mZEdgyTg/46Vh7z9s1Eit6skChtl1b9I3Z21TYJpT
    pdp1Pk6Ph+gijkQoPHX2eJgoJ/qZ/P39fsv0yiOiIZLx2HtVNJmditudBLL70HUL
    ClEKuBo4KqV8tvuSKvsN4+Ta1BPldIdcYhva8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498092; bh=TEKTCp
    n3E7OBR1J6mwhPeHVsv/G1l5wDAJdeaxQXaA8=; b=Lp8CmSBmO5T2avq8+FB19u
    Efe1+Eg6wsFPV9IXfbuGX9evs7kLFOr2bp61sFFCeQA9niBIoGPK9QuoiGhZVjxK
    G8BwrNdUeDby2D5ahqSq5sf2c3ih0K+ld0bjyW6B8S7a9LjIj9+XUjcBzkfVPHk0
    N4ABHiwQmzY77CIiCy/2RIBHtU1Hf5eXOcFlIVtF0arj14k3jW7841vr0P/gH1GQ
    mx7HIqfyEeVrWkSb9rbn4J8ojgJ+Ne/RXH9nNWP14+Mn5O1Zw6ZJ+xfzYdgeQ/2z
    2iP0y343hsN1SPVtTHUMd57Ku78XkS0SfgiIcCBI0Ay5AKb4x/s8cuoo78ds8gPQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rau4B3gD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledvleenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rau4B3gD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledvleenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032501AbeCSWVD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:21:03 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:48439
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933930AbeCSPtR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 084/124] bcache: segregate flash only volume
 write streams
Thread-Topic: [PATCH AUTOSEL for 4.15 084/124] bcache: segregate flash only
 volume write streams
Thread-Index: AQHTv5m7zix04b3usU+3E80iFYT6FQ==
Date: Mon, 19 Mar 2018 15:48:32 +0000
Message-ID: <20180319154645.11350-84-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:6b0ImkSOsoLlkBPDB5kOAEdwHze42Y7XouxbWGnltu6wg81DEgzoEZieVYWHi9HJTjgOnPsRNgKO0/tH55I+uJTvkdGA2gDTgefuRhxrlXndsYh4ekUNChoM3EJK1Fzqqn1LshvBaARq4b/EllyTRpzpQh27oQDuFkclof2QFgyiX+cZdFK+fcPmHriiu9jw0Q3huHxz837xbkxY1mVOvg9HdvlN6OMChwNhNq0FsrUGLiDE+q66SUVQ2iLNBNEh;20:xHQnDL8/2wY3HPJ+L9xrr7IiC381qcxGaMjhrNhwyrVUf4jANlKRKuo/6XvLCjWCvXy2oAXEZxOL/cpS+KIlAF9n5OtfbCDPPcWOqe6diLvBIJ/BeDWaYhetY4IdgLlJB7jIu49VqQA0BlqtpcnWdriz7PYIoLq1WOAga4iGuxY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d43d762e-42cd-41d1-b934-08d58db0f01f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB09363C065045EE5E09BF7BCAFBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 86UFOqWYnfCeeUb6Fvge/mXpRsYGtyiw0lIGjzVp5pO/rrWkKgQJZDRVDVzYmXFyW/k4Y6r7amfu4IW6eGbtBfGZzfItYtFgoWL/I3pGjKYabdXa/1OEAKsGueMfnTMDJz7Ev6Krrrb8srr9UthvgOu7r0Yp+9bjUedPWJmmvTQWRE1TVIrNozaBiDpFTNILqZwz8f8PmcVkjnLiRlZIdpFrK9b4pl7U6iR/K5oqYFrk/j7GUr61LH/gTEzjgYtRXA8wVMSXXH+4gxMu1t6QefB09TckkLvG737UEH0Kjp0bWmRaB93LnoVpOcZY0lfmIwZNpRASzaeUIlrDNitf8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43d762e-42cd-41d1-b934-08d58db0f01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:32.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index a0cc1bc6d884..6cc6c0f9c3a9 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -525,15 +525,21 @@ struct open_bucket {
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
@@ -550,7 +556,10 @@ static struct open_bucket *pick_data_bucket(struct cac=
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
