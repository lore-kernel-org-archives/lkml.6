Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498489-2-6421779541828760889
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
    t=1521498488; b=LUg4pI7G2/WFzOgoEoBtozdYQskMNHN5fui9mga4cDM8eyO
    nAIwTnhOQx6c76jDSegA5wnphOwNta8jD03/drYxsHV9bfEXvZGgaZYcdy8j0ZMl
    Ks+Jb6t9dXDTfjKMV3vBySxaV4HUnZEt4x+UC8g5RWuuLjaJWH806Q20lWU3SmkI
    BOWopVtuABv4533O8T5brMK3DIEA5DYjzg2kerUtLyqsRY3bS1A/gLaQ8nczZVEh
    TTZzXsLeVOLbiLm7JG3xztnGFd5kXbBPN5npsiJFqRHJ3Tr2j/xND2D3LQEbu4Qe
    8xxb3lqiKVl4Ntw/+RxUYowqMkNWGxAy0tAOa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498488; bh=MbXCR/
    BimVn1YlkNMgz0U+Dxz6hrt796w/q+n3NtPus=; b=KiHGCnY5SRcuDyE8+e9SKt
    rp5MfZQqgmrUXFf3q3y3HdNqCuhYrjKZANnVZ/QnlidxHbqurgWWdNq8ok3tFaC0
    D3QP7PipTHGrtMfrenGb/7jtIyGkddmhmMvOp22wDZtHE4GSN11wX+TnqSgR99O8
    UvOUF62mFG8/ju1rSHq+ZdbAG8hMpqz3K8aFFuk+MlhKrKYojZOrK5trE6+5jQBU
    dC+6WxcfB7O3CpIKZP3Of7EFYDAUdNQIw3sH/rF7lQek0AY745cW68Y9sth216n8
    zi5opd+Azi8mOhY7SVYl4wPlsZs2CbSr4UNCHsohLjB2hazBzOowOVJgK6sPJiqQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gePVe3WK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeelkeenucevlhhushhtvghrufhiiigvpeekfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gePVe3WK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljeelkeenucevlhhushhtvghrufhiiigvpeekfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeCSPst (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:48:49 -0400
Received: from mail-co1nam03on0136.outbound.protection.outlook.com ([104.47.40.136]:48409
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933780AbeCSPs3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shanker Donthineni <shankerd@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 046/124] irqchip/gic-v3: Fix the driver
 probe() fail due to disabled GICC entry
Thread-Topic: [PATCH AUTOSEL for 4.15 046/124] irqchip/gic-v3: Fix the driver
 probe() fail due to disabled GICC entry
Thread-Index: AQHTv5mgdnHxWjk2CkGMiVrILs4PMw==
Date: Mon, 19 Mar 2018 15:47:47 +0000
Message-ID: <20180319154645.11350-46-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:G9ITPLVgQgypzmhGoR3Xe4FPfkXSwB5tsD2xtTOAygipA/BiwEeAkS5Z+VQ2i6uNVBf3M8+A5P2F8GHMaCuG5Xde6+hGS80zah0KLe1BFEF2pO9z+x/ieaey7RbstGtyrJNf9jpMssPQd3Y/W7yTVNuHHdnx2RZOAMZU4dYumUs0GfuMa0DPUB81knE/rShHmJNfZ13E2V03G/QSFJ3KZLxpr6VsC1FCfkeubrmtrublpHvGBEaLqEO0WkUL9nqq;20:C+y+E0csWp9zoqpvovhGs07WUyddcxb0DhNuoLA2CcT+yYQMNlslKuinpAfR7g8EeYm6h28/fW5AReqbUCZthLgGJSWwCY0IQSv3wyGBGoLDqHOlsgbZGbIqT0gQkgwhiQNGye5ktFAgxSjoPpxc7m2eSwrjflee9McgkY4oaGY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 421144b2-4d9c-4bd8-44fc-08d58db0d0ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998366C50A11D8EF743063EFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +fpjdEic3E/jZrgUTEbtn7DCh0qJvkrBwksfFDYHreZYgYN3ODKkkrjbQcTdLVkqZRiTpPr7siThb3JS8108mQb3feUIEaL3B+ekGGkof9xPv/ab7smv26WkT+Vi2ZR/VXaJKAnE9kkNjjy5FkVTGbgwyjVJC922nBZhF32lNV0KpFT8xc+UfT6t4HMBUDs0Xr85NHHOhYBBDiEfASFpcdWhlrYYjZUfNuxjDEg4uVkwf92Y69WV6ycxViSOGdOrgyuxTkTvUuko1hSQQsx1JYLJ70DOlSoDFa0EmBl07xbcpANkt2wT2lVC8+xkpJYSWX+bpBtXT/o2VS0rTwfagQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421144b2-4d9c-4bd8-44fc-08d58db0d0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:47.5460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 980ae8e7df30..45ced9e48c5d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1331,6 +1331,10 @@ gic_acpi_parse_madt_gicc(struct acpi_subtable_header=
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
@@ -1380,6 +1384,13 @@ static int __init gic_acpi_match_gicc(struct acpi_su=
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
