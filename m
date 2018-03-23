Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804952-2-15490301484850654854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804951; b=UXaom8BsftoPZThl00UVWKUqp1LS31ZpOXaj9tNDvchds0E
    urh/lU2MgtrUi/qAXCdsMm6njAgazldN4hC8RF5pXjFZ+Xzn/g2pD0vebHTgbmRf
    19/aL05zO6PwlgWoOLPaRm8DmCRELgs1y6eB6MHUmPCYTp/FjpKwleOAssiWIRcS
    jDVVmQCB0+j4twh24R+qlHCq6JvpYcp9jOJYdwUB23KgUVzuQPrrsH1VqF61QFew
    QQ4plO1oXDFFwRi1yG/6ayCbfzEbzOIQ+Lb4IwRRiPnyKaIjYOVuGZwSQHWW3XLG
    /9BH/aERmp2LpazkO/mJmhJOiMWRntsazzBS/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804951; bh=kD61rcR3Vy+orWNZkna8M48b+e
    b5uEPtmp63whVzwsY=; b=SHiho9OAsqjzqLryTQezemJs0o3Pd+QuT2peHjX5xB
    lVl52NHWIYDv2SLO6pqiQq6cH1StM0yYjVYxR6qt4R3IlhUR8aaH+mykRzucWqeX
    GrUhUMqBcAhgc6K5UZbBDKdKyry0No+iF/YnfTkovaI/HDpf722LnA23CYRWWdzT
    bhegvSDbo/1ldtYfVvvBiG7Ii5db4XQi2J7CtLDVD2WJeSNfiBzELr8yoVl7O55t
    17qu12GrdFg6tAfE22CZ35rwquGNS50hcwRHdQkGrq4TyP1cbttuoTei2b1op+xK
    oWMBMDOBL/j0mGHQ7r0iRC/OH6l+LU7JDWty3S1r9IVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeCWLfP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:35:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754903AbeCWKFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-pm@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 018/177] cpufreq/sh: Replace racy task affinity logic
Date: Fri, 23 Mar 2018 10:52:26 +0100
Message-Id: <20180323094205.998254321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/sh-cpufreq.c |   45 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -30,54 +30,63 @@
 
 static DEFINE_PER_CPU(struct clk, sh_cpuclk);
 
+struct cpufreq_target {
+	struct cpufreq_policy	*policy;
+	unsigned int		freq;
+};
+
 static unsigned int sh_cpufreq_get(unsigned int cpu)
 {
 	return (clk_get_rate(&per_cpu(sh_cpuclk, cpu)) + 500) / 1000;
 }
 
-/*
- * Here we notify other drivers of the proposed change and the final change.
- */
-static int sh_cpufreq_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static long __sh_cpufreq_target(void *arg)
 {
-	unsigned int cpu = policy->cpu;
+	struct cpufreq_target *target = arg;
+	struct cpufreq_policy *policy = target->policy;
+	int cpu = policy->cpu;
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, cpu);
-	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 	struct device *dev;
 	long freq;
 
-	cpus_allowed = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
-	BUG_ON(smp_processor_id() != cpu);
+	if (smp_processor_id() != cpu)
+		return -ENODEV;
 
 	dev = get_cpu_device(cpu);
 
 	/* Convert target_freq from kHz to Hz */
-	freq = clk_round_rate(cpuclk, target_freq * 1000);
+	freq = clk_round_rate(cpuclk, target->freq * 1000);
 
 	if (freq < (policy->min * 1000) || freq > (policy->max * 1000))
 		return -EINVAL;
 
-	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
+	dev_dbg(dev, "requested frequency %u Hz\n", target->freq * 1000);
 
 	freqs.old	= sh_cpufreq_get(cpu);
 	freqs.new	= (freq + 500) / 1000;
 	freqs.flags	= 0;
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+	cpufreq_freq_transition_begin(target->policy, &freqs);
 	clk_set_rate(cpuclk, freq);
-	cpufreq_freq_transition_end(policy, &freqs, 0);
+	cpufreq_freq_transition_end(target->policy, &freqs, 0);
 
 	dev_dbg(dev, "set frequency %lu Hz\n", freq);
-
 	return 0;
 }
 
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int sh_cpufreq_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_target data = { .policy = policy, .freq = target_freq };
+
+	return work_on_cpu(policy->cpu, __sh_cpufreq_target, &data);
+}
+
 static int sh_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
