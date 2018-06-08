Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gxxIFVudGlumSAAAmS7hNA
	; Fri, 08 Jun 2018 15:14:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 446F7608BA; Fri,  8 Jun 2018 15:14:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D387B601B4;
	Fri,  8 Jun 2018 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D387B601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeFHPOd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:14:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeFHPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:14:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MTsu0-1froAk0v20-00QRSM; Fri, 08 Jun 2018 17:14:18 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Doug Smythies <doug.smythies@gmail.com>,
        Toshi Kani <toshi.kani@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: remove incorrect __initconst annotation
Date: Fri,  8 Jun 2018 17:14:02 +0200
Message-Id: <20180608151411.3892739-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:+MCNdx+hUjHWWKQBdkzjp68NeYpxiUj0FpwPhKvnPkYeKQnMjz5
 NyWjne+lLVFsQiUrQlqZGVwPUt9GIVc0luAp/x0QtT9ZM36E2HGAXyg6JGqhQ9t12OTynAi
 oKfphJ35l7YgvUp6SeP50jT5fUvgduw8YEhY9oC+as+0z0INAtDtkMFA8CT89lYFisSj0Fr
 RlJP/rE2PRG/b0peq5N7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cVQt4ZAPb24=:I11i/veqz2Lgujd7gXtF52
 ACZxHLBbJZf5zz4ZxC6syzkSFjFi+wW7txXi0rZwj/cW99MtXcnz2iOY4Q+jqY0y3pM+G4De5
 MgA25UzkFFXVRlcYjK9Fpru+WO/0dseoJn+jhND1hcjd1bAMd72+YvsK/ryrhQOCtLW9ASrVl
 sJILVMNBgzO4mISdzzVFabl4Xrfh74sP3a2X9KOPbhPaP+WwH6js6ZZzPBG8zyM/OvGR0+h1b
 FOcSWj27CAWj7TQ2i4iNL0y4wMPBFzbmwGo4ancda4ZsP88wxiFy7GhakQ1IxkzQSSGfytjVr
 cMr+/OBZbLtfqcWtb1WKRtEA/m8G9iLF5jLa7CCToLk+WnWcDkWP+rdsTMkbfPJl3GoYA6YD5
 ovWNGgZRADNtMa4izpZt6FscLzX+dT+2zW7TK2D+o8X7dG+6giIXbNObmp7KX++kIui/rFMag
 oQIS+BS8EddDn1lrcwzwRo0Zh3CLElOvahp49XS767tLd4ohtW7AeiLqF4+7uIWdMS3TVha+m
 ScX0TUaat96V2xd09x1mi+1y6BnrFshDOAQQQUhyLmNYSqtLP2ACxH/ez6jsqfAOTZydUmAlm
 UrgERIhxPCyTfcoLc5IPEh32AC4yJIP0Uuk57duj+pzkcJzwCO2WCSGJq6XlNdbfduyrxlVmh
 g/K/i1Q7Mby5L4YOZ8g/eKm8L5IihvCfjd+dR6mRp7eou1vnhaDc/zt/TeYH8iU15Du0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a build warning about the newly introduced code in
intel_pstate_init_cpu() that references an __initconst variable after
it has been freed:

WARNING: vmlinux.o(.text+0xf9eca2): Section mismatch in reference from the function intel_pstate_init_cpu() to the variable .init.rodata:intel_pstate_hwp_boost_ids
The function intel_pstate_init_cpu() references
the variable __initconst intel_pstate_hwp_boost_ids.
This is often because intel_pstate_init_cpu lacks a __initconst
annotation or the annotation of intel_pstate_hwp_boost_ids is wrong.

This removes the annotation to keep the variable around at
runtime.

Fixes: f50f70793d78 ("cpufreq: intel_pstate: enable boost for Skylake Xeon")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2065724dbffc..380936700165 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1794,7 +1794,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	{}
 };
 
-static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst = {
+static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
 	{}
-- 
2.9.0
