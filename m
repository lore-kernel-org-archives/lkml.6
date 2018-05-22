Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeEVJS0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:18:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33394 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVJSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:18:22 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
To: ilialin@codeaurora.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, viresh.kumar@linaro.org,
        nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, linux-clk@vger.kernel.org
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
 <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
 <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <7690ea9d-0155-ecd1-8fb2-08d0bd61e081@arm.com>
Date: Tue, 22 May 2018 10:18:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/18 08:59, ilialin@codeaurora.org wrote:
> OK, I think I found out the way. Would this be correct?

No.

> -----------------------------------------------------------------------------------------------
> extern struct cpu_topology cpu_topology[NR_CPUS];
> 
> static struct device *qcom_cpufreq_kryo_get_cluster_lead(int cluster)
> {
> 	unsigned cpu;
> 
> 	for_each_possible_cpu(cpu) {
> 		if ((cluster == cpu_topology[cpu].cluster_id) &&

cluster_id is going away soon, so avoid relying on that. IIUC there's a
way already something like opp_of_get_shared_cpus.

-- 
Regards,
Sudeep
