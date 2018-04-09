Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235871-2-1017072639455047177
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
    1523235870; b=YsYTvAYcCCi9NGVQiW6qj8u45qiyeJE5WPzqIPESkBDfPQRi6O
    dMj/hhJ5APf55PZwTYkPHIW6f9s9Cm7WRiUpOCSZJ1l5HT16UGWhUCNsnC+d50BX
    6fZG92yjvAQ3QEdb9uW52Qc/xCYkN8kPj1Se43pIaElZgAMvryYbFD43x8bQe2Oy
    6ny8itL8qk7edPXL+x7FcQO4R2kFwlmbMsPQ/t02XEElYJqowk4QJlSZ9r1lb62G
    YHm1M1VK9JHsKRHtFtyxPEMSCSVWmuUAxW4lvz1230ip9/Ggbl74TqPvSPJRM/dL
    W6tYhPuotgUQYyiztVoTO65s9VAtJ6Li0Tcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235870; bh=zTcojvna5B
    cA/8Pq1A5slMrcw+FrV6v3dpHWfx8jr3w=; b=nuI9/eElGONQd0m2nABOyJ/R2O
    76PdMzYeFUpuThRmz7/nixVZLBFQneX+QxMIxrZrQrUwUX0ueLztiHzpy8EihHV7
    cUOIvqufHrnrh4eLX3czisnNf6ba0Q8s2pde0nRKeEc0clso3arkyEY8Ibb10Adk
    uaM9Q4kSOuz5lbiAvF464doB2JWxsk7YPUNfI9/8dLsQNL6B5wNUT/Hq4dU2DCn6
    TWOV2gUd6HA/RHLKmeKODFZbGLBN21n1VmqPv1z8vAeSSCp6x7CniX/KoxV2V6es
    1AzSO0FOhM6xG0bCvJE+UQWz7aZhOlNFohyUwM7/2DL4+6yowRdmKhZQ01bQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Buf+RTkD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Buf+RTkD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPRWbcNW6oObR0ZZyDYpeZWEAjxmRp7CV4oIa5Fg2tBsOaKntJRluwIYXx/Bn7YwrFY/eX/hWnB4U1X3MthCXUom3gEd/BeJJG/UwWn3AyTVfTDNLohR
    neEbOvLMmxTdSAGSD/aJq0pFPB6QzJJZP1EtrQ/ciunbTP1jvRdXE2BXXm3mpvuBfatpY11TajlAhu/TmwVn9Sy8ap1NapLrR6NFQ0kFbL+WokFwrb8rnOCZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=-xatWzGfyKS8k81ClTMA:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeDIBDh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:03:37 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:50200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933056AbeDIAje (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mark Salter <msalter@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 162/162] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Topic: [PATCH AUTOSEL for 4.4 162/162] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Index: AQHTz5njjEL0XCokWEuoHa9G5sSZQA==
Date: Mon, 9 Apr 2018 00:29:57 +0000
Message-ID: <20180409002738.163941-162-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:3KqszXrucrisiMEoY93ZFOZSIN6Mi+k4b8LyunMnmWxW90Y2cITR/Ku++1JZ/A/yyIwSFe+/lOVCyflXftWNU7L+wGBUBD6Dg7FbiuC8gQ8QFUVlveLdpPuvm3UWTN0ohSG7BcIuIjoIrGHWYBofEwH7l0DTsdfpA7VoOfdwMyJspSFzpWKyB3PvBDBEaxSUioZO2u37lIuvYN9WYMnMYYTfuCtZer1Es9V8kVDiGr4L8+hGpnss80sLkwn2GjpH;20:fKt6rXsoTG4qO+ldw536XhdXs/3yogpqHPtgFk6LTlJ8DfxA4klZr+hunqQs+YzfIbLhpUqSTVn6nAb8CfvmafEVuV6bIa7G9eYbCqW4/cOJX6Z1qNjVI8EoyPvHuMscctJ9J+9NXi1h+pH7/orMA3VDwHQG3+HMbG3SGy4p+nQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 132e0c81-a4fd-48b9-808e-08d59db257cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047455A5A30573C85873B7BFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(15650500001)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xLhDSVWt6W0SJygl6m7ieZQ55s9dkNEe2hf7ekEdMXLa9XvtvVr8OmFVelSdO/yeQCPCKC6g+kjzVnp/TG2VwslISHoqPz6a2gH2iTqF/vkH0cRAU6vjbekiKXJMKWr/5yhDTF6IC4WJmb4Jjt/NLzY2KF3K0gRq8NyZdtJmqC1M5DHfUnQhp8oZa8fTrZonHQ95RPHmgME4FzhI5U+72pCupKAxUqeDlFGL43mG0O4zxxs5xclhmJvlEXiXSqDFf1CsX+RYoZxGvmHm6pJzPnDOODE1HcAESEgp3+yKAB2zsXFOzE0FMlA680aePr8zhcVlyKHo2eOFstomwkJvSywHaEDeKQTdZdtgCKz8i92XfG5VseflcAHatTnUi0RDu66EC6sTbMxEWhZdN9C3xubdVOX786cTltyyD+aHz48=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e0c81-a4fd-48b9-808e-08d59db257cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:57.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index eed31f9bee05..cb0d0caadc3f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -589,7 +589,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, uns=
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
