Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235235-2-10981689244838579171
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
    1523235235; b=E+t9f+f9TJYrEWCju2jN12xV/IHruezYDCNoeZQ9iWZfBCLUgX
    fKhoHKsQz0kbukkrScRcL6MpXOg+X5CPbIyH9XWQlRC1mWVoU5K5cn+8JAS+H/iQ
    svJHTvkTlIjsum/Cp8jMzkCpxbrzBFEMwcE3GCWUOVNDPnWU0as3+a/J3OB1HV0v
    DF5SmFhcf0DHvtF1NjC42GyRNrs8bmq5zd2NhDxv/ghRHCytIZKUmo7JY2ZmdlGM
    Bg+IUWNxzHtnGL62hLtMIMUdx1DVfXpkIb3GOre0okBcFy1TiADDpYNiVBYh51gc
    TBENxWAKPb3TaZyhgYKCcR9SGk9aKvriOETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235235; bh=tZ/WVNCSU/
    ybSfzEyTrpXTM61s0I5ULjxa43+zZ8YFs=; b=r+9WohmBhU7jXcCSO8aO8n22b+
    O2YOgMEF5nPlrPqM0SxpTyDyI3qL8DqgyJyHv/zkOu+5kGrnv1Uj+jvAocN9+OqF
    R2Qwe9T0xJfWCYcAmtjdb+WWSSkz7+uFD5fdvXFZwusyQOEBaXPebpYoi+U7SNVu
    /JcIe0UDgTASKzOVfi664EvAeEUMu9cinckKIrElwgXWjmKAKhbYqI8rau/Io9f4
    OD6EDV6OByTcivh03kCkT3VVVEyBxKR6K6NJjpvkHreaQXfKE6EDObtNG0yWhyfx
    OqewKZyEMPJHpJiON45g8/Q6NElwGG3tPaER2m1ks/Jsd7uYCCjPto0lB+vQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CYyZhBnq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CYyZhBnq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzCkA+L+iEq8yKnPlINIvl9GTCD4aCg+Ps4tXbr+7U3F/9qzvqOhxW69CuE+bx8x4G6lMnuVcROOTxDAUCWWrZvcpt0S1zRpnJ1uAPH7xubOgstcD3e
    dH1i0ff2m4ScvnPy5N/bytHdajoEPWzOaa8Eoq+M6Ey3NS7gDOnG1Qe0rU8CYraUB0l+IR8k9BXsnvfK8cbmfxgBEDniZ6KIuAiU4/4o7bFp0jMNQGVQuO2W
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=XE-PKwxKN_fx57-GDosA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbeDIAxY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:53:24 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:29344
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933402AbeDIAlV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 052/101] powerpc/fadump: avoid duplicates in
 crash memory ranges
Thread-Topic: [PATCH AUTOSEL for 3.18 052/101] powerpc/fadump: avoid
 duplicates in crash memory ranges
Thread-Index: AQHTz5t4bVkPZ1pFfUy8bq2RGsN2bg==
Date: Mon, 9 Apr 2018 00:41:17 +0000
Message-ID: <20180409004042.164920-2-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:JRPFIEVwWfPLgb+e2v8CI9QgeT5g09ULII8GPNdQ0s0FTjDrZ0RZ0NZc52BllSlkK4tgL3kr8XCOad9fluZNi8A85BKBhonZ2nkI+J4fZZXIqijxUSzaqklhGnG5lM5IyKMVGyUe2Nmqtn5Ff5fsiBwqHuWZoXrN7O7G8d3KFvcNtYoFCJzClopUoX8ZA6pbOZYte5vBLknR/BFy5FR8u5/EQMqYVPDvRaq1xybbfsXtAFX2wvholFhYt7Um9wci;20:InzbieRF4ZnoWZ9TBAIJ841YZTLlIueV3yuiTH7RKwqF03nC0zGF3tQ+pyiJbqjOlft+v6dMOOWIONIJnJmOlwga8edrp1qhbrQ32Gtx/GAnww4AHpQhv+617oWZ1KSYKksnFkvu+23PczLUPxLFuahS+W9dtGsBjjM0h1HHNyY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d3906cf-c742-49de-d71a-08d59db29c86
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08706AD215FF43960711DB57FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /w/VHVnPGIdBFQ+QGZvTG0bBigE0XGdJOfGYC5ln3PIsqEijOukWU+3vsE0b4IN8LgTOVLNlwrxn3joDFHyFHICZafeR9HNlTxjgKydI0jY4BmThMg3oVw5RXKjExGuq6AgZUCdpM9uPnJZSDwBzn9Rd84zxbRVvjF2CQ1Abj2sorQayKZt0xx4kU+Whq+3PNXc9taE5Zy3SJUKrdobBAmuOY8IRvXPg346WNe4fnJjcUYrVCsVc1ujYld3jszgo+rkv0GZIXaAP185O5tcNwBJTGmSixaDKsDjXjvZDOEUxWUDES8CHHwE4cIdyhSvNHGIQ+YS0HwNt1Gq0jDXcHUWRNC/dboxjA011fhRHPYGnUcLqr6Ckvgqc+sI1CKZhtC5Jste3Fi5vRrWewylzmx8eG2gzUjv+wEyAFGgOLRM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3906cf-c742-49de-d71a-08d59db29c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:17.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

[ Upstream commit a77af552ccc9d4d54459a39f9e5f7ad307aeb4f9 ]

fadump sets up crash memory ranges to be used for creating PT_LOAD
program headers in elfcore header. Memory chunk RMA_START through
boot memory area size is added as the first memory range because
firmware, at the time of crash, moves this memory chunk to different
location specified during fadump registration making it necessary to
create a separate program header for it with the correct offset.
This memory chunk is skipped while setting up the remaining memory
ranges. But currently, there is possibility that some of this memory
may have duplicate entries like when it is hot-removed and added
again. Ensure that no two memory ranges represent the same memory.

When 5 lmbs are hot-removed and then hot-plugged before registering
fadump, here is how the program headers in /proc/vmcore exported by
fadump look like

without this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001894 0x0000000000001894         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000040000000 0x0000000040000000  RWE    0
    LOAD           0x0000000040031020 0xc000000000000000 0x0000000000000000
                   0x0000000010000000 0x0000000010000000  RWE    0
    LOAD           0x0000000050040000 0xc000000010000000 0x0000000010000000
                   0x0000000050000000 0x0000000050000000  RWE    0
    LOAD           0x00000000a0040000 0xc000000060000000 0x0000000060000000
                   0x000000019ffe0000 0x000000019ffe0000  RWE    0

and with this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001894 0x0000000000001894         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000040000000 0x0000000040000000  RWE    0
    LOAD           0x0000000040030000 0xc000000040000000 0x0000000040000000
                   0x0000000020000000 0x0000000020000000  RWE    0
    LOAD           0x0000000060030000 0xc000000060000000 0x0000000060000000
                   0x000000019ffe0000 0x000000019ffe0000  RWE    0

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/fadump.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 26d091a1a54c..5df362630ffc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -812,8 +812,19 @@ static void fadump_setup_crash_memory_ranges(void)
 	for_each_memblock(memory, reg) {
 		start =3D (unsigned long long)reg->base;
 		end =3D start + (unsigned long long)reg->size;
-		if (start =3D=3D RMA_START && end >=3D fw_dump.boot_memory_size)
-			start =3D fw_dump.boot_memory_size;
+
+		/*
+		 * skip the first memory chunk that is already added (RMA_START
+		 * through boot_memory_size). This logic needs a relook if and
+		 * when RMA_START changes to a non-zero value.
+		 */
+		BUILD_BUG_ON(RMA_START !=3D 0);
+		if (start < fw_dump.boot_memory_size) {
+			if (end > fw_dump.boot_memory_size)
+				start =3D fw_dump.boot_memory_size;
+			else
+				continue;
+		}
=20
 		/* add this range excluding the reserved dump area. */
 		fadump_exclude_reserved_area(start, end);
--=20
2.15.1
