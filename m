Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163165-2-11870342716461496475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163164; b=FRL0YLK4eXyQMyqCfdBnLqwQyxpRAc20yFknytqlbkwE1+LSOv
    4+R8U4hZgLANlCSYdP6h0FPNpy/DbgUgYl+ZVp5aLYQqkWee1kZs1eJXookr79hO
    w2oNKvZm7/nFitGUrGsrjznpqiSJY3W/VpHQ3lHkr+92YRBbo+LsinCGG0EHfKTW
    MvJ3C/IrsrjQGIvyma/FVPDDn3hf5pMSfHEwpGoWAsX11F+9r0dL6O3Y9XxZhOTn
    QC8lMpfUH73AkEBgovGv3CLblrdpoLJXw9bz6kEB8ukUVqFK0rej4xxLYRTSDoxV
    v+akcxltU3dTuJMqWe3OXaPKWQBJOXSDfW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163164; bh=iCLJbn+Rfzdi6uauvMEG6g19w5n9kv
    jyv1dAt/ynJTY=; b=F9nZXEQ0E6XP+TefjgmhHHu+JOTHhJgQJq04Up38iJW4us
    /ESfwE7UHGCN5Ti/kIFmGFwh50nZAw9E04wjnuARefm4r92h+mVque27tUwrXsek
    ayqeo5XL1Iy5HWne4VAN97981vriN4R65NDLoetEUrscnaodYOIymzwC5mvFMkda
    SOJuP43THnUDtsARukDhz4/y0cxbS1vQCy9naV/l6Nj+DAScNnNWktscy7Klffkd
    LmbI1T81Cf0LZQEnAFB3F/7B3EBMghClGU9BRxW3C7TLNZtd+2iGMD2BrBOz6+Ay
    ehKx2UR6hD9xIVscLVWDOpeLu0NPUyoAzbuELJzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=bVgTISF7 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=bVgTISF7 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWJgRWUkgWq3f7kRbmNdkA2Cjcdk8FowpukTfX2whgz0qzPqqdpYwf3zErpUTDveLDSDfNSa7U9hskBwwilGHokEFEIjg1l7n7C9vV/4UOlkIsQp+t6
    qqEBH34Laqjf16B6wPqSb0N+ItQJN9t3TEIdrLzSg67Ad8e7S+FfRofRRVBhixaxVqSFE3YvSn92XbrVSWocoNOlJnX8mz2tCU+L9J4Q1xjkuXorWQc3AjiZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=yRZDeIql1kMTNggG5_0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966499AbeEXL6y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966766AbeEXJpS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Galbraith <mgalbraith@suse.de>
Subject: [PATCH 4.4 44/92] powerpc/powernv: remove FW_FEATURE_OPALv3 and just use FW_FEATURE_OPAL
Date: Thu, 24 May 2018 11:38:21 +0200
Message-Id: <20180524093203.531882789@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stewart Smith <stewart@linux.vnet.ibm.com>

commit e4d54f71d29997344b4c4c8d47708240f9f23a5c upstream.

Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
be cared about or supported by mainline kernels.

So, let's remove FW_FEATURE_OPALv3 and instead use FW_FEATURE_OPAL
exclusively.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/firmware.h          |    3 -
 arch/powerpc/platforms/powernv/eeh-powernv.c |    4 -
 arch/powerpc/platforms/powernv/idle.c        |    2 
 arch/powerpc/platforms/powernv/opal-xscom.c  |    2 
 arch/powerpc/platforms/powernv/opal.c        |   25 ++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c    |    2 
 arch/powerpc/platforms/powernv/setup.c       |    8 +-
 arch/powerpc/platforms/powernv/smp.c         |   74 +++++++++++----------------
 drivers/cpufreq/powernv-cpufreq.c            |    2 
 drivers/cpuidle/cpuidle-powernv.c            |    2 
 10 files changed, 54 insertions(+), 70 deletions(-)

--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,7 +51,6 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
-#define FW_FEATURE_OPALv3	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +68,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv3,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -48,8 +48,8 @@ static int pnv_eeh_init(void)
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
-		pr_warn("%s: OPALv3 is required !\n",
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
+		pr_warn("%s: OPAL is required !\n",
 			__func__);
 		return -EINVAL;
 	}
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -242,7 +242,7 @@ static int __init pnv_init_idle_states(v
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		goto out;
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		goto out;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -126,7 +126,7 @@ static const struct scom_controller opal
 
 static int opal_xscom_init(void)
 {
-	if (firmware_has_feature(FW_FEATURE_OPALv3))
+	if (firmware_has_feature(FW_FEATURE_OPAL))
 		scom_init(&opal_scom_controller);
 	return 0;
 }
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -98,10 +98,9 @@ int __init early_init_dt_scan_opal(unsig
 	pr_debug("OPAL Entry = 0x%llx (sizep=%p runtimesz=%d)\n",
 		 opal.size, sizep, runtimesz);
 
-	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv3;
-		pr_info("OPAL V3 detected !\n");
+		powerpc_firmware_features |= FW_FEATURE_OPAL;
+		pr_info("OPAL detected !\n");
 	} else {
 		panic("OPAL != V3 detected, no longer supported.\n");
 	}
@@ -348,17 +347,15 @@ int opal_put_chars(uint32_t vtermno, con
 	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
-		rc = opal_console_write_buffer_space(vtermno, &olen);
-		len = be64_to_cpu(olen);
-		if (rc || len < total_len) {
-			spin_unlock_irqrestore(&opal_write_lock, flags);
-			/* Closed -> drop characters */
-			if (rc)
-				return total_len;
-			opal_poll_events(NULL);
-			return -EAGAIN;
-		}
+	rc = opal_console_write_buffer_space(vtermno, &olen);
+	len = be64_to_cpu(olen);
+	if (rc || len < total_len) {
+		spin_unlock_irqrestore(&opal_write_lock, flags);
+		/* Closed -> drop characters */
+		if (rc)
+			return total_len;
+		opal_poll_events(NULL);
+		return -EAGAIN;
 	}
 
 	/* We still try to handle partial completions, though they
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -344,7 +344,7 @@ static void __init pnv_ioda_parse_m64_wi
 		return;
 	}
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
 		pr_info("  Firmware too old to support M64 window\n");
 		return;
 	}
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -140,8 +140,8 @@ static void pnv_show_cpuinfo(struct seq_
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
-	if (firmware_has_feature(FW_FEATURE_OPALv3))
-		seq_printf(m, "firmware\t: OPAL v3\n");
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		seq_printf(m, "firmware\t: OPAL\n");
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
@@ -270,9 +270,9 @@ static void pnv_kexec_cpu_down(int crash
 {
 	xics_kexec_teardown_cpu(secondary);
 
-	/* On OPAL v3, we return all CPUs to firmware */
+	/* On OPAL, we return all CPUs to firmware */
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
 
 	if (secondary) {
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -61,14 +61,15 @@ static int pnv_smp_kick_cpu(int nr)
 	unsigned long start_here =
 			__pa(ppc_function_entry(generic_secondary_smp_init));
 	long rc;
+	uint8_t status;
 
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/*
-	 * If we already started or OPALv3 is not supported, we just
+	 * If we already started or OPAL is not supported, we just
 	 * kick the CPU via the PACA
 	 */
-	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv3))
+	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPAL))
 		goto kick;
 
 	/*
@@ -77,55 +78,42 @@ static int pnv_smp_kick_cpu(int nr)
 	 * first time. OPAL v3 allows us to query OPAL to know if it
 	 * has the CPUs, so we do that
 	 */
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
-		uint8_t status;
-
-		rc = opal_query_cpu_status(pcpu, &status);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("OPAL Error %ld querying CPU %d state\n",
-				rc, nr);
-			return -ENODEV;
-		}
+	rc = opal_query_cpu_status(pcpu, &status);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("OPAL Error %ld querying CPU %d state\n", rc, nr);
+		return -ENODEV;
+	}
 
-		/*
-		 * Already started, just kick it, probably coming from
-		 * kexec and spinning
-		 */
-		if (status == OPAL_THREAD_STARTED)
-			goto kick;
+	/*
+	 * Already started, just kick it, probably coming from
+	 * kexec and spinning
+	 */
+	if (status == OPAL_THREAD_STARTED)
+		goto kick;
 
-		/*
-		 * Available/inactive, let's kick it
-		 */
-		if (status == OPAL_THREAD_INACTIVE) {
-			pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n",
-				 nr, pcpu);
-			rc = opal_start_cpu(pcpu, start_here);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("OPAL Error %ld starting CPU %d\n",
-					rc, nr);
-				return -ENODEV;
-			}
-		} else {
-			/*
-			 * An unavailable CPU (or any other unknown status)
-			 * shouldn't be started. It should also
-			 * not be in the possible map but currently it can
-			 * happen
-			 */
-			pr_devel("OPAL: CPU %d (HW 0x%x) is unavailable"
-				 " (status %d)...\n", nr, pcpu, status);
+	/*
+	 * Available/inactive, let's kick it
+	 */
+	if (status == OPAL_THREAD_INACTIVE) {
+		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
+		rc = opal_start_cpu(pcpu, start_here);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("OPAL Error %ld starting CPU %d\n", rc, nr);
 			return -ENODEV;
 		}
 	} else {
 		/*
-		 * On OPAL v2, we just kick it and hope for the best,
-		 * we must not test the error from opal_start_cpu() or
-		 * we would fail to get CPUs from kexec.
+		 * An unavailable CPU (or any other unknown status)
+		 * shouldn't be started. It should also
+		 * not be in the possible map but currently it can
+		 * happen
 		 */
-		opal_start_cpu(pcpu, start_here);
+		pr_devel("OPAL: CPU %d (HW 0x%x) is unavailable"
+			 " (status %d)...\n", nr, pcpu, status);
+		return -ENODEV;
 	}
- kick:
+
+kick:
 	return smp_generic_kick_cpu(nr);
 }
 
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -592,7 +592,7 @@ static int __init powernv_cpufreq_init(v
 	int rc = 0;
 
 	/* Don't probe on pseries (guest) platforms */
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return -ENODEV;
 
 	/* Discover pstates from device tree and init */
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -282,7 +282,7 @@ static int powernv_idle_probe(void)
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
+	if (firmware_has_feature(FW_FEATURE_OPAL)) {
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
