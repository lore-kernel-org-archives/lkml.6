Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D484C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126702172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GCEhfzjj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m7hTmQrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126702172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbeHGVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:40:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbeHGVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:40:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7781460B23; Tue,  7 Aug 2018 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533669856;
        bh=L+m1e8uBHYVAW2GEH4GOn34LmPMhjmgvwUjI47yc7a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCEhfzjje26AsDue+VWdk2ttQHgVspm/a//IrW4JljICOqAZ9GwIOSSDezh9dWvT4
         wWqlUd4/U5HQXuIC6bb1uviqqwccneljl4Sw94wLJ2P1VKppvrkwZ6jtEn3DBJPUqm
         zDNNjXJ+Iksuz/9SxodPehcW+TS4DAmN4VV/ZCug=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F19FD606FC;
        Tue,  7 Aug 2018 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533669855;
        bh=L+m1e8uBHYVAW2GEH4GOn34LmPMhjmgvwUjI47yc7a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m7hTmQrfpBvfrS1IA33SixVxu2lU0I8ZKWk148jOuB+TeIN6/uaril1CbT4cvH9MQ
         Jy9b7HvnNu+a9k4wSIOrU33uA3B8AyoTn9jrmR0J9Xt9UjAygHTcaaO5+HgInNIS99
         SzzwWdLEkCV51oCDnmn7X3l/gGkuCXGjmf1Cp35g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 12:24:14 -0700
From:   skannan@codeaurora.org
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
In-Reply-To: <20180807111237.GA1588@e107155-lin>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
Message-ID: <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 04:12, Sudeep Holla wrote:
> On Mon, Aug 06, 2018 at 01:54:24PM -0700, skannan@codeaurora.org wrote:
>> On 2018-08-03 16:46, Stephen Boyd wrote:
>> >Quoting Taniya Das (2018-07-24 03:42:49)
>> >>diff --git
>> >>a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> >>b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> >>new file mode 100644
>> >>index 0000000..22d4355
>> >>--- /dev/null
>> >>+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> >>@@ -0,0 +1,172 @@
>> >[...]
>> >>+
>> >>+               CPU7: cpu@700 {
>> >>+                       device_type = "cpu";
>> >>+                       compatible = "qcom,kryo385";
>> >>+                       reg = <0x0 0x700>;
>> >>+                       enable-method = "psci";
>> >>+                       next-level-cache = <&L2_700>;
>> >>+                       qcom,freq-domain = <&freq_domain_table1>;
>> >>+                       L2_700: l2-cache {
>> >>+                               compatible = "cache";
>> >>+                               next-level-cache = <&L3_0>;
>> >>+                       };
>> >>+               };
>> >>+       };
>> >>+
>> >>+       qcom,cpufreq-hw {
>> >>+               compatible = "qcom,cpufreq-hw";
>> >>+
>> >>+               clocks = <&rpmhcc RPMH_CXO_CLK>;
>> >>+               clock-names = "xo";
>> >>+
>> >>+               #address-cells = <2>;
>> >>+               #size-cells = <2>;
>> >>+               ranges;
>> >>+               freq_domain_table0: freq_table0 {
>> >>+                       reg = <0 0x17d43000 0 0x1400>;
>> >>+               };
>> >>+
>> >>+               freq_domain_table1: freq_table1 {
>> >>+                       reg = <0 0x17d45800 0 0x1400>;
>> >>+               };
>> >
>> >Sorry, this is just not proper DT design. The whole node should have a
>> >reg property, and it should contain two (or three if we're handling the
>> >L3 clk domain?) different offsets for the different power clusters. The
>> >problem seems to still be that we don't have a way to map the CPUs to
>> >the clk domains they're in provided by this hardware block. Making
>> >subnodes is not the solution.
>> 
>> The problem is mapping clock domains to logical CPUs that CPUfreq 
>> uses. The
>> physical CPU to logical CPU mapping can be changed by the kernel (even
>> through DT if I'm not mistaken). So we need to have a way to tell in 
>> DT
>> which physical CPUs are connected to which CPU freq clock domain.
>> 
> 
> How about passing CPU freq clock domain id as along with phandle in
> qcom,freq-domain ?

Now sure what you mean here. There's no such this as CPUfreq clock 
domain id. It has policies that are made up of logical CPU numbers. 
Logical CPU is not something that you can fix in DT.

-Saravana
