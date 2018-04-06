Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039437-2-3009155764605963179
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
    1523039437; b=NL2+3bELwXfj2xvUFiY/tUC619k1pRU7e0jEtxgAmEY9Va58x6
    IX8e/UtpI2Bju4nAh9yu4IHFlHZ4TokQdZNo7HWT0+fwI8qCHKkEyemQSRMxUu7+
    iLBbzp5aZdSDwi4fxC1ZI7cU1t/yLK5EaflGdGn9p8VWD/NwUj/m/w7xgyozQThK
    KhpE6cItUq40NcQoFgs6/2BHdngm+6EqEKRNw8pqF5zH9imjFF1nDyNhTzBdwJNn
    zz2J2Tvfry1fA4Q9v6bwigkzK35bqt1JDbZPC/WEQS1wYbbNHovwZym/tdVWLxZT
    cxGDuE9IScbq+D7QmY8axYiQOXRUFckbgs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039437; bh=
    yLKNNFzyqSWIXHkm2GdEJWuyS1GPJUoS7J/tUtAYUMY=; b=e2fk8AUxctnFerj2
    FY+dtDivHyOX7BPTa2oF8ciUU5cxnCdPzDSte2haR6AqkJQsTB1koxEfdTYuqIis
    lnmzJDFKDZHEwn2tvuNuJGNX4Ek1lUW25M0CIeZ+m4MXYqE+T8lXyzEzxHKF/+Me
    jXcUzl6SShTKlco9JIr63lwhRKhxPt7rBEAft9xqLoDGv/qxGJuBWj0nWb0OhB3O
    Syoce5OKSE5DwwpziHrRuSLNYzklaYMOUoe8offycrjgV43nO2LVP8+5wjn9/xOF
    3fD1+0RpCphyqeBRZEgxqvtWgxyPKOjv+53LLt7vvkf67m8lQjCyAXTP6MqUV+xy
    k5HeNQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrs/dpBpW4QQd9/I2/F5b/u8FGaBn3MRVRAeqp1/ZvubBY+P/6HymzglZYm/K67tLCZ8RzHo7niiC41lVICtUHlcekMW7SnqdgyVTe8Vz/nVJPJ3xk4
    86SI1QLvxRsTPsPERAmzVjzmw5qekVloO3t35Pre9XuWXMg5uBPR1nYqTHU4QEpp6hfQFRLbWmIb8reWpZcvPnZICJo/mkjpqVRMtSQzTOSah1IOI8gis0OH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=0aE5WbeoMfx8o801NA0A:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeDFSaf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:30:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:38636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752012AbeDFSae (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611448"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 05/12] x86/microcode/intel: Check microcode revision before updating sibling threads
Date: Fri,  6 Apr 2018 11:30:19 -0700
Message-Id: <1523039426-3938-6-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit c182d2b7d0ca48e0d6ff16f7d883161238c447ed upstream

After updating microcode on one of the threads of a core, the other
thread sibling automatically gets the update since the microcode
resources on a hyperthreaded core are shared between the two threads.

Check the microcode revision on the CPU before performing a microcode
update and thus save us the WRMSR 0x79 because it is a particularly
expensive operation.

[ Borislav: Massage changelog and coding style. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-2-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-3-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 923054a..87bd6dc 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -589,6 +589,17 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	if (!mc)
 		return 0;
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -776,7 +787,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	static int prev_rev;
 	u32 rev;
 
@@ -793,6 +804,18 @@ static enum ucode_state apply_microcode_intel(int cpu)
 			return UCODE_NFOUND;
 	}
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -813,8 +836,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-- 
2.7.4
