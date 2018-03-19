Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496604-2-7194591768698320943
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
    t=1521496603; b=cTDhqQz/u96qQgcAAJH9J1s/zwZtYyvSZaMdAdmbOiRhT34
    oeZwoaY3/5Y+VR5aeokvh5ZeRdC+AD3DEoYladGmD0nG21BCMkObM6mgFkVm9uKU
    K+R02EUyzukZpiMO2g5Un0aNG2g2BeeH7wKGkSPvpXdaxqmS4yy79qVj+3i65NzK
    Y8sEvfhZ1ccUveW/p9stpTJcT5xJcFwwaeB8OAPtUcJ8eChSJ7ec2UZS6bJPwxff
    n4Kc036o9i/FtVxFCp3M7ZrZdSxp4ae2kVt5fjQ91/EYLbxy/t4txPYi6/u7yB4U
    ypHFehM2qhTcKmm8hDVt3Cvti8+LbnixZNfONqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496603; bh=W9sURW
    liNGhxouIkZfXWEt3LVM2sMARqx8D9CasHUA4=; b=Dr8EaDZRsKzF4C8Tp1IBOD
    vM/DhsPvFbvjYEQrlFBWlVLRGaVxkrkvQf3blnnOmmYHl2msaFICnqGkQAj7/jqn
    kUpDgKnSVzRR/v+1I+Fc1G4bp4dicaDx2uMemknrVEJKH4amIpc2n6+BN8XjzEo1
    EFP6y12McKgs8/4NqSkA3rDyuie9SiM9f27vpJiS54Xyzpre05zy7fYTAxXWP2rM
    ++q1Watk1EZ8/lRV5uaMmuU6umf8uvSt06JAyo6WrIdkBESRbgzrjVzB0zyx4LUE
    JZ2Ie5Hh4eMNP2CIpGUctC0LF2utyROmFh8EjUR2vYNgbPvQ8Mo1GoX94ovFWLQg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o+mQh5IZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeliedugeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o+mQh5IZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeliedugeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934269AbeCSV4l (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:56:41 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934576AbeCSP4m (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 71/97] blk-mq: fix kernel oops in
 blk_mq_tag_idle()
Thread-Topic: [PATCH AUTOSEL for 4.14 71/97] blk-mq: fix kernel oops in
 blk_mq_tag_idle()
Thread-Index: AQHTv5rIKNXLs5d340Onmq/u15HatA==
Date: Mon, 19 Mar 2018 15:56:03 +0000
Message-ID: <20180319155411.12348-71-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ksaujrfMOxkoAZ3hHD7Mk+sRZbL5fTuonbx8yoFp2XiiHSkNIc8MwRc+nen1wE6JLI5KfP7pI9X5hljoGN9UMEql3rNPgYjhHHlaWbiV6sSgtBKu8EeQCwBSk2AFkhnpGwEsE9AK3ltvrjDUPsERvbu1R89upaBMLsLB1Ss2vsJkbacu+qR3c4HsmPONBJRcQzPt1WvxPTG15Mu5ajw52goLr82g9d+5HEnuma9qkHHsmMXeAXhY7kAXUeZteOMQ;20:4XzKZ6mh5TI1wz0p3OvQVn9Dw0NLlsa6kJFhsQg49jd49x7ois0YPKBfktCQGw9053j4H44iHM7kZlOv/vzChiJEHIxWmdYk3J//7wgzuLOXZTwXnzYtUo0MHJboE/TAQQrB8Om4L0V73rSjjuIS9wNFdq80ewnVMltloX+Q1Sk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b6dbc35-f079-4661-cd91-08d58db1fe38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031EB8589AA54384CFE05ABFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(51234002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KyuNpKodQRdVm2LAXeHo9ZKBNQn5aKxQxmp42jZzc1NCl5tvAM0X21gUNFswF2c+5yi289pbnE22MJHGJerhVPOAu6egzvPjn4h1KpowRJehjkEwZEs/wuaF/Z/Ikqqa3KeKqiCnZNKWk3N97eDihL66N5/ey0jSRBtdCM19VM6gURDgZsNykYh4xpgRj1+D69KQJDzG5Mos3htCPntzkZpDGGAhjxdU/RqeMXhjZj3M2RqS5rUmzdWPmm3pOufCN1sEukIBbSLF8Hxi9lyk9fJPfOGKY06V8Ezne60KJd6zRlvccrC0MeXIVzXRHolkXhIeviXCUO2d2PUmSGCI7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6dbc35-f079-4661-cd91-08d58db1fe38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:03.7910
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

[ Upstream commit 8ab0b7dc73e1b3e2987d42554b2bff503f692772 ]

HW queues may be unmapped in some cases, such as blk_mq_update_nr_hw_queues=
(),
then we need to check it before calling blk_mq_tag_idle(), otherwise
the following kernel oops can be triggered, so fix it by checking if
the hw queue is unmapped since it doesn't make sense to idle the tags
any more after hw queues are unmapped.

[  440.771298] Workqueue: nvme-wq nvme_rdma_del_ctrl_work [nvme_rdma]
[  440.779104] task: ffff894bae755ee0 ti: ffff893bf9bc8000 task.ti: ffff893=
bf9bc8000
[  440.788359] RIP: 0010:[<ffffffffb730e2b4>]  [<ffffffffb730e2b4>] __blk_m=
q_tag_idle+0x24/0x40
[  440.798697] RSP: 0018:ffff893bf9bcbd10  EFLAGS: 00010286
[  440.805538] RAX: 0000000000000000 RBX: ffff895bb131dc00 RCX: 00000000000=
0011f
[  440.814426] RDX: 00000000ffffffff RSI: 0000000000000120 RDI: ffff895bb13=
1dc00
[  440.823301] RBP: ffff893bf9bcbd10 R08: 000000000001b860 R09: 4a51d361c00=
c0000
[  440.832193] R10: b5907f32b4cc7003 R11: ffffd6cabfb57000 R12: ffff894bafd=
1e008
[  440.841091] R13: 0000000000000001 R14: ffff895baf770000 R15: 00000000000=
00080
[  440.849988] FS:  0000000000000000(0000) GS:ffff894bbdcc0000(0000) knlGS:=
0000000000000000
[  440.859955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  440.867274] CR2: 0000000000000008 CR3: 000000103d098000 CR4: 00000000001=
407e0
[  440.876169] Call Trace:
[  440.879818]  [<ffffffffb7309d68>] blk_mq_exit_hctx+0xd8/0xe0
[  440.887051]  [<ffffffffb730dc40>] blk_mq_free_queue+0xf0/0x160
[  440.894465]  [<ffffffffb72ff679>] blk_cleanup_queue+0xd9/0x150
[  440.901881]  [<ffffffffc08a802b>] nvme_ns_remove+0x5b/0xb0 [nvme_core]
[  440.910068]  [<ffffffffc08a811b>] nvme_remove_namespaces+0x3b/0x60 [nvme=
_core]
[  440.919026]  [<ffffffffc08b817b>] __nvme_rdma_remove_ctrl+0x2b/0xb0 [nvm=
e_rdma]
[  440.928079]  [<ffffffffc08b8237>] nvme_rdma_del_ctrl_work+0x17/0x20 [nvm=
e_rdma]
[  440.937126]  [<ffffffffb70ab58a>] process_one_work+0x17a/0x440
[  440.944517]  [<ffffffffb70ac3a8>] worker_thread+0x278/0x3c0
[  440.951607]  [<ffffffffb70ac130>] ? manage_workers.isra.24+0x2a0/0x2a0
[  440.959760]  [<ffffffffb70b352f>] kthread+0xcf/0xe0
[  440.966055]  [<ffffffffb70b3460>] ? insert_kthread_work+0x40/0x40
[  440.973715]  [<ffffffffb76d8658>] ret_from_fork+0x58/0x90
[  440.980586]  [<ffffffffb70b3460>] ? insert_kthread_work+0x40/0x40
[  440.988229] Code: 5b 41 5c 5d c3 66 90 0f 1f 44 00 00 48 8b 87 20 01 00 =
00 f0 0f ba 77 40 01 19 d2 85 d2 75 08 c3 0f 1f 80 00 00 00 00 55 48 89 e5 =
<f0> ff 48 08 48 8d 78 10 e8 7f 0f 05 00 5d c3 0f 1f 00 66 2e 0f
[  441.011620] RIP  [<ffffffffb730e2b4>] __blk_mq_tag_idle+0x24/0x40
[  441.019301]  RSP <ffff893bf9bcbd10>
[  441.024052] CR2: 0000000000000008

Reported-by: Zhang Yi <yizhan@redhat.com>
Tested-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c28d6b3088a0..6f899669cbdd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1928,7 +1928,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	blk_mq_debugfs_unregister_hctx(hctx);
=20
-	blk_mq_tag_idle(hctx);
+	if (blk_mq_hw_queue_mapped(hctx))
+		blk_mq_tag_idle(hctx);
=20
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
--=20
2.14.1
