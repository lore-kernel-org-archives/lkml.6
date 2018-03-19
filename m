Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496688-2-13658038788028359455
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
    t=1521496687; b=AzDcf4+yGVNoIXlgX6jAMiyGmurEMrt7pJbB8Z32cFZ/EgS
    LmUBx7rrPO/vG02kFrKjdZDemaxYmhzKP0s9/eFbJqzFrMEEV7aMhQsw6h3Xj9yv
    +vR7fKiFcmLac98pszPHIP4WBcapamanMo2P+S5gj9ll2QJvMeYDkOi9/hP8m8rY
    rU1AM/hoq9D4U3UDg7fS5evjf5WWxMem5ofBg+21ISk1PRSrL+VmMx91v2Csy8ql
    beEeEy6GhDeQ9BRNKpl04BTbIbmzPDTDJ5ePjDX8+aalwcoNSSE/U7LE2JxEazz0
    0CG+d9Q44gqQ4B+9imYCvGvMi07wQUqbEbbZlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496687; bh=7p7vbi
    j+45mYc45UrfQenyTQZII8JzvSeXWksH080mA=; b=jUWrq+8dD3xh2LXnlD3Q1O
    F5k0n1KSrNdXjwRcVPcByDznsFkC4wvcacZqtyaVg2JnaCukM9T8EFgkXsJgQfKi
    dKur+HfDY/kzBKcLMr165nreiktN6E3RpR0H2CXau4VAQoHzWF9JlLXDJeSUWgz9
    eR51lIz2HO0UjYSN0igEvDYWTFOa0PEl7xL+lYlk7lSb7n+rOLDx4omaCsUih16/
    nWd9jLhAOLF4FMCuvH6VjqtgBtd1R1Kurq6V0IZ7+lW22JucHg/3kkfzvT7tsO8y
    t1C+nL/H+ygRRWcyMG7jOYVZsNk9sWvnlMe4norHFfUBpK8syJgE37b2N4Qn6SqA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=klU70Mye x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeegtdenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=klU70Mye x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeegtdenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964844AbeCSV6D (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:58:03 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934556AbeCSP4g (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rui Hua <huarui.dev@gmail.com>, Michael Lyle <mlyle@lyle.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 65/97] bcache: ret IOERR when read meets
 metadata error
Thread-Topic: [PATCH AUTOSEL for 4.14 65/97] bcache: ret IOERR when read meets
 metadata error
Thread-Index: AQHTv5rDTSPBcIDUEE2RIzG2oHHRbg==
Date: Mon, 19 Mar 2018 15:55:55 +0000
Message-ID: <20180319155411.12348-65-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:+2GMwjaCBTb5eXNcHw4eoZe4CGRjUr3bvFyVidyLQddhTUp4lQrVR4tiVttbt/pbqmq9A2l0I1PYYo7Tbw9GB56nhtHPXwZ0zjuOZNOChZCmNiiOZCPIElHlWlPtxbFMOpFGJyLH8j28asf1JUP8HRxXbSKtbxswlU4Jj/Fkl2HLoAsunQS0uLQaeZsYX8/+SJNhuDjryJ3KDmzSqcTeV1+gF5cEh/ZGyJdSmgTZli2SWebSid4HV96mgwWKN0lP;20:eUSxJ82aJRHs1ERn9dSrjvXNTqA1G8Eme9yohD/DXOQu5n24SOCw5po4xiSyxj21a4jDteUEG5xImVQmDIl90ksJ+sTBjt++UuBJ5E39ZrzDPo+md/iinuEd8LY0Q3yuLVrqpwYiwDgeGUYYujrlHWiX15OYlSL1/Xb5ckl8U0w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc8ce33b-96be-4839-628b-08d58db1fc32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10315233E03F9EC608C28D83FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: czMs0Qz98NVLCntNj6zpoi5h/CT3bKEm1uU8Olyjg5/l6aTRONnCfUOcbQj8mbV07Y3fwb0oDkFz2X6GBkdSOEE46OXpq654wgzxHCeh40z7uDfUDOaWTh60lZ0ucRrqqYYYp9i4PlcMqSuxlefarY0Vk7D6tOtL66pAJFRe2J0wc2TiDIVyIdCvFzmG0y922aKumDwpajnGieaSypyYwG81Fewx2XQDH9XD88UzEKQmFtLVAlthVOSZX3txMwhNoG4OJTugUV7XDB07WNcgOe6JCtE0x1f6vBX56BluHAZPLnhAHqnJh7tJrCFW2M19XbFuqMjq7kvot+FC30hrvQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8ce33b-96be-4839-628b-08d58db1fc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:55.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index e9fbf2bcd122..f34ad8720756 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -568,6 +568,7 @@ static void cache_lookup(struct closure *cl)
 {
 	struct search *s =3D container_of(cl, struct search, iop.cl);
 	struct bio *bio =3D &s->bio.bio;
+	struct cached_dev *dc;
 	int ret;
=20
 	bch_btree_op_init(&s->op, -1);
@@ -580,6 +581,27 @@ static void cache_lookup(struct closure *cl)
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
