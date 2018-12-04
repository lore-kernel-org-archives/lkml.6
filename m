Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27880C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22A7206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CiRdQNWV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="btzc5G+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22A7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeLDSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:45:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:45:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B78A26014B; Tue,  4 Dec 2018 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543949155;
        bh=ZLGTIeBFFVX1ZNJJ5w0lXe7Xj+C8O0WjP0rfloUjyvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiRdQNWVuVWhcbGfTBKiRC2eVeELWng4b+7X+2XOmzPVao0sAdJsIWTPYXGclau/9
         h1t1SdAm05aX93ZK5mX6PZ2hLNtZ2tlOEKfsNO0tOdL4ujfmbQCPQ/5fiukbDX1AVC
         9rOpaiSVrp2HM7WmP9YguAm7XNpWZ5STW30B6m6U=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61A406014B;
        Tue,  4 Dec 2018 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543949154;
        bh=ZLGTIeBFFVX1ZNJJ5w0lXe7Xj+C8O0WjP0rfloUjyvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btzc5G+3S6o/GN/hS89p4Zk4ssf9cnb3VaolKX11/58z3GS5YILrCmYzHqy0kIGkp
         UafFlXdbusfbGnGp8kv/H7gQEm6HwOI8YEShvdf9D3PbHBpEdmwmOk4I34Ywx43eHT
         0OTKtL66oFbkmgd0M8K/G/Jw+mHsuMWIkbBVAw2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61A406014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 4 Dec 2018 11:45:53 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to
 attach a CPU to its PM domain
Message-ID: <20181204184553.GO18262@codeaurora.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-22-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-22-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
>Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
>a CPU number as an in-parameter and attaches the CPU's struct device to its
>corresponding PM domain. Additionally, the helper prepares the CPU to be
>power managed via runtime PM, which is the last step needed to enable the
>interaction with the PM domain through the runtime PM callbacks.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v10:
>	- New patch: Replaces "PM / Domains: Add helper functions to
>	  attach/detach CPUs to/from genpd".
>
>---
> drivers/firmware/psci/psci.h           |  1 +
> drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
>
>diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
>index 05af462cc96e..fbc9980dee69 100644
>--- a/drivers/firmware/psci/psci.h
>+++ b/drivers/firmware/psci/psci.h
>@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> int psci_dt_init_pm_domains(struct device_node *np);
> int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> 			struct device_node *cpu_node, u32 *psci_states);
>+int psci_dt_attach_cpu(int cpu);
> #else
> static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> #endif
>diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
>index 6c9d6a644c7f..b0fa7da8a0ce 100644
>--- a/drivers/firmware/psci/psci_pm_domain.c
>+++ b/drivers/firmware/psci/psci_pm_domain.c
>@@ -12,8 +12,10 @@
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/pm_domain.h>
>+#include <linux/pm_runtime.h>
> #include <linux/slab.h>
> #include <linux/string.h>
>+#include <linux/cpu.h>
> #include <linux/cpuidle.h>
> #include <linux/cpu_pm.h>
>
>@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
>
> 	return 0;
> }
>+
>+int psci_dt_attach_cpu(int cpu)
>+{
>+	struct device *dev = get_cpu_device(cpu);
>+	int ret;
>+
>+	ret = dev_pm_domain_attach(dev, true);
>+	if (ret)
>+		return ret;
>+
>+	pm_runtime_irq_safe(dev);
>+	pm_runtime_get_noresume(dev);
>+	pm_runtime_set_active(dev);
You would want to set this only if the CPU is online. Otherwise we will
not power down the domain, if the CPU was never brought online.
>+	pm_runtime_enable(dev);
>+
>+	return 0;
>+}
> #endif
>-- 
>2.17.1
>
