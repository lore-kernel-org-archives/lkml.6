Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbeEXFSX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:18:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeEXFSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:18:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 612A960213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To: Rob Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
 <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
 <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <cba1616d-ad12-599b-4351-3c7240de852a@codeaurora.org>
Date: Thu, 24 May 2018 10:48:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob, Viresh,

Thank you for the comments. If I understand correctly, the device tree 
nodes should look something like the below.

Though I am not sure if any vendor name could be associated in the cpu 
nodes.

Please suggest if my understanding is wrong.

cpu@0 {
	qcom,freq-domain = <&freq_domain_table0>;
	…
};

same follows for cpu 1/2/3

cpu@400 {
	qcom,freq-domain = <&freq_domain_table1>;
	…
};
same follows for cpu 5/6/7

freq_domain_table0 : freq_table {
	reg = < >, < >, < > ;
	reg-names = "perf_base", "lut_base", "en_base";
};

freq_domain_table1 : freq_table {
	reg = < >, < >, < > ;
	reg-names = "perf_base", "lut_base", "en_base";
};



On 5/23/2018 7:48 PM, Rob Herring wrote:
> On Wed, May 23, 2018 at 12:48 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 22-05-18, 14:31, Rob Herring wrote:
>>> On Sat, May 19, 2018 at 11:04:50PM +0530, Taniya Das wrote:
>>>> +           freq-domain-0 {
>>>> +                   compatible = "cpufreq";
>>>> +                   reg = <0x17d43920 0x4>,
>>>> +                        <0x17d43110 0x500>,
>>>> +                        <0x17d41000 0x4>;
>>>> +                   reg-names = "perf_base", "lut_base", "en_base";
>>>> +                   qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3>;
>>
>> I was thinking, can't we add platform specific properties in the CPU
>> nodes ? If yes, then we can point the phandle of fw node from the CPUs
>> and this awkward list can go away.
> 
> Yes, that's fine. That would be more like OPP binding in that the CPU
> points to the OPP table rather than the OPP pointing to the CPUs.
> 
> With that, you can get rid of the child nodes completely. Just make
> the parent reg property N sets of 3 addresses for N domains.
> 
> Rob
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
