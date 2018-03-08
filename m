Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490335-2-88710618448859369
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
    t=1520490333; b=NSchZzWxio/Z4xwW8VOkvze8WhWAVpUutY72Qq9x3lSnghc
    SHCsjSm96HUqNpXVJ9BNMP/EGDkqyasaHopDwd27ZbzZWO8Th1Tcp304B7Shf92M
    jkzxVyWc44KBlqLfS3rb69eZWEW0HdjJvtbhjnIuKiNRgNMAO5S24xEYw37kV0pX
    cITJiWf2IOnx5sDLpsanPhObKuxb98z7djk4ro5+fm7x0fHY1I69qTKGAe6WO7Yy
    R7kUoxN3epp/bVTtgEapWTDjPHZ85QkM+toQVGW/bZc08FiOHYNnY7EhCiiCNCeB
    7pzT53VOdaf2cHVsUdmR0YufQBYoJre1V7Tee6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490333; bh=ew9xrg
    CgrXcg21Irf1RONB7FpPozvFe1M00Fx4YnFcE=; b=emPO6HzuYPDsFEF+3Wxs8a
    mfdYzgCoRUE6AvdhGVojZt07EPjAArEKQpQVrux68B+t4kEHQ1KtiEpU6yY9Cmvh
    WuTs8NT22T8wT30ZUFx17lTKea+Hz2XmQlqsn040He3K95CT2ZhbuofXDW/Cukj6
    zAsgQst967mXYP7FLALNUhfePKrSKaWwZ/2p2ReO9clA7Oev4KlyzV6MVQjW7Uhu
    QND3+sUS7qG7mOxJmwPK1t8u46BVobrDid9VSiu99k+69/SUgQF7dsU3y9F4dMff
    wrV9OsDDpaqofK/lzTVP2M0MN2jrGDimndP++iTa1HAKK8V/beN1tYPdkmgYk+9w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqxnafEn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RqxnafEn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755328AbeCHFAo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:44 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935387AbeCHFAl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:41 -0500
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
Subject: [PATCH AUTOSEL for 4.9 034/190] ACPI/processor: Replace racy task
 affinity logic
Thread-Topic: [PATCH AUTOSEL for 4.9 034/190] ACPI/processor: Replace racy
 task affinity logic
Thread-Index: AQHTtpovldyZSqaI4E24B1e8IL8KQg==
Date: Thu, 8 Mar 2018 04:59:06 +0000
Message-ID: <20180308045810.8041-34-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:qJzlYy+6SYmCKjWPH6gVNC1f57vXqckAw5e2KfQZEIMo34uEeW2fbM+TeDOCozhhiG93zl+n3Duw/1qO4QR0uzgBTkNQMNZMc2PlIk3xEfEjFDukCgqoS0WzkbbQqgiO4Ey4IJFHRolzaeygodm5xzPp4SB6CoZPMtLYZcTOMms=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47627624-5496-4198-075b-08d584b1885d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111224F96852370E0AE0D5CDFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(9452136761055)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(39060400002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(7416002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: XJE+dkSN+KR2IAkhYCqfVIU82gEDI7iCItntwRzD5hU7c9iMI3HFDmvovB9Zw05EI8oi6n08xX92HAK+I9pMGmaonOXKPHaFIEbaf+z1mHOF5UDLARoR3VZ20bbzbmdC6fS6Go614kY01zKdqft7PlE1CSfgYrB75DEEgWaqbwBZZ8RfMaFDujmvkmJxl8vdSXxU11TPeD+YW81mC6eLrgOWz0EzFqNp2hvC3na72AlobWIgt26vf5PKRGZGyTZSSZmhUjyHgn6ffDdjF+lWQyPdhoV4ML/4qHb3jlU1zmUBWDrzoIurqtc7hnfmVUVeripC9ySCJ88MkCf6f3x8fw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47627624-5496-4198-075b-08d584b1885d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:06.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index eab8cdad7dc3..8697a82bd465 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -262,11 +262,16 @@ static int __acpi_processor_start(struct acpi_device =
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
index d51ca1c05619..207e9bbb9490 100644
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
