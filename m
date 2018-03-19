Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476784-2-18388964626322205701
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
    t=1521476783; b=Jig2LniYAoqha49uB21DIUtnlNT4s9X4WqrCFPI2MQuvQNm
    kzDPCBU9r40PDIq1uMOFeJ3t+I8qEd3qaH6JWwqxrFn3t0oNJ64AV5fJOGusA4P4
    3GrCWLdD83GZAE+VfkWBEgsrsDvVqBMf8tzpYLUEUFJYNUFtBvYh3wxC/roRu9PO
    ptSj7qAGwgO2WZdA6rnasxogHpzQqil6Kg7YrDSHdVka7oxBe3lKRHBviEFv114g
    AdxGLPHJrKgnkSuYQPhDhyfx6tMLoSPD5DSZ0RTPiVlIIw6NQmC4U2W+QKfUPHn4
    gRvWcF0JyuXaMMVdnLR9b1pDxCQCsYQOFqbNLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476783; bh=zpzyk7
    ZFtcMQS/huI3viSgS0IXcbcHvGw42tTBoP5Ho=; b=wrfsfsJHM5Zr4pHw6YoW02
    PtRaC1NDQ8CObMBk+ZOZ6gfoYgHKEBof+h1gk12KXSV4bbUvt0jDDwFoYUfRqk/U
    B+x+AJPVRypHsT6cZvGpGo+MllM+BF5cZjUTtlI1X/0pEhGJYLFn0JHQPxfOUDso
    y+Dx3I/RuA13e+AXoPaZrYd3LaifzWKo8ml+jPtvSpcs8ZKvLY619JcCRmqSWVKc
    hLtfB/r2l3cbv0D/v6FOrufS6S3EeLKFiBrvWZdJNJGFXfxNFNYVPvzcuygwnsl2
    T+W2HsqnLCjg76mbM2jO3p/PR15DVTx20jG4+RaY+WuLGoY1UX2sJTx9W4l28v0w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FiWX4mZL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefieefnecuvehluhhsthgvrhfuihiivgepfeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FiWX4mZL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefieefnecuvehluhhsthgvrhfuihiivgepfeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935364AbeCSQ0H (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:26:07 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966851AbeCSQN7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 068/102] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Topic: [PATCH AUTOSEL for 3.18 068/102] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Index: AQHTv50iwfXEaVyiGkmg4B0MxSJJzw==
Date: Mon, 19 Mar 2018 16:12:53 +0000
Message-ID: <20180319161117.17833-68-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:xRfqAAmzjbi/T7s8B8agwseAFFvWfSg0LjqvG8TFcaftb6/rbaZ5SAOLhAB4Q6f18Wz2jDzghOGlqqAkGJ4B0XS0+eK/Zz1VfHl97YoWr73gYYcDyNH44P9XQLTmiVUuH9QCxFgGV4QtLBnVwtvEqEkUGZO2TZy4Yvdp17UOh3s+CcJE9o8ScoEygXPqjfq3Ue/lRoSluJRdXysVmzAZ5Z+bUxqqoyyOfRljW4B40g7S4XR3u8xAZkDc36lcSv4q;20:TY2h1/VyZgtnW6ZNS1VwNfIkZr3OyKcA/I0HbAtmcolSMLChwXmBeZW2AhNhD318+/lGlmlx9IrcHv54u2EeD+7M8Fxp1/gIj8FigduUOb36XwNFDnf6yjsX/fneR30172H/Pq7p30unl7kjf5yWHHIInvRNbl/qDDHbtgJjY/4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5071308-606c-48ad-3b22-08d58db46b6b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063AB0EE3CDA34A1037414AFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(6666003)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PgtbDJ7R+QAB9bgEb2batGc2V7EGab7664h2A8L1296GDvh0sOvA/mjGD7Tea03YSq0pR2GRkC52Lol0g9BWSfst+h+EvPNsyMm2iTp9iFaGSMgh1TanEbXi0WnJt+sRPF9IugiaybclwI9sj6+9SGAJqa8f0mbBU01WW9UVuOh0U1K+cBx9OK81nteQf+OiudN41gnuMCFNJKWN1a+sXKjNT3K+E+6sEzbh98SVHHseYsXUJErYRLs/12i1nFgzagvjv33X9IoquAGH5Yolx05HY++sVG3O+RvFZ1g8n58kE7j22oAdTOYGG7/mccYldSDjrAwZnf/X8SdFr6oGnQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5071308-606c-48ad-3b22-08d58db46b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:53.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

[ Upstream commit 3116a23bb30272d74ea81baf5d0ee23f602dd15b ]

If bio has no data, such as ones from blkdev_issue_flush(),
then we have nothing to protect.

This patch prevent bugon like follows:

kfree_debugcheck: out of range ptr ac1fa1d106742a5ah
kernel BUG at mm/slab.c:2773!
invalid opcode: 0000 [#1] SMP
Modules linked in: bcache
CPU: 0 PID: 4428 Comm: xfs_io Tainted: G        W       4.11.0-rc4-ext4-000=
41-g2ef0043-dirty #43
Hardware name: Virtuozzo KVM, BIOS seabios-1.7.5-11.vz7.4 04/01/2014
task: ffff880137786440 task.stack: ffffc90000ba8000
RIP: 0010:kfree_debugcheck+0x25/0x2a
RSP: 0018:ffffc90000babde0 EFLAGS: 00010082
RAX: 0000000000000034 RBX: ac1fa1d106742a5a RCX: 0000000000000007
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88013f3ccb40
RBP: ffffc90000babde8 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fcb76420 R11: 00000000725172ed R12: 0000000000000282
R13: ffffffff8150e766 R14: ffff88013a145e00 R15: 0000000000000001
FS:  00007fb09384bf40(0000) GS:ffff88013f200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0172f9e40 CR3: 0000000137fa9000 CR4: 00000000000006f0
Call Trace:
 kfree+0xc8/0x1b3
 bio_integrity_free+0xc3/0x16b
 bio_free+0x25/0x66
 bio_put+0x14/0x26
 blkdev_issue_flush+0x7a/0x85
 blkdev_fsync+0x35/0x42
 vfs_fsync_range+0x8e/0x9f
 vfs_fsync+0x1c/0x1e
 do_fsync+0x31/0x4a
 SyS_fsync+0x10/0x14
 entry_SYSCALL_64_fastpath+0x1f/0xc2

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/bio-integrity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5cbd5d9ea61d..d9f4b3caaa41 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -165,6 +165,9 @@ bool bio_integrity_enabled(struct bio *bio)
 	if (!bio_is_rw(bio))
 		return false;
=20
+	if (!bio_sectors(bio))
+		return false;
+
 	/* Already protected? */
 	if (bio_integrity(bio))
 		return false;
--=20
2.14.1
