Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeEYEFm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:05:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45402 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEYEFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:05:40 -0400
X-Google-Smtp-Source: AB8JxZpcp12Y0sPNclNwrvKNPakSeBt2dK5qu7Lmu/3VhDcvFYhQnyqTnIW1JmPhks087BkqaNLpHw==
Date: Fri, 25 May 2018 09:35:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180525040536.njrdqjn376oehw2b@vireshk-i7>
References: <1527174220-13244-1-git-send-email-ilialin@codeaurora.org>
 <1527174220-13244-2-git-send-email-ilialin@codeaurora.org>
 <20180525035412.3jjocp7ccmv5u2il@vireshk-i7>
 <DF878CBB-304A-4116-83D5-DF6BCEB7C131@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF878CBB-304A-4116-83D5-DF6BCEB7C131@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 07:00, Ilia Lin wrote:
> 
> 
> On May 25, 2018 6:54:12 AM GMT+03:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >On 24-05-18, 18:03, Ilia Lin wrote:
> >> +static int __init qcom_cpufreq_kryo_init(void)
> >> +{
> >> +	struct device_node *np;
> >> +	struct device *cpu_dev;
> >> +	int ret;
> >> +
> >> +	cpu_dev = get_cpu_device(0);
> >> +	if (NULL == cpu_dev)
> >> +		ret = -ENODEV;
> >> +
> >> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> >> +	if (IS_ERR(np))
> >> +		return PTR_ERR(np);
> >> +
> >> +	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> >> +	of_node_put(np);
> >> +	if (!ret)
> >> +		return -ENOENT;
> >> +
> >
> >I hate the fact that it is taking so long to get done with this. But
> >can't you
> >just check machine compatibility instead of this complicated setup to
> >check OPP
> >node ? Like:
> >
> >        if (!of_device_is_compatible("qcom,apq8096") &&
> >            !of_device_is_compatible("qcom,msm8996"))
> >                return;
> 
> I have to check the "operating-points-v2-kryo-cpu" anyway, so I moved it from probe to the init.

Okay, leave it as is then. Don't send anything yet and wait for Sudeep to
respond.

> >
> >And please see if you can add an entry in MAINTAINERS and add your
> >working email
> >id there.
> 
> Sure. Should this be part of the patch itself?

If you need to send another version of this series, then add it to this patch
itself. Else send it separately and don't resend this stuff.

-- 
viresh
