Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB79C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938A02075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938A02075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJXDVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:21:15 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:58124 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeJXDVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:21:15 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id C533820093C;
        Tue, 23 Oct 2018 18:56:35 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4D368210ED; Tue, 23 Oct 2018 20:54:29 +0200 (CEST)
Date:   Tue, 23 Oct 2018 20:54:29 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        lenb@kernel.org
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Message-ID: <20181023185429.GA6756@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49c0abf2d48f..50c5699970c5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -390,11 +390,6 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
-
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
 #endif
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
@@ -490,6 +485,11 @@ static inline bool intel_pstate_acpi_pm_profile_server(void)
 {
 	return false;
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static inline void update_turbo_state(void)
