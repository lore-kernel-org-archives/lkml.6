Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498281-2-10510587356828470898
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
    t=1521498280; b=QbwJ6xpc98CEZS4+J+YaHqVbkeoLaMmxIMF69A9JvG8fUVh
    SShxpGi7Kgjw6A/kvCISpSFwp1i13/y068UARaa6YRIjBkrFq+jZOh78wN1+BZ2x
    YCR4nsifar6NJUyNyiLoPDDK3bcK4WvgUY/8AYC7EzIF9hix+DNZ+mTmnDHtZ43/
    Ax85ogfObg6pXo3TrRXsDC46NsXeAXyXW52KFlT+uljX/TL0lp+4M2b8luatKmW3
    NuLiCshkiHEHXuLcI2TzaWiPoYdRaJilfh3dNh5T2gcHy1XPxRsQsvRtKs7ullXG
    XC9GQoK1DYRwf479cqi2zYcIGkRwuhKo5f1VLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498280; bh=f7B2Hk
    kpZoV8Po0iimLZbbOgdtKQVggXHs+5/HuL/qE=; b=Zvc9g/TjBw32dXJ8Pm56aF
    0NrRsFRQ/v6xdZXItKk4hs8aj+CAH3MCq5x5+FpzSKBAtXsOC2DiravqnmzGruLu
    BDWcvql9sKwfX7M8OAM/IRBY7erUtNxMPH1AFQDKef1mn2OcGR8KCMILRID9On/W
    gpSEDul5XdCUchOR2b9sVtrjj+e3ZtT3jJZ0YzXwEXmCA47Qw2Ciyiu2zvk6sP/a
    vOUJKFGbdbns4qQ5aZNk8k2ldh93z9wfNqzOmbDCu3IExkDLAGTLu4YKG/XTXi5i
    L/R0DjYNgGPg1X8vYeRPOTo39xUGX5qCVok9LGSyaTqsAeHiD43QwpuMg1jGJoZw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n4xFWyzT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeehgeenucevlhhushhtvghrufhiiigvpeeife;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n4xFWyzT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeehgeenucevlhhushhtvghrufhiiigvpeeife;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933889AbeCSWYa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:24:30 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:48439
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933868AbeCSPtH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rui Hua <huarui.dev@gmail.com>, Michael Lyle <mlyle@lyle.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 082/124] bcache: ret IOERR when read meets
 metadata error
Thread-Topic: [PATCH AUTOSEL for 4.15 082/124] bcache: ret IOERR when read
 meets metadata error
Thread-Index: AQHTv5m6dq+tSIwaV0+wUzdgcWa3/Q==
Date: Mon, 19 Mar 2018 15:48:30 +0000
Message-ID: <20180319154645.11350-82-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:reI0cLTQoHp6FT67aA/2QW+DEbItmXvK0fR0GFvinfEhcZ1LJRuQsWaf3nneVUv+Ttch0pzwv3tfInOtxb3V9U6pj5JWuQu1DSVZSVwktcPcJWMOb7BQWDcBYxLH19A6LGNViS7o7oNTs0DIdgHxf7qUvRfNJXSqWRvbVZiGPR3V4KL4Sh37yi9fMixahWb2BYf0pXezpODsf3lXF9IzXcSpnPEiEEIKmUCrta5R6wnOhHwGeQxqweqXPZRtiCbz;20:a2QpZQoGUV6aSgowWGKPn6kycfVGoLOctjkMkplLrL4R3BKrReMTEMwKi2N9QYjg5Cx7kMy2ExXSn4Z5SZ/XQx8Tj8Dvn1TOfks17Rc6cIcmm4wk3AMNtq7rB1ltZACZsu50+oAeHlZjJIAt4AjfT++ruqR6iXST61TizBE9vxA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae17dcef-f3dc-4b6f-d40c-08d58db0ef78
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936F99E0F1ED6D89207D860FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(39060400002)(59450400001)(99286004)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: w09cVm2cmdEo3fal9TCPlpCo45RHxL2KGzWbZmJcrRelPP1aQOf470k83aaZDu1HG0MU0WOsjzXV8OHP3Pfo+w1/kq6ElBgXHzn1YTU78XRuqb0ZYLpjY7Hwfc1MQbOEfgapKd7KOUrpT7TOnk4Mj9GwZGgcaFaAu6mtS10gXpXJVZqlSeSahbgJFo/57b1LnF8OPirBjplxeeqgfeuBCU+35y2kxc8BLqLwP/9Kthz/p2/h1PbZ0Dhydjvahavg7XzpLkOUlfEYKjW4UoYsCQvd8Glyp63ngNzYUOjEEuX/77NYwxp6gQP2jF5mPb45juNGLNRpuzSPYXu1ZMb0Ag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae17dcef-f3dc-4b6f-d40c-08d58db0ef78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:30.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rui Hua <huarui.dev@gmail.com>

[ Upstream commit b221fc130c49c50f4c2250d22e873420765a9fa2 ]

The read request might meet error when searching the btree, but the error
was not handled in cache_lookup(), and this kind of metadata failure will
not go into cached_dev_read_error(), finally, the upper layer will receive
bi_status=3D0.  In this patch we judge the metadata error by the return
value of bch_btree_map_keys(), there are two potential paths give rise to
the error:

1. Because the btree is not totally cached in memery, we maybe get error
   when read btree node from cache device (see bch_btree_node_get()), the
   likely errno is -EIO, -ENOMEM

2. When read miss happens, bch_btree_insert_check_key() will be called to
   insert a "replace_key" to btree(see cached_dev_cache_miss(), just for
   doing preparatory work before insert the missed data to cache device),
   a failure can also happen in this situation, the likely errno is
   -ENOMEM

bch_btree_map_keys() will return MAP_DONE in normal scenario, but we will
get either -EIO or -ENOMEM in above two cases. if this happened, we should
NOT recover data from backing device (when cache device is dirty) because
we don't know whether bkeys the read request covered are all clean.  And
after that happened, s->iop.status is still its initially value(0) before
we submit s->bio.bio, we set it to BLK_STS_IOERR, so it can go into
cached_dev_read_error(), and finally it can be passed to upper layer, or
recovered by reread from backing device.

[edit by mlyle: patch formatting, word-wrap, comment spelling,
commit log format]

Signed-off-by: Hua Rui <huarui.dev@gmail.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/request.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 643c3021624f..d1faaba6b93f 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -576,6 +576,7 @@ static void cache_lookup(struct closure *cl)
 {
 	struct search *s =3D container_of(cl, struct search, iop.cl);
 	struct bio *bio =3D &s->bio.bio;
+	struct cached_dev *dc;
 	int ret;
=20
 	bch_btree_op_init(&s->op, -1);
@@ -588,6 +589,27 @@ static void cache_lookup(struct closure *cl)
 		return;
 	}
=20
+	/*
+	 * We might meet err when searching the btree, If that happens, we will
+	 * get negative ret, in this scenario we should not recover data from
+	 * backing device (when cache device is dirty) because we don't know
+	 * whether bkeys the read request covered are all clean.
+	 *
+	 * And after that happened, s->iop.status is still its initial value
+	 * before we submit s->bio.bio
+	 */
+	if (ret < 0) {
+		BUG_ON(ret =3D=3D -EINTR);
+		if (s->d && s->d->c &&
+				!UUID_FLASH_ONLY(&s->d->c->uuids[s->d->id])) {
+			dc =3D container_of(s->d, struct cached_dev, disk);
+			if (dc && atomic_read(&dc->has_dirty))
+				s->recoverable =3D false;
+		}
+		if (!s->iop.status)
+			s->iop.status =3D BLK_STS_IOERR;
+	}
+
 	closure_return(cl);
 }
=20
--=20
2.14.1
