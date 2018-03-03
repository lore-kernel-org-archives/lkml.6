Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117240-2-17639472235454775750
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
    t=1520117239; b=iTuSHL006sXAqlMEV/E52gAG+07OZw5nicbl+Q17zsSEMDX
    dKYirjfwPKYl9BQF+EDotDXPYKKqUCvkW5fUiiBbTKa2cajHEuoOG8nBSkcHXxZb
    OUXw8Ii20FmEcIq2+2MMo5RNnl2rVcEjiHFGb1Xg9xoenZRNhW9HwUUiqwcdf0OS
    11uTU1LIuhrHf2DVM2SndDc41DzbKcI4KyupQFvlEPJ646mLV+yk8ndLHSYSbOpG
    RKFBE+Z7dY4WLGu4mDHfitxnP0dHfyn6CYuezWh19VW7Sfj+3RhbaHAIdpfU7Rw2
    VN8IHtxTd+OzkULEvWjmEg9WYS5MRc+CMTvso7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117239; bh=doT4py
    kSCHf7XM/Jgq4jgwFQnZgCB6WxTV8YFACM3yU=; b=hHPqQGYq12Airmg8U4G/TA
    9NAOJ2oxvIY1OmLozUpAfiP6R6GRGcD+kuA2mSq/EIBw9otruIxWriqlopMKa2Eh
    KMil0hwMbE+vk4m0KoJwLQhM35utqD7Zyu6h9x/szrhowYRGXhbFTyMLdTh2Ln5W
    ND/MWjrnRvLHjdHmIIY/3CeYTHcla6gqeZHcR4trGGvxPhCVZQwAPYrzDIHItwKj
    Kb5mLUBWIdlipu3uoT/nL1dBlADWMtopdkG9lexF9JJdhbkRMWtGXc2ClDud8/WD
    OhIzg/+iZpWjbTl+AjQwir8Okvwo8LiclFxzu7jAUWl4xE62724W4v6vZ0ZZjxdQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CZTgDN84 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CZTgDN84 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeCCWqK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:46:10 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935561AbeCCWl4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 48/63] sched: Stop resched_cpu() from sending
 IPIs to offline CPUs
Thread-Topic: [PATCH AUTOSEL for 3.18 48/63] sched: Stop resched_cpu() from
 sending IPIs to offline CPUs
Thread-Index: AQHTsz+tHYnQqNO8QkO3qa5+ckEpeg==
Date: Sat, 3 Mar 2018 22:33:39 +0000
Message-ID: <20180303223228.27323-48-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:ufJ1gJzxX9oxEUUmp0hVcCVFdqo8sZWCGCuDMkg6EoBghmQqjOwiA/NP22gNgOrKjlIDvedBUe4m5+GB+qpHAeAYusuEnmf1MHz1oEUeyK79Ae6th1qxISkPt5DcfIwAfd5Kq8/p7d6hoSwbLxxQI5Q27DxzP1l8BzO+MXyiPjW0U+dk8Bj7P85JYL1KQUYfeKAIiMGX1Mv8v1wSocxWdv8tlBp6yehvIeZnKDFNst+if867Rl1xJsJ4yBllYsHj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba2bc6aa-5ec2-4a67-4da8-08d58157f6f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018144F6E96F3DA6226A2B5FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: M/0KwJLosOltCXFr8s4NoQYh6QMcBt/m/qxTtvKmD6xMT6FVrkBB60hZVdqwqxlNjMdgSVhgmHOqRfmvPtQjzpsHuNkrAGQfr39QV7MrmK1lG0m4O1I2vFSgYx3xZwtR/2GtpLIe7TaYi44Jb9Qk/PZgel/wU7DvYz6AJCNeRQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2bc6aa-5ec2-4a67-4da8-08d58157f6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:39.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 5c64c714ad08..3ff883ec2e52 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -633,7 +633,8 @@ void resched_cpu(int cpu)
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
