Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493815-2-12328170948052388956
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
    t=1521493814; b=bmoWlvGAQ8CUP2wA7oPUpmHe/p56a81ekOEGQSbaXd6GiH8
    IUFPJZYMQ4aFzBGlkOowJk/8BOdU7EW9mfyFTfP6iFoYgk0i3P6BodDbuoF/zCUf
    IUdC2d91qAH/pMy/+sCqtHaQroLyzdtWsUpykfviFu8AWtagPTYnIgifox/8TDWG
    JVYtttL/UngcS3O5PRBdmOsUoFMxIUL/VNfnBlpYmajJrxBgq1B/Qbxy2sJ7wDCs
    arLcJiurbMxZ5Q1EXQpi09nMaHCLbrt/qH/p1vUOErjaL4PZOmPuUdH69NaKpuib
    XoIlWuaF/smQ2pbfPzAr60Ze4QF58sflGMUYjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493814; bh=3GdsKI
    psVDbPCGgrIDcX/6kpi+LUe9eatq26ZCGQcoM=; b=O7OLgQCibiPtkeRj5a8sh5
    N36etj12ogFC93mI9QBZ4bBhvaUN0YTRCMBjkJKHtZEhxCUmsOS08a9p8acrzBty
    aK7sNfBB4+4H/S47lBz1xYsRgGIiT5sqNhWW2RyoTLTzoCcA5C2VgX9t/90GVEFe
    EAgG9bT9HBz0vOr1aom7Z/jfLDDFXvTB0R8w46eow811AXNaTpvvPu3ydVp8Fsx/
    jSb7j14AB8sYdjYx3DWWch3FZZC9XOK1AHQ06qQUHVxLZ1R7ldzJnJsQja+8RYpg
    zGQLH6gIc8CqEafs3RGTkWJlEIoqtuPH0bhx+cNtk4zxydrbbxXzwXTgMPKpdEIw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UeRWO6v2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UeRWO6v2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeCSVJm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:09:42 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:22550
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934985AbeCSQCA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 145/281] blk-mq: fix race between updating
 nr_hw_queues and switching io sched
Thread-Topic: [PATCH AUTOSEL for 4.9 145/281] blk-mq: fix race between
 updating nr_hw_queues and switching io sched
Thread-Index: AQHTv5twU85cdvj58k2qvdW1dtgMmA==
Date: Mon, 19 Mar 2018 16:00:45 +0000
Message-ID: <20180319155742.13731-145-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:JEOX3aheKRAgpjvyILJ3GEzC3r2DsG6HEzoV9rPhfc3sBnS40pl3Nc3WwH1LNvPRl+K1WVDVIamUIvQaqn8ZKBkWfOtqycyEJu/hy9KoBo/r4SB2hIM3fQBUZET6yU71db3X44qXv/GLfoZVejqufJ4cHItlSRMOUUzOAytJgEI1HQUdaiZeWid0RZN7izWAQO25Xzg23TbMNIaYNRFC2ph4DEkd21+M7duDtucHrictwijA9yYXkVFiJbU7xK4e;20:n66OFrwFpLJta7mOfBgE5KvjhYR8CVgGbU4AFdYSH9SdYbHqXBc4s0gomg+YhY8uKYkKZweio0YwJnEN7Z/ma2rg9nk7UzTBLtgYtPT3QRlhHbM5hn9MiFQg0EcVSdfrNZBLBsORNkCzK+NX8om0/7Iz75Tl0xFXVTTXSEfIpjw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 367554f7-d4cb-46c8-69dc-08d58db2bdf2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933CF2376C65CA3632D46C0FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1ZIQ2dyR0QpAa3Q56Azm1m38+6/eCuPaDX4Ih2KFHImNvF84zSrtzidpds3rKJiLOY7eES4X2fLqNgbGpJlaNb+3tICMg2Nq0vkgpP/61OLuBipt+K+UHpYQHcl9RaepOeqt2vajARQln5JUQfmkd0DbQLHLUANBkB75mqSChEnaux2merrlzhPz53y/028ff7cbF+nnHwaz1lRpWXevoRZPnxGPltCKij2v+nE72KBCwqHJ1fegIbHYDkPXcE1ClTDvj5tWjXUaF1FI79LSON5S7BtaE9wJ8Iq9c+USJnJ6UxupTPhB3KJXTiJKxirwbIifOurPUaCmGW9HYacNDQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367554f7-d4cb-46c8-69dc-08d58db2bdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:45.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index a1bef12dd4c4..ac09f61af52c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1907,6 +1907,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
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
@@ -1956,6 +1959,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
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
