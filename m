Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90807C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528320664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GEuOsXEg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FGaSrDsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4528320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJaAuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:50:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbeJaAuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:50:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UFng80017576;
        Tue, 30 Oct 2018 08:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b71L34CoXIYEv2cPXhcYYG6pTz2pF9ECb1wMqU90muI=;
 b=GEuOsXEgXqi4uXQO6dCHGz7GGV7mtMscNYKS2pwMgvQPG2ULgWxO9RRbtAUnN3oisjF0
 ImIBJD259vHbI4Ke3YH8AYHnoG5pPIyfKHGskIeYbKUAHzUMljRm2fOQPjf7KOeOv1Pe
 sw8XSpyyA1oHkBfPp7wXW9Va6z+lEj4/PFM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nerykgadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Oct 2018 08:56:02 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 30 Oct 2018 08:55:46 -0700
Received: from FRC-CHUB11.TheFacebook.com (2620:10d:c021:18::30) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 30 Oct 2018 08:55:46 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 30 Oct 2018 11:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b71L34CoXIYEv2cPXhcYYG6pTz2pF9ECb1wMqU90muI=;
 b=FGaSrDsBfMHbMCAmVCpD8huUR9YqbxLauz1X9AQVed+khBdgM2+4MZUeZ+kAFDHOYTaKr5iII7o89q98wZN5R0zI5V7ghT37PLrikzrbTckQLBAt5Pm8PH4IdhWGFZHLOhNCNdQ/UxZPVkoiR38lnF2SeJ+C2+I7wRjqd5ezFwU=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0757.namprd15.prod.outlook.com (10.164.171.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Tue, 30 Oct 2018 15:55:39 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 15:55:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
Thread-Topic: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
Thread-Index: AQHUb9GbG27ZhPtkmkCI4HpK7bnl76U3T4eAgACi0oA=
Date:   Tue, 30 Oct 2018 15:55:39 +0000
Message-ID: <20181030155532.GA17612@tower.DHCP.thefacebook.com>
References: <20181029215123.17830-1-guro@fb.com>
 <20181030061249.GS32673@dhcp22.suse.cz>
In-Reply-To: <20181030061249.GS32673@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:6ec5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0757;20:sHYLYwciFVhWznA8nxHO/y2YvRVk5GL/dHVMNfsTreWXhZBidGmsVlvjMe7BUo/eKwdYOhx8VfB19m0n/1DZJIYAgVERxg47P+/jD2XLZ8rTRJt0bnHqW7CzZRuqMbC/r4He+c3ngQqurIR6Kdql7hK2xkuaCYaF36Y6W4VDlBE=
x-ms-office365-filtering-correlation-id: 4df56083-3764-48f7-8636-08d63e80235a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0757;
x-ms-traffictypediagnostic: BY2PR15MB0757:
x-microsoft-antispam-prvs: <BY2PR15MB0757184FF9A0B4F95CB684A6BECC0@BY2PR15MB0757.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(67672495146484)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0757;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0757;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(346002)(366004)(52314003)(189003)(199004)(5660300001)(33656002)(76176011)(52116002)(8676002)(316002)(6436002)(5250100002)(99286004)(305945005)(102836004)(68736007)(2906002)(2900100001)(1076002)(33896004)(6506007)(229853002)(7736002)(81156014)(8936002)(81166006)(386003)(14454004)(54906003)(6486002)(476003)(97736004)(6116002)(46003)(486006)(11346002)(446003)(71200400001)(71190400001)(106356001)(478600001)(6512007)(53936002)(39060400002)(6246003)(186003)(256004)(4326008)(575784001)(9686003)(6916009)(14444005)(25786009)(86362001)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0757;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i7QzbhQ+HqUpJ4b4hiMMTbY3N+WIGI/+Xuz2KtpFjsIltMbcPh+6S+hwPgWEAguUnGoB9jv/ZJyJlXT/8SVHTk3pzvCFdf5SWLuXwYp1lG1VFA10sypacIflsivf1NpjuJjZmUJjUV5bWpgloA0NCousar6plQp9LEpZRiel291OWDRAh9tdSIdCobj+znTFbJ114NeJ1maBcoxI2cZLROeRT6q6hTOUpeTfGHhQcJftRdKrpHwokT/mJOfhp5PuJMMHzlKGlxuZweGt6LucZDwkqNNS9Q48nSD3KsJMy58LhulpmnrKkFZnG2pw4E5p+xn5XvtC0l+/FQIBpXKJzlOoshj72EGVol0WhNqEyJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65515EED1E43F74C8166BE9C00A911E0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df56083-3764-48f7-8636-08d63e80235a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 15:55:39.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 07:12:49AM +0100, Michal Hocko wrote:
> On Mon 29-10-18 21:51:55, Roman Gushchin wrote:
> > Mike Galbraith reported a regression caused by the commit 9b6f7e163cd0
> > ("mm: rework memcg kernel stack accounting") on a system with
> > "cgroup_disable=3Dmemory" boot option: the system panics with the
> > following stack trace:
> >=20
> >   [0.928542] BUG: unable to handle kernel NULL pointer dereference at 0=
0000000000000f8
> >   [0.929317] PGD 0 P4D 0
> >   [0.929573] Oops: 0002 [#1] PREEMPT SMP PTI
> >   [0.929984] CPU: 0 PID: 1 Comm: systemd Not tainted 4.19.0-preempt+ #4=
10
> >   [0.930637] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20180531_142017-buildhw-08.phx2.fed4
> >   [0.931862] RIP: 0010:page_counter_try_charge+0x22/0xc0
> >   [0.932376] Code: 41 5d c3 c3 0f 1f 40 00 0f 1f 44 00 00 48 85 ff 0f 8=
4 a7 00 00 00 41 56 48 89 f8 49 89 fe 49
> >   [0.934283] RSP: 0018:ffffacf68031fcb8 EFLAGS: 00010202
> >   [0.934826] RAX: 00000000000000f8 RBX: 0000000000000000 RCX: 000000000=
0000000
> >   [0.935558] RDX: ffffacf68031fd08 RSI: 0000000000000020 RDI: 000000000=
00000f8
> >   [0.936288] RBP: 0000000000000001 R08: 8000000000000063 R09: ffff99ff7=
cd37a40
> >   [0.937021] R10: ffffacf68031fed0 R11: 0000000000200000 R12: 000000000=
0000020
> >   [0.937749] R13: ffffacf68031fd08 R14: 00000000000000f8 R15: ffff99ff7=
da1ec60
> >   [0.938486] FS:  00007fc2140bb280(0000) GS:ffff99ff7da00000(0000) knlG=
S:0000000000000000
> >   [0.939311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [0.939905] CR2: 00000000000000f8 CR3: 0000000012dc8002 CR4: 000000000=
0760ef0
> >   [0.940638] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> >   [0.941366] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> >   [0.942110] PKRU: 55555554
> >   [0.942412] Call Trace:
> >   [0.942673]  try_charge+0xcb/0x780
> >   [0.943031]  memcg_kmem_charge_memcg+0x28/0x80
> >   [0.943486]  ? __vmalloc_node_range+0x1e4/0x280
> >   [0.943971]  memcg_kmem_charge+0x8b/0x1d0
> >   [0.944396]  copy_process.part.41+0x1ca/0x2070
> >   [0.944853]  ? get_acl+0x1a/0x120
> >   [0.945200]  ? shmem_tmpfile+0x90/0x90
> >   [0.945596]  _do_fork+0xd7/0x3d0
> >   [0.945934]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> >   [0.946421]  do_syscall_64+0x5a/0x180
> >   [0.946798]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >=20
> > The problem occurs because get_mem_cgroup_from_current() returns
> > the NULL pointer if memory controller is disabled. Let's check
> > if this is a case at the beginning of memcg_kmem_charge() and
> > just return 0 if mem_cgroup_disabled() returns true. This is how
> > we handle this case in many other places in the memory controller
> > code.
> >=20
> > Fixes: 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
>=20
> I tend to agree with Shakeel that consistency with the other caller
> would be less confusing.

I totally agree that consistency is a thing here (and everywhere),
however using memcg_kmem_enabled() here is not consistent at all.
memcg_kmem_enabled() is tight to the slab allocation accounting,
but here we have a different type of allocation: we actually charge
an area preallocated using vmalloc.

> I would split the function to __memcg_kmem_charge
> without any checks and call it from __alloc_pages_nodemask and add the
> check to memcg_kmem_charge. This would be less confusing I guess.
> Something for a follow up clean up though.

Sure. Alternatively, we can check the pointer returned by
get_mem_cgroup_from_current() in memcg_kmem_charge().

Anyway, let's postpone this clean up a bit, now the main goal
is to fix the panic.

> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

--

Andrew, can you, please, pull this patch to 4.20-rc1 or -rc2?
It has been acked by Rik and Michal, and tested by Mike.

Thanks!
