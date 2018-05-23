Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeEWJ7W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:59:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36155 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeEWJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:59:16 -0400
X-Google-Smtp-Source: AB8JxZp4JCNoFN6iSFDhy0qLvBzVspGkhUrv+5JwFpy08mDG2xoQGjJ4T3f37uiSEM+KgZ7FWVW60g==
Date: Wed, 23 May 2018 15:29:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ilia Lin <ilialin@codeaurora.org>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180523095913.o6gfwz4e4owthb5p@vireshk-i7>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
 <20180523094033.GW17671@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523094033.GW17671@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 10:40, Russell King - ARM Linux wrote:
> On Wed, May 23, 2018 at 12:05:24PM +0300, Ilia Lin wrote:
> > +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > +	if (IS_ERR(np))
> > +		return PTR_ERR(np);
> ...
> > +
> > +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > +	if (!IS_ERR(pdev))
> 
> Do you need to hold a reference to `np' here?

I am starting to feel bad for Ilia now. The problem is that there was
a lot of stuff wrong with the patch and even with so many reviewers it
wasn't easy to notice all the problems it had.

But you are right, this reference needs to be dropped.

-- 
viresh
