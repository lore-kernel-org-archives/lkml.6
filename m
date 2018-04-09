Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234637-2-5387043954697277937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234636; b=mVfTqRqqI0tFLsbPTtUFT0eas/wXHGTmB4NdLYwpWirygzET+f
    Wbpg9WiTPRC75oKBDDM5xwLeVWQwLzj7qL/DXi715Oy2DKgn10WiY92q45r+ePNq
    fZxYyEnB/iS5vk2kjYZ5tkftI3RC0+qPgJHT890C6LXfArUdooxbOYzt00lbWZMt
    BVdeFbZIpiyvPo4iItobjxULMJ3INr3GLXhkonrT5AeDYDolLXgVNDCeMCOqOz8M
    3pG/5ENqOzWpBJejiNLg17AMHJHvAVntsoPIs2rGsEwdLgfJ2O2na5Jdqav+sdyO
    VjelkpRdMbSjiilmZxZ8miEmd7ix4bAPDG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234636; bh=l9Qh9daUiC
    JOtiFVeI7ZVtEog8KCK7r9m58IgC1W1/o=; b=QsogK26Ktky38xonDxxUjIPAww
    67ddWCD5FSP1QCGD/skNGNfN911W16mU1sLpXnMyHo1oKlGJVHPzfqOH+yYi7yPJ
    PgrpIxwOxxlYQaQkwzF/szNs76VsL2pgpikM1rMm34kGDC+apAL05v4ZMJKtRHrt
    0VNeJJUQlENtAuqgeuhK7/+ptvqZLEaDMxXF1eePT6vdjesPk1uGf8JgxAVyIScJ
    gAHskaEo2ud9Ovum4jdZuBrNtIs8oGpagw1yPi7vXI58DJqzUOp0aAmorjkNy663
    /JGANo3OEJCZuNhKMoHWEplro8FL0ibkrsBiK4P0wl+OPXLBxpHp1FF+fkrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eozvAQx8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eozvAQx8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMYoFE7Jt9ndZO771qawD38L1kwJ+xNK2SZvZBJG0FZxVAAiMCmGIQYFUuMDE1MS5X7gI1XJo2TaxBQraM+nXK+DyJN+EEcmu1xYpFl3aBNWXBF8x/FF
    xNMClCam+UCMER67OVemQz2miy0tmrD3x4Eh6dsisrA8EwWO6gc61w22gB/QCfh5Sf2vlqVNfnbOSH1x7EL1sJaSAodoompzDDBSc0dgjPeiFbI/h4Gvibvq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=-xatWzGfyKS8k81ClTMA:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeDIAnW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:43:22 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:59745
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756794AbeDIAmf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mark Salter <msalter@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 101/101] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Topic: [PATCH AUTOSEL for 3.18 101/101] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Index: AQHTz5uP+MoLNiNrBU290svySM1EeQ==
Date: Mon, 9 Apr 2018 00:41:55 +0000
Message-ID: <20180409004042.164920-51-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1029;7:fFoXy6f1/jkHSYU7R6+KEIjZco7nS0SC3lNZ/ukA4Un6HkDqvNs/DNrj3oQT+i9FkXGKpufToUHdHE9ZnyVIxmT+uGmrnLs80UocemrvBgIUGhQ7UDQdzdtduXKSoXORbYU2/nGxIuVvCqTEc931l+JHI+r9bO9lh73vnZmYK+zCGGXc5Xx8oO5K7RnbRej6n9n2MpSQaHlqX3M6gGShYC8LB0gZjIWVqaSZsayWBwDC+/m7f9AE7z2NXuVmkQ3e;20:baAKljSfGuNc0qAtwwXebOpHWAyvnoG6hyRAPfpHiNxZCE/namoBNf0mXNlNinfONFDCQGutlYB5unWN4pO6AIGBcN6+qT/cejHst0CEpoYAUG4sI27dy2P2huV2vqQTEU71fekds/0b/sYK1NCu68GGGO/tETwzEIhnudCZwOM=
X-MS-Office365-Filtering-Correlation-Id: 70008c1c-bb5d-40ad-7d6e-08d59db2c617
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1029;
x-ms-traffictypediagnostic: DM5PR2101MB1029:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1029ECE2EA1D57B060C2CB50FBBF0@DM5PR2101MB1029.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1029;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1029;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(22452003)(99286004)(68736007)(186003)(6506007)(26005)(2616005)(6486002)(86362001)(15650500001)(11346002)(486006)(305945005)(59450400001)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(8936002)(8676002)(6512007)(81166006)(81156014)(2906002)(6436002)(36756003)(14454004)(86612001)(10090500001)(54906003)(2501003)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1029;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d/18/eAQwjAV9moiXF0j8YTNpHxErKIggRjGVQjzhFyxtH0vWCIcG4YaQ7NDOzs1CrUZOlvtOSGqTn9CpvqES5WChcbjL42mpYEskzPNm7tWhXP107KbHSaBj6GdAEebif5qgKVp7MAew2ltk9E0lBSVQdTqukt3dpw7s2vmDEm0k27oYGud2JVb2vACx3z4kI8Z1YZjdV8rnzHVkg29a/6sDpPUtUxiBYA3P3ccEm/u2f6lV/91Po33APEnwUqQH8rA3AK4UoXCCrYiMRgyzSQrBKEvTt55CixnDjFUrepF9NHKnbw5ZTL6WmTxsuEgFMVOarwPKz9mUhn1hwm3Mv/JVjgtIn1BFYyZzscvl+7dQVaORIicpStlOs5R/0GKdwjWT/VqJM8Ii/Fdpr4YLuJxo+XHmbw3DOvoljLqEpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70008c1c-bb5d-40ad-7d6e-08d59db2c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:55.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1029
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mark Salter <msalter@redhat.com>

[ Upstream commit b6dd4d83dc2f78cebc9a7e6e7e4bc2be4d29b94d ]

The pr_debug() in gic-v3 gic_send_sgi() can trigger a circular locking
warning:

 GICv3: CPU10: ICC_SGI1R_EL1 5000400
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 4.15.0+ #1 Tainted: G        W
 ------------------------------------------------------
 dynamic_debug01/1873 is trying to acquire lock:
  ((console_sem).lock){-...}, at: [<0000000099c891ec>] down_trylock+0x20/0x=
4c

 but task is already holding lock:
  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&rq->lock){-.-.}:
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock+0x4c/0x60
        task_fork_fair+0x3c/0x148
        sched_fork+0x10c/0x214
        copy_process.isra.32.part.33+0x4e8/0x14f0
        _do_fork+0xe8/0x78c
        kernel_thread+0x48/0x54
        rest_init+0x34/0x2a4
        start_kernel+0x45c/0x488

 -> #1 (&p->pi_lock){-.-.}:
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock_irqsave+0x58/0x70
        try_to_wake_up+0x48/0x600
        wake_up_process+0x28/0x34
        __up.isra.0+0x60/0x6c
        up+0x60/0x68
        __up_console_sem+0x4c/0x7c
        console_unlock+0x328/0x634
        vprintk_emit+0x25c/0x390
        dev_vprintk_emit+0xc4/0x1fc
        dev_printk_emit+0x88/0xa8
        __dev_printk+0x58/0x9c
        _dev_info+0x84/0xa8
        usb_new_device+0x100/0x474
        hub_port_connect+0x280/0x92c
        hub_event+0x740/0xa84
        process_one_work+0x240/0x70c
        worker_thread+0x60/0x400
        kthread+0x110/0x13c
        ret_from_fork+0x10/0x18

 -> #0 ((console_sem).lock){-...}:
        validate_chain.isra.34+0x6e4/0xa20
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock_irqsave+0x58/0x70
        down_trylock+0x20/0x4c
        __down_trylock_console_sem+0x3c/0x9c
        console_trylock+0x20/0xb0
        vprintk_emit+0x254/0x390
        vprintk_default+0x58/0x90
        vprintk_func+0xbc/0x164
        printk+0x80/0xa0
        __dynamic_pr_debug+0x84/0xac
        gic_raise_softirq+0x184/0x18c
        smp_cross_call+0xac/0x218
        smp_send_reschedule+0x3c/0x48
        resched_curr+0x60/0x9c
        check_preempt_curr+0x70/0xdc
        wake_up_new_task+0x310/0x470
        _do_fork+0x188/0x78c
        SyS_clone+0x44/0x50
        __sys_trace_return+0x0/0x4

 other info that might help us debug this:

 Chain exists of:
   (console_sem).lock --> &p->pi_lock --> &rq->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->lock);
                                lock(&p->pi_lock);
                                lock(&rq->lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

 2 locks held by dynamic_debug01/1873:
  #0:  (&p->pi_lock){-.-.}, at: [<000000001366df53>] wake_up_new_task+0x40/=
0x470
  #1:  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc

 stack backtrace:
 CPU: 10 PID: 1873 Comm: dynamic_debug01 Tainted: G        W        4.15.0+=
 #1
 Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS T48 10/02/2017
 Call trace:
  dump_backtrace+0x0/0x188
  show_stack+0x24/0x2c
  dump_stack+0xa4/0xe0
  print_circular_bug.isra.31+0x29c/0x2b8
  check_prev_add.constprop.39+0x6c8/0x6dc
  validate_chain.isra.34+0x6e4/0xa20
  __lock_acquire+0x3b4/0x6e0
  lock_acquire+0xf4/0x2a8
  _raw_spin_lock_irqsave+0x58/0x70
  down_trylock+0x20/0x4c
  __down_trylock_console_sem+0x3c/0x9c
  console_trylock+0x20/0xb0
  vprintk_emit+0x254/0x390
  vprintk_default+0x58/0x90
  vprintk_func+0xbc/0x164
  printk+0x80/0xa0
  __dynamic_pr_debug+0x84/0xac
  gic_raise_softirq+0x184/0x18c
  smp_cross_call+0xac/0x218
  smp_send_reschedule+0x3c/0x48
  resched_curr+0x60/0x9c
  check_preempt_curr+0x70/0xdc
  wake_up_new_task+0x310/0x470
  _do_fork+0x188/0x78c
  SyS_clone+0x44/0x50
  __sys_trace_return+0x0/0x4
 GICv3: CPU0: ICC_SGI1R_EL1 12000

This could be fixed with printk_deferred() but that might lessen its
usefulness for debugging. So change it to pr_devel to keep it out of
production kernels. Developers working on gic-v3 can enable it as
needed in their kernels.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ec8468829aef..b08de05bf627 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -488,7 +488,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, uns=
igned int irq)
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
=20
-	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
+	pr_devel("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
 	gic_write_sgi1r(val);
 }
=20
--=20
2.15.1
