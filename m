Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494449-2-4301912137914950655
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
    t=1521494448; b=BEpT1wZj7fkxZ4x/6vEh3QQbxYlaLSKEb7eoFBHY/VFE4f/
    fv4AoE2dPEANDjh0k/ypbJ0r3cI56vIbou6p+DyAVPsGReWLHgqtngcQBtdg4sI6
    VLhEbKkdbUUl2Ed5Ux4NZ12qBb4ki0h/vOtSUVQxVM76Mk0Hr1FKdP5aksyjI/Cb
    4lTHZHqErWjPzj4RcgGMd2sY2pnSaAu5Esr2KKPBM1pZu6mm1TsbAVNrOXlbIwSy
    wD8ZA3WtzmbYjaL1QJ0DDgXAw+16B0YnEBfdsDE5hN3xKHW3uBhSUKdQkzL9bgtu
    /GUG5uqU6/4J/6FS95qqSMBetaujFwvZQtkcy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494448; bh=bkbpa4
    eRjpPUV5Wudwky0btqFwjguUNYXxsNzymyInY=; b=l9N12jGnL45nNsQYkhPl8z
    IyghyA8QXaoWIkU31SGFo/fUO0BpzZXCQxo1DeI0nqkGpHaaSv6CTQ+xjI0ABp0t
    hoILjxoGtIJ0HHUGDIt6MyRcGK47HOol1+7gQjF2faDSMvRhGe765eqOnuM+fKcJ
    HI7r3yIYg9YTcWROvnt5RoDQ6v0i0m8hwShs6vd56BYvLARcPEmw+t9GOzLM8ir5
    4ZBwEt7zZ9+2w8Vy1KVpr4f2N21/NHtUmhCsrWuQoJ7idUGmAl0iX/fKB+REHpaQ
    Ou9+z/u5cAZztWcGDQq+5G5wWdMbkPYHE34SJiCPQJf3pxXGNdeIiv7EcQbL7PGw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g+xSR8ar x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g+xSR8ar x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934858AbeCSQAv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:51 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:3840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965251AbeCSQAq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 094/281] sched/numa: Use down_read_trylock()
 for the mmap_sem
Thread-Topic: [PATCH AUTOSEL for 4.9 094/281] sched/numa: Use
 down_read_trylock() for the mmap_sem
Thread-Index: AQHTv5tL0U6hupvRSUCrca60+YWAeA==
Date: Mon, 19 Mar 2018 15:59:44 +0000
Message-ID: <20180319155742.13731-94-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:02pSjYDgFGYmpNfjMVX0aC6wnyKAYwtHVMqDau5Zs+0Ubf8jlzdIoclrbmVbDtzo13UI7uHojhBex1RNCrfy5MLUk2t9A6g3GUTLc60a8jxVt1QR/Hze9ss9MnXsVsiE2fphyRc0yZ2DG84MYkb2Hef9Vd1Iip6y86pqkRiXmE+k66ZJ6tLlfUkpdNJaBiThFXRQdCK0QVZOb2wITxU+7z4rvp3cKHT4FCaFFMRlk4pRAaLGn50J9MBeOxC9pHnK;20:h7hUQU/6YyrYugrFWFMmqABYDCJjzm90+DEi0m070E8OavZgHUAGT9SfsXLAk1DM6GFoCjyGYBZ2qztmAE3QkkbujI+rvrbsVhGecytrePVY1/iRp0ULSI4attc4oAEViBp0Fpo8qQOtAbvD4v5z6OweJQHS930PVsnQ8GCCOEg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4b32d60-3be4-4780-a1ff-08d58db290a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933BEDD0F5F4353013E9F69FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: g6bn251KjORr0yZdeRBlLRB5pRs/pN+kdeIdHyRBuslnaNSFJWeagA2rtjBsf88hNyjLlN4qm6RlcZvY9vVAKEpKBoZ0DaR2ZEBJhhjKcCJXxdgT1fYlBeSTKQ1CUXkVgcZSOcvBUeraOL4TqYtorsD2iId/maihu42Y9BXKGraU5HZJmcgswkdMcH2YcRqBS67kyHs6iQfbX0kwsHuJgauA1CKG5Yi2uo5CupkFHQQ/8JVyFkp0T35e05iGJEz6UNI5yANWEe6qHMVC4egwYgFtLGPiNv6QFqI1DhDTSzvzTdHc3tZGpr3PrrgCCGxAAFpPdtwXXfDglPPLN3RyRA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b32d60-3be4-4780-a1ff-08d58db290a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:44.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 8655d5497735b288f8a9b458bd22e7d1bf95bb61 ]

A customer has reported a soft-lockup when running an intensive
memory stress test, where the trace on multiple CPU's looks like this:

 RIP: 0010:[<ffffffff810c53fe>]
  [<ffffffff810c53fe>] native_queued_spin_lock_slowpath+0x10e/0x190
...
 Call Trace:
  [<ffffffff81182d07>] queued_spin_lock_slowpath+0x7/0xa
  [<ffffffff811bc331>] change_protection_range+0x3b1/0x930
  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
  [<ffffffff81098322>] task_work_run+0x72/0x90

Further investigation showed that the lock contention here is pmd_lock().

The task_numa_work() function makes sure that only one thread is let to per=
form
the work in a single scan period (via cmpxchg), but if there's a thread wit=
h
mmap_sem locked for writing for several periods, multiple threads in
task_numa_work() can build up a convoy waiting for mmap_sem for read and th=
en
all get unblocked at once.

This patch changes the down_read() to the trylock version, which prevents t=
he
build up. For a workload experiencing mmap_sem contention, it's probably be=
tter
to postpone the NUMA balancing work anyway. This seems to have fixed the so=
ft
lockups involving pmd_lock(), which is in line with the convoy theory.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@redhat.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170515131316.21909-1-vbabka@suse.cz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d862f5b0331..f6e8727f7fa3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2429,7 +2429,8 @@ void task_numa_work(struct callback_head *work)
 		return;
=20
=20
-	down_read(&mm->mmap_sem);
+	if (!down_read_trylock(&mm->mmap_sem))
+		return;
 	vma =3D find_vma(mm, start);
 	if (!vma) {
 		reset_ptenuma_scan(p);
--=20
2.14.1
