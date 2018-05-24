Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeEXEhf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:37:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34741 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEXEhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:37:33 -0400
X-Google-Smtp-Source: AB8JxZo8aK2rAlv5AGXxd8DsMJMV+kGV/ltPw9qOdJxcBaTcRKtuz9TMS0lQvMDym9dBWF3Pu/47NA==
Date: Thu, 24 May 2018 10:07:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180524043729.3bzk5dazstoq6xfb@vireshk-i7>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
 <1527079139-3558-2-git-send-email-ilialin@codeaurora.org>
 <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 14:25, Sudeep Holla wrote:
> On 23/05/18 13:38, Ilia Lin wrote:
> > +static int __init qcom_cpufreq_kryo_init(void)
> > +{
> > +	/*
> > +	 * Since the driver depends on smem and nvmem drivers, which may
> > +	 * return EPROBE_DEFER, all the real activity is done in the probe,
> > +	 * which may be defered as well. The init here is only registering
> > +	 * a platform device.
> > +	 */
> > +	platform_device_register_simple("qcom-cpufreq-kryo", -1, NULL, 0);
> > +	return 0;
> > +}
> > +module_init(qcom_cpufreq_kryo_init);
> 
> Do you need this at all ? See below on how to eliminate the need for this.
> 
> > +
> > +static struct platform_driver qcom_cpufreq_kryo_driver = {
> > +	.probe = qcom_cpufreq_kryo_probe,
> > +	.driver = {
> > +		.name = "qcom-cpufreq-kryo",
> > +	},
> > +};
> > +builtin_platform_driver(qcom_cpufreq_kryo_driver);
> 
> Use builtin_platform_driver_probe and remove qcom_cpufreq_kryo_init
> or use module_platform_driver_probe if it can be module.

I agree with this, just use a single init routine to register both the driver
and device.

-- 
viresh
