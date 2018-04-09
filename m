Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523247242-2-17700047940001195870
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
    1523247242; b=mNPwtnZ93dtOBUCmPIUvG1AEdYvdppHHUHTyAw4aZPI/d6zoJh
    KX3uAWBtbUkEBP9/qItkauiWtJ0HzU7jloYDtz0ue0ztRNhT3OKwdtLOlVmw89OV
    8oMmtXk6mn9CywF9nBW2xUPfVfdpuuGAWnsWhYxZjSGK1LjYnBEd8YTIZafNu323
    LM1+LPLU5wYX3teBWxVI5i/X3vdqSkmV4Gld0cg6ArRHzvilzRitMA/O0ZqFwY1l
    CsuxuXOB/2MNQqttiT1NH88xv2NHMvRiqj3vmvVzJ3EgqchZgPzKZ/+V5FoBbUBr
    O6jC3DOkEjwnJ2qkFhRcMOEEtAsXps8IrAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247242; bh=8cGAHt30U/
    85URrck3jG/Ga1EeKF9UP3gFhx52bWv08=; b=v8GLLrIeuoVRODt6uJmhmKbf9O
    qHtl4b0yBqAy7P8mGQr3JwJPYWU7O3o3k8BnOrDVfZHr61wFti/wA9H5P8zDgKbe
    io9L2gbfsavjTJ4rg1J+0ZwJ+auuwTWp7eNkGzBJNd2d1ihUOul8O4ieCPj/ooWu
    ItOpCRM8ncIv1qn4k2dcXs88L4iOkzifvutgZ0w4uQblYvl9GX3tkQ5dH6/WRhIN
    93rRgAGbQS2eRX/T3G4gDTI//yFngjnU5QFCM5lxPBHVzj/gJVXorqHD1oKieu/s
    XxsPkIyJpEPCZld9wcV+RUWcf+Val9bz8qdWAyACK1d6BFpA3hEfRSfRG1oA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OkCGEpNo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OkCGEpNo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDtxUjnH8a49+IPUxm6vw+3vZclsnG2b8O6QCeDUb2mXI07nGk9r62SXdb656K18p+A1VZU1U+geKCOhEHh2xqvaEBDfXEf3QwDoZ0Nnd205qKGxkAQ
    7fJyIEftGB7jibFVE/vxArTyqmluFsGdU0P4Jvf5encodD/UAePl3m1fEm5Mzu1dwPkwssu29R1a6mhqVisdaz61swLYMLHpp8ufHMzr7IOkBXZxkuTDOJKN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=nx-MtzKQSM8yyWpizkIA:9 a=wPNLvfGTeEIA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDIAQs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:48 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751919AbeDIAQr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 002/189] x86/tsc: Allow TSC calibration
 without PIT
Thread-Topic: [PATCH AUTOSEL for 4.15 002/189] x86/tsc: Allow TSC calibration
 without PIT
Thread-Index: AQHTz5gKPnhGU3Bp/ES25B9qMSEXKA==
Date: Mon, 9 Apr 2018 00:16:44 +0000
Message-ID: <20180409001637.162453-2-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:z+MdDPuZZXSmDDO4kzWLkD99CTNsY7VpiFCrlCpaLW+XvFrxtrWdgV11Ivt+mRg21Jw2jMX/uUWCycjoRnzsstEOUj3vROd33cCiV/cMjPX/TT1yMgPjVXksCvc3HsmsRiO2ITYbS2H6n9MiQ3Nz2yK98mSVdZXnMF4N4PSf1/f2azT9Y0q4mSSpvRU4/ZFL6/G39B7ddUADy7u1Jcsdrr1PTlyrHO0i17j2j9WEoVWMG3hjzuB5NniH7Yz67OD9;20:7j+rNjL6iYnDPcL24zaY8JigFjqY+yfO7BodGUICjA3RwHm31foXZpBZkXUcf/zwLIg0vJjdnV15EeGEEboTlC62BUoU2yVZxwWkmZP7jwfbKnYlLB814qY9S6hPJWCfobjDvSN5uEuYQ3ZEs/xFY2EETXW9FnHNqLgw6NUXE8s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 58fff2e0-da3a-46d1-43d0-08d59daf2d7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09685FAEEC94F9BD4C840270FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(6306002)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(966005)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zWAS71Fmu+HMwIpgnM8YLPYAE/t9LvddhhaayDvI1vJobIggx5K8Do5lnElKniSAo51ez3CzH/iXoD1nnQdwUqwDBG//uDVD7tnB3wpcAZjhMI5RIAu1pIA3nG3f2RL3SBvrn+1aahpyIofyhHAUHqXocWx3UDajIYmEcHjR19MfOkyL8jRowNoK10+lGTf1baHet8Op1pyB4b7+08ulMTTkG/fX9QL6zgFMQvnyiow+tzRvuoaqgGaNzBL5rZ2snfnGR0NEykHS8Gwg4EQ2TiFMioLpi3XEhQhL2wpoc9CkKGgSh/tZiUddUarbDkb9n+TBLpSYofa9DeggX+9XX93eZ/D3s1n/V8tBcqMAr3fUzUfRkpCy9m/txv0zpec4nS2y+n2Wdn+0DdvvClE+Y0/kB4uKrNALznbj3wHEQ5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fff2e0-da3a-46d1-43d0-08d59daf2d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:44.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
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
index e169e85db434..a2c9dd8bfc6f 100644
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
