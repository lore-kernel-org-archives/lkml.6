Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242000-2-10908927079035204489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241997; b=lfYKasBwwc+d8iuk+pV70oICve2J96WEx6bbowbpcIHqA+kKiV
    ejuyvap6HZiN5CQF+ecpG6kgTsEiCZq2sNuTdxuOVTGVlxaOHctoJsFdMwFDj5LY
    78jBejouNVPO6bc5aCHxtqoeDXRYBOL/sShaC30TalPMn/0VfeTN0SHpseG3ACeM
    IF2v0PhGI1mqI/zN0YRzPrlKopHPHRv8KefEBy384WcqBM8isI2sGXi1GtE5RDiH
    72AGHOLWSOuQH7fFkCZrO5hbNT0gSHw5iwTZoif0+e+tJQqWMW+KJ2jHTDj4tKF4
    U2mfB9rzXrrkSDCZjtU2tVR4f8v9lKD6bikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241997; bh=Y1finJp2XA
    uaDA/jfIg/yIs1dcuUw6+Rh06bFuNWc30=; b=XlXd9vjRWqG6KgZJPfKC/HBtWG
    Yg+zVmiZ71gP5+YPVS900vRoVLTmPudks8/mRQWEssy2eK8YDuaKO/d/he+z/i38
    ww1j9Vihl2kYgvKAONxfbu4/MTo1Daq6jfUZpKB+bD+S067JvQZ8eJZ61vobk1lo
    spFsKXDJc0818G1kVjoi+4Kp9LPS5gD/yjJKVMK1LoRDYqi0JGGhTxZdE0v/gYR9
    mOtJshVLKdlLASN26AoPvxqL1LDbydCTYTvrGJkN7K4Kf59JnKPvuAUu87cgaiDJ
    eFDQqfRNJK4d2PeI8Iv7CmKQuDLib/5gYObw7dcQRcux40xOv6EiND48nz4A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OsEBxI2o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OsEBxI2o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPH603gjLamtk6//jzrNMPyN0am/DAWDyomPv45qCasGkRKNUQ8bvJzb5HQRz8s3xbuLvoyXESw03B6s9DjlD+aJIafY8Cg7RMqRS6KqkCWC67IYUpxB
    96igGdbTFyy2jPK392mzptM3/sR7ahMaBnxbojhkYJuEXd8vBkR6kIvWmlZMIqbO/9YBVJetRpUeEtK66bATleDRsCw3mD9lfSdo4HbHnqOU0c4sgqwDz2es
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=4yVJEyYWh7Y9hNgFzLEA:9 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDICqd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:33 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755350AbeDIA0l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Subject: [PATCH AUTOSEL for 4.9 007/293] sched/deadline: Use the revised
 wakeup rule for suspending constrained dl tasks
Thread-Topic: [PATCH AUTOSEL for 4.9 007/293] sched/deadline: Use the revised
 wakeup rule for suspending constrained dl tasks
Thread-Index: AQHTz5jm73mZ5Lb4WEuSQFqIf5N2Ag==
Date: Mon, 9 Apr 2018 00:22:52 +0000
Message-ID: <20180409002239.163177-7-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:SEs/sdu9siHuBSfB7DC/FB+ODdJzemBHrhlS6FN8WQa1xZZL03CN9mz6iKP1rOoI+MYKtjDB2QwySgi/dZKK1KDbLXtarw3XzsHlz6d9Y5H/ZRqvCjzThIzk31ODLrK+mUnGmbFBvbcvIU6ENupdNlMMmRhUY3b/oPa/rW3cdnTZA58Z/aBF4RG7ziCnX9WTz3DGBNu6QZV23HrMVg+YmD/x39pnIHyqzxaSLy50xB9+QP0rMTsYTB+h34SX2Ldq;20:k2akd3qdFUekqlTZNfXINuRlOStXQxgre0zDDnTuUwrC8hIqjWKyFtv/XI6bbcXv5GY4wnpfu6D+56ZWeFGVHudlzSMahXcoH4BTPU6CMM0rrdmfZiyirk5ZvLc/J+qpA2OZH2mxEwdLeX53uuSGoXu8g2SzGEggDpxMrMC7+7o=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0ba7e42-6bb7-4469-b572-08d59db08c83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C35A287BB1537F4AFF67FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(180628864354917)(26323138287068)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(10710500007)(7736002)(2420400007)(486006)(2906002)(6306002)(15650500001)(5660300001)(6436002)(8666007)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(7416002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l7qvbNDIXPBYBaCW0kEfJAwEeV3aY2DOarYPQw0wWpiJWQ/xaM41tEpvtkhAzKR82UqQcNlZz55tQLTp6jScjpYdxme2ny5BAic0WC0vxXlZg9SaMM1sfzAAJUoXKL7kExVg08Wk/p6EFtuoHsOWcVdkEjt68KUzQPmpwSCJByMe76MzGy+GuVUo2r+omWLNl69bQj1O3RsrMK/aIijiE9bT8xpgtC0jtnw9SYYHc7WyQxuFzMVQcPiuSsj9SMh/UCo+0zslzHeaQ0Sb0f8ESM43+l+VvGwTQXYWASH6c19u/OEtmc/mLGP7XCU6ajqWOfBezeufhjoWlK4CDonPp/z+WdZLuWs956uewdbroQ3rLkESOCY3DPCnZXoLrx1m6dIF3Im+bUAtflkLVxqG0N/oIbLzPVmTLuc1WFgHBDo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ba7e42-6bb7-4469-b572-08d59db08c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:52.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 291ea6fa7ee6..917be221438b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2184,6 +2184,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_period =3D 0;
 	dl_se->flags =3D 0;
 	dl_se->dl_bw =3D 0;
+	dl_se->dl_density =3D 0;
=20
 	dl_se->dl_throttled =3D 0;
 	dl_se->dl_yielded =3D 0;
@@ -3912,6 +3913,7 @@ __setparam_dl(struct task_struct *p, const struct sch=
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
2.15.1
