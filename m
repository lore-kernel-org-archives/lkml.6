Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479607-2-3744784637962356570
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
    t=1521479606; b=ubpcAOxhsTv0n81iyC+kRe7YpmxIqJW3v5FdN/Ne6bmdNT6
    CVS0sG5q/w/DieVtmRW8xIOEfHy60kKISduv/DTmdo7/xx0VFtUxnK2xbedLXdZP
    JKkFZ/YnvL38XE8T6cGJN2iTq5rom/b4rfcQ4/VP52kuc/NH29zO+kw4KX76KZHu
    +dwiXTFDtn03xgCWGuGrjjD/IYYDXTvUgtLvO52iBRKQa2pADAnVdTx4LruxO5yv
    znmL5FU6qT/K/r0euAegOlKkph+01fcbzVQL5lytPv0OpFAyHBfMihRFgGZthi3w
    yKZDEjdpz1926itotJS7kbzaXIhtbmfYaGhF/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479606; bh=Nsl/Qw
    8dSre2qa/90CMKqI7s7T2tmesM0M2xVgdRn6s=; b=RzwFfdvHp+t7pKIUkmRsQy
    b3UAYKVs80s2efoILmnUCwc7PQFi47szuP8Smvln/B9cOi/kgKRA3LhBLaiYFCnb
    4DPBQH/hqLk2MBUqeoiJ3xOfGoqxk8Eh0IWK71v0nyRMvoCXpOSOptXC2/8bYtnc
    R27U9Fb09AO/D8BtiV5928d6r4Ms3BmyfGESvpnLi4YmI9s+TzHojKH4EcTzuMHk
    d53tq+UyPiVCoyySlGQVO/JezCL3N1F5Fgf4bnfeeCfKra4m+IqUrFGnWPclnvzo
    f1by0ywOq1eW/lBi6TjW697tYZVyaTlVLpgBOTth2kr/3NfZQNBGx/Y+fP/PgiLg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IuDVJjKe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefiedunecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IuDVJjKe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefiedunecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966536AbeCSRNW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:13:22 -0400
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:22396
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933654AbeCSQKQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 120/167] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Topic: [PATCH AUTOSEL for 4.4 120/167] bio-integrity: Do not allocate
 integrity context for bio w/o data
Thread-Index: AQHTv5xvVv4PljaEE0O6Cd1zF0nU4A==
Date: Mon, 19 Mar 2018 16:07:52 +0000
Message-ID: <20180319160513.16384-120-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:PE/fqFPB40IhDZ8/cg4/HHpzl3G4zubRnihdb4xG5TaJookdZkVX+TSZyM8a0oG1QrrE5967CPkRIoZUJl7QoD5FYHsR4pqOCd10HtOJDhjKX6YS2Snwicq3jVr0QLZyJUi5LZrN3DkkH7be9U8244MpfyaR3TnIHX/u4de3c65BA6aYJIsQW1dWmbHDKTGAWUto0jUANQaznp9yUYRN5sIGloUqk4FrPekXSGTsbMm9hdNPOspNbnU1GVac4atK;20:63zaNU8/OrNolTD1C/eG3zKL0Fq7k47+muMaT4X906M2BGatMtlmC3DXcPywu5oCcwOYrMyEdq3Akq3ae4DNJnCo3E2pvCF9+misY0pq21YVOoVIa2p7nv/ptJiP0seloWP9TDsS96F8BySqOtS6b4BVKOwKD47rL0yoAWWUr+4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9711a63b-6a0f-4107-9465-08d58db3dfae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E7D017EB7605FD341A86FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OO+qBdFShsWZHuhwuyB3O/McWQuTfU1mgYdl2TBSD/brTPhPSBqFFp1lLDtQbVkjU0HwssAxZPW923F2ue+aaC71fw99yLlb+bjFG7SuQIrd2LDfRLMYsUfd9VPhjqZvj68qry9ZUx7+c+22hKdU9J5eXd3XJzTZ1EWnfJt3TdFQJqmp7zYUqbupJ2w7O6N3LHTxuYyXUkCozfCK6nt5RvGzomqnOLwzEbUjRr1LGz7z7j3hFx4cqB7eoNJ3ig+MLeGyOD8kuSg9OCKEgRxsx7cuA63bi/ZgE6YRhJKjYpZoCdQlkDUxVlFYov/Cwf+Ew2C2d1kmdd06qZw9U0PvcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711a63b-6a0f-4107-9465-08d58db3dfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:52.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index f6325d573c10..6e091ccadcd4 100644
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
