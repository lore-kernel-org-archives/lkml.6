Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF20C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25EB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hfceEi5u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lCz1LX3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25EB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeK0Pr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:47:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0Pr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:47:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBB8560B11; Tue, 27 Nov 2018 04:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543294252;
        bh=EOPbRGlrHRM2TTTbDsVSyyKxo+kt2GXqrZuRFlQXxLg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hfceEi5uN6C4GWbKaYo01YneoFnKuynGvM0vc3MtHKN48A00XL+6DYEwcLxN3Zqcu
         lkrZq31BCTHgsSqySyaUKA/zf2c6oDA+6kWKT5znmiNA6IPx+QqQYmw4zWZuvjRyu3
         fSCIxRXIw1eMlxYWFL+Tm30JDe8nHBGDvjgITTmg=
Received: from [10.79.128.194] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44EE3607C6;
        Tue, 27 Nov 2018 04:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543294250;
        bh=EOPbRGlrHRM2TTTbDsVSyyKxo+kt2GXqrZuRFlQXxLg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lCz1LX3kHx+lp3hHg/RNCfI4Pwpntib8qVH7dmDfbbpt2X86MF7HwOaE7AK7uQnP0
         XkKd92vjZps+juRm2cFQCYjR+2v7epSqMHYWZbiVqaT69MEGN6mLfWgRdTPwsynbJq
         gGEnl2YFQFuFpBf5rccJ8adFN5VhLnVjyGc5F2O4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44EE3607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH V2 0/5] PM / Domains: Allow performance state propagation
To:     Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1543219386.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <65f1e1c8-8227-33f2-6938-8da5c7f0e250@codeaurora.org>
Date:   Tue, 27 Nov 2018 10:20:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 1:39 PM, Viresh Kumar wrote:
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

I validated this using the rpmh powerdomain driver [1] where I had to model
a relationship across cx and mx powerdomains, so that mx is always >= cx.
Seems to work as expected, I will respin the rpmh powerdomain patches soon
(Though its awaiting Rob's review/ack for the corner bindings)

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

[1] https://patchwork.ozlabs.org/cover/935289/

> 
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
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
> Viresh Kumar (5):
>    OPP: Improve _find_table_of_opp_np()
>    OPP: Add dev_pm_opp_xlate_performance_state() helper
>    PM / Domains: Save OPP table pointer in genpd
>    PM / Domains: Factorize dev_pm_genpd_set_performance_state()
>    PM / Domains: Propagate performance state updates
> 
>   drivers/base/power/domain.c | 211 +++++++++++++++++++++++++++---------
>   drivers/opp/core.c          |  59 ++++++++++
>   drivers/opp/of.c            |  14 ++-
>   include/linux/pm_domain.h   |   6 +
>   include/linux/pm_opp.h      |   7 ++
>   5 files changed, 244 insertions(+), 53 deletions(-)
> 
