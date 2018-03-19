Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498574-2-12265145667475543956
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
    t=1521498574; b=ZWTYdnF4PY55mamG8Hw5j3nMYQ11tp/icZpviZbA3VW59U8
    1Y5ikno97WyZJcnLCzW2ukrrZtiP0lrzMG1YeMc7DXWlSRZ2xOJSwovNsrAWyrv3
    4E7/knGrIH/J5Ouxw9PxWHcqVrbhwwbmUF+HLztreOtsLJlCV16S9apcj4cap2ty
    ghZHEQGaH9UFGnJpttXJ8oOYIn4LgQsAlq6b5MVSA3/RIQgTNnYkaHenPXX1XElD
    KV32+gZ2Rb8JQdZaol6us9eRqly1AkdXzefse9Qbn4khalN5Q8+gePwvygoy+o+i
    qJgkXP8Dth7eQXz/msLaf/rSas7uzDzewKKSj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498574; bh=Xp+kSy
    HDx5b2K1knGBpW1WEyGWNU1SAwNaP2DWQVmyw=; b=f3wUOc4LbiTte3Xwf0HIb1
    5GmrPn4npxkiXUr8OhwxuXZiiPEpYYZk5Ce7TvOMMWCjP30TdXWsjwjRIv2v7A1s
    X0WSL56kRtLynp5E48MVzaJA/I4jwVj8EZUDu21IjlZjLBwjanp/2j1vgCcjt20e
    o2yYepI1sdA/ETwrmmczE6zTnsmw5vFiWPAPyPK0+tAgRbOfmeeImWSalkYRsJer
    CcyN+9QXJz6pTdQmPN4vaE7oVSmjb/+bdSHcFMinqKjXSxzAi+s7QUhsuEIfmNNg
    0OxUBc8zdOIJQTX5pfVHIhpK0686QVSye0B4yQL21W26CEYivQ/SHv3urcwIgVig
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MjkAcogm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeelieenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MjkAcogm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeelieenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936487AbeCSW2o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:28:44 -0400
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:31072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933768AbeCSPsq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 057/124] blk-mq: fix race between updating
 nr_hw_queues and switching io sched
Thread-Topic: [PATCH AUTOSEL for 4.15 057/124] blk-mq: fix race between
 updating nr_hw_queues and switching io sched
Thread-Index: AQHTv5moz9vQWbV92UWRgZLzdJPfXQ==
Date: Mon, 19 Mar 2018 15:47:59 +0000
Message-ID: <20180319154645.11350-57-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:w/AjRAjXT+ZL/vQKgivHKAXRd5XMxP4f54Z75zV5HgCcx7QzE2ELXmbg99gscMbK6NqpGESeIsTNSo2FX6qIcdFbN5Y9agS82jkbx3zkDsPA6bln6r+7TuhtTB/Obi0Bgbap7ENcQ9h7w014iMoAwyZqgOHVOCATvcePvFSbcuLAFOcuzCeiL/4Lt8JIOgpIAindb+jXXAVWKVazC6EsnEThK3wV1rjEyWaYFlkMIFLqiEC5V1N9t+ALQ/BP8A19;20:tDogjdhl0U87k7TGm36akeeNGHX6u/V8oJXCKaUMgvlB/py+uI8H4y9/X89yKYIHWST8cQquh2MvQilT2tGyNkvnCKZKZUE2eGVhIlLBTjR9bawbRfT/4u1Bi05G9vgOqTjdr47faYiCQt/XnfVMzE/9HXT7nxayFQOYprralzw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f9fa77d-65b6-4bd0-94a5-08d58db0d4dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031C2A40C427D4A60D3E012FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: djHTSxyvo8XDb/37eyPjmCpC48gW5puzMyDUZEDWGdS7gcSk/We6mVnTOIDMlwZdBZiLbu7kljeXO82kuyn446t6Kljjx0qc1UbtvEhkV/4AUvsFcIBvopw+uYbxybXFm49+GRwWQIsRni6APhchlOACI8bi4spRtmYW64QevenNynUaFhoqfhDRJUFKYc1nGJ09yo78p8pXTrRaxTVD6l9bGM6VQxP1cg8hxXu7wVwzrOZDBjNonRiO5bV3PqCmhX6md+YBWh8Vopwk0GF5kFOwUcyRCDZYD7uRiVL8J6avgtvmKdwY2z0NBDcR1R+Xwb5JUirNB23UDm3Kk1k1QQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9fa77d-65b6-4bd0-94a5-08d58db0d4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:59.9677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 4385c5cbf57b..1372ad3a21d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2388,6 +2388,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
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
@@ -2432,6 +2435,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
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
