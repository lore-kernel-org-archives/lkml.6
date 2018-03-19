Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480762-2-1771325049427260795
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
    t=1521480762; b=kyop/Hv6Mt/MqsUuF87TC1y1iz17meFh2cU+YGSL4VpQOUD
    gtaU2J65rOa0j4tSK7/u8QeCXFL0daEbrBVbRZ64xy8E2B/nQWVo2ATpWHn2JMVk
    QohxRQi0LqtXmJU7SLhpokVduW3qhRGlgv+mdE+faSnjSApFEYKNH0Y4kPmx/XfT
    bifs3Ln0KBOB7+UvF+7nQjYT1Y13CzfnGaiOu5ElnNA6bTFjdTy3RgyRTdSmMK2Y
    CaIMzEAGFj49gB5cB881Yd2UAZgn/AvSHmI7s85vBQHt7QOS1QxqTP+oaTy2ue8q
    qM1sVjzK8jkWhv5VtRfNBVG3fHWN8yOnR+BRHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480762; bh=VdnwPE
    zwdWCipnycUdHassqiRxaeMoEMguMbIOnfQrU=; b=kbbDeuq/w827rrG+P188hd
    sZLWaQAoiOWjSRtCT/2IV5Zb1lOZEs4FEbbZOKtjYlPE36xcsM9ClBtn/e1uyS73
    /GtVIzVwdoNq8G2JU/yPKzx+0vZWdm76wHtPf9wEyAMiWSTXrZke1DhraER79kcT
    +UE34az7ilzAo+wvcP/6l/ZHegKhGPeOheUc2v615dO7HIh4kQL+nZYAmqykCbz7
    0dhXaJtCmgN8wG3WsakILzlAFZZs0NMYdXbVa1q5eRmujeTKyGTWKdZYrWIOiFY8
    yj0zyDMMlK9l3r1/kRqwCnztSZsXl9jkUhIoFvjTXPIDXO/cUmY6puy45VsEMulw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxLBh3QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxLBh3QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966046AbeCSRci (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:32:38 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966027AbeCSQG5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wen Xiong <wenxiong@linux.vnet.ibm.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 021/167] blk-mq: NVMe 512B/4K+T10 DIF/DIX
 format returns I/O error on dd with split op
Thread-Topic: [PATCH AUTOSEL for 4.4 021/167] blk-mq: NVMe 512B/4K+T10 DIF/DIX
 format returns I/O error on dd with split op
Thread-Index: AQHTv5wkSyckRL/L4kuegW8JX+ZQlg==
Date: Mon, 19 Mar 2018 16:05:47 +0000
Message-ID: <20180319160513.16384-21-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:Hf1l+/oNSfB3OpXNy0HaEz8mXHMQK5oOqza6vOkHYmUmJ8GE8lAzIe8FNduImWJR3tIPeH0lW3xgTCrA2cBVJFJOenXs0j/k1YLQWhq2m6Lv8rn/3HxsyxnjbIizrHxJ9Cg8DFMmrpaih2JOLDjVVIC7b3h9wtEMBgt1975IgcTN59Ryaxm5OYb7kv9xlNx1NsKDNdYfO3YC7cBJQVxja+edstldS5LG1KtBpl5USKfA54Bbg9AMW5OUbAX+b4gW;20:XPs0kRyjSwDr1Ym3mWIqXB+47raIzOEsbq0MwiE9igf8JYZEEDXTvdv2emWYR/47yM+LzrO8atOv+IYmr/vPdVDgan70VYHS1tP+Hdn3AgCbPgGRSjaHpJaGg+Ih/FM67FwUohUlq+avNZA/rfQ49q79uda2QJ53rujHQfwDVQc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 937fa20d-85a7-403b-ee91-08d58db36cc2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093DE8425036C5DD7106875FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tZ5J7ZzYzDmAupdk+3swEpKOo7+mr7dDIXmu5qjI4kgEW0xyl2r2eQeEwoZJ5XESFuXD+T9Y/kvHdxZjWLFJ+NnklVEw7yWawN1QwNCJHjVJdnyXvn09XsE0Li1Qzcc/3ToHWoo8+r9m0bg74vamhrniGKp28dckcP2/dMhK/+dFwB8h9pKzjcL5cZD9y0KBFpQ6BjI4A9uoCMm8u0M24YScatjW6A7etz8ifqRP8vSOUw9c+IT7absv62wzEs3F9rJeW5tiZtemvKujsl+jpPLykOKAJltKvrL6n92tiwnDlmZZHRnb4i+odJswK2uGJMAwRmEmUWhjDuSG/pAyhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937fa20d-85a7-403b-ee91-08d58db36cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:47.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

[ Upstream commit f36ea50ca0043e7b1204feaf1d2ba6bd68c08d36 ]

When formatting NVMe to 512B/4K + T10 DIf/DIX, dd with split op returns
"Input/output error". Looks block layer split the bio after calling
bio_integrity_prep(bio). This patch fixes the issue.

Below is how we debug this issue:
(1)format nvme to 4K block # size with type 2 DIF
(2)dd with block size bigger than 1024k.
oflag=3Ddirect
dd: error writing '/dev/nvme0n1': Input/output error

We added some debug code in nvme device driver. It showed us the first
op and the second op have the same bi and pi address. This is not
correct.

1st op: nvme0n1 Op:Wr slba 0x505 length 0x100, PI ctrl=3D0x1400,
	dsmgmt=3D0x0, AT=3D0x0 & RT=3D0x505
	Guard 0x00b1, AT 0x0000, RT physical 0x00000505 RT virtual 0x00002828

2nd op: nvme0n1 Op:Wr slba 0x605 length 0x1, PI ctrl=3D0x1400, dsmgmt=3D0x0=
,
	AT=3D0x0 & RT=3D0x605  =3D=3D> This op fails and subsequent 5 retires..
	Guard 0x00b1, AT 0x0000, RT physical 0x00000605 RT virtual 0x00002828

With the fix, It showed us both of the first op and the second op have
correct bi and pi address.

1st op: nvme2n1 Op:Wr slba 0x505 length 0x100, PI ctrl=3D0x1400,
	dsmgmt=3D0x0, AT=3D0x0 & RT=3D0x505
	Guard 0x5ccb, AT 0x0000, RT physical 0x00000505 RT virtual
	0x00002828
2nd op: nvme2n1 Op:Wr slba 0x605 length 0x1, PI ctrl=3D0x1400, dsmgmt=3D0x0=
,
	AT=3D0x0 & RT=3D0x605
	Guard 0xab4c, AT 0x0000, RT physical 0x00000605 RT virtual
	0x00003028

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d1af3e44efb..96bd8d9a9ad7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1252,13 +1252,13 @@ static blk_qc_t blk_mq_make_request(struct request_=
queue *q, struct bio *bio)
=20
 	blk_queue_bounce(q, &bio);
=20
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
=20
-	blk_queue_split(q, &bio, q->bio_split);
-
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
--=20
2.14.1
