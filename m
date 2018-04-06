Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965609-1523039578-2-3976188540150551381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039578; b=uo9Cw2izd1/9v/h1hS4ThHS//lnRNaoIgOVP69tLIcW3hc/IAo
    eI9VBkF8qK1X+FWd6DcGUOYLiikbrBYT5Agd4ggfiFK5o03XzgoijWwRFdmFk6xP
    KEwvC8F69YUynTSuqRJIpnlMPiginUYkzoY2z2qOhGLz36qR2X++z21r4jmkC4fz
    15p7Wc8vcY6/YVhF3BygIj5z9jH4wZRS98WDLF0Fkm6sHdaMdkVZUNY4/UWTY/YG
    m1rEo5eI/s9i0QzfmUrdcTrZMRsYQ7LxWJNqvqNidP0+1fAAKpdysHCngiZ6a+bM
    jlSr+zdcCmz9VC0uTmiftt1T2BEyuoyMOf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039578; bh=
    slJ/uHTL0bFGJTDG/Dc9aOFBW0B55sftKeYb+o7aGo4=; b=EdQ+/Ik6JJwAAC26
    FhUqVNdsDTBT9ncCpYSD1dXZgKiiIomX8S75VvgFrmMOCv00/JRyBmtIdyIK56HV
    hv41ZL9Tob2U0DcT+X8GXNOJcqgtaFB5CSSeuJeivrMFNtphU2s6MsnMJ8ZD3XVY
    IsxqNEQagdvosUul6ny4TI+/9tItLIigzh1oAlqSOqStcuc6q8YDRImDWL0dfwNK
    7+KCrJA0yn+4GtV+6H5dyjtu3KA89b9EALUG8mTTbwSHiymPDXyzDDfQ1kr84+JS
    CBeYhDoca57u3vQYtDbvbcjGSvaUHVHVDa5LYECjJc8CHPeMdhZRjoh8b1fXrnqR
    bSZRLA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOZf0HNJESBUFgUaPmNG04tnP/O+laH8QK1PYo7BOBS20PBOjWTeQbGgYWquN05xl4SIh1yTFD0xZpgr5yl/4g6fKE3FwCulBdXp/SB5Ne+C7dTUuHhZ
    v08RsH+J2yNsfiRWHlaSpRX3LoFHMcLHiUVi67nwpoN2IJyLh2nTH+q+CTrhdKax/z3ErbhZguhgpNeGTmaFhzaPTbFOw+LbvOS4sW7Ip5ziGw3qPrkuM0y+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=sfOm8-O8AAAA:8
    a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=-Wj-2de5zPTN87RxXb8A:9
    a=gGpx1yReQwvDXaq7:21 a=N6se2Jw1VkNqxpCV:21 a=TvTJqdcANYtsRzA46cdi:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDFScM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:32:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:38636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbeDFSac (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611471"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 12/12] x86/microcode: Fix CPU synchronization routine
Date: Fri,  6 Apr 2018 11:30:26 -0700
Message-Id: <1523039426-3938-13-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit bb8c13d61a629276a162c1d2b1a20a815cbcfbb7 upstream

Emanuel reported an issue with a hang during microcode update because my
dumb idea to use one atomic synchronization variable for both rendezvous
- before and after update - was simply bollocks:

  microcode: microcode_reload_late: late_cpus: 4
  microcode: __reload_late: cpu 2 entered
  microcode: __reload_late: cpu 1 entered
  microcode: __reload_late: cpu 3 entered
  microcode: __reload_late: cpu 0 entered
  microcode: __reload_late: cpu 1 left
  microcode: Timeout while waiting for CPUs rendezvous, remaining: 1

CPU1 above would finish, leave and the others will still spin waiting for
it to join.

So do two synchronization atomics instead, which makes the code a lot more
straightforward.

Also, since the update is serialized and it also takes quite some time per
microcode engine, increase the exit timeout by the number of CPUs on the
system.

That's ok because the moment all CPUs are done, that timeout will be cut
short.

Furthermore, panic when some of the CPUs timeout when returning from a
microcode update: we can't allow a system with not all cores updated.

Also, as an optimization, do not do the exit sync if microcode wasn't
updated.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180314183615.17629-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 68 ++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index e6d5caa..021c904 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -517,7 +517,29 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static atomic_t late_cpus;
+static atomic_t late_cpus_in;
+static atomic_t late_cpus_out;
+
+static int __wait_for_cpus(atomic_t *t, long long timeout)
+{
+	int all_cpus = num_online_cpus();
+
+	atomic_inc(t);
+
+	while (atomic_read(t) < all_cpus) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				all_cpus - atomic_read(t));
+			return 1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+	return 0;
+}
 
 /*
  * Returns:
@@ -527,30 +549,16 @@ static atomic_t late_cpus;
  */
 static int __reload_late(void *info)
 {
-	unsigned int timeout = NSEC_PER_SEC;
-	int all_cpus = num_online_cpus();
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
 
-	atomic_dec(&late_cpus);
-
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	while (atomic_read(&late_cpus)) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				atomic_read(&late_cpus));
-			return -1;
-		}
-
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
-
-		touch_nmi_watchdog();
-	}
+	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+		return -1;
 
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
@@ -558,15 +566,22 @@ static int __reload_late(void *info)
 
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		ret = -1;
-	} else if (err == UCODE_UPDATED) {
+		return -1;
+	/* siblings return UCODE_OK because their engine got updated already */
+	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
+	} else {
+		return ret;
 	}
 
-	atomic_inc(&late_cpus);
-
-	while (atomic_read(&late_cpus) != all_cpus)
-		cpu_relax();
+	/*
+	 * Increase the wait timeout to a safe value here since we're
+	 * serializing the microcode update and that could take a while on a
+	 * large number of CPUs. And that is fine as the *actual* timeout will
+	 * be determined by the last CPU finished updating and thus cut short.
+	 */
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
+		panic("Timeout during microcode update!\n");
 
 	return ret;
 }
@@ -579,12 +594,11 @@ static int microcode_reload_late(void)
 {
 	int ret;
 
-	atomic_set(&late_cpus, num_online_cpus());
+	atomic_set(&late_cpus_in,  0);
+	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret < 0)
-		return ret;
-	else if (ret > 0)
+	if (ret > 0)
 		microcode_check();
 
 	return ret;
-- 
2.7.4
