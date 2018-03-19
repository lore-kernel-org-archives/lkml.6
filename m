Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498722-2-10352761628027475723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498721; b=UQC0tKUilDLTj9Xf2lyDYvE0NBFMlHyIgtNCeDDDPEwlS2s
    F/e6S29Npqrg1C66OVE4he8ctbhNfuL0asMixtucI4D89wrsJ4qGz11T7iumTGVR
    benX/D89SHggs+mPj+o53tyQdTYcGFgDjZ9AbUmaATZcJ1MxTiGfBFWmiTnYqycA
    H/z5iGneEK7mT+dlNcVbItKWVtQ58S3TfRQfIJ+i+7GTxvLRmLJgCyD73aVdbjtS
    vL5bdb6WqhVxSFtB311wlgDmfkS/kL2FhXYvgs54G4M5dq7Zb9L+HVe4ouv8IkTZ
    uqr9vQ7ZQwpaktMOKZ+B1YERvHN4E0ykVhE2ZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498721; bh=W0g5gj
    4qT/b0EiHr0dHOJWey/GzCRM8CLgvPO//D5Is=; b=CogPraujTc3t4jfQE37IaK
    yfp7OUzl97SqJ5zpGuyYLL5Nl5fcrXpXp/TXqLRjbOc1TGYisbEJ37FJvnXo6mTj
    QazCXemEW2SjmZLiJJUBZKT7k8qHB9Cqrji8KW22LY79DlXZpDT1z1K+dRaMFtXp
    SUII+stssACrvZGqzPrqHs2CU1SkDuqXmPJ4ICjU/Iqekxwc/+9ExI6TGfYnfzDy
    XxSdBUJaQbAuotn6t8g2yQce3SnlY9ctDZrXUfEzsSCdq6eY8FKoJ7YX6JLaWjJb
    wzlRsEJ1x1eohy++1lZbiGbKKLh2uOoTrEn1sWutosTdzA3NLRQtEmI6CJcVTo5Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1KP59ZD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddvleeinecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1KP59ZD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddvleeinecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936485AbeCSW3y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:29:54 -0400
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:31072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933786AbeCSPsj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 054/124] powernv-cpufreq: Add helper to
 extract pstate from PMSR
Thread-Topic: [PATCH AUTOSEL for 4.15 054/124] powernv-cpufreq: Add helper to
 extract pstate from PMSR
Thread-Index: AQHTv5mmGLMNdDLnx0ermQ1jpMkntg==
Date: Mon, 19 Mar 2018 15:47:56 +0000
Message-ID: <20180319154645.11350-54-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:pdn3Onbj/lfYupWh4Kxe1tUQYX0rMKJsf/0qSnnOufv6MCiJatk2ifBcmRMLkF7r4OsMIRjtOg0PlxRrY9Cen7fRlupeJTo9f47KLvN1Sd9mylEqz+rkuOirA2FcCYwL3n28UeZ7r3RmnZKKSY45ooyeHW/waA8gzk0RSGmhJqvlWtBaLRgmZ7cjWrpivNlHuP6Vvb8dHRcRwyCrvN9jlNDIqvPU3gQJs4mO7aBQXHGTkfp5uxJr7as0R16czQ1U;20:CnKaNuQ/HvHEc3tV0W5m/Gm7mZQSQ5HJkgUiMh/8VlK/ZTfttLapI9lZTzJXIQakxB+7Az2nPaPAZJNl2AmMkWn5oE91QWK36ok+cNIxIxo+18LqTVkBBAoM8xdqlixIMQcOjdVXh/tK1WxZw0r3v5mNB7XaRYGMsovfYNyPT0s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2f380bb-049f-4b84-cca2-08d58db0d3cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031AB29AABA1D1F14B42C9DFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xAvwzAJEKPM5oa996nG02rrS4oLd3vGjAPBCIjrC67rzg6H/erFBXAiG/EmDqm9+wscvagy5+bqK56ijGBqZrmOHRaCIk86HW9lD7furxBGGc0cZrrQtZLlQyS+KeHTfrqDfHZPGutFJkeXsG2YF2gbdtwzOHQedOQpXmietP9llLf2VTQkGv/vf0Il2C4gUW5MyI5imFkwd/z6AgJ1BFup4sJS3uBj4FHhKbbSWlDQ0dK23wjyIoy+u6/Nfpke47tzqudPCoRzLGSfzCkZRRaGopeJoeQk/x3siiOe+9uzBOdVdlShGjlNz8Vpdptn1cESgRsK3CEiJ1IvdzaH9sg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f380bb-049f-4b84-cca2-08d58db0d3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:56.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

[ Upstream commit ee1f4a7dafa997816ff3de96155c6f3edc21c1e6 ]

On POWERNV platform, the fields for pstates in the Power Management
Status Register (PMSR) and the Power Management Control Register
(PMCR) are 8-bits wide. On POWER8 the pstates are negatively numbered
while on POWER9 they are positively numbered.

The device-tree exports pstates as 32-bit entries. The device-tree
implementation sign-extends the 8-bit pstate values to obtain the
corresponding 32-bit entry.

Eg: On POWER8, a pstate value 0x82 [-126] is represented in the
device-tree as 0xfffffff82 while on POWER9, the same value 0x82 [130]
is represented in the device-tree as 0x00000082.

The powernv-cpufreq driver implementation represents pstates using the
integer type. In multiple places in the driver, the code interprets
the pstates extracted from the PMSR as a signed byte and assigns it to
a integer variable to get the sign-extention.

On POWER9 platforms which have greater than 128 pstates, this results
in the driver performing incorrect sign-extention, and thereby
treating a legitimate pstate (say 130) as an invalid pstates (since it
is interpreted as -126).

This patch fixes the issue by implementing a helper function to
extract Pstates from PMSR register, and correctly sign-extend it to be
consistent with the values provided by the device-tree.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 37 +++++++++++++++++++++++------------=
--
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cp=
ufreq.c
index da7fdb4b661a..37381238bf69 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -41,11 +41,9 @@
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
-#define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define MAX_PSTATE_SHIFT	32
 #define LPSTATE_SHIFT		48
 #define GPSTATE_SHIFT		56
-#define GET_LPSTATE(x)		(((x) >> LPSTATE_SHIFT) & 0xFF)
-#define GET_GPSTATE(x)		(((x) >> GPSTATE_SHIFT) & 0xFF)
=20
 #define MAX_RAMP_DOWN_TIME				5120
 /*
@@ -94,6 +92,7 @@ struct global_pstate_info {
 };
=20
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1]=
;
+u32 pstate_sign_prefix;
 static bool rebooting, throttled, occ_reset;
=20
 static const char * const throttle_reason[] =3D {
@@ -148,6 +147,20 @@ static struct powernv_pstate_info {
 	bool wof_enabled;
 } powernv_pstate_info;
=20
+static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
+{
+	int ret =3D ((pmsr_val >> shift) & 0xFF);
+
+	if (!ret)
+		return ret;
+
+	return (pstate_sign_prefix | ret);
+}
+
+#define extract_local_pstate(x) extract_pstate(x, LPSTATE_SHIFT)
+#define extract_global_pstate(x) extract_pstate(x, GPSTATE_SHIFT)
+#define extract_max_pstate(x)  extract_pstate(x, MAX_PSTATE_SHIFT)
+
 /* Use following macros for conversions between pstate_id and index */
 static inline int idx_to_pstate(unsigned int i)
 {
@@ -278,6 +291,9 @@ static int init_powernv_pstates(void)
=20
 	powernv_pstate_info.nr_pstates =3D nr_pstates;
 	pr_debug("NR PStates %d\n", nr_pstates);
+
+	pstate_sign_prefix =3D pstate_min & ~0xFF;
+
 	for (i =3D 0; i < nr_pstates; i++) {
 		u32 id =3D be32_to_cpu(pstate_ids[i]);
 		u32 freq =3D be32_to_cpu(pstate_freqs[i]);
@@ -438,17 +454,10 @@ struct powernv_smp_call_data {
 static void powernv_read_cpu_freq(void *arg)
 {
 	unsigned long pmspr_val;
-	s8 local_pstate_id;
 	struct powernv_smp_call_data *freq_data =3D arg;
=20
 	pmspr_val =3D get_pmspr(SPRN_PMSR);
-
-	/*
-	 * The local pstate id corresponds bits 48..55 in the PMSR.
-	 * Note: Watch out for the sign!
-	 */
-	local_pstate_id =3D (pmspr_val >> 48) & 0xFF;
-	freq_data->pstate_id =3D local_pstate_id;
+	freq_data->pstate_id =3D extract_local_pstate(pmspr_val);
 	freq_data->freq =3D pstate_id_to_freq(freq_data->pstate_id);
=20
 	pr_debug("cpu %d pmsr %016lX pstate_id %d frequency %d kHz\n",
@@ -522,7 +531,7 @@ static void powernv_cpufreq_throttle_check(void *data)
 	chip =3D this_cpu_read(chip_info);
=20
 	/* Check for Pmax Capping */
-	pmsr_pmax =3D (s8)PMSR_MAX(pmsr);
+	pmsr_pmax =3D extract_max_pstate(pmsr);
 	pmsr_pmax_idx =3D pstate_to_idx(pmsr_pmax);
 	if (pmsr_pmax_idx !=3D powernv_pstate_info.max) {
 		if (chip->throttled)
@@ -645,8 +654,8 @@ void gpstate_timer_handler(struct timer_list *t)
 	 * value. Hence, read from PMCR to get correct data.
 	 */
 	val =3D get_pmspr(SPRN_PMCR);
-	freq_data.gpstate_id =3D (s8)GET_GPSTATE(val);
-	freq_data.pstate_id =3D (s8)GET_LPSTATE(val);
+	freq_data.gpstate_id =3D extract_global_pstate(val);
+	freq_data.pstate_id =3D extract_local_pstate(val);
 	if (freq_data.gpstate_id  =3D=3D freq_data.pstate_id) {
 		reset_gpstates(policy);
 		spin_unlock(&gpstates->gpstate_lock);
--=20
2.14.1
