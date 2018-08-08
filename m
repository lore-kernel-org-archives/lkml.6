Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18DFC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89741216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jLbcfAF7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ihbnSr6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89741216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHHFDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:03:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHHFDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:03:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F55060B19; Wed,  8 Aug 2018 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533696368;
        bh=wHiwpsXVXS0l93Zck5Brv0rHIz3ERN+sz3uCIuUlTYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jLbcfAF7zIOYRKmSN7upO2zEdNkl+36PvVycoRE/PSzmJN17psJ+bsHWn2bbCNQl3
         79wA+cz/ekA8PzqKVM/U5N6B1K1ajWbrTF3pgIQFeqYLA7570qwmpJxVDQ8KlNz02b
         z4BXyxEOprS3jYJZDWkxkJJJKKikKVoJ3B3eCqws=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CCE860AD8;
        Wed,  8 Aug 2018 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533696367;
        bh=wHiwpsXVXS0l93Zck5Brv0rHIz3ERN+sz3uCIuUlTYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ihbnSr6q/dNO3wmXTlS+mq3GJsxJQvia6HBO2/Aodqs8FKg9vkGAsw2ChAPvNYfkJ
         vb0IW7Hwp3vHNheh3tMh8dYU2Ov4lykLrjPIKKewXUAbVJV9UIxNbeM3Lv/NMVD4BX
         9wG28nkUFbEQ/w5X/r09fQAYhR6Unh0c7ad+bhrc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CCE860AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
To:     skannan@codeaurora.org, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
 <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
Date:   Wed, 8 Aug 2018 08:16:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2018 12:54 AM, skannan@codeaurora.org wrote:
> On 2018-08-07 04:12, Sudeep Holla wrote:
>> On Mon, Aug 06, 2018 at 01:54:24PM -0700, skannan@codeaurora.org wrote:
>>> On 2018-08-03 16:46, Stephen Boyd wrote:
>>> >Quoting Taniya Das (2018-07-24 03:42:49)
>>> >>diff --git
>>> >>a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>new file mode 100644
>>> >>index 0000000..22d4355
>>> >>--- /dev/null
>>> >>+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>@@ -0,0 +1,172 @@
>>> >[...]
>>> >>+
>>> >>+               CPU7: cpu@700 {
>>> >>+                       device_type = "cpu";
>>> >>+                       compatible = "qcom,kryo385";
>>> >>+                       reg = <0x0 0x700>;
>>> >>+                       enable-method = "psci";
>>> >>+                       next-level-cache = <&L2_700>;
>>> >>+                       qcom,freq-domain = <&freq_domain_table1>;
>>> >>+                       L2_700: l2-cache {
>>> >>+                               compatible = "cache";
>>> >>+                               next-level-cache = <&L3_0>;
>>> >>+                       };
>>> >>+               };
>>> >>+       };
>>> >>+
>>> >>+       qcom,cpufreq-hw {
>>> >>+               compatible = "qcom,cpufreq-hw";
>>> >>+
>>> >>+               clocks = <&rpmhcc RPMH_CXO_CLK>;
>>> >>+               clock-names = "xo";
>>> >>+
>>> >>+               #address-cells = <2>;
>>> >>+               #size-cells = <2>;
>>> >>+               ranges;
>>> >>+               freq_domain_table0: freq_table0 {
>>> >>+                       reg = <0 0x17d43000 0 0x1400>;
>>> >>+               };
>>> >>+
>>> >>+               freq_domain_table1: freq_table1 {
>>> >>+                       reg = <0 0x17d45800 0 0x1400>;
>>> >>+               };
>>> >
>>> >Sorry, this is just not proper DT design. The whole node should have a
>>> >reg property, and it should contain two (or three if we're handling the
>>> >L3 clk domain?) different offsets for the different power clusters. The
>>> >problem seems to still be that we don't have a way to map the CPUs to
>>> >the clk domains they're in provided by this hardware block. Making
>>> >subnodes is not the solution.
>>>
>>> The problem is mapping clock domains to logical CPUs that CPUfreq 
>>> uses. The
>>> physical CPU to logical CPU mapping can be changed by the kernel (even
>>> through DT if I'm not mistaken). So we need to have a way to tell in DT
>>> which physical CPUs are connected to which CPU freq clock domain.
>>>
>>
>> How about passing CPU freq clock domain id as along with phandle in
>> qcom,freq-domain ?
> 
> Now sure what you mean here. There's no such this as CPUfreq clock 
> domain id. It has policies that are made up of logical CPU numbers. 
> Logical CPU is not something that you can fix in DT.
> 
> -Saravana

Sudeep,

Earlier the design was the freq_domain would take the CPU phandles

freq_domain:
   cpus = <&cpu0 &cpu1....>;

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
