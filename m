Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482754-2-9968399685502422527
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
    t=1521482753; b=RXL6COuIk8kR5An6cLaa9ypr16+UPomBfOw1WCmmvqPUwT2
    Vos5XGyBju4h5DbyCGRYOoyp3ncTKVuclUFvY2LmIXryAmmD68lU8cgPpT9/XlRk
    In38emyJA7WNUQw5JQZW95XmEfFrs8B4IAtOw6NXyHTAcGnR6XekeGvxzw9d0zQg
    ObzR2aW0d6ani1gSLcspN5g9v5UarMRm0oj7VDP9cd3LYI3iq2xPoMK5dtewudoB
    RuQbujo7JCPfOL/UBX0ZJ8xLNgYnQ8W+xuZLEsGDc4E7sNfAG63d98jm5/CxGjDi
    7oPjpcxP0KyKEDT/p2aP8NvIq+JEmRiRQEvFe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482753; bh=7tytLt
    DOBJ5LLbNyfNKuXG8RVC+BsYgf/Vb15U5l/ek=; b=YowMpucsFLBTGxjKPbTN2T
    L+wzW9VS+7BTosHXTY1wHEvNsQWW0FvjBF1HfUq0E6QAKBz8bLqv6uAtaWwG88xb
    vZFNuQyO6APBhJU/qOcv24muvtbp7XU0uRoVFbs+e8y2ruPC1henqCJuLsLhdss4
    MmFAv1GIUxT6nMJDo9rZTh0OvuvSQBZ+oWOFpBuBwFTS2xZJxYeO55mb9veM1oWZ
    Ox3ehUvObCNeXqerc5WGQcubgwn+rqJkqijgNZtcZmR8F2JqUdC6cGDjfYxkvFB2
    fDtWDKWFv665XF9uJ7mbIqLvs3aSu6TMQX39B1D3vD32zZy2VNMLwM5xC9XjgV+g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hppp06an x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkedtleenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hppp06an x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkedtleenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966643AbeCSSEj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:04:39 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:46928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935039AbeCSQDu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 184/281] arm64: kernel: restrict /dev/mem
 read() calls to linear region
Thread-Topic: [PATCH AUTOSEL for 4.9 184/281] arm64: kernel: restrict /dev/mem
 read() calls to linear region
Thread-Index: AQHTv5uMkPGhfWxvC0eqDvDM+I+3Kw==
Date: Mon, 19 Mar 2018 16:01:31 +0000
Message-ID: <20180319155742.13731-184-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:3Z6rTWAmpfaE99gYggAOwvTbeQMc5UI4suVPWjZrPhdwh6+K5lb12nBLypBNoMUPF4sAUJWBzO8Ah/K41VHr32nl34zDWN5S1X+AP2MmK7pz44eBh0GGoO3YOOwK83U8GJ2e1UbXyqU1xFRtFUFBpfQI6+3vVNBSFDkaBwmkJnC8E21GRHZi5LA73XcT46bRiN2+T0Zc9hQzboRIwiW6MmjW+tBsGXDzp2NaQHaiQ8x0VlvKbQnvna0k7uNd3APn;20:oFr3gzr0S+y9bfr6opkWPfG2mg+g2N33ayTBS7vctfM0V7l+niA5hcA/22VARpY3kLNKwVRdawuSri5JEcrs/4dPkgvdmkIrWyAm3GNznlrozJGt2CiMn2wu1s7PYKAnnXkcvpPWLexuuGsUI4JAudrXs2aAHtRnpNRmLDdFVMI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fd036d6-3e07-420a-d794-08d58db30036
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10779493DAAF0B28B7DD4445FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: c9QaUzwrfnjknWvYyCJKEuCXl4oBUXhoWnBRwbdg079t5YcRv+qLBAjWybPYBsUBkKW5MphbpRpNe/hCVThNXWIJJP/seygz5GJ1JgIfEnaJOKY1iUXD762pvSn5dsSuEyAEXJk1vgIJqlImxNFzOhkmsL/oU2hDD+2QGXO8dTiq3l8xViEzsjmy4KOcqmA46xcLQFXejzcFsXoptJ2Jw0MHAw0gSEz6gRm1BfQlhXXREL/zDX9b/MzwdOZ5I3NHXpOuB3hPbNG/4dX4fh9hKQD5RDCMA0ZxSQpgnE7qZaESvi2LesTx7EKjsC78U0CNEaTEK26rndSyRkjsg7hUJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd036d6-3e07-420a-d794-08d58db30036
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:31.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 1151f838cb626005f4d69bf675dacaaa5ea909d6 ]

When running lscpu on an AArch64 system that has SMBIOS version 2.0
tables, it will segfault in the following way:

  Unable to handle kernel paging request at virtual address ffff8000bfff000=
0
  pgd =3D ffff8000f9615000
  [ffff8000bfff0000] *pgd=3D0000000000000000
  Internal error: Oops: 96000007 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
  task: ffff8000fa78e800 task.stack: ffff8000f9780000
  PC is at __arch_copy_to_user+0x90/0x220
  LR is at read_mem+0xcc/0x140

This is caused by the fact that lspci issues a read() on /dev/mem at the
offset where it expects to find the SMBIOS structure array. However, this
region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
and so it is omitted from the linear mapping.

So let's restrict /dev/mem read/write access to those areas that are
covered by the linear region.

Reported-by: Alexander Graf <agraf@suse.de>
Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOM=
AP")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/mm/mmap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 01c171723bb3..caf75abf6ae7 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -18,6 +18,7 @@
=20
 #include <linux/elf.h>
 #include <linux/fs.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/export.h>
@@ -102,12 +103,18 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
  */
 int valid_phys_addr_range(phys_addr_t addr, size_t size)
 {
-	if (addr < PHYS_OFFSET)
-		return 0;
-	if (addr + size > __pa(high_memory - 1) + 1)
-		return 0;
-
-	return 1;
+	/*
+	 * Check whether addr is covered by a memory region without the
+	 * MEMBLOCK_NOMAP attribute, and whether that region covers the
+	 * entire range. In theory, this could lead to false negatives
+	 * if the range is covered by distinct but adjacent memory regions
+	 * that only differ in other attributes. However, few of such
+	 * attributes have been defined, and it is debatable whether it
+	 * follows that /dev/mem read() calls should be able traverse
+	 * such boundaries.
+	 */
+	return memblock_is_region_memory(addr, size) &&
+	       memblock_is_map_memory(addr);
 }
=20
 /*
--=20
2.14.1
