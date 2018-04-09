Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236904-2-14682651639228346283
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
    1523236903; b=M26dd3QOIOcuETslKmuCaz/bgk+k6XDRUiQr9As28iuQADTmQ0
    GZ/p0YyuRPoOI6cFcxozqv+Xpq2CZ1wkD/keY7CDispbL3mK3MtST8mxtR3PgD+0
    fZxFnG1QD8jLHp+xXNcD0H2eSAlCtk4747thNjJSzWY99REg89IWyqzl8AaZYI3m
    epdHDUf0AiidFmtbinfETyQBMDRFVHUQkXujrZpBdtLm0uyXrKf5S3qFbedyrylh
    wCGF/Twi1XB42/a/xXwKkLnC+dqMyi0M+hhHXZYXyU7MTcJBh5qG3nrrG7Uhs5tD
    19teHHUbqlX5LHE+yA+UxgXooz1IkLHOJWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236903; bh=oI51bGZlrN
    f/IB5P408RyKEhnAE9k/9HNgOr/TOzdrk=; b=OVepRIC8pebhKsQiq2rUF2at/A
    1skZwrExQShdH5dJooHU4NjDKLyVhnC81dXaarIfMpd80/0bQBt43Hf2hCKxwyl9
    o8Dv/cHna2WfCPmZq2+f2KAlC4GAOHh/UcC21nrljshudtratHvolLVE2JYqVGgC
    i3kSswq18eo470BWJCcxAowqcA2lY7M9AI4kzOS+Bey8QtwsH5mY/5bGivg3uZ7A
    dF9C/kcZ6NtYl4B4exo6ZzL6pQU8KIUmXZQzsnahqS+vmydqSsy4+9zI1PCJPlCc
    gG95jLRDI8UQDvfXeLw/w9QwviBp+2cyRCxaHzSyCeZ5sxDNkmDZTMBlmr9w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B5eRYsWj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B5eRYsWj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZBB9DZJPTyrFRd0PaEzuEspRCvEYvaHfbupOfvgSZ9fT8nEpE9/9CzX8pwqwiKU7He9o8gUdWB3IGZOis85TYURzYv6b87lHDUKf2rC8zvtYdjgaKG
    r8aeVQLObsQaxlAE85IIFWPLPgoR7QtTyFYuHZSFUuIUW1Oxcw0WsgCG3xVhG82yxvFDXh8F0UnqIYH7vlm8jr+O+/XfcZCjO2nG1EyngesCptIWDqtxdt+E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=JTNdz_s2QjFUoanZVWUA:9 a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeDIBVK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:21:10 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932682AbeDIAhK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 087/162] MIPS: Handle tlbex-tlbp race
 condition
Thread-Topic: [PATCH AUTOSEL for 4.4 087/162] MIPS: Handle tlbex-tlbp race
 condition
Thread-Index: AQHTz5m5D24FYw4Ot0K8Krg3LwF1Ng==
Date: Mon, 9 Apr 2018 00:28:47 +0000
Message-ID: <20180409002738.163941-87-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ZrZT7ASDoClw1owwDsZ1qSmvbAj/6kYuleMRiG2p4l/KMtjF0HoGo5FAv7uaKHirjDJFvrDNKUeyKF4MjY05DMWrcCLg33qWsGQHfCkzAwVImcP42GY5OrX+SqRC95RRqGb/d+jNiKWxG/4nMZnYGVhIzY28b9B14WMzoJnNKiI0yuABJ8Zv0dYrhcgm5ZjnnP8cbb9Je43MC2tm9DSiOSQA3BvlKSqCdaN/7SWYEWrat4b/UBIT4cQSC7Jd33wH;20:Xqmq+hDdBUGwCktjn06IKzSbPUQY0dYrzS8fddP5nMaV9EW+sXJL6QGwXwPXmeZM2R5+tQRsrsrAEJ1MpBPR9ougdZT/4RGgdJ9o0eivEUKRKu9MgWM1oB+1TnDxuyRLVu4GXNf9rV9bEtr+7atICDFocZXocKPiBwnPVoZozB8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f99df4e4-dd92-4b11-2a0f-08d59db20583
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10319D2625B52E9236FD1275FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: g2NzJdCQvakOvuWFUBYiZTJXFN+BBTWh2Eq27G7pSwDRJk74eh95EikSa1bPRXu9wLRWJspODbd8UtvEQJDGOg5k8JAM9QC4tuvUTwCEzHttACVE/DXaiu6pOfS7HLOavmCs8mkxPl6jS9raXkxcNTFffQKQKwf488JWs2NZhErliREsXgn5CC/CFiF753La1AkgftgYe6Waop7v14Hlu6SszKJO77H6+aCII/6dhBPEjHL9mfPfSJIh3bY2Vv+/1MflITWniuZftjPJ2TyjuWbv7InjsplDx4YAusfpwSqugm+KyXaaTDIui1kvvI0IAGttK11GM1QK2YDfWWdYqtE0FnTENjlyKQAEBe8VaHpl5wmAojkgQf7cpAkmxRIq63iqUZYDmjcVccBddCLLWs9f8aFGNk0urD4pbaHgcB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99df4e4-dd92-4b11-2a0f-08d59db20583
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:47.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit f39878cc5b09c75d35eaf52131e920b872e3feb4 ]

In systems where there are multiple actors updating the TLB, the
potential exists for a race condition wherein a CPU hits a TLB exception
but by the time it reaches a TLBP instruction the affected TLB entry may
have been replaced. This can happen if, for example, a CPU shares the
TLB between hardware threads (VPs) within a core and one of them
replaces the entry that another has just taken a TLB exception for.

We handle this race in the case of the Hardware Table Walker (HTW) being
the other actor already, but didn't take into account the potential for
multiple threads racing. Include the code for aborting TLB exception
handling in affected multi-threaded systems, those being the I6400 &
I6500 CPUs which share TLB entries between VPs.

In the case of using RiXi without dedicated exceptions we have never
handled this race even for HTW. This patch adds WARN()s to these cases
which ought never to be hit because all CPUs with either HTW or shared
FTLB RAMs also include dedicated RiXi exceptions, but the WARN()s will
ensure this is always the case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16203/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/tlbex.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 63b7d6f82d24..b639e12867ef 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1876,6 +1876,26 @@ static void build_r3000_tlb_modify_handler(void)
 }
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
=20
+static bool cpu_has_tlbex_tlbp_race(void)
+{
+	/*
+	 * When a Hardware Table Walker is running it can replace TLB entries
+	 * at any time, leading to a race between it & the CPU.
+	 */
+	if (cpu_has_htw)
+		return true;
+
+	/*
+	 * If the CPU shares FTLB RAM with its siblings then our entry may be
+	 * replaced at any time by a sibling performing a write to the FTLB.
+	 */
+	if (cpu_has_shared_ftlb_ram)
+		return true;
+
+	/* In all other cases there ought to be no race condition to handle */
+	return false;
+}
+
 /*
  * R4000 style TLB load/store/modify handlers.
  */
@@ -1912,7 +1932,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct ua=
sm_label **l,
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
 	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
-		if (cpu_has_htw) {
+		if (cpu_has_tlbex_tlbp_race()) {
 			/* race condition happens, leaving */
 			uasm_i_ehb(p);
 			uasm_i_mfc0(p, wr.r3, C0_INDEX);
@@ -1986,6 +2006,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
=20
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
=20
 		switch (current_cpu_type()) {
@@ -2053,6 +2081,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
=20
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
=20
 		switch (current_cpu_type()) {
--=20
2.15.1
