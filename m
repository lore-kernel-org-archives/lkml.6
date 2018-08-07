Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FED2174D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FED2174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbeHGN0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:26:37 -0400
Received: from foss.arm.com ([217.140.101.70]:52660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeHGN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FCE480D;
        Tue,  7 Aug 2018 04:12:46 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 386403F2EA;
        Tue,  7 Aug 2018 04:12:44 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:12:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     skannan@codeaurora.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20180807111237.GA1588@e107155-lin>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:54:24PM -0700, skannan@codeaurora.org wrote:
> On 2018-08-03 16:46, Stephen Boyd wrote:
> >Quoting Taniya Das (2018-07-24 03:42:49)
> >>diff --git
> >>a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>new file mode 100644
> >>index 0000000..22d4355
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>@@ -0,0 +1,172 @@
> >[...]
> >>+
> >>+               CPU7: cpu@700 {
> >>+                       device_type = "cpu";
> >>+                       compatible = "qcom,kryo385";
> >>+                       reg = <0x0 0x700>;
> >>+                       enable-method = "psci";
> >>+                       next-level-cache = <&L2_700>;
> >>+                       qcom,freq-domain = <&freq_domain_table1>;
> >>+                       L2_700: l2-cache {
> >>+                               compatible = "cache";
> >>+                               next-level-cache = <&L3_0>;
> >>+                       };
> >>+               };
> >>+       };
> >>+
> >>+       qcom,cpufreq-hw {
> >>+               compatible = "qcom,cpufreq-hw";
> >>+
> >>+               clocks = <&rpmhcc RPMH_CXO_CLK>;
> >>+               clock-names = "xo";
> >>+
> >>+               #address-cells = <2>;
> >>+               #size-cells = <2>;
> >>+               ranges;
> >>+               freq_domain_table0: freq_table0 {
> >>+                       reg = <0 0x17d43000 0 0x1400>;
> >>+               };
> >>+
> >>+               freq_domain_table1: freq_table1 {
> >>+                       reg = <0 0x17d45800 0 0x1400>;
> >>+               };
> >
> >Sorry, this is just not proper DT design. The whole node should have a
> >reg property, and it should contain two (or three if we're handling the
> >L3 clk domain?) different offsets for the different power clusters. The
> >problem seems to still be that we don't have a way to map the CPUs to
> >the clk domains they're in provided by this hardware block. Making
> >subnodes is not the solution.
> 
> The problem is mapping clock domains to logical CPUs that CPUfreq uses. The
> physical CPU to logical CPU mapping can be changed by the kernel (even
> through DT if I'm not mistaken). So we need to have a way to tell in DT
> which physical CPUs are connected to which CPU freq clock domain.
> 

How about passing CPU freq clock domain id as along with phandle in
qcom,freq-domain ?

--
Regards,
Sudeep
