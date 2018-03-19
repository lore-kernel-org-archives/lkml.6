Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494405-2-11935710386223144669
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
    t=1521494404; b=HftC6cWqEBXepPIYLvYBxyMkUpIrZT6pLT3Mv1X9d3uc6p9
    bWtQKjcajESuIAaiJLA7hxpLUUuQdM9ZvhLCsIPv78QvjoyjL4/DcDOdOxKJla6s
    7U4T8hL9fh2FxjN3O01Be7emLyRpQ5RTviGYjxFPFznux6dMwJly9SBBOfY7CJL8
    VdSCJZs8V32CUyS5p0ngLGuPDEA0OXVbCuNUuGpRJ2FEjmSakeTTZMAO9l4fHbgB
    DRGuq/d78EcZ9SnqPobGuVWqFB+RX9Uw3Kke2iOW65AemryX/9wKQxT/5PpMoOms
    evnRZCadBHTmvWYp2kJhBcupTAe0U63SSoCgGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494404; bh=hv2TTt
    lR02xpq3EBm3J5ijL0X+8XSdWGBKLcSV7NiuM=; b=Eezrc4OwQXxWAHm1Pgsr35
    dqbPWP/IpUh0OtimAAUMRaX+lqehF5ymrKDH4MgJp7Vob26agzfjRKJPI5s7ffUw
    EzVhgWrJU/Y8Yd8sor2ouW4S6MW17ryJGtnEL3WsL/muergNLNsIf/aNAWMkp/J5
    oCWmFUKcyCRPIaKnkGxD5TAS0g/gzXNyKvyhhGXom/4PQUcFUatkQMXx3j9dFNaI
    5cywlWZi8OnbBsmYhzo4aUREp8LRsGyvnLHBB5Y75Gyz9ROgm9SAxAMD+jWKBmUD
    zmagCbSnBc2ix1gaVVg51KcISQ78b1Q9eaAJPTPoafzLK3ZQYLn4Gik8GDxXKETQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XIo0LQ5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeelkeenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XIo0LQ5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeelkeenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967165AbeCSVTj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:19:39 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:39043
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934903AbeCSQAz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Timmy Li <lixiaoping3@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 109/281] ARM64: PCI: Fix struct
 acpi_pci_root_ops allocation failure path
Thread-Topic: [PATCH AUTOSEL for 4.9 109/281] ARM64: PCI: Fix struct
 acpi_pci_root_ops allocation failure path
Thread-Index: AQHTv5tXch0Y9s9zAUy7CDoZE51m3A==
Date: Mon, 19 Mar 2018 16:00:02 +0000
Message-ID: <20180319155742.13731-109-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:K5bkJe6qtRl/rHo0vMhLEOGZu52K1wPP6dvhNJVZh0K0zw341Rau+7HXl6kgqpLvOctVVrk4UqLLJ3z8LF9gj/bKI/x6IFMvgQX2MM0ceNNsq4bwIiv+/o7zzRz1ngoXt39ceJe+oPXkOdp25g1ap5m2bQhMy+iOUDn97ZN1PL2M2EzbtCG9Ryy1DoAHt67Z5t0x8+B2oN6BQcVMKiAGVPt5BCcARu/fOgaQLTKmG/vqCUCfOzbZXlHJXWTtJHH0;20:cKYA7mUztsWmct4xWXvqcV7fEihExxZkN6NN9tkupr847M65YouhAO3KqLeVr3H3DIoFWv/5apBufNIPOF6tXiiQYercoKzqpTLxpD4dw6ISqgVNyNzeuvMkmnP0/foiPEGcceXFxjCYn0tKvT5I5WASbNyabmWrtqTYKTEekQU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed9af313-bf06-4e32-bab6-08d58db295b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10156CFD63A215D342CE4F19FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(50582790962513)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7BjwAxp2nTskBeeVH/KJ0AmCksUx8GUKg1Qy2Sz6Tjds/GP3uz99HzGL87Pn9F450V0NevjIrOqLBfJ61Z+kJnRfvAQKkK2MHA2H+r7HiluTl63UaQI8c/2Yup1170hWxowFHs1JptyvADu09GQsiGp//NS6FjGdDEagHZn/Q38qzeVsf/MaWLt6PzQ2EpzOwRd035Xh1Dvk1yJ6bVA6LyCx5CaYSPtSS0T7doHk+0zdTbFUtZ8x9OBsCcTlveLrG0GsaQU/p3penEsXMa3F9hGju/Qoa/xLJHvlvZkUzJJfMQsgic+/Q5QYcoVAh5JHUgcoRAxQ5YReJf2RguyoZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9af313-bf06-4e32-bab6-08d58db295b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:02.5474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Timmy Li <lixiaoping3@huawei.com>

[ Upstream commit 717902cc93118119a6fce7765da6cf2786987418 ]

Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
per-controller basis") added code to allocate ACPI PCI root_ops
dynamically on a per host bridge basis but failed to update the
corresponding memory allocation failure path in pci_acpi_scan_root()
leading to a potential memory leakage.

Fix it by adding the required kfree call.

Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-co=
ntroller basis")
Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
[lorenzo.pieralisi@arm.com: refactored code, rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 409abc45bdb6..1b3eb67edefb 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -175,8 +175,10 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_roo=
t *root)
 		return NULL;
=20
 	root_ops =3D kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
-	if (!root_ops)
+	if (!root_ops) {
+		kfree(ri);
 		return NULL;
+	}
=20
 	ri->cfg =3D pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
--=20
2.14.1
