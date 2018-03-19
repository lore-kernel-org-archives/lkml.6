Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497086-6-4024262830290692231
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
    t=1521497085; b=tcfV3B6QZjEy4oVLgAFaapmqr+bdVZTyIWOs1pVDE6I+MsZ
    OTSD05PoX+EvIibUwjwgIOZWTp6OTUO4mU5iOHhx3T7lLxOzAd1Ch6u8JSi/DW0L
    srag80npVXtK9JiA1IieJI92NbBwTmZBBwPdrNzbA1J+DcsWDLbrqwxdS0Jyv1w1
    DCTOtiEI8KwTufxjmiUFf5bJSFLhpO84wNUpf9SndtdQ8Iu2JE+gU6j+XYEGS4B5
    Gsf7lkvOHPTJOJQLMXkJbnDt4C7rzb1/ExOcS0zi4umVZCF2fmr/zXmYqW02KroI
    rgEGwvxubS4Z5TbC6rKgnxxoXvyykJ0PK1HS65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497085; bh=/67M09
    EpI5ECzohT3//hsx8chaRxCdwj3x9QCS0kF8I=; b=tftmIElvJF5dh6KU8zY8JV
    q3CEkkRLkpXAj1/EVtWMZca/Uxpai5GNbdywoGz0MIM3yfl7CY9eKiaIJKZOdPDz
    uWUM8Fw00zrP7YtCPw0AXndRPFQmqnh+0hHA5qrqDlc8+18Fso6AE9NN22sJg7X6
    MOJA3r18olObN6qEEOydO2eTaIZ/NTPtf9j/FbVrB4EYAujdKKJHrwkCfMuGgKBn
    arQ+5OMgY4ruBwARan3/GU8t7+IXzbjt3cRffBk+j07h8C1RCpf8Xem9cXufXcHd
    xOY9uc8A+GQZiq167NdIPJ7vPBWfHgrhgaiOSfhL9J9jOsuQA/+Vl6GWu2mxmRzQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AzhzXQoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdekkeelnecuvehluhhsthgvrhfuihiivgepheeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AzhzXQoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdekkeelnecuvehluhhsthgvrhfuihiivgepheeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933681AbeCSWEN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:04:13 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:42976
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934117AbeCSPzu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 42/97] blk-mq: avoid to map CPU into stale hw
 queue
Thread-Topic: [PATCH AUTOSEL for 4.14 42/97] blk-mq: avoid to map CPU into
 stale hw queue
Thread-Index: AQHTv5quCqcstVMimUyIygaz7G11rQ==
Date: Mon, 19 Mar 2018 15:55:19 +0000
Message-ID: <20180319155411.12348-42-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:KHJ64oUKVurUUN2n+NnRYBsNV3JIrkphiXqPnGpqZZUCll/f3sjLa2XR4/fNASEll6X/dXYom0B3CQdc5YHDrGVYX6RtBPezMSYef1Ox7jpUs3ySs2K0dAfSRRreVQnQ3sR7LRK4XJVbSvNSWzsu//ePOy7phCbuldW9ZIha7+iYZ3X5DVQNXO2IaNcZQyQiehAYUjs8WFrFp7RERaZpiU/n16zrbq18UVk1ghARpsHPgUV6fBcqJswPIRCYmD8w;20:YPCv1RU9+LlRI58EnLz054AZZCW9P2dHG/sXi7phY4pDZPu25b8y17N1TBXJGwq8KxNGrp/3B8Wfv1BSEW/FikBIHB++Oyq0WefjAuUOPuczhnDv6E6Ztsz8iqMJaJOIPksWdKFlda84kNjojV/SJbTTscPL6vAKlmB/nwn6LFg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e19fbf7-ae34-463b-59af-08d58db1e049
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967022657D30BFCE8E0E11BFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(51234002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: I0M6h7kawz6qaLBoMRK9lG4s3DkVFCpVSIT/Vvrb18iqqBCB9qEOI+Mm+i/17tVpLY/0bFUAZ9kZ043+jGR08Kb7QOof/UV4EFBxNroO93Uqruu7jN1PSnh+UgjmGbZZedusI537rWhyTor3YWqTsM+fm7mLGbzYy580VuDjLdjDKnt2qSp500WHQHLq+KQAAAd25XuTYQmSj/ib7RDgpLGObbfOaBiiKZzQ/GQxJikFTjYg8B8sXD96r0S0Tr3ic9M+t3+g/zw8noJ5et+mVO1DAPOTwXVSsNR1j0/c3/WUJmvdfsRnOAZFmpK+n/sIonGpHnTjRLBEmNW7Vk7nnA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e19fbf7-ae34-463b-59af-08d58db1e049
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:19.8771
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
index f1fb126a3be5..12bb7a49c5ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2528,9 +2528,27 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_se=
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
