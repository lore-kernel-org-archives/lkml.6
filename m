Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233814-2-8615030191224916089
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
    1523233813; b=aWCCu7usrsBcdoz8wc5Y0wIxTdXDF/PMQ/S900CiZAie5qXhQH
    /i4ujKSKt67KQJKcFwmpRB0hzE7PK08GoVGP9kvc1nI/DYSOiYuUau7TBBba+fQ6
    EQSqUchI7y1qQ2oLzZHEX+o35ZHSjQ7IpyafMURIdfx/4CEKXUbifCxD/9f9KIT0
    ieNeUS7i9g8TYUv54D4T4huDGCQy6uRX4s1Utn7XNFQ78g0hYvtar/GFe8LNrDrY
    vrs9w+cHE1o8exgUMa4BbWfmyjcfpSDYARqREP/0FBlojxUoPIGiyScWmFfaRqoW
    0tncqcuymIKF5+HpMi792AMETQvaDsdsOfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233813; bh=t/zY1GG1w8
    e3DU60BGItVFT+b3jF4Kxx0+f7gMTU06g=; b=LdkUwGD9PGktM1LDKV2FxdSUHj
    tt7zMriKkTJxtcF8w1ha2TdD+bhYO2+8V4mncavNL+y4Iqnz7dJM7XYcx5zEYGwj
    QyNyWsXvl9bwhp2LSkEmTbuJx0ok9HV9o2De9vk8zTaRdPQRz6W26ot75A4ZZ7nn
    6TTOJQ/wAYN54CE8YY9dQimOt4Kwy/+z/BGvPSMVtNfD/FuMu9Fj5WMCwg7MjhtZ
    UW/rutdfLQDwjoEaxiqACWq4cGc7zgin90oH3QiPfiJmu/lPs2qToE+OFZPxTYwO
    JpPbfUZyg/J4e42bntl/S9dKOIP5dcf4ezUWqO/rhaDNiOtozTZuyj0TDKiQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=af24Wb9Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=af24Wb9Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPYAI9ZIuwU989A+AN1kr3FBCiKBpYIbGxbOVdw1Fv3zmEpcrQg7gp9ItI9GxxurNGBHGgr30sVjmPbFOt9IIJxMQg+2t4PPy/7j+dGEoFzz3mErn7J
    CRvGDbgzmQ8FQNJ16CeArxMQJG/SndES8Ti8nsCU06nvNEFhD2YxuOIbFLaz2e4uYc2+ka1d5eOvVH+NygCgk2qy4HwxN91Phvwt3dJNu86R4ZwFDC1cArAJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8
    a=gnAFLUE-NMrtnB6PDwIA:9 a=wPNLvfGTeEIA:10 a=9a9ggB8z3XFZH39hjkD6:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeDIA3t (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:49 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932101AbeDIA3r (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 119/293] irqchip/armada-370-xp: Re-enable
 per-CPU interrupts at resume time
Thread-Topic: [PATCH AUTOSEL for 4.9 119/293] irqchip/armada-370-xp: Re-enable
 per-CPU interrupts at resume time
Thread-Index: AQHTz5kdHxUuK3qSjEiaeMsWS7vg5w==
Date: Mon, 9 Apr 2018 00:24:25 +0000
Message-ID: <20180409002239.163177-119-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:v07iyxXGk1kdQ3z0I2ULRQ36bBGnWDd5EDv/0GYTdZuesNjh6+jAwLUGcI8rpO5ehwC3q1/MbDxFtMryz+LBrNZgIg88JEBxdSAZ7v2PnpVGKGJzWEw54mtam3r4g/a5Yr0xf9qIn+h4K7GtpFWz8tXLEMQjaK11gFUqjUT8c64RURQymKZusVVf56zI02CLGTfjKdk/YYW+EsOCF/U+iD/gbXfyoPDn0tS8HsavpPt0xzLVw2gG1nU1pU9LCkIV;20:XxKqwfqOCNGGTXU+CBYAgeHAHJlJtn+w23/NLZ9Gco+qQUs+DNe3amTQ6YIPx4ndK9HM2xAmykKAcyMhCtpAnWfL7GxNx7/ECUWAuGx9B5k6kvSS75cP7cEn89octCNLPY5PBPpaQMwyuXsDXMJB0hSag42hxb1PkYatYpxFIDg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9e03f67-0ea4-4628-cbf3-08d59db0fcfd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10327B25E2A3E366E7668BEBFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eV7sbAH9awN70QHjab58iKQ3Gk6QmES9rIQ8CulfNVyjZr76JXHZfJy9aD1NWTxqfaa4TCmAaFbD+pV9DfmDnYrKSN3edGJZY5uN+Tb/Di1hmBXJVY5sG/lyykPjP/kW8t57T0khOJExFqvxvIESoH/W5eAX/4Clwh8jeGkp7+D9h619BxU2xZAciRx8SBkBxzBSW99khpBokrI/tveNAeACJAB7Z967+XPLLJTTLWMygKRZsMfSmiumRcFwKt0MYaKatT4+HdEV6l74w5cYr38pnD50DHpNWrb6imRZbXhjCdLPoBD1DDj7HfX6cQ5n49MQ3gp24zsVBBXQWEC6vFoJAXOTpB29XcJc5KG8IahID9imBa7l3zlTAxemtx1OULAfTrAJmpj5ch8ihdK42iq5vNDJnA2JXuzmbUT6aUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e03f67-0ea4-4628-cbf3-08d59db0fcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:25.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[ Upstream commit 0fa4ce746d1d8c8aa3d09fbc675497fa4c4a5475 ]

Commit d17cab4451df1 ("irqchip: Kill off set_irq_flags usage") changed
the code of armada_370_xp_mpic_irq_map() from using set_irq_flags() to
irq_set_probe().

While the commit log seems to imply that there are no functional
changes, there are indeed functional changes introduced by this commit:
the IRQ_NOAUTOEN flag is no longer cleared. This functional change
caused a regression on Armada XP, which no longer works properly after
suspend/resume because per-CPU interrupts remain disabled. This
regression was temporarly worked around in commit
353d6d6c82e5d ("irqchip/armada-370-xp: Fix regression by clearing
IRQ_NOAUTOEN"), but it is not the most satisfying solution. This commit
implements the solution that was initially discussed with Thomas
Gleixner.

Due to how the hardware registers work, the irq-armada-370-xp cannot
simply save/restore a bunch of registers at suspend/resume to make sure
that the interrupts remain in the same state after resuming. Therefore,
it relies on the kernel to say whether the interrupt is disabled or not,
using the irqd_irq_disabled() function. This was all working fine while
the IRQ_NOAUTOEN flag was cleared.

With the change introduced by Rob Herring in d17cab4451df1, the
IRQ_NOAUTOEN flag is now set for all interrupts. irqd_irq_disabled()
returns false for per-CPU interrupts, and therefore our per-CPU
interrupts are no longer re-enabled after resume.

This commit fixes that by using irqd_irq_disabled() only for global
interrupts, and using the newly introduced irq_percpu_is_enabled() for
per-CPU interrupts.

Also, it fixes a related problems that per-CPU interrupts were only
re-enabled on the boot CPU and not other CPUs. Until now this wasn't a
problem since on this platform, only the local timers are using per-CPU
interrupts and the local timers of secondary CPUs are turned off/on
during CPU hotplug before suspend, after after resume. However, since
Linux 4.4, we are also be using per-CPU interrupts for the network
controller, so we need to properly restore the per-CPU interrupts on
secondary CPUs as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 46 ++++++++++++++++++++++++++++++++-=
----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-arma=
da-370-xp.c
index 8bcee65a0b8c..08cd669dc1e2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -281,7 +281,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain=
 *h,
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_percpu_devid_irq);
-
 	} else {
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_level_irq);
@@ -345,16 +344,40 @@ static void armada_mpic_send_doorbell(const struct cp=
umask *mask,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS);
 }
=20
+static void armada_xp_mpic_reenable_percpu(void)
+{
+	unsigned int irq;
+
+	/* Re-enable per-CPU interrupts that were enabled before suspend */
+	for (irq =3D 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
+		struct irq_data *data;
+		int virq;
+
+		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
+		if (virq =3D=3D 0)
+			continue;
+
+		data =3D irq_get_irq_data(virq);
+
+		if (!irq_percpu_is_enabled(virq))
+			continue;
+
+		armada_370_xp_irq_unmask(data);
+	}
+}
+
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
 {
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
+	armada_xp_mpic_reenable_percpu();
 	return 0;
 }
=20
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
 	armada_xp_mpic_perf_init();
+	armada_xp_mpic_reenable_percpu();
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
 	return 0;
 }
@@ -502,16 +525,27 @@ static void armada_370_xp_mpic_resume(void)
 		if (virq =3D=3D 0)
 			continue;
=20
-		if (!is_percpu_irq(irq))
+		data =3D irq_get_irq_data(virq);
+
+		if (!is_percpu_irq(irq)) {
+			/* Non per-CPU interrupts */
 			writel(irq, per_cpu_int_base +
 			       ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-		else
+			if (!irqd_irq_disabled(data))
+				armada_370_xp_irq_unmask(data);
+		} else {
+			/* Per-CPU interrupts */
 			writel(irq, main_int_base +
 			       ARMADA_370_XP_INT_SET_ENABLE_OFFS);
=20
-		data =3D irq_get_irq_data(virq);
-		if (!irqd_irq_disabled(data))
-			armada_370_xp_irq_unmask(data);
+			/*
+			 * Re-enable on the current CPU,
+			 * armada_xp_mpic_reenable_percpu() will take
+			 * care of secondary CPUs when they come up.
+			 */
+			if (irq_percpu_is_enabled(virq))
+				armada_370_xp_irq_unmask(data);
+		}
 	}
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
--=20
2.15.1
