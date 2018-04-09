Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244686-2-13058258493831941104
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
    1523244686; b=X7isVuJrG5GbDtLvIdID8vVmIzx1bAPyL965ky695f+TOSfpYI
    +kttfcgxJ32eph/GS2vH7mdHSIiVKSrqcLEQqN9KLrZ/Y5JrKeC8RNjii+a1wMRm
    UFn0JerNA95AaA0mvKp/bwSQkIB0jc1eeuD0bvJIMTCuCF6rWqWgZ4utE/kJNR64
    wUCHnNz61qOoLWIxuwZ2wxPtbaf+p75sy6zd+J3+qSo1bY1jGQHWFR9x/QWaaDQV
    GvkmgUziI69BJbou5UWV1shDPwWmMj07DzJajP3Kwrhp9CrfgXdwsaXuSHoKTzAT
    +Kn1aibXfBDBEZPZHF36EpaZ33cHUj2HWpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244686; bh=L6FAVFfdLu
    yoiD+53t6MQiLkPza4klPuHWuTS7sLyBI=; b=qjoC3CTIPul59Q47PeuXCPJbqp
    G6opNnO66BdU0LWP47oT/ooB81Nl70WethF5W8T0VWMpIr+fGoZ2NZgRlFkRgdp5
    YrQHgrzhIXo5izn94JqJKT+KkEXVoKQ8/izWXT3Yk4gQMA8Pv5kzPIH0qcrM+Eal
    CkidA+s4/FMB590RzallYWffkCTUp5go6xHmADaftb+xX+wp78bzNZwj/Wxv9YZR
    aPmPSf/dRFJeYb436w1SqZI7ifH2Di6eLn9wIQKaDOUvc/M9CueUeTIxBCy3/jPo
    uh0IUfuJ1ls4d1y7yXdSglp17HWzn7fPOC6FjFDzf2HcAIZzjl44MihX6bBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g+I+6M3w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g+I+6M3w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD5+6bBrS00eO55KHmJWpaLJkjL+GWPRCsJnuv/fM4bfLQQ5zlopyXgNFfYr9KF0l8Yc3nc/oDdGhFSST6RcXuZNYSoQURGNDLTsB2WAN7CNy4mW1+Fy
    nlnOZBV8fWgREFfXjAOXoT8VuR3wezgxUH1Jbds6107YDD4e3Fc/9JsR9DEIu8qNHHZA3i3z768WzvS9Ywki5sJ10rIpD+rc/zZmtRsTWhGyj0G6CizQ4shd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=-xatWzGfyKS8k81ClTMA:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDIDbJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:31:09 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754539AbeDIAV4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mark Salter <msalter@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 189/189] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Topic: [PATCH AUTOSEL for 4.15 189/189] irqchip/gic-v3: Change pr_debug
 message to pr_devel
Thread-Index: AQHTz5hmQGDu72S6K0K7uBH3TTss2w==
Date: Mon, 9 Apr 2018 00:19:18 +0000
Message-ID: <20180409001637.162453-189-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:bigFZzixCXt1E2rKLHtLQj0qAD+hJiAyQIFtw5v+2fs15UBNIN1+WtAuBpXtMckUV4s3TSSyhIG9iPtORh6xBl/vyiTbr2+DDsy/Q+9rLsK7cEGX9ywCelfgIcusI+v/maO5iEoHFCs5xKgsTQbTNoC5RSj9wO8TJqWMAVpdQ4fjMcD3nYH1oJg3xJUy8hjeM0+lI2bVaxnShMC6KBGp/94lJybGnzkC0Yz4Rwpl3Q6hiJA4xCyRtJybR7MdQu2k;20:0/c7mjxHafrBZwUV1Z+Lk8l0YukzFYFS2XCoe/JOU4IkNI6SrjvMvFXnjvU6wUj+UrYNnVHjjfMw/htbU/PNIW9luUIc8EcllCWPvPkqQ7gbgAEaztngRjBlqzM8cww82tfxE1mqBHW2CQRiNOpOFUiAUxEbq5LpRaIXFPwF6eY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fa8a0f8-2d8a-451c-2dfe-08d59dafe57b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093626AC2E3E1A9329190727FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(15650500001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sW5fU8fimFDsHxb4B4ROIcwF9/QoNVMEAO3mzKRPGWlKyLnTsOuQDv/2IGvsZL9wb8tIpfT3+sSunyF2m/IZ+M7FlTWqPpV3sYl0UFuba/bkFHxIXQNxpMlD0crVN2GrJuAv2tmlvHr44qdmgewnZ6bGlNwwu/gr/u5vEWFfbjOArrDsBvFyi18GZ+dbVu9s+fO+qWtkDrFjkm5mmYo8ln+v/0Jrh1PUgJtrMFh2+oUXLfI2s/2oGd4O8eziyENhSxng6Mzj+a2CNoa2o80fNHE3npy1VjAbPegtdALaB0gevY15hvHuODLrMsMvOTXtaJYJ2qOLIDu93dvxFu67fu14VaUkbTH4CjPh1EiMXlv4L7B2DEDET37RNs+JEizhspI/EO6e/pf6Lkw0BjKYFBqLv+eKCbPASwl9XCwvs1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa8a0f8-2d8a-451c-2dfe-08d59dafe57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:18.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 980ae8e7df30..0b73cbae9dae 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -673,7 +673,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, uns=
igned int irq)
 	       MPIDR_TO_SGI_RS(cluster_id)		|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
=20
-	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
+	pr_devel("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
 	gic_write_sgi1r(val);
 }
=20
--=20
2.15.1
