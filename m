Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9792082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IdvNa6XV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DxrU/L+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9792082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJ3Gmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:42:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53958 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbeJ3Gmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:42:50 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TLoBk2024861;
        Mon, 29 Oct 2018 14:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Zb9A+AO1o7G8ZkhPlsVGcpKyW6H1vTQf4I2n9gEIXQw=;
 b=IdvNa6XVW6zwjIgpPPudeCelWTUL4XMILKgbr+/Ddxis3zrGDnamk2YwvlANI24H5uvk
 cwbDtlt7m365w4or4ovVimr1JIOqIbpZNwrdBoYaTRTWVzUOsP7YH+DYWS9ifuWkd4nE
 kGhVnaLeSQ8zj+ULwMJAdfNti1RcxK5qBls= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ne72y8pgc-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Oct 2018 14:52:09 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 29 Oct 2018 14:52:00 -0700
Received: from FRC-CHUB08.TheFacebook.com (2620:10d:c021:18::27) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 29 Oct 2018 14:52:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 29 Oct 2018 17:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb9A+AO1o7G8ZkhPlsVGcpKyW6H1vTQf4I2n9gEIXQw=;
 b=DxrU/L+8xC6QpvelRLA3lWFM+x5IOwpdg+bmcknxBDP6wYd9ayySNxp38bWVrwdtuTuMRKWv4YDWQz0l8nIN1bxsklBu4IAO75zo0xnaru0wvFqiUGwXN/FldcGrKWZ9cy9sDmEA7BSpxNqP1BeMI5LBZke8IPEsaeUPi2coqdQ=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0503.namprd15.prod.outlook.com (10.163.110.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 21:51:55 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 21:51:55 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Roman Gushchin" <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
Thread-Topic: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
Thread-Index: AQHUb9GbG27ZhPtkmkCI4HpK7bnl7w==
Date:   Mon, 29 Oct 2018 21:51:55 +0000
Message-ID: <20181029215123.17830-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:ad5c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0503;20:bmlRoVRMsAVb/Hz3Y58b3Lb76y828+jUFrnvIXeXM+ADH2UAVL89FsOG5g21kQaeRMbdp4hP7XO45SL4vWAESHLv/c2g8oJ2JEYkOi6M5Txe6/Zl26lGD9Lqt4Cq3BqBzmezMaF5TnTDGXhujiBSfPtuiKrcfJX1YNsifG6PIII=
x-ms-office365-filtering-correlation-id: 5d8dd020-436d-4119-e924-08d63de8be33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0503;
x-ms-traffictypediagnostic: BY2PR15MB0503:
x-microsoft-antispam-prvs: <BY2PR15MB0503F99CF638DED94769AE63BEF30@BY2PR15MB0503.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(67672495146484)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0503;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0503;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(14444005)(97736004)(1076002)(5640700003)(6486002)(6436002)(386003)(6506007)(8936002)(53936002)(81156014)(6916009)(102836004)(2501003)(5250100002)(6512007)(39060400002)(4326008)(256004)(2906002)(54906003)(71200400001)(71190400001)(478600001)(81166006)(6116002)(316002)(25786009)(52116002)(14454004)(7736002)(5660300001)(186003)(36756003)(2616005)(46003)(486006)(2900100001)(1857600001)(305945005)(86362001)(476003)(575784001)(106356001)(2351001)(105586002)(68736007)(99286004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0503;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3NiTYMkL3b/2fdZbZOnqPqeq+OlWebL9HfS114qgrypoxDh1R5rEb14qGVnNxeQGD8w6GKLrTu8qhZvKyCAyLS6//uQkJX1CP7wz2YVg22SU6ft9QQ0xwLg1v6aNwCctwKAVkk6s8ZGlQ/Y7HNV72OB9oMBSpCZxM0Xwvh9gXIDLMpRXJf0/LOc43dpmB9qa9/6C8ejGiw8OiGSZTyOTIac7mAl0IoarLYOAxE2aLl3hVy3pk7Ft9e70If5IELWXdxzcVpLWKxAa2DeSI6ySk2/ScinRa9/6rx8G6ZkmuF9JnRgYLPiEBMYRnfruWbWrJIjNxa0zKx1PdMvHdzaKl7BRaTbLbSIUbmvm1UQTvC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8dd020-436d-4119-e924-08d63de8be33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 21:51:55.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith reported a regression caused by the commit 9b6f7e163cd0
("mm: rework memcg kernel stack accounting") on a system with
"cgroup_disable=3Dmemory" boot option: the system panics with the
following stack trace:

  [0.928542] BUG: unable to handle kernel NULL pointer dereference at 00000=
000000000f8
  [0.929317] PGD 0 P4D 0
  [0.929573] Oops: 0002 [#1] PREEMPT SMP PTI
  [0.929984] CPU: 0 PID: 1 Comm: systemd Not tainted 4.19.0-preempt+ #410
  [0.930637] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-=
20180531_142017-buildhw-08.phx2.fed4
  [0.931862] RIP: 0010:page_counter_try_charge+0x22/0xc0
  [0.932376] Code: 41 5d c3 c3 0f 1f 40 00 0f 1f 44 00 00 48 85 ff 0f 84 a7=
 00 00 00 41 56 48 89 f8 49 89 fe 49
  [0.934283] RSP: 0018:ffffacf68031fcb8 EFLAGS: 00010202
  [0.934826] RAX: 00000000000000f8 RBX: 0000000000000000 RCX: 0000000000000=
000
  [0.935558] RDX: ffffacf68031fd08 RSI: 0000000000000020 RDI: 0000000000000=
0f8
  [0.936288] RBP: 0000000000000001 R08: 8000000000000063 R09: ffff99ff7cd37=
a40
  [0.937021] R10: ffffacf68031fed0 R11: 0000000000200000 R12: 0000000000000=
020
  [0.937749] R13: ffffacf68031fd08 R14: 00000000000000f8 R15: ffff99ff7da1e=
c60
  [0.938486] FS:  00007fc2140bb280(0000) GS:ffff99ff7da00000(0000) knlGS:00=
00000000000000
  [0.939311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [0.939905] CR2: 00000000000000f8 CR3: 0000000012dc8002 CR4: 0000000000760=
ef0
  [0.940638] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000=
000
  [0.941366] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000=
400
  [0.942110] PKRU: 55555554
  [0.942412] Call Trace:
  [0.942673]  try_charge+0xcb/0x780
  [0.943031]  memcg_kmem_charge_memcg+0x28/0x80
  [0.943486]  ? __vmalloc_node_range+0x1e4/0x280
  [0.943971]  memcg_kmem_charge+0x8b/0x1d0
  [0.944396]  copy_process.part.41+0x1ca/0x2070
  [0.944853]  ? get_acl+0x1a/0x120
  [0.945200]  ? shmem_tmpfile+0x90/0x90
  [0.945596]  _do_fork+0xd7/0x3d0
  [0.945934]  ? trace_hardirqs_off_thunk+0x1a/0x1c
  [0.946421]  do_syscall_64+0x5a/0x180
  [0.946798]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The problem occurs because get_mem_cgroup_from_current() returns
the NULL pointer if memory controller is disabled. Let's check
if this is a case at the beginning of memcg_kmem_charge() and
just return 0 if mem_cgroup_disabled() returns true. This is how
we handle this case in many other places in the memory controller
code.

Fixes: 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 54920cbc46bf..6e1469b80cb7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2593,7 +2593,7 @@ int memcg_kmem_charge(struct page *page, gfp_t gfp, i=
nt order)
 	struct mem_cgroup *memcg;
 	int ret =3D 0;
=20
-	if (memcg_kmem_bypass())
+	if (mem_cgroup_disabled() || memcg_kmem_bypass())
 		return 0;
=20
 	memcg =3D get_mem_cgroup_from_current();
--=20
2.17.2

