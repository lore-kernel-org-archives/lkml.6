Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804961-2-1882803657130361915
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
    t=1521804960; b=IBNDyoFvf+VRBebw60xVlgYIvbMyxjZJBtV5ZFW/P0gvjVV
    tvt5SlhlejAW5jakrDxTDu7L81DmEXe5zaPhz4zCIZ55o0O4XHqRZnWQ5WRSeh7E
    WMXS8ZIGFVSby3KVsQi4YMqKzWKyp6/qSFsk0KZDP0VMDSOdjKdvIQ+zhAO5OQ8f
    e8UGwHS+BW/YyvUl9VMl77iiWudGEiLM5JaJQBtRgV6gWr6NYtjRCxdXwbtin10u
    SaRNfpJOUdJ1KUGnsdYOw1hJvkXxufpxQZFtJpMVv+DSeGBcYGHr+s3EOVupLY7d
    yi9Kp6sbglXXCTjQnoxECRU9SFgR9pP+/GEBwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804960; bh=Gd/UcEXAO9cJh9mFZLh/TOskYu
    aWwtOzJCjwtlwPt4o=; b=Dh5inxgUMSca7GULdw1yUxRrcRn4WAWWIyyVDNv2Di
    65lY3/dWrHMlVgEgOxBypZRGDUX+jq2fO++oTeYL8TCZx5r6CyP6G0WF7crTmAsq
    X3IHE4r7ehUMDDmAf+MzKsSUqkAC4/3XgusoXFDMob0elmdc+AAuA92z8/u5oRRn
    t5BhYiy3HEUF30VutWw+pFd03mrz5KTE4pZPknvyqtka47XsZV5CTpmUQvs6ltOW
    FizWb41EHX2yf0qyJOVtOPZs81RTWO5Et4zX7pVP+2LbFPOQhMj8o/9Ibg8eWgvU
    KtestYlTjQ00cdw9becjudqW1AZsy7dKp7omTkFyX5cQ==
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
        id S1754899AbeCWKFL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754854AbeCWKFJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-acpi@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 017/177] ACPI/processor: Replace racy task affinity logic
Date: Fri, 23 Mar 2018 10:52:25 +0100
Message-Id: <20180323094205.954384495@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_driver.c     |    7 +++-
 drivers/acpi/processor_throttling.c |   62 ++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 27 deletions(-)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -262,11 +262,16 @@ err_power_exit:
 static int acpi_processor_start(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
+	int ret;
 
 	if (!device)
 		return -ENODEV;
 
-	return __acpi_processor_start(device);
+	/* Protect against concurrent CPU hotplug operations */
+	get_online_cpus();
+	ret = __acpi_processor_start(device);
+	put_online_cpus();
+	return ret;
 }
 
 static int acpi_processor_stop(struct device *dev)
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -62,8 +62,8 @@ struct acpi_processor_throttling_arg {
 #define THROTTLING_POSTCHANGE      (2)
 
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force);
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct);
 
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -891,7 +891,8 @@ static int acpi_processor_get_throttling
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"Invalid throttling state, reset\n"));
 			state = 0;
-			ret = acpi_processor_set_throttling(pr, state, true);
+			ret = __acpi_processor_set_throttling(pr, state, true,
+							      true);
 			if (ret)
 				return ret;
 		}
@@ -901,36 +902,31 @@ static int acpi_processor_get_throttling
 	return 0;
 }
 
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static long __acpi_processor_get_throttling(void *data)
 {
-	cpumask_var_t saved_mask;
-	int ret;
+	struct acpi_processor *pr = data;
+
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
 
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
 	if (!pr)
 		return -EINVAL;
 
 	if (!pr->flags.throttling)
 		return -ENODEV;
 
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
-	ret = pr->throttling.acpi_processor_get_throttling(pr);
-	/* restore the previous state */
-	set_cpus_allowed_ptr(current, saved_mask);
-	free_cpumask_var(saved_mask);
 
-	return ret;
+	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
 }
 
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
@@ -1080,8 +1076,15 @@ static long acpi_processor_throttling_fn
 			arg->target_state, arg->force);
 }
 
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force)
+static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
+{
+	if (direct)
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct)
 {
 	int ret = 0;
 	unsigned int i;
@@ -1130,7 +1133,8 @@ int acpi_processor_set_throttling(struct
 		arg.pr = pr;
 		arg.target_state = state;
 		arg.force = force;
-		ret = work_on_cpu(pr->id, acpi_processor_throttling_fn, &arg);
+		ret = call_on_cpu(pr->id, acpi_processor_throttling_fn, &arg,
+				  direct);
 	} else {
 		/*
 		 * When the T-state coordination is SW_ALL or HW_ALL,
@@ -1163,8 +1167,8 @@ int acpi_processor_set_throttling(struct
 			arg.pr = match_pr;
 			arg.target_state = state;
 			arg.force = force;
-			ret = work_on_cpu(pr->id, acpi_processor_throttling_fn,
-				&arg);
+			ret = call_on_cpu(pr->id, acpi_processor_throttling_fn,
+					  &arg, direct);
 		}
 	}
 	/*
@@ -1182,6 +1186,12 @@ int acpi_processor_set_throttling(struct
 	return ret;
 }
 
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state,
+				  bool force)
+{
+	return __acpi_processor_set_throttling(pr, state, force, false);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
