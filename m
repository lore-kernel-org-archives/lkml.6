Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244609-2-1460008330270484051
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
    1523244608; b=n0Ew/GbH501uD2uwhOVeW5LAKh+h8RWYkCsBoRqtlIO/yrJ1MA
    HXf2uItv17R5sFdfAOOOPfwjptJpd0Qaa9QmrifsNo1f5Ja2n/Bc/YkcnqcIOQIL
    1ovCpBDwHwoNv3N/9rbyklGlR4EFBzI8CPKUl7J3rQUY0QrIQlABKdiDTEdEMtdL
    kgqw8aA6Sojp578eBK4KRX7SQprjUunoJ+65CmybW5eSOFtKLz7fbwZcGayNb/Bq
    mVZxa7Uw9ZSza8m6I91rHpxKr675c6VeUVyds4ohTEtxffNHD7uIxnchFZxKTco4
    SUdwQe4spBRgaIWHiT6btJ9PG2cJojvPL2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244608; bh=A2C2p/i3AE
    ENc6QZtVr2gQFSgqsZbN43PdZQPZlfLVc=; b=KXErOr9rbTJZ4xCsfjt069wAmj
    dMpajDz545k8gK5er+j9ZR7lXAT/KObIZoZcpC9cmUTiTsVKuM8xRiv+w+89WUZD
    7UahI8x9vLXIXnPNRtMuUoCPT4IoCmZdfQKWCfqCQIGf5sthg/AtJwYtJrADcz+f
    BCtSSu6G4hBVKR+9DEupAlydgMO/jfx+QOKeAQtEBj2nz7O96TT+/+/ejXlIOHTd
    FL7FlXslKcr9pkOTy2voT6ZwvrjQV3nYKRB9NTtBLmItHvfeQ1i9O9O/m1jSqHR6
    QbsDJd2SFCXF42aYoG7bIroscsPZv+wtp3p2swuOWxklvNgGdn3+YpDuWeQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DboLxm3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DboLxm3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ2sIZ/AWdIbH9NQyvxNo6NwsrsoozGL2PP4O+0uLcxxSkDm6gicvrYNuLZmBHVOFxTEHQ9tFa5735GD9nvrYTT4xwgk+rMp9Fjw3XgmGfL3PlGQN6me
    qzsDhekIviJOupB8YzSvkyl/yV08iIDxs1zPwvavn/qAPrWKRiEsg1yuapAXqlBWPOTUyHNNwzFHP8t7vBCe5XVJm0xm+VKRBv+YrJ9iHGj6CLWiM4WVeDuq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=nx-MtzKQSM8yyWpizkIA:9 a=wPNLvfGTeEIA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeDIAWC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:02 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754538AbeDIAWA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 002/161] x86/tsc: Allow TSC calibration
 without PIT
Thread-Topic: [PATCH AUTOSEL for 4.14 002/161] x86/tsc: Allow TSC calibration
 without PIT
Thread-Index: AQHTz5h0119NV3tAKE6PTtmIxnKY7w==
Date: Mon, 9 Apr 2018 00:19:42 +0000
Message-ID: <20180409001936.162706-2-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:O4Li5O1XdEH0H5FrehgSnrU65li8EwglBl54D2MVk9btxhDeIX5vvJAHm+HXUEIi9IXyK+hfzYS+C7l4/NBDdOkoNi3BMLDlhbTWVShwGnKKrpFP9g0ZHSg3bWCrXbKPl8m+Xr4U/vujPdcTOqCmUvZMvEONtBzw47sRInem5r7ULSapZND5PG3AYwiONcBq0SucrPX8Grnq3T6nAiKDjRhZIHpeP6pcK0kVNMWYNEWFH7xzo+yfXOEeAH/d/ODu;20:NhbYBfADKoyRw1WsRJo2zNqBZL9DIapDaPHnX/oADIW/qnzmyxuRAORlcSR3jsJ3roKY3YlIpwjdGKLv2zYWnno7Ea43BWE3gHrQEI0+xVTUfQLwEg827AuhCdt3Dwp/9TEMYjLq15/te7znE75xOOe9G5B+6nUStzKKTL5eonk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1b751e6-37e9-40c4-e9f0-08d59dafe639
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936B58291BAFB6A7FC3FB65FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: z1gvD50oZdfGag1p7a//dNRj4OyqsnZsVIVzkVhAwxOKAmCZNrn9mfM6/ylbrDa5WQF0/cb29P8I8EVcYvzC6NlaujmOMWPqEM78DsR3C9AOrkjZW6WL06GNQ+SpiahJdNgb4aDCXz/Ch3D1jHiGFdnQA1/gxnb2p+r6DmJHMyJoqcTa5TklaVGzWlJwYJzNxcf8lcaXa2yVPC8PMacNdAWzC+sRffqJCW9QRJn8POllSAaCkq0i3rPUgDKpyUXP3Ww1lBQEPnkErH0UuyiN7ZP5ZpNUQn+doTn5+HHO9xhnQmQY0ojmEpciB65DUyXmeBsDDaSoSfk7opfxKRZCe2RrXtjAFYD0A0p/RiKoBXMBCH/7k6ptT7ErJ8Bg7UW+PiYlAIPro4FGMg12szTBOEJX6yF0qPGBVYAjtw54of8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b751e6-37e9-40c4-e9f0-08d59dafe639
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:42.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 30c7e5b123673d5e570e238dbada2fb68a87212c ]

Zhang Rui reported that a Surface Pro 4 will fail to boot with
lapic=3Dnotscdeadline. Part of the problem is that that machine doesn't hav=
e
a PIT.

If, for some reason, the TSC init has to fall back to TSC calibration, it
relies on the PIT to be present.

Allow TSC calibration to reliably fall back to HPET.

The below results in an accurate TSC measurement when forced on a IVB:

  tsc: Unable to calibrate against PIT
  tsc: No reference (HPET/PMTIMER) available
  tsc: Unable to calibrate against PIT
  tsc: using HPET reference calibration
  tsc: Detected 2792.451 MHz processor

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: len.brown@intel.com
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20171222092243.333145937@infradead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/i8259.h |  5 +++++
 arch/x86/kernel/tsc.c        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index c8376b40e882..5cdcdbd4d892 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,11 @@ struct legacy_pic {
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
=20
+static inline bool has_legacy_pic(void)
+{
+	return legacy_pic !=3D &null_legacy_pic;
+}
+
 static inline int nr_legacy_irqs(void)
 {
 	return legacy_pic->nr_legacy_irqs;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 47506567435e..03d8e9204a6a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -25,6 +25,7 @@
 #include <asm/geode.h>
 #include <asm/apic.h>
 #include <asm/intel-family.h>
+#include <asm/i8259.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -363,6 +364,20 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsi=
gned long ms, int loopmin)
 	unsigned long tscmin, tscmax;
 	int pitcnt;
=20
+	if (!has_legacy_pic()) {
+		/*
+		 * Relies on tsc_early_delay_calibrate() to have given us semi
+		 * usable udelay(), wait for the same 50ms we would have with
+		 * the PIT loop below.
+		 */
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		return ULONG_MAX;
+	}
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
=20
@@ -487,6 +502,9 @@ static unsigned long quick_pit_calibrate(void)
 	u64 tsc, delta;
 	unsigned long d1, d2;
=20
+	if (!has_legacy_pic())
+		return 0;
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
=20
--=20
2.15.1
