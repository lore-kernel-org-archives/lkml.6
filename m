Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481883-2-4239823041519279433
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
    t=1521481879; b=IWQeu+K0vD4Iu/feNRj92+2DRl+DbxT5YdLYW344IdVKSNc
    KG4f/DZh6kBIcMRd27dx3llG35J5S4JBjvJExIyPPecoayM/GbI96c2Y/AuVYLSG
    NJasQe/CF/W7OtLUZZrX5AINu21C1Cjr9MNStZBbo4WHfNcbXSWxlWCla6RVRQTU
    IrOBHt94o2r/GRciMXJ/WPfELnsm8A8dIB8I1b0rqdglPPIwZ84h/nz0Tp8DArHw
    18+Oub3PwsPjp7igJJJMKZa3ZSm7sdEupvONiGyF7eBjtxBQSgYlCEIV65TG2STM
    l6vNkCV9U4qYSskuAUQCevh0SS8+iNxqQDA58ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481879; bh=w9WPyV
    Hz2L1P6y577KPPbyrrnUQFZOgMyQ2ZXems+IY=; b=ZRVNHmW9Sza8YeqY1Zml4t
    xQwZ1A7rgQZDoFTBkfQMRjGPejS+oVetF7Q5SrpEQYMqe0XLFL5OhFcaPieClvhy
    xvu7WZ5GtbGfNY3n2pLNrA5dXJEFvr+03WXnrFu8f3UnSyTnNM5cqpBzF/Bh0dw5
    alvLzVLPcyN2Le8obDTKO5Dyuq2z3ynAp4fOK42hyVEi12fopDuok/HgzCTlaOZC
    zKoDHoZPunNiXcKkEYFXncRUfu3c+qBpZpCDVGYEhO3F3GdBATawPtNn1H0ODksX
    gVOufl4tEo+6W/e6BmWh43yBZi3wwTrsypPVshQie3ZSfr16bZGYNu2zJii8p59A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oePd5BLw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekieegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oePd5BLw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekieegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965714AbeCSRvG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:51:06 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965639AbeCSQEz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 224/281] MIPS: mm: adjust PKMAP location
Thread-Topic: [PATCH AUTOSEL for 4.9 224/281] MIPS: mm: adjust PKMAP location
Thread-Index: AQHTv5uo8WEq5/JaF0yBgQ2Fs7PATw==
Date: Mon, 19 Mar 2018 16:02:19 +0000
Message-ID: <20180319155742.13731-224-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:uESDOAS+ofI5CqfFOkKF/t2MOQWI+6kQA8YFkq7aGJOAzLpa0U37xmXXxDfjs5HqRukJFn9JfLkbZUQdvamMgCC9OOTTUF1+A0I2Ocep7jzq9hVCFvoKfwE/Su4i9QO5xLYAgll2iIOTbnhUAAp1Gxa7ZGCnETdFWrOt+87pOWFeln0tKsH3nM3yhJsbMz3iU962k2ZmWsXwgoLjo+K/zQcHFbTAXejEe2rMuJIppfrHuEF65G3WywoURG+bcxD5;20:OVzQzvFHnUdURHHxaA24G+KDHNLbxSwGP668NnmssIXQkUSYMs+sDC0gMaMFT8PPmyO9gZvLdiJU5dS1L/ijPmyuzFajp7Zvf2DM+AKslaxUYHIh2Ug35XxKn2seKP76HC+X+6WN7WzRwubrSOUb/sxlb6QX7wLAzaS/d3RQcDY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c083a0b1-9eaa-4e69-e009-08d58db32258
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805C9FD3FDC8CFF57219611FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XuJcK+7BGFNSsriVlGA3BAlFLDV0UFz5fQkqC5AOfaRwg/z5BnrTkNCgYFIjNu7PFe+7zcgavObsrT0V0+VGSsPHICAt/mcShCbAsuydAyRz6DDGNj/Urno6oCMKfajNEZIlglv6f6DU/bux4lo1a2jCzCLK2vISMPmaLOEuqjvcow6K/eKLzt8b1JL84FsdK6WcUwg5l63JrzO8032d9+bRUGSkzWV4YZYhghUG4f8pMbfNM/KwJhT1PyX935B1bY1yDL5Tkzc4pr+8+pjKKyr0FOZcMdA1uZaIkIdaCzihB+vYBJpUxi/qpykcnUwOrCNZoihjQC9l3T8B/tB6/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083a0b1-9eaa-4e69-e009-08d58db32258
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:19.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit c56e7a4c3e77f6fbd9b55c06c14eda65aae58958 ]

Space reserved for PKMap should span from PKMAP_BASE to FIXADDR_START.
For large page sizes this is not the case as eg. for 64k pages the range
currently defined is from 0xfe000000 to 0x102000000(!!) which obviously
isn't right.
Remove the hardcoded location and set the BASE address as an offset from
FIXADDR_START.

Since all PKMAP ptes have to be placed in a contiguous memory, ensure
that this is the case by placing them all in a single page. This is
achieved by aligning the end address to pkmap pages count pages.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15950/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/pgtable-32.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgt=
able-32.h
index d21f3da7bdb6..c0be540e83cb 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,6 +18,10 @@
=20
 #include <asm-generic/pgtable-nopmd.h>
=20
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+
 extern int temp_tlb_entry;
=20
 /*
@@ -61,7 +65,8 @@ extern int add_temporary_entry(unsigned long entrylo0, un=
signed long entrylo1,
=20
 #define VMALLOC_START	  MAP_BASE
=20
-#define PKMAP_BASE		(0xfe000000UL)
+#define PKMAP_END	((FIXADDR_START) & ~((LAST_PKMAP << PAGE_SHIFT)-1))
+#define PKMAP_BASE	(PKMAP_END - PAGE_SIZE * LAST_PKMAP)
=20
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
--=20
2.14.1
