Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123204-3-7550797780939385455
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
    t=1520123204; b=EbRxXS59lFjtmgsnZDLD8owBB9gqSi1S7VvWYjfSXW3OA1I
    heN6Dx0X8Um0q4xo5YSB4sKW/8Q5mdHQkjBaf+4qP3ZlIzVBJUy1IxLEEll/LH2j
    +UtdsfDxGYiq2T6qG5rDUbqoSh+W14zdQ/ou9/SOMg/raI72GA/7rQUAPivjGdUc
    2uVZkUrc1GdgMmmscR7ICYovq0mcqxh48zPSo8kQqQc3KuFzVpDkBp7NjIL+3Y+P
    vSXgyyGtqT9yzRyOEUnQNUESeEuWYWeNcHcXy1PMO+Fu9XO6HKHc/gG3RGNgZO9C
    aJMbSg/+Kl/kwaEcLOkd2BXWQcvCkcHBKygXK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123204; bh=mUbJOS
    ATL3TgOaKNiHA+kqB64T0wRsYvzpJ6kJgmWfA=; b=C0VtpEULe0BHis1bXWVK0M
    42BwCt1HdBAFPNHgr63gIOOYzDXqQKyAxxj38Q+VgUY9AoiUCOQ0HQ12dvmVfmht
    YWqT8SdYOUB4WA6EobLQWaSenMN4nVWycHzYXqtQ6G6Mr0hApAxo6E4q1iB/oOMd
    Z4L2gH16De8TBHly5Oi/LtTOpUd4J0ekySbfpBBwWeUdLrqRE/ETmFhk1uX7QeV0
    DyjavXjcEAXQQl1upSIn943GsNvG/Yjvp6+lKqSJxKFSdbRCGyeYc0lXKmkOsjb0
    8DWPHBBLj+eY+MYsaTxeiI5Y0ZUThwH09bGfG++OvOuDUsqmpfl9yuzwCIjMdI4A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gCPx/jvT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gCPx/jvT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeCDA0R (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:26:17 -0500
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:13662
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933127AbeCCW2M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 15/84] sched: Stop resched_cpu() from sending
 IPIs to offline CPUs
Thread-Topic: [PATCH AUTOSEL for 4.14 15/84] sched: Stop resched_cpu() from
 sending IPIs to offline CPUs
Thread-Index: AQHTsz6gmuqY3YutF0auD/kh0uA6tQ==
Date: Sat, 3 Mar 2018 22:26:08 +0000
Message-ID: <20180303222518.26271-15-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:UpdL633oMny7/ynWVq8MoTEgcYddzYlEDIMhfjTZNsjRtRsWA/47THe9lotVYpHpUVa6Ggv1Gg4pdHAitvXhuGxJdUoSTs+GSVv9HyL/wa/B+jD2XfEIzapo/OhpYPpFG7VVJXJOuTuV80L/rNpso4HtmEqw6kxlMP2ArailrnuhCMng2tlvByHlVKNKkz2u4F5476Gx0Y3CyRfEi4t2s99ghCqnXus3guqcsopo4KPn6DDD9K+52XZzqNK0upvi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c70180d-a459-4e93-8bdb-08d581560ba1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06E81892DE29A3FD2020E0FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ej8dMA558gkKHJfFzWku+yx3MZTAJeHwsutQiIiZiCa9RNf8rPTsi3Lv985V3ka9aVTBIeBH8/cApGgeKvKXQQHY7ZT2s+8qSrjsDxfO4e0cJMc9sHbc+qMuDk74d/fkMzEyxcTypgCahzK3a9ax+5n60JdWeApXmgmRS0NHPEc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70180d-a459-4e93-8bdb-08d581560ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:08.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit a0982dfa03efca6c239c52cabebcea4afb93ea6b ]

The rcutorture test suite occasionally provokes a splat due to invoking
resched_cpu() on an offline CPU:

WARNING: CPU: 2 PID: 8 at /home/paulmck/public_git/linux-rcu/arch/x86/kerne=
l/smp.c:128 native_smp_send_reschedule+0x37/0x40
Modules linked in:
CPU: 2 PID: 8 Comm: rcu_preempt Not tainted 4.14.0-rc4+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1u=
buntu1 04/01/2014
task: ffff902ede9daf00 task.stack: ffff96c50010c000
RIP: 0010:native_smp_send_reschedule+0x37/0x40
RSP: 0018:ffff96c50010fdb8 EFLAGS: 00010096
RAX: 000000000000002e RBX: ffff902edaab4680 RCX: 0000000000000003
RDX: 0000000080000003 RSI: 0000000000000000 RDI: 00000000ffffffff
RBP: ffff96c50010fdb8 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 00000000299f36ae R12: 0000000000000001
R13: ffffffff9de64240 R14: 0000000000000001 R15: ffffffff9de64240
FS:  0000000000000000(0000) GS:ffff902edfc80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7d4c642 CR3: 000000001e0e2000 CR4: 00000000000006e0
Call Trace:
 resched_curr+0x8f/0x1c0
 resched_cpu+0x2c/0x40
 rcu_implicit_dynticks_qs+0x152/0x220
 force_qs_rnp+0x147/0x1d0
 ? sync_rcu_exp_select_cpus+0x450/0x450
 rcu_gp_kthread+0x5a9/0x950
 kthread+0x142/0x180
 ? force_qs_rnp+0x1d0/0x1d0
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x27/0x40
Code: 14 01 0f 92 c0 84 c0 74 14 48 8b 05 14 4f f4 00 be fd 00 00 00 ff 90 =
a0 00 00 00 5d c3 89 fe 48 c7 c7 38 89 ca 9d e8 e5 56 08 00 <0f> ff 5d c3 0=
f 1f 44 00 00 8b 05 52 9e 37 02 85 c0 75 38 55 48
---[ end trace 26df9e5df4bba4ac ]---

This splat cannot be generated by expedited grace periods because they
always invoke resched_cpu() on the current CPU, which is good because
expedited grace periods require that resched_cpu() unconditionally
succeed.  However, other parts of RCU can tolerate resched_cpu() acting
as a no-op, at least as long as it doesn't happen too often.

This commit therefore makes resched_cpu() invoke resched_curr() only if
the CPU is either online or is the current CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55062461b2fd..8cf36b30a006 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -506,7 +506,8 @@ void resched_cpu(int cpu)
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&rq->lock, flags);
-	resched_curr(rq);
+	if (cpu_online(cpu) || cpu =3D=3D smp_processor_id())
+		resched_curr(rq);
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
=20
--=20
2.14.1
