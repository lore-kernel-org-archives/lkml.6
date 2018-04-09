Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523247020-2-2434220832372852511
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
    1523247019; b=Eey/VKBZ6jG5PhnVrH7EWThiPNYL2TrPKr6sMWT/FiDX058Scl
    y2nwCoMRad4JBhxcRw51+YoHXo7+laFKIOFKJvBOj6qG7xXdXnjk5nW0I3njGtRs
    qIoGwhgWF8kGkeUXe/HrIjWBo/HTslQJsSWvJBFHkjM+RrOtcRASMCGIBow3mOoi
    Wzpwj7Jg1D+3yp3OCEoqlpX8mHInl0HaUjIulBV95abUUybDoTVnKfaeTgnvZXRU
    P9bK+S8fbrLWKXyxW6wDP1WRhT8IlGE5HGCIY38+BpTudQ8rLwu+Kk+CjRuWHust
    Bm50d6a6ASDGxJSSst8p2DkoEwWEO72w7zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247019; bh=VrikYJUE08
    n6vHX67TvfXOa8MJEabt4EtFdS4JvWUY8=; b=T9dQKF+iU4sbZMNbfzqK0sBoKq
    wTDOIusoleyVn8ZFvJcX0M5OJTjGFG1NrtVAhtIsAsAELkUY8XO13sl3HSKtv4mq
    OcktTP8+TzrRpdzqV3RJDMx7HsIzcOpHgGtyg7C6TGxQHrUqFV/33Rmmsn6d8/D/
    PMJM+mvI20XG7vBYghNkvPzYu6x79xBgc70hRxfSdxFq1RxYl5SskuoUWcOCh/Ig
    /o+1jagW9NNAo8gyj+j/SGawM1zKLjStexNmWO/nj7IuIh/KrvSgwbW/BPxTENsD
    PDCcdK2cKk/o1gT+t7ChwDdHgFk+RRgR4CTMpQmkDL5T6O/MdxSgfRJdj2dw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mWMEY1gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mWMEY1gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBy22Af2l61VIJyM1QRKIvFVzMhlAim5dtrQj7AtgtFgkDjSZmeeIqa2IMXOGTrwo5+HHJchedCgsfcGeizH4bea3zfM8CGG5lqheYfcJiFVbOwsRvTF
    zPPSq/geBFmarDQMNfV6mn+fPIxA91C81ZrK2jMakamdSNzt59/rv+FqtH4p/0dQdQ9YIf40XwLnOr7BRjcrvlXF/tUFmVhkCgvstS7VrccNxeDZDf4aGRI7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=Z4Rwk6OoAAAA:8 a=37rDS-QxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=ufHFDILaAAAA:8 a=JfrnYn6hAAAA:8 a=7d_E57ReAAAA:8 a=57SyGIRnAAAA:8
    a=yMhMjlubAAAA:8 a=ux3MEmx-P8e3s4GjrgcA:9 a=HjnC-LDKmVeH1-xm:21
    a=FnP4kcYOdNKQn-ur:21 a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=k1Nq6YrhK2t884LQW06G:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=jhqOcbufqs7Y1TYCrUUU:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeDIEKR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:10:17 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753032AbeDIARD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 019/189] printk: Add console owner and waiter
 logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.15 019/189] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5gTpP6JXfT76UOTL5UYuogqGg==
Date: Mon, 9 Apr 2018 00:16:59 +0000
Message-ID: <20180409001637.162453-19-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:FN767L1psWq78Z9F+79V4bbgI+nZucJwje9s4fASR4lsPLmJkI4b8NVp9BOKRajrrJJ/ZJ13En7HIr5x0wqDydOd5hyysTrRQG+QSKKjkECcjJ7/enwalKfEMe0NhDim0kkYGIYgbgDOLzqxamuLUohsCZkuoSwSeZjbEGZtTA4FIy+RcW0AeM2+g/5QW1rvQw7JLBCJeO7/Xix1EGpgvwqZ8ROkALxNIMiG3kORbB9OfjTb5cbiAPfW+OpHAxEl;20:YoF/QMe3fan//BDb3d9Zoyv4EjDcFDffC8znlHUPPI3d7RuQHGmrpizX+8kFMNRQFk3oaWLJz0PrWrsqgW+OzWJXE0G/vwfdpL6ZaMeH9zf0IoXT19Iin5uPKCpsDsvU4Fl7/z4NVnC8TPUh5OTd8+ZjIlH64KTxfO+kTsYHMg4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3b7866c-0f4a-473a-b837-08d59daf366a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112721C90B1EED5B615F0DE7FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(274141268393343)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(7416002)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(39060400002)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: E5caRPTHLJm+VJ2YzuR1krGIflUUP+4can/W0Kb3as7KXCQENHvE9Zi1k178bd4awUFFfWdkPUqrFnGnVdjqn3IW3iPb6MbQWmmpI0Cc3IyV2/pg23WGNR/GdN1WIEy67bKn+79Z1JTFy6U7+R0WoMOTeoE44Mr4QZv4PqE2LYg/KKKy/sYNmFAn41XDGjr9gRemDAoZjXFqV080q0SXfMdcOgJQc9ZwJNrMnmG+dSmdDdFWiQdDlIoRRo4KLKOHZhsd2B6dscp3Al5V9cIBtt9P4Uew+CTTpyrtMMEvcdvqhJGX0fF9EDh+ZBK99SrBNRsAa4Lh239L3qM762Ut2CikKqRZ3e/m9qSQvRQ6CM0CqgC9FgP7YtXv9+sLdrfq774qeHwWXx6062eJImxLSB2LaL6mg79DChnLw/3dNPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b7866c-0f4a-473a-b837-08d59daf366a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:59.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit dbdda842fe96f8932bae554f0adf463c27c42bc7 ]

This patch implements what I discussed in Kernel Summit. I added
lockdep annotation (hopefully correctly), and it hasn't had any splats
(since I fixed some bugs in the first iterations). It did catch
problems when I had the owner covering too much. But now that the owner
is only set when actively calling the consoles, lockdep has stayed
quiet.

Here's the design again:

I added a "console_owner" which is set to a task that is actively
writing to the consoles. It is *not* the same as the owner of the
console_lock. It is only set when doing the calls to the console
functions. It is protected by a console_owner_lock which is a raw spin
lock.

There is a console_waiter. This is set when there is an active console
owner that is not current, and waiter is not set. This too is protected
by console_owner_lock.

In printk() when it tries to write to the consoles, we have:

	if (console_trylock())
		console_unlock();

Now I added an else, which will check if there is an active owner, and
no current waiter. If that is the case, then console_waiter is set, and
the task goes into a spin until it is no longer set.

When the active console owner finishes writing the current message to
the consoles, it grabs the console_owner_lock and sees if there is a
waiter, and clears console_owner.

If there is a waiter, then it breaks out of the loop, clears the waiter
flag (because that will release the waiter from its spin), and exits.
Note, it does *not* release the console semaphore. Because it is a
semaphore, there is no owner. Another task may release it. This means
that the waiter is guaranteed to be the new console owner! Which it
becomes.

Then the waiter calls console_unlock() and continues to write to the
consoles.

If another task comes along and does a printk() it too can become the
new waiter, and we wash rinse and repeat!

By Petr Mladek about possible new deadlocks:

The thing is that we move console_sem only to printk() call
that normally calls console_unlock() as well. It means that
the transferred owner should not bring new type of dependencies.
As Steven said somewhere: "If there is a deadlock, it was
there even before."

We could look at it from this side. The possible deadlock would
look like:

CPU0                            CPU1

console_unlock()

  console_owner =3D current;

				spin_lockA()
				  printk()
				    spin =3D true;
				    while (...)

    call_console_drivers()
      spin_lockA()

This would be a deadlock. CPU0 would wait for the lock A.
While CPU1 would own the lockA and would wait for CPU0
to finish calling the console drivers and pass the console_sem
owner.

But if the above is true than the following scenario was
already possible before:

CPU0

spin_lockA()
  printk()
    console_unlock()
      call_console_drivers()
	spin_lockA()

By other words, this deadlock was there even before. Such
deadlocks are prevented by using printk_deferred() in
the sections guarded by the lock A.

By Steven Rostedt:

To demonstrate the issue, this module has been shown to lock up a
system with 4 CPUs and a slow console (like a serial console). It is
also able to lock up a 8 CPU system with only a fast (VGA) console, by
passing in "loops=3D100". The changes in this commit prevent this module
from locking up the system.

 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/hrtimer.h>

 static bool stop_testing;
 static unsigned int loops =3D 1;

 static void preempt_printk_workfn(struct work_struct *work)
 {
 	int i;

 	while (!READ_ONCE(stop_testing)) {
 		for (i =3D 0; i < loops && !READ_ONCE(stop_testing); i++) {
 			preempt_disable();
 			pr_emerg("%5d%-75s\n", smp_processor_id(),
 				 " XXX NOPREEMPT");
 			preempt_enable();
 		}
 		msleep(1);
 	}
 }

 static struct work_struct __percpu *works;

 static void finish(void)
 {
 	int cpu;

 	WRITE_ONCE(stop_testing, true);
 	for_each_online_cpu(cpu)
 		flush_work(per_cpu_ptr(works, cpu));
 	free_percpu(works);
 }

 static int __init test_init(void)
 {
 	int cpu;

 	works =3D alloc_percpu(struct work_struct);
 	if (!works)
 		return -ENOMEM;

 	/*
 	 * This is just a test module. This will break if you
 	 * do any CPU hot plugging between loading and
 	 * unloading the module.
 	 */

 	for_each_online_cpu(cpu) {
 		struct work_struct *work =3D per_cpu_ptr(works, cpu);

 		INIT_WORK(work, &preempt_printk_workfn);
 		schedule_work_on(cpu, work);
 	}

 	return 0;
 }

 static void __exit test_exit(void)
 {
 	finish();
 }

 module_param(loops, uint, 0);
 module_init(test_init);
 module_exit(test_exit);
 MODULE_LICENSE("GPL");

Link: http://lkml.kernel.org/r/20180110132418.7080-2-pmladek@suse.com
Cc: akpm@linux-foundation.org
Cc: linux-mm@kvack.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[pmladek@suse.com: Commit message about possible deadlocks]
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/printk/printk.c | 108 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b9006617710f..7e6459abba43 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -86,8 +86,15 @@ EXPORT_SYMBOL_GPL(console_drivers);
 static struct lockdep_map console_lock_dep_map =3D {
 	.name =3D "console_lock"
 };
+static struct lockdep_map console_owner_dep_map =3D {
+	.name =3D "console_owner"
+};
 #endif
=20
+static DEFINE_RAW_SPINLOCK(console_owner_lock);
+static struct task_struct *console_owner;
+static bool console_waiter;
+
 enum devkmsg_log_bits {
 	__DEVKMSG_LOG_BIT_ON =3D 0,
 	__DEVKMSG_LOG_BIT_OFF,
@@ -1753,8 +1760,56 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * semaphore.  The release will print out buffers and wake up
 		 * /dev/kmsg and syslog() users.
 		 */
-		if (console_trylock())
+		if (console_trylock()) {
 			console_unlock();
+		} else {
+			struct task_struct *owner =3D NULL;
+			bool waiter;
+			bool spin =3D false;
+
+			printk_safe_enter_irqsave(flags);
+
+			raw_spin_lock(&console_owner_lock);
+			owner =3D READ_ONCE(console_owner);
+			waiter =3D READ_ONCE(console_waiter);
+			if (!waiter && owner && owner !=3D current) {
+				WRITE_ONCE(console_waiter, true);
+				spin =3D true;
+			}
+			raw_spin_unlock(&console_owner_lock);
+
+			/*
+			 * If there is an active printk() writing to the
+			 * consoles, instead of having it write our data too,
+			 * see if we can offload that load from the active
+			 * printer, and do some printing ourselves.
+			 * Go into a spin only if there isn't already a waiter
+			 * spinning, and there is an active printer, and
+			 * that active printer isn't us (recursive printk?).
+			 */
+			if (spin) {
+				/* We spin waiting for the owner to release us */
+				spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
+				/* Owner will clear console_waiter on hand off */
+				while (READ_ONCE(console_waiter))
+					cpu_relax();
+
+				spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+				printk_safe_exit_irqrestore(flags);
+
+				/*
+				 * The owner passed the console lock to us.
+				 * Since we did not spin on console lock, annotate
+				 * this as a trylock. Otherwise lockdep will
+				 * complain.
+				 */
+				mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
+				console_unlock();
+				printk_safe_enter_irqsave(flags);
+			}
+			printk_safe_exit_irqrestore(flags);
+
+		}
 	}
=20
 	return printed_len;
@@ -2141,6 +2196,7 @@ void console_unlock(void)
 	static u64 seen_seq;
 	unsigned long flags;
 	bool wake_klogd =3D false;
+	bool waiter =3D false;
 	bool do_cond_resched, retry;
=20
 	if (console_suspended) {
@@ -2229,14 +2285,64 @@ skip:
 		console_seq++;
 		raw_spin_unlock(&logbuf_lock);
=20
+		/*
+		 * While actively printing out messages, if another printk()
+		 * were to occur on another CPU, it may wait for this one to
+		 * finish. This task can not be preempted if there is a
+		 * waiter waiting to take over.
+		 */
+		raw_spin_lock(&console_owner_lock);
+		console_owner =3D current;
+		raw_spin_unlock(&console_owner_lock);
+
+		/* The waiter may spin on us after setting console_owner */
+		spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
+
 		stop_critical_timings();	/* don't trace print latency */
 		call_console_drivers(ext_text, ext_len, text, len);
 		start_critical_timings();
+
+		raw_spin_lock(&console_owner_lock);
+		waiter =3D READ_ONCE(console_waiter);
+		console_owner =3D NULL;
+		raw_spin_unlock(&console_owner_lock);
+
+		/*
+		 * If there is a waiter waiting for us, then pass the
+		 * rest of the work load over to that waiter.
+		 */
+		if (waiter)
+			break;
+
+		/* There was no waiter, and nothing will spin on us here */
+		spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+
 		printk_safe_exit_irqrestore(flags);
=20
 		if (do_cond_resched)
 			cond_resched();
 	}
+
+	/*
+	 * If there is an active waiter waiting on the console_lock.
+	 * Pass off the printing to the waiter, and the waiter
+	 * will continue printing on its CPU, and when all writing
+	 * has finished, the last printer will wake up klogd.
+	 */
+	if (waiter) {
+		WRITE_ONCE(console_waiter, false);
+		/* The waiter is now free to continue */
+		spin_release(&console_owner_dep_map, 1, _THIS_IP_);
+		/*
+		 * Hand off console_lock to waiter. The waiter will perform
+		 * the up(). After this, the waiter is the console_lock owner.
+		 */
+		mutex_release(&console_lock_dep_map, 1, _THIS_IP_);
+		printk_safe_exit_irqrestore(flags);
+		/* Note, if waiter is set, logbuf_lock is not held */
+		return;
+	}
+
 	console_locked =3D 0;
=20
 	/* Release the exclusive_console once it is used */
--=20
2.15.1
