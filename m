Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233978-2-15362443189468485002
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
    1523233978; b=a1xiaPko2G+gn8cNhpCUb/3F9/XLvGkq4KMVJUhq+2CNitKUMa
    dW98zDd00g0K3k5E8ZTSuXIYhIjuIzqbgq0y6iEXrIiZjTZGSB+tf//UA9wVgUFt
    rMkkhy46PV3RfAQzIzeXJjp9alVMoZpW0q6tNMqVe3LZ7mk24jYSbxOeC3hT5g9w
    0S7ZnMXPVvaRZMVLkBnKonKpqC/346TaKtfFonVAHVAdDw7XXYAFYGeK5T4sHwjG
    Lf7CgPAkvy95542PQcrrSKDpjF84uC3YuBET5NOttxW4yioGXZ45cBEGUfLkNKFN
    YAf/ufJ569fOjGiQb1VUKd2HqLKjGIrxdLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233978; bh=8hWPdG3N4/
    oGpGBYFb511GqCOPYGVrRcI0g2M7jRCxg=; b=sHnURBrWMaZF6qnbxmKsHzT32P
    bktzV3o30a3Eekxh5lu6NuGsmCpQ+er/yFAioFSnIXnK9fVYmvTlv6WC3cml+WkZ
    n5es/Dc7KG0t2d6EEYTpmZEdrbdfm9utKRJEOr8vPEaB5HoHY9t+DHybXzgKQkqY
    GmKue6dawcOu5rVpe+B5L24TsQ4LtDo1KFpXUL3W6tLJqkxBL53AslQkzmzIQDAb
    fbeUnNDlKP3Fm+hQU46y0js4N3BF6N3FKTvlg7jZQBaGVBaXXM4qoC+X58gi+moG
    Tjaxxg8sABzCoU/k4l4fvMgOEomyWCBz5DlIKCMQKmUeMWcyKkGuWk5iYStg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YEYOngwb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YEYOngwb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL8uVbAI1CYj8DAQeCrp3f1V3yrNdGXrNsDqn4WaNrYIlIDKQjC4TZOf/FHQKAc9UICvI81OAAK2S4lokrk1AFe1cJMRlv+UBQ3DpbdHZ4y1dJbjrZTq
    Zg+0JfN31l/h77pk+rP0Ko0/luluyo+zR+8OUKQrW7Jg/s29neIFwKQqldp+2+hOnAC+oZmDUmNZtNBL0ni6BT7namoCIkDS5I9eHLGpsfEvnu3Tmq2lDIfo
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=y6OMZ25lKEibqHJhdFQA:9 a=wPNLvfGTeEIA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755688AbeDIAct (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:49 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:38400
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755585AbeDIAcr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 211/293] x86/tsc: Allow TSC calibration
 without PIT
Thread-Topic: [PATCH AUTOSEL for 4.9 211/293] x86/tsc: Allow TSC calibration
 without PIT
Thread-Index: AQHTz5lJ446hP3ITd0aMSrl1Ri9UZw==
Date: Mon, 9 Apr 2018 00:25:38 +0000
Message-ID: <20180409002239.163177-211-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:gztrUmzl8vj636TkEVU1etTa+QGf5haOx63RnlKZJulxFSBnIi5vYTIc3LFh1ReSshFrIc05KnXJea8HQ5KmqUNT8M6p6WJyDENeza71QBc9DZU0xEVlXK5TJsf725c+TUDsZIP7vEJ1r4Tb832QtUt7KI0oVgP96G7Is4z0tCO9fvfE9zUGLxhLkLEttqRsuiJvsMsw964WkKtVIKuT/1NWpoZbIkzD7gMUC4cQIhw6P7ozJ4uobMMbvg0tOl7E;20:AGybD0WQTfHgdbfJL0m/nrfQ7Mx3PWUKA40BaftLAxIFk9Rj/9OXE0MRIhXDlQEIRW0ZSqPq1pdAXWLSHKvVTGyj8OC8ELu9agKGzyBMVmVe0gla4AwrpuTgwhOGuicSCepm6dY0jwlBytbih1SeYoGDEZByn8BUCBoaYmx28Ts=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b98badf-941f-44a4-7455-08d59db1693d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806742B0C3E05E76C5AA940FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LTlB0tx6aHzzIhv01qTIbudi5mrV2aT2INhr7e3jeer7ue6P7XrpHCM0KBRBtNzvMhqf2kf3BRSyvtG/9d7QkJa9eRm2PnwQvijJQaEfKOn6QypjLhqPGbEl9ox91ng2LcRmIjSIv+thCRdpmCA7AI/aZU39isbvvAQOYwIm+/Yyyr0thYe4syLJprOrTv+cVooCbYje9wtKlIP9wvCK+Z3mZHVKYGm9rOTaP+8Ivbopycq3kogxe2Sfs3s64x5K+PkcJPDnFVbj4iKbdlQCRte7zkkg8peGZbLjVURmbnyfhZTZ+vqYEjfq32PMZwDUHqa2mv1EaFx240FHrQIbjSEu3/wECaevUUpHdvFsNvtnkEnvz19iKD++qT1/BniCxd3lDUVFzldGZDCHpEsnQV+Q0FABnQ8biXjjzxbqDMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b98badf-941f-44a4-7455-08d59db1693d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:38.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 39bcefc20de7..bb078786a323 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -68,6 +68,11 @@ struct legacy_pic {
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
index d07a9390023e..1845b5dc5a81 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -24,6 +24,7 @@
 #include <asm/geode.h>
 #include <asm/apic.h>
 #include <asm/intel-family.h>
+#include <asm/i8259.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -454,6 +455,20 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsi=
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
@@ -578,6 +593,9 @@ static unsigned long quick_pit_calibrate(void)
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
