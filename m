Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494443-2-16649018929676536062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494442; b=djiYrL7+xuiW085Ua9sJ1Ntogb2m5lhT/I87/LV6E6xzlUZ
    8F90GCJuhiRWriQcLtVu6CJj3T84svZFYNPyXqGK4tFUUJO1lLxWKI4FXYi424AT
    qlhZA0PBFLQ3WDK0XNYcZbUqD0fgdggRP7m308rswATOaBC90MRJBMbfhPlxdaJi
    y4BvQOII5/ocV4gtaGQZbTPtvSDg8g8gG9AfeYjltUK8rFf+jlynfAdYUZnx55e+
    u3UvEAda97LLKp6AeiYfsEAt0BkzZqq48O9y9MbhHcPL8B8aWeDozcHiomp/a7zD
    uGaNaTSlOfzfPbULRWj/M0qX7bKpVhFkIQNm+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494442; bh=qE4Xor
    NcLkA758ORU6FR5A/O8AeFQBjfQv4gMIa79HY=; b=NFHI52Y2iW8lCs522x2s1l
    CIv8jm4Hompbg5iyjR8LnumWGRsidwVIGylWYfxMNrhRKjJTsZcGtpO8y58MKE+L
    iyF9i2B9NMyVpXiDyDYsjY3ghcGAC7FJ+t3BOhJthPoLwAPP79ckOq+LQk6BYHIs
    bYwQYV1GoRaNdB1qTiOz6d966vEmh5qQeRI3UQ8gnL6f1MR6oCR+5NETSg+THx62
    GeDtkaYXw9YER1vRgbpKu1pZpiT8iMCOcHJiUrWyUB7+HxZ7yigxpLOXkIqK5RRf
    OqWJnn9/yxiz15fdgxd9GFdJo9pk0HROrbRlXxh6uhA4ysOH1qn1+FMYWBh1zJbg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eMjCRBty x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvfeenucevlhhushhtvghrufhiiigvpeektd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eMjCRBty x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvfeenucevlhhushhtvghrufhiiigvpeektd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968913AbeCSVUK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:20:10 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:4912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934902AbeCSQAy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 098/281] block: fix an error code in
 add_partition()
Thread-Topic: [PATCH AUTOSEL for 4.9 098/281] block: fix an error code in
 add_partition()
Thread-Index: AQHTv5tOh7Au33Ar9U6Qme36MtAmDw==
Date: Mon, 19 Mar 2018 15:59:48 +0000
Message-ID: <20180319155742.13731-98-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:hngufS0fenaWrAi7LCvAFFGCieNUdkqIO4s9SqaqFZ7t6HEl7Ei7H6i3AWDs1ntRuNDTU4Mpzi2GP95ExXDgk+vaZ2hxtz2d8M2S3CZdlEG33NlbHnz26AdRjS29ns71UdFlynIqcd+RufzjqiMgTpWqSnDaAIepx7RN3nja7U5LPXtG0evAnb3WOjizLQXg4b2KxttTD0mTYp3RBFfdH4fM35RW68vZ2IDaL9mvDGBlSfLv/OmGseeOhUyg4jWP;20:pgkYJmkPlE3Cm9AXoAIEpuY1bM/bwVzjFt/i21fmUzdzwyJmPDu0gM0Ym+o1xxzBnTzvrf72wq5wDeOuAQL0HrDm9uQKYfyDLS2a3ZiZCXHvOJxKw1/fd+HOquRP0ZpiBwXmXc1w/TR5WH39AMo9oqom8Hyet6Go5jrKhWxqHGU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b79efc9-831b-40f6-c3c8-08d58db291f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB09334CF9F6E3341774CB725DFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: XIsykeovoE084PDrg42LK2ZOGTgdV8Y2J2urQLTR36eVFxnfgnQLnoKjPZLh1jb9q6o49n30DaWO2aNIXCs3H6kZGEKXSVv7cHqrbtZAfY9vMGofzxEdgq13u5e79GUWUlTfZrNumhLHVGpua00dplQiVQ3oUrzkVaRStZGsnAeKWGrgPaBpq/0q8zwW+vdQ5Td0koM5qsCW8FLsxP4eyaZDJzeUT+B/9UFm6ZGS9I3Grjw7UOIFIRwWsBTfiOIDsztGOS5k12y9Df/kUGc7QmczH8Bv/PHwdjUoVaQC5ES0nMDFUiqDru1dzyjn8zwXvyu2xHHI02N9e7fC7cM4kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b79efc9-831b-40f6-c3c8-08d58db291f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:48.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7bd897cfce1eb373892d35d7f73201b0f9b221c4 ]

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struc=
t")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partition-generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index a2437c006640..298c05f8b5e3 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -321,8 +321,10 @@ struct hd_struct *add_partition(struct gendisk *disk, =
int partno,
=20
 	if (info) {
 		struct partition_meta_info *pinfo =3D alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err =3D -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info =3D pinfo;
 	}
--=20
2.14.1
