Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493665-2-13957969151584273739
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
    t=1521493665; b=A6jp2aOFYpaO+qiQiddRd0pXKP+280sJWb+BXj3zdPHq3RM
    wIMJtE1xfb35W7+v/L6Q2ja6iv7EQFb1qlGfXMU7SZ4VgAsQEw+xBaUX7GXmGqpm
    4yl6Y0peVPd2L8f2kULE8SguRVKtWjeLUVr0r04EmyZrn2JwQhXbe8KGV0D2ryY3
    mLxxYqWXRcihaLlA9u6b6MaorRAd3nTch5iQKqSqCVuRZVP6Ul55r9/Gq8fA9UL1
    or1wAq6uKV/ZvTO5ZweIKcY7VSqIeqgCH5XdxS/JSqm3z6RQRPlZM5NT4gknba9/
    Md3TFGML/plZZRrKxBDGmW6hcUVu8E2dxEbHjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493665; bh=/m1ClC
    Y5c0D0YehKL8s0LwzIWYJksj6CJLInnQYTxu4=; b=ZxV/7ipS8HGnIGlwSVCZ/d
    xQ7ctbHojruaI75YKxqkyYoGPudrSNboDV5MABHaGsewhIgRxc1x2NDP6faE+9Ac
    x2gtnPZggiMHGmhwEFOJD4Ee/ZFOaHf/2Fd6xyKNO+UbmqQPH4zkHZ9MLt2F4Doc
    xSrP0hja4l423KV+9Nx5GkZMGc8GJVsvsy+jB0WkgFrzLjmQPuxke9bwvrPKpmbz
    GMjC4/iwJhT0QqbbhxYHsX58ilJgpg3yba3jR75ghGF5FNdnZDUCOAx8+13Kg4BB
    PZiThyZ3zwY3cPVJ7gCWxG+GT5EQeofjZUEWYJOWZKO8XS2erHCvtO0LUHuh/VWw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0PCvJ7o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeelfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0PCvJ7o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeelfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934997AbeCSVHj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:07:39 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:47488
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965382AbeCSQCF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shanker Donthineni <shankerd@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 138/281] irqchip/gic-v3: Fix the driver
 probe() fail due to disabled GICC entry
Thread-Topic: [PATCH AUTOSEL for 4.9 138/281] irqchip/gic-v3: Fix the driver
 probe() fail due to disabled GICC entry
Thread-Index: AQHTv5trgQIKVeKq3UytLOGN8TyWkw==
Date: Mon, 19 Mar 2018 16:00:36 +0000
Message-ID: <20180319155742.13731-138-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:LlMAUkPV2IEZDUgUHR5ar6ovvtceT5xLYOEzz8+wMhn/xf058IgE7xnTs/ZFqfuMd1spkMAQUkdux3QlfntIYTVA2aXqsXo7oWuAEdQaAOuCn8ja2+qcABV/eiWFPLu2PR7l2bKYpzQW76oDbV5tyEuVYpzD6w+dKTN4Iy7RwDgsOTyLSakM5qj0jt2CxFGTmtvi6qEw7k21XliDD5frWbiBAiwWP88lwQ3QglRRURqlbmdgXlpJOXNafN6AIckR;20:RRqMD5aI+/c+ROlbTSDm0vrp7hsnV1cZsKJQWzbLjZjr7bH5E5nT+owK8L3rHbXfBSH+c4jlvJ/SQe3KWCL4rtZFGDOYNXs8wi0fvtJdLPh+R/tDoSCMkdtGvbC4cqnQisyMik/TezEkC8VVLhqh/cghaUzOtw6OTwAbFEsKcWo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55e6958a-03ad-4dc3-9d20-08d58db2bace
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091973AF3075771821D4F1EBFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mjwIXiqqd/MxOTODnsp1L0yHSmVGMB+Ii2hlNm7/MYuCYBza8rP87Tt5MQLfs8FckyOMBzDWjuwpMErt5FXZWEwhz8rbhKHIGpTiAZ+NOOiGKSy+pjhxY319F3qf/s6+vqM3/Ta3F6J+tEVUOKcsC/UiiWmwqZFPKnARDDBredmOmEOLPpxdjK5efzo1oRweVKws3OCFpnEYPf3vo5WOvslYKbYUG3GLsaabHnz127XGy6XSmqR2gtl25DHyTnUWin+HJBiVHWEGtvloC0VFWouHOdvoOC26bRApe+Gt2TRjqfOyvYPLYawtqlG8OEV5VYglXu3Os4c0WYEqgMBU8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e6958a-03ad-4dc3-9d20-08d58db2bace
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:36.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shanker Donthineni <shankerd@codeaurora.org>

[ Upstream commit ebe2f8718007d5a1238bb3cb8141b5bb2b4d5773 ]

The ACPI specification says OS shouldn't attempt to use GICC configuration
parameters if the flag ACPI_MADT_ENABLED is cleared. The ARM64-SMP code
skips the disabled GICC entries but not causing any issue. However the
current GICv3 driver probe bails out causing kernel panic() instead of
skipping the disabled GICC interfaces. This issue happens on systems
where redistributor regions are not in the always-on power domain and
one of GICC interface marked with ACPI_MADT_ENABLED=3D0.

This patch does the two things to fix the panic.
  - Don't return an error in gic_acpi_match_gicc() for disabled GICC entry.
  - No need to keep GICR region information for disabled GICC entry.

Observed kernel crash on QDF2400 platform GICC entry is disabled.
Kernel crash traces:
  Kernel panic - not syncing: No interrupt controller found.
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.5 #26
  [<ffff000008087770>] dump_backtrace+0x0/0x218
  [<ffff0000080879dc>] show_stack+0x14/0x20
  [<ffff00000883b078>] dump_stack+0x98/0xb8
  [<ffff0000080c5c14>] panic+0x118/0x26c
  [<ffff000008b62348>] init_IRQ+0x24/0x2c
  [<ffff000008b609fc>] start_kernel+0x230/0x394
  [<ffff000008b601e4>] __primary_switched+0x64/0x6c
  ---[ end Kernel panic - not syncing: No interrupt controller found.

Disabled GICC subtable example:
                   Subtable Type : 0B [Generic Interrupt Controller]
                          Length : 50
                        Reserved : 0000
            CPU Interface Number : 0000003D
                   Processor UID : 0000003D
           Flags (decoded below) : 00000000
               Processor Enabled : 0
 Performance Interrupt Trig Mode : 0
 Virtual GIC Interrupt Trig Mode : 0
        Parking Protocol Version : 00000000
           Performance Interrupt : 00000017
                  Parked Address : 0000000000000000
                    Base Address : 0000000000000000
        Virtual GIC Base Address : 0000000000000000
     Hypervisor GIC Base Address : 0000000000000000
           Virtual GIC Interrupt : 00000019
      Redistributor Base Address : 0000FFFF88F40000
                       ARM MPIDR : 000000000000000D
                Efficiency Class : 00
                        Reserved : 000000
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4a78296b48..100c80e48190 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1250,6 +1250,10 @@ gic_acpi_parse_madt_gicc(struct acpi_subtable_header=
 *header,
 	u32 size =3D reg =3D=3D GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
=20
+	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
 	redist_base =3D ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
@@ -1299,6 +1303,13 @@ static int __init gic_acpi_match_gicc(struct acpi_su=
btable_header *header,
 	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
 		return 0;
=20
+	/*
+	 * It's perfectly valid firmware can pass disabled GICC entry, driver
+	 * should not treat as errors, skip the entry instead of probe fail.
+	 */
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
 	return -ENODEV;
 }
=20
--=20
2.14.1
