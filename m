Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965609-1523039512-2-14960353772030194956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039511; b=wPx7r3K8xFa7U8tpE2NWe8b3WeHO4fWfhnTKGeTxHTNQetm8HC
    7nJ+5DCeWsLzvBlq7gaKA4gJttQLY9OB05jE0R4zhu5+9xteHdt/XWuvEf27RoFN
    9rd66D5hBciQkLQDU1htxmOJuBEMV2Tt/bH2nDGlXKIvU3XdFriO41XP+H+g7Iq0
    sEeOlhKo5KrQ4dV3RyMn8ZSoqkLTIem4TpQ0SF9L6jv9yI0ZDjyfB0tqgrgWl9vr
    wrjmIqaY9Gqf+S0XSqMBlwsFh/VnhZyldQaigYtQqrla0byBL2CmYn5gxlV6zgOM
    Qxk0A2JDJUrtLRHT0Mco7irx31CkccOGmt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039511; bh=
    TK+pdCsXi0joUHFyKqW5fQZCgcNp8R5LqqCYEICiTsI=; b=ARWSOtPK94lOuEjL
    N5iAbyodFWvo4hPwp8XfWkWhkNoFgtmOVFh4FQo1BdYDHx3McEVt6yRBckvtrMRi
    /j+knxfPj6Ygnw2MnqPOPACPRb2ffkp9fPauKuvpkN43KFtuoakHBdsLK8vLUpn9
    BVYeVvWhYKD7naV2jWsTvjfp/0qGuTIrFKwFoLJ3JOZbm31TfWB5PIIobvBzZQ2P
    EMAP1Mza9Fng3dogbFwdE66LIHCUSpjKskWADG9QawdGKgzdzv8coGSJNu12Nuue
    HebbZLIfPk7232jakd0ppZ61QlkcjntNprtGsPXPSKgdg6cpFIiVelsMEhQ8pF4Q
    5LP0Pw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfE1x6WZr5K9m159UUCca4+IONGWLdfo40T7qHje9v0tJtUOA/+yltWIv0FBuzPIdWHpIcBT4I8ar7xSC+IYgCx1+hrz/uEGZsZ69bra1deLXIHovLr8q
    kPfk/U8wm2KNH4QxOZThX8ig0wT31p9W/M4WTz+WNKn5A99aoub5QqMvSwguyzMSvS3jZjseex0acyB2Ob7sNzPmNPHrHnF/dnBchO/Q9TlNNWpO2ZCsc2Qu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zd2uoN0lAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=MRMyyBjJLbl1ykA676EA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDFSbY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:31:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:38635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDFSad (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611461"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 09/12] x86/microcode: Request microcode on the BSP
Date: Fri,  6 Apr 2018 11:30:23 -0700
Message-Id: <1523039426-3938-10-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117 upstream

... so that any newer version can land in the cache and can later be
fished out by the application functions. Do that before grabbing the
hotplug lock.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180228102846.13447-7-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f25c395..8adbf43 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -499,15 +499,10 @@ static int check_online_cpus(void)
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
 
 	if (!uci->valid)
 		return UCODE_OK;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate != UCODE_OK)
-		return ustate;
-
 	return apply_microcode_on_target(cpu);
 }
 
@@ -515,11 +510,11 @@ static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
+	int cpu, bsp = boot_cpu_data.cpu_index;
 	enum ucode_state tmp_ret = UCODE_OK;
 	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
-	int cpu;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -528,6 +523,10 @@ static ssize_t reload_store(struct device *dev,
 	if (val != 1)
 		return size;
 
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	if (tmp_ret != UCODE_OK)
+		return size;
+
 	get_online_cpus();
 
 	ret = check_online_cpus();
-- 
2.7.4
