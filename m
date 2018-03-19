Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498575-2-15911312481507498189
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
    t=1521498574; b=G+SGJvNGxkAgkVtJPDuVnFrHo4rI7orjKQDIFP0/p49himU
    KxnPMTU6o83/hBtO24hFNtiZzmrUbPtZFK1KscaiXY7KB62vznwf7yx90N5dY/YP
    vlCuWYu3yFfz5WCw28GpoUaPxC6gJmtYEItxuWInRmFM1FVkjZKFlC1lHzpVitWm
    Cnhg8DnNNCwIPiHM6vPCWsETBzU8yzocOx//l1VVjurhP1Aep8wiwelKhvXPZyc4
    45cM76xSSl1j59aOUIb4FLxlDtX0d+lHN7lDHwHAdMekF10Z55qZmj/JrTd6jBmN
    fT659JMp3xb+bl+SQqQVprRsdXDW+K6h5wA6Fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498574; bh=0kYdNP
    MffejYxmGU0TiU3io1EBE6XPHMIIDiH/G8t+g=; b=hRS7oJv+TvYyTVPaonPGiR
    0SrTX2pHlmeXQmjXLVBifyrpcR+t6BFKMwVi3qiuNf3F80mRLadWAa9l3eSBt1Cu
    05fJFy4t3cxSbhkgCEMJPm+e9sj8xNygqyUGaVs8JlPaUQSuyhL62AQSnNrX8ofH
    79YBqRD2e1UDz8H7L01xZpyjfPOvg0F5oteVaI8EfCH5MWK0wdl6FV/tu/ygfSww
    u9dBv6X5Khoi7Hk1rhsPDajouY09hJz1rzkwnfkJj9n9n5X0e0dEfxmAiWJvskj3
    IG+FBOENhxQK/MRLgsW7yA7sxKUNOscwsnCMy1/jVTkfoCO1MFK9xJkmoI1BNZpg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cfoPzreO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdekleegnecuvehluhhsthgvrhfuihiivgepfeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cfoPzreO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdekleegnecuvehluhhsthgvrhfuihiivgepfeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933839AbeCSW3b (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:29:31 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:15712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933795AbeCSPso (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 056/124] blk-mq: avoid to map CPU into stale
 hw queue
Thread-Topic: [PATCH AUTOSEL for 4.15 056/124] blk-mq: avoid to map CPU into
 stale hw queue
Thread-Index: AQHTv5mncLYGrWYEREemqBa3n8b/Eg==
Date: Mon, 19 Mar 2018 15:47:58 +0000
Message-ID: <20180319154645.11350-56-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:iq3Z8NBPdGppDyx0+cFZ4774HYNWNr9qDAUHcZ/rfNa+gc7jzy7A0rJsjyIUMFEA9Sp74pwlPuW9w5IYyRRQ3egPr1r/q1rMDnZC3jarqoluFWHFS3rAMmYMR+s7bqJRXJ5qMcFE6PkCXEhPMt9b9WPWQolIje0WKA3b/+p2MzeeIYMwUsjxO0FAKrHs7Cf7KzT5Ik0qPSZQTi+5RXfaIWB+hkTGEUHTJVEKjFZqCiJBoyL+nb/p2mJsoAmmhEGX;20:rWMCXtFG8vxkiY7nflxI+j0tPQGhSySTxnlsjH7XlHIvcelNel+xC2Oe488oEXh9KIyUBfFSN9pE7dMJrZo9AfLH9dGq5TAHVxqhko5zAxRvyh1EFC16RsJQkVmVSD1KYczyq2NRGi0rc3gZFPlKBcxzvfJ1qC+wEC218ymVibU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2995e9db-c0cf-4552-f2f3-08d58db0d483
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031D171B1C7227E168B0A34FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(51234002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LFFyH0FdBPgUHL3nmsct6I1n7N/7Izcke+GpnzaVjEoMzZtqggrc6bP68XVw0OL69b4+LxQzzrvJP3YsgJdUK1orgPSSsljW/X6+rpS4uh8VAnz8H8ik2n8wY7tcKno6crNuVXi/5AU0T5Ims4if068htgl8MHigtUhsz4qgd62cYiZYhzgg7drqvVE2sVzf23ghV+6pN8cMl3sJcGpsAx3ZBPPAceyNPokCFQkkljuotxWnM4ZdfCJp43CcHlOsoFppEx8un8WcjZ+KdjWDEvUDZHE33WIdxBt8/YbVvBL9D9HtaiFoXenJUwguxhCBrOqSlxUa78m+CusZG/626w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2995e9db-c0cf-4552-f2f3-08d58db0d483
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:59.0040
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

[ Upstream commit 7d4901a90d02500c8011472a060f9b2e60e6e605 ]

blk_mq_pci_map_queues() may not map one CPU into any hw queue, but its
previous map isn't cleared yet, and may point to one stale hw queue
index.

This patch fixes the following issue by clearing the mapping table before
setting it up in blk_mq_pci_map_queues().

This patches fixes this following issue reported by Zhang Yi:

[  101.202734] BUG: unable to handle kernel NULL pointer dereference at 000=
0000094d3013f
[  101.211487] IP: blk_mq_map_swqueue+0xbc/0x200
[  101.216346] PGD 0 P4D 0
[  101.219171] Oops: 0000 [#1] SMP
[  101.222674] Modules linked in: sunrpc ipmi_ssif vfat fat intel_rapl sb_e=
dac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass =
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore=
 mxm_wmi intel_rapl_perf iTCO_wdt ipmi_si ipmi_devintf pcspkr iTCO_vendor_s=
upport sg dcdbas ipmi_msghandler wmi mei_me lpc_ich shpchp mei acpi_power_m=
eter dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_k=
ms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahc=
i crc32c_intel libata tg3 nvme nvme_core megaraid_sas ptp i2c_core pps_core=
 dm_mirror dm_region_hash dm_log dm_mod
[  101.284881] CPU: 0 PID: 504 Comm: kworker/u25:5 Not tainted 4.15.0-rc2 #=
1
[  101.292455] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5=
 08/16/2017
[  101.301001] Workqueue: nvme-wq nvme_reset_work [nvme]
[  101.306636] task: 00000000f2c53190 task.stack: 000000002da874f9
[  101.313241] RIP: 0010:blk_mq_map_swqueue+0xbc/0x200
[  101.318681] RSP: 0018:ffffc9000234fd70 EFLAGS: 00010282
[  101.324511] RAX: ffff88047ffc9480 RBX: ffff88047e130850 RCX: 00000000000=
00000
[  101.332471] RDX: ffffe8ffffd40580 RSI: ffff88047e509b40 RDI: ffff88046f3=
7a008
[  101.340432] RBP: 000000000000000b R08: ffff88046f37a008 R09: 0000000011f=
94280
[  101.348392] R10: ffff88047ffd4d00 R11: 0000000000000000 R12: ffff88046f3=
7a008
[  101.356353] R13: ffff88047e130f38 R14: 000000000000000b R15: ffff88046f3=
7a558
[  101.364314] FS:  0000000000000000(0000) GS:ffff880277c00000(0000) knlGS:=
0000000000000000
[  101.373342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.379753] CR2: 0000000000000098 CR3: 000000047f409004 CR4: 00000000001=
606f0
[  101.387714] Call Trace:
[  101.390445]  blk_mq_update_nr_hw_queues+0xbf/0x130
[  101.395791]  nvme_reset_work+0x6f4/0xc06 [nvme]
[  101.400848]  ? pick_next_task_fair+0x290/0x5f0
[  101.405807]  ? __switch_to+0x1f5/0x430
[  101.409988]  ? put_prev_entity+0x2f/0xd0
[  101.414365]  process_one_work+0x141/0x340
[  101.418836]  worker_thread+0x47/0x3e0
[  101.422921]  kthread+0xf5/0x130
[  101.426424]  ? rescuer_thread+0x380/0x380
[  101.430896]  ? kthread_associate_blkcg+0x90/0x90
[  101.436048]  ret_from_fork+0x1f/0x30
[  101.440034] Code: 48 83 3c ca 00 0f 84 2b 01 00 00 48 63 cd 48 8b 93 10 =
01 00 00 8b 0c 88 48 8b 83 20 01 00 00 4a 03 14 f5 60 04 af 81 48 8b 0c c8 =
<48> 8b 81 98 00 00 00 f0 4c 0f ab 30 8b 81 f8 00 00 00 89 42 44
[  101.461116] RIP: blk_mq_map_swqueue+0xbc/0x200 RSP: ffffc9000234fd70
[  101.468205] CR2: 0000000000000098
[  101.471907] ---[ end trace 5fe710f98228a3ca ]---
[  101.482489] Kernel panic - not syncing: Fatal exception
[  101.488505] Kernel Offset: disabled
[  101.497752] ---[ end Kernel panic - not syncing: Fatal exception

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5629f18b51bd..4385c5cbf57b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2603,9 +2603,27 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_se=
t *set)
=20
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
-	if (set->ops->map_queues)
+	if (set->ops->map_queues) {
+		int cpu;
+		/*
+		 * transport .map_queues is usually done in the following
+		 * way:
+		 *
+		 * for (queue =3D 0; queue < set->nr_hw_queues; queue++) {
+		 * 	mask =3D get_cpu_mask(queue)
+		 * 	for_each_cpu(cpu, mask)
+		 * 		set->mq_map[cpu] =3D queue;
+		 * }
+		 *
+		 * When we need to remap, the table has to be cleared for
+		 * killing stale mapping since one CPU may not be mapped
+		 * to any hw queue.
+		 */
+		for_each_possible_cpu(cpu)
+			set->mq_map[cpu] =3D 0;
+
 		return set->ops->map_queues(set);
-	else
+	} else
 		return blk_mq_map_queues(set);
 }
=20
--=20
2.14.1
