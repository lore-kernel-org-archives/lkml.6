Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475857-2-8992854690816675330
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
    t=1521475855; b=jkahheAyVIWOJW+6x48zhjKTNNvmBX7Sh3AtSMlb3sdtexY
    ItcAWEpfLA9hN3t38F5uHMaxmnHKmFWgPMQQTTTcfblY5NE7FidhMXUmBXgsiFKB
    SCjVUB+0thyeu5buZONafjO7ZXgJqnGxotIqD+/O11uQq32F7xe0y558nweCmjFm
    K6VCOt9IAzPon+KmSW+hiJenSfRW58GNWmZVD423Mmst6YjQcpM/FKY7aTX7Oo0j
    to/6GW5qyrA7C+l53L0ESfFsblPYK/PBamF40SAWc5KMOXt5VangnZRvDF0z53QM
    OlS9QAaowMEgbO7w3d83syKcC8+ccY9cwon0b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475855; bh=xQQaZF
    jLCc88D4oRJO7pP1safPqkWIwyxWZ1GmGADT0=; b=jCJrU59XJEeS5eXfAwe3Dt
    wgedGoak9r6CLc70lTdMHnL6C6kDbNXFWr/TGkIfgcPR093bJuxT07/2+TOCF96F
    oMpXX0btd3z5abbuY/gH1CFWMzsi0T38N2CjxvNQvmLxrjoa8by+nubt50m1f7lY
    r0yb6EZiszZH7wa2h5YgsrZKlFhoHcTLFpGOELY7s2rK8Q+wfCBTO1wNKWMmtlzo
    X5BVdoRrx4gakUXpXpRASXblLOzNlAZyiJsYTOh+mlfuZvS/fVgA+PIewzsuSxLL
    pmIoKXrEBTtsC3rB9Nnqmp2/Dk/AivoNnTjeM6QUIHSN6XqwClsBvZ2G8CYUAbzg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Plvct6JO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugidqmhhiphhsrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeehgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Plvct6JO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugidqmhhiphhsrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeehgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966292AbeCSQKw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:52 -0400
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:18758
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966656AbeCSQKp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 135/167] MIPS: mm: fixed mappings: correct
 initialisation
Thread-Topic: [PATCH AUTOSEL for 4.4 135/167] MIPS: mm: fixed mappings:
 correct initialisation
Thread-Index: AQHTv5x61nhgJCaHr067NhCcNsLXPA==
Date: Mon, 19 Mar 2018 16:08:12 +0000
Message-ID: <20180319160513.16384-135-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:o27SAXzb6KPlkXOsWoCgb0/sZK3rh/DkG/Y9PrfuhjE+2dX4chs8SafjqOzeTFUYHsy2YgALoInDZo/mSRXD5NK9mrZ1XUxeiF4JLNgtAhuUpegBjWNtVNfz9ABBPNzxd/FGAdUit2ep3jyi3/oqIdUyDRrKB1TFvDB2hycAAMDFrtpjPeAJ7ytoJkyocEYoZFhxuPFfFzJ//6qbFDlGZ5WZ9tTr24Ukf4aXbgjqFYhuQgmhR3XGpxlsIx3vgqQV;20:vCgLvLMQuNMsMu9al9qgMiLWXSgQ7zFBPlCJEx1vsS6limOEZDYwsE6DFCmDmQCwARGc4ZfEcR4eAEFTwYgD+qmkl4cn/e+VpIB8B/4ZbuLLhlTIlTF2OgGbBlqBEyrO5H6Sl2OvYoA3zLv0KsJUHXimM/YgaAKVkSv1KiPWWk0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2ceda35-f34d-4add-12a0-08d58db3f63f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10959BCCC5F6722A6781BFA9FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FPPoxhcSGG/q64dkYMrVYytAKYULsGzF23JI09ON4mZkCIIiVbOHiU/9xdSvi0jp+ZC2Rt5kv6hK8vqbFYcU9SJiqaOo2ZY8e/YEtk3cEidx9LYhO0kgD8WJ0zdMazhGfSVwGSAVfAM2NLnyd2CHNNlx70Snq1kVpSN5EjSCBQvNusvlMWtvY4Os5dfeZatrEGvUTX0TgV5sHpa52HwaQxEFd78gBec7nhtxM63zC48535D9GtoRHc1/Z86yyfpytCny2a5SpZ0nDCDh/+U2lp2H2GOehFm35yMVMGuDfS3acZoxv1FUiAKNLVE/XdH93hazEzuF1B9b0LtOaFmigg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ceda35-f34d-4add-12a0-08d58db3f63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:12.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 71eb989ab5a110df8bcbb9609bacde73feacbedd ]

fixrange_init operates at PMD-granularity and expects the addresses to
be PMD-size aligned, but currently that might not be the case for
PKMAP_BASE unless it is defined properly, so ensure a correct alignment
is used before passing the address to fixrange_init.

fixed mappings: only align the start address that is passed to
fixrange_init rather than the value before adding the size, as we may
end up with uninitialised upper part of the range.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/pgtable-32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911ba748..b19a3c506b1e 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -51,15 +51,15 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1);
+	fixrange_init(vaddr & PMD_MASK, vaddr + FIXADDR_SIZE, pgd_base);
=20
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr =3D PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr & PMD_MASK, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
=20
 	pgd =3D swapper_pg_dir + __pgd_offset(vaddr);
 	pud =3D pud_offset(pgd, vaddr);
--=20
2.14.1
