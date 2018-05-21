Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeEUHgI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:36:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:36:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF72B60392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 0/2] Add support for QCOM cpufreq FW driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <20180521060529.kyjkglucbydr6b3f@vireshk-i7>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <cb15a4db-77cd-8063-f323-652c6b03306e@codeaurora.org>
Date: Mon, 21 May 2018 13:05:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521060529.kyjkglucbydr6b3f@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

Sure, will do it next time. Hope updating the fixes in this email is 
fine. Do let me know in case you need me to send it across again the 
series with cover letter updated.

On 5/21/2018 11:35 AM, Viresh Kumar wrote:
> On 19-05-18, 23:04, Taniya Das wrote:
>>   [v2]
>>     * Address comments given in v0 series.
> 
> That's not how you do it. You need to explain every change in enough
> detail here so that the reviewers don't need to go to their previous
> emails to see what changed.
> 
Fixes in [v2]
   * Fixed the alignment issues in "qcom_cpufreq_fw_target_index" for 
  dev_err and also for "qcom_cpu_resources_init".
  * Removed ret = 0 from qcom_get_related_cpus and added to check for 
cpu_mask_empty to return -ENOENT.
  * Fixes qcom_cpu_resources_init function
    * Remove initialization of 'index'
    * Check for valid 'c'
  * Removed initialization of 'prev_cc' from 'qcom_read_lut'.
  * Remove initialization of 'ret' from function qcom_resources_init and 
add return -ENODEV based on 'of_get_available_child_count'.
  * Removed initialization of 'rc' from qcom_cpufreq_fw_driver_probe
  * Removed module_exit as this driver would not be used as module, also 
updated the Kconfig to bool from tristate.
  * Updated the subsystem in device tree bindings.

>>   [v1]
>>      * Fixed compilation reported by Amit K.
>>
>> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this firmware.
>>
>> Taniya Das (2):
>>    dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
>>    cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
>>
>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           |  68 +++++
>>   drivers/cpufreq/Kconfig.arm                        |   9 +
>>   drivers/cpufreq/Makefile                           |   1 +
>>   drivers/cpufreq/qcom-cpufreq-fw.c                  | 317 +++++++++++++++++++++
>>   4 files changed, 395 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>>
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
