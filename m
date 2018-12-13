Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5A6C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9358720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZVM0sjLo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c8tYgLsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9358720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeLMEoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:44:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeLMEoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:44:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FDC56087B; Thu, 13 Dec 2018 04:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544676245;
        bh=7gOE38BUDZMZRdp8kJoQIAfbPP8cPtLJjt97waFrnGY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZVM0sjLoxwN8cYBfZxMnbcgUIrZeueKzFOvu03vvlDHWeET61QStS6MIjf6mK5v43
         j2jsxKcQee5sGPqP9gvSludO4CDSeV8c4RblLbx5+zq49wEwztApmlR3CMAldw6WcH
         jcH2mRv78M64q7NTqdTKJt7xAB6YFGOlXRjKExPA=
Received: from [10.79.128.154] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 096F160237;
        Thu, 13 Dec 2018 04:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544676243;
        bh=7gOE38BUDZMZRdp8kJoQIAfbPP8cPtLJjt97waFrnGY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c8tYgLsxfhVWa3qxgPrp7mfD/V1PG7ez0Xw5lyW5RpMMTAej0wAg8ThlJ1xBzaBJ8
         cVJkPBnPrM9P+YROQXOML56JVsnPwHeHDCTGjhIf+vf33jzzo+FnxrACI9EznOtiia
         v6Uhfq5RR8uiFqG5uMVT3CDJXAGudQlA6UYNG10o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 096F160237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH V3 0/6] PM / Domains: Allow performance state propagation
To:     Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1544611890.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <98df6bc6-4455-87d3-a8b6-493b1c4d7960@codeaurora.org>
Date:   Thu, 13 Dec 2018 10:13:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/2018 4:27 PM, Viresh Kumar wrote:
> Hi,
> 
> This series adds performance state propagation support in genpd core.
> The propagation happens from the sub-domains to their masters. More
> details can be found in the individual commit logs.
> 
> This is tested on hikey960 by faking power domains in such a way that
> the CPU devices have two power domains and both of them have the same
> master domain. The CPU device, as well as its power domains have
> "required-opps" property set and the performance requirement from the
> CPU eventually configures all the domains (2 sub-domains and 1 master).
> 
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
> 
> Rajendra has already tested the previous version of this series and so I
> have included his Tested-by for all patches.

I also tested this on top of my v7 [1] of rpm power domain series and things
continue to work as expected for the cx/mx propagation so I am fine with my
Tested-by on all the patches.

[1] https://lkml.org/lkml/2018/12/12/174

> 
> V2->V3:
> - Include Ulf's patch (sent separately earlier) with this series.
> - The performance state update code doesn't rely anymore on the power
>    on/off state of the genpd, it sets and propagates rate in all cases.
> - That simplified a lot of code from V2 in _genpd_power_on().
> - commit logs improved for few commits.
> - s/mstate/master_state/
> - and few more minor changes.
> 
> v1->V2:
> - First patch (1/5) is new and an improvement to earlier stuff.
> - Move genpd_status_on() check to _genpd_reeval_performance_state() from
>    _genpd_set_performance_state().
> - Improve dev_pm_opp_xlate_performance_state() to handle 1:1 pstate
>    mapping between genpd and its master and also to fix a problem while
>    finding the dst_table.
> - Handle pstate=0 case properly.
> 
> --
> viresh
> 
> Ulf Hansson (1):
>    PM / Domains: Make genpd performance states orthogonal to the
>      idlestates
> 
> Viresh Kumar (5):
>    OPP: Improve _find_table_of_opp_np()
>    OPP: Add dev_pm_opp_xlate_performance_state() helper
>    PM / Domains: Save OPP table pointer in genpd
>    PM / Domains: Factorize dev_pm_genpd_set_performance_state()
>    PM / Domains: Propagate performance state updates
> 
>   drivers/base/power/domain.c | 207 ++++++++++++++++++++++++++----------
>   drivers/opp/core.c          |  59 ++++++++++
>   drivers/opp/of.c            |  14 ++-
>   include/linux/pm_domain.h   |   6 ++
>   include/linux/pm_opp.h      |   7 ++
>   5 files changed, 235 insertions(+), 58 deletions(-)
> 
