Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBAQkh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:40:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58976 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeBAQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:40:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 361F960FED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date: Thu, 1 Feb 2018 08:40:29 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] irqchip/gic-v3: Ignore disabled ITS nodes
Message-ID: <20180201164029.GA23162@codeaurora.org>
References: <20180129164933.25479-1-sboyd@codeaurora.org>
 <8e564636-aae3-4fee-a57c-6f1c01529b49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e564636-aae3-4fee-a57c-6f1c01529b49@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Marc Zyngier wrote:
> On 29/01/18 16:49, Stephen Boyd wrote:
> > @@ -1815,6 +1815,8 @@ static int __init its_of_probe(struct device_node *node)
> >  
> >  	for (np = of_find_matching_node(node, its_device_id); np;
> >  	     np = of_find_matching_node(np, its_device_id)) {
> > +		if (!of_device_is_available(np))
> > +			continue;
> >  		if (!of_property_read_bool(np, "msi-controller")) {
> >  			pr_warn("%s: no msi-controller property, ITS ignored\n",
> >  				np->full_name);
> > 
> 
> Can you also address the same thing in
> drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c?

Sure.

> 
> Do we need a cc to stable for this?
> 

We don't have any dts files with the disabled node in mainline,
so no?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
