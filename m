Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487738-2-7084446426127716256
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
    t=1520487737; b=iYU+iQHmaF5XOSdsY3FAAhnM6n5RWD2EW1xJf4QssofKSOo
    67W0m+In6XR+u4TMZiqoEnNuLuFwVRuobAIRt/UpVz8bmSJthpmoDjXXQVVOPRNS
    0mumY3wFOItFzARtaiq7YclbMQK+uhasrU75lgiELjHJNVlswBq3WpD/oec28RuX
    PzOhbWzSWC3En7OEIF9Aipk1in+Ks33rvQw+GS/QqIylDPMRNSUL/vkRLIwpKcLl
    gZB/ChzJeSqcvPW/CzO4INYz792XiGtNGVzn3ThGBDHSUAFJv8xKm3Pyykw1CTWf
    g75F1pZC1th+145hEOOZKSWkrmCsBmugrk7u9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487737; bh=5ZfGTN
    KfChGKG6NPhznu9J54k+0eE0qlstMwC/pVFKo=; b=ujQ8a9c8lrWjalhExzjehs
    6O+ib0muey/4VrZV8PLGpbUvgyInJFzxBDeJtC/vyXx6lPpmJyeokF3ECIdp0oSL
    djx6zxpaM3QS6e9vKPVx59xIT8ufl40OoxxGTdbtQKeG9sJFxs3DN6MxpvcEP7dG
    2IJmcX2zQCTXXd0uUaXbDk7GLFEXSVIqSsH7Cujw9RTQ2iuln2Anaj2N5TdPDooo
    svSaoRbsKj6f7a0JaiefAD3wwMfpXvrY/djljCu0kE8Mbcz5HHl3/zhtQHTjz8n3
    /P6Ja9e9e8icnQ6DYh+LD86kLt9K5MHqpelD3DFbAjr4tlFItkITagEjtOeJCWPQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWmkeKM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWmkeKM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966173AbeCHFlD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:41:03 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:58876
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966222AbeCHFFX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:23 -0500
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
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 018/101] ACPI/processor: Replace racy task
 affinity logic
Thread-Topic: [PATCH AUTOSEL for 4.4 018/101] ACPI/processor: Replace racy
 task affinity logic
Thread-Index: AQHTtpqF5z/W/jQcmEW3tw/nA3KKUQ==
Date: Thu, 8 Mar 2018 05:01:31 +0000
Message-ID: <20180308050023.8548-18-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:V+nKQY1quS6MJuviq6/JGw6cwctEXZLN/Qx5OvB2GjwBAsOIvpDWehzAotPScTBXf041DPNAT93SyEpDIjY59DH9uPdxgPjknXq5aMhJJY3/f3q5bRlxxMAnmarzB8K7jhLVApbZWops/RFBRA6BshtILM4hn+2GydatNml/AVk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a430c2e-9921-4c91-fa93-08d584b22be6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07276317A39D920B4D2ADE2EFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(9452136761055)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: eUSAJ+HhSYcg00hcJhYEQKOYrZ8pdqhA7N+chUtUkGvRlDLT/qgoY9g5WSP7CErO/Spo9kS1E0XGT2+8yHAFUHnAskSLQaR9prHnwnPUrGpaSXJj33/xHXcH0JtbfzNf42+2552/fEwZZQ6InJ726sXdZozPl46EXJxhEQdfBpZ5RjeOumLQIUCm9rnYvWXmUPmF8JwPP4HX0nSV11UtF7MWenNSvzUsWGK/SF1mNVDIDJCf6diJXhW59SdbAB/i4VQT440gY17zRCj0DD8t2+dxYveyPmdiNbDZ6uuR6VIVwLd2IsiUoQJzz9POQmJWgFrSvVl7pqnV8jORLFfwgA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a430c2e-9921-4c91-fa93-08d584b22be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:31.1599
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

[ Upstream commit 8153f9ac43897f9f4786b30badc134fcc1a4fb11 ]

acpi_processor_get_throttling() requires to invoke the getter function on
the target CPU. This is achieved by temporarily setting the affinity of the
calling user space thread to the requested CPU and reset it to the original
affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

acpi_processor_get_throttling() is invoked in two ways:

1) The CPU online callback, which is already running on the target CPU and
   obviously protected against hotplug and not affected by affinity
   settings.

2) The ACPI driver probe function, which is not protected against hotplug
   during modprobe.

Switch it over to work_on_cpu() and protect the probe function against CPU
hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.785920903@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/processor_driver.c     |  7 ++++-
 drivers/acpi/processor_throttling.c | 62 +++++++++++++++++++++------------=
----
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index 2c086859a0bd..c9bf74982688 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -270,11 +270,16 @@ static int __acpi_processor_start(struct acpi_device =
*device)
 static int acpi_processor_start(struct device *dev)
 {
 	struct acpi_device *device =3D ACPI_COMPANION(dev);
+	int ret;
=20
 	if (!device)
 		return -ENODEV;
=20
-	return __acpi_processor_start(device);
+	/* Protect against concurrent CPU hotplug operations */
+	get_online_cpus();
+	ret =3D __acpi_processor_start(device);
+	put_online_cpus();
+	return ret;
 }
=20
 static int acpi_processor_stop(struct device *dev)
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_t=
hrottling.c
index c72e64893d03..93d72413d844 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -62,8 +62,8 @@ struct acpi_processor_throttling_arg {
 #define THROTTLING_POSTCHANGE      (2)
=20
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force);
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct);
=20
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -891,7 +891,8 @@ static int acpi_processor_get_throttling_ptc(struct acp=
i_processor *pr)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"Invalid throttling state, reset\n"));
 			state =3D 0;
-			ret =3D acpi_processor_set_throttling(pr, state, true);
+			ret =3D __acpi_processor_set_throttling(pr, state, true,
+							      true);
 			if (ret)
 				return ret;
 		}
@@ -901,36 +902,31 @@ static int acpi_processor_get_throttling_ptc(struct a=
cpi_processor *pr)
 	return 0;
 }
=20
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static long __acpi_processor_get_throttling(void *data)
 {
-	cpumask_var_t saved_mask;
-	int ret;
+	struct acpi_processor *pr =3D data;
+
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
=20
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
 	if (!pr)
 		return -EINVAL;
=20
 	if (!pr->flags.throttling)
 		return -ENODEV;
=20
-	if (!alloc_cpumask_var(&saved_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	/*
-	 * Migrate task to the cpu pointed by pr.
+	 * This is either called from the CPU hotplug callback of
+	 * processor_driver or via the ACPI probe function. In the latter
+	 * case the CPU is not guaranteed to be online. Both call sites are
+	 * protected against CPU hotplug.
 	 */
-	cpumask_copy(saved_mask, &current->cpus_allowed);
-	/* FIXME: use work_on_cpu() */
-	if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
-		/* Can't migrate to the target pr->id CPU. Exit */
-		free_cpumask_var(saved_mask);
+	if (!cpu_online(pr->id))
 		return -ENODEV;
-	}
-	ret =3D pr->throttling.acpi_processor_get_throttling(pr);
-	/* restore the previous state */
-	set_cpus_allowed_ptr(current, saved_mask);
-	free_cpumask_var(saved_mask);
=20
-	return ret;
+	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
 }
=20
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
@@ -1080,8 +1076,15 @@ static long acpi_processor_throttling_fn(void *data)
 			arg->target_state, arg->force);
 }
=20
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force)
+static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct=
)
+{
+	if (direct)
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct)
 {
 	int ret =3D 0;
 	unsigned int i;
@@ -1130,7 +1133,8 @@ int acpi_processor_set_throttling(struct acpi_process=
or *pr,
 		arg.pr =3D pr;
 		arg.target_state =3D state;
 		arg.force =3D force;
-		ret =3D work_on_cpu(pr->id, acpi_processor_throttling_fn, &arg);
+		ret =3D call_on_cpu(pr->id, acpi_processor_throttling_fn, &arg,
+				  direct);
 	} else {
 		/*
 		 * When the T-state coordination is SW_ALL or HW_ALL,
@@ -1163,8 +1167,8 @@ int acpi_processor_set_throttling(struct acpi_process=
or *pr,
 			arg.pr =3D match_pr;
 			arg.target_state =3D state;
 			arg.force =3D force;
-			ret =3D work_on_cpu(pr->id, acpi_processor_throttling_fn,
-				&arg);
+			ret =3D call_on_cpu(pr->id, acpi_processor_throttling_fn,
+					  &arg, direct);
 		}
 	}
 	/*
@@ -1182,6 +1186,12 @@ int acpi_processor_set_throttling(struct acpi_proces=
sor *pr,
 	return ret;
 }
=20
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state,
+				  bool force)
+{
+	return __acpi_processor_set_throttling(pr, state, force, false);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result =3D 0;
--=20
2.14.1
