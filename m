Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481986-2-15356003975095605580
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
    t=1521481984; b=RnQi8QzK6asXEQV3HpPVBn4SRR3nvvIjVk95LUFtnzmK1IB
    +p3fCORjDzAyWMTfEya4+GqEL5dD20wxCbHBdD4JdjVeUGXhlu4X9Fug5W9mRZ/F
    FPU1iFM4M0v9Akk98preCG6Xwa8z+ESb29PyfBBtEL8UVrrXeQToQR9rfWqNfsgF
    lC72hh4l/mcZANPiw4yUSSfudnvRJHRSFXNFUhRaA5aEeJVQhu+BvEGSiHD7PEyv
    qq/o27dsN8Egk3RTH3WvB14rRfdxmyP8mVk0xnUyAuOGd/aNASy1Dal62MiAPv6c
    AfuJwi/CRviuzCQeqDIt6y4HPxsFpD+np4jROCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481984; bh=GiqFUh
    4H1hm9kLlACtsAV83Ufckp8vbYyE35+pxf6m4=; b=oxrm1jixz6JNQVrxGZtBGm
    UU6+N8PxdX7MFdUi8klJWBj48fsj6LbObWE7fNyn3SlVRJLmyoYbmm5PpGCoCdPO
    wPClTAcqYYFYb0rDNOsBhLY4pBtEWP7WGfPQydRdBdCjH4B2LVFoS4jSK0OPPhI9
    Fs04/nDHClpUR3ujmEBUowIwgPGJqo6asq7c4L3R8/9U98n8IU53BOXSlOQGuJSk
    OSioFKTPfWYaDN0rX95kG9nj3fuPCxYXMg9trStVJesEGhdV3phTCCA9KUSQ6kkj
    Yt/McjEfrtlXeLHRzDJGjGv6gPcjBzK16fRX8vnrLt65EW/ukhxg0N/X/54nvwFQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j9lk25lT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudektddtudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j9lk25lT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudektddtudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968235AbeCSRw5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:52:57 -0400
Received: from mail-dm3nam03on0105.outbound.protection.outlook.com ([104.47.41.105]:45007
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965708AbeCSQEv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Mike Galbraith <efault@gmx.de>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 222/281] sched/deadline: Use the revised
 wakeup rule for suspending constrained dl tasks
Thread-Topic: [PATCH AUTOSEL for 4.9 222/281] sched/deadline: Use the revised
 wakeup rule for suspending constrained dl tasks
Thread-Index: AQHTv5unJKaDES8Xl02ZIXSH3SKKSg==
Date: Mon, 19 Mar 2018 16:02:16 +0000
Message-ID: <20180319155742.13731-222-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:Ayp+bkM5ZTsu2jHR7MxTI+BhtGeL+uvF7RQ+vMg995iKoMdk9kZ6jOxr0jTV89LNbeYJqAuN2l6TQfFhQkPiVxsxShpQ3JXxjsf9E4DWCUHW//sair0pi3oStGPX0siypTHLDFWoXR2cWFI2qt0pibozkwR/qIT8EitcLst2CNrvyg4Z+9DauEHqeoNO+qqiUCLhtNMjTxY4k4mjsSSTrVcolpk6f9wdmJd3gieK+2QDeX6LLScCiwpXP8JsoWPg;20:Ou3OUxjqDIt/jiHfsFUmfHR88h707Uj3kv2mvssSVf/NK2FKrQKFMPzHbXabbers/HQ+SSYYp1nsxPZXE1UXH3mkUpjTgXkFYHTuWeUSW71BI7i7kHMdiX/iyp0XdNYd8nFcPvD6ciJa06+MU9/xqXYmVPH4w8T9aGlVL/xjxHU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b210ef12-f6cb-4293-815e-08d58db321b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08052616225657C8D6B0EED7FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(180628864354917)(26323138287068)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(8666007)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(10710500007)(8936002)(2420400007)(7416002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(15650500001)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mc/M3esVMlpkdoD5c9Xl0YUyZHbhKzRvLxG/xG/HuE+/ZAfs+xvORnPy5mvC3hQJz8TJD5CJB0bXOUR92MNtlD4bd2wIH/lQxOC2L3ZvwDn01Hbbpn6cblYjQEtxKc569NCILUqFgRcyuKU78uxVTDaNIA274D9Ki8kioeRAt7ftOGYiT88hLE+hhoB5hqo55pMEKd3O7q8Rz/fYnVGfpuDfsYcAo5lHRjIn19MkID11pIHdRsvjy6Bx40Yl7cGX4obkH65Sasu1idKrszW+q5v5xb+IBPPokjLB3EtEEqtJecoOokuhbahJNsfRJ9OZluwXXSfc/xd3D+L5wl+XEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b210ef12-f6cb-4293-815e-08d58db321b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:16.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Bristot de Oliveira <bristot@redhat.com>

[ Upstream commit 3effcb4247e74a51f5d8b775a1ee4abf87cc089a ]

We have been facing some problems with self-suspending constrained
deadline tasks. The main reason is that the original CBS was not
designed for such sort of tasks.

One problem reported by Xunlei Pang takes place when a task
suspends, and then is awakened before the deadline, but so close
to the deadline that its remaining runtime can cause the task
to have an absolute density higher than allowed. In such situation,
the original CBS assumes that the task is facing an early activation,
and so it replenishes the task and set another deadline, one deadline
in the future. This rule works fine for implicit deadline tasks.
Moreover, it allows the system to adapt the period of a task in which
the external event source suffered from a clock drift.

However, this opens the window for bandwidth leakage for constrained
deadline tasks. For instance, a task with the following parameters:

  runtime   =3D 5 ms
  deadline  =3D 7 ms
  [density] =3D 5 / 7 =3D 0.71
  period    =3D 1000 ms

If the task runs for 1 ms, and then suspends for another 1ms,
it will be awakened with the following parameters:

  remaining runtime =3D 4
  laxity =3D 5

presenting a absolute density of 4 / 5 =3D 0.80.

In this case, the original CBS would assume the task had an early
wakeup. Then, CBS will reset the runtime, and the absolute deadline will
be postponed by one relative deadline, allowing the task to run.

The problem is that, if the task runs this pattern forever, it will keep
receiving bandwidth, being able to run 1ms every 2ms. Following this
behavior, the task would be able to run 500 ms in 1 sec. Thus running
more than the 5 ms / 1 sec the admission control allowed it to run.

Trying to address the self-suspending case, Luca Abeni, Giuseppe
Lipari, and Juri Lelli [1] revisited the CBS in order to deal with
self-suspending tasks. In the new approach, rather than
replenishing/postponing the absolute deadline, the revised wakeup rule
adjusts the remaining runtime, reducing it to fit into the allowed
density.

A revised version of the idea is:

At a given time t, the maximum absolute density of a task cannot be
higher than its relative density, that is:

  runtime / (deadline - t) <=3D dl_runtime / dl_deadline

Knowing the laxity of a task (deadline - t), it is possible to move
it to the other side of the equality, thus enabling to define max
remaining runtime a task can use within the absolute deadline, without
over-running the allowed density:

  runtime =3D (dl_runtime / dl_deadline) * (deadline - t)

For instance, in our previous example, the task could still run:

  runtime =3D ( 5 / 7 ) * 5
  runtime =3D 3.57 ms

Without causing damage for other deadline tasks. It is note worthy
that the laxity cannot be negative because that would cause a negative
runtime. Thus, this patch depends on the patch:

  df8eac8cafce ("sched/deadline: Throttle a constrained deadline task activ=
ated after the deadline")

Which throttles a constrained deadline task activated after the
deadline.

Finally, it is also possible to use the revised wakeup rule for
all other tasks, but that would require some more discussions
about pros and cons.

Reported-by: Xunlei Pang <xpang@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
[peterz: replaced dl_is_constrained with dl_is_implicit]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Link: http://lkml.kernel.org/r/5c800ab3a74a168a84ee5f3f84d12a02e11383be.149=
5803804.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/sched.h   |  1 +
 kernel/sched/core.c     |  2 +
 kernel/sched/deadline.c | 98 +++++++++++++++++++++++++++++++++++++++++++--=
----
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4d0afc009a7..c549c8c9245c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1412,6 +1412,7 @@ struct sched_dl_entity {
 	u64 dl_deadline;	/* relative deadline of each instance	*/
 	u64 dl_period;		/* separation of two instances (period) */
 	u64 dl_bw;		/* dl_runtime / dl_deadline		*/
+	u64 dl_density;		/* dl_runtime / dl_deadline		*/
=20
 	/*
 	 * Actual scheduling parameters. Initialized with the values above,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bce3a7ad4253..2dd9ad72f543 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2183,6 +2183,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_period =3D 0;
 	dl_se->flags =3D 0;
 	dl_se->dl_bw =3D 0;
+	dl_se->dl_density =3D 0;
=20
 	dl_se->dl_throttled =3D 0;
 	dl_se->dl_yielded =3D 0;
@@ -3911,6 +3912,7 @@ __setparam_dl(struct task_struct *p, const struct sch=
ed_attr *attr)
 	dl_se->dl_period =3D attr->sched_period ?: dl_se->dl_deadline;
 	dl_se->flags =3D attr->sched_flags;
 	dl_se->dl_bw =3D to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	dl_se->dl_density =3D to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
=20
 	/*
 	 * Changing the parameters of a task is 'tricky' and we're not doing
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3042881169b4..3042927c8b8a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -484,13 +484,84 @@ static bool dl_entity_overflow(struct sched_dl_entity=
 *dl_se,
 }
=20
 /*
- * When a -deadline entity is queued back on the runqueue, its runtime and
- * deadline might need updating.
+ * Revised wakeup rule [1]: For self-suspending tasks, rather then
+ * re-initializing task's runtime and deadline, the revised wakeup
+ * rule adjusts the task's runtime to avoid the task to overrun its
+ * density.
  *
- * The policy here is that we update the deadline of the entity only if:
- *  - the current deadline is in the past,
- *  - using the remaining runtime with the current deadline would make
- *    the entity exceed its bandwidth.
+ * Reasoning: a task may overrun the density if:
+ *    runtime / (deadline - t) > dl_runtime / dl_deadline
+ *
+ * Therefore, runtime can be adjusted to:
+ *     runtime =3D (dl_runtime / dl_deadline) * (deadline - t)
+ *
+ * In such way that runtime will be equal to the maximum density
+ * the task can use without breaking any rule.
+ *
+ * [1] Luca Abeni, Giuseppe Lipari, and Juri Lelli. 2015. Constant
+ * bandwidth server revisited. SIGBED Rev. 11, 4 (January 2015), 19-24.
+ */
+static void
+update_dl_revised_wakeup(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	u64 laxity =3D dl_se->deadline - rq_clock(rq);
+
+	/*
+	 * If the task has deadline < period, and the deadline is in the past,
+	 * it should already be throttled before this check.
+	 *
+	 * See update_dl_entity() comments for further details.
+	 */
+	WARN_ON(dl_time_before(dl_se->deadline, rq_clock(rq)));
+
+	dl_se->runtime =3D (dl_se->dl_density * laxity) >> 20;
+}
+
+/*
+ * Regarding the deadline, a task with implicit deadline has a relative
+ * deadline =3D=3D relative period. A task with constrained deadline has a
+ * relative deadline <=3D relative period.
+ *
+ * We support constrained deadline tasks. However, there are some restrict=
ions
+ * applied only for tasks which do not have an implicit deadline. See
+ * update_dl_entity() to know more about such restrictions.
+ *
+ * The dl_is_implicit() returns true if the task has an implicit deadline.
+ */
+static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_deadline =3D=3D dl_se->dl_period;
+}
+
+/*
+ * When a deadline entity is placed in the runqueue, its runtime and deadl=
ine
+ * might need to be updated. This is done by a CBS wake up rule. There are=
 two
+ * different rules: 1) the original CBS; and 2) the Revisited CBS.
+ *
+ * When the task is starting a new period, the Original CBS is used. In th=
is
+ * case, the runtime is replenished and a new absolute deadline is set.
+ *
+ * When a task is queued before the begin of the next period, using the
+ * remaining runtime and deadline could make the entity to overflow, see
+ * dl_entity_overflow() to find more about runtime overflow. When such cas=
e
+ * is detected, the runtime and deadline need to be updated.
+ *
+ * If the task has an implicit deadline, i.e., deadline =3D=3D period, the=
 Original
+ * CBS is applied. the runtime is replenished and a new absolute deadline =
is
+ * set, as in the previous cases.
+ *
+ * However, the Original CBS does not work properly for tasks with
+ * deadline < period, which are said to have a constrained deadline. By
+ * applying the Original CBS, a constrained deadline task would be able to=
 run
+ * runtime/deadline in a period. With deadline < period, the task would
+ * overrun the runtime/period allowed bandwidth, breaking the admission te=
st.
+ *
+ * In order to prevent this misbehave, the Revisited CBS is used for
+ * constrained deadline tasks when a runtime overflow is detected. In the
+ * Revisited CBS, rather than replenishing & setting a new absolute deadli=
ne,
+ * the remaining runtime of the task is reduced to avoid runtime overflow.
+ * Please refer to the comments update_dl_revised_wakeup() function to fin=
d
+ * more about the Revised CBS rule.
  */
 static void update_dl_entity(struct sched_dl_entity *dl_se,
 			     struct sched_dl_entity *pi_se)
@@ -500,6 +571,14 @@ static void update_dl_entity(struct sched_dl_entity *d=
l_se,
=20
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
+
+		if (unlikely(!dl_is_implicit(dl_se) &&
+			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
+			     !dl_se->dl_boosted)){
+			update_dl_revised_wakeup(dl_se, rq);
+			return;
+		}
+
 		dl_se->deadline =3D rq_clock(rq) + pi_se->dl_deadline;
 		dl_se->runtime =3D pi_se->dl_runtime;
 	}
@@ -961,11 +1040,6 @@ static void dequeue_dl_entity(struct sched_dl_entity =
*dl_se)
 	__dequeue_dl_entity(dl_se);
 }
=20
-static inline bool dl_is_constrained(struct sched_dl_entity *dl_se)
-{
-	return dl_se->dl_deadline < dl_se->dl_period;
-}
-
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flag=
s)
 {
 	struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
@@ -997,7 +1071,7 @@ static void enqueue_task_dl(struct rq *rq, struct task=
_struct *p, int flags)
 	 * If that is the case, the task will be throttled and
 	 * the replenishment timer will be set to the next period.
 	 */
-	if (!p->dl.dl_throttled && dl_is_constrained(&p->dl))
+	if (!p->dl.dl_throttled && !dl_is_implicit(&p->dl))
 		dl_check_constrained_dl(&p->dl);
=20
 	/*
--=20
2.14.1
