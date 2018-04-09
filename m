Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239507-2-9961771862446561273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239506; b=TkkFEn7VCoo3OjzWogH02glxESFs0HmQscjOu87DbFpVK5lqKU
    HiNew7vTEp9/2GY0XK29B92RQSS952CUfHmNJxqe5CvRpZbxHm9bUujrESlVOUI9
    V5L0ohPdpMOq6cBZEY77MMbn0J9umAYXS9+Ylj3Ffmw6HPaa/i7zjPqmxQsHAHkf
    JRuPbMHSXgOlw9VDnRWpy9g5WL98EfRsB/B9n2U/8FYMcJ6nLxL0Lss+ky/wl8tT
    EKHFM0m5LqbmM839hbHSnKw+9OC/X0sjzRrMNwkRGjQ4jGFnSAJDUHPkoPcxE2IP
    fHM3EliwAMgQTKW9q1Hf1RvUqjA/bo71yABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239506; bh=PbYxSaU4Gy
    XNRGN/JZ9u5BHlUUjDEZ1Q82t4l6YPzyw=; b=YU6zt1UESigX0CfN5qCQqRPAG4
    KtlT2S+M91vb7aPLpkhCX3aipJzt0vOTpPfeJYxHMiZ1A2kt2UHyqh+Fl6GjmsBY
    Qx8OVwmux+qFR9zDFNHD50vVAlFnBfoYf42Td1W5NNbiJzm9/uzPMeHRb4AL7G1E
    YDcFI/4Zq/QTEaJ8ONa6SuA9Mxc+f5Uk3WrjIYii+eyk6We33KOad44dzRBiXmd4
    em0jmzrsqCvGPTKqLsXTCbtNmMEmkONEI2zaRaH8Op3NUjc/TWQdjHPHIZWRKz33
    OfyyciVS8SOIE+w6fwwlXxPBZuPxfaxi1+AfLKKfKpUSq9i5r9bverPchW2g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaeY0jn4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaeY0jn4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIDIqwtA6+HeImlewVMqQSfeBpuxAdKiSAERUotnusCe6ZTxBirXeU+ZSAYteN5eqYv3LbU3+G4wkpINIjX8x5wtYAdJ7mZlQEtVuWJY1US1jUK+Ivgf
    UtGftQPRTvh2dAkV6QNTxEpCPyRrb3gyG8oN1NFiJD2y/GeW0vOIM73IcRP3oekbRaKmTco0Ab9Qr2+7wfqCJBlwhgx4k1atwfc1Bb0AENNllK3mC/gOs57f
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=IUqagsr5woBtfdQQkWYA:9
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757722AbeDICE6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:04:58 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756375AbeDIAcA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 186/293] arcnet: change irq handler to lock
 irqsave
Thread-Topic: [PATCH AUTOSEL for 4.9 186/293] arcnet: change irq handler to
 lock irqsave
Thread-Index: AQHTz5k9xRhQ573zAUiI4DiC/fbHRA==
Date: Mon, 9 Apr 2018 00:25:19 +0000
Message-ID: <20180409002239.163177-186-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:zAbYfhYyEmqU5RYg0++gunVN6gpslKFXGc7rWaUTHI1nvnoD3fmS+t85+TR3vGTPOE1ObiNlVZyDw7uzz6ll/SBB1IXZRKYGflwvU3Q1HSGWytH1OBx1ZxwOFqYhmCTHmq4pfKOMI/Akv+AW6BaZRDBvzXt179IyUVEne1D8ESoEN9nvCQF+hBLP+wXOJejisnONMIHeETp8lV/WpPa0uFYJYwhm1BYG1RD+08u5HCrTFscgLwMiKExjNUqbC3c6;20:P5D9aVmqgIhXIc1Uljfwm9/KZGXamc3YA4aiqDBWixmZITf1aLh8plSCJoIK8i7vEqZiuNsmBEn1DYfAXs3/pegttbPTDZrKNVEv7HaD6Xi6k5lRqJJfzRURDWYaqg7YH3pcdRI/MRfDUtiWLelEMhQ/rUH457CsZeJ4K+rEEAU=
X-MS-Office365-Filtering-Correlation-Id: 5099ba1b-df1c-43be-9362-08d59db14dcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11263E24974FA00F2C922EAAFBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JrZLRITMwynEQpze/VZVvffHZh0Kq3VgpvTApoHVK0zeVblXSphKXlOyOYK6jklfZHrfLQkU85JoTa9JT0YKibIfusVB56vJfe5Mqs/AmZB1crXMtTgVTDzyNJmvAkoEvVOe08FaQssho6OpNeIskONhtHUp3P3Fxg5HXkMapNDKMvi8JIXlfPzSR7qkSUdh4cx2pD6kkfEIhzXTcyGIULGTOSTnhM8ahI2D0PiJhpFXmR6LMlzfmMPh71bm0s2WcVSw1xVZE/JwHiiAxFY2+bXCND7lDBBi90bYod1fnBumVYQ3d9yu/brNlAuPhf4y/RUlH2PWm5Z591QFfwqiC6No088wtoqHd6Mnzljd5ogRurEIWUBB8KPxkX4a+yruU1rf2Oy2wcVPkXXc5jDmd3yxtUxP7nXfBu1h1AlRIVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5099ba1b-df1c-43be-9362-08d59db14dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:19.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 5b85840320151f61e04d83a23ef2567a07094503 ]

This patch prevents the arcnet driver from the following deadlock.

[   41.273910] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   41.280397] [ INFO: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected ]
[   41.287433] 4.4.0-00034-gc0ae784 #536 Not tainted
[   41.292366] ------------------------------------------------------
[   41.298863] arcecho/233 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
[   41.305628]  (&(&lp->lock)->rlock){+.+...}, at: [<bf083bc8>] arcnet_send=
_packet+0x60/0x1c0 [arcnet]
[   41.315199]
[   41.315199] and this task is already holding:
[   41.321324]  (_xmit_ARCNET#2){+.-...}, at: [<c06b934c>] packet_direct_xm=
it+0xfc/0x1c8
[   41.329593] which would create a new lock dependency:
[   41.334893]  (_xmit_ARCNET#2){+.-...} -> (&(&lp->lock)->rlock){+.+...}
[   41.341801]
[   41.341801] but this new dependency connects a SOFTIRQ-irq-safe lock:
[   41.350108]  (_xmit_ARCNET#2){+.-...}
... which became SOFTIRQ-irq-safe at:
[   41.357539]   [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.362677]   [<c063ab8c>] dev_watchdog+0x5c/0x264
[   41.367723]   [<c0094edc>] call_timer_fn+0x6c/0xf4
[   41.372759]   [<c00950b8>] run_timer_softirq+0x154/0x210
[   41.378340]   [<c0036b30>] __do_softirq+0x144/0x298
[   41.383469]   [<c0036fb4>] irq_exit+0xcc/0x130
[   41.388138]   [<c0085c50>] __handle_domain_irq+0x60/0xb4
[   41.393728]   [<c0014578>] __irq_svc+0x58/0x78
[   41.398402]   [<c0010274>] arch_cpu_idle+0x24/0x3c
[   41.403443]   [<c007127c>] cpu_startup_entry+0x1f8/0x25c
[   41.409029]   [<c09adc90>] start_kernel+0x3c0/0x3cc
[   41.414170]
[   41.414170] to a SOFTIRQ-irq-unsafe lock:
[   41.419931]  (&(&lp->lock)->rlock){+.+...}
... which became SOFTIRQ-irq-unsafe at:
[   41.427996] ...  [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.433409]   [<bf083d54>] arcnet_interrupt+0x2c/0x800 [arcnet]
[   41.439646]   [<c0089120>] handle_nested_irq+0x8c/0xec
[   41.445063]   [<c03c1170>] regmap_irq_thread+0x190/0x314
[   41.450661]   [<c0087244>] irq_thread_fn+0x1c/0x34
[   41.455700]   [<c0087548>] irq_thread+0x13c/0x1dc
[   41.460649]   [<c0050f10>] kthread+0xe4/0xf8
[   41.465158]   [<c000f810>] ret_from_fork+0x14/0x24
[   41.470207]
[   41.470207] other info that might help us debug this:
[   41.470207]
[   41.478627]  Possible interrupt unsafe locking scenario:
[   41.478627]
[   41.485763]        CPU0                    CPU1
[   41.490521]        ----                    ----
[   41.495279]   lock(&(&lp->lock)->rlock);
[   41.499414]                                local_irq_disable();
[   41.505636]                                lock(_xmit_ARCNET#2);
[   41.511967]                                lock(&(&lp->lock)->rlock);
[   41.518741]   <Interrupt>
[   41.521490]     lock(_xmit_ARCNET#2);
[   41.525356]
[   41.525356]  *** DEADLOCK ***
[   41.525356]
[   41.531587] 1 lock held by arcecho/233:
[   41.535617]  #0:  (_xmit_ARCNET#2){+.-...}, at: [<c06b934c>] packet_dire=
ct_xmit+0xfc/0x1c8
[   41.544355]
the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
[   41.552362] -> (_xmit_ARCNET#2){+.-...} ops: 27 {
[   41.557357]    HARDIRQ-ON-W at:
[   41.560664]                     [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.567445]                     [<c063ba28>] dev_deactivate_many+0x114/0=
x304
[   41.574866]                     [<c063bc3c>] dev_deactivate+0x24/0x38
[   41.581646]                     [<c0630374>] linkwatch_do_dev+0x40/0x74
[   41.588613]                     [<c06305d8>] __linkwatch_run_queue+0xec/=
0x140
[   41.596120]                     [<c0630658>] linkwatch_event+0x2c/0x34
[   41.602991]                     [<c004af30>] process_one_work+0x188/0x40=
c
[   41.610131]                     [<c004b200>] worker_thread+0x4c/0x480
[   41.616912]                     [<c0050f10>] kthread+0xe4/0xf8
[   41.623048]                     [<c000f810>] ret_from_fork+0x14/0x24
[   41.629735]    IN-SOFTIRQ-W at:
[   41.633039]                     [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.639820]                     [<c063ab8c>] dev_watchdog+0x5c/0x264
[   41.646508]                     [<c0094edc>] call_timer_fn+0x6c/0xf4
[   41.653190]                     [<c00950b8>] run_timer_softirq+0x154/0x2=
10
[   41.660425]                     [<c0036b30>] __do_softirq+0x144/0x298
[   41.667201]                     [<c0036fb4>] irq_exit+0xcc/0x130
[   41.673518]                     [<c0085c50>] __handle_domain_irq+0x60/0x=
b4
[   41.680754]                     [<c0014578>] __irq_svc+0x58/0x78
[   41.687077]                     [<c0010274>] arch_cpu_idle+0x24/0x3c
[   41.693769]                     [<c007127c>] cpu_startup_entry+0x1f8/0x2=
5c
[   41.701006]                     [<c09adc90>] start_kernel+0x3c0/0x3cc
[   41.707791]    INITIAL USE at:
[   41.711003]                    [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.717696]                    [<c063ba28>] dev_deactivate_many+0x114/0x=
304
[   41.725026]                    [<c063bc3c>] dev_deactivate+0x24/0x38
[   41.731718]                    [<c0630374>] linkwatch_do_dev+0x40/0x74
[   41.738593]                    [<c06305d8>] __linkwatch_run_queue+0xec/0=
x140
[   41.746011]                    [<c0630658>] linkwatch_event+0x2c/0x34
[   41.752789]                    [<c004af30>] process_one_work+0x188/0x40c
[   41.759847]                    [<c004b200>] worker_thread+0x4c/0x480
[   41.766541]                    [<c0050f10>] kthread+0xe4/0xf8
[   41.772596]                    [<c000f810>] ret_from_fork+0x14/0x24
[   41.779198]  }
[   41.780945]  ... key      at: [<c124d620>] netdev_xmit_lock_key+0x38/0x1=
c8
[   41.788192]  ... acquired at:
[   41.791309]    [<c007bed8>] lock_acquire+0x70/0x90
[   41.796361]    [<c06f9140>] _raw_spin_lock_irqsave+0x40/0x54
[   41.802324]    [<bf083bc8>] arcnet_send_packet+0x60/0x1c0 [arcnet]
[   41.808844]    [<c06b9380>] packet_direct_xmit+0x130/0x1c8
[   41.814622]    [<c06bc7e4>] packet_sendmsg+0x3b8/0x680
[   41.820034]    [<c05fe8b0>] sock_sendmsg+0x14/0x24
[   41.825091]    [<c05ffd68>] SyS_sendto+0xb8/0xe0
[   41.829956]    [<c05ffda8>] SyS_send+0x18/0x20
[   41.834638]    [<c000f780>] ret_fast_syscall+0x0/0x1c
[   41.839954]
[   41.841514]
the dependencies between the lock to be acquired and SOFTIRQ-irq-unsafe loc=
k:
[   41.850302] -> (&(&lp->lock)->rlock){+.+...} ops: 5 {
[   41.855644]    HARDIRQ-ON-W at:
[   41.858945]                     [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.865726]                     [<bf083d54>] arcnet_interrupt+0x2c/0x800=
 [arcnet]
[   41.873607]                     [<c0089120>] handle_nested_irq+0x8c/0xec
[   41.880666]                     [<c03c1170>] regmap_irq_thread+0x190/0x3=
14
[   41.887901]                     [<c0087244>] irq_thread_fn+0x1c/0x34
[   41.894593]                     [<c0087548>] irq_thread+0x13c/0x1dc
[   41.901195]                     [<c0050f10>] kthread+0xe4/0xf8
[   41.907338]                     [<c000f810>] ret_from_fork+0x14/0x24
[   41.914025]    SOFTIRQ-ON-W at:
[   41.917328]                     [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.924106]                     [<bf083d54>] arcnet_interrupt+0x2c/0x800=
 [arcnet]
[   41.931981]                     [<c0089120>] handle_nested_irq+0x8c/0xec
[   41.939028]                     [<c03c1170>] regmap_irq_thread+0x190/0x3=
14
[   41.946264]                     [<c0087244>] irq_thread_fn+0x1c/0x34
[   41.952954]                     [<c0087548>] irq_thread+0x13c/0x1dc
[   41.959548]                     [<c0050f10>] kthread+0xe4/0xf8
[   41.965689]                     [<c000f810>] ret_from_fork+0x14/0x24
[   41.972379]    INITIAL USE at:
[   41.975595]                    [<c06f8fc8>] _raw_spin_lock+0x30/0x40
[   41.982283]                    [<bf083d54>] arcnet_interrupt+0x2c/0x800 =
[arcnet]
[   41.990063]                    [<c0089120>] handle_nested_irq+0x8c/0xec
[   41.997027]                    [<c03c1170>] regmap_irq_thread+0x190/0x31=
4
[   42.004172]                    [<c0087244>] irq_thread_fn+0x1c/0x34
[   42.010766]                    [<c0087548>] irq_thread+0x13c/0x1dc
[   42.017267]                    [<c0050f10>] kthread+0xe4/0xf8
[   42.023314]                    [<c000f810>] ret_from_fork+0x14/0x24
[   42.029903]  }
[   42.031648]  ... key      at: [<bf0854cc>] __key.42091+0x0/0xfffff0f8 [a=
rcnet]
[   42.039255]  ... acquired at:
[   42.042372]    [<c007bed8>] lock_acquire+0x70/0x90
[   42.047413]    [<c06f9140>] _raw_spin_lock_irqsave+0x40/0x54
[   42.053364]    [<bf083bc8>] arcnet_send_packet+0x60/0x1c0 [arcnet]
[   42.059872]    [<c06b9380>] packet_direct_xmit+0x130/0x1c8
[   42.065634]    [<c06bc7e4>] packet_sendmsg+0x3b8/0x680
[   42.071030]    [<c05fe8b0>] sock_sendmsg+0x14/0x24
[   42.076069]    [<c05ffd68>] SyS_sendto+0xb8/0xe0
[   42.080926]    [<c05ffda8>] SyS_send+0x18/0x20
[   42.085601]    [<c000f780>] ret_fast_syscall+0x0/0x1c
[   42.090918]
[   42.092481]
[   42.092481] stack backtrace:
[   42.097065] CPU: 0 PID: 233 Comm: arcecho Not tainted 4.4.0-00034-gc0ae7=
84 #536
[   42.104751] Hardware name: Generic AM33XX (Flattened Device Tree)
[   42.111183] [<c0017ec8>] (unwind_backtrace) from [<c00139d0>] (show_stac=
k+0x10/0x14)
[   42.119337] [<c00139d0>] (show_stack) from [<c02a82c4>] (dump_stack+0x8c=
/0x9c)
[   42.126937] [<c02a82c4>] (dump_stack) from [<c0078260>] (check_usage+0x4=
bc/0x63c)
[   42.134815] [<c0078260>] (check_usage) from [<c0078438>] (check_irq_usag=
e+0x58/0xb0)
[   42.142964] [<c0078438>] (check_irq_usage) from [<c007aaa0>] (__lock_acq=
uire+0x1524/0x20b0)
[   42.151740] [<c007aaa0>] (__lock_acquire) from [<c007bed8>] (lock_acquir=
e+0x70/0x90)
[   42.159886] [<c007bed8>] (lock_acquire) from [<c06f9140>] (_raw_spin_loc=
k_irqsave+0x40/0x54)
[   42.168768] [<c06f9140>] (_raw_spin_lock_irqsave) from [<bf083bc8>] (arc=
net_send_packet+0x60/0x1c0 [arcnet])
[   42.179115] [<bf083bc8>] (arcnet_send_packet [arcnet]) from [<c06b9380>]=
 (packet_direct_xmit+0x130/0x1c8)
[   42.189182] [<c06b9380>] (packet_direct_xmit) from [<c06bc7e4>] (packet_=
sendmsg+0x3b8/0x680)
[   42.198059] [<c06bc7e4>] (packet_sendmsg) from [<c05fe8b0>] (sock_sendms=
g+0x14/0x24)
[   42.206199] [<c05fe8b0>] (sock_sendmsg) from [<c05ffd68>] (SyS_sendto+0x=
b8/0xe0)
[   42.213978] [<c05ffd68>] (SyS_sendto) from [<c05ffda8>] (SyS_send+0x18/0=
x20)
[   42.221388] [<c05ffda8>] (SyS_send) from [<c000f780>] (ret_fast_syscall+=
0x0/0x1c)

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

   ---
   v1 -> v2: removed unneeded zero assignment of flags
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/arcnet/arcnet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 6ea963e3b89a..915d55337e4c 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -756,6 +756,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 	struct net_device *dev =3D dev_id;
 	struct arcnet_local *lp;
 	int recbuf, status, diagstatus, didsomething, boguscount;
+	unsigned long flags;
 	int retval =3D IRQ_NONE;
=20
 	arc_printk(D_DURING, dev, "\n");
@@ -765,7 +766,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 	lp =3D netdev_priv(dev);
 	BUG_ON(!lp);
=20
-	spin_lock(&lp->lock);
+	spin_lock_irqsave(&lp->lock, flags);
=20
 	/* RESET flag was enabled - if device is not running, we must
 	 * clear it right away (but nothing else).
@@ -774,7 +775,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 		if (lp->hw.status(dev) & RESETflag)
 			lp->hw.command(dev, CFLAGScmd | RESETclear);
 		lp->hw.intmask(dev, 0);
-		spin_unlock(&lp->lock);
+		spin_unlock_irqrestore(&lp->lock, flags);
 		return retval;
 	}
=20
@@ -998,7 +999,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 	udelay(1);
 	lp->hw.intmask(dev, lp->intmask);
=20
-	spin_unlock(&lp->lock);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return retval;
 }
 EXPORT_SYMBOL(arcnet_interrupt);
--=20
2.15.1
