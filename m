Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485721-2-18355988971009703903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485721; b=mnxMis5RMziZ2MvrSRxCq8pUj9tRokKR88BRs8CvlYK9DOr
    fy0QW8nhPuWi2sHcaYBjlmnlevqrDxOosg17YWkQ9W6tcuMztExgefkb/MYomXUP
    Tqiv/dlWr8nLB/uMz0LYAbHdAu9zU/CP4kbbTYg0FhpMyd5ILqM/H6t1U129TtSI
    mJHaXarn6rFfo5gfAR2Zh1cmwa9MSHdEPpnBkj9n5TpZht0MlaeM3UHftz3ltocO
    SS+7Wk34xcm2Cf+QYQkRdu8OqM2X9tGOfdgVgAb36ZxJW4x1s4b8KD3whuQXhXm0
    h9gYazDzI3a1PjSPBZ1fliT4EanLJ43GIp3rwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485721; bh=K1AFXK
    S/Lg8WeVDplcZ4v00PzpoCrLIe0WiWrHVepsA=; b=NX83XNPUPngdrm8c9CeHJE
    zV+DzB9FQbq5o1y8UFM7Nbj5WD0kSxvUOayW+HHuO7BoY2cZlHsMnRYuGRE4nFWe
    YdDokYswKlis1sGIyFFvCcYL2lXOhkbL4OY98qpUp7M49QPdsF2cLEvFr8X4v0yz
    PccXb4yVSvXHJlnHqms/yNeWDkDMh0AZzEiGcdR9/Tixacli2VQ+0SMonIFmMnpg
    7MPrFQeTf2ALWW+YoIr415mtg1Gv/cEAIGJ7BtH4nJW15EqjRphQo//MbYOj3iZ/
    rNPVllh7T43QJPUhzMhPMthsDATgnL9iraXBivOIYtd+VNICRndhRDqRgSdpAssw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTxm2jyV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTxm2jyV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966419AbeCHFIW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:22 -0500
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:48480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966725AbeCHFIN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 12/53] cpufreq/sh: Replace racy task affinity
 logic
Thread-Topic: [PATCH AUTOSEL for 3.18 12/53] cpufreq/sh: Replace racy task
 affinity logic
Thread-Index: AQHTtprBP2t6PjNCL0O2Fl4+exrjCQ==
Date: Thu, 8 Mar 2018 05:03:11 +0000
Message-ID: <20180308050230.8876-12-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;20:e85uzPy3N5TMU5H5IRg721PeFb2y+DWMMLgKg/Xgw5D8yB6iYAuQAr5fNp722jyLs+eksbOlOhiEjzcyAiRswQsEqh+hN+mQMONXNVZeewnBJS8VBXJxQwnYCJpzIVCHIeDSjW1lX+WHtjewXpkZxYDxgvhjobu/Ae0K+CP22kg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a3bad67-579e-42f8-8333-08d584b293b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08715925370FE0EAB8643ACFFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(7416002)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(966005)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(6306002)(25786009)(4326008)(39060400002)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UZBf+qUUGue0O/BXS57mVIVos+AMQykLk1DIWB9sQbhGR57Tsjxo/fuqI3frKCvwpoCYih6Dw4XrjRuVdUQsJ9bC18nAhjiV9g3Ra1aYRToyNF60pBcNmtyGEp2GMyMKas3wc4a7VLyL6fIjmmVMtQD1GrimweXv5vovHc6M72czO435hqS2uQw1WuagaqIHRIpP6yV1BsNf/ZtMM8iOgE4xpFOa0UKwR8fmDNcToU9Gmbn9nLc+BCLNdj1ASFuGo8g/I4O69HqrQ+lVtvZK4HEpB0OiwV7NW6u6scls1Rv23EbslJGza9A7U4o6cgGU3EXJ+WM6tsr1dQElYwS5lQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3bad67-579e-42f8-8333-08d584b293b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:11.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 205dcc1ecbc566cbc20acf246e68de3b080b3ecf ]

The target() callback must run on the affected cpu. This is achieved by
temporarily setting the affinity of the calling thread to the requested CPU
and reset it to the original affinity afterwards.

That's racy vs. concurrent affinity settings for that thread resulting in
code executing on the wrong CPU.

Replace it by work_on_cpu(). All call pathes which invoke the callbacks are
already protected against CPU hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.958216363@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpufreq/sh-cpufreq.c | 45 ++++++++++++++++++++++++++--------------=
----
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 86628e22b2a3..719c3d9f07fb 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -30,54 +30,63 @@
=20
 static DEFINE_PER_CPU(struct clk, sh_cpuclk);
=20
+struct cpufreq_target {
+	struct cpufreq_policy	*policy;
+	unsigned int		freq;
+};
+
 static unsigned int sh_cpufreq_get(unsigned int cpu)
 {
 	return (clk_get_rate(&per_cpu(sh_cpuclk, cpu)) + 500) / 1000;
 }
=20
-/*
- * Here we notify other drivers of the proposed change and the final chang=
e.
- */
-static int sh_cpufreq_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static long __sh_cpufreq_target(void *arg)
 {
-	unsigned int cpu =3D policy->cpu;
+	struct cpufreq_target *target =3D arg;
+	struct cpufreq_policy *policy =3D target->policy;
+	int cpu =3D policy->cpu;
 	struct clk *cpuclk =3D &per_cpu(sh_cpuclk, cpu);
-	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 	struct device *dev;
 	long freq;
=20
-	cpus_allowed =3D current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
-	BUG_ON(smp_processor_id() !=3D cpu);
+	if (smp_processor_id() !=3D cpu)
+		return -ENODEV;
=20
 	dev =3D get_cpu_device(cpu);
=20
 	/* Convert target_freq from kHz to Hz */
-	freq =3D clk_round_rate(cpuclk, target_freq * 1000);
+	freq =3D clk_round_rate(cpuclk, target->freq * 1000);
=20
 	if (freq < (policy->min * 1000) || freq > (policy->max * 1000))
 		return -EINVAL;
=20
-	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
+	dev_dbg(dev, "requested frequency %u Hz\n", target->freq * 1000);
=20
 	freqs.old	=3D sh_cpufreq_get(cpu);
 	freqs.new	=3D (freq + 500) / 1000;
 	freqs.flags	=3D 0;
=20
-	cpufreq_freq_transition_begin(policy, &freqs);
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+	cpufreq_freq_transition_begin(target->policy, &freqs);
 	clk_set_rate(cpuclk, freq);
-	cpufreq_freq_transition_end(policy, &freqs, 0);
+	cpufreq_freq_transition_end(target->policy, &freqs, 0);
=20
 	dev_dbg(dev, "set frequency %lu Hz\n", freq);
-
 	return 0;
 }
=20
+/*
+ * Here we notify other drivers of the proposed change and the final chang=
e.
+ */
+static int sh_cpufreq_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_target data =3D { .policy =3D policy, .freq =3D target_fre=
q };
+
+	return work_on_cpu(policy->cpu, __sh_cpufreq_target, &data);
+}
+
 static int sh_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
--=20
2.14.1
