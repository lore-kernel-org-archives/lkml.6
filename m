Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487780-2-767172059250768801
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
    t=1520487779; b=VMrjqzlDHHm6BgiCnKWGy4TXNrqyElmb0C22OSP/2o00dKO
    5bHcUa0+JTwfEsVyBQc/tnZALmGI5UDjHAzU72fhdt7juWBTsIFA0ayjQcsgH3IC
    He24ko4yKn2tsiX5U5LPzQWZH0B2a6B+x5zinI7zL9BahHXnNUomF3ojj5erjl00
    kh3o2QqMM7YddVu21KAXXUhjNkyv4MmlrUWrzmitllsL95TByt0fE8VF7GXWDLET
    eoBVGVj5vNtXV/gV/Z8L1ztwDzJSprHWMTzwXYqEL8LpUrIs1hz0+onYOszBTbZ2
    SYXDrN8uYIM9r2RYOwyQtpmSEgCOaqQNalTDzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487779; bh=K1AFXK
    S/Lg8WeVDplcZ4v00PzpoCrLIe0WiWrHVepsA=; b=lEiIsG7GKyqADgPlpuU4uY
    tiQq9r7taOSV0hhmFDlvUV6BHpgf/8/1mxf4nvyHDPppxndATL4BjgPe7Alh95F/
    XJm+HC8KwyMrTPaprpDBG1HlxjYkRGGCgtKtah3KNXj01E8TqNBNVCCFzO6JNfOU
    FhFCVofGnvaZEyBiMD8dIMn8zocyrNS+EF5nMazxvR8v5TnUC8fx+DXgarUxSvoN
    S3ktnvYHoKybsnLCDm/+o1Gmw43F4F88EU5YP3o2sPQXZTPsyMtNKwJG6JpqivCA
    I/tBj3XDuWOciq10/pdVuzXT1CstJxY4n2JK5zJTSZheqB2NoOBYBWUFqXocTt8w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FIhwyEuK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FIhwyEuK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966251AbeCHFm5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:42:57 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966209AbeCHFFU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:20 -0500
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
Subject: [PATCH AUTOSEL for 4.4 019/101] cpufreq/sh: Replace racy task
 affinity logic
Thread-Topic: [PATCH AUTOSEL for 4.4 019/101] cpufreq/sh: Replace racy task
 affinity logic
Thread-Index: AQHTtpqGR6jRzC4yR0CgSdZpHReReg==
Date: Thu, 8 Mar 2018 05:01:31 +0000
Message-ID: <20180308050023.8548-19-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:If9H5gUjwuUkqbDq6MCLbbN5l4aYQX8A0R8xpvTZz1lpRC6tChduyOXbtF30ZfmVcVqri735WcE++NAxhn4joumeGVnqOHtEMfKqzKr87UjIMjMDBwWmnRBkICplqslupeUMkkGfn1eCvi2h1g86NKMuV43JJRYBNqzhcHTwD7A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac22962a-1786-4039-7d6b-08d584b22c3c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727275FBA9340C7E80FCE74FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: sznRYLyyjt4GswHZB34Krsmn1vLuMlOfL5rH/FQhjDqRYj3+McOBNeMgqE2kusixeOfENp2lCesuwmXBBBr08d/LmCtXC90mZkLAZ1zYVvOUEoZmfa50onx25cN9SyJgSpVA/3XojF2BoaVowqrpZphaq9Jak5Uou6TonibbGFCCdVHJXu2TVWja8e45YB0WLKflpnHwCTB5TUmrGlOgEKNVIh7SHVSRa9SaA7VeXOSI2/TOFL9KFzP8ZUkfGfoW/Tc6Noo6+zCvhTlwBIkNKJ0j+SR33DuclZrWCtSA+Znm5l10B6dHpsWs0WhuIdgZLSvfzfcdcPzo9ZTT49SNHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac22962a-1786-4039-7d6b-08d584b22c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:31.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
