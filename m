Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490032-2-16417753429485054582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490031; b=Bj8CZWKtmaUNk+7cD+1gzrpXNbh7CEVd1k1WCKcFekMdISx
    ptiuU9zJO7y2jMJn+Jr8yb2jPU63BsK0gPjmsxdtrQkkJulXvs2HuFvH1Jcg6ylj
    WN6F9mb14l3CwADwvU6knVK3VGWaBCf67SZHdtfFUqKl0dZ5gOIh9XMlE1JyYuVB
    prT2cevGisLtmUSkQZUwWtlL6O+9COuGiOs4EUB1u439mwY3LixZbj6ppyWazDJN
    DLWX+nI1jLoLZDBU6Ojm+U+rZT9tkPjRJOiiw/94ceoxmZf+x1fzj4pu6dB+xZG1
    Sgp4gp3r05DSWXamWRs1VWYwNRt02Xgy4ESdMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490031; bh=7af8KO
    ME2cjogO1QVwe63oblOPj6Ek8f+lF7pghjlI4=; b=VP5AMEc/9FgHzQzlCOw2h4
    oIYRKJq+a5WVtWnjDPEMbga77aFh+V56s7YUGu3fhzMAt8gJyYTKfIqmJAldkXN0
    OkgLDf2lwKCs0VE1b8N2ujargnq1nYScs3dhgiCZpLU1Lf1JIT5fYiQFq6jTAe/o
    VnRy4Ohdd98E8F+Dp/R7mnrnMlm0FmyLpzyFNLqM955IbUw//veFuc6F9z4cjeGE
    BuFcCg7/Px9w2IL9icjeFV9OPdr3t1Dnik1n/+g9586Rmx+nVygJOKmpR6+ku46J
    W71z398n9pED8IGQmD4Yw5RHWKwTI5leRFMg9eNjMZaiFl3yRloNlEubZYi6dyJA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U72CC7WQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U72CC7WQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965721AbeCHGUP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:20:15 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:45079
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935419AbeCHFA5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 054/190] irqchip/mips-gic: Separate IPI
 reservation & usage tracking
Thread-Topic: [PATCH AUTOSEL for 4.9 054/190] irqchip/mips-gic: Separate IPI
 reservation & usage tracking
Thread-Index: AQHTtpo1c56ZN0UDBUqLv7kamsDmXA==
Date: Thu, 8 Mar 2018 04:59:15 +0000
Message-ID: <20180308045810.8041-54-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:TuhL3/DaIyUoXvbytYUOl7Mms8biJjtSX2juhhcTzMR8275JKWThZt2AU9XaqC4edp2/y/ENUFmojvMQFDBpvlrwoleA4e76d6+EaZ5753ac2/4D6T7EnHjTGKXA0CCs55teiaGuj0b1m0WUG0lhQTPNawdevNg83ScTZ8hnQkURUyG7msGvTwFvwU8T2dgs6j2UHEJQgJ1mU48JuQ9C39X+inpOfGF7HDujRDibutjkROAU1WM3h4HG2+8a0V55;20:Sk0X8ftpMzxb64+oQn/DDDq1FwqlIKOvSZy1Ci4fXgiQnUTDY49YxGXPoG6OeVTO4uU4YvqKAGiQ2AhKD7pIU96dwzwc+Rhj67G4WcO6MwOulBfwNj5zAyfBg9lqRYvAw6Pqu5FXniTGjGZOQjtqXeTjZD7ZxW87P963dGRIBnA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58f9ad5d-d709-46e0-1bfc-08d584b18dbf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11095AC853B5A21719F2DCA1FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6306002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(966005)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Hi1CsrBIfTIBbHFImJHJKFVp6TeXis/9GF5/EQlWdStVBbiLzcUx2uFrhkXR/6eB3gKFfWk/rbe7bjtc+/1ijfHD0CqfoA8CSN1AJX8TOKZhOLeKSos4TfF7Xs7vvesqonaDn9PNLI/6nLfl97VDwbq5BVqS3Nn1IKWFqZxTZ8NBUlQN/da6yhzqrKpSMKUaj8RXq8yK+QFDj2tsrs0Ik8CgyoHIcz9OOABENS/YsO0sVEhBsPoPF77tVlq1p95szPYeCteP9cKd6w9U8SaE0/vh3ReWOFAeN3KuObibUV0rZest6/o3FWUxI1P6DUyttWaSI+wtD8ppauGxo6LRLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f9ad5d-d709-46e0-1bfc-08d584b18dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:15.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit f8dcd9e81797ae24acc44c84f0eb3b9e6cee9791 ]

Since commit 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy
domain") introduced the GIC IPI IRQ domain we have tracked both
reservation of interrupts & their use with a single bitmap - ipi_resrv.
If an interrupt is reserved for use as an IPI but not actually in use
then the appropriate bit is set in ipi_resrv. If an interrupt is either
not reserved for use as an IPI or has been allocated as one then the
appropriate bit is clear in ipi_resrv.

Unfortunately this means that checking whether a bit is set in ipi_resrv
to prevent IPI interrupts being allocated for use with a device is
broken, because if the interrupt has been allocated as an IPI first then
its bit will be clear.

Fix this by separating the tracking of IPI reservation & usage,
introducing a separate ipi_available bitmap for the latter. This means
that ipi_resrv will now always have bits set corresponding to all
interrupts reserved for use as IPIs, whether or not they have been
allocated yet, and therefore that checking it when allocating device
interrupts works as expected.

Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Link: http://lkml.kernel.org/r/1492679256-14513-2-git-send-email-matt.redfe=
arn@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-mips-gic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.=
c
index d74374f25392..abf696b49dd7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,7 @@ static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
=20
 static void __gic_irq_dispatch(void);
=20
@@ -746,17 +747,17 @@ static int gic_irq_domain_alloc(struct irq_domain *d,=
 unsigned int virq,
=20
 		return gic_setup_dev_chip(d, virq, spec->hwirq);
 	} else {
-		base_hwirq =3D find_first_bit(ipi_resrv, gic_shared_intrs);
+		base_hwirq =3D find_first_bit(ipi_available, gic_shared_intrs);
 		if (base_hwirq =3D=3D gic_shared_intrs) {
 			return -ENOMEM;
 		}
=20
 		/* check that we have enough space */
 		for (i =3D base_hwirq; i < nr_irqs; i++) {
-			if (!test_bit(i, ipi_resrv))
+			if (!test_bit(i, ipi_available))
 				return -EBUSY;
 		}
-		bitmap_clear(ipi_resrv, base_hwirq, nr_irqs);
+		bitmap_clear(ipi_available, base_hwirq, nr_irqs);
=20
 		/* map the hwirq for each cpu consecutively */
 		i =3D 0;
@@ -787,7 +788,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, u=
nsigned int virq,
=20
 	return 0;
 error:
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
=20
@@ -802,7 +803,7 @@ void gic_irq_domain_free(struct irq_domain *d, unsigned=
 int virq,
 		return;
=20
 	base_hwirq =3D GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
=20
 int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1066,6 +1067,7 @@ static void __init __gic_init(unsigned long gic_base_=
addr,
 			   2 * gic_vpes);
 	}
=20
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
 }
=20
--=20
2.14.1
