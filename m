Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482563-2-4953818423134242945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482562; b=dVgDSXbG8ERJfhJX9WGHRjsWGeCGQp2zcBijQsWi5pBCppH
    iswF0BqxSNJyACN5Wqe7d5GxISYaukSHGHfuE0b4cIivRUv56BZFlm2ZLe9FlMbU
    E8C4Zv7OHUID/vRvjyLzXWQ70eHv/TM3BL8nyxi8Mt2A3j6GVbfUAHhN1o3kjTdV
    fBcMXVDHB9j0Gfxg4y2W7hXn1nhXL6wDhY2LGkuiDstpIylT4ZqAcsOaFbZuIaMh
    DGs83Ilz3oR05GOGdfBE+1ynaBWw/0R1XZOAghjsCOhOcKMBhyc8GFlQ13+tZ1Ms
    oyOp+wFlJGIJCNXCZNostLprnTYr+s1wPFi/3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482562; bh=GLGRRt
    sqixUtUICQIzFaVFC7PfhOE69qxaTXXqTQVBI=; b=pMlk3zukpRpQ2z8FWPYGGv
    WyFhlrBVNyqYYECX80rNrtVLRfi2V5HGuhs98WO+mzOxl2r0ReAw2M+1HLAsGuEs
    CwNiI8SsK60pmBas7vVrs2JeCPMF/v6OzSGgP1Z2upovb7XXV2fHNca18nKxnwvc
    191Nhkj1UiXHlHwW+GCA0KQmNrjZm0VOYqxlK0xLeh2tGGog8HfdeR/YY0itw0vW
    kCspurwhAUc8mJkq835bC4xAeSjczFLQ7ApaidRoOzWex4z9QTlH8u+TSC3X7Yf3
    TqlJMH//f6/vG3frQdWlHQGDYb5FrMlI2YTEk5CKCZoe8lDeiwzmjKDEktEI/kPQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nCZBNDQo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeitdenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nCZBNDQo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeitdenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968423AbeCSSCi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:02:38 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965617AbeCSQD7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 193/281] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Topic: [PATCH AUTOSEL for 4.9 193/281] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Index: AQHTv5uRMp6w0pj+90SaYqFKYzsM8w==
Date: Mon, 19 Mar 2018 16:01:41 +0000
Message-ID: <20180319155742.13731-193-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:GnmcLNSH4jc6wZovOpiNPkcZXxlD3o7aORpuj7Ur1N/YitRlPMKyfC7uO/A7mw8tTalmIxETIMp6gqQA/zjS0aJIJm/3d+FZSdQYL0vbmtg6GaO91kWzJpMcz8VoJozZWs8vMavp/GloivirhD4KFFyFxTZlcu/ynkgW2yv9WCuNgEyWga3igKSV9S7SjXv1LCvZKZBKu6mza4mXHTmGYO5WsBocBfRwwAgsmi1Hl1gL/takc745UGdP1eY4JH6K;20:cza4wBtHgoNVX9WYvJY4Dldr99QWiVHmkzYf30F1+RonYiH3NoUypR1tUeS74rC5joLpnd+TYLP83OQPzyMRA7MOyAqB/YVORDOCrKnLDvTYRJMo81ljLx/t4xwYe0WLP+OHd+l6aOrTy9Z7Jukc6bLG05R7oPS724dDPoOGZj8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7961ddd-081f-4b68-42ae-08d58db3038c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727D6DA06BE9386F3D0A67BFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: MCEBtvP1e71wPR7TYQHrlOraba4QDqSM25Db/wcfcZvG3gg0ynH50/VCk5o7iLQF8JwY2dWUOsHRcxhNEW0VwvcgQJ49JCoPlRm23FWgqiWQG5x1+k2YDFBnzEr05LJbv9E41MKXRw3inkzA28X+paoIbtwKlbiAs3mMBM+f1w/6dvN2xFisy4mS28jFM+wmW8+/leXNzkxmlZCSl4ckbTZ+nMqZQUNI1Z75hLFXWzAxRX3sylIaZtbbPMTW/VCmHgpJzdDOzOSmwcv0EpE+sNbiNTTDN1MLVYGDuH7a68MTjD6tr6WB9gvBSkDC0vfxB1xjkbuHBCoRI+o4lp5d/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7961ddd-081f-4b68-42ae-08d58db3038c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:41.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 63f72f00c72e..80dedde0de73 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -175,6 +175,9 @@ bool bio_integrity_enabled(struct bio *bio)
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
