Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497086-2-11101316707275363288
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
    t=1521497086; b=oVHEq3gHBJp7aaDk28Nm/dHZK2M0Lf1oJ5FgdBhWEEPsCPB
    fDb8AWgEUR+LLd+a+ayEQ0PFxZjw5rYdBaovmi1Pj21o1VEbENas1HsA8HFl3Lo7
    meNg1xBCVdhAyuMTDO/VxL3RGLh0HztijrPy4Nd1bB/wThKCDBnJrkUpBvvIP/ix
    Oz0Oct3MEuYsfAp7k4fMfqaKOng+9mKrLdUIKbgkSMsgKRzGpvbuUfGEvSiPqIZ6
    R+XywWDW4ztdBk9zwTV4vNREB32QiSzFTlR9cZCAoG8p6b2DUgm68Lf2oXkCbmS+
    UwwW7UpIa8bCSGPUVgzi261UlDPqdeEhj+7M24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497086; bh=L36ACO
    QxGespyc2sldnMicz1xRW1+cQijj8zQ69IH7Q=; b=Xc7ihb0GmjoCFxkezN9QCW
    5XKoncZpkmDupeiMkUYcrtr5rroYGnWyY2pRhwE1kEL0QCxNvVwscPtVjLzNvCU/
    x/+/SkhjpZlcxWpV3N63RfCrVFMxxtXKi4KB74fvMfx2uMFVDrUtSNcoUfaDQfIb
    TuM35lvFsTvJUME79jNoeDG+kSvfX6LZD7JhL5Erv5SdHOCBgffikTz0A664smlg
    hdpbVZXSaz4B3cLxGJagg0uC6X9I5UKre4GlIo5bnqXwSW3JIcGnbIryGQgsISlg
    gKfpzUHjexYy4cQ8oy6EwtqKnKZCpAgwiH1QDCx3shAtNQxJ3MmmEVWOK4P47tvQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YWIvxIzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeelvdenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YWIvxIzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeelvdenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeCSWER (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:04:17 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933560AbeCSPzu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 43/97] blk-mq: fix race between updating
 nr_hw_queues and switching io sched
Thread-Topic: [PATCH AUTOSEL for 4.14 43/97] blk-mq: fix race between updating
 nr_hw_queues and switching io sched
Thread-Index: AQHTv5qvSjF6iD0Zv0G0yVlwTA/sAg==
Date: Mon, 19 Mar 2018 15:55:20 +0000
Message-ID: <20180319155411.12348-43-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:KEqACU5gNg+eomDqwuT1udGTREnBtxyIE66Z2462z7bGHHixxB1upNPMPG9PhjyqnHDWDXPmNh6qf/8p4NB4lgzpUB2B6hjARDUNjturSSsjRQtq/AmqnRPizUNMokw0pEHB4vCswvYvvdDElSPqL0S0F6aDwMB1w3sW4F79kV7sH/3Cu+JZW4b3uHwsYAZGZOYMrMpMgtCMMqkZwMo6XJQ4PMLyMBZzUy7ywjPBYYwZCdg0z07xX3dfdnhFaHDI;20:TeyDUvzHYBMy+F+x23G8FQJ9sXOpdQ6CeGxZBh2qYerS6ATSkHV0MDNd052u6+WAPw8aCfxO3+fOPQj2zDEUSYjx6j+bdjeKOpcGSt3HYL8MFcPoKcufSEEmedAZXG/SduMeaqqyBRaViomYqtdxBSWzsvKnPMiZJ+hNF5NsaeI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75a77093-f268-4112-c2b4-08d58db1e08d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09671FB234E4E0C9DA338754FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hSAfe8MM0WUWfBFv1G76HArLiXG1WiHmeeqqbQtxcBWsOSoxVJNz4rIMm4QUbx/o+5GcEjPgoUL5fpev+2JvfLuRaVyYXLWKNsVEJM9WA5/xByb5Ih2IUfeZdgIk/YY4sWu+kjZKXETYx6E/2dCvV3+Es3y+I9hVdMSdv8lxLet3sTS6HVTAeS/8hwFwtoIg83DbGBOcWsqqWxByjakO0xoZJwBY2k5htEOasVlA6YS3DP+sTPuaLcI0DNtgVxPvf7f5vTeetQTHirdIgMrQsVfcPHqvOBs7vmsmTJzaCBQj9GpRyTmzhov3Ja8dnoDKH8YS4WgCbaxDqXrASpTC5Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a77093-f268-4112-c2b4-08d58db1e08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:20.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit fb350e0ad99359768e1e80b4784692031ec340e4 ]

In both elevator_switch_mq() and blk_mq_update_nr_hw_queues(), sched tags
can be allocated, and q->nr_hw_queue is used, and race is inevitable, for
example: blk_mq_init_sched() may trigger use-after-free on hctx, which is
freed in blk_mq_realloc_hw_ctxs() when nr_hw_queues is decreased.

This patch fixes the race be holding q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 12bb7a49c5ba..c28d6b3088a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2314,6 +2314,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
set *set,
 	struct blk_mq_hw_ctx **hctxs =3D q->queue_hw_ctx;
=20
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i =3D 0; i < set->nr_hw_queues; i++) {
 		int node;
=20
@@ -2358,6 +2361,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
set *set,
 		}
 	}
 	q->nr_hw_queues =3D i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
=20
--=20
2.14.1
