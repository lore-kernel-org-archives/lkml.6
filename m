Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119858-2-14722825408014025542
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
    t=1520119858; b=cN5MJXk5FhBv4Qsm+Ek1tDuVE5DTe2W194ZWZUoWWu8btqq
    eGSlqCz2zUH1xyhQPGcFHqftnY0C8a8v3iUg+El0o0/ITa3ZhYqGV6+dbGbrDawR
    Qqgq0e2VQdJsB+2eCH9rUlDTJrure1iqtwG5LZ4gIRAfGnageRFEeWwg0Phul9MW
    eQMQvx+i4q1U/OEZ4wlXDkK/jqkNKCedclDCrgGAH4Z5/+vaP1ewZR5VxrJE9BO/
    zNeMhhQGbGFgkZujWBaeDqhasxmV/7ZQIPGm3VHJPGN2434Vq0C7S/N9NjKcKyDX
    sJ7oP7LZqb5AkgwDfVajLjVkB9rHm/JfMW3C+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119858; bh=inPnpc
    XJQ4BaFjpt+L8JqEnPvcgOTtLbMiDpQZYmhM8=; b=ec+5ypLeG8nx8s1enRZLhQ
    irjuMW72rtPDgFGPNUNnPwHSpAUB3ZW3hFKQb9CtzK+6MRl5yqDQswKew9KrVjPo
    c5TW+A40RYqOqs2jS7I7CE1J0SklpUq1HslMdtCBLvGKlUnTeDeMe8I61KI5EYPO
    8xedDMu+u4klqWcQht1PXtKp5NBrtzIRT9EJ4fu6/iAYVqfpunSOzS3hVAjZ+XYf
    31CsnO1sl5iGGP1kUBQEa7ntvmD5Sxp5N1i2xRH4h9yOGxVo6xUqJTiN3Vw4OQ5U
    tMAu+5WiYsckpSTm64rDnscCszZv7ORXIrmx0RMm6Roxlo3NdeGZiqbAJJ8NKfrQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gnSnNrxz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gnSnNrxz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934309AbeCCXap (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:30:45 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934529AbeCCWgM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 177/219] sched: Stop switched_to_rt() from
 sending IPIs to offline CPUs
Thread-Topic: [PATCH AUTOSEL for 4.9 177/219] sched: Stop switched_to_rt()
 from sending IPIs to offline CPUs
Thread-Index: AQHTsz8eDn0NIlOCkU2+sEr14PDX6g==
Date: Sat, 3 Mar 2018 22:29:40 +0000
Message-ID: <20180303222716.26640-177-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:JHq9QP0i4LlzQ5mrjj8cH0MKEwxwo28dq4hvOLi/yRAs1wpkZH3BT9sxxjtCHq7MrdBy3Q9fHoK19p0ZBdWiPoeZAostNWEL0YN9gf0o/eHyDB24yhvKAYKQGDb3CUyMQvYy2i9cJc0W/wg74k8ep0zVR41kWv9ISZ6b95T0+8cewoTp99f0EiDb/dVeHZRaTu000q/1nFOi8QnT2zmw8fz9jjw0Xu8Yk4CyF9/GK/is5pbNmSGHL6jdNxKLbsMB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7729e888-b11a-40bb-f112-08d581572829
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020A6D379D7770E3564BA03FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fPtP3cxREW8T/fqtGa+/72tOVfQuiojnx1m+5XKxWO4awwtVSoTL6n32iKNgsd6gojeeYtCHAqLMstLg5I3srv49SlcBvoZRI3jCi8tbj2KhESwEOl4cQHEio3HjxJ5q1qIDmsMO/Xyq5Hi2VCKN23P9cDc3elLgHT+yV0BbpJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7729e888-b11a-40bb-f112-08d581572829
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:40.3851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 2fe2582649aa2355f79acddb86bd4d6c5363eb63 ]

The rcutorture test suite occasionally provokes a splat due to invoking
rt_mutex_lock() which needs to boost the priority of a task currently
sitting on a runqueue that belongs to an offline CPU:

WARNING: CPU: 0 PID: 12 at /home/paulmck/public_git/linux-rcu/arch/x86/kern=
el/smp.c:128 native_smp_send_reschedule+0x37/0x40
Modules linked in:
CPU: 0 PID: 12 Comm: rcub/7 Not tainted 4.14.0-rc4+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1u=
buntu1 04/01/2014
task: ffff9ed3de5f8cc0 task.stack: ffffbbf80012c000
RIP: 0010:native_smp_send_reschedule+0x37/0x40
RSP: 0018:ffffbbf80012fd10 EFLAGS: 00010082
RAX: 000000000000002f RBX: ffff9ed3dd9cb300 RCX: 0000000000000004
RDX: 0000000080000004 RSI: 0000000000000086 RDI: 00000000ffffffff
RBP: ffffbbf80012fd10 R08: 000000000009da7a R09: 0000000000007b9d
R10: 0000000000000001 R11: ffffffffbb57c2cd R12: 000000000000000d
R13: ffff9ed3de5f8cc0 R14: 0000000000000061 R15: ffff9ed3ded59200
FS:  0000000000000000(0000) GS:ffff9ed3dea00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000080686f0 CR3: 000000001b9e0000 CR4: 00000000000006f0
Call Trace:
 resched_curr+0x61/0xd0
 switched_to_rt+0x8f/0xa0
 rt_mutex_setprio+0x25c/0x410
 task_blocks_on_rt_mutex+0x1b3/0x1f0
 rt_mutex_slowlock+0xa9/0x1e0
 rt_mutex_lock+0x29/0x30
 rcu_boost_kthread+0x127/0x3c0
 kthread+0x104/0x140
 ? rcu_report_unblock_qs_rnp+0x90/0x90
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x22/0x30
Code: f0 00 0f 92 c0 84 c0 74 14 48 8b 05 34 74 c5 00 be fd 00 00 00 ff 90 =
a0 00 00 00 5d c3 89 fe 48 c7 c7 a0 c6 fc b9 e8 d5 b5 06 00 <0f> ff 5d c3 0=
f 1f 44 00 00 8b 05 a2 d1 13 02 85 c0 75 38 55 48

But the target task's priority has already been adjusted, so the only
purpose of switched_to_rt() invoking resched_curr() is to wake up the
CPU running some task that needs to be preempted by the boosted task.
But the CPU is offline, which presumably means that the task must be
migrated to some other CPU, and that this other CPU will undertake any
needed preemption at the time of migration.  Because the runqueue lock
is held when resched_curr() is invoked, we know that the boosted task
cannot go anywhere, so it is not necessary to invoke resched_curr()
in this particular case.

This commit therefore makes switched_to_rt() refrain from invoking
resched_curr() when the target CPU is offline.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f6d68ddfa2f3..c7b0d2e7a9aa 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2206,7 +2206,7 @@ static void switched_to_rt(struct rq *rq, struct task=
_struct *p)
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->rt.overloaded)
 			queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
--=20
2.14.1
