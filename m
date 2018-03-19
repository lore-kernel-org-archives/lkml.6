Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480207-2-8707308401234986622
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
    t=1521480206; b=MErIPJB3ty89zp+zvL5lx2DLzhkQ3qYlGDFOdRVBsctucOW
    GhO5lT/NN/ruLZj5fmNLF+V8EoyqbCH7coiILhsTV4Uf+hX9B89cU0zOvaujApos
    9SQ+YP3FupPGeUOUw5WZJqO/PUtM+uFVQnKmotg3cHhEbl1rKyLsPKyigxC52IJB
    9ZxPJc/+iNmPwRO4/p6QUof1jLzX/UfXFn2DU+ZXhrwRLbtoQVFYT06rSePGR5Vq
    u3fizywyPbTWUQAGLAd4Vx89WnLYzdSXyivaeI+FlIY/foyXiESTeTKX9WtKpBHv
    0pnVj//x8t5qTjOb1g86hmVvHWJF/upsMKx+4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480206; bh=XYUFjL
    FzxNxoAlmknChKjeITo88uZ7s4EG/o0vPPstk=; b=DWfKPBCpnwb/h+bB2Zj+LM
    zCQnjAH6tqUnfYE2RrjDVdSMbTEiWy+ssPROiQgNdX/0f4H7FizDJsxhog7GcUtZ
    ILAXTAA4Ob667W5mKZgKilfdkL0GqOZC9b00Fo3GTR+EoEPzIEF744WJl121MqOc
    QFxz7mp4QcO90FWTLd7me7ljRadqIwIo/aUe/0nVrm1ZUwipshv5jr9YfNuipEbc
    hf0jDom7FnRRL5zC7kruNzFkwcklwsWoWGkAqrtrWH36dmBpVRx2bCuv5lvFzEPD
    aq8ThuTrAUc1KLanAH/YIDg3/IM/Z2EiPTE8xvvo4upVLDtVDP1gJ7VceeV7nArg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d8QrPnrW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehheegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d8QrPnrW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehheegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966031AbeCSRXT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:23:19 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:45505
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966379AbeCSQI7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 063/167] sched/numa: Use down_read_trylock()
 for the mmap_sem
Thread-Topic: [PATCH AUTOSEL for 4.4 063/167] sched/numa: Use
 down_read_trylock() for the mmap_sem
Thread-Index: AQHTv5xDLpnoj7RWs0y+Tn4wFyDLtA==
Date: Mon, 19 Mar 2018 16:06:40 +0000
Message-ID: <20180319160513.16384-63-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:mWu3cwwj91IcMWfv/mQQ6YBSCqIikiHYJbODy39GgbVj/Ut1NDvwC/BPBsN6Pa3WWCmzTTgZUihfGUMKniQshq6Ac97nwXbpkdCbXtp2QlYua52jSHMeTZr/WG5MT/vCa5Ox7HAeAmASSsfEfE87jwWXnmA8eDnObiuQq8KeqmhJQIE/Sr2OwB2SBPNxN3Ai9MyZjohrwVY8GWhKcxty/cXBYJIBGHvBnRpenO3fC4TkMdAwFWeNWA6uwrzLZKQ8;20:EQGfbfaAiiNfSieVFGqCc2rGB0J8USXxuxIXwGKCl40HgvoH0SNPOhHvfiCgHtPCzZxvOBRMaLVwcl+eFZrxTsho/v1YRd0kxWg7mkTrqkn9nbtpQm1VkjRDXvNKIRXVg/KM7LhoRAxMIf4efsXdkUvf1WsEc3T/Vi4k1D8Z/pk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61609005-fabf-4cf5-db6f-08d58db3b71f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965EB1AC45B0883040974D0FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(966005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(6306002)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LU/eJ6doMP7S3BKxuiN7I+5gfxlGf/GrI5TWpKLJxUcP95j7x9paLXCxRx1RRqH8mHfZBZjTqe8PRB1xKMZFgDuM8xcH/tAm6M0WNlaaQ3LxUlpk0o8yaDROv7n3ZxiiBK9Hsko5AawaFdrr9SdjVNuD0/tKmhDf/JWCks3a3fe70W/5bFNzjytkUlJX06AfZTaDnBHObDJYs/3Mng8mucqAhe4JSY3lKjkwTnIitJ0y1b76JFqgcwB1vCOeYQ/6NjXqcoUzlYBhWu4j+jZLuBl+1o+rbxWhMCL0pQmNKC3VeGbxaSMA3yTFgaHnEoTRqiMqVC3hzp1OtqmpYgkMWA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61609005-fabf-4cf5-db6f-08d58db3b71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:40.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
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
index 812069b66f47..3b136fb4422c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2223,7 +2223,8 @@ void task_numa_work(struct callback_head *work)
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
