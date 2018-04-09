Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240014-2-6634168915001725310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240013; b=KwsR1HUoWPdat8Gy1LD+gKkEY+2s0QySpukmU4f4tK2Uh54SlG
    0rvurzSGW+3kCF0ltdWrxa/Nr6nE7hpPaGQ7rbe7TPzfr8T40ISGphKwcelZgEKC
    EIkhHJk5qrlXqUyX16eIA7FzpO5BEooFo8LJrj+NiSIKEk5agS2fF+5YHIZrN3Ln
    hy78jEABhkIFtVFJv8zqgoTE3XXkbU4s4JhBK75Z+amSZ4rFmUCtwoe2SUFxudqG
    SmO8q1GVbKlxzZLmGlnFa3v8T/7t/PqbOpdYMZMmSbJ1rqgd42HRuo0p205BNzyv
    XfvUoXLEcBZqO5risvf6JDjMHsHMkr0LvR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240013; bh=fyKD7EH5sU
    R5qrQQFz3fuCai3Xe2/sWqxCm5wQ4cvXU=; b=S8pxCVEtIVLojGpZ2cUayvYOqR
    BPeePZcSpZnWaF8evV3ZqY5jBrsTarmxD3vi0OnEgpQIzamT/cc5nKwORcbNkuGp
    XokGdkWecV8xpcOUeTsis+Ih2lej1rITpaRMzA3lJxaiIi6b60g3II8hqjgOY1Jj
    oWB9f/PGxXlLnLyVUbFlYOXYfz0lJJp1gcSNRqdSjk0JGDVq5Q0UVipU6Cxmvxq/
    2WBuEr36YRmpC4qgOyu3oFHY0Bk4wWhNpzmBdigY+ZLbXsnukICYMOMFp+uTfjr6
    8VhPpnZpSiEKMNA60BVDp0Od/4CJOg+BssnFg1/h2wTvynp6O5rJ7JvP5feQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PjgR8vAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PjgR8vAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDiZ0SN4iyt7qmsbBrsImAua0P12phIh7KSTUMFrYkmTwaxFDz8G740YqasXTaxxNnAbT5HXC8PLbN+6QnCtg4GxpKVNyOE/HKIThgfP17ZCxeNOi3dU
    M5iCN/jAWBoIkcEaydr4YzTZDqxb17gdfg25Y2VDcrsnbgeFTFdFtrkHV5AFp0JYAxGJAgLmPe21AEhJx8C+LmRc96B7sCfw1wbvmV+F8QET0uRdaYC0DM4K
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=XE-PKwxKN_fx57-GDosA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbeDICNc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:13:32 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756180AbeDIAbK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 156/293] powerpc/fadump: avoid duplicates in
 crash memory ranges
Thread-Topic: [PATCH AUTOSEL for 4.9 156/293] powerpc/fadump: avoid duplicates
 in crash memory ranges
Thread-Index: AQHTz5kv+Ek3qJPUWkyOFtfhKGG/1Q==
Date: Mon, 9 Apr 2018 00:24:55 +0000
Message-ID: <20180409002239.163177-156-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:ih/H556CQY+o4CRu08xfCUCxm9xrhY2uzdr0Gto0L/UyGZmBy6BLmFXxUVMybgI0F8R9QwfY3T8X3E9alqb5jxd3LLTaFgxEEGta/oTmADxV3CLXubfLQCPRxIWO79l5uOAhAgHr5Pl/jLT+to8+fJ5m1Hv8KcI7wAI+sxEVdfQC0/zCJ3jIHayhjOlXQBfUotOTFc3LzIpSFjuQ92iG6AlQ0+sbhxx3/Avc3WSzMhr+Lj0X6usSZkyPyjwFZfJW;20:Pzmd9Kqfqyw+hY4qmNwhdWsz7uBSOC91bBibfKnLk4xX8R6bhnHQJJIBkxHg9SepeHGRJZRa1FqJuWFhv9vX3suDSx8r2vIJ60qF53RixFoxbG0Uw+qlw3P4f5e6Qt9B6hlHWwy7T0PgPbgXtVnkyvQs9pRoBfq8IOnuC9WLWBY=
X-MS-Office365-Filtering-Correlation-Id: 26da0179-1e32-43b2-034b-08d59db13069
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917C7267ABC0BFDA69E04FBFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C9KE9PY+Bo0vhOW/rXxAv3LerrFuy/NC/YHZWuJWeqhSiwER6xSwizvfCGojMgzoImbPiLQ387pEnigizdfHmRdFmaFUlNZ9W6awe29i1rB0xdqk2H8K5EhyvI8A9m3OUBwCP7BBRDtAIhbvvHFU33PsTsWzGjWvDo0PGbZKR1xsQf3rLpoNdYy/UD+fx9RqfGTzQmia2Msfyxexyo9Ol0EZYpzsPchm33jauHZ1+KL+aR+dHlZVCQQp+/pcsfB0Aq1He2uVZo0K9DFuQQ25GpRawaYJMDbuFzAQ8kQPqUzYAfal6H1/vhY2+vu6iHkGsOmcTs0x9h/xMitxbGosa3KvCx1vwmzrpZcvMpBhxnOrVLtirq8ck7xPYYN4tXiQRdhipRcmTDAkw+4myGgL3d24V8G4lkRWCxWi5cT/+fM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da0179-1e32-43b2-034b-08d59db13069
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:55.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 8f0c7c5d93f2..4088eef74b65 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -821,8 +821,19 @@ static void fadump_setup_crash_memory_ranges(void)
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
