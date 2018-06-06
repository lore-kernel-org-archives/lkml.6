Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Do0jtmHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E2C260555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeFFMYE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:24:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeFFMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:24:02 -0400
Date: Wed, 6 Jun 2018 14:23:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:16:40AM +0200, Daniel Lezcano wrote:
> +	atomic_t idle_duration_ms;
> +	atomic_t run_duration_ms;

> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);

> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);

> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);

> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);

> +	if (!atomic_read(&ii_dev->idle_duration_ms))

> +	if (!atomic_read(&ii_dev->run_duration_ms))

What is the point of atomic_t here ?!
