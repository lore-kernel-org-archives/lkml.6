Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE79F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfBEKwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:52:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbfBEKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:52:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15AoiwV031242
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 05:52:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qf8svrw37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 05:52:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 5 Feb 2019 10:52:12 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 10:52:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15Aq8bE58916954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 10:52:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6D39A405C;
        Tue,  5 Feb 2019 10:52:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5F30A405B;
        Tue,  5 Feb 2019 10:52:07 +0000 (GMT)
Received: from bostonp9.aus.stglabs.ibm.com (unknown [9.3.23.179])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 10:52:07 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     akshay.adiga@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] tools/power/cpupower: Display boost frequency separately
Date:   Tue,  5 Feb 2019 04:51:28 -0600
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19020510-4275-0000-0000-0000030B4111
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020510-4276-0000-0000-000038194262
Message-Id: <20190205105128.9484-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq driver creates sysfs file "scaling_boost_frequency" for platforms
which support boost frequency. Cpupower now prints boost frequencies
separately. For few x86 vendors who already have different way to get boost
frequency, will continue to use the existing logic. Rest of the platforms
will rely on "scaling_boost_frequency" file to display boost frequency.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/lib/cpufreq.c        | 19 +++++-----
 tools/power/cpupower/lib/cpufreq.h        | 16 ++++-----
 tools/power/cpupower/utils/cpufreq-info.c | 42 +++++++++++++++++------
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 0c0f3e3f0..80650497f 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -333,17 +333,20 @@ void cpufreq_put_available_governors(struct cpufreq_available_governors *any)
 }
 
 
-struct cpufreq_available_frequencies
-*cpufreq_get_available_frequencies(unsigned int cpu)
+struct cpufreq_frequencies
+*cpufreq_get_frequencies(const char *type, unsigned int cpu)
 {
-	struct cpufreq_available_frequencies *first = NULL;
-	struct cpufreq_available_frequencies *current = NULL;
+	struct cpufreq_frequencies *first = NULL;
+	struct cpufreq_frequencies *current = NULL;
 	char one_value[SYSFS_PATH_MAX];
 	char linebuf[MAX_LINE_LEN];
+	char fname[MAX_LINE_LEN];
 	unsigned int pos, i;
 	unsigned int len;
 
-	len = sysfs_cpufreq_read_file(cpu, "scaling_available_frequencies",
+	snprintf(fname, MAX_LINE_LEN, "scaling_%s_frequencies", type);
+
+	len = sysfs_cpufreq_read_file(cpu, fname,
 				linebuf, sizeof(linebuf));
 	if (len == 0)
 		return NULL;
@@ -389,9 +392,9 @@ struct cpufreq_available_frequencies
 	return NULL;
 }
 
-void cpufreq_put_available_frequencies(struct cpufreq_available_frequencies
-				*any) {
-	struct cpufreq_available_frequencies *tmp, *next;
+void cpufreq_put_frequencies(struct cpufreq_frequencies *any)
+{
+	struct cpufreq_frequencies *tmp, *next;
 
 	if (!any)
 		return;
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 60beaf5ed..775738269 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -28,10 +28,10 @@ struct cpufreq_available_governors {
 	struct cpufreq_available_governors *first;
 };
 
-struct cpufreq_available_frequencies {
+struct cpufreq_frequencies {
 	unsigned long frequency;
-	struct cpufreq_available_frequencies *next;
-	struct cpufreq_available_frequencies *first;
+	struct cpufreq_frequencies *next;
+	struct cpufreq_frequencies *first;
 };
 
 
@@ -129,14 +129,14 @@ void cpufreq_put_available_governors(
  *
  * Only present on _some_ ->target() cpufreq drivers. For information purposes
  * only. Please free allocated memory by calling
- * cpufreq_put_available_frequencies after use.
+ * cpufreq_put_frequencies after use.
  */
 
-struct cpufreq_available_frequencies
-*cpufreq_get_available_frequencies(unsigned int cpu);
+struct cpufreq_frequencies
+*cpufreq_get_frequencies(const char *type, unsigned int cpu);
 
-void cpufreq_put_available_frequencies(
-		struct cpufreq_available_frequencies *first);
+void cpufreq_put_frequencies(
+		struct cpufreq_frequencies *first);
 
 
 /* determine affected CPUs
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index c3f39d512..10290b308 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -161,19 +161,12 @@ static void print_duration(unsigned long duration)
 	return;
 }
 
-/* --boost / -b */
-
-static int get_boost_mode(unsigned int cpu)
+static int get_boost_mode_x86(unsigned int cpu)
 {
 	int support, active, b_states = 0, ret, pstate_no, i;
 	/* ToDo: Make this more global */
 	unsigned long pstates[MAX_HW_PSTATES] = {0,};
 
-	if (cpupower_cpu_info.vendor != X86_VENDOR_AMD &&
-	    cpupower_cpu_info.vendor != X86_VENDOR_HYGON &&
-	    cpupower_cpu_info.vendor != X86_VENDOR_INTEL)
-		return 0;
-
 	ret = cpufreq_has_boost_support(cpu, &support, &active, &b_states);
 	if (ret) {
 		printf(_("Error while evaluating Boost Capabilities"
@@ -248,6 +241,33 @@ static int get_boost_mode(unsigned int cpu)
 	return 0;
 }
 
+/* --boost / -b */
+
+static int get_boost_mode(unsigned int cpu)
+{
+	struct cpufreq_frequencies *freqs;
+
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_INTEL)
+		return get_boost_mode_x86(cpu);
+
+	freqs = cpufreq_get_frequencies("boost", cpu);
+	if (freqs) {
+		printf(_("  boost frequency steps: "));
+		while (freqs->next) {
+			print_speed(freqs->frequency);
+			printf(", ");
+			freqs = freqs->next;
+		}
+		print_speed(freqs->frequency);
+		printf("\n");
+		cpufreq_put_frequencies(freqs);
+	}
+
+	return 0;
+}
+
 /* --freq / -f */
 
 static int get_freq_kernel(unsigned int cpu, unsigned int human)
@@ -456,7 +476,7 @@ static int get_latency(unsigned int cpu, unsigned int human)
 
 static void debug_output_one(unsigned int cpu)
 {
-	struct cpufreq_available_frequencies *freqs;
+	struct cpufreq_frequencies *freqs;
 
 	get_driver(cpu);
 	get_related_cpus(cpu);
@@ -464,7 +484,7 @@ static void debug_output_one(unsigned int cpu)
 	get_latency(cpu, 1);
 	get_hardware_limits(cpu, 1);
 
-	freqs = cpufreq_get_available_frequencies(cpu);
+	freqs = cpufreq_get_frequencies("available", cpu);
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
@@ -474,7 +494,7 @@ static void debug_output_one(unsigned int cpu)
 		}
 		print_speed(freqs->frequency);
 		printf("\n");
-		cpufreq_put_available_frequencies(freqs);
+		cpufreq_put_frequencies(freqs);
 	}
 
 	get_available_governors(cpu);
-- 
2.17.1

