Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965609-1523039472-2-17253306688573764314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sk.us-asciiroen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039472; b=MpltV390ROKyGLMxtvVGlf9Fto4Gt9PgkdFZGu1n9m6SBZJyto
    CStnSz+sEHIY4Tv4Ahdjh37c+NZ2GgwI7Ct7iOKWw6oGnCffL1ysgpnMvXvujCdc
    8VGsvjcllOvM1P+X1tzXd4KUQALlYxebTFC3XLBxDVqEHKrs5vk45O78UthLtpt/
    mzErAUvPdDzcG8VJvua/LokUmwok+YFtWkuIqgVuiYTBRBr6UhYTBSiSNElWuDWc
    tC/kqQDmmqWAUphNPz9sVcYOZqd7j5MdD5EbjXm1w30rMcNyQTddEGMYcruM4RBR
    v5etJF2jWoiOfOX9TMAe9a7ngndrykrPQWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039472; bh=
    J538lGXqUTAVRZjjGedJkbalhj2FXVfVw/AI0b7UpIw=; b=RF/ONjhFjHfeDA9H
    HN3ArF+kTNFMrwQVF5IpZsTzN6CHY2xar0onIndI9NK56arYmRUrjCn+NvJinz+L
    ON+49QuqMbm/aEkmpUyNavsCVpufxJ8QleL9n+ehyyE3wqDqDH0eEff2XKCB3u3J
    R6hM7xlyT7yksL8923F9BN4x5HExJ3545XYxGvIX461LYePbVLKZ5SsgSydNCbDy
    n0mfas/jN80b/HeiAHey/azXJ3jh2TU7ZVxnRJAkLK6/+fzDkE9dJ0a5QOxkptq4
    s1ubtkO9qFs0qPADV5jrbmk0m8ySQhMbm0hbLbE5tad91N/24ol+NUwCWZTrJCO8
    FJxQtQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCZ8A269H9cvJ2yLMdCMpkkWyOkNJwvzHIuY2k3Mnm6UebS1LVM/WkG1e+YfxkiQgDfbZZEuS+lBoZo/cUdKFL05agunZ5tIBqaidf6FoxyIx25eaDia
    VPqrImjF4/o8/m1/+wXdTJzYob7vJGnrAVJHo4+9mYMo3HrZUNfLs91bldChRPjL+Z3g5RblROuaLH176y7lRKF1nQqaGN5cKyrKdYZhPgR9j1SjcLYg1i+Y
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=ujPgyWcY82IGUUahj2QA:9
    a=xFNtQM0qyN2y1kXk:21 a=JTm8uv6drEzKXMky:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeDFSag (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:30:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:38636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752000AbeDFSae (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611455"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 07/12] x86/microcode: Do not upload microcode if CPUs are offline
Date: Fri,  6 Apr 2018 11:30:21 -0700
Message-Id: <1523039426-3938-8-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 30ec26da9967d0d785abc24073129a34c3211777 upstream

Avoid loading microcode if any of the CPUs are offline, and issue a
warning. Having different microcode revisions on the system at any time
is outright dangerous.

[ Borislav: Massage changelog. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1519352533-15992-4-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-5-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cbeace2..f25c395 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -486,6 +486,16 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+static int check_online_cpus(void)
+{
+	if (num_online_cpus() == num_present_cpus())
+		return 0;
+
+	pr_err("Not all CPUs online, aborting microcode update.\n");
+
+	return -EINVAL;
+}
+
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -519,7 +529,13 @@ static ssize_t reload_store(struct device *dev,
 		return size;
 
 	get_online_cpus();
+
+	ret = check_online_cpus();
+	if (ret)
+		goto put;
+
 	mutex_lock(&microcode_mutex);
+
 	for_each_online_cpu(cpu) {
 		tmp_ret = reload_for_cpu(cpu);
 		if (tmp_ret > UCODE_NFOUND) {
@@ -538,6 +554,8 @@ static ssize_t reload_store(struct device *dev,
 		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
+
+put:
 	put_online_cpus();
 
 	if (!ret)
-- 
2.7.4
