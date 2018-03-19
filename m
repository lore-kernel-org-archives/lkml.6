Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497136-2-12927382020532853431
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
    t=1521497135; b=L7fUkcqSJL3026zfklUpedHk1Ci8ouBkWSDtMm1Tq+lAo+a
    gI7xMp1Qb/NzMg5V6k//j02AiiN2rHkMht4udgOYki/R2RlwAabFPtOujK7a+Hje
    w/MWGP8G2PlWtHWdluTU0OufzGoFPCZLxm7x1jT0zO32QYEGZKfkoGlXrtXpxDfY
    zBaXf81ozJ6kUy3wCo48QnC8QDr9GTaZ10JzSW1mX5MTHTb6Pu9A4VJ3SwG7oFiv
    XsUfGIHyT8xW2hm8Wi9Ib1vhzyD39ZQ5LHrvvBd+jD2ukcSQW+Ng84IS3GzO9ALx
    jTMgFR+sKl09IXFCLdTJRft0sAGq3CLBoPzuBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497135; bh=q5djBq
    s+O7tj0+nRC2JRywXrSRA/Me44/A1qoYDtr9k=; b=XdpvrtApo6GDqvf+P2XlTn
    j9y5phFpb7f3s92glLsMZwt6SwmjkeIpGvxK7xyh3CPza9S3bJbRIVYogAGTthj2
    +bswDb39XVyDfz9GdOL9NlXJXMm0nNAceGoatYmnAFVUSl252r+ljbUs/BeqKufR
    9/q5LDehq1fjkXlXSHMq+G/8MBLKOJXDLlem3uex6f4XFCE+muJCrfxP77LG/swn
    3tA9tMgfsXf3ffy0EYkA5mPE4W/wRRtMOlOFdWtedzcLrzhnFoBm+RqjJfbzg1pd
    zXBOikl4n1d+m5j9omZBxHw6jkbXIkSYf9zoVA4cgQHCagoO7qdpajupyJI86sIQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G4LuRTFk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeekleenucevlhhushhtvghrufhiiigvpeeige;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G4LuRTFk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeekleenucevlhhushhtvghrufhiiigvpeeige;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeCSWFa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:05:30 -0400
Received: from mail-bl2nam02on0108.outbound.protection.outlook.com ([104.47.38.108]:23880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934219AbeCSPzl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shanker Donthineni <shankerd@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 34/97] irqchip/gic-v3: Fix the driver probe()
 fail due to disabled GICC entry
Thread-Topic: [PATCH AUTOSEL for 4.14 34/97] irqchip/gic-v3: Fix the driver
 probe() fail due to disabled GICC entry
Thread-Index: AQHTv5qnarwxZtGUlkOEW4oSxiRnoQ==
Date: Mon, 19 Mar 2018 15:55:08 +0000
Message-ID: <20180319155411.12348-34-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:rxPNB1SDt29UDsVpIOqpkwxfHbA5YEgKm9ShAuvQJ6bpdoOIymxdnnjWawg7jZQ877si10UbFXiognv3XKrnRFPjra385gnFi2Rdx2dsiToxXHmw9+q7AljYjUBQ9QAOZsnn5jnxQ8AjMQ/OYLMig/rQLSLmAiduP+FT9eQvOuXiaBgfkRsC7WMDAlkC08tkwwIBTFg55CRN1pTX9JkIBtl886HDym7Rs9+0KLK4RFi4pKbKtdo9YQ2HZieFn+89;20:Wy0Sgx6rRUVSkYzaAPJo3/2qAtIflMtEKADsQ2RQSfK67XeLyT3EcL0HKarK5tGZHEX0LzxsxVXbFYdLlN3mIjwC0w3kAIQX3G7SKMs2suheb9IlTVMkqr07hGU46k7Tj2+t+ttQWzfi+DkKDIfIyc4aXznMCA3kvRKc15ffQyY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b7d45fa-813d-446b-6cb4-08d58db1dc8f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098296B94653C06B1D5C5F1AFBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: m2OCG4pGJ6f7BVyhVP6RF7uow0qShBNgLlwp0lxR+a+QBqkDKOaU8lwZ3jwuApAtv3A2MQ4YbPwtCtMEzwuqWWJX/RKtY4F9Lz7RpEhiMFnN2mGhnrp8gm5k84Xn/+xcLYBJjOSc9ITCmMyua1nAwnfAIs6JT8Iip2K+MHIQFZj77uCAHdpcdAGbInKa2hdoDEarYAuJRubE2cVBwcm+c8GfBKt+7um+HUYnnFyQ8nNbY+iuE6MN6D0peUjZjOgjPHgpTqEwLCQjtg2PguisrWs2MXxEboLFV17rCaTHZBbUe9PbBzbcGJ4E/2/8eD9E5cmfu8blDa3QRUPavjTavQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7d45fa-813d-446b-6cb4-08d58db1dc8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:08.7592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
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
index ae9ff72e83ee..848fcdf6a112 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1297,6 +1297,10 @@ gic_acpi_parse_madt_gicc(struct acpi_subtable_header=
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
@@ -1346,6 +1350,13 @@ static int __init gic_acpi_match_gicc(struct acpi_su=
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
