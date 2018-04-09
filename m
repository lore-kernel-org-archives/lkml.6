Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242685-2-11316812052408016972
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
    1523242684; b=hHNgKDQm7t5zIk6pQRmm9xiL8pUuebzRFMQ2hEYNzKxHog8XJ1
    u1ECL4DhWa1jUWo7oLXHnNaHGRw1K6DpPI6OZop/SUehwg1vszebaPqEIeOH6D0m
    pGcjTkHDbslpOT0looLUm1MYYk4jBc7fDn6veYmTa715ljXexw+AVfgdTteZPXTX
    rp/acZ+H3Lk2jX4H4el55TYGnsAVlHR9IuKqaUaWgbC/hLQ3N3Z03erWOsBC/3rq
    izvy0TmFD0WBm70AOMcblPdU04gttAuMZz/NUpcr5dOvRxHyOcujSB2cKgRnFnft
    9hTX/ml03sLvijL2Bn+xwCRLlcZYig+nJGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242684; bh=D8Q5W03mgN
    ZuzBZTpOGSmyjkp8KsscGI7ISYH3ffmko=; b=dKUG2l/Ose5jrb/L7Q2seDeHOV
    ypBtp3ifb5w+4J8pW3hq9yHHDY4Fl0fx2LcLVZ8TfYAwpEtYMA96kNG/QxOCEr3a
    xUPxozFsb4h+3UCUl41pEtg2iKbM3tB6qIEAobARyMytCFDTVPFq9fiHZIhgJ6+m
    WshIGx5SrzjMQOOeI333aA6mcdROsF8/JJPJwvFdnrX49yAfnKGDy17SNlfynAhW
    7gn7nFjgILidO2cDvWzByXWc+zSY7nnViD9I2RACRosTp6vCWh34g5swo9hFLbq4
    TVeCInPMG4Ta93tEAPl48GiKBs2Zpv+qc5ORRlugN1pGC0nWd898OpOnFq2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jcddq2OG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jcddq2OG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDnsUhwotY1fmiksDBeFCB7kl8ZV0Y2zNSPm4ZmwdOBfgGJELebges9P6mlWq7Wyka1qmWGhsPgy9tc4ZM6YNv0pZo3rJ6Z4zjuycSchiC0GnBj97AfW
    cXLELLjpFqgXvqES3k0o1dZfDb+hrSnB4wbuMGzi7Rss5fahn44cRTyffcXEaaKsxzt132KQiXFOXGgWpjkk59KSPmeCGUjELv96QfZSsj1aCw8Pdnmz9I8u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=bXTVU1rvmwoYY_QPZfUA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbeDIC6C (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:58:02 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755188AbeDIAZg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 126/161] MIPS: Generic: Support GIC in EIC
 mode
Thread-Topic: [PATCH AUTOSEL for 4.14 126/161] MIPS: Generic: Support GIC in
 EIC mode
Thread-Index: AQHTz5i4tpDjJ+CkEUW7ERLU5WNKMg==
Date: Mon, 9 Apr 2018 00:21:36 +0000
Message-ID: <20180409001936.162706-126-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:60ZROYFX8grO2Odc//pvNYOlnboMwrFk4hB6geoVmmNvZYMdelVAbEMTpusIn6fh2QCgAVYLuFchIY/8yB29LpjftnYR2xN83VZkeFd8WCRYyah7WC3PJdvjV0cCicfSIqi+gNVIi0F2M+yPowZF6l7Lo6b78oft8rDM3Yd71gIwe65bIw8qoxoVMEg8vd6iSzbEbruwkq94/mASH2kousl5qXo/DwafjqP9PnfivDgoGBiL2xBXkQtCVLKTyjJ6;20:kluLAoX9oNSg7YUBI3FziNLa7Aab3GCmd7pOOt/wSTkPo1Bk70YEQcSjiEHr30Oa+olRibu0QPPbjpa6X0WsQ3y3J4Dzm5ReGa40xiOk0rWNCBIriQby9GT3ShkvLbrpSB5YdGb6ouorUKVa8xmvD3PoP9ki4ZVzYrDHAafXx2U=
X-MS-Office365-Filtering-Correlation-Id: 41b05cf8-66ac-450f-06df-08d59db0690f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133D44CD7E53BB9E18D182FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Eko95FMDKQy/I+SCXnQHw7ypZqjpbadlQfmCwMiwmMS4rv0a53DyCB385EtiP7fFxyLpyX54H0dUbhvqm5py/bSEQDB92mkUDf9Y55bvPB8PJ6ti0df9u77GAtocpnWkLNhDwvq+8F5C9DJQsg2s6okJdi4R4vigQlD1PK+W9nnWrKmbgvHKL1m4F/3+dpJPz+t4pD89V2cNTmyzH3Ug0w3gBQToWDr9Y6kmEFpEvVQk0pX1vsUj/AFaQoxxfRkxMuDe4nTGv4oII3+UcsR7kO2x7owPZyHfyyVKbVqfZMsFTkNciyjLpKVMHLAM9U2H3Ogt70L4OOoNWKxxCL6hIW6/3MTRJss3SpFKqlMX/1i91AYK7wqeQ5Y8YoRZITFAmxYUciyTr/lRQQVuL2PXSdb+HXpAG9HlUnCgMlYoCR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b05cf8-66ac-450f-06df-08d59db0690f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:36.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 7bf8b16d1b60419c865e423b907a05f413745b3e ]

The GIC supports running in External Interrupt Controller (EIC) mode,
and will signal this via cpu_has_veic if enabled in hardware. Currently
the generic kernel will panic if cpu_has_veic is set - but the GIC can
legitimately set this flag if either configured to boot in EIC mode, or
if the GIC driver enables this mode. Make the kernel not panic in this
case, and instead just check if the GIC is present. If so, use it's CPU
local interrupt routing functions. If an EIC is present, but it is not
the GIC, then the kernel does not know how to get the VIRQ for the CPU
local interrupts and should panic. Support for alternative EICs being
present is needed here for the generic kernel to support them.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18191/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/generic/irq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index 394f8161e462..cb7fdaeef426 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -22,10 +22,10 @@ int get_c0_fdc_int(void)
 {
 	int mips_cpu_fdc_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_fdc_irq =3D gic_get_c0_fdc_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_fdc_irq >=3D 0)
 		mips_cpu_fdc_irq =3D MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	else
@@ -38,10 +38,10 @@ int get_c0_perfcount_int(void)
 {
 	int mips_cpu_perf_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_perf_irq =3D gic_get_c0_perfcount_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_perfcount_irq >=3D 0)
 		mips_cpu_perf_irq =3D MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	else
@@ -54,10 +54,10 @@ unsigned int get_c0_compare_int(void)
 {
 	int mips_cpu_timer_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_timer_irq =3D gic_get_c0_compare_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else
 		mips_cpu_timer_irq =3D MIPS_CPU_IRQ_BASE + cp0_compare_irq;
=20
--=20
2.15.1
