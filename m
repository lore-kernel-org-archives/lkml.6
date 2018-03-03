Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118263-5-10993483943346323418
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
    t=1520118263; b=XrkLLh3eegLZ/H/IDV/6xCbyz5W3Bl1ay12MK82Eay1yMSc
    Y+iQQN38ROtA9xCN+lxM3agdK0u1GHLCYixSYNyZYMn0LJD6mJMglFH9PRNeFM7E
    raqIopCJu4P3F2RQpuMdj3578pmN/9NbSoShuJ1GDzuj3rLRh5WonyMWBf9bdUCv
    yr4CbS+2tAv1uM9LX5ive9iVLlWmy9wPtTWkK+EUR4zBhqmtqjxtej78e49IsM6w
    SwRI26TSsOeh8vE27+KIagde+9GleiFiFzeiNPymuZpEY0ABuU3lFBc7EsS54rg6
    IC5iVDhVDLKBAifmTalI/P567dUbuZnv1Gk/z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118263; bh=DF8NRv
    oa0fRLIJ8LjmmE5lMrbZPAxieiU9PotjgmEYk=; b=VuO53L3mHvhxwYI6LoEzzp
    5GQgOfm9YaPZVKYIW0Wn2DkM9ILSTYUxDuYSSl4X2i7ZbNMNbJgETUI3fyXsxe/3
    l2P9Ghv00qceLZu2Q/7+3n2Nm/IQ7m93X+N4HVVLC2NMmPi3aJ3h8WBUesFSUsdB
    LmjOWHpzXZsHoSU6w106lJ4JCpkSDpvLXdS4SCivflGHwRrBVa/Cs2n59dic9TjP
    r1AunAiXd9P4veatO5s7FU9q0xxmfnXRa8CXHz4ZuSmiunmUUOsjao+1f7DXt+t1
    okB/BOZ5wrKFel/XMDRsGmDd+/hyPOf7dNno/HlZ008I8WbqVMi9lxt4qRTBZuMg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iNOU+W19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iNOU+W19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934470AbeCCXDi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:03:38 -0500
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:13952
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935227AbeCCWkQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 089/115] sched: Stop resched_cpu() from
 sending IPIs to offline CPUs
Thread-Topic: [PATCH AUTOSEL for 4.4 089/115] sched: Stop resched_cpu() from
 sending IPIs to offline CPUs
Thread-Index: AQHTsz9nT3uXC/R6/U2MY7ELD5NOgA==
Date: Sat, 3 Mar 2018 22:31:42 +0000
Message-ID: <20180303223010.27106-89-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:IyPjz0CsKGBufvzQEMGI80TgSY6yQncLorrGI+Q4FEEyOhDGUqpA8dUZlO34QEa/yoBm2/qSCT9VFJksmRIfRGC21YyLNRHJEW6Q01icFhvXhdZ8ZmAHnWk+UUXz5NydUDxc4gb2AWwi2Hr4ib0UO8qgz2lqTTOCmu0hB/oqB2KNZPEfqN+Xr1zvUDGiFAklorR747sMYZXrMJQgsFqriQWx777hUgNnZrTQBdcU8Gy8XK84m++YyZUHkaoJ/Rto
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 280d9fb5-374b-46b5-25af-08d58157b995
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939226C0AE6215CC43958ECFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YaTAnE/WZbibfzZUhcpyDxquwkJYfVHzOfyTQjIvAtX3x9BJlBwtMdK4Yiyp0NZ2eKO20iGZlfzj90xSFyMiJv2lZjniucVnkmvM63ogl3OZ2gqxhM8Cjfg6yL5ukcznrRfNwKdPws8gB6m7CPq+BDzU0Adt01aJA5XuEKFyTN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280d9fb5-374b-46b5-25af-08d58157b995
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:42.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index c5b1c62623cf..65ed3501c2ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -601,7 +601,8 @@ void resched_cpu(int cpu)
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
