Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236962-2-15591817164414071370
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
    1523236961; b=KB9LOsgtk5Zot35KqYDnxRVEEbUGDP1dRmlmZoUMgGM3komhoK
    j/tFPVJD/5CbQuZCQLdmhT1lGpkL/wXhGeB1HN/sNQIAtXgkA7FRGFE7W2/dJjUT
    6KMoi7uaE4fFUtJKBdo4w+hF0QVdhax8+x58bm07PVGgbfFEfS7UXkRKAgMWDcRA
    SXNNvwYLtzbehbiLAvFwVlghtJqLderR/k5iX+4qepyEQKwnmDZRj3dcYMSNGiVD
    99cRqFWzv5G24Exjuzu9FlWV6YNrHp8RBHt/3Lx+IeGVGrm7uF+TB5Qh7owITra/
    dp3Rglf398hEbs/DP18BjK3Zm0GSKD+QE8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236961; bh=tZ/WVNCSU/
    ybSfzEyTrpXTM61s0I5ULjxa43+zZ8YFs=; b=gkJIR5VZUxrMBvEcwT4M+ydkkU
    8f3frLTFMHdaBEdUhLW5uq8AvX4Tl8I0InpZQg+tpCluGl580lI9Pmgn+4nW2+ZO
    sJMSjTSF5aQfPQPSeBUcaPYYurU88riS9F/U5F3sprhtqg3yg/ylt3L1AWkGPjH+
    qveP1U0UyU02MnE1EkrgSOhnkkvHi7abAa23AzBGDiPKmGmfjzjIL5+Pnve5qa2o
    NgounzYbYtazQqYkRHpWTOmnCUaWr3MDKvDINtHMQFlPNSnhAYfXqhcsJc62uD+z
    SSyEZWZR8r1UcFAmna64qPZHcc/ZF4QSzzkZGFijXrvxtuUh5GzvbSnulfcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YedtXQAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YedtXQAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLgCbDbOORvUckKgyySTb/Pc5PMiIT86L7u/rdPRlGdFWVBOyJJ/MK2Npw4qc0iCCb0UI/acfVMdpX93DYwKULuYYpnvL7ZdEDVCkbJSxFBKeBF/x1eH
    0BKbl+kW0pIj7Go7vb/DC15uFGaRd+rXjla3qCQATcX0hSKvGX9QNLV6vT6wwqbx5x1CKB//GRrfOZVMXUZHJcj4162dC+C8Jj2P28aGCOAw2+GAYMl7S8cx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=XE-PKwxKN_fx57-GDosA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeDIBWY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:22:24 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932732AbeDIAhG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 079/162] powerpc/fadump: avoid duplicates in
 crash memory ranges
Thread-Topic: [PATCH AUTOSEL for 4.4 079/162] powerpc/fadump: avoid duplicates
 in crash memory ranges
Thread-Index: AQHTz5m1tNPvS5jWMk6WiQizUfZDng==
Date: Mon, 9 Apr 2018 00:28:41 +0000
Message-ID: <20180409002738.163941-79-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:8fl6BK5SfLDHSxFnytgcN9lYbj/yCRfxxxAS2yOQRxLCV2v72D3/PxQcyaJBjTHT+4AHjk7jlZA2INFDdTKvGMsSBlpC5QwGAUKsiWAX25du9o2Z2wwVHL1vrB7HlORshC110ak+Hz2/yQIqPmBtXq4abq4IFLBYutu3fbE4UqCr2DwsfDzVfhYG++vQJyOZLeI2ij2WcPkQPTugnwD1L6CKiDmTsIGsEsfCn2Fu1obfGqNz+qdSn4/EC9pNuD7z;20:zcTLg9/wkO0aUnc/SbxmudZZEetvvM1idBa3eRefnLXbJP7KiKJoybH7CM3xiPGgsyxNrOuCRvfcjpF/2ZCZXZYdiEuWSNfy8jS8MUa5CwE2RikbX4RJnyp80LCcCcxMShUL19UKCeb8zn1GV6oIakBFkNy30y6Lz0leXhwc0ds=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c5512c2-083e-4bf8-500f-08d59db2023e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885613C11F54B0A07B76E2DFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +PhLCYhGoYrwhH7ReSUfuZRPNGnbEpzIrjY472CN/wC+LbpyP5I9KBaKKMbRf8CIaFBrmf1Ex1sqEb+qSbEBZGvF7yOl9ktt3zQUmCIaS1d9J/rtnDoMBXBQWpXd03amUX1E4hmPl00jXZnzh14fLDLVVeV4cZ0jV2jvKF1nlLKLL70FuFRmsCGAiZ1/xP0baMZmcGfGL6qP7Ojp+Z8j2gLPPLXo0O6b1LT8MQWjErw1+pCQhQTH7Qmk5FLOHMyKVnTho36seM7hL941QYqPcRLR0Bz59+I/NSS+e8wh3Rs/TnmCCQ4tk1pqTamIEJdDVyq1jebd9r6x9S7Rlwvm73r3v/DOM+ORDhmLoCi/KcBq1Y0DPEaCXZ1OsBZxZIOWtWwD0Q2UsN1TmttXPchCje3XfT+i3mAXAVBfh7sK0zM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5512c2-083e-4bf8-500f-08d59db2023e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:41.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
