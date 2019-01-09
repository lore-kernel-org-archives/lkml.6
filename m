Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682842063F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfAIK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:59:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfAIK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:59:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F358CA78;
        Wed,  9 Jan 2019 02:59:53 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D353F70D;
        Wed,  9 Jan 2019 02:59:52 -0800 (PST)
Date:   Wed, 9 Jan 2019 10:59:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109105945.GA18034@e107155-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109104236.6532-1-quentin.perret@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:36AM +0000, Quentin Perret wrote:
> The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> frequency changes to provide scale-invariant load-tracking signals to
> the scheduler. However, in the slow path, it does so while specifying
> the current and max frequencies in different units, hence resulting in a
> broken freq_scale factor.
> 
> Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> frequency table.
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> message protocol")

Good find.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
