Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237772-2-18014719806122128825
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
    1523237771; b=SdZcclGcZkpRZ40q33idz/B7dfwsKPIzUtIKQdUQBJwSujquCe
    Ec6VaXZDyetqGXrxO05mESGPo/mqLJe5P1VRubknoY9PYRPFBTNI9QI/ORfrhlEI
    FiqNY7zBnwRlJUbRDMBZ8DJF6wGZcLWS5K6T2oPDYvmEZf+ZUJJRTpfCSbaEJAp3
    ODToYYuNA1nVbL87w2vEIqSsO738Ofrk1gDyW00Ew93MybAdfni9Y96nptxk8srh
    dE6cpISuEn3yvezGno19fP2F9c7hCRiI0giPalhm8wq8besekJMPj0lrf+MD48BG
    A3urGhnVpGsHwWpL0sx0NT1t3KiWH0W8Gi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237771; bh=zdET7kbUe2
    VPlHUtHki2oJLc0uTICM3cjEtzwz8tQyo=; b=oXUOwarpV+jy6NFY5LqKCwDvNC
    pM+lkdkNnZXLgoSw3n17G/qs3RmDrJyZz/5cNKPoyOYl2VnRpqU0EmWtu1V9FhB7
    zTzHdzrCHKM1O4oRKsZs2fqkDP9yy9CysGqoj9PCTV3EzSZo7GIke2ktEcpI6c0F
    78GJ/Bmb1IWu5TNGLJwJJgKt27zRa+D05i3v1221/JKMP8jdWIJkfXkB1aKI5YCf
    uYfNw46EiE+QYpbvkrWWlGN1Ua8H2plR8YK6b/IcceK+P3jY6pO7tGpfhHmIB2Rp
    q3H63cN6pmTJ2if1xb0mPokYCjgBkt/nWKuA6gYCHQxirhjkH7gs+9EKe/Vg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LFDVQUiG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LFDVQUiG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLIg7hisBTD51W7WobdSmzQugYQhomMuIzslsrt+cYYVqA44osBLFNIG9ql7S9H2QEX9DaUY5x/BLnubWeK2ipSNzC8L4xZjRx3dFu05PtiLKjumeq7D
    lKbbPINRN++nIhZn2d6VXh47dTjJ4YflhaHYRKINFQKGAVso8jcFc6c3qslczUJJQEwws6d5+b5TMBNblmskHhhg7/2PPF9+KCv9/ZCkujzBZ3nDt+o2QU7h
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
    a=yMhMjlubAAAA:8 a=gYLVPaDO0sj71Jv8NcsA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeDIAfG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:06 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755772AbeDIAfF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 018/162] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Topic: [PATCH AUTOSEL for 4.4 018/162] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Index: AQHTz5ma72q7lC3LxE+ROkAIyDKTNg==
Date: Mon, 9 Apr 2018 00:27:55 +0000
Message-ID: <20180409002738.163941-18-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:+ofxis3V1nNWtrh8b16ivq5Yi5EwaSwr0Vxf1EuD6PxuXdPawDrTPUMF3yRu2k2KmlzFPzBF+9ZyQ2fwc9T4spYcQCUHmrtzxtExzWX3wHhj9SiFS43cf+OwYLIjgYWB/P/xSCWWsT7uP15DjuOCi3g9qPMs2mRIPW1a2TK97ILS/0IZZxlzbXYBDs7qw6+Qb47DKz/6z0QLLAPUT9xfkKaOI4wTXGPqimkraEiOdo7qCrVJVtfMSSggAvnueW2y;20:+2E/DGxSP6zRzK07pqoMMKAOQPRZENZWHh/5TLgxrJg9LCPh2QIX5FdaZfCYJvrLkXVNFCvxuAKcaxLCGtVmE+0WZ+sk/UxGE64knFUgxH4d0wNtkg/vDQLlZ0mexIBvUCzCeHL+vl/BGUidleBp4X8eoUJaxczpPsF6lFStLy8=
X-MS-Office365-Filtering-Correlation-Id: 88b437ba-d992-4816-c0c7-08d59db1ba85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10137334F2D9F40724966C37FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(966005)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6306002)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: N5wjTTxnsl/T6kxv+zlDernzWSwgMj1BVTiFzaySnFKxx/w1jxKjFdlm1O2kCdtQjHati9LB0t3qvb47kz7NBBbVyd1CPF3UMrVTZKnkk5QP2Y1iYEcvVxh6+b2CIFIDs5MSlXgnFfJt/QiX5vAleYz0mkErfitmI/QB9H/ZMkNcHvJPgslQJae5HtBrhNpFfbeSuGVuztwnuIDzqFt5zNNvFqCTK+dJsH+e6JzSUleP+gAvpfoHQ3ltHTxyHZjW5r95c6ToDlTZR1qoLRHaT56g+HQvMs/Jm0lHURaGCCxCGBrnvImp3vnI3FaY1laOdY+Aju2WwyAoS2xircqxMTVC0RIwNfBhk+fkhQqjH3xHovbhlitZMAmsyLjZuYu3Qk9JqPlqbwotqfd5pa/3Slay98qU8LgQkQ5KseWDNHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b437ba-d992-4816-c0c7-08d59db1ba85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:55.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 861ba6351c520328e94a78c923b415faa9116287 ]

ACPICA commit 99bc3beca92c6574ea1d69de42e54f872e6373ce

It is reported that on Linux, RTC driver complains wrong errors on
hardware reduced platform:
  [    4.085420] ACPI Warning: Could not enable fixed event - real_time_clo=
ck (4) (20160422/evxface-654)

This patch fixes this by correctly adding runtime reduced hardware check.
Reported by Chandan Tagore, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/99bc3bec
Tested-by: Chandan Tagore <tagore.chandan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/evxfevnt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.=
c
index 10ce48e16ebf..d830705f8a18 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -180,6 +180,12 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_enable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -237,6 +243,12 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_disable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -290,6 +302,12 @@ acpi_status acpi_clear_event(u32 event)
=20
 	ACPI_FUNCTION_TRACE(acpi_clear_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
--=20
2.15.1
