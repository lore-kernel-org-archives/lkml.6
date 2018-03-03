Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120873-2-17356612924122454524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120872; b=YtuH678uL0Yhp3UF4MhucK1uvaUvN+vyZBA5t9ubMhXXGAW
    3mix7msY200hab+evX6x+EDVXbmnBqL4ktM8Xls7b0sbm0XV1apcvyHczSJpB+MQ
    qMTFV55XQ/o04HgyCwG9cXrFgXFgVdO39cwf2Hu4ibIvzIIgwGCFY6Y5ppZtoLkU
    mejMjI+BW82rGGGg19JR3RaUo+kfea8cfgEjqtRD2Ueyp/hTydxw9rcT40Zj9XPY
    w3h/+1gCDhE8B70WzaZ6Eyn3lLbJ9dHsNtxxJWmEH9UYWe+zSZrn6X8kq8kqSq1K
    u2prJTXmE+Ty0erXySOOltaOT8x3/PIZk3Z3Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120872; bh=9bmtbw
    0khGlxvFriu5WTIGaddUmj0RTo1cGPtld7zD0=; b=PzdP6EBA8TjdOGBCWZvxXt
    uJB5ArmakY4lzng3LI86t2ws2bvzNvAd693FxOkrR63DjFaouX4brvsG6aBria1x
    nxNLpWsuNRD4/LJeaLdQB8Z1oNbT5S0x4P1Iib83wS5Wlm68cH6dtgBZRnjGrKWt
    eP/HFUIacKAo0CNnA9jHheH4hB86Xg4eiIzAZgzDW6qBxIm0qaK7PTwtt3JDWXOl
    6iF3JSLIdtUJVloA+L1TnNPBv3woYhTS1QkY4rv/NRhXKbfX4QMzo/zmRt2oi+Ui
    6Hs54JV6IhR/XINwjKqElfsM786oZJ8DT+uYiqpuQWmdJlxduuhvQ9ONTuThun4Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVdYFLc3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVdYFLc3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933966AbeCCXrs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:47:48 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933058AbeCCWeC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        "juri.lelli@arm.com" <juri.lelli@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "xlpang@redhat.com" <xlpang@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jdesfossez@efficios.com" <jdesfossez@efficios.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 104/219] rtmutex: Fix PI chain order integrity
Thread-Topic: [PATCH AUTOSEL for 4.9 104/219] rtmutex: Fix PI chain order
 integrity
Thread-Index: AQHTsz8EdS8EOF0QP0iBWGHu1X/0lA==
Date: Sat, 3 Mar 2018 22:28:56 +0000
Message-ID: <20180303222716.26640-104-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:HFVHH3HMCZfvipO/WbHGI0HYMJogW/n2OIBHQHM6AqD5ZYLHqLtamWOLeqWjdoVlTfygIsDjrRRnn316jOf965w7pflK1+sKZryTGLSMBWhgBVxB/6JWj0B4o3r63NZG3uvbYDXt1DKNVfvbCVM/txbtP+ulDfDN/urue7h84Ltp56PVM2QGrMN27+ALPEK8gVR352k/v0rA8m4TLD//2lPns+f7LGfRzsvVhjo+xOSPr3oqXWqjKgBC7L8yooQU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5934ca8d-e018-4d48-2c0a-08d58156dab4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065861DA4F3360309B28CF0FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(6306002)(106356001)(105586002)(478600001)(66066001)(7416002)(107886003)(3660700001)(966005)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: XuK2Ph7mMYD1nKadm1XDT0O5ADu87LverTQwPcNqM/v4d4zg609+6+BTZ5RoYjvImfvQAcUo48J+K2MN4/HJ/KcNr9iH3IhRokzTkWue0yDaI8no8Ss/ybt4CtiLTSmZhQtZGA2yVgzK7vnxvGynjmiDMO+IA/8BRGA2NPdpmVI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5934ca8d-e018-4d48-2c0a-08d58156dab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:56.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e0aad5b44ff5d28ac1d6ae70cdf84ca228e889dc ]

rt_mutex_waiter::prio is a copy of task_struct::prio which is updated
during the PI chain walk, such that the PI chain order isn't messed up
by (asynchronous) task state updates.

Currently rt_mutex_waiter_less() uses task state for deadline tasks;
this is broken, since the task state can, as said above, change
asynchronously, causing the RB tree order to change without actual
tree update -> FAIL.

Fix this by also copying the deadline into the rt_mutex_waiter state
and updating it along with its prio field.

Ideally we would also force PI chain updates whenever DL tasks update
their deadline parameter, but for first approximation this is less
broken than it was.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170323150216.403992539@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/locking/rtmutex.c        | 29 +++++++++++++++++++++++++++--
 kernel/locking/rtmutex_common.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2c49d76f96c3..196cc460e38d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -236,8 +236,7 @@ rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	 * then right waiter has a dl_prio() too.
 	 */
 	if (dl_prio(left->prio))
-		return dl_time_before(left->task->dl.deadline,
-				      right->task->dl.deadline);
+		return dl_time_before(left->deadline, right->deadline);
=20
 	return 0;
 }
@@ -704,7 +703,26 @@ static int rt_mutex_adjust_prio_chain(struct task_stru=
ct *task,
=20
 	/* [7] Requeue the waiter in the lock waiter tree. */
 	rt_mutex_dequeue(lock, waiter);
+
+	/*
+	 * Update the waiter prio fields now that we're dequeued.
+	 *
+	 * These values can have changed through either:
+	 *
+	 *   sys_sched_set_scheduler() / sys_sched_setattr()
+	 *
+	 * or
+	 *
+	 *   DL CBS enforcement advancing the effective deadline.
+	 *
+	 * Even though pi_waiters also uses these fields, and that tree is only
+	 * updated in [11], we can do this here, since we hold [L], which
+	 * serializes all pi_waiters access and rb_erase() does not care about
+	 * the values of the node being removed.
+	 */
 	waiter->prio =3D task->prio;
+	waiter->deadline =3D task->dl.deadline;
+
 	rt_mutex_enqueue(lock, waiter);
=20
 	/* [8] Release the task */
@@ -831,6 +849,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struc=
t *task,
 static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct =
*task,
 				struct rt_mutex_waiter *waiter)
 {
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Before testing whether we can acquire @lock, we set the
 	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
@@ -958,6 +978,8 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *loc=
k,
 	struct rt_mutex *next_lock;
 	int chain_walk =3D 0, res;
=20
+	lockdep_assert_held(&lock->wait_lock);
+
 	/*
 	 * Early deadlock detection. We really don't want the task to
 	 * enqueue on itself just to untangle the mess later. It's not
@@ -975,6 +997,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *loc=
k,
 	waiter->task =3D task;
 	waiter->lock =3D lock;
 	waiter->prio =3D task->prio;
+	waiter->deadline =3D task->dl.deadline;
=20
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1080,6 +1103,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	struct task_struct *owner =3D rt_mutex_owner(lock);
 	struct rt_mutex *next_lock;
=20
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on =3D NULL;
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_commo=
n.h
index e317e1cbb3eb..50848b460851 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -33,6 +33,7 @@ struct rt_mutex_waiter {
 	struct rt_mutex		*deadlock_lock;
 #endif
 	int prio;
+	u64 deadline;
 };
=20
 /*
--=20
2.14.1
