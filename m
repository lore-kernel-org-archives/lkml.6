Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA84C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD3C21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD3C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHHK41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:56:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbeHHK41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:56:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43EF18A;
        Wed,  8 Aug 2018 01:37:47 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BE783F2EA;
        Wed,  8 Aug 2018 01:37:45 -0700 (PDT)
Date:   Wed, 8 Aug 2018 09:37:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>, skannan@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20180808083738.GA25416@e107155-lin>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
 <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
 <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
 <153370890232.220756.13782706852981763402@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153370890232.220756.13782706852981763402@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:15:02PM -0700, Stephen Boyd wrote:
> Quoting Taniya Das (2018-08-07 19:46:01)
[...]

> > Sudeep,
> > 
> > Earlier the design was the freq_domain would take the CPU phandles
> > 
> > freq_domain:
> >    cpus = <&cpu0 &cpu1....>;
> > 
> 
> I believe Sudeep is recommending something I recommended earlier. It
> would look like:
> 
>    cpu7 {
> 	   qcom,freq-domain = <&cpufreq_hw 1>;
>    }
> 
> to indicate that cpu7 is in cpufreq_hw's frequency domain #1. That
> should probably be called clk domain BTW.
>

Thanks Stephen, that's exactly what I meant. You have explained all the
details saving me time :)

> If that was done with a phandle and a single cell, then we should have
> something similar on the cpufreq_hw node side indicating how to parse
> the cells in qcom,freq-domain. A property like #qcom,freq-domain-cells =
> <1> to indicate that one u32 follows the phandle.
>

As Saravana mentions in the other email I can't believe it's just made up
of logical CPU numbers. If that's the case is it software configurable.

--
Regards,
Sudeep
