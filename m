Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495845-2-7738480974362436441
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
    t=1521495844; b=WaizRVedG+jz/7WGA1B7cS9yg693i9lvxO7KWrUiAda+f0A
    oez+Zn1l9aW9dV4ZifxwDZb5M5D5jPIdi5aK2Jq0Xp3CyMniVQHosfoJ5OhyNv9S
    b/H8H1M4efQfXXZtRBE7CtSYHbzJlLaB9dJcUKQym8ZTFedH9uNSxtVopa8ZueSx
    1slqd6PwQVqLwm4SDi7NJUCGs4+pAhuixtoCnoWFdY5VX93erN28lMjm8iko5lqP
    BB4ZOXefrxsOcsXZDY+TxZJNinFfBN1YoNo8U26H2YcVW1w4PwRcJVCa3L1/DTcb
    P2S7ZQVDWi4u5hZSGvwWKFA0jTbTPH0UE0MAmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495844; bh=iuCoKv
    a7c7g/3fYRpMjqaUMLuwpzm9J3bm5+zoyF+5g=; b=DRFwVcvL41hM8Ypw3pnLoG
    FLnu0xYiej60l6OiLbm9BefCc6zyXyqWz8Qt8B728ev8eFPoJW0oWnL7rRHy78zs
    4+j7nSuOyYigQnjSSkLfearmCYkwj1u06Eq03vJsU4qXmSe/xwxgnBRjjhi4Osm6
    77a8Z+QoDBWoaUSmBMWW9UfTZWTF09M4KbLBQa+1g7CHYBvN7LFTcQVoxOZZ8ogO
    mvifPw2/GkeRBs6ALXKNXTB9AWbH/at9VJhlcZpdvSnWbh6TARfD/IdCQfTGJOFx
    Kx8zvSKGRDM0oyfs5LePwqjOpfn30JpZ7Lr4qOm3CfrxRWx/GmZTlA3XBOgLgqCA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gyr153z+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtheenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gyr153z+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtheenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934875AbeCSVn7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:43:59 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964937AbeCSP6a (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wen Xiong <wenxiong@linux.vnet.ibm.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 029/281] blk-mq: NVMe 512B/4K+T10 DIF/DIX
 format returns I/O error on dd with split op
Thread-Topic: [PATCH AUTOSEL for 4.9 029/281] blk-mq: NVMe 512B/4K+T10 DIF/DIX
 format returns I/O error on dd with split op
Thread-Index: AQHTv5scLcUIaYCn+UOyTUKQHdG2yw==
Date: Mon, 19 Mar 2018 15:58:25 +0000
Message-ID: <20180319155742.13731-29-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:qIBtAH+aLXkWehNpmo3uM6aRWZtqIYHD5sjcJUVreiqGjgnxAELjgTu1B3pE9UjEcQBlyAzkRDkLdawviRfj7iCa+fui1bac5M4fkOuxCK4rhprI8nXDWMkWxA/kCUeNrF4x6StO/apQLoBYg/SNAIezvYN+f+E1+FK3juItce7WB+UAlkhxcftRY/scvs5PfDhhqQwVZynTooqYikEBvnWjk/8i9/q6MOE91QIhkkAHDctWlIFBKN1QfxHN1YmH;20:3CkUkj1FJr5LMtHFIAx0I4X5R8jK0EZZ149xAO2emWh6AlrDwDROX+vqUGFDwI8gyqGqMl/w8/V9OgLprNuxlheTbmcl0fSw2NgFx4hKrBanP0u7JaYJKIoyetP6kDutdhpQDRBWIMaE5L/PbwSNh9/vgXl7NA2lHGh94DAfh3o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea70f11b-2f19-434a-7de9-08d58db23f81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933B1367729B3BC37F443F5FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: nF7cJkslWgIpYNZHztClPfixldv6951wqpDaU3SOzUO91lQoXrIDPdnuwTbCxRSzwZg4e9BUieOTJCvbe3tIrGRt+zKoYiGFISyg6Zvp8Mvithm3+OR/TXwRIMGsOOo+TpOxIdYPfoLWA6yOXVay7E6TTztPqa1IhLii61O8y0/qSaOnTnI97U1UQsY6SHeObsc9XHdjlZ0eA7YgRHOXxnI7+fzNREYVEC23beAIj+jPX5ITnU0LK7OxOEnyS9St8JZ8rq1xfZSGMnv5KS/USILcTl+qOD0VwVHNccEUzUIBuS+WXRRjM2t0gdtsFvIW/OQCnfFP5zuZvdPwdMIk1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea70f11b-2f19-434a-7de9-08d58db23f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:25.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 10f8f94b7f20..a1bef12dd4c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1265,13 +1265,13 @@ static blk_qc_t blk_mq_make_request(struct request_=
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
