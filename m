Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242072-2-16548477598601190230
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
    1523242071; b=RfXlC1v/oybQM+AiKhpzqSiIOf5xbsbyEI4Tdpg+iCvvZhEJoq
    ksZSLZjP5w6ZanHv9/gqH0t5f/msky+OvMj43o7ya/vuWKBhpUm4jxC1cjAVaEHA
    wE2kAHoYYNdb0x6bxwKczINECH5w+0GOH/NKkz0KMXVCrN73V5ibSS31iHkXvvF7
    t1FUgvPtfg48ucvUyU6hwQvUN42grQggsPP5ndwmv0nKXKWSlZZNHJqxraycAX2f
    C4aX9LU+Fg4N891u3L57/u1yhuU2Mz5r1/Dw/1h2RROHOcP7EYLGrY5dMIh5gSP9
    16YxS84qqolf6vJae+01beh5xfgaOnDCQ5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242071; bh=eJCr+ENV2x
    tSuikKtG94QoJhvimjb4qTNrW9jPVmO1w=; b=ONIcgSFmY3T/07kRsNj4f+I2XZ
    FENx4B1ktA17rVuy7QMYn8ZziZmxmjfweZt26POBrr/vezgC8Q15WdNx1XeNV+QT
    c6175c5g4xWVFDTc1P8GtyAgsu7n7p9U4uzD4+OsbIwgnSqn44ezFE5PlLiyJqLC
    NIYYz1a55xGn79zoTNDy+URIpS3xb9Zfd8NZdXEajeei/1m2SAx6WNBqo25JyDs4
    45wDqzvoJQRQZAhlFoqlx2J6oHOBQmke0oAAqb7gUQ/HSrzjNPQE/QwSz5RCScQH
    qO9WXsMRiuBWu91eobiBjWN2u8RIrch0+JKjPspm3an6/497OfQPn9iGgcXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O19ILJd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O19ILJd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG7CTs0ghzp7MxBPOSIvXgyqGbntrDlIO8bEkyMsNaIol+Wx0PAwgCX6vcTt94uYCKCo4Kvk93M1kMp3OybxS6TcFGd8n/VD8xeJfYc5aFDUXl7ZgNcW
    FONilAN0xAl8JhyhTT++HyrJovdHHAlvrwv15ponqbQ7HnpAWAM5m2qGe+RC0AL0J8RmFc0arpAdJJjRiOVqHIkVUGfMA2iG7EYxqKbpRyMZGqK4ePSo2JBN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=72xZbA8UcqOln83T7vIA:9 a=4zZynRfxn_piIYhw:21 a=IFRIY7OpxCe8iowW:21
    a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbeDICrg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:47:36 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755396AbeDIA0k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 008/293] MIPS: mm: fixed mappings: correct
 initialisation
Thread-Topic: [PATCH AUTOSEL for 4.9 008/293] MIPS: mm: fixed mappings:
 correct initialisation
Thread-Index: AQHTz5jmffflvfqTcEK5VadLMjKj8Q==
Date: Mon, 9 Apr 2018 00:22:53 +0000
Message-ID: <20180409002239.163177-8-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:+SlaVoWhL8EKOxchST3Dzj/fTjzOFG245aJAZ+dgridtFw2jdh0WR3EofcsK9Vk4kNgQ5CxP1fxQBx0u7KE8qvA0saQ0FaLtfOvLANLMCUtoMGmYD9FVvithXGlvodCprgoTl9eaajD6/R72as+Pufn0pJK+b7fGI1mcyNUe75pF7VSi2zXLSIve3m+v12gVXjaziLp7cUlJLyGkCKO3oeMRpMxmncRJyzek1KyBQt+keYva98q8xKMBCH3bv0Yd;20:wmoDG1X72pZpYqCyboSwMh9DOvURuX4DY84S9B7Qm92AOgj+lrmRYXxGiLbPxo7tHdXbJQDa/qSaJfne9YtF2CYi+8TSH0/cX3Q5AWzz42aPE+9Z1HkMOrmGkyShe+0Aj6f0NyGf9MZUtlZMthJejwbuk9w7Cvt93adqJG8HaZA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47e840ce-e34f-4035-8901-08d59db08cf8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015FE4754EF1638FD8941B9FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NPo5mFN679odDJxKDtZHwgI/ZRejav12mYeVR9T4M3blMkMasIEwcwjloZIdUj0EE8N2tpeopfhWP2aoUzZHcEdn75VH8lBQLDlaFDqFCp5GaE/6sOh3k0GKcE5OclFnfKtP2jeY3qXpPI5AVdxkaCAHHHxpHtr9HfTXJAwp+/y0T6p5GM1PehfAaymao0xkAopY5kz86OF+GDr+D5l5iagGdRDJD1QX2nA/oA6nAk78OVQfjzNEeKTCw5GcYWJQmnZXOlPKql+3MlXOzlUqcRzj4JVff5n1hO9GO0EY4TurxHhicbeMZi58AUrTtjBKRmzd7Fsk6fx6f6ZdYxCdkwamRV/cjoFXhARyZg3uprDGppNEfLBK4yqlCwafWIKs77s+mJemPcrE+BzO4yGIAFb0s0BR+j3anHc+l2HcGec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e840ce-e34f-4035-8901-08d59db08cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:53.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
2.15.1
